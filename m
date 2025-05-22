Return-Path: <netdev+bounces-192537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89417AC04AC
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DBF3BCEC1
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4436E22155F;
	Thu, 22 May 2025 06:37:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784301ACEA6;
	Thu, 22 May 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895874; cv=none; b=dMMVtm3Zpgka94a1kv8TMxRJOrKkOXPnQTIhZctxG7PvWPz5cJE1tYejXf0cEWNeqkk4nqilGiItdydh7ty3pB3CyIMY6xN4+SpPXVDsHCCHPhcWejzP8Q+mrc/MpwEicDbAQDlaK862m8RvXlyXB6JwJv0WdFyHC+Pb6xoOrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895874; c=relaxed/simple;
	bh=awsg4yO3SRHKC8llTafIGAlDFyGcLYFGSAV2e81IRI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oup/FlWLa4vKkalOzJwUWikh66NK5E4PRJPck3kjcId9fMuNkW0s4esdLoO+JeL0xST5n9lmvEEETkj5CAtWUyrCGMzznieYX+WJiT3nBkfKNIu2Qv26u/7kPfOYYq3zNvZkuSxyTZA53Tftdx+36BkleZpp5nVbelny0hx7fsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2z914PPfz6HJh7;
	Thu, 22 May 2025 14:36:53 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id A83DE1402FC;
	Thu, 22 May 2025 14:37:48 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 08:37:43 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v2 0/3] hinic3: queue_api related fixes
Date: Thu, 22 May 2025 09:54:40 +0300
Message-ID: <cover.1747896423.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500005.china.huawei.com (7.182.85.13)

This patch series contains improvement to queue_api and 2 queue_api
related patches to the hinic3 driver.

Changes:

v1: http://lore.kernel.org/netdev/cover.1747824040.git.gur.stavi@huawei.com

v2:
* Update cover letter subject and text.
* Add 2 patches for user code related to queue api.

Gur Stavi (3):
  queue_api: add subqueue variant netif_subqueue_sent
  hinic3: use netif_subqueue_sent api
  hinic3: remove tx_q name collision hack

 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 23 ++++++++-----------
 include/net/netdev_queues.h                   |  8 +++++++
 2 files changed, 18 insertions(+), 13 deletions(-)


base-commit: 3da895b23901964fcf23450f10b529d45069f333
-- 
2.45.2


