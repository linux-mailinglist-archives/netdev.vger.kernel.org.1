Return-Path: <netdev+bounces-288339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCjoORg5B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:17:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813AB552020
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90EA3305EA3B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451848BD36;
	Fri, 15 May 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlojZh8O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfno5mVJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AC48B36F
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858099; cv=none; b=V8Jgnrhgyitki9vmGx4rylgcxBD6RgUQc0Wjh3qxiDd+Qd7A0dYr/Tpg3IY8va61oUYk5N32QGtli9OIAu4W+uVCbyxcsvDf3x1VVzDMtX6Bz+qSZvAF8P6VNi0FVdvG/jdFUijLSNkk4jrDcQaAl4JgcIiqTB6cusmglPPDuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858099; c=relaxed/simple;
	bh=8dBFIMELtiHPcLNOkoOczxG4l6go+NgkUVpwFC9zadk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4quETQZttOKAYRrxZD+pzdxQVGJ/4DgdCWpNI56hl8YtWO1jDDs+XEqEF1CTGqXJ4X9hJFjh9P7k54+yhJc9JfmlAa5lyqWxERNFbhVx31AWJaMNmrGkDjywDpNjSAVrvQiTMCMHVE5AhtT1o2J/ylJiDaKkVlkTBOUUd0YjK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlojZh8O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfno5mVJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 May 2026 17:14:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778858096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF0beZdgI77efpVKkK8sRIJS96TZ/SM1OUjOkryulY4=;
	b=NlojZh8OLEjIK2/Wf0uT7PaoQTe6wCQn8AoMiHOF3OHssvtyKdDOhUmPp5qXvus6o1MxC2
	WzLAKRc3+8zej+gnmZARQnJh07IIUf04RccsAa8ZObnrWljvqSeINok9IGVmx4LnZTufrt
	BTvwilcRJOu0kcxUKOvpO4cwR5sQJ9s9DMTjAInJfmo16U4UBQ8d+uBRbRk903A7W8sFqm
	o6AICwACl2bO2qdL4yvGjvuuOAHmLkzoEsnjPtjWEDXpbzQgWGGPFZ1XX9zqqVL3sfJFsl
	VqKZXoM4TbqzmB8dFxAz5lvPsti4vyYUu/eL4y1Hkp+8X2o6ixY/xQ06h4uJ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778858096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QF0beZdgI77efpVKkK8sRIJS96TZ/SM1OUjOkryulY4=;
	b=vfno5mVJu6piA1E+n/IFaANblXmtGNkip/ZjkW/1mnlmTv9+K1ZnLCCmktf22PZJBamNwQ
	ZA+/JQpvg6bjI+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jayachandran <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Message-ID: <20260515151454.LJU-RugA@linutronix.de>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
 <willemdebruijn.kernel.38ce4095cf2f5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.38ce4095cf2f5@gmail.com>
X-Rspamd-Queue-Id: 813AB552020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288339-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Action: no action

On 2026-05-08 13:34:04 [-0400], Willem de Bruijn wrote:
> It probably makes sense to integrate this with the main commit message
> that is preserved in the log.
>=20
> Or as a cover letter if this goes to a multi-patch series.

b4 did this since it was a single patch. If I split it into multiple
patches (as suggested below) then the cover letter should be created.

> > index 5555b71ab19b5..cab4f7c601257 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -223,24 +223,49 @@ static netdev_features_t hsr_fix_features(struct =
net_device *dev,
> > =20
> >  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device=
 *dev)
