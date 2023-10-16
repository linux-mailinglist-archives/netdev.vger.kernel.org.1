Return-Path: <netdev+bounces-41514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D77CB2CD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA931F226A3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8122C28DDF;
	Mon, 16 Oct 2023 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="JoxsBoYC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFD339AE
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:44:03 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD895
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:44:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso32622925ad.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697481841; x=1698086641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWPwKWdwEDWr14soGfGjK+ZMfIWI4sV0shfvtifNth4=;
        b=JoxsBoYCGtAKRr54+gjwXBghXQ4Z7IkReSrrYZ9HU6xdDOZb80KZQRAYQ+9zZW3TBC
         f/S0eb5jn0nfRx9xHEeTZZ0C8Q8yknty3DWGmJJDoB3DiRdMtY2DuSn+dBqBv0TTDzv8
         byaiS8QgtpqIODo5Wt+r70EhC+ES1pE9ks1zvTi7UqhOXTJ7gGuN4LAyzVGeVPKoG7zG
         lFisHva7eigWn0t2g5Ykhk0tpiMZCZblF5wzAZg6GIGQ0BVQy0nIQ9nKvWk+XprzTT6J
         DLJIfb2C4QITuiZcE8Ac0GeatQvLFdQ4ysWQ1C6Lr93HtOZTAZiPgx5zayXjhEZXOVVl
         6hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481841; x=1698086641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWPwKWdwEDWr14soGfGjK+ZMfIWI4sV0shfvtifNth4=;
        b=YKl9nWAmcS1Dx98nn5iRIDuiTNEphrnC2uksvho/eJ8BqbBbTxWeNxDsg3PFw3Oc8/
         +TqzroIu9UgnxAr9IryI9nCWInf3ClLWIU36/6tvX7R0dld90j19oeNIptcFQqWS3eOz
         Ou25x72Jhf0mdivfJ2/uGlDRPlnGQGoVqChlWuWcLqfgJXXoyjvjbHtEaxMkYzffpEdL
         V9pvewcmI3ZUx23YrPH3TaaHNayFjV64nK60Lqjz8ymPEKOExfWyRVE4F1tkVCiSf4Q3
         q1kk1Xh8gF2idIxJWMgXnQk7YCeBkwPE46lPlRCsX9ezsa7bWe1Y2YVf4f8J8YWIN/fZ
         QH0Q==
X-Gm-Message-State: AOJu0YwvrB7MmASBtejXHhHlONU0kyR8J3FUMbelF8JS2G/uo/0d0FvT
	DtZzxs8DuiK70WWSeXvhc/tMjQ==
X-Google-Smtp-Source: AGHT+IGucQoCZs8kTZnj0f3ie00/OA9unIXta+jTJIF0CrgPJLPUzjNG/AdQ/PNJ+6EGSQOwKZqksw==
X-Received: by 2002:a17:902:ea0e:b0:1c5:befa:d81d with SMTP id s14-20020a170902ea0e00b001c5befad81dmr138756plg.10.1697481841470;
        Mon, 16 Oct 2023 11:44:01 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001c61acd5bd2sm8816708plg.112.2023.10.16.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:44:01 -0700 (PDT)
