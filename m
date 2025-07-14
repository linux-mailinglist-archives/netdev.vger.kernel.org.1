Return-Path: <netdev+bounces-206506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C68B03518
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830CF3B8953
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049291DE8BF;
	Mon, 14 Jul 2025 04:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD14A11;
	Mon, 14 Jul 2025 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465935; cv=none; b=NToD5/6/jNFWnKbl9S67383Z16Uja3XU4RcIKQabPZyz+Gn1tI+hX78rYlSv62OOSo/Q6BXmFbgfc6Iix9BbhOfv2PjO/jmhQyiRbJhSnnXA3doV7ATKytS3UdxdEbooCpEW3/bIbP8zZQUkULIDhgyk0zjq3iTGek0AFpGXtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465935; c=relaxed/simple;
	bh=BIOBOMEyZSMRK3yVZTk6UPPB0pcOqwWhOV8QxF5CxF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3/FX63M7R1/Uu3DhrMLvSkUtoeMUi0KclgBOJ1fML9LoFuBjPiFHf+IYSzCec2Sv5oPK3qiMVFvxq4k5wMO9lCOdOCDd2itaokpIItLmJ1jbjsxh5CTeiFCKcQ+mDke45bJpEfRqk7mm7y9iyTY1mcMoi0Q/FmsavEZbSJSEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1be077f35;
	Mon, 14 Jul 2025 12:00:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: wiagn233@outlook.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	p.zabel@pengutronix.de
Subject: Re: [PATCH v2 1/1] dt-bindings: net: rfkill-gpio: document reset-gpios
Date: Mon, 14 Jul 2025 12:00:04 +0800
Message-Id: <20250714040004.481274-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
References: <TY4PR01MB144321BDC50DEF7A2537C24F0984BA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUhKVkMeTE4fSExNGUJNH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++
X-HM-Tid: 0a980717215e03a2kunm472be37a742ad0
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pkk6Azo4TzE4DRE5FyoaHToy
	Mz9PFA9VSlVKTE5JT01OTUpPTk5PVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFKS09DNwY+

Hi Shengyu,

> What is blocking this patch to get merged? I'm seeing more 5G modules
> need this to work correctly, for example, FM350.

I don't know either. I sent this patch again this year, [1]
but no one responded.

[1] https://lore.kernel.org/all/20250208102009.514525-2-amadeus@jmu.edu.cn/

Thanks,
Chukun

--
2.25.1


