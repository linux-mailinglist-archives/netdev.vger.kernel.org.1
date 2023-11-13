Return-Path: <netdev+bounces-47471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 053E57EA5AC
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6D51C209C7
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E522D639;
	Mon, 13 Nov 2023 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikMwCh04"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4F02D622;
	Mon, 13 Nov 2023 22:03:05 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02501D50;
	Mon, 13 Nov 2023 14:03:04 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce2cf67be2so2611220a34.2;
        Mon, 13 Nov 2023 14:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699912983; x=1700517783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrR0LMMA9pCsMg7Z2og3ajwpAkisvYIotqQKaMkJ4HQ=;
        b=ikMwCh04/dMazyMkQQ0QkHHGsmfbSI/OLIhwdNGDmERxZf8Lon6GlSMN/cN+AEsSv1
         xt6LnOSXQOZrF+cWKQmoAaWAGoYSBheSf9wgJxKUIu69f9JrDTPfKU7+IKG3dgE5p8I1
         CTGMdAhyGBCEoTaFpGrEhcBjPX0pNompL3LaiCoGmk2O/YRGtlUDsfRK8h8bL+LMnvd4
         dT7U1ShSD6NhWVYmqc5C9NtdbeqY6+/2DEzB6zr0UdOfd6UeXY6CrRtilcwZoN3dYLVO
         Ehlan/46BP1g2eckOPyPWgi94qi0/nNrsliGaOxv9pwWgwFD1VmVUex1BN1xzPW3AzQD
         5z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699912983; x=1700517783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrR0LMMA9pCsMg7Z2og3ajwpAkisvYIotqQKaMkJ4HQ=;
        b=quIc9IpRFLGzvp/v6WJqJBeorzppbT7I0uo/wvGMS5G8a/FZ+ETgrH9i4P86tgzhIj
         0gXag8OU/mWVHvLtV+tx6zT01PVMPYNCZhubpM3XekRlGrvugpErm+tpkpvv2HGVADcK
         PDfGSAh0QlkoDRtqpnbXnDYhsyaXuHU398d87kJFb355bCTJ7o8/Hsv7XZQ2pY42y8/e
         3cHRjyU5g61pKUNUt5SJ4KpAMMaZAo3F4oJ0pzBHEuunsTkD16eDrZ1oWgU4b2rgOCPu
         E38HQPdVBndNCkkQelP3Kduad03iPmDKix9Pz9o0FftyzrfRltxvldm2nuN7SAFO155z
         v/yQ==
X-Gm-Message-State: AOJu0YzMnu8DuA6/phzxUhXryaKI6buy9WI4DDWddUgN/Ul/dn2jINHz
	1GfRIkq4PW4hheVltxmcNyQ=
X-Google-Smtp-Source: AGHT+IEHzuDLDN+SqdeAktwSurDVy0AQs9qa/F7Y0H5oyMx9fMGQ5LzdsS/6XH5yklsmNh+8aZ+UeA==
X-Received: by 2002:a05:6830:1397:b0:6d6:4be1:442c with SMTP id d23-20020a056830139700b006d64be1442cmr435454otq.4.1699912983220;
        Mon, 13 Nov 2023 14:03:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a18-20020a656412000000b0059d219cb359sm3779823pgv.9.2023.11.13.14.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 14:03:02 -0800 (PST)
Message-ID: <3acda2a2-3c99-4a14-ab68-ab166ce08194@gmail.com>
Date: Mon, 13 Nov 2023 14:03:00 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Do not make
 'phy-mode' required
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Fabio Estevam <festevam@denx.de>
References: <20231113204052.43688-1-festevam@gmail.com>
 <43d176e2-d95f-40dd-8e42-8d7d5ed6492c@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <43d176e2-d95f-40dd-8e42-8d7d5ed6492c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/23 13:51, Andrew Lunn wrote:
> On Mon, Nov 13, 2023 at 05:40:52PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <festevam@denx.de>
>>
>> The property 'phy-connection-type' can also be used to describe
>> the interface type between the Ethernet device and the Ethernet PHY
>> device.
>>
>> Mark 'phy-mode' as a non required property.
> 
> Hi Fabio
> 
> What does the driver actually require? Will it error out if neither is
> provided?
> 
> Maybe we should be changing the condition that one or the other is
> required?

'phy-connection-type' is the deprecated version of 'phy-mode' which 
of_get_phy_mode() will fall back to if 'phy-mode' is not provided. It 
does not appear that stmmac attempts to use anything other than 
of_get_phy_mode() therefore would not it be acceptable to update the 
relevant .dts file such that it uses 'phy-mode'?

That really should not have a functional impact given that 
of_get_phy_mode() has worked that way for a while.
-- 
Florian


