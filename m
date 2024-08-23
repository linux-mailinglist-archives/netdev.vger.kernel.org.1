Return-Path: <netdev+bounces-121432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFBF95D10D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7684D289724
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA6191495;
	Fri, 23 Aug 2024 15:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E81190067;
	Fri, 23 Aug 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425627; cv=none; b=OWDHtvBiK5Bd14zRTVW06vvDNHek48BidTJAbm/OnyEEXecTuJxPa5EuW44qsgByX1ALci6ECOF74I7ZQfVKQygbSux6mFGtA/soJk26KDQ8icleVuYB35jh62l7NbZqoQJP5w3JjvMU3HF0FNLLiVIAkYxknqKQtMowQ9yQp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425627; c=relaxed/simple;
	bh=YsfC9+nD/qkrgp3ee7v8HRgNjCCd0CcWxmByb8pZZgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXArq9emJBF0rFJFwCSu2J3id+kIBgz3lchguJUXDe2m10NhZ2dKknpcquf7P9hLh4JzGC4Kk8Z5Eq1UI/1SV96bLYA/R7RAa02yEHuZlK4dvtcauWxYslWBi3QVvTrpj5g+aOgkIpIxMdnJt8ebjQMsTPz5266kRNNMuhCA5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wr3M50qK6z1S8VB;
	Fri, 23 Aug 2024 23:06:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CAD9A18001B;
	Fri, 23 Aug 2024 23:07:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Aug 2024 23:07:02 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next v14 11/11] mm: page_frag: add an entry in MAINTAINERS for page_frag
Date: Fri, 23 Aug 2024 23:00:39 +0800
Message-ID: <20240823150040.1567062-12-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240823150040.1567062-1-linyunsheng@huawei.com>
References: <20240823150040.1567062-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

After this patchset, page_frag is a small subsystem/library
on its own, so add an entry in MAINTAINERS to indicate the
new subsystem/library's maintainer, maillist, status and file
lists of page_frag.

Alexander is the original author of page_frag, add him in the
MAINTAINERS too.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b291c3a9aa4..14d01fa02aa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17237,6 +17237,17 @@ F:	mm/page-writeback.c
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
+F:	tools/testing/selftests/mm/page_frag
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-- 
2.33.0


