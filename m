Return-Path: <netdev+bounces-43228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD77D1CD2
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CAE3B21638
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA57910793;
	Sat, 21 Oct 2023 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MA17+YZi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84DFC14
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:25 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB841A3
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b95622c620so255166466b.0
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887643; x=1698492443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=MA17+YZitnsJ5QuQz8z+qMlLyJBYn5NZtUod4nNBIU2GfKPG7a7l1pO6i87ZFVpx1F
         2dz3zVoyuWQLc5AMo4oRCItIK9zba6uPzCwrZDZ32izY8gh41+aTl0i1otMzNHEVa68P
         nvnowAV+tuyFJmrnF/QOUr8I1kuvq7pzndTTk+17RgnIElxG1Si1XrmTqCixIrMMrS5Y
         +Y/A7IwtfWvtTa82cAOiNW3qR6pCDhqLwWC3Kfua/bJiEgF69DIoBVj4FgMXg83IHzK9
         6kOhk4wHmwd/9h8iYsdG2CnfX1nGKxDAJXi3Vh5sBG8u81/rDss3s6oY+Onz/Tyf0JC9
         GLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887643; x=1698492443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=mTmxFJaLuk3w35KLLSFenCGRPVD0ndAZD3whOe2O4rTPhGXgztFFkx/SEfos3zZ1/5
         BBKKE0D4h7KX3RkIR39V4A/Vjly8F35eRiYv9jD5T95fpVeKsZYjnyNESDX+GFXPcQmm
         9Ur0cHkw6CbqgSGBHhYthJNvxnLL9dc/24UvYmWIz87pVal0Yqrl1d1j0J/Ys70kTfbs
         oxaysOM2+si578El01w6sktHuUaaubxg4DD1a/tb5n3PQOY4VTZNa74vg8aInWcUeSu6
         ELsRORo9uixMWnGf3w84MNxUslIKb3jbJ/qzN3jiqnq2CEy+HZWKbvOJWyqYFE8jqb8K
         0iWA==
X-Gm-Message-State: AOJu0Yz7ijAoXAG30IMvcqg1DwAjj62xJMuGQ3AxGvsDdfCALU52RyDT
	8tZUVgA5e6NcfPpPj2SDtwvFIvhWfIdYy4fpE3M=
X-Google-Smtp-Source: AGHT+IHTsk5K9gSalr4KMGhmQePf9JfJxvke5P+I9qNLiweOWRnUA82WGIiNCTvJQlzIS8uTdYZoKg==
X-Received: by 2002:a17:907:7fa7:b0:9ae:701a:6efa with SMTP id qk39-20020a1709077fa700b009ae701a6efamr4188363ejc.69.1697887643165;
        Sat, 21 Oct 2023 04:27:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906148900b0099d45ed589csm3402709ejc.125.2023.10.21.04.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 06/10] devlink: make devlink_flash_overwrite enum named one
Date: Sat, 21 Oct 2023 13:27:07 +0200
Message-ID: <20231021112711.660606-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since this enum is going to be used in generated userspace file, name it
properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index cd4b82458d1b..b3c8383d342d 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -265,7 +265,7 @@ enum {
  * Documentation/networking/devlink/devlink-flash.rst
  *
  */
-enum {
+enum devlink_flash_overwrite {
 	DEVLINK_FLASH_OVERWRITE_SETTINGS_BIT,
 	DEVLINK_FLASH_OVERWRITE_IDENTIFIERS_BIT,
 
-- 
2.41.0


