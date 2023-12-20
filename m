Return-Path: <netdev+bounces-59311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE681A5FB
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203981F230C1
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162547A5F;
	Wed, 20 Dec 2023 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ity5bDRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40E47771
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso7478419e87.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092037; x=1703696837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+1IHh3oVTDww6460OieDYibU9O1WrheFv72KEnN684=;
        b=ity5bDRkeC4SwH3mv8+gCbAyQXaC3cSvPf3TPfD34ivs4RK4boNrubG/JiKFpK+z7M
         0obgw6osw7MZ41rNTY/Sriegnd5p/z83HRbuIa6C6RY/YRotUPQri54nibXMo+5KvBL+
         EFgEE6x2VLfzQQEVT/gr1PdQXc9fVfWRcx9MCDPO7ZqfuACyHjKttUceA/upabzhc9VO
         Ry6CmRo4Rt1jr73Q0iZ1AH1DmSkQ53dS2ddMTS3dGu7XtRB2AR1XX9pXDs6ih1uRlpSr
         aqJdLKzFQjcA6EujExjFQIfDqZ9P8A4J4wDajt1JLY4q9kdYrPJGlaBsLNbRyxozv+gm
         ieLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092037; x=1703696837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+1IHh3oVTDww6460OieDYibU9O1WrheFv72KEnN684=;
        b=syOhbtqAs19tfl2LnAlvoigrQPegOdEv6+eOPW87P1gTU8g7OsaBbqVVvOuoL3F3Zs
         TvPDi5tB1Z1O8T9qRWbHbpOJlUEnAH2uzfTWPvplhqp4F9gw0qsaJbhINb7w2yHyX+Cu
         bkCWNVrTvzBIJz89VgcOTJwqdxYY9zsBVDpX261KxZu+K8UUyuqx/N4dPZVMQafNqzeJ
         s7Ys3XXdp2Yw06fmsE1nKzh3SC8dWcjhKTREOflmmT7rYjnmDNF6ApqiLgMhhmmgPvyW
         ERZZZzXe7qbimxtc1DJH7AMIyFTfZNG66Q5S45J4CJ/Rftij7WBOZoBYImDWm7gPB7d0
         +VDQ==
X-Gm-Message-State: AOJu0YzEfWQdlKYtyqUyZ066G9fC6nbudau0iNlKHHZnNFMVQ/CzBo+x
	RYXkcC77do8wCKVG28GkDDE=
X-Google-Smtp-Source: AGHT+IExEOzsCvo3BDXaqVURiDO9bDSm7e2uR2qDoezny4Irn8z4+g7moLknw8zh4jvw4xVQfNRNig==
X-Received: by 2002:a05:6512:10d0:b0:50e:492f:f60c with SMTP id k16-20020a05651210d000b0050e492ff60cmr2033632lfg.83.1703092036183;
        Wed, 20 Dec 2023 09:07:16 -0800 (PST)
Received: from ?IPV6:2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3? (dynamic-2a01-0c23-c0e1-2b00-cc8d-2472-9da4-1ff3.c23.pool.telefonica.de. [2a01:c23:c0e1:2b00:cc8d:2472:9da4:1ff3])
        by smtp.googlemail.com with ESMTPSA id ew18-20020a170907951200b00a1dd58874b8sm18652ejc.119.2023.12.20.09.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 09:07:15 -0800 (PST)
Message-ID: <74241057-4bc8-4d95-bde5-0dfc4b88a26d@gmail.com>
Date: Wed, 20 Dec 2023 18:07:14 +0100
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
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>,
 Alexander Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>,
 Willy Liu <willy.liu@realtek.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>,
 =?UTF-8?Q?Maximili=C3=A1n_Maliar?= <maximilian.maliar@nic.cz>
References: <20231220155518.15692-1-kabel@kernel.org>
 <f75e5812-93fe-4744-a160-b5505fecd47d@gmail.com>
 <20231220172518.50f56aaa@dellmb>
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
In-Reply-To: <20231220172518.50f56aaa@dellmb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.12.2023 17:25, Marek Behún wrote:
> On Wed, 20 Dec 2023 17:20:07 +0100
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 20.12.2023 16:55, Marek Behún wrote:
>>> Hi,
>>>
>>> this series reworks the realtek PHY driver's support for rtl822x
>>> 2.5G transceivers:
>>>
>>> - First I change the driver so that the high level driver methods
>>>   only use clause 45 register accesses (the only clause 22 accesses
>>>   are left when accessing c45 registers indirectly, if the MDIO bus
>>>   does not support clause 45 accesses).
>>>   The driver starts using the genphy_c45_* methods.
>>>
>>>   At this point the driver is ready to be used on a MDIO bus capable
>>>   of only clause 45 accesses, but will still work on clause 22 only
>>>   MDIO bus.
>>>
>>> - I then add support for SerDes mode switching between 2500base-x
>>>   and sgmii, based on autonegotiated copper speed.
>>>
>>> All this is done so that we can support another 2.5G copper SFP
>>> module, which is enabled by the last patch.
>>>   
>>
>> Has been verified that the RTL8125-integrated PHY's still work
>> properly with this patch set?
>>
> 
> Hi Heiner,
> 
> no, I wanted to send you an email to test this. I do not have the
> controllers with integrates PHYs.
> 
Quite some newer consumer mainboards come with on-board RTL8125, also
a lot of cheap add-on cards with this chip is available.
RTL8125 comes in different flavors, with different integrated PHY's.
I have one add-on card with RTL8125 that I can use for testing.

> Can you test this?
> 
> Also do you have a controller where the rtlgen driver is used but it
> only supports 1gbps ? I.e. where the PHY ID is RTL_GENERIC_PHYID
> (0x001cc800).
> 
Most of the consumer mainboards and PC's come with such a MAC/PHY
controller, nowadays it's usually RTL8111h. And yes, I have such a
test system.
Note that there are also PHY's with this generic ID that are 100M only
(on certain RTL8101 chips).

> I am asking because I am told that it also is clause 45, so the drivers
> can potentially be merged completely (the rtl822x_ functions can be
> merged with rtlgen_ functions and everything rewritten to clause 45,
> and gentphy_c45_ functions can be used).
> 
I doubt it's C45, most likely the integrated 1G PHY's are an evolution
of RTL8211f and similar PHY's. There may also be differences between
all the PHY's sharing the generic id 0x001cc800. But I can't say for
sure because I don't have access to any Realtek datasheets.

To be 100% sure testing would have to be done on all relevant RTL8101/
RTL8168/RTL8125 chip versions.

> Marek

Heiner


