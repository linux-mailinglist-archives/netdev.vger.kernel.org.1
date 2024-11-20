Return-Path: <netdev+bounces-146473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405559D38E6
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4F284E96
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 10:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6E19F116;
	Wed, 20 Nov 2024 10:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800919CC1C;
	Wed, 20 Nov 2024 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100230; cv=none; b=krWzcI0qAEdgI2ji8W4vuQ7qNchlN5bRbnAeVVGNZj/8CanQcEYTgB89gjAAdI76e6Y5qavmBD0p+34DIxM2YU8EAcw/Ps9isZKJAMQV8zl7g6aLbLqpEjwjX+gTfw3CYLicTKWhCnPMyR3bspenLd2236E6dQjZah0Vo1TrYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100230; c=relaxed/simple;
	bh=JhiS83x9s7x2O8rU8DkmDE6TIAj9KeHp0cuLDmETTdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiYaoz2D01mBM0yaMUJxMp6QSLBmImuvNxE/SBaEvJAtM8TakjgKXwaY+pF+of1vf2Um0pMwWtXhqwEai5ccJox9PLTSTc9+Hyq9mmOVdbdbzNCtShLVM6YzT7L8Ohcyg/43ArxGsqe86qtcR2jqfqY8Z30LBx+mQ2qugbs0U6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmpphS_1732100208 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:49 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 21/21] =?UTF-8?q?MAINTAINERS=EF=BC=9AAdd=20the?= =?UTF-8?q?=20motorcomm=20ethernet=20driver=20entry?=
Date: Wed, 20 Nov 2024 18:56:25 +0800
Message-Id: <20241120105625.22508-22-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add myself as the maintainer for the motorcomm ethernet driver.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b9344c3..ab63d872d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15686,6 +15686,14 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM ETHERNET DRIVER
+M:	Frank <Frank.Sae@motor-comm.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://www.motor-comm.com/
+F:	Documentation/networking/device_drivers/ethernet/motorcomm/*
+F:	drivers/net/ethernet/motorcomm/*
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
-- 
2.34.1


