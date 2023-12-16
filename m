Return-Path: <netdev+bounces-58214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7481E8158CC
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656B2B2400C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53869154A9;
	Sat, 16 Dec 2023 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc/sHShb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADD18040
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a232e9f0ca9so10937566b.1
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 03:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702726009; x=1703330809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt6QS+gMUxFf6hAvwoyNks7iQ8znNP0zxhVoIyqc0rY=;
        b=dc/sHShbuoWBUCRnVH5i/2vZN0bq03+REDjaTvD6QyM8vmfPnql/4+a/7kHoj5ka5k
         AG1JdwlqLUOPr6PitfND4PTN0LiEoaQBYpEFvZbMQFTa6ZICuvgL5AFd3qrwYofTpKEI
         PvA1jheLOOA+VCkCPKbGoD2pIJaWJIYqbrGjP+MqcvUeWNSEdyVpQZps3uH9oYcdamTW
         zdtLMbpRXTJx3kiu66u9YZkUKHw8gn/zQWXsBTyV4TpPOwAmSD1Iy3mp4/4aJBBrd874
         mBgMax0sDSue+IGYt1BbjVyjPsQlmXNX2cnJEUxS0+p66vfekc3w5tNyfvI6iKKRPFjO
         EcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702726009; x=1703330809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt6QS+gMUxFf6hAvwoyNks7iQ8znNP0zxhVoIyqc0rY=;
        b=OKls1+tWcAQQDjwmzU0IHTZeFfXwooeKkw6AsYuExePvMJEM4bVpZfzA0KIhvOae0H
         NYGNr0FtMrRoTzkg81hqySQ+GaTxws873ZenzXF95iKReT66TF5q3NK/v7t+/Wge+qdZ
         fcXxv11Uk6MOBrCyay22E6swwltjw36GYtpBUtC2MDbeRTc9zEGX7aA9DCJMjq2wT02X
         V72iltbNjHOMRC29iBG6ZGSj2L4c9pSbOKaqTpdwVNhxkaHzYhVJ3C+ZvOlbsqXMwhqw
         VhzIjsE52hT5l1hv5SrdlCgTHqBCXDTq4EvxXNi57OGHqEL9Tj+/4bhJumw0fRIlcvkD
         uAYw==
X-Gm-Message-State: AOJu0YyT8UNWv39XzBxdDQudJ29e7OoDWZH3LicZEoJi+MAbfIH4so++
	QKmH16vHa+n+TMCpQJb7vBQ=
X-Google-Smtp-Source: AGHT+IGES/sn6jdjBxPEEn6I6qhpsqIS/BcqNy6kMO0KcCazOR0Iqttjp2kY83xfQOohIN5sIeoP4Q==
X-Received: by 2002:a17:906:d282:b0:9fe:81a:c258 with SMTP id ay2-20020a170906d28200b009fe081ac258mr7761669ejb.26.1702726008741;
        Sat, 16 Dec 2023 03:26:48 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00982a92a849asm11866504ejc.91.2023.12.16.03.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:26:48 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH net-next] net: pktgen: Use wait_event_freezable_timeout() for freezable kthread
Date: Sat, 16 Dec 2023 19:26:32 +0800
Message-Id: <20231216112632.2255398-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A freezable kernel thread can enter frozen state during freezing by
either calling try_to_freeze() or using wait_event_freezable() and its
variants. So for the following snippet of code in a kernel thread loop:
  wait_event_interruptible_timeout();
  try_to_freeze();

We can change it to a simple wait_event_freezable_timeout() and then
eliminate a function call.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 net/core/pktgen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 57cea67b7562..2b59fc66fe26 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3669,10 +3669,8 @@ static int pktgen_thread_worker(void *arg)
 		if (unlikely(!pkt_dev && t->control == 0)) {
 			if (t->net->pktgen_exiting)
 				break;
-			wait_event_interruptible_timeout(t->queue,
-							 t->control != 0,
-							 HZ/10);
-			try_to_freeze();
+			wait_event_freezable_timeout(t->queue,
+						     t->control != 0, HZ/10);
 			continue;
 		}
 
-- 
2.39.2


