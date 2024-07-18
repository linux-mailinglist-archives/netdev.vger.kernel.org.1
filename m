Return-Path: <netdev+bounces-112010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47F934867
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7B5B217EB
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2A60275;
	Thu, 18 Jul 2024 06:56:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090626ACF
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285771; cv=none; b=mEcStd67xMV9J+WEI537FG/xA0234j8y8lq1Ddl18M3DFXoPjSVfWv24xPR63UceZIObL+3i3CN95ni3dLwOfG5TdSOeNZy8N4pOXnKd4vjNL6+rAaLH654+RnNSs+OuyQG12Od4n4GdOToOiXS+n5qemcgwxYntISbxESTjyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285771; c=relaxed/simple;
	bh=pTt9jlugQv4Lu24ZXA7GsTNtjKFEZVI9KlaBOv8lzbQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=qv2Wsfdf0bJ0qpQEDZGuqavevsznkzXzl4bV35pIlG1Jh+Mq/BvsuByO6pLZGfDrvhpTRzJgaXScIoonmQwuDSrAN4eRuYcwKUJfaT4hpnlQN0VtwqsOnoIRRUS4nplyOhfJ4ZCTQRWB/51O8iw33MGGVxoVuzEhtLqUcWab+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from vapr.local.chopps.org (unknown [50.229.122.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id A52357D06B;
	Thu, 18 Jul 2024 06:56:08 +0000 (UTC)
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-10-chopps@chopps.org>
 <20240715125555.GC45692@kernel.org> <m2cynbdz19.fsf@chopps.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian Hopps
 <chopps@labn.net>, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec-next v5 09/17] xfrm: iptfs: add user
 packet (tunnel ingress) handling
Date: Wed, 17 Jul 2024 23:32:36 -0700
In-reply-to: <m2cynbdz19.fsf@chopps.org>
Message-ID: <m2v813cho8.fsf@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


Christian Hopps <chopps@chopps.org> writes:

> [[PGP Signed Part:Good signature from 2E1D830ED7B83025 Christian Hopps <chopps@gmail.com> (trust ultimate) created at 2024-07-17T22:55:46-0700 using RSA]]
>
> Simon Horman via Devel <devel@linux-ipsec.org> writes:
>
>> On Sun, Jul 14, 2024 at 04:22:37PM -0400, Christian Hopps wrote:
>>> From: Christian Hopps <chopps@labn.net>
>>>
>>> Add tunnel packet output functionality. This is code handles
>>> the ingress to the tunnel.
>>>
>>> Signed-off-by: Christian Hopps <chopps@labn.net>
>>> ---
>>>  net/xfrm/xfrm_iptfs.c | 535 +++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 532 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>>
>> ...
>>
>>> +static int iptfs_get_cur_pmtu(struct xfrm_state *x,
>>> +			      struct xfrm_iptfs_data *xtfs, struct sk_buff *skb)
>>> +{
>>> +	struct xfrm_dst *xdst = (struct xfrm_dst *)skb_dst(skb);
>>> +	u32 payload_mtu = xtfs->payload_mtu;
>>> +	u32 pmtu = iptfs_get_inner_mtu(x, xdst->child_mtu_cached);
>>
>> Hi Christian,
>>
>> Please consider arranging local variable declarations in Networking
>> code in reverse xmas tree order - longest line to shortest.
>> I think that in this case that would involve separating the
>> declaration and assignment of pmtu.
>>
>> Edward Cree's tool can be helpful here:
>> https://github.com/ecree-solarflare/xmastree
>
> This does not appear to be a style that is required by the net/xfrm code. I
> verified this by running the above tool on the other files in net/xfrm/*.c. In
> this case I'd prefer to not increase the number of lines in the function in
> order to satisfy the optional style guideline.
>
>>> +
>>> +	if (payload_mtu && payload_mtu < pmtu)
>>> +		pmtu = payload_mtu;
>>> +
>>> +	return pmtu;
>>> +}
>>
>> ...
>>
>>> +/* IPv4/IPv6 packet ingress to IPTFS tunnel, arrange to send in IPTFS payload
>>> + * (i.e., aggregating or fragmenting as appropriate).
>>> + * This is set in dst->output for an SA.
>>> + */
>>> +static int iptfs_output_collect(struct net *net, struct sock *sk,
>>> +				struct sk_buff *skb)
>>> +{
>>> +	struct dst_entry *dst = skb_dst(skb);
>>> +	struct xfrm_state *x = dst->xfrm;
>>> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
>>> +	struct sk_buff *segs, *nskb;
>>> +	u32 pmtu = 0;
>>> +	bool ok = true;
>>> +	bool was_gso;
>>> +
>>> +	/* We have hooked into dst_entry->output which means we have skipped the
>>> +	 * protocol specific netfilter (see xfrm4_output, xfrm6_output).
>>> +	 * when our timer runs we will end up calling xfrm_output directly on
>>> +	 * the encapsulated traffic.
>>> +	 *
>>> +	 * For both cases this is the NF_INET_POST_ROUTING hook which allows
>>> +	 * changing the skb->dst entry which then may not be xfrm based anymore
>>> +	 * in which case a REROUTED flag is set. and dst_output is called.
>>> +	 *
>>> +	 * For IPv6 we are also skipping fragmentation handling for local
>>> +	 * sockets, which may or may not be good depending on our tunnel DF
>>> +	 * setting. Normally with fragmentation supported we want to skip this
>>> +	 * fragmentation.
>>> +	 */
>>> +
>>> +	BUG_ON(!xtfs);
>>> +
>>> +	pmtu = iptfs_get_cur_pmtu(x, xtfs, skb);
>>> +
>>> +	/* Break apart GSO skbs. If the queue is nearing full then we want the
>>> +	 * accounting and queuing to be based on the individual packets not on the
>>> +	 * aggregate GSO buffer.
>>> +	 */
>>> +	was_gso = skb_is_gso(skb);
>>> +	if (!was_gso) {
>>> +		segs = skb;
>>> +	} else {
>>> +		segs = skb_gso_segment(skb, 0);
>>> +		if (IS_ERR_OR_NULL(segs)) {
>>> +			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
>>> +			kfree_skb(skb);
>>> +			return PTR_ERR(segs);
>>
>> This will return 0 is skb_gso_segment returns NULL,
>> which occurs if skb doesn't require segmentation.
>> Is that intentional?
>>
>> If so, I wonder if it would be slightly nicer
>> to use PTR_ERR_OR_ZERO() instead of PTR_ERR().
>>
>> Flagged by Smatch (suggestion is my own).
>>  (suggestion is my own)
>
> Thanks! Actually in the case of NULL I've changed the code to return -EINVAL as xfrm_output_gso() does.
>
>>> +		}
>>> +		consume_skb(skb);
>>> +		skb = NULL;
>>> +	}
>>> +
>>> +	/* We can be running on multiple cores and from the network softirq or
>>> +	 * from user context depending on where the packet is coming from.
>>> +	 */
>>> +	spin_lock_bh(&x->lock);
>>> +
>>> +	skb_list_walk_safe(segs, skb, nskb)
>>> +	{
>>> +		skb_mark_not_on_list(skb);
>>> +
>>> +		/* Once we drop due to no queue space we continue to drop the
>>> +		 * rest of the packets from that GRO.
>>> +		 */
>>> +		if (!ok) {
>>> +nospace:
>>> +			if (skb->dev)
>>> +				XFRM_INC_STATS(dev_net(skb->dev),
>>> +					       LINUX_MIB_XFRMOUTNOQSPACE);
>>> +			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
>>> +			continue;
>>> +		}
>>> +
>>> +		/* Fragmenting handled in following commits. */
>>> +		if (iptfs_is_too_big(sk, skb, pmtu)) {
>>> +			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
>>> +			continue;
>>> +		}
>>> +
>>> +		/* Enqueue to send in tunnel */
>>> +		ok = iptfs_enqueue(xtfs, skb);
>>> +		if (!ok)
>>> +			goto nospace;
>>> +	}
>>> +
>>> +	/* Start a delay timer if we don't have one yet */
>>> +	if (!hrtimer_is_queued(&xtfs->iptfs_timer)) {
>>> +		hrtimer_start(&xtfs->iptfs_timer, xtfs->init_delay_ns,
>>> +			      IPTFS_HRTIMER_MODE);
>>> +		xtfs->iptfs_settime = ktime_get_raw_fast_ns();
>>> +	}
>>> +
>>> +	spin_unlock_bh(&x->lock);
>>> +	return 0;
>>> +}
>>
>> ...
>>
>>> +static enum hrtimer_restart iptfs_delay_timer(struct hrtimer *me)
>>> +{
>>> +	struct sk_buff_head list;
>>> +	struct xfrm_iptfs_data *xtfs;
>>> +	struct xfrm_state *x;
>>> +	time64_t settime;
>>> +
>>> +	xtfs = container_of(me, typeof(*xtfs), iptfs_timer);
>>> +	x = xtfs->x;
>>> +
>>> +	/* Process all the queued packets
>>> +	 *
>>> +	 * softirq execution order: timer > tasklet > hrtimer
>>> +	 *
>>> +	 * Network rx will have run before us giving one last chance to queue
>>> +	 * ingress packets for us to process and transmit.
>>> +	 */
>>> +
>>> +	spin_lock(&x->lock);
>>> +	__skb_queue_head_init(&list);
>>> +	skb_queue_splice_init(&xtfs->queue, &list);
>>> +	xtfs->queue_size = 0;
>>> +	settime = xtfs->iptfs_settime;
>>
>> nit: settime is set but otherwise unused in this function.
>>
>>      Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.
>>
>
> Hmm, this value is in fact used inside a trace point function call in this function.


Realized this is another artifact of splitting the commit, I've moved settime to the later tracepoint commit now.

Thanks,
Chris.

>
>>> +	spin_unlock(&x->lock);
>>> +
>>> +	/* After the above unlock, packets can begin queuing again, and the
>>> +	 * timer can be set again, from another CPU either in softirq or user
>>> +	 * context (not from this one since we are running at softirq level
>>> +	 * already).
>>> +	 */
>>> +
>>> +	iptfs_output_queued(x, &list);
>>> +
>>> +	return HRTIMER_NORESTART;
>>> +}
>>
>> ...
>>
>>> @@ -98,10 +607,23 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>>>  {
>>>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>>>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>>> -	int ret = 0;
>>> +	int ret;
>>> +	u64 q;
>>> +
>>> +	if (x->dir == XFRM_SA_DIR_OUT) {
>>> +		q = xtfs->init_delay_ns;
>>> +		(void)do_div(q, NSECS_IN_USEC);
>>> +		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
>>> +				  xc->max_queue_size);
>>> +		if (ret)
>>> +			return ret;
>>>
>>> -	if (x->dir == XFRM_SA_DIR_OUT)
>>>  		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>>> +	}
>>
>> ret will be used uninitialised here unless the if condition above is true.
>>
>> Flagged by W=1 x86_64 allmodconfig build with clang-18, and Smatch.
>
> Sigh, this is an artifact of splitting up the new file into multiple
> functionality commits. The final resulting code does not leave the value
> uninitialized. In any case I will fix it in this middle commit too.
>
> Thanks!
> Chris.
>
>>
>>>
>>>  	return ret;
>>>  }
>> ...
>
> [[End of PGP Signed Part]]


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmaYvIcSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlUdAP/iEnFHr/AFyBFDYLwH48R5DmRZ/uG4aV
O7sjeSJnijaBGa/odPoGht46XGDiIv+F9bJujd2MStsrheJSIp1fOVO96IHCGKtC
ak9SYqjgAB56jKI92ALPs8pzlHS8LGzG5E+h4HivLLncMDXEcfWEbwberX+VS3jY
2nUNxAXD1iABfyqjhvIbH3HDz8wFz5g2plcKvnp7hPiLvsf8XZbPv7oBB8lj9ejk
67QQ098Pa8jAICYIUsyEmmnS1G+c+emM9/AYFqVm3oR7Xjht8Mp0Da8f7mAKnWng
L8RV0afDUbnWSl5IMNpwA6M9HahnT2Dtf5tHaClsBuQqVp7NH+PVVJGPyTPmCJXN
D7U6c9DbjVwR9V5gviTvEnH8zRqwJWd9tUvYNH7MNfnK/Z+SguCBKQEjihUpJty9
7T/gBYhpf7Ffi0KfmCsQxOAsNBYP8cepo+wHjt40VN6BRUV3KPjP8a3tPuYBY5CO
rNXqfM5YkhCeF8zIyhkKx0XejOeuGCLkhp77OMTtSWwP1Sbd0NJY5aYRKibU8fBp
RfA0B6RHyGlYLKl50TzSHYH5vVnlZuM+kti8kFni/ZcZnIcvyM228qnCpHTGbkFj
aajwZMFz2ibvX4sJSS655ZnubR3OT/KzOM73vzgru5DrK77bxG1FNUUeEZD76Oa+
7qEdSeNCQFQ9
=zH4n
-----END PGP SIGNATURE-----
--=-=-=--

