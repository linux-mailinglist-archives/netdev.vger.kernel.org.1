Return-Path: <netdev+bounces-275252-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL26Gyg/0GkL5QYAu9opvQ
	(envelope-from <netdev+bounces-275252-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:28:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA3398BE2
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 445BF302D597
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8086E364947;
	Fri,  3 Apr 2026 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="eHE8Jc4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD612765D7;
	Fri,  3 Apr 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775255330; cv=none; b=qWO091Cxc31tVfJKlwmSyGdSgM2iquL9q6U9zOpfiJ80W1Ad2I6hum3SXCUA+KDo3I7NyPK1i+2rtKElnSbUTuswEAnvsJqHGz1//QeBDTi2ah5rv48ffU/L8qr39Tsc18V1n5U2uj0lmGwDXEbb6HW4X6kwpKOFix7b10RGjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775255330; c=relaxed/simple;
	bh=X3zco+XvVhWpTCZMpFuVqN5WeEOytgRz8E3bdKkvgaM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NisYsPyOedOYd3RoToKQmyLtclLhoDMbJ2IymJZ2OXovq1I5uF0Ec22kETpx6EU6X53K5pLcByhQmYIvsDJ6iBcQ7XHlYDHcie+f2lfRdG/LQGXBYJe0vy2LAD0nb0tLr74jPhqY+hazkf3z+e79itr3eIP20gDsZG9cVPkgMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=eHE8Jc4H; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8ECBFA587E;
	Sat,  4 Apr 2026 00:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775255326; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7YzsoARFzCOSqfo/cEvzh2PgtShoqkpEQjef7RRbDNg=;
	b=eHE8Jc4HwkoCAywnc7Zeq8zQujHlItD2zXiL7vjvdXkoi97POHp+ERCScWeNCt+Z//7Ztk
	C7p4eagLNsxCC9NatVlKg6oLX1wQ3wv5M83OZCkfDbkxx/BQO37XbSF8vN1x+gN6JQXaI0
	3Y6vHX2CjX/KiSC/zKZ9v4uElHe9xTFwwu3J2r0/ThYUE1C5kyR2J2aVrxPAU6T7rLsTTj
	xgFDK43Ln4/VZXA5H8f0Ni5Uj82fFBFGcTBQkpeK8p5rLpp6jtms29hUlwAMPbuyd7zI0M
	ncWqMt9VOtzYN/MFNtKaWhFYAsrEL6gZjAm8OexMrJgeoYDT8dr+18+0lnxA5w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 04 Apr 2026 00:28:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade
 <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
In-Reply-To: <20260403-b4-var-som-om44-lan7500-v1-2-0dadde850143@bootlin.com>
References: <20260403-b4-var-som-om44-lan7500-v1-0-0dadde850143@bootlin.com>
 <20260403-b4-var-som-om44-lan7500-v1-2-0dadde850143@bootlin.com>
Message-ID: <c7214f0bc4eb2129cb8e8fd8f41958a4@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275252-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.3:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.1:email]
X-Rspamd-Queue-Id: D6FA3398BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3.4.2026 21:02, Thomas Richard wrote:
> Add USB tree description, including the Gigabit Ethernet controller
> (LAN7500). Adding the LAN7500 node will allow the bootloader to patch 
> the
> devicetree and set the MAC address.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>  arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi 
> b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
> index 
> 37d56b3010cff0f6ea6208289da0aba7328067d5..9e04aa70f98227ac0054fea6cd4521ed1323ecbd 
> 100644
> --- a/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/omap4-var-som-om44.dtsi
> @@ -322,4 +322,18 @@ &usbhshost {
> 
>  &usbhsehci {
>  	phys = <&hsusb1_phy>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	usbhub: hub@1 {
> +		compatible = "usb424,2514";
> +		reg = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethernet: ethernet@3 {
> +			compatible = "usb424,7500";
> +			reg = <3>;
> +		};
> +	};
>  };

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai

