Return-Path: <netdev+bounces-48748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CB7EF67D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033451C20AF4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B9343152;
	Fri, 17 Nov 2023 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20230601.gappssmtp.com header.i=@ragnatech-se.20230601.gappssmtp.com header.b="QFcJLbTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52F10C6
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3185195e87.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 08:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1700239493; x=1700844293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eA55YfApAKQilOmSxAi1H7xzp3FySlfaXmMF1pFLUMY=;
        b=QFcJLbTdE97VdTsGwBYOgP2MXlO+T5q6LA0On2Mlq462IXQfbiRTh2DXfievKoRQew
         ZMMxdIbr3VQu/McvZhAjv+dUJ2XWxch55L1t/eBwH6ISw/0XEY8RuEXLDKpYLqH4sYzk
         7c2iD5c88sn5Vficf4N/bFt5WirVmKUF+EjlwqQU4B7HnJTNmx/8qojGexXumJxtFT6a
         O1S+gkZuFoloHEFZ/ymY1a1C7nGIoSp04r58N7dNiaexdFW4UnGPGB+0KykHLybMal9f
         P65oCDPhIGSldT74U0YTO9jZghaVYOmgMVV+0Wg3pad0r6fBlMzUainLe3Ax7g0ee6f9
         suBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239493; x=1700844293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eA55YfApAKQilOmSxAi1H7xzp3FySlfaXmMF1pFLUMY=;
        b=ewswfPokq7XhWg6mFLtXyzFF9ApcEJgMjXMUdbAroUE/NYgwDs3W1iezOLh8tLQCkU
         FLU6DiNKkx5bK89gAg7kuW8QcYeHRZ0+900GSFskF2Lc5A/Jdvq+ak9FQkjP2c9jR/18
         v7UMwpN3kpeMwybFkJVLy/6jz5nUgR8UDs4ieNgBfjXgATK0sCnM8UmIgXIjlopBEIbK
         S4wyCgRNs6OINQxgyrf/ti3uJ2qQsVvKUfGLc/Wb3Rp4xmbOI2Zk+pbmw7SoKZlqIxtD
         4uxosz/lVtfxZVDwTc4sv+KLIOdXXTSXjrPrFFPWtU9jXgBhmP6wiCos9y3Z13alOCav
         fhPg==
X-Gm-Message-State: AOJu0YyynbRH5NK90Uqy+t+3fAuj3CkivJcwW75LIKGoVRaveB4kD/KV
	MuILJRrO+O8d78AqVbZlhlWRqA==
X-Google-Smtp-Source: AGHT+IF7UiC+QJF2Sk0XRI5G1Yt+AuSSfCDAgbG01W6BdSxNi7LKOZ0bq+GUwK4QdhoSqckMwsQQFQ==
X-Received: by 2002:ac2:5bdb:0:b0:507:b084:d6bb with SMTP id u27-20020ac25bdb000000b00507b084d6bbmr71517lfn.43.1700239493069;
        Fri, 17 Nov 2023 08:44:53 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8a96.dip0.t-ipconnect.de. [79.204.138.150])
        by smtp.googlemail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm2791947wrn.60.2023.11.17.08.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 08:44:52 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 0/5] net: ethernet: renesas: rcar_gen4_ptp: Add V4H support
Date: Fri, 17 Nov 2023 17:43:27 +0100
Message-ID: <20231117164332.354443-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This small series prepares the rcar_gen4_ptp to be useable both on both 
R-Car S4 and V4H. The only in-tree driver that make use of this is 
rswtich on S4. A new Ethernet (R-Car Ethernet TSN) driver for V4H is on 
it's way that also will make use of rcar_gen4_ptp functionality.

Patch 1-2 are small improvements to the existing driver. While patch 3-4 
adds V4H support. Finally patch 5 turns rcar_gen4_ptp into a separate 
module to allow the gPTP functionality to be shared between the two 
users without having to duplicate the code in each.

Niklas Söderlund (5):
  net: ethernet: renesas: rcar_gen4_ptp: Remove incorrect comment
  net: ethernet: renesas: rcar_gen4_ptp: Fail on unknown register layout
  net: ethernet: renesas: rcar_gen4_ptp: Prepare for shared register
    layout
  net: ethernet: renesas: rcar_gen4_ptp: Add V4H clock setting
  net: ethernet: renesas: rcar_gen4_ptp: Break out to module

 drivers/net/ethernet/renesas/Kconfig         | 10 ++++++++
 drivers/net/ethernet/renesas/Makefile        |  5 ++--
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c | 24 +++++++++++++++-----
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h | 13 +++++++----
 drivers/net/ethernet/renesas/rswitch.c       |  2 +-
 5 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.42.1


