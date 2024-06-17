Return-Path: <netdev+bounces-104038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E6390AF0C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F041F266B8
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33D198A0C;
	Mon, 17 Jun 2024 13:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457C19885F;
	Mon, 17 Jun 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630281; cv=none; b=tVKv/NbKoOagHFRlPVdsCjnVh0Z3HfP3FegeDnm4/WVnZ8Za20Zg2VVkEX4f8tY0lJH3vg4N9SVuysEjkxC+nJptFEouHbzB01dXemLWZ789s5BSbWpKLhUWoIyYxwuryEPwMpQUu7tR/jS5eiNhqEdUDp4i9bOVAL0fZzPmuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630281; c=relaxed/simple;
	bh=DQpyE4LcoP5CQrtouqqIWkyt30utSJoMGx1TjK1UjWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCZNaU6t+yxtgUkAN+ATwMS6C5Q3W2EF4aF8mzhz9SEUwhyx3G07mi0BNur6D6kGP28723/+f0zZJG9OQDnC3XxMWzGl5mqDCjJfU3KN3ZXgTHGNmFZDWYy9eVji0VZUctgCknauBB2LolqF88N2IPLRwEO5OCNHTbrHz3fnn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W2r0f16sWznVxD;
	Mon, 17 Jun 2024 21:13:06 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BC16814011B;
	Mon, 17 Jun 2024 21:17:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 21:17:57 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next v8 13/13] mm: page_frag: add a entry in MAINTAINERS for page_frag
Date: Mon, 17 Jun 2024 21:14:12 +0800
Message-ID: <20240617131413.25189-14-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240617131413.25189-1-linyunsheng@huawei.com>
References: <20240617131413.25189-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

After this patchset, page_frag is a small subsystem/library
on its own, so add a entry in MAINTAINERS for to indicate
the new subsystem/library's maintainer, maillist, status and
file lists of page_frag.

Alexander is the orginal author of page_frag, add him in the
MAINTAINERS too.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e66b7d4324ae..16ff7a33c199 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16951,6 +16951,17 @@ F:	mm/page-writeback.c
 F:	mm/readahead.c
 F:	mm/truncate.c
 
+PAGE FRAG
+M:	Alexander Duyck <alexander.duyck@gmail.com>
+M:	Yunsheng Lin <linyunsheng@huawei.com>
+L:	linux-mm@kvack.org
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/mm/page_frags.rst
+F:	include/linux/page_frag_cache.h
+F:	mm/page_frag_cache.c
+F:	mm/page_frag_test.c
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-- 
2.33.0


