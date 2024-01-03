Return-Path: <netdev+bounces-61214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6690822E3D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A010C2854C2
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710819BAE;
	Wed,  3 Jan 2024 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TR24D0vP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472F199CF
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d87ecf579so26921425e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704288520; x=1704893320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0olBIvsaTcEjzvUP/vki3wM7nZSj0jUNCFJJ+BMsxw8=;
        b=TR24D0vPkQbxhhu8lqdw2nv9sbGkLZA+FLZ3XKMk74MwKdjw+bEWCrwuHkJ3N7ZOEH
         7d/qzGH3OKvxWfce51Jsq7GZIY3yjUbCZer8FhLBH+euuX9hR2w4loFArKMqNHm0Tzh9
         a2AT7gJ+SUuPEhUgXUrY3mrU4+aC+X5HoWejFd3cllWNHHeD1146IhyXS/05v0hJ5OQK
         dK0YI89aKZIAkbFIxF+JEphq3adxbkMCBN1r+xK1ylwAX78q1nQTMutXqts6SCf1dk+v
         WCDp3xqr8B3mZNTda+ZuHoU0equjB1QU3uH5GsozrcRspql/w1r3tdzV6Xrf/o8FpJ+1
         161g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704288520; x=1704893320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0olBIvsaTcEjzvUP/vki3wM7nZSj0jUNCFJJ+BMsxw8=;
        b=oYzsqISFh/2KClhW1PX2oD6Njc0SzSBs3mvEPdyM2AGqJdG9Atr0g+lM+vrcI9S9FI
         Y14ta4aQ99hii54JvRWvXo4geg2i/nQYdv8TIuL+QVHR3yw3YtuMi2AsHU4bcslu39Tt
         ehp9TOjHsfeDI7Fs3smx//MKnI/fpDkOiIPgGd5/Q6c3/pOy0AYv8l2gScHpr25q4z6O
         Bdi2/nW/nwoOufvv20jZqczr2sJMZtn8xNuVeBj4NnIn5unL5anIkuJvxKr2q/5zKpRY
         LjU2ZhofZsTy107TmzIrxDsoIFVEioHDNOq/0dGm03KCVcS0aMWV2ooxASlFQ6BnZ/v8
         pfSw==
X-Gm-Message-State: AOJu0YzR5oh8xUzsO17DIGhlV0qmAdQoxKAtz0+RFG/XmLlwziMUFd/L
	o8PHY5ktNd3825z+wqgjh+RutosDwNq/P1CUJ4p1ZwDMiejubA==
X-Google-Smtp-Source: AGHT+IEpjSe4/pLOxjhNn9wyiR64lmPBmrhj9rhdptvecyl7xyG3hcHil45FRnm370yCL+ET9b0dmA==
X-Received: by 2002:a05:600c:a004:b0:40d:2fad:2c53 with SMTP id jg4-20020a05600ca00400b0040d2fad2c53mr7404828wmb.253.1704288520236;
        Wed, 03 Jan 2024 05:28:40 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c314a00b0040d91912f2csm1606214wmo.1.2024.01.03.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:28:39 -0800 (PST)
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
Subject: [patch net-next 0/3] dpll: expose fractional frequency offset value to user
Date: Wed,  3 Jan 2024 14:28:35 +0100
Message-ID: <20240103132838.1501801-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Allow to expose pin fractional frequency offset value over new DPLL
generic netlink attribute. Add an op to get the value from the driver.
Implement this new op in mlx5 driver.

Jiri Pirko (3):
  dpll: expose fractional frequency offset value to user
  net/mlx5: DPLL, Use struct to get values from
    mlx5_dpll_synce_status_get()
  net/mlx5: DPLL, Implement fractional frequency offset get pin op

 Documentation/netlink/specs/dpll.yaml         | 11 +++
 drivers/dpll/dpll_netlink.c                   | 24 +++++
 .../net/ethernet/mellanox/mlx5/core/dpll.c    | 94 ++++++++++++-------
 include/linux/dpll.h                          |  3 +
 include/uapi/linux/dpll.h                     |  1 +
 5 files changed, 98 insertions(+), 35 deletions(-)

-- 
2.43.0


