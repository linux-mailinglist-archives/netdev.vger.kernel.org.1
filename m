Return-Path: <netdev+bounces-62199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC508261E2
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05141C20F71
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA9F9F9;
	Sat,  6 Jan 2024 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEVndtLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C210786
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso726931a12.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704579470; x=1705184270; darn=vger.kernel.org;
        h=content-transfer-encoding:to:autocrypt:subject:from:cc
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UblO/NdiuErvMde9G9KUtmv0Ap6N0eUv5Zd8l4sIQvI=;
        b=QEVndtLMljvsp/GASL8ILBYamBiGjw//+/Cg7ZlEfElgAzWVAcR6d5NIA++M+PLJpw
         Yri5djcUQ7oCo3ffXzAIXy4hKdxuJJNwcIWtKvxiYikN5ERLySvWlMfR40VDgArDsZQ3
         t++fBw9ATkWBWBWG7wZtJjGDk4L0z0R2dxnth0pMINEUFdwCCpNgjBjIgS/meM2NOip1
         5tIhfK0b1mELiHg80H/k2HHlqeHLLhM8PtUoy8tCnfXtgIpxZ+O9a0ktKgM+Y/DsFJ71
         2bc970IWEmcUGK85WgxbNA+cTf5wMJidWmPA6aqWRUDSvV6lrmEuMHUAkApS0YrJCWuM
         yp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579470; x=1705184270;
        h=content-transfer-encoding:to:autocrypt:subject:from:cc
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UblO/NdiuErvMde9G9KUtmv0Ap6N0eUv5Zd8l4sIQvI=;
        b=ln/MJSlx8YZVHmJS0vUORFqyLh5vmbbJ30feyfDA8CB0ompuzlTrSecXNhi/0husmG
         7SN3su+eQhV6cE4kmSgycyt4Lj3KB3QqB+pagL5GGSnK5QI3l0/5sjXXLx1B2ukQlUgz
         aajuNw3v/BJPXQau6YwedgVb379g9hL3vccfs5c7n7k4Hl/NST5N9ZENH5y7Mdoozo9+
         STwQ6UYacAM8jjahK3LSdMZW18bHr28MrPC9ot9i43V6QvkP0OOS5fbuz6I6n2HOdP3/
         T53p4BdgfJXDdpIo00p90idydmA4C2ONSZ8DZRdaZb6JaqINPzl5fCZl/Lmm8lX7Fbkr
         Dacg==
X-Gm-Message-State: AOJu0Yy4Dwm91cRDMzKoRjkPIt7pcTU+KA8lGynouWobicIQ14xjAxYl
	5vW66dgDV8SDezEw5BlUGUU=
X-Google-Smtp-Source: AGHT+IEjXf3/1ImF3FEeUgiZW+GufP544i1SapHspHwWnMJjnwLh8f2JpTvEGBBuvrjPZMyRcOTlGw==
X-Received: by 2002:a17:907:597:b0:a2a:fe2:578a with SMTP id vw23-20020a170907059700b00a2a0fe2578amr344789ejb.67.1704579469577;
        Sat, 06 Jan 2024 14:17:49 -0800 (PST)
Received: from ?IPV6:2a01:c22:7310:c700:9da3:cda2:7a2c:5dba? (dynamic-2a01-0c22-7310-c700-9da3-cda2-7a2c-5dba.c22.pool.telefonica.de. [2a01:c22:7310:c700:9da3:cda2:7a2c:5dba])
        by smtp.googlemail.com with ESMTPSA id x17-20020a170906297100b00a26e4986df8sm2380056ejd.58.2024.01.06.14.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:17:49 -0800 (PST)
Message-ID: <8d8700c8-75b2-49ba-b303-b8d619008e45@gmail.com>
Date: Sat, 6 Jan 2024 23:17:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 RFC 0/5] ethtool: switch EEE netlink interface to use EEE
 linkmode bitmaps
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
To: Andrew Lunn <andrew@lunn.ch>, Russell King <rmk+kernel@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

