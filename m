Return-Path: <netdev+bounces-40915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF097C91C2
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592F1282986
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF03367;
	Sat, 14 Oct 2023 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FeRlKX+o"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0317E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:27:05 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410BFBE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:27:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9daca2b85so19977085ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697243222; x=1697848022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h951LMewXn+s7IXM8I6VN6t/9c8zi/6NXOasNhvUCHY=;
        b=FeRlKX+oiFtJfDl9bPhhb6/DKCFoKMt34VATDem7yu0UtioDUHHwzTpQqsI5WL/L46
         uz3AacgQ8AlDc0iuqwEN/misigFXGmedSiGTDQwez7AHywWPuQd87S79a1C7bIME45um
         GgDsJ2RMHh300w2AmW/5oKoW74vGuTC/MsfOxhxBvgboI4X+0z+aWsFjrFPtyouR6F4M
         BvXKoFrHft1pJB+HquaIXOSM+bOQqtXytAKVy1lzA5x92G8cu0Bq+j97wJ+X2vvMiqX4
         MeaqbgjJYHWY633dPaBurBp5OQ03lR297t/r1c4JcXUZ6+2rWHdnG5Sw/u8Hh8W66BbS
         OBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697243222; x=1697848022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h951LMewXn+s7IXM8I6VN6t/9c8zi/6NXOasNhvUCHY=;
        b=i3r4XCNsXzbHulQ/PaKjhExn0qIQizTnMUZrQnyKFuUPDrDSaNs+Tw5dTxbUAG96bQ
         Kxk7ezf1OCQY3TxI7hcKNQ/E2HcXZeWMN1BfaPib+QudyMHcZPBIJOrzsoRQpRqGn/5Y
         c9H6Mvpwp8mt8kvJre/pXr2z33JA2o7m9m4ERpKmu+Qf9foXCMRqHhIy329EdEcbO1GF
         vT40QAEQG5UNIl2Kh7qYqwaNuWELgQV3D9E757fLS7fTlbGMzsvCiBoUrG8A++X21OMb
         nWgfQN8bOplbeiFpIAih5H1sdepAQYv3Zy4xedLZa3CO7zyEnsm8wDc8ZkYkaUti55iY
         hwog==
X-Gm-Message-State: AOJu0YwtKXCHxvwk+HkE3PhfM/VU9qF4Aii8OmHAeSSf+bUhsXBk1JxK
	Lv4aCKYHa7j46EZD+rWHxWkD2A==
X-Google-Smtp-Source: AGHT+IH5t1f+cgbEN0NasFfdvSF8aJa0oFyo6n1BQ1IJ6ddA6P+N5o+MmDwISk4BBCp+Vy/D+3hR2w==
X-Received: by 2002:a17:903:32c4:b0:1b8:8682:62fb with SMTP id i4-20020a17090332c400b001b8868262fbmr2538812plr.4.1697243221703;
        Fri, 13 Oct 2023 17:27:01 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id k1-20020aa79d01000000b00666e649ca46sm1381476pfp.101.2023.10.13.17.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 17:27:01 -0700 (PDT)
Date: Fri, 13 Oct 2023 17:26:59 -0700
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
Subject: Re: [PATCH net-next v3 0/2] Switch DSA to inclusive terminology
Message-ID: <20231013172659.27cea145@hermes.local>
In-Reply-To: <20231013215251.152912-1-florian.fainelli@broadcom.com>
References: <20231013215251.152912-1-florian.fainelli@broadcom.com>
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

