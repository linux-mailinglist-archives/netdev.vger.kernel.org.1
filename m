Return-Path: <netdev+bounces-60432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FD81F3EB
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D8B21EE7
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4A7FB;
	Thu, 28 Dec 2023 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bsesUh4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6F1FDC
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da16ec9be4so291201b3a.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703727998; x=1704332798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNB++PJ6pw8L12UZXBY4NQeYCzHzjlirc1hhBOThbfU=;
        b=bsesUh4HyY1EqUvyKSY2HHOP14GLciUFDYkcaopmHr7tVXAAFYjKV7dwHCjhEiCCEX
         YtGD3bK3+2wmppGpnsuJ2aekxVk5CgN48ftycVw7JXCbvlYeKrbrU6EkDk7RaTWsMbYI
         MOLWJ3+6oMoupzz/ENAZJX2VBF7wvvIrGQVFL8xgP6OTFrO5Owr+8xGYKJ54yR9edBV+
         XnDNB8vt63Q+2rwpa2Vm6WzicSiZjiprpBXHLfGxW1L0mk/nLXKhBZCMu5CqIn7kqZax
         ou9fy8orGCxAsuVTl231O+qaXGt0eXVzYWgP6BFd8ngwRnMUqumBnoBiLB9AKqk2zoE1
         zn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727998; x=1704332798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNB++PJ6pw8L12UZXBY4NQeYCzHzjlirc1hhBOThbfU=;
        b=C3rFr/r6PbgtQS0b7011CG6R+MvYS7TVvr3DvwLNNSbrZilXkSp5A8YPXNTl5Ue5lS
         WPwfVSNmYEQIdUU90clYoydDIZMXc9w0Q44OxeXZIxkGTJHWPlsPenus9zCy9xviHmjX
         l++EBQ+gID3/o7GEQJ2WJoHLwwA+jrqBhAO/Tp9gO4JBSFuNx4KTGpK8kSq4O2u6cy5A
         MbCndhGjzLs6ZYsu0ufBlGqrjvLnN4w2Q9q0Osz1P60SIxrTxAL3rIRi6+6uRCZ32qRc
         A1xhDgdtU1a17xRD0RFbonqO3UrcOU9QAqJqh3Djkl3j6rIe0mgUTmAli6/HjmzBFTvc
         F/kg==
X-Gm-Message-State: AOJu0Yy8augzqSj0XU2ASXxxwooDczuMXX2bYCNhVPB92svwNjrSWoiM
	ZTi+EgD54nr53u7U8su0X8gFbN3kSqR3/d21iZIKLO5KQFo=
X-Google-Smtp-Source: AGHT+IEbMLDbh9U3iXgrW4hFObfZAg7S4YjooCGQR/ZnZEGdoC73ulVVVoxKIAOJ/JFGTc+EnFcR0A==
X-Received: by 2002:a05:6a00:1e02:b0:6d9:bbc9:98d9 with SMTP id gx2-20020a056a001e0200b006d9bbc998d9mr5002362pfb.8.1703727997927;
        Wed, 27 Dec 2023 17:46:37 -0800 (PST)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id f4-20020a63de04000000b00588e8421fa8sm12232182pgg.84.2023.12.27.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:37 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 1/5] netdevsim: maintain a list of probed netdevsims
Date: Wed, 27 Dec 2023 17:46:29 -0800
Message-Id: <20231228014633.3256862-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231228014633.3256862-1-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this patch I added a linked list nsim_dev_list of probed nsim_devs,
added during nsim_drv_probe() and removed during nsim_drv_remove(). A
mutex nsim_dev_list_lock protects the list.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/dev.c       | 19 +++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..8d477aa99f94 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -35,6 +35,9 @@
 
 #include "netdevsim.h"
 
+static LIST_HEAD(nsim_dev_list);
+static DEFINE_MUTEX(nsim_dev_list_lock);
+
 static unsigned int
 nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
 {
@@ -1607,6 +1610,11 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
 	devl_unlock(devlink);
+
+	mutex_lock(&nsim_dev_list_lock);
+	list_add(&nsim_dev->list, &nsim_dev_list);
+	mutex_unlock(&nsim_dev_list_lock);
+
 	return 0;
 
 err_hwstats_exit:
@@ -1668,8 +1676,19 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 {
 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
+	struct nsim_dev *pos, *tmp;
+
+	mutex_lock(&nsim_dev_list_lock);
+	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
+		if (pos == nsim_dev) {
+			list_del(&nsim_dev->list);
+			break;
+		}
+	}
+	mutex_unlock(&nsim_dev_list_lock);
 
 	devl_lock(devlink);
+
 	nsim_dev_reload_destroy(nsim_dev);
 
 	nsim_bpf_dev_exit(nsim_dev);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 028c825b86db..babb61d7790b 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -277,6 +277,7 @@ struct nsim_vf_config {
 
 struct nsim_dev {
 	struct nsim_bus_dev *nsim_bus_dev;
+	struct list_head list;
 	struct nsim_fib_data *fib_data;
 	struct nsim_trap_data *trap_data;
 	struct dentry *ddir;
-- 
2.39.3


