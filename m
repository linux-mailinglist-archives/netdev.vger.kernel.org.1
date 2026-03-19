Return-Path: <netdev+bounces-269465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFXxJTkIvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61F2CCD2B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17F1F302E105
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70A372B49;
	Thu, 19 Mar 2026 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rH2mlg8I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0gX39Rt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1BA364040
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930377; cv=none; b=txlZnvuwV8eEf22AeXkBpglg88OzKtr5cGP3owp6zVr1EZH/inNkbaIpRiscRh0NsicW9zc6JDST3GrlTXGPDppwBJLK4tWBTcMzhCA6MD1adxYrqHROK6hl77dPFixWiFswF23E8yrMg5FYiqmvxvghi4/2GqB/r/LLLx2iGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930377; c=relaxed/simple;
	bh=NFsudDlAACABBiM2MRvf7ksrssPfnX6id0M0TAlZiSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoyumTGVfZtmUWD+KN6yzYOAzdeCeehNhveo1OcH8IemfSzeqMw3jqAuGsjQJ9ru6sy9poqq7nu2F5+4y8xGk+xP5rfZ0fx9kp4gtH+omG1LyTjfXruwPADrQD462d7aGcetJTr5U9rGLGDh4yinzqZfzvvD3pd5qeKVhU2TR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rH2mlg8I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0gX39Rt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Mar 2026 15:26:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773930374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+Svnijlvd9QAwYqWAu6R8HSWrNYZOqfP34o5gkEIio=;
	b=rH2mlg8I/6dvsOXm+ufcssXyERvnF0RNVuDaC8wEXNNgGuxF8tPRidSZKb1JavNN13mtfd
	PPEvQfMumxJgs+z3fOTgfUpl/hQt3rUGfdJAJng0nDIb/wSLenwtW9HBXKH4hLvUXK8arq
	TuYgbcNj+PpyfwK3KQqVoPxkzXs7+HPQbXSeiEQKHlOTvzYTptXvwu9IdSpFuQKZoc0hy0
	eJbglf6tGG9De9P00zopssViv8k9GvMCb7peG75yfuvhsbBcGLAu7yCVIB5Gx6m25ABAlI
	FwDhCUbGnHheWCp7OTElQUShZyuy2FBZ9qRuBi7IZ9U9Z/oo7RpPyQ9fNF4xAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773930374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+Svnijlvd9QAwYqWAu6R8HSWrNYZOqfP34o5gkEIio=;
	b=C0gX39Rt336BHXXc5XOf+xfM8AcZqrh3vBAfrT6t0u8STLEWr8ukARkp++ydfJo+NTPldU
	zZIAtsGkaM066JDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260319142613.KHz32I-V@linutronix.de>
References: <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.17068ce38efa5@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 5A61F2CCD2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 09:29:44 [-0400], Willem de Bruijn wrote:
> > But here you have PACKET_VNET_HDR_SZ to configure virtio_net_hdr.=20
>=20
> I mean an implicit header in the packet. virtio_net_hdr is something
> that the packet socket needs to inspect. The metadata between ptp4l
> and hsr_dev_xmit is not, so the packet socket can be oblivious to it.

Ah okay. If I insert a header, I would need to scan for something in
every packet and it must not collide with anything that would include
the same sequence. This means the PTP packets from ptp4l and everything
else that sends data. That is something I am not very comfortable with.
Even the destination MAC address had to be changed a few times during
testing so scanning for it would not be good.

> > This
> > is kind of what I ask for with PACKET_HSR_INFO + PACKET_HSR_BIND_PORT
> > (and I added static branches so nobody has to suffer with CONFIG_HSR
> > enabled but no HSR enabled socket)..
> >=20
> > The diff below would be what means to bypass AF_PACKET entirely and use
> > eth0/ eth1 to send via SLAVE_A/ B and hsr0 with SO_MARK to send with
> > system's HSR header but only on one of the two ports.
> > With HSR-offloading enabled we need to attach the SO_MARK hints also on
> > eth0/ eth1 devices, too. Otherwise the offloading part will send the
> > packet on both ports and attach a header (as designed).
>=20
> eth0/eth1 are not HSR devices, so how would they interpret skb->mark
> and how would they loop packets to the other port?

If you look at the diff below, there is the
hsr_skb_get_header_port_mark() helper.

So eth0/ eth1 are not HSR devices but they are used as slaves by hsr0.
The intention is use the eth0/ eth1 devices to pass packets which
include the HSR-header. So if I send on eth0 the intention is to send
the packet 1:1 on this device. The skb->mark is not required there
unless with hardware offload enabled. In this case if "PORT" marker is
used to let the driver know to not duplicate the packet on the other
port and if "HEADER" marker is set then it won't prepend a HSR header.
The port marking is the same as for hsr0 and I used the next bit for the
header to keep things a bit simple.
The skb->mark with values 1=E2=80=A67 is then not available to anything els=
e in
this scenario.

> > diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net=
/ethernet/ti/icssg/icssg_common.c
> > index 79df641b4fb97..a2e50cae01686 100644
> > --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> > +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> > @@ -909,13 +909,17 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buf=
f *skb, struct net_device *ndev
> >  	 */
> >  	dst_tag_id =3D emac->port_id | (q_idx << 8);
> > =20
> > -	if (prueth->is_hsr_offload_mode &&
> > -	    (ndev->features & NETIF_F_HW_HSR_DUP))
> > -		dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> > +	if (prueth->is_hsr_offload_mode) {
> > +		bool has_header;
> > +		bool has_port;
> > =20
> > -	if (prueth->is_hsr_offload_mode &&
> > -	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
> > -		epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> > +		hsr_skb_get_header_port_mark(skb, &has_header, &has_port);
> > +		if (ndev->features & NETIF_F_HW_HSR_DUP && !has_port)
> > +			dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> > +
> > +		if (ndev->features & NETIF_F_HW_HSR_TAG_INS && !has_header)
> > +			epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> > +	}
> > =20
> >  	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
> >  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);

Sebastian

