Return-Path: <netdev+bounces-59299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E637481A4D9
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE15B24C21
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84C4B143;
	Wed, 20 Dec 2023 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOZ4tQnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB23482FD
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso1775133a12.0
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 08:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703089209; x=1703694009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmhyUhESyJYfhOPaJuSduX5EcAHdC92PQCbsLA0TPik=;
        b=JOZ4tQndtQmHxRluwrLFAgZrEjl+ZSiIgpPcOX9i40X3GV4aiMyVxs6LtXqEUQrim+
         YbJgzWI+Ekb4tUuvIoy036QwpI1XlD/bxLKG9ohAeTXdovzv+KbzZ+tCr42AqcoYxZCD
         YE9sSp6J8VpjJnpDYHNXUbGwAme4Gc6VQLpfp8yvfqVsG4vBwW7Ak3CwMWegmBI8EL+F
         1OeERWrKqHoA4shXEdtHfyQILSR0D6jNDUNjO6rTL55Lxh4viQx1R6Hx7egkovJz3Ik3
         TqNLd3WcxURUOgvC5835lbC3mr+tmnu5GCH3KfgLVtJiFGkjfDBXkYLIz95m7F6cvL4x
         WUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089209; x=1703694009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmhyUhESyJYfhOPaJuSduX5EcAHdC92PQCbsLA0TPik=;
        b=L3Fa4nu0sBGgF46jbaLUYHjy+XrPnIInQLGuRbxx8dJs0rcXm+yDDdy1VbZXBD2N5q
         +nPRacV17SoFzIBgnT5e629e9U2/5ngMCNlCVCF2SsQYxocOF+REFyzwI4wDl4yrsQeR
         Jhn0bfqZz/yo4y0/zGkzVh3uYg111kkXblnILjSLzAyM9oUFPcTV8mAEnIo4Bkt8MJEt
         oRGvcceKAH297irrmxF73LreZVa2EjcjiWpe/ymCfqsI+2SmmT9vgFs12M0iayXwW2K8
         ExMbW83RaxB/MJHoLaSANzMD/kydVvtodT8Z0RkAjQ4WRUJDOyXfO8aF98jr0y8cYte/
         CJHg==
X-Gm-Message-State: AOJu0YyY7q7sga1+iRSstHUO96rTR54Yp/FXqbpLlX0hpHaDy1ePl9S1
	O+7bJOqoZ1u9b0/OyTM8AgUgf0rL7qo=
X-Google-Smtp-Source: AGHT+IF8dhnl1tNJ5OkVs8OEYRLB8p9JGALWwweYYWW51eXWJLKAZVcltrq+SNLkI4dI85qHu+hM7w==
X-Received: by 2002:a17:906:54d3:b0:a23:4902:a596 with SMTP id c19-20020a17090654d300b00a234902a596mr3770354ejp.1.1703089208380;
        Wed, 20 Dec 2023 08:20:08 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3? (dynamic-2a01-0c23-c0e1-2b00-cc8d-2472-9da4-1ff3.c23.pool.telefonica.de. [2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3])
        by smtp.googlemail.com with ESMTPSA id ev14-20020a056402540e00b005519a444a6asm8590909edb.71.2023.12.20.08.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 08:20:08 -0800 (PST)
Message-ID: <f75e5812-93fe-4744-a160-b5505fecd47d@gmail.com>
Date: Wed, 20 Dec 2023 17:20:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] Realtek RTL822x PHY rework to c45 and
 SerDes interface switching
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
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20231220155518.15692-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.12.2023 16:55, Marek Behún wrote:
> Hi,
> 
> this series reworks the realtek PHY driver's support for rtl822x
> 2.5G transceivers:
> 
> - First I change the driver so that the high level driver methods
>   only use clause 45 register accesses (the only clause 22 accesses
>   are left when accessing c45 registers indirectly, if the MDIO bus
>   does not support clause 45 accesses).
>   The driver starts using the genphy_c45_* methods.
> 
>   At this point the driver is ready to be used on a MDIO bus capable
>   of only clause 45 accesses, but will still work on clause 22 only
>   MDIO bus.
> 
> - I then add support for SerDes mode switching between 2500base-x
>   and sgmii, based on autonegotiated copper speed.
> 
> All this is done so that we can support another 2.5G copper SFP
> module, which is enabled by the last patch.
> 

Has been verified that the RTL8125-integrated PHY's still work
properly with this patch set?


