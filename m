Return-Path: <netdev+bounces-51500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C592D7FAF01
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 01:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823422810BA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0B7F4;
	Tue, 28 Nov 2023 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qOBU2jKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CC1B1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:24 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb92becbf6so72920547b3.2
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 16:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701131244; x=1701736044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Re5mrkQDhsmsBqEX/isMp/hVwh4xSdN/Lox5QrdMG60=;
        b=qOBU2jKinFzgaPEHxaJfe41F624KCMs++r0koVCoSIttPz8VqTZplqFAIk6ZEvxrKT
         QMngF+T0rI92WZEso1EqD/vBKLzCLpQjW5AnqoWTouPKNBlVwjrVjBd/N+9srXyb4xUa
         D6/bC7QNKBaRhG4ihnQmXS7MwmvW5KS8Wb14ZO29brny7mzrgrcTUS3hyiLVnpZVyHE4
         WUP8V8QkkFXReU5SGaadiC/WibRAntKfmfDaOODly87bb5hRCsrFFvLgP4VJ66EDOood
         fVtPXdUubOwEuAZgplZoB5eJZLUAHo06wnNGZpPIXnlD3DnuG3MkUM7Sn4ohRpSf/kYr
         i9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131244; x=1701736044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Re5mrkQDhsmsBqEX/isMp/hVwh4xSdN/Lox5QrdMG60=;
        b=rOtKLO7fRWEe+o+YkHOnDwBwzjUqoGuQcgmKcTAv+Ff4/j+g16ZpBzuSZWahsQlzm/
         JImyU8CyuAyX6L9sX1Ks4HSXeVhft7Gi+fApcY2/PWIxgTb3m3p8nhgskIuPAjgBaJF9
         N8y85Av9KLbovDNd31tBB0ZT2+z140VoMUWhZ9hTMiHoaOZ7+7zr4eH78y2OtEFT8YZN
         FJsjtiQFZQIa4v8tkfWefp6iYHENuaeN1z/IQx0ixAdFDmBo+rGbrQbaK/JMeEKkzwMX
         I3cvzTIKfEz9tBaQl49w4xF+AZ6lWSg0NWtPQ98DkSkuMbBA0Vb+QpW1eOztz4AHikhT
         Ia2A==
X-Gm-Message-State: AOJu0YxI7usMIKK/6BHPgwuIfwBAtiVJ3tV9JrHZ0Ll5hP2a6D50I6Hk
	NvL58S4SQbGQyMjzttZg0LOtPPq3VvT9llfzJFMkg7eYj5/VZhyVPc7PQZ9Nhecy2n9e9Uvnv2J
	GEvpk7jGjGLuM7fF7wUJ1X1YIO7laEoZD5lfV0OeqUAc8E7Qp5VBLrE4CNT0aFwP7
X-Google-Smtp-Source: AGHT+IEzKG48RUQbySYjUN8Jw+eoWQEXFZD6O5//zOPMY9y71ZkaF4Ew5IgLGo/glvrfUYP/x+6DZz3rIPjl
X-Received: from jfraker202.plv.corp.google.com ([2620:15c:11c:202:19d5:f826:3460:9345])
 (user=jfraker job=sendgmr) by 2002:a05:690c:3105:b0:5cc:4276:1c6b with SMTP
 id fb5-20020a05690c310500b005cc42761c6bmr372945ywb.4.1701131243881; Mon, 27
 Nov 2023 16:27:23 -0800 (PST)
Date: Mon, 27 Nov 2023 16:26:45 -0800
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231128002648.320892-1-jfraker@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231128002648.320892-3-jfraker@google.com>
Subject: [PATCH net-next 2/5] gve: Deprecate adminq_pfn for pci revision 0x1.
From: John Fraker <jfraker@google.com>
To: netdev@vger.kernel.org
Cc: John Fraker <jfraker@google.com>, Jordan Kimbrough <jrkim@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

adminq_pfn assumes a page size of 4k, causing this mechanism to break in
kernels compiled with different page sizes. A new PCI device revision was
needed for the device to be able to communicate with the driver how to
set up the admin queue prior to having access to the admin queue.

