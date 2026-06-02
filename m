Return-Path: <netdev+bounces-294375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VpN0BOssH2qjiQAAu9opvQ
	(envelope-from <netdev+bounces-294375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:20:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 721746315B3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:20:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WVT3p86R;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294375-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 816BB302DFBB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F093CC330;
	Tue,  2 Jun 2026 19:20:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894EC3A7F73;
	Tue,  2 Jun 2026 19:20:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428006; cv=none; b=OKy3plY418/bc1MXfYVF0X5yKIi74fkmtp/mego2VYJGo8RJSVVelVgOig2qMDIajxCHkusLTq71l8FEviwMRKHKeBOXD8G4WO0JTpovo61L+Z6o2TX9NiO6U121RToLV4pksrH33cSGm119iKRo2o7l7g76DZawMhYMtCKWXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428006; c=relaxed/simple;
	bh=iY5lxsufbIs6GBTopTls6bbsXH/MIbKi7m5qIfPLAIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V/EOLUE6fOwmESDHgjNpjotBPpxPL2cwJ5cjwzOE9GRhIiX/paVdwaYF2hY6O/MS+sWNC/NAM4qPfJr5CV7xHreRIK9vmjGCKIC7LHcSGwclHYsNsh3a1+ubJakJ5BWaRzDY2nGJ0aIP7GvAFiXKVJo9AJ5N6ZeD6QITzKUMQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVT3p86R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402611F00893;
	Tue,  2 Jun 2026 19:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780428005;
	bh=1Ly8Kx3ZJ29PYIkpBHUVyCnqBzuLK3fkAbcgfIqfT+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WVT3p86R55nggMaNgeXEphhspHN1gFEL1GIAaBzrlHdF4jwRTjUliy546fvWs7Bx1
	 QZMgc6ciI/Fbnk/RB3oHtS42/gurZU5qAl3AvveNKtjR5kiehPglidLlxnzzvnkjNH
	 aYe1DqOySU9eRLdFpUoX7SXGSwzas6pNR/r9XTX6fc47RtJez/kwOsM9HWCqzjfSGj
	 bdLzdq5mcqnValm7a4gzSbAuHFNpiDpknRVj4ZP17A2pGU+DAPvR1yaeV3ukL/i+Kj
	 qP5kxtetkzo0JXN9FNOreeNLsl5v3+CKyn++o4wxKdZN/h00Z7AlFbvrRIXx30iQ0N
	 DwhX+LU08jjMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BB3811A6C;
	Tue,  2 Jun 2026 19:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: garp: fix unsigned integer underflow in
 garp_pdu_parse_attr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042800690.1014313.17359151426074181113.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:20:06 +0000
References: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260527083200.42861-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	TAGGED_FROM(0.00)[bounces-294375-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 721746315B3

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 16:31:58 +0800 you wrote:
> The receive-side GARP attribute parser computes dlen with reversed
> operands:
> 
>         dlen = sizeof(*ga) - ga->len;
> 
> ga->len is the on-wire attribute length and includes the GARP attribute
> header. For normal attributes with data, ga->len is larger than
> sizeof(*ga), so the subtraction underflows in unsigned arithmetic.
> 
> [...]

Here is the summary with links:
  - [net] net: garp: fix unsigned integer underflow in garp_pdu_parse_attr
    https://git.kernel.org/netdev/net/c/16e408e607a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



