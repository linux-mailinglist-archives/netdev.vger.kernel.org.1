Return-Path: <netdev+bounces-36737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776E7B1862
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CFB022820F6
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC830FA2;
	Thu, 28 Sep 2023 10:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A017F5
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 10:40:00 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4418F
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:39:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31f7638be6eso12085308f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695897596; x=1696502396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+zG599xetIUCrmLqPv0EhUwFmQJzXnxPCuWCvWHCnok=;
        b=ViTwuzzrh+LLlF6f2BdINTOnkS0//PZVKZIfUfIx5ypv7AMfcNI6NsXixVdckSfJoR
         XyytGk4R2fOmWkq/t79m/6BvZgwePrfyQG8YAi4UJRxH/5jaqnpTvZ/2s2igL5W6wpKn
         baZ0uTQ2x1kma34F1DmY8Pn7qKC77q+2/ArzqOp2Ju+iBeC9wb/BcyM1jcGesA4H69ZN
         kmPzy2W2UQD7lV2WqQYM3EsnwXBCDzbk6VTKenR4kQQxIqCtxdtiyMP2JPH7m/geSlVp
         TD5BL1Aqa8VNKHS3lDd8uwyC/3B+cwUP3jFBQHB0V1o5I3/AAyukr7BM3OWpRfOlhxSg
         DOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897596; x=1696502396;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zG599xetIUCrmLqPv0EhUwFmQJzXnxPCuWCvWHCnok=;
        b=er0fSoWO/j+gSlE/iG6SwUBHCp9OGscx5V2kp21YBBd9lB6qFbaVB+khLTmkqJJ7yk
         1m3jwljchln8wTbC/iMgnTBntOITfvAN2Bt+ahI4HotO64C+h6A/IzUXiHIfksONxQMi
         QbpaV8K0KDXwZ1TVc61XzE3To+gBOjTH1JUhAeWgHDyrt09T0FceAzi0Jbz2HgiakxMr
         pHO0HC97ELp188tfgPzVqcE4wK8bsgyR3EbIQu617PpTepF8od5lnMcIgaXozofvSV92
         F3TOtG/Gn7U7jusQZskX2zSEIM74FER+QmEvrSSrGIilNa8tNZ51XmqrQW3/oH1cA/Y2
         itDA==
X-Gm-Message-State: AOJu0Yx0ps4rNL0NVYmDNRzdLpFP7yh2bZKdmZCSHaodVXGSc6G/DM6Q
	Pu9RGASA4eESZv7jtxvS4C4=
X-Google-Smtp-Source: AGHT+IGQrhHjLRyDnYfSjDnAJpgRz12rkhKPvlPdo6N4t622BRSoEBkzpwEFBL16NoxSb1SCJ6advA==
X-Received: by 2002:a5d:4149:0:b0:314:1313:c3d6 with SMTP id c9-20020a5d4149000000b003141313c3d6mr770541wrq.33.1695897595879;
        Thu, 28 Sep 2023 03:39:55 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bd53:c900:41e5:cf81:eee9:53b0? (dynamic-2a01-0c23-bd53-c900-41e5-cf81-eee9-53b0.c23.pool.telefonica.de. [2a01:c23:bd53:c900:41e5:cf81:eee9:53b0])
        by smtp.googlemail.com with ESMTPSA id z4-20020a05600c220400b003fe61c33df5sm6782200wml.3.2023.09.28.03.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 03:39:55 -0700 (PDT)
Message-ID: <9bebdf7d-28dd-46d6-b94d-9459f9f99920@gmail.com>
Date: Thu, 28 Sep 2023 12:39:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Packets get stuck on RTL8111H using R8169 driver
To: Alexander Merkle <alexander.merkle@lauterbach.com>, nic_swsd@realtek.com,
 romieu@fr.zoreil.com
