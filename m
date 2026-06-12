Return-Path: <netdev+bounces-298572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lEzoNfraK2roGQQAu9opvQ
	(envelope-from <netdev+bounces-298572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFE67899F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 12:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jRiP7GPc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298572-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298572-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02DB13183711
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5E3815D1;
	Fri, 12 Jun 2026 10:05:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2D3806C9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:05:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258757; cv=none; b=FUElslcpGPMUY9JHEGyCfuCxyI1o9noSLgRhE3KfckiAZyPbg/sPqclFGlqGTKZBy8sVyqUDXRo7XfDqoItbOLvZZcCkf/9rf8xLKGJDLiLnd2xg1ZuJDd+774ym67un0abC2Ysy2LxcO1tXmygV/t1phfCSU5HU1RcQgg/9fdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258757; c=relaxed/simple;
	bh=CyabT7vF6A9HLsq1nY7xAi5JCpRND0pj096wsCpSbiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnBCSIyXlhBtCwBzVenIxFqA78dcn6pPdRAqVzqX3Nt+1UTwaImiDykX8/a0+KI7J2nsp5NcMBI3VHSts9/ACgfOurcsb9YkPfohrRsK0kdYUdz16S6x8m0CyoQgsXv1Tj+p6fGaXCHj+tN5Oy4H7tJzLlIJlrQkzUWtSIT/XnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRiP7GPc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49C91F000E9;
	Fri, 12 Jun 2026 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781258755;
	bh=QfvrgCTjCv1hUFOScnGK4uwvXbXalciTA91zTL2tazY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jRiP7GPcCONw40WWjnP/MQUJ7jl+wf1DT4Y942aSwlYXUU7s4mR9vxoGrdWQOoNaF
	 nOWEyNqRPfa6fnMmViW5qnqghfjSLr5AHkxJ2I+ZyQq3uOxSi2wo1uNZbP5tgRSpw9
	 h1IxQ+X2mdo21w3n4IiYCIhChffe1xlYi4e9ummzWQuPEI2RF/zJlumcYCdHeIyC3h
	 Qmw5bn2hvstOd1+Kvchh5kG+557OM54U0RMpjupEHt7IcezVUmbq5GCceG0P4SODQP
	 lp9C1Vwcz4tHDW4m5iyTSDMBrq6RCEqhre1wafrX6rmNWXPMpXnsF9qrxCLQVaCArc
	 kE23AQg3KsmDw==
Date: Fri, 12 Jun 2026 12:05:53 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Madhur Agrawal <madhur.agrawal@airoha.com>
Subject: Re: [PATCH net-next v2] net: airoha: Add TCP LRO support
Message-ID: <aivaASdn8t-96aKs@lore-desk>
References: <20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m2UmlyBJec8+Pvm1"
Content-Disposition: inline
In-Reply-To: <20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298572-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url,airoha.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03EFE67899F


--m2UmlyBJec8+Pvm1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add hardware TCP Large Receive Offload (LRO) support to the airoha_eth
> driver, leveraging the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues
> mapped to RX queues 24=E2=80=9331. LRO hw offloading does not support
> Scatter-Gather (SG) so it is required to increase the page_pool allocation
> order to 2 for RX queues 24=E2=80=9331 (LRO queues).
> Since HW LRO is configured per-QDMA and shared across all devices using
> it, LRO is mutually exclusive with multiple active devices on the same
> QDMA block. Call netdev_update_features() on sibling devices in
> ndo_open/ndo_stop so that NETIF_F_LRO availability is re-evaluated when
> the QDMA user count changes.
>=20
> Performance comparison between GRO and hw LRO has been carried out using
> a 10Gbps NIC:
> GRO: ~2.7 Gbps
> LRO: ~8.1 Gbps
>=20
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

commenting on sashiko's report:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260610-airoha-eth-lro=
-v2-1-54be99b9a2d5%40kernel.org

[...]

> =20
> +static int airoha_qdma_lro_rx_process(struct sk_buff *skb,
> +				      struct airoha_qdma_desc *desc)
> +{
> +	u32 desc_ctrl =3D le32_to_cpu(READ_ONCE(desc->ctrl));
> +	u32 len, th_off, tcp_ack_seq, agg_count, data_off;
> +	struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> +	u32 msg1 =3D le32_to_cpu(READ_ONCE(desc->msg1));
> +	u32 msg2 =3D le32_to_cpu(READ_ONCE(desc->msg2));
> +	u32 msg3 =3D le32_to_cpu(READ_ONCE(desc->msg3));
> +	u16 tcp_win, l2_len;
> +	struct tcphdr *th;
> +	bool ipv4, ipv6;
> +
> +	agg_count =3D FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2);
> +	if (agg_count <=3D 1)
> +		return 0;
> +
> +	ipv4 =3D FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
> +	ipv6 =3D FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
> +	if (!ipv4 && !ipv6)
> +		return -EOPNOTSUPP;
> +
> +	l2_len =3D FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
> +	len =3D FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
> +	if (ipv4) {
> +		struct iphdr *iph, _iph;
> +
> +		iph =3D skb_header_pointer(skb, l2_len, sizeof(*iph), &_iph);
> +		if (!iph)
> +			return -EINVAL;
> +
> +		if (iph->protocol !=3D IPPROTO_TCP)
> +			return -EOPNOTSUPP;
> +
> +		if (iph->ihl < 5)
> +			return -EINVAL;
> +
> +		th_off =3D l2_len + (iph->ihl << 2);
> +		if (!pskb_may_pull(skb, th_off))
> +			return -EINVAL;
> +
> +		iph =3D (struct iphdr *)(skb->data + l2_len);
> +		iph->tot_len =3D cpu_to_be16(len - l2_len);
> +		iph->check =3D 0;
> +		iph->check =3D ip_fast_csum((void *)iph, iph->ihl);
> +	} else {
> +		struct ipv6hdr *ip6h;
> +
> +		th_off =3D l2_len + sizeof(*ip6h);
> +		if (!pskb_may_pull(skb, th_off))
> +			return -EINVAL;
> +
> +		ip6h =3D (struct ipv6hdr *)(skb->data + l2_len);
> +		if (ip6h->nexthdr !=3D NEXTHDR_TCP)
> +			return -EOPNOTSUPP;
> +
> +		ip6h->payload_len =3D cpu_to_be16(len - th_off);
> +	}

- The IPv6 path only checks ip6h->nexthdr !=3D NEXTHDR_TCP and does not walk
  extension headers (HBH, Routing, Fragment, Destination Options).=20
  Can this misclassify any IPv6 packet that the HW happens to mark with
  agg_count > 1 and includes extension headers?
  - AFAIK the hw does not aggregate IPv6 packets with extensions headers

- Similarly, the IPv4 path does not consult QDMA_ETH_RXMSG_IP4F_MASK, so
  IPv4 fragments that the HW reports as aggregated would also fall through
  the protocol check.
  - AFAIK the hw does not aggregate IPv4 fragments

- A related observation: this routine is invoked unconditionally for every
  RX packet from airoha_qdma_rx_process(), with no airoha_qdma_is_lro_queue=
(q)
  gate.  Should non-LRO RX queues skip this entirely so that HW corner
  cases on those queues cannot accidentally take this path?
  - LRO will just return agg_count =3D 1 for non LRO queues.

> +
> +	tcp_win =3D FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
> +	tcp_ack_seq =3D le32_to_cpu(READ_ONCE(desc->data));
> +
> +	if (!pskb_may_pull(skb, th_off + sizeof(*th)))
> +		return -EINVAL;
> +
> +	th =3D (struct tcphdr *)(skb->data + th_off);
> +	data_off =3D th_off + (th->doff << 2);
> +	if (len <=3D data_off)
> +		return -EINVAL;
> +
> +	th->ack_seq =3D cpu_to_be32(tcp_ack_seq);
> +	th->window =3D cpu_to_be16(tcp_win);
> +
> +	/* Check tcp timestamp option */
> +	if (th->doff =3D=3D (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
> +		u32 topt;
> +
> +		if (!pskb_may_pull(skb, data_off))
> +			return -EINVAL;
> +
> +		th =3D (struct tcphdr *)(skb->data + th_off);
> +		topt =3D get_unaligned_be32(th + 1);
> +		if (topt =3D=3D ((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> +			     (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
> +			u8 *ptr =3D (u8 *)th + sizeof(*th) + 2 * sizeof(__be32);
> +			__le32 tcp_ts_reply =3D READ_ONCE(desc->tcp_ts_reply);
> +
> +			put_unaligned_be32(le32_to_cpu(tcp_ts_reply), ptr);
> +		}
> +	}

- Is the timestamp echo-reply refresh intentionally limited to the exact
  doff =3D=3D 8 case (12 bytes of options consisting of NOP/NOP/Timestamp)?
  - AFAIU HW LRO can only aggregate TCP segments that belong to the same fl=
ow
    and have the same TCP option layout across all segments.
    The HW can't aggregate segments with variable layout (e.g. SACK) and th=
ey
    will reported with agg_count sets to 1.

> +
> +	shinfo->gso_type =3D ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
> +	shinfo->gso_size =3D (len - data_off) / agg_count;
> +	shinfo->gso_segs =3D agg_count;
> +
> +	return 0;
> +}
> +
>  static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
>  {
>  	enum dma_data_direction dir =3D page_pool_get_dma_dir(q->page_pool);
> @@ -694,9 +836,17 @@ static int airoha_qdma_rx_process(struct airoha_queu=
e *q, int budget)
>  			__skb_put(q->skb, len);
>  			skb_mark_for_recycle(q->skb);
>  			q->skb->dev =3D netdev;
> -			q->skb->protocol =3D eth_type_trans(q->skb, netdev);
>  			q->skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>  			skb_record_rx_queue(q->skb, qid);
> +
> +			if (airoha_qdma_lro_rx_process(q->skb, desc) < 0) {
> +				netdev->stats.rx_dropped++;
> +				dev_kfree_skb(q->skb);
> +				q->skb =3D NULL;
> +				continue;
> +			}

- On a non-zero return from airoha_qdma_lro_rx_process(), this drops the
  entire packet and bumps rx_dropped.  Several of the early returns are
  -EOPNOTSUPP for "this packet is not plain TCPv4/TCPv6", which previously
  would have been delivered up the stack normally.
  Would treating -EOPNOTSUPP as "deliver without GSO marking" be safer
  than dropping?  Otherwise any HW corner case that sets agg_count > 1
  on a non-TCP packet becomes a silent drop visible only as rx_dropped.
  - This is not doable since the hardware has already merged multiple packe=
ts
    into one, the payload contains data from multiple original segments and
    headers have been rewritten.

- A second concern in the same path: on non-LRO scatter-gather queues,
  if a multi-fragment packet's first buffer is dropped here, q->skb is
  left NULL and the next descriptor's buffer enters the "first buffer"
  branch even though it is actually a continuation fragment.  Can this
  lead to the next fragment being treated as a new packet head?
  - This has not been introduced by this patch.

> +
> +			q->skb->protocol =3D eth_type_trans(q->skb, netdev);

[...]

> +static void airoha_update_netdev_features(struct airoha_gdm_dev *dev)
> +{
> +	struct airoha_eth *eth =3D dev->eth;
> +	int i, j;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> +		struct airoha_gdm_port *port =3D eth->ports[i];
> +
> +		if (!port)
> +			continue;
> +
> +		for (j =3D 0; j < ARRAY_SIZE(port->devs); j++) {
> +			struct airoha_gdm_dev *iter_dev =3D port->devs[j];
> +			struct net_device *netdev;
> +
> +			if (!iter_dev || iter_dev =3D=3D dev)
> +				continue;
> +
> +			if (iter_dev->qdma !=3D dev->qdma)
> +				continue;
> +
> +			netdev =3D netdev_from_priv(iter_dev);
> +			if (netdev->reg_state !=3D NETREG_REGISTERED)
> +				continue;
> +
> +			netdev_update_features(netdev);
> +		}
> +	}
> +}
> +
>  static int airoha_dev_open(struct net_device *netdev)
>  {
>  	int err, len =3D ETH_HLEN + netdev->mtu + ETH_FCS_LEN;
> @@ -1778,6 +1970,18 @@ static int airoha_dev_open(struct net_device *netd=
ev)
>  	struct airoha_gdm_port *port =3D dev->port;
>  	u32 cur_len, pse_port =3D FE_PSE_PORT_PPE1;
>  	struct airoha_qdma *qdma =3D dev->qdma;
> +	int qdma_id =3D qdma - &qdma->eth->qdma[0];
> +
> +	/* HW LRO is configured on the QDMA and it is shared between
> +	 * all the devices using it. Refuse to open a second device on
> +	 * the same QDMA if LRO is enabled on any device sharing it.
> +	 */
> +	if (atomic_read(&qdma->users) &&
> +	    airoha_fe_lro_is_enabled(qdma->eth, qdma_id)) {
> +		netdev_warn(netdev, "required to disable LRO on QDMA%d\n",
> +			    qdma_id);
> +		return -EBUSY;
> +	}

- Consider this sequence on a single QDMA:
    1. devA opens, devA enables NETIF_F_LRO via ethtool
       -> airoha_fe_lro_init_rx_queue() programs REG_CDM_LRO_EN
    2. devA closes -> airoha_dev_stop() runs
       airoha_dev_stop() does not call airoha_fe_lro_disable() when
       atomic_dec_and_test(&qdma->users) succeeds, so REG_CDM_LRO_EN bits
       remain set in HW after the last user goes away.
    3. devB opens on the same QDMA
       The guard above evaluates atomic_read(&qdma->users) =3D=3D 0 first, =
so the
       EBUSY branch is short-circuited and devB opens successfully even tho=
ugh
       the HW is still in LRO mode.  devB will then receive HW-aggregated G=
SO
       packets despite NETIF_F_LRO not being set on its features.
    4. devA tries to reopen
       Now atomic_read(&qdma->users) =3D=3D 1 and airoha_fe_lro_is_enabled(=
) still
       returns true, so devA gets EBUSY even though the only "LRO user" is
       stale HW state from its previous incarnation.
       Should airoha_dev_stop() call airoha_fe_lro_disable() when the QDMA
       user count drops to zero, or should the open path reset stale LRO st=
ate
       when users =3D=3D 0?
    - This issue is valid and I will fix in the next revision.

> =20
>  	netif_tx_start_all_queues(netdev);
>  	err =3D airoha_set_vip_for_gdm_port(dev, true);
> @@ -1817,6 +2021,8 @@ static int airoha_dev_open(struct net_device *netde=
v)
>  	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
>  				    pse_port);
> =20
> +	airoha_update_netdev_features(dev);
> +
>  	return 0;
>  }
> =20
> @@ -1876,6 +2082,8 @@ static int airoha_dev_stop(struct net_device *netde=
v)
>  		}
>  	}
> =20
> +	airoha_update_netdev_features(dev);
> +
>  	return 0;
>  }
> =20
> @@ -2154,6 +2362,56 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
>  	}
>  }
> =20
> +static netdev_features_t airoha_dev_fix_features(struct net_device *netd=
ev,
> +						 netdev_features_t features)
> +{
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_qdma *qdma =3D dev->qdma;
> +
> +	if (atomic_read(&qdma->users) > 1)
> +		features &=3D ~NETIF_F_LRO;
> +
> +	return features;
> +}
> +
> +static int airoha_dev_set_features(struct net_device *netdev,
> +				   netdev_features_t features)
> +{
> +	netdev_features_t diff =3D netdev->features ^ features;
> +	struct airoha_gdm_dev *dev =3D netdev_priv(netdev);
> +	struct airoha_qdma *qdma =3D dev->qdma;
> +	struct airoha_eth *eth =3D qdma->eth;
> +	int qdma_id =3D qdma - &eth->qdma[0];
> +
> +	if (!(diff & NETIF_F_LRO))
> +		return 0;
> +
> +	if (features & NETIF_F_LRO) {
> +		int i, lro_queue_index =3D 0;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
> +			struct airoha_queue *q =3D &qdma->q_rx[i];
> +			u32 size;
> +
> +			if (!q->ndesc)
> +				continue;
> +
> +			if (!airoha_qdma_is_lro_queue(q))
> +				continue;
> +
> +			size =3D SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
> +			size =3D min_t(u32, size, CDM_LRO_AGG_SIZE_MASK);
> +			airoha_fe_lro_init_rx_queue(eth, qdma_id,
> +						    lro_queue_index, i, size);
> +			lro_queue_index++;
> +		}
> +	} else {
> +		airoha_fe_lro_disable(eth, qdma_id);
> +	}
> +
> +	return 0;
> +}
> +
>  static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>  				   struct net_device *netdev)
>  {
> @@ -3082,6 +3340,8 @@ static const struct net_device_ops airoha_netdev_op=
s =3D {
>  	.ndo_stop		=3D airoha_dev_stop,
>  	.ndo_change_mtu		=3D airoha_dev_change_mtu,
>  	.ndo_select_queue	=3D airoha_dev_select_queue,
> +	.ndo_fix_features	=3D airoha_dev_fix_features,
> +	.ndo_set_features	=3D airoha_dev_set_features,
>  	.ndo_start_xmit		=3D airoha_dev_xmit,
>  	.ndo_get_stats64        =3D airoha_dev_get_stats64,
>  	.ndo_set_mac_address	=3D airoha_dev_set_macaddr,
> @@ -3169,11 +3429,9 @@ static int airoha_alloc_gdm_device(struct airoha_e=
th *eth,
>  	netdev->ethtool_ops =3D &airoha_ethtool_ops;
>  	netdev->max_mtu =3D AIROHA_MAX_MTU;
>  	netdev->watchdog_timeo =3D 5 * HZ;
> -	netdev->hw_features =3D NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6=
 |
> -			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
> -			      NETIF_F_HW_TC;
> -	netdev->features |=3D netdev->hw_features;
> -	netdev->vlan_features =3D netdev->hw_features;
> +	netdev->hw_features =3D AIROHA_HW_FEATURES | NETIF_F_LRO;
> +	netdev->features |=3D AIROHA_HW_FEATURES;
> +	netdev->vlan_features =3D AIROHA_HW_FEATURES;
>  	SET_NETDEV_DEV(netdev, eth->dev);

- Is NETIF_F_LRO the right feature flag here?
  - I guess it is ok to use NETIF_F_GRO_HW here. I will work on it.

Regards,
Lorenzo

> =20
>  	/* reserve hw queues for HTB offloading */
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ether=
net/airoha/airoha_eth.h
> index 8f42973f9cf5..e78ef751f244 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -44,6 +44,18 @@
>  	 (_n) =3D=3D 15 ? 128 :		\
>  	 (_n) =3D=3D  0 ? 1024 : 16)
> =20
> +#define AIROHA_LRO_PAGE_ORDER		order_base_2(SZ_16K / PAGE_SIZE)
> +#define AIROHA_MAX_NUM_LRO_QUEUES	8
> +#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
> +#define AIROHA_RXQ_LRO_MAX_AGG_COUNT	64
> +#define AIROHA_RXQ_LRO_MAX_AGG_TIME	100
> +#define AIROHA_RXQ_LRO_MAX_AGE_TIME	2000
> +
> +#define AIROHA_HW_FEATURES			\
> +	(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |	\
> +	 NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |	\
> +	 NETIF_F_SG | NETIF_F_TSO | NETIF_F_HW_TC)
> +
>  #define PSE_RSV_PAGES			128
>  #define PSE_QUEUE_RSV_PAGES		64
> =20
> @@ -672,6 +684,18 @@ static inline bool airoha_is_7583(struct airoha_eth =
*eth)
>  	return eth->soc->version =3D=3D 0x7583;
>  }
> =20
> +static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
> +{
> +	struct airoha_qdma *qdma =3D q->qdma;
> +	int qid =3D q - &qdma->q_rx[0];
> +
> +	/* EN7581 SoC supports at most 8 LRO rx queues */
> +	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
> +		     AIROHA_MAX_NUM_LRO_QUEUES);
> +
> +	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
> +}
> +
>  int airoha_get_fe_port(struct airoha_gdm_dev *dev);
>  bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
>  			     struct airoha_gdm_dev *dev);
> diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethe=
rnet/airoha/airoha_regs.h
> index 436f3c8779c1..dfc786583774 100644
> --- a/drivers/net/ethernet/airoha/airoha_regs.h
> +++ b/drivers/net/ethernet/airoha/airoha_regs.h
> @@ -122,6 +122,20 @@
>  #define CDM_CRSN_QSEL_REASON_MASK(_n)	\
>  	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
> =20
> +#define REG_CDM_LRO_RXQ(_n, _m)		(CDM_BASE(_n) + 0x78 + ((_m) & 0x4))
> +#define LRO_RXQ_MASK(_n)		GENMASK(4 + (((_n) & 0x3) << 3), ((_n) & 0x3) =
<< 3)
> +
> +#define REG_CDM_LRO_EN(_n)		(CDM_BASE(_n) + 0x80)
> +#define LRO_RXQ_EN_MASK			GENMASK(7, 0)
> +
> +#define REG_CDM_LRO_LIMIT(_n)		(CDM_BASE(_n) + 0x84)
> +#define CDM_LRO_AGG_NUM_MASK		GENMASK(23, 16)
> +#define CDM_LRO_AGG_SIZE_MASK		GENMASK(15, 0)
> +
> +#define REG_CDM_LRO_AGE_TIME(_n)	(CDM_BASE(_n) + 0x88)
> +#define CDM_LRO_AGE_TIME_MASK		GENMASK(31, 16)
> +#define CDM_LRO_AGG_TIME_MASK		GENMASK(15, 0)
> +
>  #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
>  #define GDM_PAD_EN_MASK			BIT(28)
>  #define GDM_DROP_CRC_ERR_MASK		BIT(23)
> @@ -883,9 +897,15 @@
>  #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
>  #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
>  #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
> +/* RX MSG2 */
> +#define QDMA_ETH_RXMSG_AGG_COUNT_MASK	GENMASK(31, 24)
> +#define QDMA_ETH_RXMSG_L2_LEN_MASK	GENMASK(6, 0)
> +/* RX MSG3 */
> +#define QDMA_ETH_RXMSG_AGG_LEN_MASK	GENMASK(31, 16)
> +#define QDMA_ETH_RXMSG_TCP_WIN_MASK	GENMASK(15, 0)
> =20
>  struct airoha_qdma_desc {
> -	__le32 rsv;
> +	__le32 tcp_ts_reply;
>  	__le32 ctrl;
>  	__le32 addr;
>  	__le32 data;
>=20
> ---
> base-commit: 660a9e399ab02c0cb86d277ed6b0c9d10c350fdd
> change-id: 20260520-airoha-eth-lro-a5d1c3631811
>=20
> Best regards,
> --=20
> Lorenzo Bianconi <lorenzo@kernel.org>
>=20

--m2UmlyBJec8+Pvm1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaivaAAAKCRA6cBh0uS2t
rH/4AQCjKGQYyP2Ov9o0XSFi/UFNHsmnJrl249vghHVOiv3FjAEApKi8epV/Bp8D
weGJgllMC+wxPrs352VhBJoYidbFggY=
=EFPE
-----END PGP SIGNATURE-----

--m2UmlyBJec8+Pvm1--

