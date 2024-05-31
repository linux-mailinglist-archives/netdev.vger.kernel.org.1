Return-Path: <netdev+bounces-99713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25A08D606D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25541C220F7
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A90157469;
	Fri, 31 May 2024 11:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864D745E7;
	Fri, 31 May 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154164; cv=none; b=oXlGngCgMPxyjKnSv9kqy2qS9gZiERhOnCmt4pXmQveeVCRrrlgmIbLUrmPenHY1EcsomEkGpKrfSlX4fFg4JFvBIoykr9Ct1dKEDthZ89s59QAPHJpex6gHUxGxktsjluxMzDNCVhE2AdJNcQi1y8Pw4kCMCXCA6X5qlktnjFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154164; c=relaxed/simple;
	bh=lzU+ACahgdWp8DXcp9/J0T05KhWTiXpBLy8PGomSY14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcHW9phTfvJTjiWYivozesl0NleuShHsdlg7jEZu1FO+HUlXcX1INYaZzPetox+oVfekGaYVzPF0lEcIp8RKKWmvOkXV1nNaP3eAQjUrhjyHVAtftP772IL3vvm41VVhZStvKTWPnuoDeOM1LZkrc2skI/kLKEUnw6uq5V085iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6893c33403so5236066b.3;
        Fri, 31 May 2024 04:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717154161; x=1717758961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otBvvEMTLMLnzI9ZLifgCog+x7xxrRbOwj15O7mxl/g=;
        b=fSfveSvcFTKPGQmvVk2rXtbx+w72BEXLQtLO79tDghTpAjlhEnP4nyn+Npb9Lqkq3K
         pBls7rS605SHqRdiGqMeomcAIo+EemA8hD/AAvccvQrS709ONTBBA2c+Iy2fkX631I3H
         3ETOXgYSw8iWrjN3v3PSrtZEYrE3evgMCV0rDlK0zw3rSW+1MzBkAcQJ6c7FrKkp4Icc
         B4tpsLJ6kzOhy2bav3QkIcg4ccPe0WSepIC4DeGixC4RBC6ja6rOP6hmg+AGTlJs51px
         yNCy05ceFyN85vYFs6+1AbdaFcgRNF84uDb1T8b6IWAYZTLUhJaUb2F2E+cVCYaFmovY
         QeIA==
X-Forwarded-Encrypted: i=1; AJvYcCVFiFJLTYDP+J62dJ+93NfBIE+ZlJu6D2R4ikAn2ggI3obCFe7AuR0K88TTHBAiPuqp4pET8nhzVBnKgADQKaShDcLuZZXxC45vqytc
X-Gm-Message-State: AOJu0Yw76E8n3J0nA0+s+FuBkrylPH/97WzhGDx1A7K87HEQOesQBwi0
	p0AsGkF0XIY0kr9MzG0u2aVrC4dgmEWkG6i6prWfvdTg+rmr7pBs
X-Google-Smtp-Source: AGHT+IEoBf5u3A5Syw/lTniBy3rP5CqaR9zdYeTxFTfMNe2FbFjsxeJnBvTnP+Rdo1EjmwdKQK5RzQ==
X-Received: by 2002:a17:906:175a:b0:a63:2698:2163 with SMTP id a640c23a62f3a-a681fc5d513mr141285066b.7.1717154160854;
        Fri, 31 May 2024 04:16:00 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e78db9b9sm75815266b.97.2024.05.31.04.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:16:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] openvswitch: Move stats allocation to core
Date: Fri, 31 May 2024 04:15:49 -0700
Message-ID: <20240531111552.3209198-1-leitao@debian.org>
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

Move openvswitch driver to leverage the core allocation.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/openvswitch/vport-internal_dev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 74c88a6baa43..7daba6ac6912 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -140,11 +140,7 @@ static struct vport *internal_dev_create(const struct vport_parms *parms)
 		err = -ENOMEM;
 		goto error_free_vport;
 	}
-	vport->dev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
-	if (!vport->dev->tstats) {
-		err = -ENOMEM;
-		goto error_free_netdev;
-	}
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	dev_net_set(vport->dev, ovs_dp_get_net(vport->dp));
 	dev->ifindex = parms->desired_ifindex;
@@ -169,8 +165,6 @@ static struct vport *internal_dev_create(const struct vport_parms *parms)
 
 error_unlock:
 	rtnl_unlock();
-	free_percpu(dev->tstats);
-error_free_netdev:
 	free_netdev(dev);
 error_free_vport:
 	ovs_vport_free(vport);
@@ -186,7 +180,6 @@ static void internal_dev_destroy(struct vport *vport)
 
 	/* unregister_netdevice() waits for an RCU grace period. */
 	unregister_netdevice(vport->dev);
-	free_percpu(vport->dev->tstats);
 	rtnl_unlock();
 }
 
-- 
2.43.0


