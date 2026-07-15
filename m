Return-Path: <netdev+bounces-307714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6LFKL0hOV2rcIwEAu9opvQ
	(envelope-from <netdev+bounces-307714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:09:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC9175C40E
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:09:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NARP+YA3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307714-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F21C3063CE8
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5123DA7FF;
	Wed, 15 Jul 2026 09:00:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFD3D9DAD;
	Wed, 15 Jul 2026 09:00:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106041; cv=none; b=Y8jCVgE3yH7beGJoSDilWFINDZLmMan06bYaElkcs+H/M6vZwAvJMQ7niuRCsxhTWYK2N6yTlEKQzIncf5XgzKcQ00Vu6sCxQp9zFsed4hl2D1g2mqeFK00MQjRizBhslq9Utsw2FXzznCLt/iSox6oh0CMBX4e1+3t/xIkbRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106041; c=relaxed/simple;
	bh=sW0uEZWe6tUXPmm+L0Sefg6jfHV3ohevQmOKxg/g3pQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rf4jHIhBgbzt0OBV1QC2+b+afGLeCSGiSLsZIQceccBPePjPrgQVg8U5mj0LA+2C7Iv0Kav0pvIGtoVkRaif4JQHIFj1QmNfIMTtjvN3DSYRrG/z5F+tyUDGhUhKtEdK3BYpoCLcahqh74tlDqplzNFzaQeWl2RbGlHIYnYSDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NARP+YA3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA811F000E9;
	Wed, 15 Jul 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106037;
	bh=45M0Fa9/SGxHpp4jJkt4N9B4NIY8KR/dSaCinU2gelM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NARP+YA3cII42w9ZUhrq0nI09MhX9y1RyKKrzBOJB3U6wE6lMgSZgsPHmYlr2LgCy
	 8WY83VVBji2Mc8sxcPwUkN0Gdjs00qyb2QNgPxRMy9cClvSa4HXX7R6m17YvHzrnKD
	 rlUI61OwWBXCdqV8MbNVOaObq/B4jOPSTSxGD4gxk/idSbYWR3XHZ7c7mkqVi+lGl3
	 vzPUAPHtJCsXJVUWVuA8859Jw5kSZ7d6/ffNj9HwF/iBlIbUK7TDmx7Bz6bEM9y7uM
	 0Gifr4z2aMRnVJfLWfQTB2cPDUmO5v1O+mkN/WyQbYn0pFKrrGa1gVIBUWL6Rbn++G
	 nYY/RHtJguJiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D2A143938E87;
	Wed, 15 Jul 2026 09:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/3] bpf: bidirectional VLAN support for
 bpf_fib_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410601163.3969811.1253596819047175894.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:00:11 +0000
References: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, yatsenko@meta.com, leon.hwang@linux.dev,
 kpsingh@kernel.org, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 rongtao@cestc.cn, eyal.birger@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, toke@redhat.com, dsahern@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307714-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FC9175C40E

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 13 Jul 2026 21:53:02 +0530 you wrote:
> This series adds VLAN awareness to bpf_fib_lookup() in both directions.
> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
> plus the VLAN tag (XDP programs need this because VLAN devices have no
> XDP xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged
> frame had arrived on the matching VLAN subinterface, for iif policy
> routing and VRF table selection.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
    https://git.kernel.org/bpf/bpf-next/c/35dac1daeb3c
  - [bpf-next,v7,2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
    https://git.kernel.org/bpf/bpf-next/c/217828aad80d
  - [bpf-next,v7,3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
    https://git.kernel.org/bpf/bpf-next/c/e54a87872e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