On Fri, 13 Oct 2023 14:52:49 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> One of the action items following Netconf'23 is to switch subsystems to
> use inclusive terminology. DSA has been making extensive use of the
> "master" and "slave" words which are now replaced by "conduit" and
> "user" respectively.
> 
> Changes in v3:
> - properly align arguments with the changed function names
> - ensure markup delimiters lengths are corrected to the name word length
> - maintain the existing wording about LAG devices
> 
> Changes in v2:
> 
> - addressed kbuild test robots reports
> - preserve capitalization where relevant
> - fixed build error in mtk_ppe_offload.c
> 
> Florian Fainelli (2):
>   net: dsa: Use conduit and user terms
>   net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT
> 
>  .../bindings/net/dsa/mediatek,mt7530.yaml     |    2 +-
>  Documentation/networking/dsa/b53.rst          |   14 +-
>  Documentation/networking/dsa/bcm_sf2.rst      |    2 +-
>  .../networking/dsa/configuration.rst          |  102 +-
>  Documentation/networking/dsa/dsa.rst          |  156 +-
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
>  include/uapi/linux/if_link.h                  |    4 +-
>  net/core/dev_ioctl.c                          |    2 +-
>  net/dsa/Makefile                              |    6 +-
>  net/dsa/{master.c => conduit.c}               |  118 +-
>  net/dsa/conduit.h                             |   22 +
>  net/dsa/dsa.c                                 |  222 +--
>  net/dsa/dsa.h                                 |   12 +-
>  net/dsa/master.h                              |   22 -
>  net/dsa/netlink.c                             |   22 +-
>  net/dsa/port.c                                |  124 +-
>  net/dsa/port.h                                |    4 +-
>  net/dsa/slave.h                               |   69 -
>  net/dsa/switch.c                              |   18 +-
>  net/dsa/switch.h                              |    4 +-
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
>  net/dsa/{slave.c => user.c}                   | 1462 ++++++++---------
>  net/dsa/user.h                                |   69 +
>  74 files changed, 1539 insertions(+), 1537 deletions(-)
>  rename net/dsa/{master.c => conduit.c} (76%)
>  create mode 100644 net/dsa/conduit.h
>  delete mode 100644 net/dsa/master.h
>  delete mode 100644 net/dsa/slave.h
>  rename net/dsa/{slave.c => user.c} (62%)
>  create mode 100644 net/dsa/user.h

After applying both patches, Ran script to check for non-inclusive naming.

net/dsa/conduit.c:      if (netif_is_lag_master(dev))
net/dsa/conduit.c:      if (netif_is_lag_master(dev))
net/dsa/conduit.c:      if (!netif_is_lag_master(dev)) {
net/dsa/dsa.c:  dsa_tree_notify(dst, DSA_NOTIFIER_MASTER_STATE_CHANGE, &info);
net/dsa/dsa.c:  if (netif_is_lag_master(conduit))
net/dsa/dsa.c:  if (netif_is_lag_master(conduit))
net/dsa/port.c: bridge_dev = netdev_master_upper_dev_get(lag_dev);
net/dsa/port.c: if (!bridge_dev || !netif_is_bridge_master(bridge_dev))
net/dsa/port.c: dp->cpu_port_in_lag = netif_is_lag_master(conduit);
net/dsa/switch.c:       case DSA_NOTIFIER_MASTER_STATE_CHANGE:
net/dsa/switch.h:       DSA_NOTIFIER_MASTER_STATE_CHANGE,
net/dsa/switch.h:/* DSA_NOTIFIER_MASTER_STATE_CHANGE */
net/dsa/user.c:         if (netif_is_bridge_master(upper))
net/dsa/user.c: if (netif_is_bridge_master(info->upper_dev)) {
net/dsa/user.c: } else if (netif_is_lag_master(info->upper_dev)) {
net/dsa/user.c: } else if (is_hsr_master(info->upper_dev)) {
net/dsa/user.c: if (netif_is_bridge_master(info->upper_dev) && !info->linking)
net/dsa/user.c: else if (netif_is_lag_master(info->upper_dev) && !info->linking)
net/dsa/user.c: if (!netif_is_lag_master(dev))
net/dsa/user.c: if (!netif_is_lag_master(dev))
net/dsa/user.c:     netif_is_bridge_master(info->upper_dev) && info->linking) {
net/dsa/user.c: if (netif_is_bridge_master(info->upper_dev))
net/dsa/user.c: if (netif_is_lag_master(info->upper_dev))
net/dsa/user.c: if (!netdev_uses_dsa(lag_dev) || !netif_is_lag_master(lag_dev))
net/dsa/user.c: if (!netif_is_bridge_master(br))
net/dsa/user.c: if (netif_is_lag_master(info->upper_dev)) {
net/dsa/user.c: if (netif_is_bridge_master(foreign_dev))

So most of the remaining problem is due to bridge and lag.

Still should change the NOTIFIER since it is not in public API.

