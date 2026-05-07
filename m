Return-Path: <netdev+bounces-285204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IWIDdBZ/GndOQAAu9opvQ
	(envelope-from <netdev+bounces-285204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:22:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD84E5BBD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 257913001BDE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFD93C343D;
	Thu,  7 May 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g9y4kQ6g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345339B4A1;
	Thu,  7 May 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145726; cv=none; b=fR0HbDanS2YuZbDKNCM/fwFcBj8Lr2VrH6OJze/wtfabyc2nl1phWaC7iNdeytCLFsr6wqFlPoR7cow6/40LmMzKWj9nQkoTXtDbNvDfc3W1zWqcXBefO4kU4W+lmL7O5w4jfOzcwbRUJUWftdd1T8Pj2xeq4Vt+GEvw76MaopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145726; c=relaxed/simple;
	bh=59tWzzAtxTcAUWtxPg7MT4meYExWqFkXq0PcIIC22U8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMxd/oQJ33YdE6AT80qbUT2k+wM4cd20VQCcZEcH9y8wGaH4HccNDBc18BdE5JT0MCOhquPb7Ng5/ApOEn27eSpp2EgUl3G5vR8kASA22Y2VeyOZf5lei7vEqh/VocvZNbwatoxMf8gq9qovSnV2Esysfq0KgzGgbYDB0eEQk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g9y4kQ6g; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778145722; x=1809681722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=59tWzzAtxTcAUWtxPg7MT4meYExWqFkXq0PcIIC22U8=;
  b=g9y4kQ6gFiYW33DsWEzlXYceI0q7j/DgUhmouwckCDRexjobV5GsbPuW
   WqE5GCHsnPQtlwlUub5RI+b7WPI7dGMeYIE7Nc9X8k2lPo4FH7LxnlVq5
   UM7H2b4qx77ZrmgvdXfqIIeyAX/fjfcTrd6TRRkq4JMTJjLGtlZGlsdt1
   aFICESoosTIVJ1nPw0xwRd6ywFc+IPIoiACfR2OVnyXTqlPqn8eZzIKKa
   7Hulup+NQXbykTQRSFwNAla4H/EiVDYElnrCbpzXG4TWx+veu3n7993kK
   6a/xqs+uNGmfqAnuOdDPG13wo5UqOTtfuDmfxCu4G/viyvGho2624N0rs
   A==;
X-CSE-ConnectionGUID: omU3fqXoTGyYlhpuglZLEQ==
X-CSE-MsgGUID: e1bn+2lrSq6R0TTCN/0y/Q==
X-IronPort-AV: E=Sophos;i="6.23,221,1770620400"; 
   d="scan'208";a="57571463"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 02:21:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 02:21:56 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 02:21:53 -0700
Date: Thu, 7 May 2026 11:21:52 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 09/13] net: lan966x: add PCIe FDMA support
Message-ID: <20260507092152.paw7bfv2d2mh5ris@DEN-DL-M70577.microsemi.net>
References: <20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com>
 <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
 <b7399930-ea04-4899-a760-ca1410065aac@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7399930-ea04-4899-a760-ca1410065aac@redhat.com>
X-Rspamd-Queue-Id: C7AD84E5BBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285204-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Action: no action

> On 5/4/26 4:23 PM, Daniel Machon wrote:
> > +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)
> > +{
> > +     struct lan966x *lan966x = rx->lan966x;
> > +     struct fdma *fdma = &rx->fdma;
> > +     struct lan966x_port *port;
> > +     struct fdma_db *db;
> > +     void *virt_addr;
> > +     u32 blockl;
> > +
> > +     /* virt_addr points to the IFH. */
> > +     virt_addr = fdma_dataptr_virt_addr_contiguous(fdma,
> > +                                                   fdma->dcb_index,
> > +                                                   fdma->db_index);
> > +
> > +     lan966x_ifh_get_src_port(virt_addr, src_port);
> > +
> > +     if (WARN_ON(*src_port >= lan966x->num_phys_ports))
> > +             return FDMA_ERROR;
> > +
> > +     port = lan966x->ports[*src_port];
> > +     if (!port)
> > +             return FDMA_ERROR;
> > +
> > +     db = fdma_db_next_get(fdma);
> > +
> > +     /* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> > +      * values before they feed memcpy/XDP sizes.
> > +      */
> > +     blockl = FDMA_DCB_STATUS_BLOCKL(db->status);
> > +     if (blockl < IFH_LEN_BYTES + ETH_FCS_LEN || blockl > fdma->db_size)
> > +             return FDMA_ERROR;
> 
> Pre-existing issues reported by sashiko (most of them actually) can be
> safely ignored/postponed to follow-ups, but the above OOB (and in patch
> 11/13) access looks real and IMHO should be addressed.
> 
> /P
>

This one looks right. The check ought to be: blockl > fdma->db_size -
XDP_PACKET_HEADROOM.

For patch #11, which issue are you referring to? If its the sashiko-gemini
critical issue:

  > +xdp_init_buff(&xdp, fdma->db_size, &port->xdp_rxq);
  >    +
  > +/* Headroom includes the IFH; BPF may grow into it via adjust_he ad.
  > + * The IFH is rebuilt on XDP_TX and unread on XDP_PASS.
  > + */      
  > +xdp_prepare_buff(&xdp,
  > + data - XDP_PACKET_HEADROOM,
  > + XDP_PACKET_HEADROOM + IFH_LEN_BYTES,
  > + data_len,
  > + false);   

Then no, this is a false-positive. The data pointer is already offset by
XDP_PACKET_HEADROOM, so the hard_start lands correctly at offset 0.

/Daniel


