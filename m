Return-Path: <netdev+bounces-33454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E304779E08E
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36AF1C20D83
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64423182B0;
	Wed, 13 Sep 2023 07:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C5182A4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:53 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763771728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401d67434daso70008715e9.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589171; x=1695193971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx5cwCcgwsE/VDoxUQV5N86Hk7Oe81f9AvXImzVF+5A=;
        b=m5ggpqFT8fUJaCSGSD1tm3MIy1IB1TooSxNlSbMlqIn/3KeVPP4M18fQunKcoINc5p
         OLib6ZoKreuWG1n54Y23HmdUlaRm9/XToJ9ZRJ0oz/3CSMr8gMj6y9JxTliydu33Ckp7
         w/dGY1AEBQKcesBTDDtzzCVWYUA5BI444jDxzh5uXcXh6wFbUe9C6GzpFPQ9X2sDnGxX
         c8EBb84UfbsnNzKlC2yRpELK9f09lqh+AcWLJ7uySUGeWR8wi8pKDiwBROzzQ86rSOEO
         9RvTbnwBKFEbN1KBaddE67d7Hrhz6GGowWMJzwaDRO6uhzBXm9w3dWbvP+Hg9WKMGkWJ
         znGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589171; x=1695193971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx5cwCcgwsE/VDoxUQV5N86Hk7Oe81f9AvXImzVF+5A=;
        b=rqcu2NLdvRJpulxzck/paLF7HanN2ZvsRyG/poU5EHHK12y1PZyX7ARKpUHgRBr/JG
         YMTLsuX6Zfo2I0DyaJkSX93mPutleVXGMbbc8SpICihwJXePnfcmWvcFEZ4tC0Kx/Pa4
         /tCTDK9lVzmQ9I1Ho0Yd7oZYlHpCKMl2TJEfjU1lf9YeL4il/Z8InDUlhnzV+x+0T+N8
         z3kT+tSW6LHjcbsYKTXaxCRYb48FfWYajAzsGTctBn+/5FfTPDNEkc30HPk05UgxqBMr
         6bwQBiuTaQiEN2Br1uQW3cFDbTzxPhuD9Q3X8eZ/jG/nJtyY5huGZKUfGJ+9EPdQ4t6P
         sq1g==
X-Gm-Message-State: AOJu0YzO0fSq9qHLvMHQvuwiIClzC+97HQnzXqBYnpoP+HDZe/os0JDG
	Lg2IEy0FJifc0Dd56IBwzanj5LP0Uu2Byqgg57U=
X-Google-Smtp-Source: AGHT+IEMhxSUp2FNgMOJZyxM9fQQdmleP3KPq97xLWjQyHx8HtnMmaKT5/fTZL3dWew6dTb5qELIug==
X-Received: by 2002:a7b:c44e:0:b0:401:c0ef:c287 with SMTP id l14-20020a7bc44e000000b00401c0efc287mr1282784wmi.27.1694589171068;
        Wed, 13 Sep 2023 00:12:51 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fe601a7d46sm1098719wme.45.2023.09.13.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:50 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 03/12] net/mlx5: Lift reload limitation when SFs are present
Date: Wed, 13 Sep 2023 09:12:34 +0200
Message-ID: <20230913071243.930265-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Historically, the shared devlink_mutex prevented devlink instances from
being registered/unregistered during another devlink instance reload
operation. However, devlink_muxex is gone for some time now, this
limitation is no longer needed. Lift it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index af8460bb257b..3e064234f6fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -138,7 +138,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct pci_dev *pdev = dev->pdev;
-	bool sf_dev_allocated;
 	int ret = 0;
 
 	if (mlx5_dev_is_lightweight(dev)) {
@@ -148,16 +147,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return 0;
 	}
 
-	sf_dev_allocated = mlx5_sf_dev_allocated(dev);
-	if (sf_dev_allocated) {
-		/* Reload results in deleting SF device which further results in
-		 * unregistering devlink instance while holding devlink_mutext.
-		 * Hence, do not support reload.
-		 */
-		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported when SFs are allocated");
-		return -EOPNOTSUPP;
-	}
-
 	if (mlx5_lag_is_active(dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
 		return -EOPNOTSUPP;
-- 
2.41.0


