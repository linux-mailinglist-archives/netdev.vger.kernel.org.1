Return-Path: <netdev+bounces-110317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AFA92BD53
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DC1B2889D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A119D08E;
	Tue,  9 Jul 2024 14:44:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A219CCF6;
	Tue,  9 Jul 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536259; cv=none; b=GwWgrM+treaIEni6mVAiDitUqxIhDSEC/byyhyoanmbgHAOw7hqPzyB1sRJSMtN1/G85aWw0+9leQObeZogl5dl7EnuDaiKhmx3wKiB0KcX7bbICmUUPi5xfWvpNEj6JqbLO32izlMhwdeQ61iUvaPjnrLt0fukSosK0Nhkn9Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536259; c=relaxed/simple;
	bh=Tvqxjf0N6l3GTpWFwGge2xMlKhD/CeT33iKWyPokJzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTXy6EPr+ABQePLMPGsk5REOD0oXQIE3JORWoP+f1CyCHZ49bs8+oBfxVK8oowLNHGZxmAlIBGPD+ehBkbAR2onMR2ktjaYougOZtOoOyNCReqzkunlEv1mCIJwuvhJ6HnWtJN36PJjpvl6dOSh04Ri7SKK3VKsgIlW+SnK0LH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77e7420697so401098966b.1;
        Tue, 09 Jul 2024 07:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536256; x=1721141056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewtc0gkqH+Jh23Mk4mdXNAHA8fX0PKQF6/iY8Gy51x0=;
        b=VLEY437Df8jH5B7r4sp1KzWEHZZeCOCIJcwZqzaqcCSoT6xBuKOzVlcLEbMuDkQJGt
         sBnwA/lGe7IzkCINpw0TOOkJiCeO4B1qBHaGud22wUjyWD1a+/S12H25qFKHcvHKpYf0
         RkJK5OkruRzRJIjbtBabsp3b4/Fhjq9StIXZStxClo4iUa3FUuQOTRUjj2qH6ZnpjETe
         eyMZ5ztL264jjDwe5y4j1DBBYVdtfIjJ/ELENNcgM3X3Rlw4pgyMZppitgL9TCTbDH6V
         5l0GpLwCiBtP7pZidWxEsg5hNTg9fdC5EKNG9sLMvLioP+Lzife7hMzTROXJrdIvqbrp
         nbxw==
X-Forwarded-Encrypted: i=1; AJvYcCUSPkP6WQCiVMEG9oLi8aaX07xaqSuyeXnzuQ73y1Gzogjeq/ZICb0Ip+bmxIghcY9e+NeZF71BDS+3SKRth7dJHsKZr3UkGsvb4DNacOmLB01howLehtM0DeVHtUHytwViVC1F
X-Gm-Message-State: AOJu0YxX5/4QriQmIhqfmRgmS0+1prEw6ojB12cMA4hts9QtsXugrGPB
	5f8hZKQ/fBSqHim7MKsZQ9y5ETybSgS+/jpjIO0xfOHOTN1BZ+LC
X-Google-Smtp-Source: AGHT+IHnAkfL/ucgW+6bWaBiym6Ym73TFBQDhJUkVFcISYrYyuQQ03BI425zsHWpM/lZeyATW5GmTg==
X-Received: by 2002:a17:906:36d3:b0:a6f:b58f:ae3c with SMTP id a640c23a62f3a-a780b6b1b96mr179372366b.26.1720536255954;
        Tue, 09 Jul 2024 07:44:15 -0700 (PDT)
Received: from localhost (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff7aesm82149866b.102.2024.07.09.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:44:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: netconsole: Eliminate redundant setting of enabled field
Date: Tue,  9 Jul 2024 07:44:00 -0700
Message-ID: <20240709144403.544099-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709144403.544099-1-leitao@debian.org>
References: <20240709144403.544099-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When disabling a netconsole target, enabled_store() is called with
enabled=false. Currently, this results in updating the nt->enabled
field twice:

1. Inside the if/else block, with the target_list_lock spinlock held
2. Later, without the target_list_lock

This patch eliminates the redundancy by setting the field only once,
improving efficiency and reducing potential race conditions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index de0d89e4e4e2..5ef680cf994a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -369,6 +369,7 @@ static ssize_t enabled_store(struct config_item *item,
 		if (err)
 			goto out_unlock;
 
+		nt->enabled = true;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
@@ -381,8 +382,6 @@ static ssize_t enabled_store(struct config_item *item,
 		netpoll_cleanup(&nt->np);
 	}
 
-	nt->enabled = enabled;
-
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
 out_unlock:
-- 
2.43.0


