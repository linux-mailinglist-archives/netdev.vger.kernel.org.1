Return-Path: <netdev+bounces-61217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4CE822E40
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A3E1C23633
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED4D19BD8;
	Wed,  3 Jan 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IGyLn6u1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDA19BCE
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so266516f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 05:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704288524; x=1704893324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6skAPmPoiy0Bq24LZbH7O+9zLEpGnX9a97LILppSPhk=;
        b=IGyLn6u1lcFTbBTx9iBztuwwEgaYzNIBeqtOdFo1RiBGg/p880TpfOXbTIShOKO4l7
         cwPonS855W+Kkq+mRAP1pIinF6+AjGx/9yl2KMpOoOj2k6/D2vgJ1iF3A2ZFhy43pVeS
         0NPLKHnrmS2RR4HvLxssIVgSrFzz37EkgR1ACyywSgmowFs6GW3XeBTFXHB3+1k4uR5l
         FJv7jgdgM5oXb7MADUEMKBtidiay4C4uwJKd7uZQL+rQx67QesOzU71sGYlXOhJfNicg
         HobkJgYzoi0IXQnrMTSE1bO8OAAhizYFGlHr13nRo3SD+YHLuyl42WHFNBBwk8/qRnxa
         eYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288524; x=1704893324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6skAPmPoiy0Bq24LZbH7O+9zLEpGnX9a97LILppSPhk=;
        b=bTrg92AvGnCkNIFfZHkKY9Uno6Ua1R7VHoo7PNkD0lKtefa0jLf4htB8To5uPsCmvF
         PvfQyffwitZvrIfrkxFBztudYEYcD1wqZbZBK6VgGUY06VVEbpGzV8ou703fNi+BsWx9
         +wESaBB4cwHZMRZZGwxNDqqMsWyEg1F89itmxCGrE9JUxOXYRmMtYLxpW83+q3Ttcnb3
         h+oZ3X5kjC/MN1oSIWcYd7LBP6e66RD1fuNVN/2yGEbfZhydJC+n3vO4U2r9sgmTxbpE
         Gjy8KgxpsUe5qKtSDxrUcqohTCNUPEuwR35uqWGboL1JH7L6ZGORuE0llz8qim5i+7wG
         Kf1Q==
X-Gm-Message-State: AOJu0Yyj4nK3+u9GLlQpDeO45RlyQEzlzIjv5iuEp2lOpOJwu78SOXxA
	Bm2NF2jqwxZg2emA7qjjljd2+LqoEDl2jL9voeNcBVlgjyUhcA==
X-Google-Smtp-Source: AGHT+IE7v19TeYZCXIBN1f4GmBvtPzx8TGa2YHhPAEcKB2rLM8iUDIuZksBQRqfTwHtvFG0uMpc7kA==
X-Received: by 2002:adf:f303:0:b0:336:86af:ede5 with SMTP id i3-20020adff303000000b0033686afede5mr506262wro.46.1704288524181;
        Wed, 03 Jan 2024 05:28:44 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d4b82000000b003367ff4aadasm30551035wrt.31.2024.01.03.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:43 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	michal.michalik@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net-next 3/3] net/mlx5: DPLL, Implement fractional frequency offset get pin op
Date: Wed,  3 Jan 2024 14:28:38 +0100
Message-ID: <20240103132838.1501801-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103132838.1501801-1-jiri@resnulli.us>
References: <20240103132838.1501801-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Implement ffo_get() pin op filling it up to MSEED.frequency_diff value.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
index dbe09d2f2069..18fed2b34fb1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dpll.c
@@ -40,6 +40,8 @@ struct mlx5_dpll_synce_status {
 	enum mlx5_msees_admin_status admin_status;
 	enum mlx5_msees_oper_status oper_status;
 	bool ho_acq;
+	bool oper_freq_measure;
+	s32 frequency_diff;
 };
 
 static int
@@ -57,6 +59,8 @@ mlx5_dpll_synce_status_get(struct mlx5_core_dev *mdev,
 	synce_status->admin_status = MLX5_GET(msees_reg, out, admin_status);
 	synce_status->oper_status = MLX5_GET(msees_reg, out, oper_status);
 	synce_status->ho_acq = MLX5_GET(msees_reg, out, ho_acq);
+	synce_status->oper_freq_measure = MLX5_GET(msees_reg, out, oper_freq_measure);
+	synce_status->frequency_diff = MLX5_GET(msees_reg, out, frequency_diff);
 	return 0;
 }
 
@@ -69,8 +73,10 @@ mlx5_dpll_synce_status_set(struct mlx5_core_dev *mdev,
 
 	MLX5_SET(msees_reg, in, field_select,
 		 MLX5_MSEES_FIELD_SELECT_ENABLE |
+		 MLX5_MSEES_FIELD_SELECT_ADMIN_FREQ_MEASURE |
 		 MLX5_MSEES_FIELD_SELECT_ADMIN_STATUS);
 	MLX5_SET(msees_reg, in, admin_status, admin_status);
+	MLX5_SET(msees_reg, in, admin_freq_measure, true);
 	return mlx5_core_access_reg(mdev, in, sizeof(in), out, sizeof(out),
 				    MLX5_REG_MSEES, 0, 1);
 }
@@ -102,6 +108,16 @@ mlx5_dpll_pin_state_get(struct mlx5_dpll_synce_status *synce_status)
 	       DPLL_PIN_STATE_CONNECTED : DPLL_PIN_STATE_DISCONNECTED;
 }
 
+static int
+mlx5_dpll_pin_ffo_get(struct mlx5_dpll_synce_status *synce_status,
+		      s64 *ffo)
+{
+	if (!synce_status->oper_freq_measure)
+		return -ENODATA;
+	*ffo = synce_status->frequency_diff;
+	return 0;
+}
+
 static int mlx5_dpll_device_lock_status_get(const struct dpll_device *dpll,
 					    void *priv,
 					    enum dpll_lock_status *status,
@@ -175,10 +191,25 @@ static int mlx5_dpll_state_on_dpll_set(const struct dpll_pin *pin,
 					  MLX5_MSEES_ADMIN_STATUS_FREE_RUNNING);
 }
 
+static int mlx5_dpll_ffo_get(const struct dpll_pin *pin, void *pin_priv,
+			     const struct dpll_device *dpll, void *dpll_priv,
+			     s64 *ffo, struct netlink_ext_ack *extack)
+{
+	struct mlx5_dpll_synce_status synce_status;
+	struct mlx5_dpll *mdpll = pin_priv;
+	int err;
+
+	err = mlx5_dpll_synce_status_get(mdpll->mdev, &synce_status);
+	if (err)
+		return err;
+	return mlx5_dpll_pin_ffo_get(&synce_status, ffo);
+}
+
 static const struct dpll_pin_ops mlx5_dpll_pins_ops = {
 	.direction_get = mlx5_dpll_pin_direction_get,
 	.state_on_dpll_get = mlx5_dpll_state_on_dpll_get,
 	.state_on_dpll_set = mlx5_dpll_state_on_dpll_set,
+	.ffo_get = mlx5_dpll_ffo_get,
 };
 
 static const struct dpll_pin_properties mlx5_dpll_pin_properties = {
-- 
2.43.0


