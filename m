Return-Path: <netdev+bounces-58288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393E815B8C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D479F1F2368B
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C6328C4;
	Sat, 16 Dec 2023 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5bySA/K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773D328BF;
	Sat, 16 Dec 2023 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-553046ea641so584999a12.3;
        Sat, 16 Dec 2023 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702757157; x=1703361957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nqit6ZDQM1+iIh4DkqzDKobNS44VmlhGAuMHZDrwAjE=;
        b=h5bySA/KRLF86sYTJwxS/LTucJoh2zD110RgXYjlZZMBUFNX+QeR0ebyEMqoe0vNCn
         OLeG/f7Lq7wFFa0Tm9myF7gWxa4+Zf4U29mlffMiy82IWQ6/RNizHeujeqOCDfNOnZjr
         HpD2d0G0iCEz6Qcnn6tMXzH/XjgVVg3NPXFmgkzQO1wjEkf4y4sxEIcKuMgwscsKVdJo
         FOND22nm/Sas++f/E+kJkynWcs9At9EZFIXVD2qAKoJx1xxcYMfG0RT9h0reudSpV1Wl
         dtOSWcBfoW6I49fIgXIFsTgQPNoSMnLBxVBszYwy73HOjK14AcHx+SM2sboPDwUJ2/Jz
         klfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702757157; x=1703361957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqit6ZDQM1+iIh4DkqzDKobNS44VmlhGAuMHZDrwAjE=;
        b=G9MKp+nA3PWsEyjYNc3MNNkAjSoyQjOcBdsp6KYY1OtjTqcty7aZVzhiDL/aKLlTTA
         kJQr6TIePlvBl8vNsxKf1Yg/XXmTN5oV1MwrU6x/PyIfkjPCCI6ZqMOnn7K5a5phK8cs
         In5e9bVGw1buaMk5/N/iLSdqiUYNsuEqOu6v2S7D+fxdjcXtHMHjlsE9DtRWiFhFcMKD
         gFPRCY981HBQruj27O7StDxythNpZhs35W/P08zSjDt2hJxq66Faye13VNvtSWafPOG+
         hIv7lok8cSWt4SbY+omlmr1I0AKZjOCZlpZ9E+tAj9T4B/EewhGorHA+ElBjMHTI9rea
         sfdg==
X-Gm-Message-State: AOJu0YwxYF89KxNDymlkSqA+nzVHrZqS9oVafZHEAyIP6u+XrQDSd5nc
	ZYnpIH8tX+3a7/SqHmayZtI=
X-Google-Smtp-Source: AGHT+IHETBtLxE1DJu0zVbu/ua93e7Pd0V6R4Pf9rrR6yekjUPRJxTpUqA2M8R+uK5en6k2ZxL2hHA==
X-Received: by 2002:a50:c041:0:b0:551:b477:1992 with SMTP id u1-20020a50c041000000b00551b4771992mr1972833edd.38.1702757157466;
        Sat, 16 Dec 2023 12:05:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0055267663784sm2907133edb.11.2023.12.16.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 12:05:57 -0800 (PST)
Message-ID: <e7f6d5dd-465a-48ca-9727-a32d8de0cbc2@gmail.com>
Date: Sat, 16 Dec 2023 21:05:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] Add en8811h bindings documentation yaml
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20231216194321.18928-1-ericwouds@gmail.com>
 <20231216194321.18928-2-ericwouds@gmail.com>
 <23c99ed8-7274-4171-930f-65582d86402d@lunn.ch>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <23c99ed8-7274-4171-930f-65582d86402d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> 
> Is this to deal with wiring up the SERDES backwards? Is there a more
> detailed description in the data sheet?
> 

Sadly, I have not received the datasheet. All comes from studying different versions of the driver.

On the BananiPi-R3 Mini the RX pair is reversed:

	phy14: ethernet-phy@14 {
		reg = <14>;
		interrupts-extended = <&pio 48 IRQ_TYPE_EDGE_FALLING>;
		reset-gpios = <&pio 49 GPIO_ACTIVE_LOW>;
		reset-assert-us = <10000>;
		reset-deassert-us = <20000>;
		phy-mode = "2500base-x";
		full-duplex;
		pause;
		airoha,rx-pol-reverse;

		leds {
			#address-cells = <1>;
			#size-cells = <0>;

			led@0 { /* en8811_a_gpio5 */
				reg = <0>;
				color = <LED_COLOR_ID_YELLOW>;
				function = LED_FUNCTION_LAN;
				function-enumerator = <1>;
				default-state = "keep";
				linux,default-trigger = "netdev";
			};
			led@1 { /* en8811_a_gpio4 */
				reg = <1>;
				color = <LED_COLOR_ID_GREEN>;
				function = LED_FUNCTION_LAN;
				function-enumerator = <2>;
				default-state = "keep";
				linux,default-trigger = "netdev";
			};
		};
	};


