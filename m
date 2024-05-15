Return-Path: <netdev+bounces-96564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E68C6714
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E96F283E90
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9113130A79;
	Wed, 15 May 2024 13:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF47129E8C;
	Wed, 15 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778801; cv=none; b=FQHEe3WPkV1apIVZK86iIfbrBW7NIJkI0ix3eirQYEMpDpAyNiFlbtMCjNDHQUDpck5WKECvM9EyFUqTkJmJQdUiKOvQMX4BS2vEn8IgeJR8pIP+aWrTgq6lzU8E7lhk2Z4qozbB4bGkdEsH21NmogK8+vLjGLENj5zoGywIz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778801; c=relaxed/simple;
	bh=wRCKhxV7zvGXxC90jxbtGJoR75S1QRttnfk4RRvHJOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQX+OUkpFud3SCrh7B6gIAPPCv79DksbejkfYrCPaJtt6bxRyH7gLQBT5NIwBGRQ55C8n9/CdGKz5ye/u4ZdIlfk1YqmOIHiQ/bvgoBkPg6T6DeTz4npiRVTIX9U4+hKJZANWRz8uiZxlCTN4CZFpjkOSro3If2p7BwxNaQMwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VfYV05LTyzkXhc;
	Wed, 15 May 2024 21:09:44 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A214014037B;
	Wed, 15 May 2024 21:13:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 21:13:18 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>
Subject: [RFC v4 13/13] mm: page_frag: add a entry in MAINTAINERS for page_frag
Date: Wed, 15 May 2024 21:09:32 +0800
Message-ID: <20240515130932.18842-14-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240515130932.18842-1-linyunsheng@huawei.com>
References: <20240515130932.18842-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

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
index c4c6ffbc6d10..998c5e868dd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16709,6 +16709,17 @@ F:	mm/page-writeback.c
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


