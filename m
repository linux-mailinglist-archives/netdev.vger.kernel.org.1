Return-Path: <netdev+bounces-123668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B6C9660B1
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D189A1C25147
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F71B3B27;
	Fri, 30 Aug 2024 11:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89F1B2EF2;
	Fri, 30 Aug 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017111; cv=none; b=rsUsKVRYe4kWiRMhbKrK2pMdmIinzKKDYovwnZLGBLuaGUikzXx84CJrPXmibk6sJe9WfEzEartw8zOqtZNaYo3ZDLTnBDJUgbbe0uCFbkwCuZ7mNzhdSd2Zv00ygCyY3Aa+9fQ+Lc15E5LFPVbqUrSjlMwAoDimHUkNQIS7Ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017111; c=relaxed/simple;
	bh=qtsjIH9wOGTk1Dgrata277dNnCjQOpF2fUHYAYgK2zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KskgXWjlPvq+ps406ReI/naje9WS7e1E/HdS0/lsMijgR0l5qXu6dPPfNo5qHzX59O344G6ypXQ6jEHJYKiAyiWnz5pwDtKh4NzpjMrrC3NNru3PcgLZuH//fjJxE4lNe3GnVoOAqFmRLav6RplGveDcyjhjco1aU7n3vRI0WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WwG5d39rVz1S9Tl;
	Fri, 30 Aug 2024 19:24:53 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F01BE140136;
	Fri, 30 Aug 2024 19:25:07 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 19:25:07 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next v16 14/14] mm: page_frag: add an entry in MAINTAINERS for page_frag
Date: Fri, 30 Aug 2024 19:18:44 +0800
Message-ID: <20240830111845.1593542-15-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830111845.1593542-1-linyunsheng@huawei.com>
References: <20240830111845.1593542-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 289a6b5615ce..7220b112af60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17259,6 +17259,18 @@ F:	mm/page-writeback.c
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


