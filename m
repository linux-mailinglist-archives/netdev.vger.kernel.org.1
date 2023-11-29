Return-Path: <netdev+bounces-51965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD6E7FCCDA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AAB28325F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 02:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD533D8E;
	Wed, 29 Nov 2023 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfuAwZZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B12710FC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:23:44 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4079ed65582so45847505e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 18:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701224622; x=1701829422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rV1Gnc/xnQkWh00He5omWJrEfUz1cle6tqm1kO4uq9I=;
        b=gfuAwZZg73XM9dtdInAqYOoz5G9AE/+wMu0NGul3epRQDtCD5eLF/7ddnPyBK6ClyZ
         NyJl+xYAIphghH6SGkX/KihGlYAGPftz7V60BnOyLv70HHYQY2pWjtsQ0f46+hj+pgOH
         moomOdZ9Wsp1pkwzomN2KLfGayRUneW708JQ9ehs5NX9OIokT5A/EH68lEJ7pz63hCTi
         ju27SSMk1ON3GYuwE7XYAm1vhmBzZBRjMcAtiCO5H8/vv/p7CW1NycCHUlxW2LJa1LFc
         DVc1FbA2RH9PKX9LXhYWEL266YsOWLNwQGgCi5LM8hBwis36ZpP4fxqv++guYOjK8Hoy
         rksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701224622; x=1701829422;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV1Gnc/xnQkWh00He5omWJrEfUz1cle6tqm1kO4uq9I=;
        b=DzRUz6vI52FDQnjZrQqYzlhiRqOih9R11rWTIBa8fXOqoBmoE0rd6WPz7H6UMlBb4+
         dN0RG5YkS804nm83luY8QzMUnwvesBrTJpU8wMQNK9DSlVSlmVKfKObR26VxLJ4r9psD
         j1cxyEToO96iF8VHtwanqK7ONnZReHj1+iyeC63fldR8I1TJO2vjMjvm9L+B/3S3plMb
         HikeMIsxmqgFJea54ZFjINCoSFHQPFRWV/rt2tLa4a1qrBo+Liv89Q/nDIOD6H7nZzPy
         JIoqypD0La+IcYCVcl/ssuWnaEza52G1AZj4R5a7oqfjo1XREvBCmVO3kSg1pG8P7x2F
         368w==
X-Gm-Message-State: AOJu0YybfYUH84NM36JZ+/9OT/kLihrKhYRxzJTa3SnnTUoTLvjE4kwn
	Rc+5k25ArewQlWeM2zfrsQE=
X-Google-Smtp-Source: AGHT+IHTm7LsPfkLD8g09vx2zPx8xzjWUbqcb6IfIHr7h7FX+zsUCvCp4Wy6TBK0H//MxbNxCGfAbQ==
X-Received: by 2002:a05:600c:474d:b0:40b:3802:6ef8 with SMTP id w13-20020a05600c474d00b0040b38026ef8mr11950876wmo.34.1701224622330;
        Tue, 28 Nov 2023 18:23:42 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm341953wms.12.2023.11.28.18.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 18:23:42 -0800 (PST)
Message-ID: <6566a0ae.050a0220.c197.0f51@mx.google.com>
X-Google-Original-Message-ID: <ZWagrLFzDWkaAaqX@Ansuel-xps.>
Date: Wed, 29 Nov 2023 03:23:40 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH RFC net-next 8/8] dsa: qca8k: Use DSA common code for LEDs
References: <20231128232135.358638-1-andrew@lunn.ch>
 <20231128232135.358638-9-andrew@lunn.ch>
 <65669a29.5d0a0220.19703.34e3@mx.google.com>
 <53a2be7c-731c-4a27-87be-8c42b26ce9a4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a2be7c-731c-4a27-87be-8c42b26ce9a4@lunn.ch>

On Wed, Nov 29, 2023 at 03:16:16AM +0100, Andrew Lunn wrote:
> > Hi,
> > 
> > I attached a fixup patch for this to correctly work. Since we are using
> > port_num the thing needs to be decrememted by one.
> 
> I thought this might happen.
> 
> How about this fix instead? It fits better with the naming of
> parameters, and just does the offset once for each API function.
>

Yep also works. My idea was to act on the function that parse the
port_num and gives regs and mask to prevent problem in the future but I
don't think it will change that much.

With your proposed fix,

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

> 
> From 0789b95345bfa5086365051f95531fdb3d053e3e Mon Sep 17 00:00:00 2001
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Tue, 28 Nov 2023 20:11:42 -0600
> Subject: [PATCH] dsa: qca8k: Fix off-by-one for LEDs.
> 
> ---
>  drivers/net/dsa/qca/qca8k-leds.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
> index febae23b65a9..0aa209b84251 100644
> --- a/drivers/net/dsa/qca/qca8k-leds.c
> +++ b/drivers/net/dsa/qca/qca8k-leds.c
> @@ -80,9 +80,10 @@ qca8k_parse_netdev(unsigned long rules, u32 *offload_trigger)
>  }
>  
>  int
> -qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
> +qca8k_led_brightness_set(struct dsa_switch *ds, int port,
>  			 u8 led_num, enum led_brightness brightness)
>  {
> +	int port_num = qca8k_port_to_phy(port);
>  	struct qca8k_led_pattern_en reg_info;
>  	struct qca8k_priv *priv = ds->priv;
>  	u32 mask, val;
> @@ -140,11 +141,12 @@ qca8k_led_brightness_set(struct dsa_switch *ds, int port_num,
>  }
>  
>  int
> -qca8k_led_blink_set(struct dsa_switch *ds, int port_num, u8 led_num,
> +qca8k_led_blink_set(struct dsa_switch *ds, int port, u8 led_num,
>  		    unsigned long *delay_on,
>  		    unsigned long *delay_off)
>  {
>  	u32 mask, val = QCA8K_LED_ALWAYS_BLINK_4HZ;
> +	int port_num = qca8k_port_to_phy(port);
>  	struct qca8k_led_pattern_en reg_info;
>  	struct qca8k_priv *priv = ds->priv;
>  
> @@ -231,9 +233,10 @@ qca8k_led_hw_control_is_supported(struct dsa_switch *ds,
>  }
>  
>  int
> -qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
> +qca8k_led_hw_control_set(struct dsa_switch *ds, int port, u8 led_num,
>  			 unsigned long rules)
>  {
> +	int port_num = qca8k_port_to_phy(port);
>  	struct qca8k_led_pattern_en reg_info;
>  	struct qca8k_priv *priv = ds->priv;
>  	u32 offload_trigger = 0;
> @@ -255,9 +258,10 @@ qca8k_led_hw_control_set(struct dsa_switch *ds, int port_num, u8 led_num,
>  }
>  
>  int
> -qca8k_led_hw_control_get(struct dsa_switch *ds, int port_num, u8 led_num,
> +qca8k_led_hw_control_get(struct dsa_switch *ds, int port, u8 led_num,
>  			 unsigned long *rules)
>  {
> +	int port_num = qca8k_port_to_phy(port);
>  	struct qca8k_led_pattern_en reg_info;
>  	struct qca8k_priv *priv = ds->priv;
>  	u32 val;
> -- 
> 2.42.0
> 

-- 
	Ansuel

