Return-Path: <netdev+bounces-74187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06C860702
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C950DB20D7C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7618629;
	Thu, 22 Feb 2024 23:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A7817BD3
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644822; cv=none; b=naR1V2UnHV5yYUqaXRYwl+cWN1p7fLKGCnZI39t7P0EF3JQlgNICwYiZrvODjVt+2pFUebiX4iUJ3X/yFitOBW8DMrK9ZrJ2davMXYCr/wHjOzRDHDxh5XHQiiiD7Nw8DL05BsNabzlC7Kz8mGRjEh6jKRFh6s0cBHsJzO7dR7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644822; c=relaxed/simple;
	bh=GazAxiBxHqNul1+j/3O3F5i0ywf3TjEaLxAM75TrmRk=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=kBTEt6cD16haJkb1aSwHOFyzkFbkxvBBG1eCyRIKlOgothGOOOIJtDHAZdbYOQfn51Fd7baOVzou3BPHLnI+DutLcEdFegUAdq3J5dTvfhTPg2m9aKbQE80sJ0gHS8SM8FpRcKNrBCtovdqI3bc9IqozsB+vFia4nvNHg/pl3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net; spf=fail smtp.mailfrom=labn.net; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=labn.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=labn.net
Received: from ja.int.chopps.org.chopps.org (172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 264D27D05A;
	Thu, 22 Feb 2024 23:33:33 +0000 (UTC)
References: <20240219085735.1220113-1-chopps@chopps.org>
 <20240219085735.1220113-9-chopps@chopps.org>
 <20240219201349.GO40273@kernel.org>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@labn.net>
To: Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v1 8/8] iptfs: impl: add new iptfs xfrm mode
 impl
Date: Thu, 22 Feb 2024 15:23:36 -0500
In-reply-to: <20240219201349.GO40273@kernel.org>
Message-ID: <m24je013cj.fsf@ja.int.chopps.org>
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


Simon Horman <horms@kernel.org> writes:

