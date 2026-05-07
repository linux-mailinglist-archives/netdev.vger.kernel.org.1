Return-Path: <netdev+bounces-285308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KvMA6eF/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257C4E830A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17AA7300B9DA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4243BE16E;
	Thu,  7 May 2026 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MY/2xBVp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAA3B7744;
	Thu,  7 May 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156961; cv=none; b=WJ6psgaFJokayiZRcXVx4KVn6LXj8N7r3DY1WIJlsWQJnsAekN7O8ybVsymfM6mQNj4M7Pjapb42RIx/7d6NJUUo/GA55i0afuqHm6M4JxTgM4F5l5AGWZlGRpktoynm2EWd6fLSKdA4fXlI59459Lp06DDV7sUF1LLro/QG1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156961; c=relaxed/simple;
	bh=Y++sXmlSsHai8PAxrMnUKMOgyR38lU9i2YrXRraFovs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYbp1L1UzOgzsO96MfWajMJ9Gr9hxhFElP35LHJuQfy+/dXEYtoXPgkc/bymc8egHx8X677lKuPPpbtK+EHmdPtjrkRbfFcZmbO1zek5hPg4YL1uLDxBWJFwRuXwQEjaQUdFB1JPn9vfdmxZQz28FxzHaf9PzM0H+QqjpFhmSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MY/2xBVp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LmEIVv5Hxh+mKmeuHsN7vP/fAMiciYkPlIj13WZ+oiE=; b=MY/2xBVpjxX2ZXH6RhO3LIF2+N
	x4csJK/N/xl92PKhwsmp0UjPRbRm/Rrtz4SozNtBf6AqtO5BJoH769H2UhBcDCNP470yRW+O/UVsa
	pyds4D5Cno6Z40QB5+xOuQhW+Sr4uB2BZ2Pl5t32AxN2j3/AVfxPOL/DF5VxOthAVWf0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxqo-001oGr-6c; Thu, 07 May 2026 14:29:10 +0200
Date: Thu, 7 May 2026 14:29:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH net v1 1/2] dt-bindings: ethernet: eswin: refine delay
 model and HSP register description
Message-ID: <2436c6e9-4aad-4ffd-9fef-0cbbe38dc66d@lunn.ch>
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083136.175-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507083136.175-1-lizhi2@eswincomputing.com>
X-Rspamd-Queue-Id: 0257C4E830A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-285308-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23]
X-Rspamd-Action: no action

>      ethernet@50400000 {
>          compatible = "eswin,eic7700-qos-eth", "snps,dwmac-5.20";
>          reg = <0x50400000 0x10000>;
> -        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> -                <&d0_clock 193>;
> -        clock-names = "axi", "cfg", "stmmaceth", "tx";
>          interrupt-parent = <&plic>;
>          interrupts = <61>;
>          interrupt-names = "macirq";
> -        phy-mode = "rgmii-id";
> -        phy-handle = <&phy0>;
> +        clocks = <&d0_clock 186>, <&d0_clock 171>, <&d0_clock 40>,
> +                <&d0_clock 193>;
> +        clock-names = "axi", "cfg", "stmmaceth", "tx";

Please don't move the clocks around, since they have nothing to do
with RGMII delays.


>          resets = <&reset 95>;
>          reset-names = "stmmaceth";
> -        rx-internal-delay-ps = <200>;
> -        tx-internal-delay-ps = <200>;
> -        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118>;
> -        snps,axi-config = <&stmmac_axi_setup>;
> +        eswin,hsp-sp-csr = <&hsp_sp_csr 0x100 0x108 0x118 0x114 0x11c>;
> +        phy-handle = <&phy0>;
> +        phy-mode = "rgmii-id";
>          snps,aal;
>          snps,fixed-burst;
>          snps,tso;
> -        stmmac_axi_setup: stmmac-axi-config {
> +        snps,axi-config = <&stmmac_axi_setup_gmac0>;
> +
> +        stmmac_axi_setup_gmac0: stmmac-axi-config {

And what do these changes have to do with RGMII delays?

    Andrew

---
pw-bot: cr

