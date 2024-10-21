Return-Path: <netdev+bounces-137584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A429A714B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34370283486
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6001F4FD6;
	Mon, 21 Oct 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HntMsgdZ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897431EF945;
	Mon, 21 Oct 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532805; cv=none; b=QfPNNJ2z+3Dl1/7vM2K9R5WupugIIu2sOoDdxDm8DPfHFt5PVAKOvWsWIiWZrA1vSfTU/3+wAs5s+go8RfaHvEOGzVEg1PbjX0BYDajMIXUGpwkSWt8F5HAW+7c23CSC8LprrU3rcpPTZ54ZeDBhKyb0Vzw55LfUbPCCQyf/l8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532805; c=relaxed/simple;
	bh=FkYnC5v0yIlyNmcCKM8Skrn2LYtpxSulwrdHUBMxZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edz/QDzZXW4TMutK9UPO3p5YPsvCkDO7U1LcFvUfHwuu9JzkQDp6ur3NTowJkr92JNskuBy7tmJrH6dPn3Ae86FlSHeayruzQqIXFwbdSQuT+/P71H6MsdeOdOhUHQ49fk9evBURrxJKSQaYzlh4m4w0LBj17z7MKmrDEq2SchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HntMsgdZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00B1E240002;
	Mon, 21 Oct 2024 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729532800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRPQmmO/50SbRRQK3oyXv/+1GlUkCXtzEQvhddj1OlI=;
	b=HntMsgdZV5oJvoNH/bqbRjpeNglhghLXtIXNpaFxT+p37UiHNve+rdvbL+pt/zzWWmJezU
	OILXE0sGpm4H4D5UpmOmv9Ncwf0LMXp1D3GjydiNbRLSkQIgL4KgYL3sJgtOrBYYV4w/9M
	Ap8OpgxRmhOvrqrZ4GyouPXYIZe8E4tIjlVgZKaygkRNIoFpoT2cnb7A/5/buOGqFndxzI
	s3/OW+8fclB6lgQF1MmYPIe3tPj72pEKNi0MsJWb+1tN85+9QC4oCT+GABunePGwqeLaUp
	v8M6ReWU084fWe50b3CA1ZNHGlgaEpIHn1C2dlCLCg+r8arzvFrW2HlYdtf6+A==
Date: Mon, 21 Oct 2024 19:46:38 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>,
 <Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
 <ast@fiberby.net>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 10/15] net: lan969x: add PTP handler function
Message-ID: <20241021194638.585a9870@device-21.home>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-10-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
	<20241021-sparx5-lan969x-switch-driver-2-v1-10-c8c49ef21e0f@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Daniel,

On Mon, 21 Oct 2024 15:58:47 +0200
Daniel Machon <daniel.machon@microchip.com> wrote:

> Add PTP IRQ handler for lan969x. This is required, as the PTP registers
> are placed in two different targets on Sparx5 and lan969x. The
> implementation is otherwise the same as on Sparx5.
> 
> Also, expose sparx5_get_hwtimestamp() for use by lan969x.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

[...]

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> index 15f5d38776c4..3f66045c57ef 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
> @@ -114,6 +114,8 @@ enum sparx5_vlan_port_type {
>  #define SPX5_DSM_CAL_LEN               64
>  #define SPX5_DSM_CAL_MAX_DEVS_PER_TAXI 13
>  
> +#define SPARX5_MAX_PTP_ID	512
> +

Sorry if I somehow missed it, but if you define SPARX5_MAX_PTP_ID here,
you probably don't need it to be also defined in sparx5_ptp.c as well ?

Thanks,

Maxime

