Return-Path: <netdev+bounces-73078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C5085ACE2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 21:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A410288FE0
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA62E535D0;
	Mon, 19 Feb 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYv7tIA3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AEB535BF
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373633; cv=none; b=f2A2grIuJcVNW83yKKKW589bXeIP9TeBT2bLUSE2z+M8umBH/fQc3TuKNM9AUEs6VTtH36m1KKkM91W+QMiaQ4bTwbPlk0zEI+J2cL5O8YCWx17mmA2aeeQKHmMPftQErvqgiIFPHBjoRNZ8ab777uy/bberpU4mhW8ebwD/lOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373633; c=relaxed/simple;
	bh=KciqEVc1JI/R4CyGsB/xQChlbDyFWSoBcqtng0+6BKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDuUI5Ik4AL0Nb5B6tAi4h72tFUTzhOe64IO147ynnDPognaz6Om1jO2/ey2syaukrOCHf047bCj/ZLeLinntx/dvJtiFX632b6KcEy7POgt+EIuA45wGd8l6CkSphv3HOKn5Y3KPyp1IagdY1vzG7RXAlVJkqHb3EOXOAWtgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYv7tIA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D16C43609;
	Mon, 19 Feb 2024 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708373633;
	bh=KciqEVc1JI/R4CyGsB/xQChlbDyFWSoBcqtng0+6BKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYv7tIA3Si/F5TVe4Jzni4prGyKSHlq3Bf/KVfQNEcjE/UVyN/H0P1mKeODUbiC+m
	 OFnQ7JJoXuTcKCPIRYEzug5ZNCi4sEXGLAcpF1TFMJco8sOKFnfJM1yp4wDGTKcoKF
	 R9uPajDZRC0OFsl9iax0jYaho8NRh5Em22IB5Xfj0yPcK6f8ISIGS0hQTv91LssmeH
	 qHBVbloKQ247eDx6lkCw+r56rClaHs/VDoawcQsKKyoZkx3CZh3P1fzsvGRoqi6t4R
	 /q9PYBKm34ozcQxBKdjS5tu54mPUflqwUFRxuB8kLWJ8XdJYnPQqSOwGH3QRxn0t0b
	 IoIp3ANQwdtNw==
Date: Mon, 19 Feb 2024 20:13:49 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
Message-ID: <20240219201349.GO40273@kernel.org>
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219085735.1220113-9-chopps@chopps.org>

On Mon, Feb 19, 2024 at 03:57:35AM -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>

...

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c

...

> +/**
> + * skb_head_to_frag() - initialize a skb_frag_t based on skb head data
> + * @skb: skb with the head data
> + * @frag: frag to initialize
> + */
> +static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
> +{
> +	struct page *page = virt_to_head_page(skb->data);
> +	unsigned char *addr = (unsigned char *)page_address(page);
> +
> +	BUG_ON(!skb->head_frag);

Is it strictly necessary to crash the Kernel here?
Likewise, many other places in this patch.

> +	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
> +}

...

> +/**
> + * skb_add_frags() - add a range of fragment references into an skb
> + * @skb: skb to add references into
> + * @walk: the walk to add referenced fragments from.
> + * @offset: offset from beginning of original skb to start from.
> + * @len: amount of data to add frag references to in @skb.
> + *
> + * skb_can_add_frags() should be called before this function to verify that the
> + * destination @skb is compatible with the walk and has space in the array for
> + * the to be added frag refrences.

nit: references

> + *
> + * Return: The number of bytes not added to @skb b/c we reached the end of the
> + * walk before adding all of @len.
> + */

...

> +/**
> + * iptfs_reassem_done() - In-progress packet is aborted free the state.

nit: This does not match the name of the function it documents.

     Flagged by W=1 build with gcc-13.

> + * @xtfs: xtfs state
> + */
> +static void iptfs_reassem_abort(struct xfrm_iptfs_data *xtfs)
> +{
> +	__iptfs_reassem_done(xtfs, true);
> +}

...

