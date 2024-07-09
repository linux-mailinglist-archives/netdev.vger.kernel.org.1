Return-Path: <netdev+bounces-110318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40CF92BD54
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F29228CAC6
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909E19D893;
	Tue,  9 Jul 2024 14:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EC419D088;
	Tue,  9 Jul 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536260; cv=none; b=Dezi3kzJLSwDDDd7AN6FT7dy6VjqXRoDkOCUE+D+5krH3X85JBx2XLRd6zM6w8W6GSKJHuT26T2qfV7h/DLUJTHTxp7b8+i75y6mWYUf/SzBAgIUAcDLvY6s+ZXHyYHgSa1bwUe2ipyMRb2FoQ/MxbZdWeXZSoKxtLzXfDJQG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536260; c=relaxed/simple;
	bh=btvlBUWWDSLHxA3Oc50qvZ/grcYhq9rFiT/wfk5rzYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snxkAK2Hd2CPnxo/MBHEbOxlYoRFWJ0W0s+gx2hKTFW4HU9EYBefJpgNnzeSyl0lUk0KuTZrDQ2lTSKX8yFobxWCzDu/CijfV5erhDUO/fSQq/NiJ3vF9Qz3vQsIOEKayPfwtTFGzbGnZFfhqchRC3y6wMUdh7W0Ab+PuzEN2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77b550128dso656078166b.0;
        Tue, 09 Jul 2024 07:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720536258; x=1721141058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaQ/diN4YhmX6xN+AsGd6y/zX6M5AHWPoibyg9p/Zro=;
        b=d5olPAVgQ+kt7UGLm+THu7hQ+mtr1KzLweVxkvywE6wFJ1kiYYVJlpIaHP8xMoS9to
         McvCfqnqzKUV0jwhHoaLkCS0OtpuLO5cf4U+tdWJteTj5x5lv/OgHa3WupACytYyr8rc
         iJP3s4RFgXpn9EvI/uMM5RoQk2PbKd2f+hwIL87cDPeEyXv4HWT/hoTTAyt8T743SBMZ
         rUcQ/olGsmsG9Cp6unIxU3Dl2vUSB+nO3QcnOP6bWYcOsLXr+Qa5CfK4YataiHF+7Pr2
         ZOZm+S9DQsjpKIojF+BkN4evYF61kJQZXx43KE0vtkPN2tKZanABrIGAjTOd6jBdX6qC
         YrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSEHtvp7XhSFfzYvn0H3MD0rlOYtRllzP6ZTuQXBSEmMCm5JTQfI+KwNubwKUzRUSMHFyjw0kjIP85yrWOiflDsms4vqUkC8ZUpwJRKCWY0W/sVCS12DfRsSoOeiSwVmkkVLDK
X-Gm-Message-State: AOJu0YxL48VRmY1y5lCDG/VtQiuFLQ/vtM0X1nQbkwZaNkF8VTHdnx+K
	qi63r5gmrzGRmEogRpLeJGNhKX1mq7fPNbaWbF7b56a9/GEQv4rz
X-Google-Smtp-Source: AGHT+IHZhega8vXLAHHD8eI+DPHHywMlNJNxom27aMbWUErlhqQ1KeVvhCOVJnb+noc+kTurkCdaHw==
X-Received: by 2002:a17:906:fcb1:b0:a6f:bf5d:b365 with SMTP id a640c23a62f3a-a780b6fe485mr226293566b.33.1720536257791;
        Tue, 09 Jul 2024 07:44:17 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8541f7sm82882166b.154.2024.07.09.07.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:44:17 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] net: netconsole: Disable target before netpoll cleanup
Date: Tue,  9 Jul 2024 07:44:01 -0700
Message-ID: <20240709144403.544099-4-leitao@debian.org>
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

Currently, netconsole cleans up the netpoll structure before disabling
the target. This approach can lead to race conditions, as message
senders (write_ext_msg() and write_msg()) check if the target is
enabled before using netpoll.

This patch reverses the order of operations:
1. Disable the target
2. Clean up the netpoll structure

This change eliminates the potential race condition, ensuring that
no messages are sent through a partially cleaned-up netpoll structure.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5ef680cf994a..9c09293b5258 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -973,6 +973,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -980,7 +981,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				spin_lock_irqsave(&target_list_lock, flags);
 				netdev_put(nt->np.dev, &nt->np.dev_tracker);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;
-- 
2.43.0


