Return-Path: <netdev+bounces-34945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28A7A61CF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5E9281701
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EB41865B;
	Tue, 19 Sep 2023 11:56:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CD4684
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 11:56:52 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F4AF2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so61429095e9.1
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695124609; x=1695729409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xm57SUfFZHH+8dv1S0QHpRMRBULiYAXcl59n2S0Yyw=;
        b=tgBpvOAT/yGrTizC+Br7B1vSxPFnsOgNxrtOraG+AFmRWQZjACRZnadFnk6Qca14i5
         ErWQQrl/N9kh2tQ5As3lSTHvP96WDGwHAErqg3bCjioiqohy7hqT8p5QFx/vT5gEEF0s
         wPxHPmIUiG3wJjZoMS7rK34L0cx9/8EUe/qrkSjHDWmjvGbLerLcGTC8EwU8YlHosE5p
         PaSwKT2Jv/0rSRK8hwx9sf7kZQJs8nd4DWlSWvhUR+j30xNXgG2UNHt4m8uOlP5TXplj
         z4feX+xu7Ax6B3ChQa9ZDvY+pwKPtmEYKFWLDtho1Ig2KD0EgAqWjYxRxlWupsG4SwUV
         sUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695124609; x=1695729409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xm57SUfFZHH+8dv1S0QHpRMRBULiYAXcl59n2S0Yyw=;
        b=jLr4sy5cB1YVVTzIa14+NDZ4dLTg0uoyg7+GlAZO+//EDZZ/Ac0Jeekkzsi4FRwZ6j
         FrPegwDCbnH9//Lehfyj8XfbEPUGz0sutZom8wYXbYQ5EyQzmOlb5OaH0+OeX9f76MUE
         hB0yz5d6IHnmJ1hd7XVlTAekLeYdD8yZow9CqdWdLmprGCo8ktPlVwmjC9/izncH60q7
         52cgl32FGI3YfffKmL/5bQ4iX3C57COHIaCmxZ59hHXxrDqUDOKhiwnN3DPUVjgRnfbT
         ObQ5GbNqBkOb2ToM9dNUnFAXD9v4GGW2GfzdT6xQIRo1DDh5NQlNBzmhc0TfQfxjXkT1
         Jt5A==
X-Gm-Message-State: AOJu0YwgdVj9UmhNhffRJcxCB+xkZf6kJJtFcXBw4OuEZELrYhJSSttm
	hDWaUfBp2MnXi7ERaPePWO7IGhNmICrekk/mFgM=
X-Google-Smtp-Source: AGHT+IERuXkKzqWlNabyKXx9B/ctZ6jonv0eP33OXRWP1UQZWSMs5DUjyzJeJSl1NMxfQOyU48j9gQ==
X-Received: by 2002:a7b:c3d0:0:b0:3fb:a506:5656 with SMTP id t16-20020a7bc3d0000000b003fba5065656mr9314254wmj.32.1695124609452;
        Tue, 19 Sep 2023 04:56:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c00d100b003fe0a0e03fcsm17923654wmm.12.2023.09.19.04.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 04:56:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v2 1/5] devlink: update headers
Date: Tue, 19 Sep 2023 13:56:40 +0200
Message-ID: <20230919115644.1157890-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230919115644.1157890-1-jiri@resnulli.us>
References: <20230919115644.1157890-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Update the devlink headers to recent net-next.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 8b9b98e75059..6c4721270910 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -680,6 +680,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_STATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
+	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
-- 
2.41.0


