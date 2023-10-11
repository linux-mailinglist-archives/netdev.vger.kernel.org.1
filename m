Return-Path: <netdev+bounces-40036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A79A37C57D4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D8028170A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3320311;
	Wed, 11 Oct 2023 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VLHO61xu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F51D6A7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:12:42 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B292
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:12:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a6190af24aso1212626266b.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697037157; x=1697641957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAgFeLpEzvuaN6Ug5hM7a4CNPu1b9UntxyrTaGBWUvc=;
        b=VLHO61xudCuav6IadLfntnsRV9cC6j177uwqdo1vlsAD/Gz2xVKbvUPgXGqri3bDRc
         B6YYlmNqSEXY5npdCKpj+WCDyleMzZIn4VgJMNwL2MoDeO5R30CslHICOmnk8E9pL0Kx
         rOsNYTBGNJlW8ARMpAh+OdyLks7gbpK1aRbdn4P+R1qSgV4QMuTnsO+d8kVsPtrA/SiS
         6aix1z3i27yqM6eDwF5tBBfkdgUtSEf3+uL686l1kV+SakZpyGqrEeESteEEM+t/NnJD
         W7wy/YHhVApo9r4P8Uoirnsk+vQDH9nx6reT+oe/lE1BbbfOc7OwT1fZGkN44dxMAfKD
         wu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037157; x=1697641957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAgFeLpEzvuaN6Ug5hM7a4CNPu1b9UntxyrTaGBWUvc=;
        b=SL4hLsyDrJQCcylwtKJ8vg5b1IUwGo3cGtfiokBnp0KqMPtALcQ6yPGWCYL69yzMbN
         Y1TxONYmw1DoR3LvAwXw04FkrrrMD1jdHdSXGuqR3/k6wBV/3vKFkH+rF7AX7mgXhOd6
         HefwOGPNB2NUuqK2eez3qK7J3zqMKYXkK2TjGB9cWw9lI+nOElt2wGXMWMvrNLJ8/UTc
         +XLlUnoFRU2pnvBGFaqAEU6eKPcuJhYL+SMV/GMlcZ1A/97yO+eqRDSpxQ4qcgqwg7Cx
         VH+KqVV1o+vHwHPf5nF505P+i8kgERxImg+2R7yR96DIn3XHeE/pJiUyxmLz0UJeYkyv
         0pSQ==
X-Gm-Message-State: AOJu0YwBbGvHmmuiMS+hAKcYSF2DQ5sTDrLHLlD1ju6+eyjK8XDPz/Hw
	i4ZfRLLSjLEDAEyR7bdG6RQRzA==
X-Google-Smtp-Source: AGHT+IHS47E09L/oI9WrH+icpXfiGhfan4uYZBBoe0aUo+VpL3TVjdBEG2UUJXj2Fr6cFB3aSTVnhw==
X-Received: by 2002:a17:906:af65:b0:9b2:9e44:222e with SMTP id os5-20020a170906af6500b009b29e44222emr22445165ejb.19.1697037157679;
        Wed, 11 Oct 2023 08:12:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709064ad000b009ae54585aebsm9731532ejt.89.2023.10.11.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:12:36 -0700 (PDT)
Date: Wed, 11 Oct 2023 17:12:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch, aelior@marvell.com, manishc@marvell.com,
	horms@kernel.org, vladimir.oltean@nxp.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jdamato@fastly.com,
	d-tatianin@yandex-team.ru, kuba@kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 1/2] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <ZSa7Y9gwC8qCBv2r@nanopsycho>
References: <20231011131348.435353-1-pawel.chmielewski@intel.com>
 <20231011131348.435353-2-pawel.chmielewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011131348.435353-2-pawel.chmielewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 03:13:47PM CEST, pawel.chmielewski@intel.com wrote:
>From: Paul Greenwalt <paul.greenwalt@intel.com>
>
>The need to map Ethtool forced speeds to Ethtool supported link modes is
>common among drivers. To support this, add a common structure for forced
>speed maps and a function to init them.  This is solution was originally
>introduced in commit 1d4e4ecccb11 ("qede: populate supported link modes
>maps on module init") for qede driver.
>
>ethtool_forced_speed_maps_init() should be called during driver init
>with an array of struct ethtool_forced_speed_map to populate the mapping.
>
>Definitions for maps themselves are left in the driver code, as the sets
>of supported link modes may vary between the devices.
>
>The qede driver was compile tested only.
>
>Suggested-by: Andrew Lunn <andrew@lunn.ch>
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
>Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
>---
> .../net/ethernet/qlogic/qede/qede_ethtool.c   | 46 +++++--------------
> include/linux/ethtool.h                       | 27 +++++++++++
> net/ethtool/ioctl.c                           | 13 ++++++

Would be probably better to this this in 2 patches. 1) Introduce ethtool
infra, 2) convert qede to use it


