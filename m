Return-Path: <netdev+bounces-254825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI4jDXFze2mMEgIAu9opvQ
	(envelope-from <netdev+bounces-254825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:49:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB72B1275
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5000730488DD
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD92D7384;
	Thu, 29 Jan 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="065Cp4zb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHyK9lev"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74E1A3154
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697833; cv=none; b=Ise77j35+08Vav0RAdh0i1f7e6pgDjk/T92j8N+2EfcsefCNbtjN1qKc07pZtw9387un6HQfIPkBJoa9MxUIowUazU3/llj5HFVXIDjUSliL0QhLzKK+vpRYG9nvagutnjdnB0+VENrxOohnM1VrqRmOEQ03mx0XVDt5xUDq4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697833; c=relaxed/simple;
	bh=hFAzXNZW6wcy9pudOMS/JeWcvAulzTtxbw9EJrn7FxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR2ijVKUtDVg70AhGlSW7ZzKmxP2X5t3yIyad9p9ekUXk+WiaKob+zIWdzdWAyiLdxZM9/cXawVKMYhPUcGBj+baz9HPpRX5No4NZH1zLJa1qLb16CiismDjFTwn14BpL6cZIhQQCMtfq7u4tHO9F3RA+ePdyft5wkTQXZ7Na/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=065Cp4zb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHyK9lev; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 15:43:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769697830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xo06iS+jZwwuRGAhYZxzhnZxelFqe2215oARqBsaMNU=;
	b=065Cp4zbxaaJWpLmi8SBg8eOwzPZExhdvej5i3vdgctfyP4nb3Mmqr2J4PUaf4G+KwExv/
	h2NASrV1UWLss4O7lg6DFv55gpWytQPNUsBBFBpOvmyA++KbHiP5PnSwqGiZJsu2qkr8Yh
	Wmakl9Vkhn0C2DMZzbugm8W5bai5J+rOcQSRhcWUpJrUXBwKh3PKZo5nQhUJLU25Ijuj5H
	B0ud0XHAphAF7+Mm3UdQjdv1PmMdlion7IiuLGgjgM7Tb/BZQD/bfEvRfd4ff7WS2g/VtK
	06ccd+rjV1S2TDYoJxrHFc77fjfALgxMDGTDrBY58UJEaapRlybl4Vl2bs/k4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769697830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xo06iS+jZwwuRGAhYZxzhnZxelFqe2215oARqBsaMNU=;
	b=qHyK9levHnWfK3P2+hZ+PfIDHI+FebxB6cg/mRxUovqZwMMUUx+fGygmM0HxWlFMPkEtJ5
	LK/B1M/UW7zKyIDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260129144348.CIs44m-d@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254825-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: AEB72B1275
X-Rspamd-Action: no action

On 2026-01-22 15:57:01 [+0100], Felix Maurer wrote:
=E2=80=A6
> As the problem (we accidentally skip over a sequence number that has not
> been received but will be received in the future) is similar to PRP, we c=
an
> apply a similar solution. The duplicate discard algorithm based on the
> "sparse bitmap" works well for HSR if it is extended to track one bitmap
> for each port (A, B, master, interlink). To do this, change the sequence
> number blocks to contain a flexible array member as the last member that
> can keep chunks for as many bitmaps as we need. This design makes it easy
> to reuse the same algorithm in a potential PRP RedBox implementation.

I know you just "copy" the logic based on what we have now but=E2=80=A6
Why do we have to track the sequence number for A, B and interlink? The
'master' port is what we feed into the stack so this needs to be
de-duplicated. I am not sure how 'interlink' works so I keep quiet here.
But A and B? There shouldn't be any duplicates on A and B unless the
destination node forwards the node. Or do I miss something?
I'm bringing this up because limiting to one (or two since I am unsure
about interlink) would save some memory and avoid needless updates. And
if you have HW-offloading enabled then you shouldn't see any packets
which are not directed to _this_ node.

=E2=80=A6
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 70b3819e9298..c9bd25e6a7cc 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -805,6 +774,39 @@ void *hsr_get_next_node(struct hsr_priv *hsr, void *=
_pos,
>  	return NULL;
>  }
> =20
> +/* Fill the last sequence number that has been received from node on if1=
 by
> + * finding the last sequence number sent on port B; accordingly get the =
last
> + * received sequence number for if2 using sent sequence numbers on port =
A.
> + */
> +static void fill_last_seq_nrs(struct hsr_node *node, u16 *if1_seq, u16 *=
if2_seq)
> +{
> +	struct hsr_seq_block *block;
> +	unsigned int block_off;
> +	size_t block_sz;
> +	u16 seq_bit;
> +
> +	spin_lock_bh(&node->seq_out_lock);
> +
> +	// Get last inserted block
> +	block_off =3D (node->next_block - 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> +	block_sz =3D hsr_seq_block_size(node);
> +	block =3D node->block_buf + block_off * block_sz;
> +
> +	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_B - 1],
> +			  HSR_SEQ_BLOCK_SIZE)) {
> +		seq_bit =3D find_last_bit(block->seq_nrs[HSR_PT_SLAVE_B - 1],
> +					HSR_SEQ_BLOCK_SIZE);
> +		*if1_seq =3D (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
> +	}
> +	if (!bitmap_empty(block->seq_nrs[HSR_PT_SLAVE_A - 1],
> +			  HSR_SEQ_BLOCK_SIZE)) {
> +		seq_bit =3D find_last_bit(block->seq_nrs[HSR_PT_SLAVE_A - 1],
> +					HSR_SEQ_BLOCK_SIZE);
> +		*if2_seq =3D (block->block_idx << HSR_SEQ_BLOCK_SHIFT) | seq_bit;
> +	}
> +	spin_unlock_bh(&node->seq_out_lock);

I know you preserve what is already here but what is this even used for?
| ip -d link show dev hsr0

does not show these numbers. It shows the sequence number of the hsr0
interface which I understand.
But then it is also possible to show the last received sequence number
of any node on either of the two interfaces?

> +}
> +
>  int hsr_get_node_data(struct hsr_priv *hsr,
>  		      const unsigned char *addr,
>  		      unsigned char addr_b[ETH_ALEN],
=E2=80=A6
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -82,15 +82,18 @@ int prp_register_frame_out(struct hsr_port *port, str=
uct hsr_frame_info *frame);
>  #define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_BLOCK=
_SHIFT)
>  #define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOCK_MA=
SK)
> =20
> +#define DECLARE_BITMAP_FLEX_ARRAY(name, bits) \
> +	unsigned long name[][BITS_TO_LONGS(bits)]
> +
>  struct hsr_seq_block {
>  	unsigned long		time;
>  	u16			block_idx;
> -	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> +	DECLARE_BITMAP_FLEX_ARRAY(seq_nrs, HSR_SEQ_BLOCK_SIZE);

is there a story behind DECLARE_BITMAP_FLEX_ARRAY()? We have just this
one user.

>  };

Sebastian

