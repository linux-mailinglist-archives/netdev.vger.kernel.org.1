Return-Path: <netdev+bounces-52993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F38010B2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23245B20D41
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D07A4D130;
	Fri,  1 Dec 2023 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4e2r0HG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B804198;
	Fri,  1 Dec 2023 09:03:48 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdfcef5f8aso920763b3a.3;
        Fri, 01 Dec 2023 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701450228; x=1702055028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cjuIkJ9H8CNcUcuncysFw/32ztJiuwvLYvu+mgg+Nc=;
        b=J4e2r0HGMDerR9RB5msukkC04Hrm2L7aU9oaBrRGMKzip4ExZ7fnwO+FsG9HTxUo3B
         KXcvs102CfmAXmtoJMw8Hs3OMejXPfyaWW/5V+U8oSvrzm8YX/Eyq7sIuI9NJp5z5qkC
         NhubYlONoRSKQZyMWcuBsG29SQIulo5YbMGN9BZNCiX3peg+qeoOX9fD4adWZh0p15B8
         pCPyJyuNTocEUgLEwOrC+PGdndGBZ5Zn9cYjq5uVWb44TqZwV2wNRIRpRxzxaoGpC6Ye
         1m348qfp+8zX/2m1ejdrcTPLPX3lsR/vY7AZPzIXYl8jkhu9NR2oThI633zfE+l8x7Pr
         vQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450228; x=1702055028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cjuIkJ9H8CNcUcuncysFw/32ztJiuwvLYvu+mgg+Nc=;
        b=nEIYG4IZaBkRV5MnWZn8zasNSKESdfRFihQp4qIYqez4S4BvmBY92l34CdY6/skrWM
         MKVUb7Biw7o2aWyjjxvLM35sCCUREwuLf9Bgw09tc7T9TJaworQaas985w8Ki9IE/7x2
         FkHdSeRGQFjZIoBysGI7psZMUS5BeoVQ3zoET1xyz4Qk2ovKoAq5XUAKp5qzR8/DHC/z
         L6vTD8tfKoEoroF1x7W4q51BnDdKWEOudO7HaY/qQjC1y3gBnLZapukdvmczhxqyMPBs
         v+Bp/eml8QXk2pAJIMFkGEXj2B5YgDUmPwTkBjUKP+vFqdEPWpcE/LF0cd6hsr114RcM
         j+bA==
X-Gm-Message-State: AOJu0Yy//nrwko4J5+S8vOU/FczS2sa88i3NWcH7/szEO/5i98Gjd+dk
	+todmykWBYJ4t6Cdl6Q2toU=
X-Google-Smtp-Source: AGHT+IGKXSF0uigJqiWQrI0nCGJEGnuOt717Ok9SMu83MM6+qCac2B0oi6+1kI/lPE2SuaLOXZ90rQ==
X-Received: by 2002:a05:6a20:9c93:b0:18b:281e:51ba with SMTP id mj19-20020a056a209c9300b0018b281e51bamr29188274pzb.11.1701450227742;
        Fri, 01 Dec 2023 09:03:47 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r14-20020aa79ece000000b006c9c0705b5csm3232908pfq.48.2023.12.01.09.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:03:45 -0800 (PST)
Message-ID: <b6ba48dd-e470-4592-979b-23afc475ec03@gmail.com>
Date: Fri, 1 Dec 2023 09:03:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: phy: micrel: allow usage of generic ethernet-phy
 clock
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, andrew@lunn.ch, hkallweit1@gmail.com
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201150131.326766-1-heiko@sntech.de>
 <20231201150131.326766-3-heiko@sntech.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231201150131.326766-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 07:01, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The generic ethernet-phy binding allows describing an external clock since
> commit 350b7a258f20 ("dt-bindings: net: phy: Document support for external PHY clk")
> for cases where the phy is not supplied by an oscillator but instead
> by a clock from the host system.
> 
> And the old named "rmii-ref" clock from 2014 is only specified for phys
> of the KSZ8021, KSZ8031, KSZ8081, KSZ8091 types.
> 
> So allow retrieving and enabling the optional generic clock on phys that
> do not provide a rmii-ref clock.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


