Return-Path: <netdev+bounces-102073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBF7901542
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44822281877
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACD51CD0C;
	Sun,  9 Jun 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="SNIDV9wd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1038A3F
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717924279; cv=none; b=KIAjvg7yUITf3yaVjI1L0yRpEqFMCquuPRzL4g3fusLctGHOS2GXdFDvHsQ0IadN2TyVT9KN6XaYKafa2EIjwsEk8DqeW4PZMNM3Sse1nfd+vfwT/xxvHYa6YCSyM1EeptH8DL/9x5EN/hRxaVEMoBxzWBnVIAFi/0AUKr56KAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717924279; c=relaxed/simple;
	bh=GzifLABJkRsET3YQtOXxnCwDTE75tgHgt9R4GJUNDP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eX8zndSHIaMzPhgN35G/vPmapVudBdUHbGtx6/qH7tw4m7H/U3CAwxUmeSJ5HIQX1VugXWKpOMU08zZcCM0Tu+KSyjHyhw2NqZRlXEk+wZV9UlYqrTTz1lMMcEc2A4dgVGExXhZ99c8/bbw0z3SpAn3wImxoetDBI+MkVVoEC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=SNIDV9wd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717924260; x=1718529060; i=hfdevel@gmx.net;
	bh=3pegzNPR3CISaJIiofUevUAIapVgOLBrHIM7uJrCSoI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SNIDV9wdFV2AA+1IX5llSX2jNdsKp6ZBqe3FDfcemGXEYvnopE2tuBbn/8NYrE1+
	 W5/834XDYjCREjrgRgjopKNDok5/G0Im1vyEDUIhQhNlNjLQ/rhy7CxMpViz61g3g
	 bW85qBlkbuqow+62btJNoyIt4fVy50S1Uj2GNZKJ1QUj2+CxX4sjBZ3z9hhu13/y3
	 UmocT9rxGvIS63s3PUxh6eY/B7gef/T9I8DRK5FUkb0rb6miNhPR6Zin9vQlIH887
	 5AviOsvE0GPSWn+fCYbU0LU3WjeExy1/ZGeZ66iH7/7QzsIwvyzOMzUz4eUZch7RB
	 34P8hyYAbfJkjIQx4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpJg-1sq7Yk1Tfe-00aObQ; Sun, 09
 Jun 2024 11:11:00 +0200
Message-ID: <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
Date: Sun, 9 Jun 2024 11:10:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240605232608.65471-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDmYzvtAzAGe0zPYwnBZPoZV+uaF0dnnvBYeOS+PtT2c3oPxswT
 otOAJip3ahHv5Wuvp0tC965IlSeHP7+aYyOeXLBInuPIFxMjEYeogm8X5HTnQcppyb5qlch
 P3fhHiof1tTooT3cW4d/gmnEUwMHfLCaZUtIULjRhg/Jk56Z55VkHSr6EFmcOgMeq0m3gE4
 CHpMNK+laXDKAV89byRNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8cnFgKZ0Jls=;T3g9UAvJrh3hTu86Ya45zeyKG9p
 Y9iTMQ+7wY4VSxcaH0/Wz64W68/EvScLkx+IzGWD0yff8soDlv8PFTOnKiy7ug5H5yfHhYdDj
 /mMtvhI+BfvEuFDPZSW7/9XtRwD/aVwWlISOlLhy56o2xhbnzqeEENIxal8J1hqWcCw8a12Ti
 AZuc/O5Xo6dtHVHXmx0qTHOCB85scJdIMl1FlttlpfLOwYJ/sGhXzbtMnzQj7UCyVRye0cNtH
 V01zLHZW0bHITMHZxgzsPKnSfXhOXnCT0Sn3PD0xKoOOB/mOhYWKuWoU1pRYNHloIS+htvJjt
 XsA6xnQEvXLodpgfM+TDyhN1Qmv+IuqAg6O9S38uP9C9jKVtRwYR/FXX2Xlc24JvuQA66DU+l
 AthVE+aaUVYvMRkNTDSKWZOZu/Egk+3uLWBVZVuDIw5dsvV77YJt8JRCf2foCCVQbRdkfnyxo
 YwvSsRjlu6qDb6wm1iHfZsM6OhIhE2678U80FJtN6dxoGaeliNfJZLKdrk15gile7yGZdx0Zd
 5lehAyCozQk97W4VB1nlnF2y1cWp/kjGD+HmdF88mJkE4aSQectKwx0cTK+nMWtV7vOKAwDOf
 wmZOdlcx+O0dQ3C+DXyOCZ9gUsIOMK7VyzYHJahiv3MGV0pf7J0k6HYffEd6BDE1wta73bE0J
 e5pk6Ocl+LQS0YhBjOP3wR8k3t2bOGolDxoaY5HPmVKib5cVm9QM5dDWEPJ0jNE92YULdcjMS
 bI+1LIgfbIbowBQ85tzO/D8hLdrvcOGxcqSngGG8YmzHzpwwEOPOznSkTO+Wfbri/OLM3BnAj
 bf7LH40F5HKETDsLOwQQKHHOPOQ/u8UWGGxvJzLha+e6c=

