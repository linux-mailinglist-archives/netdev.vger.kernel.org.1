Return-Path: <netdev+bounces-59315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5081A63C
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 18:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528811F24D77
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7A4779C;
	Wed, 20 Dec 2023 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmNpOZui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDD4778C
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a269a271b5bso69990366b.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703093003; x=1703697803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1Bsg3YVDtY8QT78kveIvWZicheI26GDORHP6nnZ1qw=;
        b=KmNpOZui8Dgrt+vlCyLdXX8Xb2U2QhVoGoefGV/rgBeNbbRs6L/XKSi+9b6/6GI85C
         StcdDn9LtJkLTti72qKuAqJlfrtQAguOoTbPoq4e1YmNsvfwI4lQOSpy63HP2aiGHe+4
         fizEQU9ix7rnwFG86ZZ/Oor4o99j4iXENQGQFbhWPSH5v7sERCdnllAq4N8T6+LA0C8f
         BlGeCdi8u5oGGkm8VOpq1J7Ox4CJ26xwom9ZFK0zQCyAsLbjfDmj5x6VgtkOWDERavDI
         xBPoh6HW/92CSfKkH+ieyqTzcscORL0z9mGM03FPq5PyIC8JwoTBJU2C0irVknRm2MCD
         wxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703093003; x=1703697803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1Bsg3YVDtY8QT78kveIvWZicheI26GDORHP6nnZ1qw=;
        b=lFQgj58iDdVI0qU7QhKU77pEnq3XzjANHOsFNzLtYjolX30tqCKKtzcuEP7t5OAWHo
         8zkG/CO2Hn9JcjSNR0val4TS+qfnLC4Rg+qdDsZLLX6/sLOS97nonkWRAWW9CtHrIlLB
         DFYh9aGeVlUBRaXI/N2SsQYGMGeAnZzLcETFPFuqXmzHHJ9Gkg+CZ/voMCv8OrIUwrdu
         SDi+8prnOFNEo+uzrSlTLaGkZmKLunTCJDMeaSGuL/iSsYHzkVUUlfYFJBMLdHuema0K
         SIdY41S7NP+7PMNDFNl4+zAq4LHkPGmylyggn0T5s0w4uZ3Uw07GgD64P3U6Zz8z7po+
         bQHw==
X-Gm-Message-State: AOJu0YzFQi5rWfO65sPrwETPOo2S20n8EnoUF16zkspVMMCkkEC0HscT
	rkz9Rvu1sefi1aATKDmCwAnYgMfLQxM=
X-Google-Smtp-Source: AGHT+IGRKWUm+rWdhTvpJCfl8wleyb90ZI/D11YeUcTmiLVD5aVCsHWJqjNj+Dp2uzsRCNWk7zom+g==
X-Received: by 2002:a17:907:3da2:b0:a23:55c5:a657 with SMTP id he34-20020a1709073da200b00a2355c5a657mr3920540ejc.44.1703093002831;
        Wed, 20 Dec 2023 09:23:22 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3? (dynamic-2a01-0c23-c0e1-2b00-cc8d-2472-9da4-1ff3.c23.pool.telefonica.de. [2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3])
        by smtp.googlemail.com with ESMTPSA id hy25-20020a1709068a7900b00a2327e826ccsm29667ejc.201.2023.12.20.09.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 09:23:22 -0800 (PST)
Message-ID: <cb28278d-c038-4dbf-81e7-097bf61dfb74@gmail.com>
Date: Wed, 20 Dec 2023 18:23:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/15] net: phy: realtek: drop .read_page and
 .write_page for rtl822x series
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 Alexander Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>,
 Willy Liu <willy.liu@realtek.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?Q?Maximili=C3=A1n_Maliar?= <maximilian.maliar@nic.cz>
References: <20231220155518.15692-1-kabel@kernel.org>
 <20231220155518.15692-14-kabel@kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231220155518.15692-14-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.12.2023 16:55, Marek Behún wrote:
> Drop the .read_page() and .write_page() methods for rtl822x series.
> 
> The rtl822x driver methods are now reimplemented to only access clause
> 45 registers and these are the last methods that explicitly access
> clause 22 registers.
> 
> If the underlying MDIO bus is clause 22, the paging mechanism is still
> used internally in the .read_mmd() and .write_mmd() methods when
> accessing registers in MMD 31.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/net/phy/realtek.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index cf608d390aa5..e2f68ac4b005 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -963,8 +963,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page	= rtl821x_read_page,
> -		.write_page	= rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {
> @@ -975,8 +973,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status	= rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page	= rtl821x_read_page,
> -		.write_page	= rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {
> @@ -987,8 +983,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status    = rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page      = rtl821x_read_page,
> -		.write_page     = rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {
> @@ -999,8 +993,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status    = rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page      = rtl821x_read_page,
> -		.write_page     = rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {
> @@ -1011,8 +1003,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status    = rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page      = rtl821x_read_page,
> -		.write_page     = rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {
> @@ -1023,8 +1013,6 @@ static struct phy_driver realtek_drvs[] = {
>  		.read_status    = rtl822x_read_status,
>  		.suspend	= genphy_c45_pma_suspend,
>  		.resume		= rtl822x_resume,
> -		.read_page      = rtl821x_read_page,
> -		.write_page     = rtl821x_write_page,
>  		.read_mmd	= rtlgen_read_mmd,
>  		.write_mmd	= rtlgen_write_mmd,
>  	}, {

Dropping the read_page/write_page hooks will be problematic,
because they are used by the PHY initialization in e.g.
rtl8125a_2_hw_phy_config().


