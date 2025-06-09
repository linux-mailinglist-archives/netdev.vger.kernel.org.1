Return-Path: <netdev+bounces-195723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33121AD214A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2655E3AC43D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7544137C2A;
	Mon,  9 Jun 2025 14:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EA8F40;
	Mon,  9 Jun 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480538; cv=none; b=P8ml1jZUzs6htxUGDKv4Dq7CiygCoG6lhjDiLZOLVi/qFpLuFgH6T/q0hWCb0dPpspneK88bAEAFwkKULr4Jc3GCq9Da4QkDZPVrI3thMUXIgZMJhBBGdJjvw/O6m5mIxasjvSq4/YuPCTniexsab54LSWfqwakYqZ+BlSl9bBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480538; c=relaxed/simple;
	bh=bXUCEysAOb9uw12WSpLEv5WjGJ/MvLt6RCuqsE0t33g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y5JwzU10vmBPaofQQPe/FvB24gpHhcAFVc8S7HORuHsuXlNI9AkHShXXw68QfRA79s3X8XN6WJ2DTcuq/rVtdKs/JTd7xB1ahQZoZ3VDqKc26zkj7tk2Dk3Jo7cCkNftfCooBqO0+mnzCueUc0alfAfVCPtyW2zz1ulzz0dUA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGF7X1MTpz6L5HS;
	Mon,  9 Jun 2025 22:44:40 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CF3C1404FE;
	Mon,  9 Jun 2025 22:48:52 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 16:48:46 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v3 0/3] hinic3: queue_api related fixes
Date: Mon, 9 Jun 2025 18:07:51 +0300
Message-ID: <cover.1749038081.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500005.china.huawei.com (7.182.85.13)

This patch series contains improvement to queue_api and 2 queue_api
related patches to the hinic3 driver.

Changes:

v1: http://lore.kernel.org/netdev/cover.1747824040.git.gur.stavi@huawei.com

v2: https://lore.kernel.org/netdev/cover.1747896423.git.gur.stavi@huawei.com
* Update cover letter subject and text.
* Add 2 patches for user code related to queue api.

v3:
* Turn netif_subqueue_sent to inline function (Paolo Abeni)

Gur Stavi (3):
  queue_api: add subqueue variant netif_subqueue_sent
  hinic3: use netif_subqueue_sent api
  hinic3: remove tx_q name collision hack

 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 23 ++++++++-----------
 include/net/netdev_queues.h                   |  9 ++++++++
 2 files changed, 19 insertions(+), 13 deletions(-)


base-commit: 90b83efa6701656e02c86e7df2cb1765ea602d07
-- 
2.45.2


