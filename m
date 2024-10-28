Return-Path: <netdev+bounces-139541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F59B2FB3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850301F234E3
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7B81D434E;
	Mon, 28 Oct 2024 12:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723961DCB2D;
	Mon, 28 Oct 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117140; cv=none; b=SEpBVCEpIR3VHn6wGwDbn7VG479Z67qNtJkp4OplGfUhswVOvN3bUbcMGSd+AbFAa7bQ3ElInWrU7vVgi6MXdF59slAG4WqcXAgBbOnhhcBT9m/H4vYUcYznB6O0Xsr9nCJ3tIsM3X9b++DD6lGOtXS11sQJzUxzICckCuXe6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117140; c=relaxed/simple;
	bh=VXYtw/EXJZSrRHyQbodfvqQyNsKyIoED1VmSrb+lXb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuSkSA3Mf8AjCxGRAr/2nM1sLW4ubXE+ukDK8Y3gADJXnnzLeYcvoFhbZQ0MN8NzwS4sCeY58TyIiGl+OPqwMi4YUr7GVbDRmD3Ig5UKzG6nNtu4TrROKsZ8B1nRf+wF3Jydj5Gvo+q3n0l7tnoL217eoFhNadmWLCHKwZPtAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcX9314cRzpXWk;
	Mon, 28 Oct 2024 20:03:35 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F7BA1402CC;
	Mon, 28 Oct 2024 20:05:31 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 20:05:30 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>
Subject: [PATCH RFC 10/10] mm: page_frag: add an entry in MAINTAINERS for page_frag
Date: Mon, 28 Oct 2024 19:58:50 +0800
Message-ID: <20241028115850.3409893-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241028115850.3409893-1-linyunsheng@huawei.com>
References: <20241028115850.3409893-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

After this patchset, page_frag is a small subsystem/library
on its own, so add an entry in MAINTAINERS to indicate the
new subsystem/library's maintainer, maillist, status and file
lists of page_frag.

Alexander is the original author of page_frag, add him in the
MAINTAINERS too.

CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linux-MM <linux-mm@kvack.org>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..9f84f2e901f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17399,6 +17399,18 @@ F:	mm/page-writeback.c
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
+F:	tools/testing/selftests/mm/page_frag/
+F:	tools/testing/selftests/mm/test_page_frag.sh
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-- 
2.33.0