Cc: netdev@vger.kernel.org
References: <56c144a8-6526-80eb-91d7-9b36faa103c7@lauterbach.com>
Content-Language: en-US
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
In-Reply-To: <56c144a8-6526-80eb-91d7-9b36faa103c7@lauterbach.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28.09.2023 11:28, Alexander Merkle wrote:
> Hi,
> 
> I want to report a problem seen on my quite recent desktop machine using an onboard RTL8111H ethernet controller mounted on a ASUS X570-P motherboard.
> I problem can be reproduced using
>   - Debian Bookworm using Kernel `6.1.0-12-amd64` / `6.1.52-1`
>   - Fedora Desktop 39 Beta using Kernel `6.5.5`
> . In both cases we see that small ethernet packets e.g. ICMP/UDP seem to get stuck in the controller and are send out when there is other activity on the interface.
> 

Is there an actual problem? Or are you just curious why the numbers are different?

> The simplest scenario to use is using `ping` in our office environment (active network). We used a quite powerful company core switch as ping target.
> Using the R8169 driver the ping times are 2-3 times as high as using the r8168-dkms driver from debian (non-free). In numbers
>   r8169: ~800-900us
>   r8168: ~200-300us
> .

In a home network with current linux-next and same chip version,
other side being my DSL router:

PING 192.168.178.1 (192.168.178.1) 56(84) bytes of data.
64 bytes from 192.168.178.1: icmp_seq=1 ttl=64 time=0.418 ms
64 bytes from 192.168.178.1: icmp_seq=2 ttl=64 time=0.485 ms
64 bytes from 192.168.178.1: icmp_seq=3 ttl=64 time=0.366 ms
64 bytes from 192.168.178.1: icmp_seq=4 ttl=64 time=0.363 ms
64 bytes from 192.168.178.1: icmp_seq=5 ttl=64 time=0.365 ms
64 bytes from 192.168.178.1: icmp_seq=6 ttl=64 time=0.361 ms
64 bytes from 192.168.178.1: icmp_seq=7 ttl=64 time=0.366 ms
64 bytes from 192.168.178.1: icmp_seq=8 ttl=64 time=0.549 ms
64 bytes from 192.168.178.1: icmp_seq=9 ttl=64 time=0.368 ms
64 bytes from 192.168.178.1: icmp_seq=10 ttl=64 time=0.474 ms
64 bytes from 192.168.178.1: icmp_seq=11 ttl=64 time=0.362 ms
64 bytes from 192.168.178.1: icmp_seq=12 ttl=64 time=0.365 ms
64 bytes from 192.168.178.1: icmp_seq=13 ttl=64 time=0.370 ms
64 bytes from 192.168.178.1: icmp_seq=14 ttl=64 time=0.352 ms

Hard to say why you see higher ping times.
1. Please test with a mainline kernel. Vendor kernels may include whatever changes.
2. Test different interrupt coalescing and GRO settings.
   For the latter see gro_flush_timeout and napi_defer_hard_irqs sysfs attributes

My setup uses the driver defaults.

> 
> Using our UDP based communication between host and device we see that UDP packets (especially small ones) are not send out and reach the device only when there is other activity on the ethernet link.
> Using the r8169 driver we did a cross-check to evaluate our theory and using a `ping -f <powerful company core switch>`  as root running in background. With that cross-check applied we see that the delayed packets / UDP protocol resends are gone.
> 
> I will try to collect as much information as possible for you:
> ```
> $ lspci
> 05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> ```
> Device is labeled as: REALTEK 8111H L31ZY23GL15
> ```
> # DMESG output using r8168 driver
> pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
> r8168: loading out-of-tree module taints kernel.
> r8168: module verification failed: signature and/or required key missing - tainting kernel
> r8168 Gigabit Ethernet driver 8.051.02-NAPI loaded
> r8168: This product is covered by one or more of the following patents: US6,570,884, US6,115,776, and US6,327,625.
> r8168  Copyright (C) 2022 Realtek NIC software team <nicfae@realtek.com>
> r8168 0000:05:00.0 enp5s0: renamed from eth0
> r8168: enp5s0: link up
> # DMESG output using r8169 driver - mac address is removed
> r8169 0000:05:00.0 eth0: RTL8168h/8111h, <mac address removed>, XID 541, IRQ 145
> r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> r8169 0000:05:00.0 enp5s0: renamed from eth0
> r8169 0000:05:00.0: firmware: direct-loading firmware rtl_nic/rtl8168h-2.fw
> Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
> r8169 0000:05:00.0 enp5s0: Link is Down
> r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow control off
> ```
> 
> Regards,
> 
> Alex
> 


