Return-Path: <netdev+bounces-61647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B472824782
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B80B23C16
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4A12556C;
	Thu,  4 Jan 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJcIAWAl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61824B5E
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9af1f52bcso441116b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704389575; x=1704994375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSQTxmwIPQ8gejO1z/IiwbV0b9ymbnn3pvsLrkt/bJ4=;
        b=TJcIAWAltLUKBj26U3pco8LPPHDWou/BA2WIp7UDFfgV+i4O4ma3+dBVHuJRi7adAX
         9ZicazZNm9i250VpZJxZbheiKi+jSV7B+x3kcu/gRtBVSi20RgGYMFbF4IyuHN8PZVMA
         KP7sM607ohHhDSBfAyrwqUU0GZ4mDfaxR7bV99rpYmIKSsxuuYsMLbW+bcrs91OFevMN
         WMjtxklvtDhdGwI/q3M+Ehu68AhUbmgXwp75Sf0FcthbVGgSAqBDDc38caKQO8NNhAxR
         09jeXh6rWyXyWPvNxMWR956bHVuMZkjPyR0qva9/OqUcRv6aH+5aUanSLKEDqb0Qmydb
         H8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389575; x=1704994375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSQTxmwIPQ8gejO1z/IiwbV0b9ymbnn3pvsLrkt/bJ4=;
        b=b7noCCjoxsqE22p0NrnNkfNTES9Gvr9Y5aMQbldit6oo5D6XNNLYLv3MILacOe+mQH
         asXW04UJwHGFWo7vfgR2DckOlw7IWMm2jI4Cw/urFaGqu6XtRHt+GP0AzYVhfNSTLlBD
         lmKzL/wSQkEbMuLlDEq4qoqTuJ7QjRGtARosI7bjgGWb3lvHLWv3RTwcFMEWHa5jlgc3
         faa9g+LkyKDuRA0eOXQ25n6HfifGL0foOukuKwq/VzSzXA3GSajwa+nIUHuxeUBIJMYc
         AK3mHHexCnB5Kslmx1cmDz71XSaueEQVrO6QddxldKkc6glaqX7PI+nM3vVvlTiUPfZJ
         DKnQ==
X-Gm-Message-State: AOJu0YxEGTLLGFVwNjui+Q40j1/1nJ/a3S4nVOBn5p3P2S3mEkIalX8H
	B19+gTz3pEhpOStJPwKBbGA=
X-Google-Smtp-Source: AGHT+IHGV5H/fau/CvD3rpxRM9Sn1CgmND9gs81A1Yg+XKs+mG9ttknJwTtsfT77X2ggZkkgZIsNWQ==
X-Received: by 2002:a05:6a00:4603:b0:6d9:8df5:bb3d with SMTP id ko3-20020a056a00460300b006d98df5bb3dmr947034pfb.26.1704389575490;
        Thu, 04 Jan 2024 09:32:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v5-20020a632f05000000b005c259cef481sm24489077pgv.59.2024.01.04.09.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 09:32:54 -0800 (PST)
Message-ID: <c29d9020-6aee-423a-b18a-d85766def8f9@gmail.com>
Date: Thu, 4 Jan 2024 09:32:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] net: dsa: bcm_sf2: drop
 priv->master_mii_dn
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Linus Walleij <linus.walleij@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-11-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240104140037.374166-11-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/24 06:00, Vladimir Oltean wrote:
> There used to be a of_node_put(priv->master_mii_dn) call in
> bcm_sf2_mdio_unregister(), which was accidentally deleted in commit
> 6ca80638b90c ("net: dsa: Use conduit and user terms").
> 
> But it's not needed - we don't need to hold a reference on the
> "brcm,unimac-mdio" OF node for that long, since we don't do anything
> with it. We can release it as soon as we finish bcm_sf2_mdio_register().
> 
> Also reduce "if (err && dn)" to just "if (err)". We know "dn", aka the
> former priv->master_mii_dn, is non-NULL. Otherwise, of_mdio_find_bus(dn)
> would not have been able to find the bus behind "brcm,unimac-mdio".
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


