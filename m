Return-Path: <netdev+bounces-206170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47FB01D6E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 15:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D7D5A616F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B872D374A;
	Fri, 11 Jul 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b7cf6GZj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019D2D3725;
	Fri, 11 Jul 2025 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240472; cv=none; b=banIK2/G212B4lZFKAK8UDRFZpsBex1MwkE/YDCK+4yoeDMKwc+iZ+10mS0OrcRFx52buH0GSo5EBlwnSai6wXFjAlFpqvde0qGxzLL417HU2X3HGrB6mc7OsioZ4NbUTepn5si08x1GFnXSo2I0Z/LX05baWlqYXvHDj4PPDRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240472; c=relaxed/simple;
	bh=pOnQnmNAGNWqR9/80p5kf8LIfCO3vRiy6jroi1LMAOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMmISSYw13nuYNirr5Ptm/u+j3NHz1ENL9yhKLRtL0jmwubj8ijroGhMCLoYLRgBILDtvqDbBTwn1+glfCI7pELjdMFGl0N/Q7bFG7LRM8n9KuvYlaSMjYWYy5ys+9TYy5toY/Fhg+GmKoqYTFDBNE2VGASS7YItIIbMEYNSR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b7cf6GZj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qDx+vu0/GXtAlNHOTNkLKj70zz6SzlJ2l7+v/wim4vs=; b=b7cf6GZj82AGY/A5JqFH3VGoF5
	IREG4YH7jYhE4YZ9AXcI+oLKzD/9i2KT+9G9T8FcALPUkTcKt4kyfOGOG5X6JPDblZIW+P3uAeUdk
	PY6ocPgLgSAjASFlFsLMwRsopZ29nCoRLopLb7GzRtVdWpWpRRsxF1sg4y8Sa96LY/MQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uaDmx-001Ees-Jv; Fri, 11 Jul 2025 15:27:43 +0200
Date: Fri, 11 Jul 2025 15:27:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Message-ID: <fc6b76d6-d789-4c1d-854d-c2e2f2a66492@lunn.ch>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711065748.250159-2-wei.fang@nxp.com>

> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    oneOf:
> +      - enum:
> +          - system
> +          - ccm_timer
> +          - ext_1588
> +
> +  nxp,pps-channel:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    default: 0
> +    description:
> +      Specifies to which fixed interval period pulse generator is
> +      used to generate PPS signal.
> +    enum: [0, 1, 2]
> +
> +required:
> +  - compatible
> +  - reg

Given that clocks and clock-names are not required, please document
what happens if they are not present.

	Andrew

