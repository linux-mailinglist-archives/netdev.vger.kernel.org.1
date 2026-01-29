Return-Path: <netdev+bounces-254803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKqPHzlhe2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:31:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E68B0672
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1C93013D7D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815DC2749E0;
	Thu, 29 Jan 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4e6cbkKZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/LOJHdm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2427A91D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693385; cv=none; b=UCe+TeYmnLC1WWQ3kgH1MpNL7RP8vs6PqKVo3EN6nF53Aqu+bI6o+z0uIZjVJ3Yj+Oym5DwLD3JmccAAj8ppAX6WD4lZCBCv+JAZDY9bPvvCBWgIx7DQfAYGVKGWW94bhgQubB/pwqUNG2/F5v4i+3VcUGYO/IwHHLemlCXSfEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693385; c=relaxed/simple;
	bh=HjaLF9XOvgXBgck3PsTXGsHEJPkaeWI6D2M5OJMJizM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar0+9Y2KIS8PUp2Zz/dPIud2Q00LQUoSNbUGO7M8f0F0VLVekm/9GdfG41+VQqi9atr3z56AabfA7WaYTABZzz3U4w2hUGq6JrQernzSvfQRw2nPlB50Epm6DvP3Kup6a6JGKBDXeg56udMH5ewt17z7SEPbeYqSRe/T+TFVhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4e6cbkKZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/LOJHdm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 14:29:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769693382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVF88mdylAwx4nCycQNgURy8YQIk3RNaKJQxkCWNRdA=;
	b=4e6cbkKZWIhPDZgmpbHt3The2ZDK6aPcgNtiDLb3Z55/DfPFJ6wgAKrwffqs8HEzSklHkf
	KEfB2MB4xp7LSbtDySOMVG2IeLcKfm1vVeC3hbE8HbsQmTPrIQkCWoqXYjaBZ6WnyqWZZg
	2ff133vUZVMzfu/W0VwidubGLjUafZHMy45uNdAQ2tJqlVwDs8y11ZOpebtqOHgl2nnBiF
	GOOSWEuZgNxb59CRf2OrUNa7O2jLiy68VuBmS4mSe/dYwzkVeO+VfgRu/a21aX0x1s0dd9
	9/EGx5nVqH61AG3WPsOzewoPlmIG5qUl+4xD78nkrsbFCC1m2CXAuytLRljjhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769693382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVF88mdylAwx4nCycQNgURy8YQIk3RNaKJQxkCWNRdA=;
	b=h/LOJHdmx/T9lSQoEIHhEWaDimEv1GpiTrvr2mcCwb/t7nl1nE6qiY9ZHcg2hfIHtqqP9h
	kKE+q4qyMxqizSAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <20260129132940.XvIWrwoG@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254803-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2E68B0672
X-Rspamd-Action: no action

On 2026-01-22 15:56:59 [+0100], Felix Maurer wrote:
> The PRP duplicate discard algorithm does not work reliably with certain
=E2=80=A6
> The idea of the new algorithm is to store the seen sequence numbers in a
> bitmap. To keep the size of the bitmap in control, we store it as a "spar=
se
> bitmap" where the bitmap is split into blocks and not all blocks exist at
> the same time. The sparse bitmap is implemented using an xarray that keeps
> the references to the individual blocks and a backing ring buffer that
=E2=80=A6

My idea was to keep track of say the last 64 sequence numbers but I had
no idea how to efficiently implement it with all the "forget" parts and
so on. What you did here is quite nice.

> @@ -280,6 +301,59 @@ struct hsr_node *hsr_get_node(struct hsr_port *port,=
 struct list_head *node_db,
=E2=80=A6
> +/* Get the currently active sequence number block. If there is no block =
yet, or
> + * the existing one is expired, a new block is created. The idea is to m=
aintain
> + * a "sparse bitmap" where a bitmap for the whole sequence number space =
is
> + * split into blocks and not all blocks exist all the time. The blocks c=
an
> + * expire after time (in low traffic situations) or when they are replac=
ed in
> + * the backing fixed size buffer (in high traffic situations).
                                    HSR_MAX_SEQ_BLOCKS,=20
> + */
> +static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
> +					       u16 block_idx)
> +{
> +	struct hsr_seq_block *block, *res;
> +
> +	block =3D xa_load(&node->seq_blocks, block_idx);
> +
> +	if (block && hsr_seq_block_is_old(block)) {
> +		hsr_forget_seq_block(node, block);
> +		block =3D NULL;
> +	}
> +
> +	if (!block) {
> +		block =3D &node->block_buf[node->next_block];
> +		hsr_forget_seq_block(node, block);
> +
> +		memset(block, 0, sizeof(*block));
> +		block->time =3D jiffies;

So we assign ->time here while the block is created and it expires after
HSR_ENTRY_FORGET_TIME (400ms). *Maybe* it should be updated in
hsr_check_duplicate() if we set a bit. The difference would be that the
last sequence in the block would get it whole life time while now the
lifetime starts with the first entry in the block. The downside
of course would be that the first entry gets more than the initialy
expected lifetime.
Not sure if this matters in reality, just wanted to mention.

> +		block->block_idx =3D block_idx;
> +
> +		res =3D xa_store(&node->seq_blocks, block_idx, block, GFP_ATOMIC);
> +		if (xa_is_err(res))
> +			return NULL;
> +
> +		node->next_block =3D
> +			(node->next_block + 1) & (HSR_MAX_SEQ_BLOCKS - 1);
> +	}
> +
> +	return block;
> +}
> +
>  /* Use the Supervision frame's info about an eventual macaddress_B for m=
erging
>   * nodes that has previously had their macaddress_B registered as a sepa=
rate
>   * node.
> @@ -545,47 +631,26 @@ int prp_register_frame_out(struct hsr_port *port, s=
truct hsr_frame_info *frame)
=E2=80=A6
> +
> +	seq_bit =3D hsr_seq_block_bit(sequence_nr);
> +	if (test_and_set_bit(seq_bit, block->seq_nrs))

the access happens under ::seq_out_lock so you don't need to be atomic
here. You could safe a cycle and use __test_and_set_bit() instead.

> +		goto out_seen;
> =20
>  	node->time_out[port->type] =3D jiffies;
>  	node->seq_out[port->type] =3D sequence_nr;
> +out_new:
>  	spin_unlock_bh(&node->seq_out_lock);
>  	return 0;
> +
> +out_seen:
> +	spin_unlock_bh(&node->seq_out_lock);
> +	return 1;
>  }
> =20
>  #if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)

Sebastian

