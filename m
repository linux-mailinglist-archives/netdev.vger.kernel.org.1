Return-Path: <netdev+bounces-124561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDED969FDC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714E51C22F36
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27386482E2;
	Tue,  3 Sep 2024 14:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9591CA69D;
	Tue,  3 Sep 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372488; cv=none; b=iCAdEqIw9jNwDpsq7vGGyp8JPx68gedF3h3BVnvNRyeB4swbthKAuWB1FM2Fi3xaTKTgU++doUflwJ7mo9Jle8Brd+NphFnBPb94/SEW+UBnoYomA0+0kzKc/vdDx9Vpc1yBbjWyn9Fb+hpKFZnus0FOKY5naLMhI3eIwWKJBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372488; c=relaxed/simple;
	bh=yo2ngucoohaz4ZVlQSokhpzKAWCl9YfjIgSeu9P5Z9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCpQfIW7comfCtKfrPE3fn6g29AYMiuvO68Ywk5GKBaRU/SaZKIopgAEFmYIwKXGvLBlNuRCFhcD2jTwLNQare+QLKcfUo6LoUOQEuPIjoRF+nj/PgTv+/QhEHq6lfyuxlXgFab7rxfstSoLISKPniPZ/W1a6N8/1VWDMKBTNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86abbd68ffso891175266b.0;
        Tue, 03 Sep 2024 07:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372485; x=1725977285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlldsvThyQe+t9ooRgmvSM2+Zu0mVfH7lLG856mOXwI=;
        b=Q3fe//lVYPtmTTKWYM5bd48P8tltv13grL/So5USxcC/E0zOSO7r3UvFFiBGmeAbfv
         22ZwMk6WRviRNT+kcwHuKQyaIOAhqG8KOzfcttwZr4L8pphK3iqqjHEybp437EWlRtVu
         P42qwiOI06R1/yYLadIE2pnbEbgh26iabs1Qs8dCgUlhJ39XI8NrQ0gLx+m23ryEAy57
         udd9j/zYnXqZzTPLY/FiJRTa7+vJePODwOnmxAYbVJ6nmGX2vo20YYb1w39abfsWUp1e
         zYQDfWhPoxSKZvCTKqn4D4VEBF11OumuddcQGA2MuFW4+/RiFkdQhODmhAXHGXsdRWzf
         HJSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNHF0saFw5EHd7zM3WI1WorjG//d/jcHrCEpKBJP9GM8+bzn/fdsXQZmglyp3o65346qAucUIS@vger.kernel.org, AJvYcCXs53P6Ui9m8yEdvLhekKo3o4VZ3st2/Mc/ziHRckVxR5uWgTtWxYyrAAYmd4C6eXXs4XuILvgVce/tnTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCzFXjXrBQukIMb5fQqTOjvJnKDqJCbZH58jYEOizKiHgg23a
	wYGIeFb6DsJXmw58YUy21Q01nqqQ4INmspzAuqlPRbwdZXljAE3o
X-Google-Smtp-Source: AGHT+IGIs9UmHV9t20hb0PFDHL0XL5gO3zPLO9/lSmMqoTuSw5wIrr+UGbjHd67tH4xJpeowfs9XHw==
X-Received: by 2002:a17:907:94d6:b0:a75:7a8:d70c with SMTP id a640c23a62f3a-a89a249c510mr1345137066b.4.1725372484234;
        Tue, 03 Sep 2024 07:08:04 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d8117sm694239266b.172.2024.09.03.07.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 1/9] net: netconsole: remove msg_ready variable
Date: Tue,  3 Sep 2024 07:07:44 -0700
Message-ID: <20240903140757.2802765-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable msg_ready is useless, since it does not represent anything. Get
rid of it, using buf directly instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01cf33fa7503..03150e513cb2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1075,7 +1075,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
-	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
 	int userdata_len = 0;
@@ -1105,8 +1104,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     MAX_PRINT_CHUNK - msg_len,
 					     "%s", userdata);
 
-		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp(&nt->np, buf, msg_len);
 		return;
 	}
 
-- 
2.43.5


