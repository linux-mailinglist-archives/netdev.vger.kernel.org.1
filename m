Return-Path: <netdev+bounces-220460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D4B4616C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CB31C26319
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3B30B511;
	Fri,  5 Sep 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QtfDgUNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49E1F2361
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095082; cv=none; b=ARjGsdJwNIkj8/dbxgWtFoOS3SejDpsXSy04EKDmbiAAwvUIxyv6QrUP4bkl5dHomIRf3e0mbvz/1SOKz3pQ5bp7bdqM8ETQSskYaf3WWF4ZbDIoCpa0wngSPsSvJgf7LXt53H0f1D+MMEZ6qqqWMjlixZFdHELFh1uiXccBaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095082; c=relaxed/simple;
	bh=0yAhrMvinQFkNRgapsOR0PXHAt4KleP7GLcnD0x8gc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS1zD9m+UZmUqPFSoW1I4l0CXNnlxZiULjrSu3GJtjcTsr2DnEHk5m5afFnwoSu4QdsIJrNny5aW8ur9W8vO8blLCgkYd4YG0JWLyCcl3VUSdcIeMNZTCr/oi1lsek+D39zcHp0JASJ8pevNEHZR9yypGiXJJpEfSqjNLQRHCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QtfDgUNJ; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-61e050652f0so523639eaf.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095080; x=1757699880;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar/FtxDk4QjWcaWgSLxj0jW+sgXpMBSFcpJ8ibUqW3M=;
        b=WfEa8oseiHAGjNxlv8SZr/OBa+rNveYxzIhhEkat2wnXIqSFdDwjPKwP0GMuDsDZN8
         oBMze0Cflr7y98Sx6nuySGX7wCQHmKj1fvMVKwTcaChctyY/igFuutJdeeLHBtnw3j7M
         RrEJCQb+Jf02WaGhzr/pphPT1aJB1tFwyJhdSrJJogj35eKFVvF+ZkpwTstJ1TJly/ud
         im90ckscs8MSmCnbiqoNUweAsgKsddRKyXIqEbL4yA+xyTUkFNiV9oTsFdA3Tt+m+xYS
         536yEXBi9SRO09H9IrqQ2X9hpP1XA4t/xFOeH3hRxyX4U86Ke00u26nEAP2txYdt//NJ
         eu7A==
X-Gm-Message-State: AOJu0Yyc5kYBpGNXtVyTzPEMzMfL2akzZN/MeaXi182NEVcNJ5rHN1hh
	alg+8dQLwoJwxf8QSNBYYcIyMb6CQuhCSpSDpYv+NU4IXWgDe9nA+cebM7evOSJv3VbvCsdDIQg
	OO7S6M/uetXW2p3V1laOfUWgj3JXxPGD2V6oNnapZzRV89ZMh0BaLSfjn/B59iaJJwH21d1vlHu
	aOc4i9ZsGVo+wg9wvSfmzdcjTLes8KJbiEOj5IxNUdeiaIRwBIMQo+Wgk2zUkzMXZ88EQgkvEnc
	7IqtiHUCrGfrgxl
X-Gm-Gg: ASbGncvu1nLoLuFucI4Qxe2yKCjoXkYuswHlDNoIXGA6DITyC/4aSDezXSjrKnnfT9K
	lWdxL5Wie9TDavqAMs+ftsmUZKR/jaia1WefdvbX78pJujupfLAFFa5nFCgvrXgEEU57CVtj477
	YCA2zUdGvrPx26XC4ePrvC3jAQo+urO+QzLx1LKUycnUXzErFxr0MBpoE/Ra4eCcwAnhJlu+NPS
	yc/8LgtOzh1QR2O5qjcyaUnA8eUhWxyaSt5IMAd/hEt3hynqp7TtIZqMJtEBzZRhpTV70+yCC+c
	wyuFUZY2STb0wEHI3bGjxLkfcRw9Z4bPPgq89E+SCZUu/LK40LK7ayG0+C8QMztbSwPxGG3cp/9
	msDK+Gfs0whWfbS7fUNT1PseAn1KrCQz2650bKonrADszehPk2xsUroxlQ8iaQB5GKOjZeiWsg1
	h/qdVT
X-Google-Smtp-Source: AGHT+IFuq/7D/KsR3vSWjHB0lWCn00T8Ldij0ZK5B2DG/SF0gGHkEly1tLpdb9NAuALc7blPzTXyobNCoDOB
X-Received: by 2002:a05:6820:518e:b0:603:f521:ff26 with SMTP id 006d021491bc7-61ff9345251mr1487054eaf.1.1757095080226;
        Fri, 05 Sep 2025 10:58:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-62169c0b1d7sm72557eaf.2.2025.09.05.10.57.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:58:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7224cb09e84so46417776d6.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757095079; x=1757699879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar/FtxDk4QjWcaWgSLxj0jW+sgXpMBSFcpJ8ibUqW3M=;
        b=QtfDgUNJBrpLpkiEf6qMGAcxx+I/GiTVYNjpib477J/cDu6hjN3W6C34ceD+4cAOfD
         ontlwHQrqQxX51IPAksoRrsjJPi3aOyYAG3t2A57iwVsFT48eYQa/leyGNW8D8UqRFc/
         0NOj561SOXtGZw6rDz3o0uNi+nBugkTJcH2ks=
X-Received: by 2002:a05:6214:2241:b0:70d:b5c4:ac16 with SMTP id 6a1803df08f44-72bc3374610mr44433186d6.28.1757095079074;
        Fri, 05 Sep 2025 10:57:59 -0700 (PDT)
X-Received: by 2002:a05:6214:2241:b0:70d:b5c4:ac16 with SMTP id 6a1803df08f44-72bc3374610mr44432856d6.28.1757095078460;
        Fri, 05 Sep 2025 10:57:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e723sm69820776d6.9.2025.09.05.10.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:57:57 -0700 (PDT)
Message-ID: <88a5a964-288d-4048-8731-625adb15bb48@broadcom.com>
Date: Fri, 5 Sep 2025 10:57:55 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 net-next] net: phy: fixed_phy: remove link gpio support
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <75295a9a-e162-432c-ba9f-5d3125078788@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/25 23:08, Heiner Kallweit wrote:
> The only user of fixed_phy gpio functionality was here:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
> Support for the switch on this board was migrated to phylink
> (DSA - mv88e6xxx) years ago, so the functionality is unused now.
> Therefore remove it.
> 
> Note: There is a very small risk that there's out-of-tree users
> who use link gpio with a switch chip not handled by DSA.
> However we care about in-tree device trees only.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