Date: Mon, 16 Oct 2023 11:43:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support)
Subject: Re: [PATCH net-next v4 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231016114359.096728c3@hermes.local>
In-Reply-To: <20231016164742.264613-2-florian.fainelli@broadcom.com>
References: <20231016164742.264613-1-florian.fainelli@broadcom.com>
	<20231016164742.264613-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 16 Oct 2023 09:47:41 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> Use more inclusive terms throughout the DSA subsystem by moving away
> from "master" which is replaced by "conduit" and "slave" which is
> replaced by "user". No functional changes.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  .../bindings/net/dsa/mediatek,mt7530.yaml     |    2 +-
>  Documentation/networking/dsa/b53.rst          |   14 +-
>  Documentation/networking/dsa/bcm_sf2.rst      |    2 +-
>  .../networking/dsa/configuration.rst          |  100 +-
>  Documentation/networking/dsa/dsa.rst          |  162 +-
>  Documentation/networking/dsa/lan9303.rst      |    2 +-
>  Documentation/networking/dsa/sja1105.rst      |    6 +-
>  .../dts/marvell/armada-3720-espressobin.dtsi  |    2 +-
>  drivers/net/dsa/b53/b53_common.c              |    4 +-
>  drivers/net/dsa/b53/b53_mdio.c                |    2 +-
>  drivers/net/dsa/bcm_sf2.c                     |   36 +-
>  drivers/net/dsa/bcm_sf2.h                     |    2 +-
>  drivers/net/dsa/bcm_sf2_cfp.c                 |    4 +-
>  drivers/net/dsa/lan9303-core.c                |    4 +-
>  drivers/net/dsa/lantiq_gswip.c                |   34 +-
>  drivers/net/dsa/microchip/ksz9477.c           |    6 +-
>  drivers/net/dsa/microchip/ksz_common.c        |   20 +-
>  drivers/net/dsa/microchip/ksz_ptp.c           |    2 +-
>  drivers/net/dsa/mt7530.c                      |   16 +-
>  drivers/net/dsa/mv88e6xxx/chip.c              |    2 +-
>  drivers/net/dsa/ocelot/felix.c                |   68 +-
>  drivers/net/dsa/ocelot/felix.h                |    6 +-
>  drivers/net/dsa/qca/qca8k-8xxx.c              |   50 +-
>  drivers/net/dsa/qca/qca8k-common.c            |    2 +-
>  drivers/net/dsa/qca/qca8k-leds.c              |    6 +-
>  drivers/net/dsa/qca/qca8k.h                   |    2 +-
>  drivers/net/dsa/realtek/realtek-smi.c         |   28 +-
>  drivers/net/dsa/realtek/realtek.h             |    2 +-
>  drivers/net/dsa/sja1105/sja1105_main.c        |    4 +-
>  drivers/net/dsa/xrs700x/xrs700x.c             |   12 +-
>  drivers/net/ethernet/broadcom/bcmsysport.c    |    2 +-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c   |    2 +-
>  .../net/ethernet/mediatek/mtk_ppe_offload.c   |    2 +-
>  include/linux/dsa/sja1105.h                   |    2 +-
>  include/net/dsa.h                             |   56 +-
>  include/net/dsa_stubs.h                       |   22 +-
>  net/core/dev_ioctl.c                          |    2 +-
>  net/dsa/Makefile                              |    6 +-
>  net/dsa/{master.c => conduit.c}               |  118 +-
>  net/dsa/conduit.h                             |   22 +
>  net/dsa/dsa.c                                 |  224 +--
>  net/dsa/dsa.h                                 |   12 +-
>  net/dsa/master.h                              |   22 -
>  net/dsa/netlink.c                             |   14 +-
>  net/dsa/port.c                                |  124 +-
>  net/dsa/port.h                                |    4 +-
>  net/dsa/slave.h                               |   69 -
>  net/dsa/switch.c                              |   20 +-
>  net/dsa/switch.h                              |    8 +-
>  net/dsa/tag.c                                 |   10 +-
>  net/dsa/tag.h                                 |   26 +-
>  net/dsa/tag_8021q.c                           |   22 +-
>  net/dsa/tag_8021q.h                           |    2 +-
>  net/dsa/tag_ar9331.c                          |    4 +-
>  net/dsa/tag_brcm.c                            |   14 +-
>  net/dsa/tag_dsa.c                             |    6 +-
>  net/dsa/tag_gswip.c                           |    4 +-
>  net/dsa/tag_hellcreek.c                       |    4 +-
>  net/dsa/tag_ksz.c                             |   12 +-
>  net/dsa/tag_lan9303.c                         |    4 +-
>  net/dsa/tag_mtk.c                             |    4 +-
>  net/dsa/tag_none.c                            |    6 +-
>  net/dsa/tag_ocelot.c                          |   22 +-
>  net/dsa/tag_ocelot_8021q.c                    |   12 +-
>  net/dsa/tag_qca.c                             |    6 +-
>  net/dsa/tag_rtl4_a.c                          |    6 +-
>  net/dsa/tag_rtl8_4.c                          |    6 +-
>  net/dsa/tag_rzn1_a5psw.c                      |    4 +-
>  net/dsa/tag_sja1105.c                         |   30 +-
>  net/dsa/tag_trailer.c                         |    4 +-
>  net/dsa/tag_xrs700x.c                         |    4 +-
>  net/dsa/{slave.c => user.c}                   | 1464 ++++++++---------
>  net/dsa/user.h                                |   69 +
>  73 files changed, 1541 insertions(+), 1537 deletions(-)
>  rename net/dsa/{master.c => conduit.c} (76%)
>  create mode 100644 net/dsa/conduit.h
>  delete mode 100644 net/dsa/master.h
>  delete mode 100644 net/dsa/slave.h
>  rename net/dsa/{slave.c => user.c} (62%)
>  create mode 100644 net/dsa/user.h

Thanks for doing this.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

