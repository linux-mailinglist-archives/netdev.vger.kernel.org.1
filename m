Return-Path: <netdev+bounces-272711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Mc2N09Lx2nbVAUAu9opvQ
	(envelope-from <netdev+bounces-272711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB634D2A5
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3732A302B52D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F92347537;
	Sat, 28 Mar 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9ZsBU5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DD1C8634
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774668621; cv=none; b=idvtIJjAAeHdsM9fhWppwOFzJqlWqHIucszO8i7yHbIyOjQovyf71CEtuRt3fEHg6kJyeBZXb3Hvsl0LtcNmGIh0k5yngHNTZX9uBDJjwRThHeZJ03bMLU+Ihl43p7nVGd+y+Ot/+n8Bsw9C9lHjE7+8RrU2Hw+u9+RuY3x1+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774668621; c=relaxed/simple;
	bh=VfnA3FhrwmRJpisDICHTA0woI6WjcszShzggdjLyWt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POmwnPO0dHnyUMCcq04gfIxAZxsb3f8d8x1VNJs3GDe+JE20IKtcjwNETDbInB5z4vckDwHJd7M8I5hgWZGlKHpQJRoD2KZbTsG1U635C7eUzLnP+kRmlIVWhLYM3OhbV0i3CrqCujFAN4a+PVVwd+8CiV5XfVdbgZF0L4SDBic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9ZsBU5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8F9C19424;
	Sat, 28 Mar 2026 03:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774668621;
	bh=VfnA3FhrwmRJpisDICHTA0woI6WjcszShzggdjLyWt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9ZsBU5VWGqjXxJQz8dEDExfO+QCCYnUupvfiBZjo5jshXcwrfU8odoSV5creVtMH
	 dqz5/smCiuzv5eSfhfDE5nh4iI6aPGfMm0cOpUGNN6ODusHysjh7lv47w6npHYi+9V
	 sqPoCkmUimdVBbhy83oBNXAfOWb6eOkmbsd1TRMYwS3Ot2my5nNi2aPC4WOAMGIbs9
	 6P/+IiUTJW49e9I/Yw/RVwJvz/O1adPKi+gNV14FMCY4ColQW2TBMkULBbkt4bQR3h
	 zjW3oo9Wf+HPwL0gcauZDxsQiZeXOSWnuqqyyVoOV6VaaeIe3PDuST/gQETPhfzBFF
	 k1f6Je/KE/e6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5B3930181;
	Sat, 28 Mar 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466860654.4167434.2412551855911601858.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:30:06 +0000
References: <20260326155138.2429480-1-edumazet@google.com>
In-Reply-To: <20260326155138.2429480-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 oskar.kjos@hotmail.com, idosch@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,hotmail.com,nvidia.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-272711-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FDB634D2A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 15:51:38 +0000 you wrote:
> Oskar Kjos reported the following problem.
> 
> ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
> by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
> IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
> as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
> at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
> value. __ip_options_echo() then reads optlen from attacker-controlled
> packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
> a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).
> 
> [...]

Here is the summary with links:
  - [v2,net] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
    https://git.kernel.org/netdev/net/c/2edfa31769a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



