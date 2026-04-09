Return-Path: <netdev+bounces-276986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFZjLYug12kUQQgAu9opvQ
	(envelope-from <netdev+bounces-276986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:50:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C64DC3CA9EF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77DF304CE85
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9B63CE4B2;
	Thu,  9 Apr 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EYWgZCsG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9E3CE48C;
	Thu,  9 Apr 2026 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738812; cv=none; b=HVEWqkd7ew4s8VUQlBN4kqjejtkxUYJYZK7X3qf7Vql4y5Msh94p/hIGCKsFloP/EaLJ7nNhAC293MjQM63dWaF5jojYmMfu28KpIdTTaFocfcVokKx9db4lmiEW8ANsMR5MJKKezeiMkE2aDhXzWlQH9GTqiz4lwPhMQ94nvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738812; c=relaxed/simple;
	bh=2L6LKGM//lOCZObxlxh84VVtVUTrFvbwgQHqvFakwo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN9fnZDDuhQ2iq80/7b/7OfXbNN1sQcq0Me0ZqMGv1+IwU0f7V7mh1FX64MjBqvMTTOkYlGSgKmFLCh6wraNb1HNmkGgE0KFSZ+P71GnW9BpyafExGmd1EES619c/ifZRCxaAFhJwCk4B2YCCcKmXet6hmKvfiDo16870OMTZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EYWgZCsG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LzBWU5lPTgaIQwywPaNh1ueqepBz9byfm3c/htVgcPM=; b=EYWgZCsGZu1QCHFNahcoR94fBw
	CmCWfpDniiWFgHRTQXcYrGVkgixrT4c9d/cv5V8wUxYO7pfeHwLi6Yf5nKpn8CO9ZmrW+TfU+SAok
	J8wsI5mHiPLjhCX4h3A4Y3ijTnSC8TUf3yyNo8R6cZ8u5RCD1YA0KB1itpFhDOIthNjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAomQ-00FQtj-Lq; Thu, 09 Apr 2026 14:46:42 +0200
Date: Thu, 9 Apr 2026 14:46:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Message-ID: <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276986-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C64DC3CA9EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +&eqos {
> +	/* delays are added by connected ethernet-switch cpu port */
> +	phy-mode = "rgmii";
> +	pinctrl-0 = <&eqos_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	fixed-link {
> +		full-duplex;
> +		speed = <1000>;
> +	};
> +};


> +	ethernet-switch@0 {
> +		compatible = "nxp,sja1110a";
> +		reg = <0>;
> +		reset-gpios = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> +		spi-max-frequency = <4000000>;
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/* 100Base-TX on connector J26 */
> +			port@1 {
> +				reg = <0x1>;
> +				label = "lan1";
> +				phy-handle = <&switch_port1_base_tx_phy>;
> +				phy-mode = "internal";
> +				status = "okay";
> +			};
> +
> +			/* CPU */
> +			port@2 {
> +				reg = <0x2>;
> +				ethernet = <&eqos>;
> +				label = "cpu";
> +				phy-mode = "rgmii-id";
> +				rx-internal-delay-ps = <2000>;
> +				tx-internal-delay-ps = <2000>;
> +				status = "okay";
> +
> +				fixed-link {
> +					full-duplex;
> +					speed = <1000>;
> +				};
> +			};
> +
> +			/* sgmii on addon board connector J21 */
> +			port@3 {
> +				reg = <0x3>;
> +				label = "lan3";
> +				status = "disabled";
> +			};
> +
> +			/* sgmii on addon board connector J21 */
> +			port@4 {
> +				reg = <0x4>;
> +				label = "lan4";
> +				status = "disabled";
> +			};
> +
> +			/* 100base-t1 on addon board connector J21 */
> +			port@5 {
> +				reg = <0x5>;
> +				label = "trx1";
> +				phy-handle = <&switch_port5_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "disabled";
> +			};
> +
> +			/* 100base-t1 on addon board connector J21 */
> +			port@6 {
> +				reg = <0x6>;
> +				label = "trx2";
> +				phy-handle = <&switch_port6_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "disabled";
> +			};
> +
> +			/* 100base-t1 on addon board connector J21 */
> +			port@7 {
> +				reg = <0x7>;
> +				label = "trx3";
> +				phy-handle = <&switch_port7_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "disabled";
> +			};
> +
> +			/* 100base-t1 on addon board connector J21 */
> +			port@8 {
> +				reg = <0x8>;
> +				label = "trx4";
> +				phy-handle = <&switch_port8_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "disabled";
> +			};
> +
> +			/* 100base-t1 on addon board connector J21 */
> +			port@9 {
> +				reg = <0x9>;
> +				label = "trx5";
> +				phy-handle = <&switch_port9_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "disabled";
> +			};
> +
> +			/* 100Base-T1 on connector J26 */
> +			port@a {
> +				reg = <0xa>;
> +				label = "trx6";
> +				phy-handle = <&switch_port10_base_t1_phy>;
> +				phy-mode = "internal";
> +				status = "okay";
> +			};
> +		};
> +
> +		mdios {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			mdio@0 {
> +				compatible = "nxp,sja1110-base-t1-mdio";
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* 100base-t1 on addon board connector J21 */
> +				switch_port5_base_t1_phy: ethernet-phy@1 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x1>;
> +					status = "disabled";
> +				};
> +
> +				/* 100base-t1 on addon board connector J21 */
> +				switch_port6_base_t1_phy: ethernet-phy@2 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x2>;
> +					status = "disabled";
> +				};
> +
> +				/* 100base-t1 on addon board connector J21 */
> +				switch_port7_base_t1_phy: ethernet-phy@3 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x3>;
> +					status = "disabled";
> +				};
> +
> +				/* 100base-t1 on addon board connector J21 */
> +				switch_port8_base_t1_phy: ethernet-phy@4 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x4>;
> +					status = "disabled";
> +				};
> +
> +				/* 100base-t1 on addon board connector J21 */
> +				switch_port9_base_t1_phy: ethernet-phy@5 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x5>;
> +					status = "disabled";
> +				};
> +
> +				/* 100Base-T1 on connector J26 */
> +				switch_port10_base_t1_phy: ethernet-phy@6 {
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x6>;
> +				};
> +			};
> +
> +			mdio@1 {
> +				compatible = "nxp,sja1110-base-tx-mdio";
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* 100Base-TX on connector J26 */
> +				switch_port1_base_tx_phy: ethernet-phy@1 {
> +					reg = <0x1>;
> +				};
> +			};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

