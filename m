Return-Path: <netdev+bounces-270140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BblrCgX3vWm+EQMAu9opvQ
	(envelope-from <netdev+bounces-270140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6472E2CCC
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F2C830338AB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4606F3101AD;
	Sat, 21 Mar 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs6Dzs2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213353C07A;
	Sat, 21 Mar 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057216; cv=none; b=A4Ecl+e8xlSqCY6u3lwbWRCHH8qKdJMOAsSBsPwATwH2ufsiz3rW3B/PX+y/e8qQWALKTilBDqPa79cFBjyiwMBdOAJPSeyFOaaPvpSFczR4BUYqwXHjGEyCAlE3uh9HASq/MfP8BlmsIHuznffVgsyVm3921UTZw6ckeOgIe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057216; c=relaxed/simple;
	bh=ewLoup8QV1e6EtVHrX6BPU6g4YtluWG056Fcho1RAJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R7lW1UvNAmVpysvRp/5dypmuzSHwn41NKfcRCYe8F2GnleGkFnDKs/qkl6o1GDJUa+afUTjVVv3Ia8EDrgqZrz/xRw62eU8C4avn/vK3K5qaXORMtBsDuDpJMPNum0nNQh9HcN3RPGP/9chhQXrYjASOnIn46lTKzqwktj0vzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs6Dzs2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75C3C4CEF7;
	Sat, 21 Mar 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057215;
	bh=ewLoup8QV1e6EtVHrX6BPU6g4YtluWG056Fcho1RAJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rs6Dzs2tEd+bXSOztpR0/QiMlWVOWhToCAz2FqL02xO7Lt/a+KQvMEDsn36tBiUcS
	 0WrLleyyK9ud8yyzUFgbtItqiODdE5HALYWGy2TjIy/C6TKFDMp9ySs03LMTx2BnVY
	 4wSGV0+ChgC0XrN0SYFPPcMUGvhI0xKK7Xok09qqyZ7S6lWOj+VyBKqo4eUGaUDA1Z
	 3D8cGlCZh2fZ+VWVM1AN2ThpBQn3g/c0/KMo4gsYR1NPKO4kztseV3BcgH1I+kBeS3
	 6m8O2kN+Q98ZK+zJ8Ku0xBkNL5UUkbw8RiOGjDylkhHRDYAgdj/Leu8sh/uwuMo1kN
	 6EcROuIQ8nGdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC63808200;
	Sat, 21 Mar 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: validate MPLS set/set_masked payload
 length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405720582.2718727.10927931850502604118.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:05 +0000
References: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260319080228.3423307-1-n05ec@lzu.edu.cn>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pshelar@ovn.org, martin.varghese@nokia.com,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, tanyuan98@outlook.com,
 bird@lzu.edu.cn
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,nokia.com,vger.kernel.org,openvswitch.org,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-270140-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C6472E2CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 08:02:27 +0000 you wrote:
> validate_set() accepted OVS_KEY_ATTR_MPLS as variable-sized payload for
> SET/SET_MASKED actions. In action handling, OVS expects fixed-size
> MPLS key data (struct ovs_key_mpls).
> 
> Use the already normalized key_len (masked case included) and reject
> non-matching MPLS action key sizes.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: validate MPLS set/set_masked payload length
    https://git.kernel.org/netdev/net/c/546b68ac8935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



