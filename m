Return-Path: <netdev+bounces-44451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBE7D8024
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D41B212A8
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A092AB2B;
	Thu, 26 Oct 2023 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEt5wwqI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3C2D021;
	Thu, 26 Oct 2023 09:58:09 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE7A93;
	Thu, 26 Oct 2023 02:58:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso108604466b.2;
        Thu, 26 Oct 2023 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698314286; x=1698919086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KIvM94Zo8czLYhdT3nLKb2AOCp1EA16AmR4SZgO/t4=;
        b=NEt5wwqImRgDWauETNXA/+jsOSV/bAbMRs4dBNT7cfzWdx6QEOBGMXqbrgyAjDGy/7
         Hr9JirvRT5DeB6wZfZ6tFtvh9+aMKdz7LKsU/V/4veYb/hrLGwTOZcYx0j/J62qKbdCI
         tgxAWfn0AcXuPISxqqeOb3c+A/drBmfflaVr8CIp8AsKrVmO4mKs0Qff6pZjy3qj5Ufx
         akde5aojA3aLHl9v2oqO/xEY24bE5/MRAyy91q4GxUv6JkMl51fQvz7Cr7LM7t0FF4Ta
         4oVAXDsKgxccPbXQUYIZJ88yjf8oQb3C0qjyh3wkkYFIj6pdg97BC+vfV2BLoa3OT7Ov
         BGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314286; x=1698919086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KIvM94Zo8czLYhdT3nLKb2AOCp1EA16AmR4SZgO/t4=;
        b=N6vRd4e+QkIhSCtbz710e7guKNQqMixRqqstFYofbnCo5PmPLUVkSrdVmab5CD043r
         jVTqUZzOfniG8z6M0svhE2+9DL91aEwiF01MKwU0RV+OpS+6/jCaWDOEGssY5KYJppzd
         miIfeWIchzju/tbiR7AXQa/BqMbhUBP7wL8JA3tD9preyX65pTf55SwbZuNoriSDTFck
         jBBv358uk50rRhLvh+3F939MEMr2fFAUUY3d+KO5TOCnbGLc7xH2dxq7pSZUyRFYW76P
         3tT3pucZESR8AC8LX/p8NInXjAqMcKyxSWjTgzBYiJsJnVwX5D1OIKNvz4vo6wuH+eWq
         4aMQ==
X-Gm-Message-State: AOJu0Yxsc9ddX5Qn72I2jkBotTlthOpTN9FGgWhvndp2QFmY6tN8Vb8b
	JtdHVbuPOPbBMhlA4Ml+qU8=
X-Google-Smtp-Source: AGHT+IFCQqAufKA0LjuOtRNshjlN3m4ejifcXJ3YvxW+ZdXdN/W0E5ZaHeHdmKDkFOFggdRCPQmqFw==
X-Received: by 2002:a17:907:841:b0:9c7:3611:9e7c with SMTP id ww1-20020a170907084100b009c736119e7cmr13848003ejb.61.1698314286213;
        Thu, 26 Oct 2023 02:58:06 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906088d00b0098ec690e6d7sm11396113eje.73.2023.10.26.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:58:05 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:58:03 +0300
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
Subject: Re: [PATCH net-next v8 1/5] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231026095803.a54uni73ugwm33sg@skbuf>
References: <20231026051051.2316937-1-o.rempel@pengutronix.de>
 <20231026051051.2316937-1-o.rempel@pengutronix.de>
 <20231026051051.2316937-2-o.rempel@pengutronix.de>
 <20231026051051.2316937-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026051051.2316937-2-o.rempel@pengutronix.de>
 <20231026051051.2316937-2-o.rempel@pengutronix.de>

On Thu, Oct 26, 2023 at 07:10:47AM +0200, Oleksij Rempel wrote:
> Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> driver.
> 
> Major changes include:
> 
> 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
>    Packet wake events alongside existing wake reasons.
> 
> 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
>    handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
>    program the switch's MAC address register accordingly when Magic
>    Packet wake-up is enabled. This change will prevent WAKE_MAGIC
>    activation if the related port has a different MAC address compared
>    to a MAC address already used by HSR or an already active WAKE_MAGIC
>    on another port.
> 
> 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
>    address changes on ports with active Wake on Magic Packet, as the
>    switch's MAC address register is utilized for this feature.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