> 3 files changed, 52 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>index 95820cf1cd6c..d4f2cd13d308 100644
>--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
>@@ -201,21 +201,6 @@ static const char qede_tests_str_arr[QEDE_ETHTOOL_TEST_MAX][ETH_GSTRING_LEN] = {
> 
> /* Forced speed capabilities maps */
> 
>-struct qede_forced_speed_map {
>-	u32		speed;
>-	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
>-
>-	const u32	*cap_arr;
>-	u32		arr_size;
>-};
>-
>-#define QEDE_FORCED_SPEED_MAP(value)					\
>-{									\
>-	.speed		= SPEED_##value,				\
>-	.cap_arr	= qede_forced_speed_##value,			\
>-	.arr_size	= ARRAY_SIZE(qede_forced_speed_##value),	\
>-}
>-
> static const u32 qede_forced_speed_1000[] __initconst = {
> 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> 	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
>@@ -263,28 +248,21 @@ static const u32 qede_forced_speed_100000[] __initconst = {
> 	ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> };
> 
>-static struct qede_forced_speed_map qede_forced_speed_maps[] __ro_after_init = {
>-	QEDE_FORCED_SPEED_MAP(1000),
>-	QEDE_FORCED_SPEED_MAP(10000),
>-	QEDE_FORCED_SPEED_MAP(20000),
>-	QEDE_FORCED_SPEED_MAP(25000),
>-	QEDE_FORCED_SPEED_MAP(40000),
>-	QEDE_FORCED_SPEED_MAP(50000),
>-	QEDE_FORCED_SPEED_MAP(100000),
>+static struct ethtool_forced_speed_map
>+	qede_forced_speed_maps[] __ro_after_init = {
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 1000),

This is confusing indentation. What about:
static struct ethtool_forced_speed_map
qede_forced_speed_maps[] __ro_after_init = {
	ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 1000),
?


>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 10000),
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 20000),
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 25000),
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 40000),
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 50000),
>+		ETHTOOL_FORCED_SPEED_MAP(qede_forced_speed, 100000),
> };
> 
> void __init qede_forced_speed_maps_init(void)
> {
>-	struct qede_forced_speed_map *map;
>-	u32 i;
>-
>-	for (i = 0; i < ARRAY_SIZE(qede_forced_speed_maps); i++) {
>-		map = qede_forced_speed_maps + i;
>-
>-		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
>-		map->cap_arr = NULL;
>-		map->arr_size = 0;
>-	}
>+	ethtool_forced_speed_maps_init(qede_forced_speed_maps,
>+				       ARRAY_SIZE(qede_forced_speed_maps));
> }
> 
> /* Ethtool callbacks */
>@@ -564,8 +542,8 @@ static int qede_set_link_ksettings(struct net_device *dev,
> 				   const struct ethtool_link_ksettings *cmd)
> {
> 	const struct ethtool_link_settings *base = &cmd->base;
>+	const struct ethtool_forced_speed_map *map;
> 	struct qede_dev *edev = netdev_priv(dev);
>-	const struct qede_forced_speed_map *map;
> 	struct qed_link_output current_link;
> 	struct qed_link_params params;
> 	u32 i;
>diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
>index 62b61527bcc4..68d682012e9d 100644
>--- a/include/linux/ethtool.h
>+++ b/include/linux/ethtool.h
>@@ -1052,4 +1052,31 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
>  * next string.
>  */
> extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
>+
>+/* Link mode to forced speed capabilities maps */
>+struct ethtool_forced_speed_map {
>+	u32		speed;
>+	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
>+
>+	const u32	*cap_arr;
>+	u32		arr_size;
>+};
>+
>+#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)				\
>+{									\
>+	.speed		= SPEED_##value,				\
>+	.cap_arr	= prefix##_##value,				\
>+	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
>+}
>+
>+/**
>+ * ethtool_forced_speed_maps_init
>+ * @maps: Pointer to an array of Ethtool forced speed map
>+ * @size: Array size
>+ *
>+ * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
>+ * should be called during driver module init.
>+ */
>+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
>+				    u32 size);
> #endif /* _LINUX_ETHTOOL_H */
>diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c

Why you put this into ioctl.c?

Can't this be put into include/linux/linkmode.h as a static helper as
well?


>index 0b0ce4f81c01..34507691fc9d 100644
>--- a/net/ethtool/ioctl.c
>+++ b/net/ethtool/ioctl.c
>@@ -3388,3 +3388,16 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
> 	kfree(flow);
> }
> EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
>+
>+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
>+				    u32 size)
>+{
>+	for (u32 i = 0; i < size; i++) {
>+		struct ethtool_forced_speed_map *map = &maps[i];
>+
>+		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
>+		map->cap_arr = NULL;
>+		map->arr_size = 0;
>+	}
>+}
>+EXPORT_SYMBOL(ethtool_forced_speed_maps_init);
>-- 
>2.37.3
>
>