On 06.06.2024 01.26, FUJITA Tomonori wrote:

> This patchset adds a new 10G ethernet driver for Tehuti Networks
> TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
> (drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
> chips.
>
> Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
> based on TN40xx chips. Tehuti Networks went out of business but the
> drivers are still distributed under GPL2 with some of the hardware
> (and also available on some sites). With some changes, I try to
> upstream this driver with a new PHY driver in Rust.
>
> The major change is replacing the PHY abstraction layer in the original
> driver with phylink. TN40xx chips are used with various PHY hardware
> (AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell MV88X3120,
> MV88X3310, and MV88E2010).
>
> I've also been working on a new PHY driver for QT2025 in Rust [1]. For
> now, I enable only adapters using QT2025 PHY in the PCI ID table of
> this driver. I've tested this driver and the QT2025 PHY driver with
> Edimax EN-9320 10G adapter and 10G-SR SFP+. In mainline, there are PHY
> drivers for AQR105 and Marvell PHYs, which could work for some TN40xx
> adapters with this driver.
>
> To make reviewing easier, this patchset has only basic functions. Once
> merged, I'll submit features like ethtool support.
>
> v9:
> - move phylink_connect_phy() to simplify the ndo_open callback
> v8: https://lore.kernel.org/netdev/20240603064955.58327-1-fujita.tomonor=
i@gmail.com/
> - remove phylink_mac_change() call
> - fix phylink_start() usage (call it after the driver is ready to operat=
e).
> - simplify the way to get the private struct from phylink_config pointer
> - fix netif_stop_queue usage in mac_link_down callback
> - remove MLO_AN_PHY usage
> v7: https://lore.kernel.org/netdev/20240527203928.38206-7-fujita.tomonor=
i@gmail.com/
> - use page pool API for rx allocation
> - fix NAPI API misuse
> - fix error checking of mdio write
> v6: https://lore.kernel.org/netdev/20240512085611.79747-2-fujita.tomonor=
i@gmail.com/
> - use the firmware for TN30xx chips
> - move link up/down code to phylink's mac_link_up/mac_link_down callback=
s
> - clean up mdio access code
> v5: https://lore.kernel.org/netdev/20240508113947.68530-1-fujita.tomonor=
i@gmail.com/
> - remove dma_set_mask_and_coherent fallback
> - count tx_dropped
> - use ndo_get_stats64 instead of ndo_get_stats
> - remove unnecessary __packed attribute
> - fix NAPI API usage
> - rename tn40_recycle_skb to tn40_recycle_rx_buffer
> - avoid high order page allocation (the maximum is order-1 now)
> v4: https://lore.kernel.org/netdev/20240501230552.53185-1-fujita.tomonor=
i@gmail.com/
> - fix warning on 32bit build
> - fix inline warnings
> - fix header file inclusion
> - fix TN40_NDEV_TXQ_LEN
> - remove 'select PHYLIB' in Kconfig
> - fix access to phydev
> - clean up readx_poll_timeout_atomic usage
> v3: https://lore.kernel.org/netdev/20240429043827.44407-1-fujita.tomonor=
i@gmail.com/
> - remove driver version
> - use prefixes tn40_/TN40_ for all function, struct and define names
> v2: https://lore.kernel.org/netdev/20240425010354.32605-1-fujita.tomonor=
i@gmail.com/
> - split mdio patch into mdio and phy support
> - add phylink support
> - clean up mdio read/write
> - use the standard bit operation macros
> - use upper_32/lower_32_bits macro
> - use tn40_ prefix instead of bdx_
> - fix Sparse errors
> - fix compiler warnings
> - fix style issues
> v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori=
@gmail.com/
>
> [1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori=
@gmail.com/
>
> FUJITA Tomonori (6):
>    net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
>    net: tn40xx: add register defines
>    net: tn40xx: add basic Tx handling
>    net: tn40xx: add basic Rx handling
>    net: tn40xx: add mdio bus support
>    net: tn40xx: add phylink support
>
>   MAINTAINERS                             |    8 +-
>   drivers/net/ethernet/tehuti/Kconfig     |   15 +
>   drivers/net/ethernet/tehuti/Makefile    |    3 +
>   drivers/net/ethernet/tehuti/tn40.c      | 1771 +++++++++++++++++++++++
>   drivers/net/ethernet/tehuti/tn40.h      |  233 +++
>   drivers/net/ethernet/tehuti/tn40_mdio.c |  143 ++
>   drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
>   drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
>   8 files changed, 2493 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/tehuti/tn40.c
>   create mode 100644 drivers/net/ethernet/tehuti/tn40.h
>   create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
>   create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
>   create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h
>
>
> base-commit: c790275b5edf5d8280ae520bda7c1f37da460c00

Hi Tomonori,

feel free to add my

Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>

to your patch series.
I have also tested your driver, however since I have 10GBASE-T cards
with x3310 and aqr105 phys I had to add a few lines (very few!) to make
them work. Therefore, formally I cannot claim to have tested exactly
your patches.
Once your driver is out, I will post patches for supporting the other phys=
.
Thanks for taking the effort of mainlining this driver!
Best regards,
Hans


