Return-Path: <netdev+bounces-61918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF2982533C
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 13:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633FCB22B78
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9428E3F;
	Fri,  5 Jan 2024 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IoqUjHOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F092D029
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5ac76667so11282615e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704456779; x=1705061579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9I1IUSxusyj2ZH9ePAaxlo1XldnDznjT14eCLUfzR94=;
        b=IoqUjHOj4gCMvKFs0PLXa1muuAc4Hx50bCNxaUY+ZoRWbx5nOu50gD7M3tAd/6n8YC
         F5/le41Bcezs7cp81+AlAao929pgNLI13tksvIBdIIUgsVdSIbUwmYPxQ6IOV9r44VYK
         FBdqVssrKhkqi+vZXiTkTc/bYTXq/XtawrLU2T5VblKxLOqCbeDjyyOHGybB4EmU7JMJ
         b8zq5vbuLD10kqh9X54o1rsbDRLx4vuTcz5hb8l5V+8w4G+TugPyeEfTpscg3M/WvU8r
         bsdAa4S3wPJYmGtfao+ljE63T0xvzvo5IkXACMTXV6lYIc1D/e8sa1ae00oEiqGkq14R
         nhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704456779; x=1705061579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I1IUSxusyj2ZH9ePAaxlo1XldnDznjT14eCLUfzR94=;
        b=rDrex6myHyDPMeFuM3+1IOe7UNxD3TzmY0oC7gMczcVq5wF9colxEYUkxhsQVtpY63
         GGoj8ED1byLiUDYzcYvHlw7e+vYFjav83eQkAWeHBfQWnqZUe5JjRTz09dINX8fH4Sx5
         ynYSlM21+1jcaDQ5XtAuad7lf5lTl3Nnp1sp8Cv4D3aDsCdht+qcjH//qC/5ZqT4JfmR
         bx9/Dhr2Tuhbs1QbLVtqUInbYuvVC/9k/TwkdvR0nZpOcEGExudgD4GqmmFZVnU+IwPu
         JB3vjPLTjpRQCAfkSzL0gk7Jeoei7tiCwkQ/J5OA2fPLbImwDiaPtkcu6VYIItAOym6W
         h/mA==
X-Gm-Message-State: AOJu0YzU8VImKbLTqKbcwTNyG6t3Qm2tWiuOKvsgEbufhluADau2mHzw
	YcjNbr25iSQ2DpKUsTejHkvT87z6c5jdHA==
X-Google-Smtp-Source: AGHT+IHVzmflQqpgaieXUcnJojqjT1bNBoHMGKD4B1gu9wMuTSY3UV3IY5kfvlEJINJ3AseGCW1Z0Q==
X-Received: by 2002:adf:e387:0:b0:337:5557:e6ad with SMTP id e7-20020adfe387000000b003375557e6admr1056665wrm.126.1704456779020;
        Fri, 05 Jan 2024 04:12:59 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d610c000000b003366da509ecsm1277475wrt.85.2024.01.05.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 04:12:58 -0800 (PST)
Date: Fri, 5 Jan 2024 13:12:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 07/15] net/mlx5: SD, Add informative prints in kernel
 log
Message-ID: <ZZfySfG4VClzDKTr@nanopsycho>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-8-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221005721.186607-8-saeed@kernel.org>

Thu, Dec 21, 2023 at 01:57:13AM CET, saeed@kernel.org wrote:
>From: Tariq Toukan <tariqt@nvidia.com>
>
>Print to kernel log when an SD group moves from/to ready state.
>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>---
> .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
> 1 file changed, 21 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>index 3309f21d892e..f68942277c62 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>@@ -373,6 +373,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
> 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
> }
> 
>+static void sd_print_group(struct mlx5_core_dev *primary)
>+{
>+	struct mlx5_sd *sd = mlx5_get_sd(primary);
>+	struct mlx5_core_dev *pos;
>+	int i;
>+
>+	sd_info(primary, "group id %#x, primary %s, vhca %u\n",
>+		sd->group_id, pci_name(primary->pdev),
>+		MLX5_CAP_GEN(primary, vhca_id));
>+	mlx5_sd_for_each_secondary(i, primary, pos)
>+		sd_info(primary, "group id %#x, secondary#%d %s, vhca %u\n",
>+			sd->group_id, i - 1, pci_name(pos->pdev),
>+			MLX5_CAP_GEN(pos, vhca_id));
>+}
>+
> int mlx5_sd_init(struct mlx5_core_dev *dev)
> {
> 	struct mlx5_core_dev *primary, *pos, *to;
>@@ -410,6 +425,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
> 			goto err_unset_secondaries;
> 	}
> 
>+	sd_info(primary, "group id %#x, size %d, combined\n",
>+		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));

Can't you rather expose this over sysfs or debugfs? I mean, dmesg print
does not seem like a good idea.


>+	sd_print_group(primary);
>+
> 	return 0;
> 
> err_unset_secondaries:
>@@ -440,6 +459,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
> 	mlx5_sd_for_each_secondary(i, primary, pos)
> 		sd_cmd_unset_secondary(pos);
> 	sd_cmd_unset_primary(primary);
>+
>+	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
> out:
> 	sd_unregister(dev);
> 	sd_cleanup(dev);
>-- 
>2.43.0
>
>

