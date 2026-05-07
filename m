Return-Path: <netdev+bounces-285108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIvnMVvy+2mMJAAAu9opvQ
	(envelope-from <netdev+bounces-285108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E04E2249
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7B53006B58
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA011A6822;
	Thu,  7 May 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCcFrOuY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5017E105
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778119256; cv=none; b=CA0fVTZBM2mbV0ijEQnwcdK44ZG73xWAh80sTB4XmARkT1O5FuVn9v/ctRDd5BYJa79Y2QRCeGroNEMC22CFtwSHtez5x+dMYLcM1zxWy1g3RqmDpY2zKt0MOPPO0loImjmR1Zn1Qrpc6kt1QrYz+AM58LuGzi8nkxWnU+yx1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778119256; c=relaxed/simple;
	bh=8xY+/ouMf/rwCHBpBkrkf7rC/HasfkEzVqXipjLVTd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tLVRS1XA98fliUXXrNZS92OIfOwBMW9UD6fAit+ywTwxordC1WFhznasKiZQhx0wStoLrHuhKjO8wjIU4jrtP3xiSDi+Crp5z90PZHbCivHbD8EaCrN40+dxf3OZ7nXWix2KTrNN32is28AFSBH+bpPWJlnfa8aI6jXtdJkZZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCcFrOuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72800C2BCB0;
	Thu,  7 May 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778119256;
	bh=8xY+/ouMf/rwCHBpBkrkf7rC/HasfkEzVqXipjLVTd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCcFrOuY+26MvEsippykPsPqtFI2em0TqiRpu9TNlq10AdPgivzYygW2/QiG82cj/
	 +De/XTI/WkMaU+nfZmzilnNKuTzaeaQl4KvP+SYyXoPtd5GC64XewRJzF+eCA/R9Mu
	 bjPeHSkSH0D8FLrI+ONiKfTa3XaMBgjDlusfJGnM/T9dFZ2POAJ4WiGuFVsEHvClE2
	 bbRyIMvNF5j5Ktag5++/LYC0iVRBheDc0TA0kvs+tb4IOb/Q/2LOV8SaOm7J++n2OV
	 08ilE6tcgkUZ+AvbuihfR0DGoSgaheQ2ogkCcw/9Wz3u2pK26YRL1sq7Q7uTquWGtR
	 ztl0fWBaPT6IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD99393089F;
	Thu,  7 May 2026 02:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: cortina: Drop half-assembled SKB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811920590.3299821.5501648211282109462.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 02:00:05 +0000
References: <20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org>
In-Reply-To: <20260505-gemini-ethernet-fix-v2-1-997c31d06079@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, lixiasong1@huawei.com, netdev@vger.kernel.org,
 eitschman@nebelreich.de
X-Rspamd-Queue-Id: 300E04E2249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl,huawei.com,vger.kernel.org,nebelreich.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-285108-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 May 2026 23:52:17 +0200 you wrote:
> From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
> 
> In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
> gmac_get_queue_page() returns NULL for the second page of a multi-page
> fragment, the driver logs an error and continues — but does not free the
> partially assembled skb that was being assembled via napi_build_skb() /
> napi_get_frags().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: cortina: Drop half-assembled SKB
    https://git.kernel.org/netdev/net/c/b266bacba796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



