Return-Path: <netdev+bounces-251467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKKoFC5fcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:07:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 005EE51567
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76D67643354
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED893EF0C9;
	Tue, 20 Jan 2026 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTudAju2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507636C58F;
	Tue, 20 Jan 2026 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909828; cv=none; b=VPfV+jkUwPrmILvCKCAb2an/OVHkXylLMq/jURpifeZCFCP4HgCfe79sscJYwxfgX2QfdjwWBYXCA1EeAHQsfdz6ERunbbcGoBSiex/xU3UkUZ+BnVltZENXz4Q+kvYFhbdlOAKJjirBvc8gU6OZcRelRwy56LN13f2HssWeA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909828; c=relaxed/simple;
	bh=uICr/bxdlfjRWKIQHOuu8bOjJbNsoFQIwXIixEaGIoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rFpDAx+QOGkgzmgD0T6FF61tUerpf+1t3DtPKiW9x2XT/xgh6JwBRxUUfh6x5FSVXzhxdXJpNZkGZL03w1Zew9RMSsaKVZktL6+MrdCU0CL9GcozYy8sas4mSwxnFc/xllvpEm5cf8COUEG4zPPJFva4lr3XXJZEpR3VnLp+CcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTudAju2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4C1C16AAE;
	Tue, 20 Jan 2026 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768909828;
	bh=uICr/bxdlfjRWKIQHOuu8bOjJbNsoFQIwXIixEaGIoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fTudAju2sTMHc86jX3C+3A+ukVQK4vde1ON/2pzw1zNZldYRjlCMgF8revhuYYFGh
	 umBBwbyqVzihZ+41o0n9sMsuem+ugaUkbCUV8vj0bu8GdpOVAh/ZFPZsb2kdWdVm8f
	 YJLwTEXly6AZ/QLWYRz3VWR813NOXiXkJoayMb5x6oh8hb/84Exxl2YZ1m+zvZQM3I
	 lsWd+iQU1l9EtQtfV2tGzMMxu9g0PdZ3YcIhdbfSXpeOgSeA3E9446mV+aJ/PosaN4
	 g7R8noWQn/Vy6ZXaPDwhphx5tWCiW218HRFeTW5Vnk5gyAN6SWKDcEwjSVkE24xkMU
	 DFNMztWVwBBkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8D8D38068DF;
	Tue, 20 Jan 2026 11:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 00/16] netkit: Support for io_uring zero-copy
 and
 AF_XDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176890982554.757566.17882816780312694183.git-patchwork-notify@kernel.org>
Date: Tue, 20 Jan 2026 11:50:25 +0000
References: <20260115082603.219152-1-daniel@iogearbox.net>
In-Reply-To: <20260115082603.219152-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, dw@davidwei.uk, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251467-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 005EE51567
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Jan 2026 09:25:47 +0100 you wrote:
> Containers use virtual netdevs to route traffic from a physical netdev
> in the host namespace. They do not have access to the physical netdev
> in the host and thus can't use memory providers or AF_XDP that require
> reconfiguring/restarting queues in the physical netdev.
> 
> This patchset adds the concept of queue leasing to virtual netdevs that
> allow containers to use memory providers and AF_XDP at native speed.
> Leased queues are bound to a real queue in a physical netdev and act
> as a proxy.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/16] net: Add queue-create operation
    https://git.kernel.org/netdev/net-next/c/a5546e18f77c
  - [net-next,v7,02/16] net: Implement netdev_nl_queue_create_doit
    https://git.kernel.org/netdev/net-next/c/31127deddef4
  - [net-next,v7,03/16] net: Add lease info to queue-get response
    https://git.kernel.org/netdev/net-next/c/9e2103f36110
  - [net-next,v7,04/16] net, ethtool: Disallow leased real rxqs to be resized
    https://git.kernel.org/netdev/net-next/c/ff8889ff9107
  - [net-next,v7,05/16] net: Proxy net_mp_{open,close}_rxq for leased queues
    https://git.kernel.org/netdev/net-next/c/0caa9a8ddec3
  - [net-next,v7,06/16] net: Proxy netdev_queue_get_dma_dev for leased queues
    https://git.kernel.org/netdev/net-next/c/804bf334d08a
  - [net-next,v7,07/16] xsk: Extend xsk_rcv_check validation
    https://git.kernel.org/netdev/net-next/c/1ecea95dd3b5
  - [net-next,v7,08/16] xsk: Proxy pool management for leased queues
    https://git.kernel.org/netdev/net-next/c/0073d2fd679d
  - [net-next,v7,09/16] netkit: Add single device mode for netkit
    https://git.kernel.org/netdev/net-next/c/b5c3fa4a0b16
  - [net-next,v7,10/16] netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
    https://git.kernel.org/netdev/net-next/c/b5ef109d22d4
  - [net-next,v7,11/16] netkit: Add netkit notifier to check for unregistering devices
    https://git.kernel.org/netdev/net-next/c/eef51113f8af
  - [net-next,v7,12/16] netkit: Add xsk support for af_xdp applications
    https://git.kernel.org/netdev/net-next/c/920da3634194
  - [net-next,v7,13/16] selftests/net: Add bpf skb forwarding program
    https://git.kernel.org/netdev/net-next/c/61d99ce3dfc2
  - [net-next,v7,14/16] selftests/net: Add env for container based tests
    https://git.kernel.org/netdev/net-next/c/6be87fbb2776
  - [net-next,v7,15/16] selftests/net: Make NetDrvContEnv support queue leasing
    https://git.kernel.org/netdev/net-next/c/ab771c938d9a
  - [net-next,v7,16/16] selftests/net: Add netkit container tests
    https://git.kernel.org/netdev/net-next/c/931420a2fc36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