Signed-off-by: Jordan Kimbrough <jrkim@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c   | 48 ++++++++++++++++++++++++++++-----------
 drivers/net/ethernet/google/gve/gve_register.h |  9 ++++++++
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index d3f3a0152..f81ed6f62 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -225,9 +225,20 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 
 	/* Setup Admin queue with the device */
-	iowrite32be(priv->adminq_bus_addr / PAGE_SIZE,
-		    &priv->reg_bar0->adminq_pfn);
-
+	if (priv->pdev->revision < 0x1) {
+		iowrite32be(priv->adminq_bus_addr / PAGE_SIZE,
+			    &priv->reg_bar0->adminq_pfn);
+	} else {
+		iowrite16be(GVE_ADMINQ_BUFFER_SIZE,
+			    &priv->reg_bar0->adminq_length);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		iowrite32be(priv->adminq_bus_addr >> 32,
+			    &priv->reg_bar0->adminq_base_address_hi);
+#endif
+		iowrite32be(priv->adminq_bus_addr,
+			    &priv->reg_bar0->adminq_base_address_lo);
+		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK, &priv->reg_bar0->driver_status);
+	}
 	gve_set_admin_queue_ok(priv);
 	return 0;
 }
@@ -237,16 +248,27 @@ void gve_adminq_release(struct gve_priv *priv)
 	int i = 0;
 
 	/* Tell the device the adminq is leaving */
-	iowrite32be(0x0, &priv->reg_bar0->adminq_pfn);
-	while (ioread32be(&priv->reg_bar0->adminq_pfn)) {
-		/* If this is reached the device is unrecoverable and still
-		 * holding memory. Continue looping to avoid memory corruption,
-		 * but WARN so it is visible what is going on.
-		 */
-		if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
-			WARN(1, "Unrecoverable platform error!");
-		i++;
-		msleep(GVE_ADMINQ_SLEEP_LEN);
+	if (priv->pdev->revision < 0x1) {
+		iowrite32be(0x0, &priv->reg_bar0->adminq_pfn);
+		while (ioread32be(&priv->reg_bar0->adminq_pfn)) {
+			/* If this is reached the device is unrecoverable and still
+			 * holding memory. Continue looping to avoid memory corruption,
+			 * but WARN so it is visible what is going on.
+			 */
+			if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
+				WARN(1, "Unrecoverable platform error!");
+			i++;
+			msleep(GVE_ADMINQ_SLEEP_LEN);
+		}
+	} else {
+		iowrite32be(GVE_DRIVER_STATUS_RESET_MASK, &priv->reg_bar0->driver_status);
+		while (!(ioread32be(&priv->reg_bar0->device_status)
+				& GVE_DEVICE_STATUS_DEVICE_IS_RESET)) {
+			if (i == GVE_MAX_ADMINQ_RELEASE_CHECK)
+				WARN(1, "Unrecoverable platform error!");
+			i++;
+			msleep(GVE_ADMINQ_SLEEP_LEN);
+		}
 	}
 	gve_clear_device_rings_ok(priv);
 	gve_clear_device_resources_ok(priv);
diff --git a/drivers/net/ethernet/google/gve/gve_register.h b/drivers/net/ethernet/google/gve/gve_register.h
index fb655463c..8e72b9700 100644
--- a/drivers/net/ethernet/google/gve/gve_register.h
+++ b/drivers/net/ethernet/google/gve/gve_register.h
@@ -18,11 +18,20 @@ struct gve_registers {
 	__be32	adminq_event_counter;
 	u8	reserved[3];
 	u8	driver_version;
+	__be32	adminq_base_address_hi;
+	__be32	adminq_base_address_lo;
+	__be16	adminq_length;
 };
 
 enum gve_device_status_flags {
 	GVE_DEVICE_STATUS_RESET_MASK		= BIT(1),
 	GVE_DEVICE_STATUS_LINK_STATUS_MASK	= BIT(2),
 	GVE_DEVICE_STATUS_REPORT_STATS_MASK	= BIT(3),
+	GVE_DEVICE_STATUS_DEVICE_IS_RESET	= BIT(4),
+};
+
+enum gve_driver_status_flags {
+	GVE_DRIVER_STATUS_RUN_MASK		= BIT(0),
+	GVE_DRIVER_STATUS_RESET_MASK		= BIT(1),
 };
 #endif /* _GVE_REGISTER_H_ */
-- 
2.43.0.rc1.413.gea7ed67945-goog


