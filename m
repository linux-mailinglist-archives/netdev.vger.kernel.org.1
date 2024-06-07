Return-Path: <netdev+bounces-101731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070EE8FFE37
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 10:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B121A1F26082
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2715B12B;
	Fri,  7 Jun 2024 08:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052515B127;
	Fri,  7 Jun 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749868; cv=none; b=uvNt4b6PoeywYU1HDtKibya33NwbwWolAw0IC7+KRxqrEv2m7jxzr7yo9PZXJ+cxVUg6oxLEWzp2QctaAEU1Ue3n5joEcLAuwcB8asqofcojpXtWnZZKDjpDM5PYZT4Cz0gcGwFNJpdH0Fdgmykk8qQH5mudTqHEPt06GqOfQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749868; c=relaxed/simple;
	bh=ZGIN+3jBdsxYLWxmKjRImDnEocFLP4dx/WNFCIBynME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbL1zrRhU2q5fr6zpFRSGLf4RWl06EFlYc8sLl/HIEO+FvM+ojB0+Dshq3/0WpFVICc3o++ItFTXPK4yRJYfKeKHMrjIlWlioOmCqvc2VJo1dRVoWcMPIinEyncC5KWf3btHNW/gFASUfXMc9ujzy23ptgafG6jLEgc3WSyvO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso29854766b.2;
        Fri, 07 Jun 2024 01:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749865; x=1718354665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4K2z7NbHqX/9YFvaDXUZZSVRNBRpOe0GfnIPk5+1a8=;
        b=GOwscALTrfBD5fV91VjII6Z0sNxJMliAzJnjq7L6BCeWWABbE7yTQ8H3GmRKGcP0cF
         uTkj/BAab8VKSV8RCSDytHncGemkYjhv/uDZArK0Epm5N5LkPe/fmbHWykU6xo89O1t7
         HHO5sOam2VUmRYKoJ1aCzTMtpDtLgZS+fO5c0dRSvwS1ix3veDz9NDeR+IiB/ntEo8Lw
         U9slFy6F5RXb1frbfqxc4vZF4Rh+CyjbOArWQjCVcTufBnOkur5EQF2GnMquczhJrG0J
         QEm5QDLqFHFNSnWy+Iq/M3QBwQNY9K1CO2gjhZw3PrSFFt+vfpCrzbLP9qppsmbVxkfF
         kLcg==
X-Forwarded-Encrypted: i=1; AJvYcCWSfQH1bj9QiJSeDuedOQxl+1HxV9LwMFVjoD1GzNK1+sLKqm71OsY0V+tEZAmL2OWhcwzYpZC7xhdSPOD0E2n127pRsXg7UC8Ck3g8
X-Gm-Message-State: AOJu0YxXBj5/4QGduY+3+gZ9H9VXoEgIurN+nO+4w6BhmNVFBX8LUEMD
	ytuQf7Hh9I0xgCwh3sQQBOYWIT/pgKYJ1DgWrciZUFTo8jA/9FDK
X-Google-Smtp-Source: AGHT+IGOC8WKarSr1SDF9TztrVJzc005LX9HyTpLCm0LyrrM3frfZSG9Ck0GQ0GWIsIAS7ooPUM9IA==
X-Received: by 2002:a17:906:2bdb:b0:a68:bcf6:5a57 with SMTP id a640c23a62f3a-a6cd7891d48mr130532966b.44.1717749865361;
        Fri, 07 Jun 2024 01:44:25 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805f6e3bsm214832466b.92.2024.06.07.01.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 01:44:24 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	sbhatta@marvell.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] ip_tunnel: Move stats allocation to core
Date: Fri,  7 Jun 2024 01:44:19 -0700
Message-ID: <20240607084420.3932875-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core instead
of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Move ip_tunnel driver to leverage the core allocation.

All the ip_tunnel_init() users call ip_tunnel_init() as part of their
.ndo_init callback. The .ndo_init callback is called before the stats
allocation in netdev_register(), thus, the allocation will happen before
the netdev is visible.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/ip_tunnel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index bccef2fcf620..5cffad42fe8c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1099,7 +1099,6 @@ static void ip_tunnel_dev_free(struct net_device *dev)
 
 	gro_cells_destroy(&tunnel->gro_cells);
 	dst_cache_destroy(&tunnel->dst_cache);
-	free_percpu(dev->tstats);
 }
 
 void ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
@@ -1313,20 +1312,15 @@ int ip_tunnel_init(struct net_device *dev)
 
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = ip_tunnel_dev_free;
-	dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!dev->tstats)
-		return -ENOMEM;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
-	if (err) {
-		free_percpu(dev->tstats);
+	if (err)
 		return err;
-	}
 
 	err = gro_cells_init(&tunnel->gro_cells, dev);
 	if (err) {
 		dst_cache_destroy(&tunnel->dst_cache);
-		free_percpu(dev->tstats);
 		return err;
 	}
 
-- 
2.43.0


