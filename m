Return-Path: <netdev+bounces-113671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743893F75C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5404F28275E
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0114F9CF;
	Mon, 29 Jul 2024 14:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F6823A9;
	Mon, 29 Jul 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262424; cv=none; b=i9TISAgbxKVzGyAMl6CMhuj+im8c8s8mfiTGs34AYQ0qKnRcOzZIycwKS/QXwmIzN/OuA257j8/jBvfAqngNLA6KwT61syr9OxaIdBK1fLm9feEDZ/U8yZZCF126CkL1kE7zY5vxFURhcEUHv/h70wHhzjj9Ygb0yqt7RNuQDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262424; c=relaxed/simple;
	bh=ELOgQPxevioL9vd3bsixdd4TqgKriaSm39J/tE1J0kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XW109fJyRk3onHWIfN7678svXDOtPD2KaU5zqX0GxN6U3dJpun5Wf7+T6fpWs4hFk1DkGgNFHefYb51kn7HJ+reqcN3Pe2HD8rLJ8V2nlXhuWmT7icbBOA8LqZJR77pEvKgAjyZHtJIYiHsCgeXsyaX2nPchAFKvspFkHZ578pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a9e25008aso452938366b.0;
        Mon, 29 Jul 2024 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262421; x=1722867221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kE9NdmuAC54sa3jAscd/RN4AeV/AnJyswrvQEpKVXqM=;
        b=EdodLWp/q06/SbnsPsRDtOYrfOigsRsUVqKGhSwwsKTou6ApMfSCrj6P2i/nG6ThgL
         GVzDlA9Yuk8xOmfRGh5opwPiTpzh1ysQ6T14HLEiHpcG19CAO4ukHGytRIo2nP+Ihpmg
         U+gQaCX3WQlxGgC4ORVyPL1anyEKcxrnWjJ1QfkTiZH4zr1DmNkIES2SQFwGWa+3d0s7
         0d2L4Ml3Ni8sMgwl2amJ3sFx2S+HX0yL6/hzLz06EMeDRjKvjB2ZC6xJjMdPtJmWxwEq
         hik9dhMeVezytbFimavMK1hEDLTiioLg/SDkcd1HA8UKkAEYqpVkWDdtUey7mP/JB197
         bjkA==
X-Forwarded-Encrypted: i=1; AJvYcCX7c1I9OoYWoISbbiMHALK3IvsRNiH2MAO1OqVX13oJZAfDSpd3Nc8zxclf3gNLveJIWudJeNpNQY+hBwXFuu7TPIoCDsFCOYb1VeBI
X-Gm-Message-State: AOJu0YyNGpJnX02AGGMhVCXPiOL/CebN3XMi62WvYg3q5pBYHI9tzuHu
	cNP7OKCNayf4uvUGAdu4YeW+B3NbMeG/ns0Woha8eGNam9ntfyEw
X-Google-Smtp-Source: AGHT+IHGpveJEMhOusEbxZOLKbtsRLt1MTUdzg0lZIMLEDLn2tqHT6TkFmM0r30M5fYSc3lDW8Jahw==
X-Received: by 2002:a17:906:d54f:b0:a7a:9144:e242 with SMTP id a640c23a62f3a-a7d4007fe24mr624731566b.27.1722262420463;
        Mon, 29 Jul 2024 07:13:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9202sm507512966b.209.2024.07.29.07.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:13:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: Add skbuff.h to MAINTAINERS
Date: Mon, 29 Jul 2024 07:12:58 -0700
Message-ID: <20240729141259.2868150-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The network maintainers need to be copied if the skbuff.h is touched.

This also helps git-send-email to figure out the proper maintainers when
touching the file.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..7f4295d67aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15879,6 +15879,7 @@ F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
 F:	include/linux/netdevice.h
+F:	include/linux/skbuff.h
 F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdevice.h
-- 
2.43.0