> >  {
> > +	enum hsr_port_type tx_port =3D HSR_PT_NONE;
> >  	struct hsr_priv *hsr =3D netdev_priv(dev);
> >  	struct hsr_port *master;
> > +	bool has_header =3D false;
> > =20
> >  	rcu_read_lock();
> >  	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > -	if (master) {
> > -		skb->dev =3D master->dev;
> > -		skb_reset_mac_header(skb);
> > -		skb_reset_mac_len(skb);
> > -		spin_lock_bh(&hsr->seqnr_lock);
> > -		hsr_forward_skb(skb, master);
> > -		spin_unlock_bh(&hsr->seqnr_lock);
> > -	} else {
> > -		dev_core_stats_tx_dropped_inc(dev);
> > -		dev_kfree_skb_any(skb);
> > +	if (!master)
> > +		goto drop;
> > +
> > +	skb->dev =3D master->dev;
> > +	if (skb->len > ETH_HLEN * 2) {
>=20
> Try to avoid magic constants
>=20
> sizeof(struct hsr_inline_header + ETH_HLEN is better self-documenting
> that these are two consecutive protocol headers.

okay.

> PF_PACKET sockets also choose an skb->protocol. Even if you don't use
> that as the sole signal that such a header is present, you probably
> want to check it and ignore (or drop) packets with a different than
> the one expected value (ETH_P_1588?).

I have been looking at skb->protocol. This originates from po->num
(packet_snd(), saddr =3D=3D NULL) because userland does bind() with
sll_protocol =3D htons(ETH_P_ALL). This gets then overwritten in
packet_parse_headers() and is set to 0 because hsr_header_ops provides only
->create and ->parse, no ->parse_protocol.=20

So skb->protocol is 0 in xmit. Having eth_header_parse_protocol() would
return ETH_P_1588 in my inline-header case.

So you want something like

	if (skb->protocol =3D=3D ETH_P_1588 && skb->len large_enough)

? Then could drop the ETH_P_1588 header check and just stick the magic
check. Did I understood you correctly?

Regarding skb->protocol assignment.
This was introduced in
e78b2915517e8 ("net: Introduce parse_protocol header_ops callback")
which is from 2019 and hsr_header_ops is from 2013.
Should this be added, and if so should it reflect the "normal" header or
the after the hsr header inner type? I lean towards the ethernet header
but I am not sure about the implications here. So I would assign
eth_header_parse_protocol here.

> > +		struct hsr_inline_header *hsr_opt;
> > +
> > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct eth=
hdr));
> > +		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
>=20
> Need a pskb_may_pull before accessing fields?

I did check the size. Should I use pskb_may_pull() instead of checking
skb->len directly?

=E2=80=A6
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index 0aca859c88cbb..7f92314934c98 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/if_vlan.h>
> > +#include <net/sock.h>
> >  #include "hsr_main.h"
> >  #include "hsr_framereg.h"
> > =20
> > @@ -343,7 +344,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr=
_frame_info *frame,
> >  		hsr_set_path_id(frame, hsr_ethhdr, port);
> >  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
> >  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> > -		return skb_clone(frame->skb_std, GFP_ATOMIC);
> > +		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
> > +		if (frame->req_tx_port !=3D HSR_PT_NONE)
> > +			skb_set_owner_w(skb, frame->skb_std->sk);
>=20
> How is this related to the rest of the patch?

The user sends the data in the skb. Here the skb gets the hsr header
assigned. In the offload case it is simply cloned, in the SW-case
(below) the header is added. The original (submitted) skb is thrown away
while the cloned one is submitted to the networking driver. I needs a
socket assigned or otherwise the requested timestamp is never submitted
to the user.

> > +		return skb;
> >  	}
> > =20
> >  	/* Create the new skb with enough headroom to fit the HSR tag */
=E2=80=A6
> > @@ -697,10 +733,15 @@ static int fill_frame_info(struct hsr_frame_info =
*frame,
> >  	if (port->type =3D=3D HSR_PT_INTERLINK)
> >  		n_db =3D &hsr->proxy_node_db;
> > =20
> > -	frame->node_src =3D hsr_get_node(port, n_db, skb,
> > -				       frame->is_supervision, port->type);
> > -	if (!frame->node_src)
> > -		return -1; /* Unknown node and !is_supervision, or no mem */
> > +	frame->req_tx_port =3D tx_port;
> > +	frame->has_foreign_header =3D has_hsr_header;
> > +
> > +	if (!frame->has_foreign_header) {
> > +		frame->node_src =3D hsr_get_node(port, n_db, skb,
> > +					       frame->is_supervision, port->type);
> > +		if (!frame->node_src)
> > +			return -1; /* Unknown node and !is_supervision, or no mem */
> > +	}
>=20
> This is quite a large patch. Does it make sense to split this
> has_foreign_header into a separate first patch, before the second
> patch that handles the ETH_P_1588 packets?

If it is easier for you, I could try split it in more individual
patches. The skb_set_owner_w() part from above could be its own logical
change. Let me think of something.

Sebastian

