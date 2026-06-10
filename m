Return-Path: <netdev+bounces-297672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eoHxNdtgKWr2VwMAu9opvQ
	(envelope-from <netdev+bounces-297672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:04:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DFF6698FA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:04:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=WUy0xljL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297672-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297672-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93A9B30B7F99
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645D218EBA;
	Wed, 10 Jun 2026 13:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24993E16AB
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:00:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096420; cv=none; b=I6PaBf9cljZEIDEgpETle+H9U5u5E72OMNfr18UJeneO7lA9XYFwB61qH21IAEXqOhK4ieSTqPPST1+8droXaPFYzAi1LqAHu2u3dCC4bZLDDsWo9KjNpU+vJjkOSfPlaeu0YUH1STrTXa6aGzI71ZbHjqEiJG+H8g0vFNJsCF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096420; c=relaxed/simple;
	bh=A9EvpKcqN53vmQLvEM3hL0lEKlk78UrMK3C3bXsNnZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PScbhevz20lB1bWkS3KQOQytjrli4wIh1T1gAqLCwNO8SP7kGTMzv+8nnniOoKpr8GEAQroOFqPIRK8DV70qJ0Agkpy5QeJhw2nrhVjAMK1PDukTVIjgCZttk0+5h45B5/IbGgcq3I+uvLjJeD0zEG/0KLuNUGpzVZj64ykaiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WUy0xljL; arc=none smtp.client-ip=95.215.58.183
Message-ID: <08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781096407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SGtVNbcwG9pfhAaZcDYoFasUWq/H1TadDKPDknF8II=;
	b=WUy0xljLQiJAIo67fX3LQRJbG2sHV+A9+3ozf9jf9XImgyJA9KCXtOyj593qFuDCYbCYQg
	ra5M/me58EipPsMZMBemokyOnIQGyn3qBFvzbjJ0FxEToT9cndDdD/tmfvxpMnsu4GHBUu
	twjmYgOsWPZbcu+UB12Eqbv3UcTHuFU=
Date: Wed, 10 Jun 2026 20:59:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Run generic devmap egress prog on private skb
To: Sun Jian <sun.jian.kdev@gmail.com>, bpf@vger.kernel.org
Cc: Menglong Dong <menglong.dong@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260610102850.483291-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:toke@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,etsalapatis.com,kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,redhat.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78DFF6698FA


On 6/10/26 6:28 PM, Sun Jian wrote:
> Generic XDP devmap multi redirect uses skb_clone() for the
> intermediate destinations and sends the last destination with the
> original skb. This can leave multiple destinations sharing the same
> packet data.
>
> This becomes visible when a devmap egress program mutates packet data.
> One destination can observe changes made for another destination. The
> last-destination path has the same problem: the last destination runs on
> the original skb, so its egress program can modify packet data still
> shared with earlier cloned skbs.
>
> Native XDP broadcast redirect does not have this issue because
> xdpf_clone() copies the frame data for each destination. Generic XDP
> should provide the same per-destination isolation before running a
> devmap egress program.
>
> Fix this by making cloned skbs private in dev_map_generic_redirect()
> before running the devmap egress program. Use skb_copy() instead of
> skb_unshare() so that allocation failure does not consume the skb and
> the existing caller error paths keep their ownership semantics.
>
> Add a selftest that covers the last-destination case where earlier
> destinations do not have a devmap egress program, while the final
> destination does.
>
> Tested with:
>    ./test_progs -t xdp_veth_egress
>    ./test_progs -t xdp_veth
>    ./test_progs -t xdp
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/
>
> Changes in v2:
> - Move the private-copy step into dev_map_generic_redirect() so the
>    last-destination path is covered as well.
> - Use skb_copy() instead of skb_unshare() to keep caller ownership
>    unchanged on allocation failure.
> - Add a generic XDP last-destination selftest case.
>
>   kernel/bpf/devmap.c                           |  10 ++
>   .../selftests/bpf/prog_tests/test_xdp_veth.c  | 151 +++++++++++++++++-
>   2 files changed, 158 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..59f267685bc6 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -700,12 +700,22 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
>   int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
>   			     const struct bpf_prog *xdp_prog)
>   {
> +	struct sk_buff *nskb;
>   	int err;
>   
>   	err = xdp_ok_fwd_dev(dst->dev, skb->len);
>   	if (unlikely(err))
>   		return err;
>   
> +	if (dst->xdp_prog && skb_cloned(skb)) {
> +		nskb = skb_copy(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		consume_skb(skb);
> +		skb = nskb;
> +	}
> +


LGTM.


Please split selftest as a seprated patch of a patchset.

>   	/* Redirect has already succeeded semantically at this point, so we just
>   	 * return 0 even if packet is dropped. Helper below takes care of
>   	 * freeing skb.
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> index 3e98a1665936..1f0b9ade12fe 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> @@ -456,7 +456,11 @@ static void xdp_veth_egress(u32 flags)
>   			.remote_flags = flags,
>   		


[...]

> +	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
> +		struct bpf_devmap_val devmap_val = {};
> +		int ifindex = if_nametoindex(net_config.veth_cfg[i].local_veth);
> +
> +		SYS(destroy_xdp_redirect_map,
> +		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
> +		    net_config.veth_cfg[i].namespace, IP_NEIGH,
> +		    net_config.veth_cfg[i].remote_veth);
> +
> +		if (attach_programs_to_veth_pair(bpf_objs, VETH_EGRESS_SKEL_NB,
> +						 &net_config, prog_cfg, i))
> +			goto destroy_xdp_redirect_map;
> +
> +		err = bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
> +		if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +			goto destroy_xdp_redirect_map;
> +
> +		devmap_val.ifindex = ifindex;
> +		devmap_val.bpf_prog.fd = -1;
> +
> +		if (i == VETH_PAIRS_COUNT - 1)
> +			devmap_val.bpf_prog.fd =
> +				bpf_program__fd(xdp_redirect_multi_kern->progs.xdp_devmap_prog);
> +
> +		err = bpf_map_update_elem(egress_map, &ifindex, &devmap_val, 0);


The kernel walks DEVMAP_HASH in bucket order so I don't think we can 
guarantee that the entry at VETH_PAIRS_COUNT - 1 is the last dst.

Could we use i as the key instead, so the entry order becomes 
deterministic? (bucket is key & (n_buckets - 1).)