> On Mon, Feb 19, 2024 at 03:57:35AM -0500, Christian Hopps wrote:
>> From: Christian Hopps <chopps@labn.net>
>>
>> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
>>
>> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
>> functionality. This functionality can be used to increase bandwidth
>> utilization through small packet aggregation, as well as help solve PMTU
>> issues through it's efficient use of fragmentation.
>>
>> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
>>
>> Signed-off-by: Christian Hopps <chopps@labn.net>
>
> ...
>
>> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
>
> ...
>
>> +/**
>> + * skb_head_to_frag() - initialize a skb_frag_t based on skb head data
>> + * @skb: skb with the head data
>> + * @frag: frag to initialize
>> + */
>> +static void skb_head_to_frag(const struct sk_buff *skb, skb_frag_t *frag)
>> +{
>> +	struct page *page = virt_to_head_page(skb->data);
>> +	unsigned char *addr = (unsigned char *)page_address(page);
>> +
>> +	BUG_ON(!skb->head_frag);
>
> Is it strictly necessary to crash the Kernel here?
> Likewise, many other places in this patch.

In all use cases it represents a programming error (bug) if the condition is met.

What is the correct use of BUG_ON?

>> +	skb_frag_fill_page_desc(frag, page, skb->data - addr, skb_headlen(skb));
>> +}
>
> ...
>
>> +/**
>> + * skb_add_frags() - add a range of fragment references into an skb
>> + * @skb: skb to add references into
>> + * @walk: the walk to add referenced fragments from.
>> + * @offset: offset from beginning of original skb to start from.
>> + * @len: amount of data to add frag references to in @skb.
>> + *
>> + * skb_can_add_frags() should be called before this function to verify that the
>> + * destination @skb is compatible with the walk and has space in the array for
>> + * the to be added frag refrences.
>
> nit: references

Fixed.

>> + *
>> + * Return: The number of bytes not added to @skb b/c we reached the end of the
>> + * walk before adding all of @len.
>> + */
>
> ...
>
>> +/**
>> + * iptfs_reassem_done() - In-progress packet is aborted free the state.
>
> nit: This does not match the name of the function it documents.
>
>      Flagged by W=1 build with gcc-13.

Fixed.

>
>> + * @xtfs: xtfs state
>> + */
>> +static void iptfs_reassem_abort(struct xfrm_iptfs_data *xtfs)
>> +{
>> +	__iptfs_reassem_done(xtfs, true);
>> +}
>
> ...
>
>> +/**
>> + * iptfs_input_ordered() - handle next in order IPTFS payload.
>> + * @x: xfrm state
>> + * @skb: current packet
>> + *
>> + * Process the IPTFS payload in `skb` and consume it afterwards.
>> + */
>> +static int iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
>> +{
>> +	u8 hbytes[sizeof(struct ipv6hdr)];
>> +	struct ip_iptfs_cc_hdr iptcch;
>> +	struct skb_seq_state skbseq;
>> +	struct skb_frag_walk _fragwalk;
>> +	struct skb_frag_walk *fragwalk = NULL;
>> +	struct list_head sublist; /* rename this it's just a list */
>> +	struct sk_buff *first_skb, *defer, *next;
>> +	const unsigned char *old_mac;
>> +	struct xfrm_iptfs_data *xtfs;
>> +	struct ip_iptfs_hdr *ipth;
>> +	struct iphdr *iph;
>> +	struct net *net;
>> +	u32 remaining, first_iplen, iplen, iphlen, data, tail;
>> +	u32 blkoff, capturelen;
>> +	u64 seq;
>> +
>> +	xtfs = x->mode_data;
>> +	net = dev_net(skb->dev);
>> +	first_skb = NULL;
>> +	defer = NULL;
>> +
>> +	seq = __esp_seq(skb);
>> +
>> +	/* Large enough to hold both types of header */
>> +	ipth = (struct ip_iptfs_hdr *)&iptcch;
>> +
>> +	/* Save the old mac header if set */
>> +	old_mac = skb_mac_header_was_set(skb) ? skb_mac_header(skb) : NULL;
>> +
>> +	skb_prepare_seq_read(skb, 0, skb->len, &skbseq);
>> +
>> +	/* Get the IPTFS header and validate it */
>> +
>> +	if (skb_copy_bits_seq(&skbseq, 0, ipth, sizeof(*ipth))) {
>> +		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
>> +		goto done;
>> +	}
>> +	data = sizeof(*ipth);
>> +
>> +	trace_iptfs_egress_recv(skb, xtfs, htons(ipth->block_offset));
>
> Maybe this is backwards, because the argument to htons should be
> in host byte order, but the type of ipth->block_offset is __be16.
>
> Also, personally, i would suggest using be16_to_cpu as it better
> describes the types involved.
>
> This is flagged by Sparse along with some other problems.
> Please take care not to introduce new Sparse warnings.

Cleaned these up. Switched to be16 macros..

> ...
>
>> +static u32 __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
>> +				   struct sk_buff *inskb,
>> +				   struct list_head *list,
>> +				   struct list_head *freelist, u32 *fcount)
>> +{
>> +	const u32 nslots = xtfs->cfg.reorder_win_size + 1;
>> +	const u64 inseq = __esp_seq(inskb);
>> +	u32 savedlen = xtfs->w_savedlen;
>> +	u64 wantseq = xtfs->w_wantseq;
>> +	struct sk_buff *slot0 = NULL;
>> +	u64 last_drop_seq = xtfs->w_wantseq;
>> +	u64 distance, extra_drops, missed, s0seq;
>
> Missed is set but otherwise unused in this function.
>
> Flagged by W=1 build with clang-17.

I've removed `missed`; however, it will be needed for congestion control if that gets implemented.

>
>> +	u32 count = 0;
>> +	struct skb_wseq *wnext;
>> +	u32 beyond, shifting, slot;
>> +
>> +	BUG_ON(inseq <= wantseq);
>> +	distance = inseq - wantseq;
>> +	BUG_ON(distance <= nslots - 1);
>> +	beyond = distance - (nslots - 1);
>> +	missed = 0;
>> +
>> +	/* Handle future sequence number received.
>> +	 *
>> +	 * IMPORTANT: we are at least advancing w_wantseq (i.e., wantseq) by 1
>> +	 * b/c we are beyond the window boundary.
>> +	 *
>> +	 * We know we don't have the wantseq so that counts as a drop.
>> +	 */
>> +
>> +	/* ex: slot count is 4, array size is 3 savedlen is 2, slot 0 is the
>> +	 * missing sequence number.
>> +	 *
>> +	 * the final slot at savedlen (index savedlen - 1) is always occupied.
>> +	 *
>> +	 * beyond is "beyond array size" not savedlen.
>> +	 *
>> +	 *          +--------- array length (savedlen == 2)
>> +	 *          |   +----- array size (nslots - 1 == 3)
>> +	 *          |   |   +- window boundary (nslots == 4)
>> +	 *          V   V | V
>> +	 *                |
>> +	 *  0   1   2   3 |   slot number
>> +	 * ---  0   1   2 |   array index
>> +	 *     [b] [c] : :|   array
>> +	 *                |
>> +	 * "2" "3" "4" "5"|*6*  seq numbers
>> +	 *
>> +	 * We receive seq number 6
>> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 3 [distance(4) - 1]
>> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 1 [min(savedlen(2), beyond(1)]
>> +	 * slot0_skb == [b], and should match w_wantseq
>> +	 *
>> +	 *                +--- window boundary (nslots == 4)
>> +	 *  0   1   2   3 | 4   slot number
>> +	 * ---  0   1   2 | 3   array index
>> +	 *     [b] : : : :|     array
>> +	 * "2" "3" "4" "5" *6*  seq numbers
>> +	 *
>> +	 * We receive seq number 6
>> +	 * distance == 4 [inseq(6) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 3 [distance(4) - 1]
>> +	 * beyond == 1 [newslot(4) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 1 [min(savedlen(1), beyond(1)]
>> +	 * slot0_skb == [b] and should match w_wantseq
>> +	 *
>> +	 *                +-- window boundary (nslots == 4)
>> +	 *  0   1   2   3 | 4   5   6   slot number
>> +	 * ---  0   1   2 | 3   4   5   array index
>> +	 *     [-] [c] : :|             array
>> +	 * "2" "3" "4" "5" "6" "7" *8*  seq numbers
>> +	 *
>> +	 * savedlen = 2, beyond = 3
>> +	 * iter 1: slot0 == NULL, missed++, lastdrop = 2 (2+1-1), slot0 = [-]
>> +	 * iter 2: slot0 == NULL, missed++, lastdrop = 3 (2+2-1), slot0 = [c]
>> +	 * 2 < 3, extra = 1 (3-2), missed += extra, lastdrop = 4 (2+2+1-1)
>> +	 *
>> +	 * We receive seq number 8
>> +	 * distance == 6 [inseq(8) - w_wantseq(2)]
>> +	 * newslot == distance
>> +	 * index == 5 [distance(6) - 1]
>> +	 * beyond == 3 [newslot(6) - lastslot((nslots(4) - 1))]
>> +	 * shifting == 2 [min(savedlen(2), beyond(3)]
>> +	 *
>> +	 * slot0_skb == NULL changed from [b] when "savedlen < beyond" is true.
>> +	 */
>> +
>> +	/* Now send any packets that are being shifted out of saved, and account
>> +	 * for missing packets that are exiting the window as we shift it.
>> +	 */
>> +
>> +	/* If savedlen > beyond we are shifting some, else all. */
>> +	shifting = min(savedlen, beyond);
>> +
>> +	/* slot0 is the buf that just shifted out and into slot0 */
>> +	slot0 = NULL;
>> +	s0seq = wantseq;
>> +	last_drop_seq = s0seq;
>> +	wnext = xtfs->w_saved;
>> +	for (slot = 1; slot <= shifting; slot++, wnext++) {
>> +		/* handle what was in slot0 before we occupy it */
>> +		if (!slot0) {
>> +			last_drop_seq = s0seq;
>> +			missed++;
>> +		} else {
>> +			list_add_tail(&slot0->list, list);
>> +			count++;
>> +		}
>> +		s0seq++;
>> +		slot0 = wnext->skb;
>> +		wnext->skb = NULL;
>> +	}
>> +
>> +	/* slot0 is now either NULL (in which case it's what we now are waiting
>> +	 * for, or a buf in which case we need to handle it like we received it;
>> +	 * however, we may be advancing past that buffer as well..
>> +	 */
>> +
>> +	/* Handle case where we need to shift more than we had saved, slot0 will
>> +	 * be NULL iff savedlen is 0, otherwise slot0 will always be
>> +	 * non-NULL b/c we shifted the final element, which is always set if
>> +	 * there is any saved, into slot0.
>> +	 */
>> +	if (savedlen < beyond) {
>> +		extra_drops = beyond - savedlen;
>> +		if (savedlen == 0) {
>> +			BUG_ON(slot0);
>> +			s0seq += extra_drops;
>> +			last_drop_seq = s0seq - 1;
>> +		} else {
>> +			extra_drops--; /* we aren't dropping what's in slot0 */
>> +			BUG_ON(!slot0);
>> +			list_add_tail(&slot0->list, list);
>> +			/* if extra_drops then we are going past this slot0
>> +			 * so we can safely advance last_drop_seq
>> +			 */
>> +			if (extra_drops)
>> +				last_drop_seq = s0seq + extra_drops;
>> +			s0seq += extra_drops + 1;
>> +			count++;
>> +		}
>> +		missed += extra_drops;
>> +		slot0 = NULL;
>> +		/* slot0 has had an empty slot pushed into it */
>> +	}
>> +	(void)last_drop_seq;	/* we want this for CC code */
>> +
>> +	/* Remove the entries */
>> +	__vec_shift(xtfs, beyond);
>> +
>> +	/* Advance want seq */
>> +	xtfs->w_wantseq += beyond;
>> +
>> +	/* Process drops here when implementing congestion control */
>> +
>> +	/* We've shifted. plug the packet in at the end. */
>> +	xtfs->w_savedlen = nslots - 1;
>> +	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
>> +	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
>> +
>> +	/* if we don't have a slot0 then we must wait for it */
>> +	if (!slot0)
>> +		return count;
>> +
>> +	/* If slot0, seq must match new want seq */
>> +	BUG_ON(xtfs->w_wantseq != __esp_seq(slot0));
>> +
>> +	/* slot0 is valid, treat like we received expected. */
>> +	count += __reorder_this(xtfs, slot0, list);
>> +	return count;
>> +}
>
> ...
>
>> +/**
>> + * iptfs_get_mtu() - return the inner MTU for an IPTFS xfrm.
>
> nit: This does not match the name of the function it documents.

Fixed.

Thanks for your review!
Chris.

>> + * @x: xfrm state.
>> + * @outer_mtu: Outer MTU for the encapsulated packet.
>> + *
>> + * Return: Correct MTU taking in to account the encap overhead.
>> + */
>> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
>
> ...

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJEBAEBCgAuFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmXX2cwQHGNob3Bwc0Bs
YWJuLm5ldAAKCRAuHYMO17gwJbvTD/9cQoiiWkVsASHGF89nV8hOfj2JWVH/lYzZ
OEoe5vqjZn/ErdIGAAHYPfRaAmC3k+FuXt++Ieh0AlqPwHzO0JIPdSe3TxErOAP5
UkeNlXOgXK9GQU7c+2B2RqnIQ/r56jYpL+YSA/fQkB0XgXnopV8afx9ciHOC+QgX
sFWYwn+h9RWTfFgy/rM7XHpx/Rl2sxtyObe6ngmgJNI4bcd0FxE6l2MT/vZJQuzf
Ke0cz+6pGwRaV84Scrj+FHzjOt7+4Ys4WHh4g5Q8hM4loeJncrcbh8ukgwEL9Gg4
R2eADr6rsKeM4JKHpZstdlP1DlOSQlRbHqBnJGAiq8PYbkwofHy7uaFnVdYy8lr2
Tzxa9c61BlF0b22PqebO1p2tlrZVlmLz6+Abdg5Qp6qod0jabx+2AuoRvwx1e3JM
hh53uS6zavlTPnHQJl7Q5smEvhavvDLmQMhUobV8c20TOSOdgDv1vftG3OI3UcfJ
KX0ptxYqELq6cQn05h/RP25TKy+xqSxNsxvQ8ErMuNhdM7R7esTGuLaMRgFFcus4
IpLsC3JUdbogC7CjacTOpUmgnemLXRDUDdF+2i9KU+YZrFB+s+/0TAL5pSUQKrH6
OUka3qMIbOukqCF255AtndUd/2egtEZ0okJ4nK0voeyVrVXY30OhG5HBV6gGylpr
69LrJn+EAw==
=djxG
-----END PGP SIGNATURE-----
--=-=-=--

