Return-Path: <netdev+bounces-42741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE287D0075
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A88C282206
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625832C90;
	Thu, 19 Oct 2023 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggqdpCBS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CFE32C76;
	Thu, 19 Oct 2023 17:25:20 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF685CF;
	Thu, 19 Oct 2023 10:25:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507c50b7c36so3740205e87.3;
        Thu, 19 Oct 2023 10:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697736317; x=1698341117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tnjx/g75TQ9FU2jTkV4DiWvBfVCxrF8QEzTIbCBryMQ=;
        b=ggqdpCBS0pmk74rY44ASsOdZskI/M/PydYRYE2HvSeqBtfe1j3kkVtg1ScM5Pucbpo
         8TbmeMeR8UQ7VTlmXp99WSl4d4fiOaH7xOhfNwLWFpt3nzBATYouaxggGGANIq/iZ6RI
         OlLcdG7FxSwEKztXYf6A11VcM0srGzht1Rd2cbT8ZeiUq3E9hiZwD9ddzU4/gd97v4RV
         RwcmtzPhbPENn7DWY62/HqNTCWm2lyVw1B0QgAr8MLmvCV8L6lanDD6Z/Bd8EByBeJ36
         Av2c7CP1ol+sR+ZyJ+FIeSXWsdHCT3E4s03RupQ9Pqnadh2XpYN1Ou+E6WGS0V+EDNp0
         McJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697736317; x=1698341117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnjx/g75TQ9FU2jTkV4DiWvBfVCxrF8QEzTIbCBryMQ=;
        b=iez58jUOVrof/aieTBs3RvXWXS25Zk/tnRn3vp5DIihYzHNXk2bDtJRl/96aF9TPwn
         IAkS4XIVSSwAE1rIthfIAxfpGuLdceQo7HIFM+nvSU827KiGeL7XjhYoqT1kmMNmc7ME
         qhuYBPgID6GW/U6VfmepRd/J91b5upFpGqsKLoE7s9D4neYNLEVdKJJGr4X0RRRgavNr
         Wlhu/mhjlC//A5Ms3Hcfg4Eu7GNO9VnAndvehWN3KDo28EPRYVqCHgaHdCgisxUHzyVm
         tB/TFkkR880sf9OQdh6GixtcR25Tfk1RmFwP0V2h6Klx4gUIUgLu8jw2dzg/RHM8Pzvz
         SpDg==
X-Gm-Message-State: AOJu0Yy3NM14KmujbwB0f4YBaWgVHhOfZb9nCYRGfEsy0IYnQFB+3dpa
	TQmrTWVX4lRrg61WujNt80E=
X-Google-Smtp-Source: AGHT+IETtCAH69WjFxmrGsal06d2Gb/GBtC8Q7aVDLCgATNOxTvvOolcROpJV0weAOLvi7PuIFa0BA==
X-Received: by 2002:a05:6512:515:b0:504:30eb:f2ac with SMTP id o21-20020a056512051500b0050430ebf2acmr1955852lfb.68.1697736316689;
        Thu, 19 Oct 2023 10:25:16 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id fj27-20020a0564022b9b00b005309eb7544fsm4752188edb.45.2023.10.19.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 10:25:16 -0700 (PDT)
Date: Thu, 19 Oct 2023 20:25:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 8/9] net: dsa: microchip: Refactor switch
 shutdown routine for WoL preparation
Message-ID: <20231019172513.el67tdxnmcfc7l2g@skbuf>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-9-o.rempel@pengutronix.de>
 <20231019122850.1199821-9-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019122850.1199821-9-o.rempel@pengutronix.de>
 <20231019122850.1199821-9-o.rempel@pengutronix.de>

On Thu, Oct 19, 2023 at 02:28:49PM +0200, Oleksij Rempel wrote:
> Centralize the switch shutdown routine in a dedicated function,
> ksz_switch_shutdown(), to enhance code maintainability and reduce
> redundancy. This change abstracts the common shutdown operations
> previously duplicated in ksz9477_i2c_shutdown() and ksz_spi_shutdown().
> 
> This refactoring is a preparatory step for an upcoming patch to avoid
> reset on shutdown if Wake-on-LAN (WoL) is enabled.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

