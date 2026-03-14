Return-Path: <netdev+bounces-267753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVTHHSBtWne1AAAu9opvQ
	(envelope-from <netdev+bounces-267753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:40:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7D28DBAD
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 426EA300C6F6
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93B2FD660;
	Sat, 14 Mar 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj3JbUmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE6299A87;
	Sat, 14 Mar 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773502822; cv=none; b=vFdEN2ZT0eqfpEuLjDXeZ8bakMvn5sfq5Yk9bn/0LFMU6kDz0n5hIRCvOWaociLgCLXMgmRLNw5JGAYgctWsDERfPb1DUeZ9dgZSePow+kLeJwXPsYLNPQ9+Y2fQQVtSbygtmkNdwAvYT96DlvrVSRed+bjY8Qn7x2v8E7Oh4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773502822; c=relaxed/simple;
	bh=WoPbqZeSHQS7/U+Zg1lu7MCzHBCJT+hDh8F/zCHEdfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCLhRnRaU07o/JSnEn23V9EnqMUCtIdj7OdRJWgNhNJVBTYsAnLRg/UUhA1Hu4WHm9vG0ylSR/r0Sc1QgndnSO8G2oE/M5a2Y38RHbR0Cj+2zc9jmdzIQloKCe6SVh0ZcD7puqVnAzC488JMEBNZ7xVANAZ9C99v1yN6iFiAS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj3JbUmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC7DC116C6;
	Sat, 14 Mar 2026 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773502821;
	bh=WoPbqZeSHQS7/U+Zg1lu7MCzHBCJT+hDh8F/zCHEdfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xj3JbUmKkanbsDjkE/3Byh+gqQTGmHKnhZaI6Z1U35pQMoOszufYV3Qrne9mZSRBN
	 ++Gj8dVw3EOi87nLPIm52u0T2zvchjYdpxIAMRORdR+qE/KLLSFRJLVmtzZbj+0kq1
	 +/+VkLA8chEuMNvDXUhPvjEOr6/LkTcKRJBrb9340y++jggBFvIRT3/o3r36UyJFOo
	 f4vzO/58MHMxP9qIEU0/JyUuuklqJmo4c7v8AYSfknR9+RYRYvIwiNCjgCeY7SyfPd
	 Za+G/i3r0KlmG7RJ0ahd5l9TgclIFP6ghLhgcoKAh6wtVXf88i9VEnd0ijP52uiqCn
	 0kSWvazn0MIpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402493808200;
	Sat, 14 Mar 2026 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] tcp: RFC 7323-compliant window retraction
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177350281603.1717807.13218820187988201902.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 15:40:16 +0000
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
In-Reply-To: 
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, dsahern@kernel.org,
 jmaloy@redhat.com, kerneljasonxing@gmail.com, mfreemon@cloudflare.com,
 shuah@kernel.org, sbrivio@redhat.com, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-267753-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CC7D28DBAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Mar 2026 09:02:25 +0100 you wrote:
> Hi,
> 
> this series implements the receiver-side requirements for TCP window
> retraction as specified in RFC 7323 and adds packetdrill tests to
> cover the new behavior.
> 
> Please see the first patch for background and implementation
> details. Since MPTCP adjusts the TCP receive window on subflows, the
> relevant MPTCP code paths are updated accordingly.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] tcp: implement RFC 7323 window retraction receiver requirements
    https://git.kernel.org/netdev/net-next/c/0e24d17bd966
  - [net-next,v3,2/6] mptcp: keep rcv_mwnd_seq in sync with subflow rcv_wnd
    https://git.kernel.org/netdev/net-next/c/81714374a29c
  - [net-next,v3,3/6] tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
    https://git.kernel.org/netdev/net-next/c/e2b9c52a2b00
  - [net-next,v3,4/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_nomem.pkt
    https://git.kernel.org/netdev/net-next/c/ec1adf8ecf95
  - [net-next,v3,5/6] selftests/net: packetdrill: add tcp_rcv_wnd_shrink_allowed.pkt
    https://git.kernel.org/netdev/net-next/c/ba58b3e70b86
  - [net-next,v3,6/6] selftests/net: packetdrill: add tcp_rcv_neg_window.pkt
    https://git.kernel.org/netdev/net-next/c/3eb371eddad0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



