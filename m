Return-Path: <netdev+bounces-270325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNvSJqZRwGm3GAQAu9opvQ
	(envelope-from <netdev+bounces-270325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 21:31:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F1A2EAB57
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 21:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE45D3009995
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A785368974;
	Sun, 22 Mar 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="f+SlOw/Y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAB23EAB2;
	Sun, 22 Mar 2026 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774211490; cv=none; b=dHzx+gAkfpzlRvOQ4o9rdknnBAOEHSXLmanXXZ2UM9QKv/oMln14RFHNFYxNfMitPKN2rxOzT/5u7/8sW2Zf0o9SLMnILzYUFh8Wwy4WLWOrOdOOUW3qwwpiXH9CZ63qImPU8imV0Pe4ctTCj6mW+/z2VPxAZ64tOhCclBzYhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774211490; c=relaxed/simple;
	bh=IUa9QJoeD37qm9+5BKx5RW2zaamGwL+qcG6z/rFL3Bw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeC70iFvfN4CG0xW01lCJ7mT5ksiL2/+nCofJkSFIUuZDB13+kemYetYos1okf326PLwCi3P47Ky3vpx4oMym0FDDsDCk8mWeMQcu3vfaUP+qYIWI7nsYFYYuTCQrazEseunbJy1BQHN82TBkv752n/I0osQ9LKqIqyo/Z6adNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=f+SlOw/Y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774211489; x=1805747489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUa9QJoeD37qm9+5BKx5RW2zaamGwL+qcG6z/rFL3Bw=;
  b=f+SlOw/YqtKAWTjz979uoqojbEb06yN1RV3eRkPE/6LQdEVQRT1IaRCq
   262DdTLi2XuSlod5ceQJ7intZqlyYVFRh5uTKHbTy8u6r+ZaQdjwZo/XV
   Pl2LEvjS3ONnVZqQZnpBUlBKsDhJeND1WhtNFn0tyaDYsoJkSgEu679n6
   ZCtuEKkuD7E6T1TCz9AALdtVl30qaDBeG2PuztM0rjYpboIXFzl14QaMY
   cjwIZHSK7PGrvivyKgYBLgpvMiWC+5e1VqKsuUotVJndNtTiJT/ZYquB1
   uzJ70snh/8OkyHFfP00g9j6FVZiF42lvVEZc2nkOCXfBOkduzhdr/UpNC
   A==;
X-CSE-ConnectionGUID: pMzjF3TCSwOumwaJoiDn0w==
X-CSE-MsgGUID: mnaZ3p4xTru3HVT3Nommyg==
X-IronPort-AV: E=Sophos;i="6.23,135,1770620400"; 
   d="scan'208";a="54282255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 13:31:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 22 Mar 2026 13:30:51 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 22 Mar 2026 13:30:48 -0700
Date: Sun, 22 Mar 2026 21:30:47 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 08/10] net: lan966x: add PCIe FDMA XDP support
Message-ID: <20260322203047.4neqananv66unpsp@DEN-DL-M70577>
References: <20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com>
 <20260320-lan966x-pci-fdma-v1-8-ef54cb9b0c4b@microchip.com>
 <ab2f788b-7214-4aa6-bfca-b33d3ab37321@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab2f788b-7214-4aa6-bfca-b33d3ab37321@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F1A2EAB57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mohsin,

> > +static int lan966x_xdp_pci_run(struct lan966x_port *port, void *data,
> > +                            u32 data_len)
> > +{
> > +     struct bpf_prog *xdp_prog = port->xdp_prog;
> > +     struct lan966x *lan966x = port->lan966x;
> > +     struct xdp_buff xdp;
> > +     u32 act;
> > +
> > +     xdp_init_buff(&xdp, lan966x->rx.max_mtu, &port->xdp_rxq);
> > +
> > +     xdp_prepare_buff(&xdp,
> > +                      data - XDP_PACKET_HEADROOM,
> > +                      IFH_LEN_BYTES + XDP_PACKET_HEADROOM,
> > +                      data_len - IFH_LEN_BYTES,
> > +                      false);
> > +
> > +     act = bpf_prog_run_xdp(xdp_prog, &xdp);
> > +     switch (act) {
> > +     case XDP_PASS:
> > +             return FDMA_PASS;
> > +     case XDP_TX:
> > +             return lan966x_fdma_pci_xmit_xdpf(port, data, data_len) ?
> > +                    FDMA_DROP : FDMA_TX;
> 
> What if the BPF program modifies packet boundaries (e.g.,
> headroom/tailroom adjustment)? After bpf_prog_run_xdp(), xdp.data and
> xdp.data_end may differ from the original data and data_len, but
> lan966x_fdma_pci_xmit_xdpf() is called with the original values.
> Wouldn't any adjustments made by the XDP program be silently lost?
>

I think you are absolutely right. Thanks for catching this. Actually, we might
have the same issue in the platform XDP path also.

I will fix this in v2.

> > +     default:
> > +             bpf_warn_invalid_xdp_action(port->dev, xdp_prog, act);
> > +             fallthrough;
> > +     case XDP_ABORTED:
> > +             trace_xdp_exception(port->dev, xdp_prog, act);
> > +             fallthrough;
> > +     case XDP_DROP:
> > +             return FDMA_DROP;
> > +     }
> > +}
> > +

/Daniel

