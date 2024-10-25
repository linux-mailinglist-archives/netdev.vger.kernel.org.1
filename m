Return-Path: <netdev+bounces-138983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044F9AFA63
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314211C20DE5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 06:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AEC1AF0BA;
	Fri, 25 Oct 2024 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ipvoAb7w"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0431F1A7ADE
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839301; cv=none; b=VwQ6N4FDPDSZXfI6BuO0vS8wK/+ccmlMwXlg5idbHls3lCY8IYQ8YCwY5VjvOld9j1OGd2K9RiyhNWhwjugsfb0svPhGP8Id1EzUtewKcjT6Uwmbnr2q6Ij1IR7fljaVf9iJBfP6nB9gUovBs/YrEYiLSEz0mECP7fT81riXLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839301; c=relaxed/simple;
	bh=tux+kVXoxeqatZsSvhUcOundmYXP9bd2WCJpZ0y15bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+WUK1zlpDuIq+lo6Ji+TeVGMGVA+OEnAYNJiannl28uZgdantmWRG8gQPzz6GdnOa4NP/JKrRGeTU05ULHowzNegqu3HvfYYdcJFLWC2W2sUgVi7A/XYrXUocBbTErQVoSyqwlFYCZ51xKJk8kox5acsZbx/gK8Mo90thvYf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ipvoAb7w; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729839296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utWPae6JOH6Gfwt6/OMxC57uOc92cN39G9Jp3wctaGM=;
	b=ipvoAb7wizNjLbnsMi5gnUC/2Kr5hGsx/CI0ySYYppvcYpqlTUz1B850F9inafyqCHXzXY
	E7DkHEaMgIrYY5RDQAZgpijc6GimwDDPw1Lz4E/aK0wvTtEMckswS67XU2Qo1fzsMF7QGG
	/XCQUFIUIWwLWVvd2uhykQ6kIGC1GUk=
From: George Guo <dongtai.guo@linux.dev>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dongtai.guo@linux.dev,
	edumazet@google.com,
	guodongtai@kylinos.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com
Subject: [PATCH 1/1] add comment for doi_remove in struct netlbl_lsm_secattr
Date: Fri, 25 Oct 2024 14:54:41 +0800
Message-Id: <20241025065441.1001852-1-dongtai.guo@linux.dev>
In-Reply-To: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
References: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

---
 include/net/netlabel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 48106f910139..7091c8552fa1 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -209,6 +209,7 @@ struct netlbl_lsm_secattr {
  * struct netlbl_calipso_ops - NetLabel CALIPSO operations
  * @doi_add: add a CALIPSO DOI
  * @doi_free: free a CALIPSO DOI
+ * @doi_remove: remove a CALIPSO DOI
  * @doi_getdef: returns a reference to a DOI
  * @doi_putdef: releases a reference of a DOI
  * @doi_walk: enumerate the DOI list
-- 
2.34.1


