Return-Path: <netdev+bounces-32086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF937922C5
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169A01C2099B
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5CD311;
	Tue,  5 Sep 2023 12:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB663D9
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 12:54:17 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD50B8;
	Tue,  5 Sep 2023 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OeJj+JSjMyHjOYVRVgIa5VnEmjnn/PkxGVs377DiFHc=; b=knYOJUpFOkx/PTFAFCOw7335Um
	kaB4NqGSQPYJljK5ryCqrSJLAXgROfuCFDZ6nxrDaFaMZ2P1OTzLDGsTkXqBZFy/8cWeORqxUBXqD
	9SSx+wiegIGGNbSkeppKPolCEzz53X6z4CI2S6jLv0WwAQnUcyhnevP7n7ElGcVrVF7g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdVZF-005o8p-8n; Tue, 05 Sep 2023 14:54:05 +0200
Date: Tue, 5 Sep 2023 14:54:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [RFC net-next v1 2/2] net: dsa: microchip: ksz9477: Add drive
 strength configuration
Message-ID: <0db96467-958e-4e5a-bd66-fc469316cfbb@lunn.ch>
References: <20230905124340.4116542-1-o.rempel@pengutronix.de>
 <20230905124340.4116542-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905124340.4116542-2-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +static const struct ksz9477_drive_strength ksz9477_drive_strengths[] = {
> +	{ SW_DRIVE_STRENGTH_2MA,  2000 },
> +	{ SW_DRIVE_STRENGTH_4MA,  4000 },
> +	{ SW_DRIVE_STRENGTH_8MA,  8000 },
> +	{ SW_DRIVE_STRENGTH_12MA, 12000 },
> +	{ SW_DRIVE_STRENGTH_16MA, 16000 },
> +	{ SW_DRIVE_STRENGTH_20MA, 20000 },
> +	{ SW_DRIVE_STRENGTH_24MA, 24000 },
> +	{ SW_DRIVE_STRENGTH_28MA, 28000 },

These SW_DRIVE_STRENGTH_ values appear in both ksz8795_reg.h and
ksz9477_reg.h. Can the code be made common?

> +static u32 ksz9477_drive_strength_to_reg(u32 milliamp)
> +{
> +	size_t array_size = ARRAY_SIZE(ksz9477_drive_strengths);
> +	int i;
> +
> +	for (i = 0; i < array_size; i++) {
> +		if (ksz9477_drive_strengths[i].milliamp >= milliamp)
> +			return ksz9477_drive_strengths[i].reg_val;

Normally an exact match is used, not the nearest value.


    Andrew

---
pw-bot: cr