> +/**
> + * iptfs_input_ordered() - handle next in order IPTFS payload.
> + * @x: xfrm state
> + * @skb: current packet
> + *
> + * Process the IPTFS payload in `skb` and consume it afterwards.
> + */
> +static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	u8 hbytes[sizeof(struct ipv6hdr)];
> +	struct ip_iptfs_cc_hdr iptcch;
> +	struct skb_seq_state skbseq;
> +	struct skb_frag_walk _fragwalk;
> +	struct skb_frag_walk *fragwalk = NULL;
> +	struct list_head sublist; /* rename this it's just a list */
> +	struct sk_buff *first_skb, *defer, *next;
> +	const unsigned char *old_mac;
> +	struct xfrm_iptfs_data *xtfs;
> +	struct ip_iptfs_hdr *ipth;
> +	struct iphdr *iph;
> +	struct net *net;
> +	u32 remaining, first_iplen, iplen, iphlen, data, tail;
> +	u32 blkoff, capturelen;
> +	u64 seq;
> +
> +	xtfs = x->mode_data;
> +	net = dev_net(skb->dev);
> +	first_skb = NULL;
> +	defer = NULL;
> +
> +	seq = __esp_seq(skb);
> +
> +	/* Large enough to hold both types of header */
> +	ipth = (struct ip_iptfs_hdr *)&iptcch;
> +
> +	/* Save the old mac header if set */
> +	old_mac = skb_mac_header_was_set(skb) ? skb_mac_header(skb) : NULL;
> +
> +	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
> +
> +	/* Get the IPTFS header and validate it */
> +
> +	if (skb_copy_bits_seq(&skbseq, 0, ipth, sizeof(*ipth))) {
> +		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
> +		goto done;
> +	}
> +	data = sizeof(*ipth);
> +
> +	trace_iptfs_egress_recv(skb, xtfs, htons(ipth->block_offset));

Maybe this is backwards, because the argument to htons should be
in host byte order, but the type of ipth->block_offset is __be16.

Also, personally, i would suggest using be16_to_cpu as it better
describes the types involved.

This is flagged by Sparse along with some other problems.
Please take care not to introduce new Sparse warnings.

...

