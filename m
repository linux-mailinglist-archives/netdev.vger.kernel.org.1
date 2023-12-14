Return-Path: <netdev+bounces-57469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F09F81322D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2CBEB21995
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371BA59E37;
	Thu, 14 Dec 2023 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="2EGtkTxp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE2125
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:55 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2cc47f1e829so3207351fa.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702561853; x=1703166653; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8dphjj7mK2d5prA5vtE9dCFx9BvvXqvLp7Qq2OB3qyU=;
        b=2EGtkTxpy81VphOZkLDQjEkC71Flm9hyk5VGuSI0L2sr/9dRHXqCbN/+b9QXoY5tao
         y5bPNhwJ5oN4w5l5Y/fqHyxuLli9R0cva0JT2zqbBNkfSgvUCHyfA9rKYwx8CGL7q7Pn
         4CpK0kQsHCU+qAUECqoLD0N5xQ++Mr6bxXrLLiHvuOvC3Ci4CeMRPebaZMftN+dtI5I8
         ETvdIfICIY/90uB68rD8x4vwa7vUhqXYLgGBDQqYv+D+kFuI+dmCE9PjdBEEOgIn5Gyk
         XAaugwx6S+CR+DDpsXjHgpSIfkFgyGOF6ZJ8g9pHrF4CMWJPp2l+Sc2B/1IV+ijZiyEL
         xVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561853; x=1703166653;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dphjj7mK2d5prA5vtE9dCFx9BvvXqvLp7Qq2OB3qyU=;
        b=XXqAExNV4f+n3RXcRH/sJ16Bm73Lbjbj+uFgtXgVSidhdEIh9eQ5jfstDukTG90PhW
         esmpsWSkrNQshtw/d4kGtI4v7B+4ct0CoCRY3/1SeNN/A7OKqcLDrG6H4iEG9c1oQNk4
         sZH6xBFEuUfMbITd6XrKFWACHokYe+KL/m8iSG47xdaZuHhtsxSKsLzkwodv9SMOCjFB
         ktbiCfJCEgwPGw+Okle3igHbaabI2t3UndwIimPvC8i8Ba9jbvJQR61LRvhZDqn8LOTr
         /U7WW435LNN2vQW07trZOypfQfx+ILy1GLFWy09ti5A73ZTvaW/ZT+xOjDO4efAoUmng
         aKmw==
X-Gm-Message-State: AOJu0YyXUlK+tTCy73pVPbfXdHcR0nK8CJQ7YMkhklp7a07fp9WkP3oN
	4LAsC5aEQXPJL688zX6IeT7xCA==
X-Google-Smtp-Source: AGHT+IHkgvVp6iuD8rLWzkkZ72La4Oal8C2RABFvWUGReIUwgVSBvPjynUCtBL0WuzZT7wQE3F4+WQ==
X-Received: by 2002:a2e:a4ce:0:b0:2cc:1ff3:bc19 with SMTP id p14-20020a2ea4ce000000b002cc1ff3bc19mr3639384ljm.45.1702561853541;
        Thu, 14 Dec 2023 05:50:53 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc258b5491sm1154010ljf.10.2023.12.14.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:50:52 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH v4 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram counters to ingress traffic
Date: Thu, 14 Dec 2023 14:50:27 +0100
Message-Id: <20231214135029.383595-7-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214135029.383595-1-tobias@waldekranz.com>
References: <20231214135029.383595-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Chips in this family only have one set of histogram counters, which
can be used to count ingressing and/or egressing traffic. mv88e6xxx
has, up until this point, kept the hardware default of counting both
directions.

In the mean time, standard counter group support has been added to
ethtool. Via that interface, drivers may report ingress-only and
egress-only histograms separately - but not combined.

In order for mv88e6xxx to maximize amount of diagnostic information
that can be exported via standard interfaces, we opt to limit the
histogram counters to ingress traffic only. Which will allow us to
export them via the standard "rmon" group in an upcoming commit.

The reason for choosing ingress-only over egress-only, is to be
compatible with RFC2819 (RMON MIB).

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 6 +++---
 drivers/net/dsa/mv88e6xxx/global1.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 627ed0d8be94..9e365364a34a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1221,7 +1221,7 @@ static size_t mv88e6095_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
@@ -1233,7 +1233,7 @@ static size_t mv88e6250_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port, 0,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
@@ -1246,7 +1246,7 @@ static size_t mv88e6320_stats_get_stat(struct mv88e6xxx_chip *chip, int port,
 
 	*data = _mv88e6xxx_get_ethtool_stat(chip, stat, port,
 					    MV88E6XXX_G1_STATS_OP_BANK_1_BIT_9,
-					    MV88E6XXX_G1_STATS_OP_HIST_RX_TX);
+					    MV88E6XXX_G1_STATS_OP_HIST_RX);
 	return 1;
 }
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 174c773b38c2..49444a72ff09 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -462,8 +462,7 @@ int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip)
 int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 {
 	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6390_G1_CTL2_HIST_MODE_MASK,
-				      MV88E6390_G1_CTL2_HIST_MODE_RX |
-				      MV88E6390_G1_CTL2_HIST_MODE_TX);
+				      MV88E6390_G1_CTL2_HIST_MODE_RX);
 }
 
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index)
@@ -491,7 +490,7 @@ int mv88e6095_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	val |= MV88E6XXX_G1_STATS_OP_HIST_RX_TX;
+	val |= MV88E6XXX_G1_STATS_OP_HIST_RX;
 
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_STATS_OP, val);
 
@@ -506,7 +505,7 @@ int mv88e6xxx_g1_stats_snapshot(struct mv88e6xxx_chip *chip, int port)
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_STATS_OP,
 				 MV88E6XXX_G1_STATS_OP_BUSY |
 				 MV88E6XXX_G1_STATS_OP_CAPTURE_PORT |
-				 MV88E6XXX_G1_STATS_OP_HIST_RX_TX | port);
+				 MV88E6XXX_G1_STATS_OP_HIST_RX | port);
 	if (err)
 		return err;
 
-- 
2.34.1


