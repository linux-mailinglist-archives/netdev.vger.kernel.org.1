Return-Path: <netdev+bounces-45935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B57E073F
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C771C210D0
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1220309;
	Fri,  3 Nov 2023 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu28+IpF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FC62033A
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:17:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2843C13E
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699031819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2BDwvqkQrafYreOuDJL/fbzR9dfSYQpbXhoeoCg4t4=;
	b=fu28+IpFlQas8mxoN7TZI/8oTlMrWcZYpnt6UylHAEmX+yk1vJPXbOuCWM5Cn4Hwdvn2lJ
	xEocG4g2l04WWFVR/kkZzIQ2JiSLAJzhnqypnfPOLYMbt67upvcufHLRKQEdRS7iy9gwor
	+CYH9DiCBJBqoKymMzQpNksCLu9FhUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-pleYeuzlM6i_Grq8vQ4w-g-1; Fri, 03 Nov 2023 13:16:56 -0400
X-MC-Unique: pleYeuzlM6i_Grq8vQ4w-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D79E985A58A;
	Fri,  3 Nov 2023 17:16:55 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B65AE40C6EBC;
	Fri,  3 Nov 2023 17:16:52 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [RFC v1 2/8] Kconfig: Add the new file vhost/iommufd
Date: Sat,  4 Nov 2023 01:16:35 +0800
Message-Id: <20231103171641.1703146-3-lulu@redhat.com>
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Change the makefile and Kconfig, to add the
new file vhost/iommufd.c

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/Kconfig  | 1 +
 drivers/vhost/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index b455d9ab6f3d..a4becfb36d77 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -72,6 +72,7 @@ config VHOST_VDPA
 	select VHOST
 	select IRQ_BYPASS_MANAGER
 	depends on VDPA
+	depends on IOMMUFD || !IOMMUFD
 	help
 	  This kernel module can be loaded in host kernel to accelerate
 	  guest virtio devices with the vDPA-based backends.
diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
index f3e1897cce85..cda7f6b7f8da 100644
--- a/drivers/vhost/Makefile
+++ b/drivers/vhost/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) += vringh.o
 
 obj-$(CONFIG_VHOST_VDPA) += vhost_vdpa.o
 vhost_vdpa-y := vdpa.o
+vhost_vdpa-$(CONFIG_IOMMUFD) += iommufd.o
 
 obj-$(CONFIG_VHOST)	+= vhost.o
 
-- 
2.34.3