So far only 32bit legacy bitmaps are passed to userspace. This makes
it impossible to manage EEE linkmodes beyond bit 32, e.g. manage EEE
for 2500BaseT and 5000BaseT. This series adds support for passing
full linkmode bitmaps between kernel and userspace.

Fortunately the netlink-based part of ethtool is quite smart and no
changes are needed in ethtool. However this applies to the netlink
interface only, the ioctl interface for now remains restricted to
legacy bitmaps.

Next step will be adding support for the c45 EEE2 standard registers
(3.21, 7.62, 7.63) to the genphy_c45 functions dealing with EEE.
I have a follow-up series for this ready to be submitted.

v2:
- now as RFC
- adopt suggestion from Andrew to start with struct ethtool_keee
  being an identical copy of ethtool_eee, and switch all users

Heiner Kallweit (5):
  ethtool: replace struct ethtool_eee with a new struct ethtool_keee on
    kernel side
  ethtool: switch back from ethtool_keee to ethtool_eee for ioctl
  ethtool: adjust struct ethtool_keee to kernel needs
  ethtool: add linkmode bitmap support to struct ethtool_keee
  net: phy: c45: change genphy_c45_ethtool_[get|set]_eee to use EEE
    linkmode bitmaps

 drivers/net/dsa/b53/b53_common.c              | 10 +--
 drivers/net/dsa/b53/b53_priv.h                |  6 +-
 drivers/net/dsa/bcm_sf2.c                     |  2 +-
 drivers/net/dsa/microchip/ksz_common.c        |  4 +-
 drivers/net/dsa/mt7530.c                      |  4 +-
 drivers/net/dsa/mv88e6xxx/chip.c              |  4 +-
 drivers/net/dsa/qca/qca8k-common.c            |  4 +-
 drivers/net/dsa/qca/qca8k.h                   |  4 +-
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |  4 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |  2 +-
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  8 +--
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  8 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  6 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  8 +--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 +-
 drivers/net/ethernet/broadcom/tg3.c           | 10 +--
 drivers/net/ethernet/broadcom/tg3.h           |  2 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |  6 +-
 drivers/net/ethernet/freescale/enetc/enetc.c  |  4 +-
 drivers/net/ethernet/freescale/fec.h          |  2 +-
 drivers/net/ethernet/freescale/fec_main.c     | 10 +--
 drivers/net/ethernet/freescale/gianfar.c      |  4 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |  6 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 +--
 drivers/net/ethernet/intel/igc/igc.h          |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  8 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 10 +--
 drivers/net/ethernet/marvell/mvneta.c         |  4 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  |  4 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  4 +-
 drivers/net/ethernet/realtek/r8169_main.c     |  4 +-
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    |  4 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  4 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   |  4 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c        |  4 +-
 drivers/net/ethernet/ti/cpsw_priv.h           |  4 +-
 drivers/net/ethernet/ti/icssg/icssg_ethtool.c |  4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  2 +-
 drivers/net/phy/marvell.c                     |  2 +-
 drivers/net/phy/phy-c45.c                     | 44 +++++-------
 drivers/net/phy/phy.c                         |  8 +--
 drivers/net/phy/phylink.c                     |  8 +--
 drivers/net/usb/ax88179_178a.c                | 10 +--
 drivers/net/usb/lan78xx.c                     |  4 +-
 drivers/net/usb/r8152.c                       | 14 ++--
 include/linux/ethtool.h                       | 19 ++++-
 include/linux/phy.h                           |  8 +--
 include/linux/phylink.h                       |  4 +-
 include/net/dsa.h                             |  4 +-
 net/dsa/user.c                                |  4 +-
 net/ethtool/common.c                          |  5 ++
 net/ethtool/common.h                          |  1 +
 net/ethtool/eee.c                             | 71 ++++++++++++-------
 net/ethtool/ioctl.c                           | 71 ++++++++++++++++---
 57 files changed, 283 insertions(+), 196 deletions(-)

-- 
2.43.0


