Return-Path: <netdev+bounces-111074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9292FBC2
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D789A1C226C8
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E87170855;
	Fri, 12 Jul 2024 13:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103ED16F8F7;
	Fri, 12 Jul 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792129; cv=none; b=apAfy0uGPVqIzAicDc+RQgYEk2W69P7FQ1ZG5vt7bIPPVK8XpisTuEOGLmGZJD+SOWdPUSozO+WwLme/b9yo8v50+xnEQvDQbEVNIqCX6MGPO6XHFblhU3aHkXwFj32OIMb7u6XOrmgjPG6AbYAYjc4fEptFqV9dvuf+yt9HcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792129; c=relaxed/simple;
	bh=nqVDQNv+suqxBIpH77fKPAmQjy6WSNsrO+Tg5CD5qrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHYNNzkUIREWGyOo+Zj8SEjnEjl0Tyl2R2wJ3NT+vwTRi3NsoJwXD+vlnMLPP2viKUSmbCGnfxQ/3dRuTWMmxV3U9HQ/bBcxyXEfU7o5VoVxdw8+k5+c6ZVsTtro9DqF5nwMSdaag/i8Mk45f6MSTbH0Sx35tGxf2D7F7VqLCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so4675777a12.1;
        Fri, 12 Jul 2024 06:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792126; x=1721396926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmVwnvN6+DuyrexeYoU5XL5BETojSK3dnBSlBQaG9gA=;
        b=FvGS4O3mzvkPpxtB8r5WQtqrQpxkTf/UBBCmXrLcYKv1ItmcIB7+qZ97UUVXj4fZQY
         k9kx278w/+dB3q2Al+VU4mNawZHr/Ov2ZYyjGDmnp4H2DDB6HVFbrApVCMUjmztsuXx6
         L7q+rrq8BAOfViIUdKvO9gAWW8OwlCAsn+dYF5QRehbCQ90vv1iKFNRP5FoCE63ukClj
         Hgi6yBHVbzcQz3PcphB5DoyO65yzK9H5DHNMrBTLF98ieE+BVT4gG5At+ifJlq66PbNQ
         2vxr/kGPZZ00qwl3n//VcESDvGs1ohDRIsYTF78MkClr0nNq/EICm+FHJpPoL59/IFK1
         5yaw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/Clt95BcEJFzzGNK7ecIjzBVuFPmEisliN/Q8voX70/F/fo7dE8Ioro4zvnvXvSfalMBezOYEDj2UVXr0oySyzrNXIgidgSMdzfWJZf9puehUKk8PdqyFebFocSlmU2oURxh
X-Gm-Message-State: AOJu0YzJPSnalF8dixuYaGfRaURk0OpGEgClTo5U+H/7EE5NJUB56AEZ
	Cn+a9CwTB04eioBne34nVpsrhXZDbvBRO/P62475x+KZZvUJn70vws0FIA==
X-Google-Smtp-Source: AGHT+IFv51hOg+PubMmleWpQi1pNNfOjes3smQ6GJQ4MUFgcUEGWOyTU3+wdbc30gzz9j7sc4aW9YQ==
X-Received: by 2002:a17:906:ca0e:b0:a77:b349:ffd8 with SMTP id a640c23a62f3a-a799cd38d66mr179731966b.32.1720792126181;
        Fri, 12 Jul 2024 06:48:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcbeasm348959866b.28.2024.07.12.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:48:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:FREESCALE QORIQ DPAA ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dpaa: Fix compilation Warning
Date: Fri, 12 Jul 2024 06:48:16 -0700
Message-ID: <20240712134817.913756-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove variables that are defined and incremented but never read.
This issue appeared in network tests[1] as:

	drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c:38:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
	38 |         int i = 0;
	   |             ^

Link: https://netdev.bots.linux.dev/static/nipa/870263/13729811/build_clang/stderr [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c
index 4fee74c024bd..aad470e9caea 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_sysfs.c
@@ -35,7 +35,6 @@ static ssize_t dpaa_eth_show_fqids(struct device *dev,
 	u32 last_fqid = 0;
 	ssize_t bytes = 0;
 	char *str;
-	int i = 0;
 
 	list_for_each_entry_safe(fq, tmp, &priv->dpaa_fq_list, list) {
 		switch (fq->fq_type) {
@@ -85,7 +84,6 @@ static ssize_t dpaa_eth_show_fqids(struct device *dev,
 
 		prev = fq;
 		prevstr = str;
-		i++;
 	}
 
 	if (prev) {
-- 
2.43.0


