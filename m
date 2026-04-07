Return-Path: <netdev+bounces-275929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH7fGJbT1Gl/xwcAu9opvQ
	(envelope-from <netdev+bounces-275929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:51:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B174A3AC552
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD51A300F52F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585B3A7592;
	Tue,  7 Apr 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pTvv3/u0"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DD217C211;
	Tue,  7 Apr 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555462; cv=none; b=MnOoeSppX1CmzaiCXs7Y7PADUKYAPZT7JCHfkqrvhmZ+rdzZEophGqiG2AqWYHUKBWnVilvtEIcYCa/JqsFNT30iN56f8j9XwtU4Hvl6Dj5poqi4qyu54CN/7xkMsUeLaJyVo8tNPohS7F67vIha3vPog1rvPPvrXjQ5kjZ6bUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555462; c=relaxed/simple;
	bh=n6aqPPp7D064x6KiO05o7DWyiQYk4CFYC5RxUthxGaU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tOqc2Tr9iT1C/dy5uk0cjgo3qGn4Ydr7jKgUtW62YTzuHozb/QzLL+xe0JiD/CaRHJN+H3HwFQOKDZKuZN3ixpvkFiYpVISsDmn7LBHKglrKBnZjdaJvxMjY1PAOGj6ND0hsgXTMiQpkPjfEIJujQQMDctM62T7Wat67Eg8+QpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=pTvv3/u0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Jvmhek9eBYywwT5eEvjckk1dp75+bwe5nYioDBqeGbQ=; b=pTvv3/u0sT3OmnqtitZI7HTr/9
	X7GwEDGj/0jsjcKAxlFIkIuiaOWTuLA3w7RUjYeD3Mic+5tdJHWzSlXaEL9FAkyTW88saBFL/UE8O
	BsZB+fJKC49S6/y4jflL0r4MQi4Cncsuh8PqpuRNqemITjZzvtlgM6YJimOZ6DIS/tLoXIbBnzajw
	4iFfTiUlqoVnapzAsNGWmzqJIKTCTpQVFSASfZfyUnRtPiYaTLf78vUX7ldA/4QH6BdiSEpxl2CQw
	RrZk/vBc4TuzUeSbj1JwcJDsR0M8mzPt40aGKFtBcq1LsDRf3TDO5h7qKbTO/6cAW8D1FwevH7CVB
	kYbLoI/A==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wA34k-0009d2-1a;
	Tue, 07 Apr 2026 11:50:26 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wA34C-000F6t-0g;
	Tue, 07 Apr 2026 11:50:25 +0200
Message-ID: <cada22a0-b3a8-4ff4-b163-fd8248fffaf3@iogearbox.net>
Date: Tue, 7 Apr 2026 11:50:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 00/14] netkit: Support for io_uring zero-copy
 and AF_XDP
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260402231031.447597-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27964/Tue Apr  7 08:24:40 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275929-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: B174A3AC552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 4/3/26 1:10 AM, Daniel Borkmann wrote:
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
> Memory providers and AF_XDP operations take an ifindex and queue id,
> so containers would pass in an ifindex for a virtual netdev and a queue
> id of a leased queue, which then gets proxied to the underlying real
> queue.
> 
> We have implemented support for this concept in netkit and tested the
> latter against Nvidia ConnectX-6 (mlx5) as well as Broadcom BCM957504
> (bnxt_en) 100G NICs. For more details see the individual patches.
> 
> v10->v11:
>   - Fix missing mp_ops->uninstall upon unlease path (Gemini)
>   - Fix dma device retrieval on tx queue when rx queue is leased (Gemini)
>   - Rework ethtool channel checks to check rx/tx individually (Gemini)
>   - The remainder of the Gemini findings were non-issues
>   - Add more extensive net selftests around queue leasing corner cases
>   - Rebase and retested everything with mlx5 + bnxt_en
I've look into the latest v11 findings from Gemini in the meantime, and
thought I'd share an update/comments related to them:

   https://sashiko.dev/#/patchset/20260402231031.447597-1-daniel%40iogearbox.net

 From all the claims related to the series, the one in the netkit device dump
looks reasonable to improve, iow, to not dump IFLA_NETKIT_SCRUB if in single
mode since we also reject the presence of the attribute during device creation,
change would look like:

      -  if (nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
      -      return -EMSGSIZE;
      +  if (nk->pair != NETKIT_DEVICE_SINGLE &&
      +      nla_put_u32(skb, IFLA_NETKIT_SCRUB, nk->scrub))
      +      return -EMSGSIZE;

Anyway, wrt the individual patch comments from Gemini:

Patch 2:
   - The capable(CAP_NET_ADMIN) is intentional
Patch 6:
   - Solved in your patch which is a good thing to do
     https://patchwork.kernel.org/project/netdevbpf/patch/20260404001938.2425670-1-kuba@kernel.org/
   -> Iiuc, its unreachable today due to other guards, but an explicit check
      would definitely cement that
   - The second double free or use-after-free on unregistered devices claim is
     not true, there is an inconsistency in the io_uring vs devmem wrt clearing
     mp_ops to NULL but the code handles both cases correctly
Patch 7:
   - Independent of the series; oob queue index in io_uring/zcrx claims that
     there is no bounds-check against real_num_rx_queues before being passed
     to netdev_queue_get_dma_dev and from there into ndo_queue_get_dma_dev
     callback
   -> mlx5e_queue_get_dma_dev as the only implementation does bounds check
      internally, it might make sense to have a guard in the core code if
      more drivers implement the ndo_queue_get_dma_dev
   - Order-dependent DMA dev validation in netdev_nl_get_dma_dev claim cannot
     override memory provider state, mixed cases get rejected
Patch 9:
   - Intentional, netkit proxies all xsk operations to the phys device
Patch 10:
   - Above diff to not dump IFLA_NETKIT_SCRUB makes sense to me
   - The changelink operations claim further below is intentional and for now
     rejected with -EOPNOTSUPP given nothing new can be configured here
Patch 11:
   - netkit notifier takes care of this and is part of this series

Some cases in patch 6 and 7 that don't require a specific driver are worth additional
tracking in the netkit leasing selftests to asset behavior though. Happy to fold that
+ the IFLA_NETKIT_SCRUB diff above into a v12 or as a follow-up, let me know.

Thanks a lot,
Daniel