> +static u32 __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
> +				   struct sk_buff *inskb,
> +				   struct list_head *list,
> +				   struct list_head *freelist, u32 *fcount)
> +{
> +	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
> +	const u64 inseq = __esp_seq(inskb);
> +	u32 savedlen = xtfs->w_savedlen;
> +	u64 wantseq = xtfs->w_wantseq;
> +	struct sk_buff *slot0 = NULL;
> +	u64 last_drop_seq = xtfs->w_wantseq;
> +	u64 distance, extra_drops, missed, s0seq;

Missed is set but otherwise unused in this function.

Flagged by W=1 build with clang-17.

> +	u32 count = 0;
> +	struct skb_wseq *wnext;
> +	u32 beyond, shifting, slot;
> +
> +	BUG_ON(inseq <= wantseq);
> +	distance = inseq - wantseq;
> +	BUG_ON(distance <= nslots - 1);
> +	beyond = distance - (nslots - 1);
> +	missed = 0;
> +
> +	/* Handle future sequence number received.
> +	 *
> +	 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
> +	 * b/c we are beyond the window boundary.
> +	 *
> +	 * We know we don't have the wantseq so that counts as a drop.
> +	 */
> +
> +	/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the
> +	 * missing sequence number.
> +	 *
> +	 * the final slot at savedlen (index savedlen - 1) is always occupied.
> +	 *
> +	 * beyond is "beyond array size" not savedlen.
> +	 *
> +	 *          +--------- array length (savedlen == 2)
> +	 *          |   +----- array size (nslots - 1 == 3)
> +	 *          |   |   +- window boundary (nslots == 4)
> +	 *          V   V | V
> +	 *                |
> +	 *  0   1   2   3 |   slot number
> +	 * ---  0   1   2 |   array index
> +	 *     [b] [c] : :|   array
> +	 *                |
> +	 * "2" "3" "4" "5"|*6*  seq numbers
> +	 *
> +	 * We receive seq number 6
> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 3 [distance(4) - 1]
> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +	 * shifting == 1 [min(savedlen(2), beyond(1)]
> +	 * slot0_skb == [b], and should match w_wantseq
> +	 *
> +	 *                +--- window boundary (nslots == 4)
> +	 *  0   1   2   3 | 4   slot number
> +	 * ---  0   1   2 | 3   array index
> +	 *     [b] : : : :|     array
> +	 * "2" "3" "4" "5" *6*  seq numbers
> +	 *
> +	 * We receive seq number 6
> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 3 [distance(4) - 1]
> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
> +	 * shifting == 1 [min(savedlen(1), beyond(1)]
> +	 * slot0_skb == [b] and should match w_wantseq
> +	 *
> +	 *                +-- window boundary (nslots == 4)
> +	 *  0   1   2   3 | 4   5   6   slot number
> +	 * ---  0   1   2 | 3   4   5   array index
> +	 *     [-] [c] : :|             array
> +	 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
> +	 *
> +	 * savedlen = 2, beyond = 3
> +	 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
> +	 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
> +	 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
> +	 *
> +	 * We receive seq number 8
> +	 * distance == 6 [inseq(8) - w_wantseq(2)]
> +	 * newslot == distance
> +	 * index == 5 [distance(6) - 1]
> +	 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
> +	 * shifting == 2 [min(savedlen(2), beyond(3)]
> +	 *
> +	 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
> +	 */
> +
> +	/* Now send any packets that are being shifted out of saved, and account
> +	 * for missing packets that are exiting the window as we shift it.
> +	 */
> +
> +	/* If savedlen > beyond we are shifting some, else all. */
> +	shifting = min(savedlen, beyond);
> +
> +	/* slot0 is the buf that just shifted out and into slot0 */
> +	slot0 = NULL;
> +	s0seq = wantseq;
> +	last_drop_seq = s0seq;
> +	wnext = xtfs->w_saved;
> +	for (slot = 1; slot <= shifting; slot++, wnext++) {
> +		/* handle what was in slot0 before we occupy it */
> +		if (!slot0) {
> +			last_drop_seq = s0seq;
> +			missed++;
> +		} else {
> +			list_add_tail(&slot0->list, list);
> +			count++;
> +		}
> +		s0seq++;
> +		slot0 = wnext->skb;
> +		wnext->skb = NULL;
> +	}
> +
> +	/* slot0 is now either NULL (in which case it's what we now are waiting
> +	 * for, or a buf in which case we need to handle it like we received it;
> +	 * however, we may be advancing past that buffer as well..
> +	 */
> +
> +	/* Handle case where we need to shift more than we had saved, slot0 will
> +	 * be NULL iff savedlen is 0, otherwise slot0 will always be
> +	 * non-NULL b/c we shifted the final element, which is always set if
> +	 * there is any saved, into slot0.
> +	 */
> +	if (savedlen < beyond) {
> +		extra_drops = beyond - savedlen;
> +		if (savedlen == 0) {
> +			BUG_ON(slot0);
> +			s0seq += extra_drops;
> +			last_drop_seq = s0seq - 1;
> +		} else {
> +			extra_drops--; /* we aren't dropping what's in slot0 */
> +			BUG_ON(!slot0);
> +			list_add_tail(&slot0->list, list);
> +			/* if extra_drops then we are going past this slot0
> +			 * so we can safely advance last_drop_seq
> +			 */
> +			if (extra_drops)
> +				last_drop_seq = s0seq + extra_drops;
> +			s0seq += extra_drops + 1;
> +			count++;
> +		}
> +		missed += extra_drops;
> +		slot0 = NULL;
> +		/* slot0 has had an empty slot pushed into it */
> +	}
> +	(void)last_drop_seq;	/* we want this for CC code */
> +
> +	/* Remove the entries */
> +	__vec_shift(xtfs, beyond);
> +
> +	/* Advance want seq */
> +	xtfs->w_wantseq += beyond;
> +
> +	/* Process drops here when implementing congestion control */
> +
> +	/* We've shifted. plug the packet in at the end. */
> +	xtfs->w_savedlen = nslots - 1;
> +	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
> +	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
> +
> +	/* if we don't have a slot0 then we must wait for it */
> +	if (!slot0)
> +		return count;
> +
> +	/* If slot0, seq must match new want seq */
> +	BUG_ON(xtfs->w_wantseq != __esp_seq(slot0));
> +
> +	/* slot0 is valid, treat like we received expected. */
> +	count += __reorder_this(xtfs, slot0, list);
> +	return count;
> +}

...

> +/**
> + * iptfs_get_mtu() - return the inner MTU for an IPTFS xfrm.

nit: This does not match the name of the function it documents.

> + * @x: xfrm state.
> + * @outer_mtu: Outer MTU for the encapsulated packet.
> + *
> + * Return: Correct MTU taking in to account the encap overhead.
> + */
> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)

...

