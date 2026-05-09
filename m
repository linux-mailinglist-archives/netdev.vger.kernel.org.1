Return-Path: <netdev+bounces-286224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id llfIDGTB/2kn+QAAu9opvQ
	(envelope-from <netdev+bounces-286224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:21:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF4501FA8
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1BAA3002D30
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047003932E8;
	Sat,  9 May 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERnWJXff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09CA2EC57C;
	Sat,  9 May 2026 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778368859; cv=none; b=XyoiVrKR08kVB70r8tZNiHUO1E/whPW9jsFh0oDzf0601PS9OfoPXzocdYlY2wvv0aQNKcT0pz/GwmBPXHEzm98pduYrHekmXlppxv3WnodFwTtiG2MqOB6fV6BT/vRGFEALPw5DpG+R7qB2G7H2oZqfP5P8d3G5orfLStxK2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778368859; c=relaxed/simple;
	bh=nfKeovBbfRTcfLaExtvN2cMkkog5MgHyOOaIBcOtZBU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LZjWQnyjiFrfEBk4X3c+A0SaKYEpxM3im3hpfIZYyHFTGaKpYrsVelNAjRmbPAjNkXtIvSXfrhrveXreKs4ad0PXOF4XXBhey8eVZFjm1D5aeT/pWjA51RIf8rBuWWU4Y3g0678xXGUdoTglHGaUyiea9wKY+URJoJQMF0/yRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERnWJXff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DCCC2BCB2;
	Sat,  9 May 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778368859;
	bh=nfKeovBbfRTcfLaExtvN2cMkkog5MgHyOOaIBcOtZBU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERnWJXffJ+hR1rQ/YTcvgtf9fPK+1FGpzyIeiYxtWYJnwshXj+rw293/yaSwhiBSS
	 +pri6W7e5qrw4V7SSA+dUHeubGBIi2e2aZZbfloI94w2I316yCKxICoAIJlicbjPd8
	 RojO1fuBO/zUXQxhmm1wsHLZGFlqhzw9ka5kVpLr7VAwkmN04urmz95sUiQlno4nZt
	 1qZKZHHX78DpvL05xbl1xPxuJDaOAcnLaCgkq5Jfp6xqaGDJwJnMzeIm3LQzNuNJ1b
	 w/A17+TMc2R8Ybd3g6mb69RdzvFn5uOeZdHWGQW/lpPa6YaOw72V8mfO3hdvRRV2t/
	 C7k1mcUDVhxRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF663811A7B;
	Sat,  9 May 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177836880730.1203938.10346076460528713605.git-patchwork-notify@kernel.org>
Date: Sat, 09 May 2026 23:20:07 +0000
References: <20260508144344.694-1-linpu5433@gmail.com>
In-Reply-To: <20260508144344.694-1-linpu5433@gmail.com>
To: Linpu Yu <linpu5433@gmail.com>
Cc: kerneljasonxing@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 linux-kernel@vger.kernel.org, tanyuan98@outlook.com, yifanwucs@gmail.com
X-Rspamd-Queue-Id: 14CF4501FA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286224-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org,fomichev.me,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,outlook.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 May 2026 22:43:43 +0800 you wrote:
> XSKMAP entries are used as redirect targets for incoming XDP frames.
> A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
> traffic, but xsk_map_update_elem() currently allows such sockets to
> be inserted into the map.
> 
> Redirecting packets to such a socket on the veth generic-XDP path
> causes a kernel crash in xsk_generic_rcv().
> 
> [...]

Here is the summary with links:
  - [bpf,v4] xskmap: reject TX-only AF_XDP sockets
    https://git.kernel.org/bpf/bpf/c/bf6d507f7e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



