Return-Path: <netdev+bounces-207143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD5B05F4B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF493B32B7
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BC2E49B1;
	Tue, 15 Jul 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kjgKyL39"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E02E4997
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587245; cv=none; b=jdCla3pdMjpqnh8KRr+7f7WQLHmmeTksXXsOpAx3qQcFnox+nCVcmeZFt1M52745xcsl0uh8EvjB00gncDnhQ6W11uhF5QKDfZtnBkD7gemxT938QpQeB4kFtjfM+5SYMUI+dFx1/tdwgqjqpHZnJjkQ/HRdS2P1kqmYGUW6bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587245; c=relaxed/simple;
	bh=NHY04lWbnuGt7TUMVXMBAd99xrE3nzf7tN3dhvAdpFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACDOzjVccID0tP/vqmKpniTOWNc+vbuAPuLYcALZXAS66GWO4IbvvhA4k+HrjEbyQg2vVBM2zWfCWkhtvalKjKAjJFnWJ+RJcwc4WYsnMMT39rXa5LaIJs9Cb+cR4pMwebh1rpDpLjw06k233pcuR/KVVLPDIpUzmh8icQ7wjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kjgKyL39; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587161;
	bh=NWDrOIeUTkfMgeyG9DirCptVDnqPmotqOLDK+VZpCcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kjgKyL395Bpv+Gv8DO1Yp/nbLJUdG4lX5EExTEGa5HvUgx02Vp1SBT0Gb/y0HJ70C
	 1+EK2g1XPTpeg5IzW8sW8CkR4SxSM/kfWdPVtirIlmJjKs6ICQM7PC7yVdfUmzyud/
	 6/TgenGECuUxaVU/HjvcO3soaKw/bg/n+g+rMOa8=
X-QQ-mid: zesmtpip2t1752587129tb54538eb
X-QQ-Originating-IP: PsIrTfnu37O5BQpc09CPKOeWtbwmOWY2B4qF0spybKw=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:45:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9443703254596192763
EX-QQ-RecipientCnt: 63
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: airlied@gmail.com,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	andrew+netdev@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	arend.vanspriel@broadcom.com,
	bp@alien8.de,
	brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	davem@davemloft.net,
	dri-devel@lists.freedesktop.org,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	intel-xe@lists.freedesktop.org,
	ira.weiny@intel.com,
	j@jannau.net,
	jeff.johnson@oss.qualcomm.com,
	jgross@suse.com,
	jirislaby@kernel.org,
	johannes.berg@intel.com,
	jonathan.cameron@huawei.com,
	kuba@kernel.org,
	kvalo@kernel.org,
	kvm@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux@treblig.org,
	lucas.demarchi@intel.com,
	marcin.s.wojtas@gmail.com,
	ming.li@zohomail.com,
	mingo@kernel.org,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	niecheng1@uniontech.com,
	oleksandr_tyshchenko@epam.com,
	pabeni@redhat.com,
	pbonzini@redhat.com,
	quic_ramess@quicinc.com,
	ragazenta@gmail.com,
	rodrigo.vivi@intel.com,
	seanjc@google.com,
	shenlichuan@vivo.com,
	simona@ffwll.ch,
	sstabellini@kernel.org,
	tglx@linutronix.de,
	thomas.hellstrom@linux.intel.com,
	vishal.l.verma@intel.com,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2 8/8] scripts/spelling.txt: Add notifer||notifier to spelling.txt
Date: Tue, 15 Jul 2025 21:44:07 +0800
Message-ID: <A205796B545C4241+20250715134407.540483-8-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MycRura4/XvKSghc7/pa9XHASutBsOQuzzHY2t37wkqnL3EQ4b2WP1Gh
	ElPQzWwQFnREb3nQLWJ3qNzjb3GcBfyJQKPQJ69yoG0q3zHaR7KQSKKXEsSHkMcoRM1k1BY
	ps22/1Fsn8ySr1dc7bfZolGEZmjkxQssEqY9w2BSkA2XLRnIoeKrS7baLaSRY+pqXVNX9V7
	5WZifSZZU0GTWkbHj5EVtB8VGov6xpIuEQELM0qeKO7zsDY1lbolGVIThKsrApHifihhx10
	kGbHlbr/XyYZCPJSL38sDGEvgAvMd4h8mxd0UzTJzqi5eBn9xm/nRX6lh58v9YfhxQygE8n
	8z+tICs+z+h8xv1w/BwPwtWN//u/2d1LCIv0PSkPjewkoyyF8Xed/LcJ+QeFCHo2dy8QdHb
	4NljU0ORp/rJkPBOrJXrTOu1w5VHR5GHiAqvAocLjcJ1a6ndacn0gfMu5OeKC2wBOHhUNFR
	SKHclylNdXcTXdEmOI4lFAQAMMmJdBJ7joZqeQN1YiqsHnY5ZEtudusulG2RyUDWbPxbQ2m
	1mKDH24orXFn87VH0DKvhK7sCBYTqUqoznSQFgjub/r3vLIQu890ikweU25IXIWi/4spciI
	h/aOfxddCISl+f3p2pBdd0JQVIkWABbETYXu3QJNFPbaDH0uQrjUAnUxAQ02wdN2WWLRPi3
	5Vl5jR7tEgE+dy/Zya+9+QwysaAwx+HZlr6A8lX+8wIVHpMhObBlww95PNjNSlW9WTwdylO
	3tsH49ARtWp1b39aDGNKlMq8iQ9SN3X2Cs5VwkBDqKn+auYNXaqnYLPRxnPjBpJpRrLz6Gi
	P2lwe3W/OjAb7WxH5OM6r3NDxGjiIKtvDu/Bq4UoXh465lOyZF9eirXc6DMEe8pROGUZGvq
	/92dzLXsH5aN8F4isgT1Nj8kgj02Rn6wA9jL6fb5111ik2fZXhveOqSU7sykaxtMkkeDKcR
	EiLjmufldz9fBK7+kb6t522q+4bOCQYh9yPE7yK0XSFr6AnjUiltOZfOC7cTmIG3c2vK9lf
	EK3CKh0lbnwcaHdpdP7ncsBzcwk+BY090uuUgsyxIvZXVgcJxfKALtGg+fE5BbuMF8rDlu9
	KArMdL/MEdR
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This typo was not listed in scripts/spelling.txt, thus it was more
difficult to detect. Add it for convenience.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c9a6df5be281..d824c4b17390 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1099,6 +1099,7 @@ notication||notification
 notications||notifications
 notifcations||notifications
 notifed||notified
+notifer||notifier
 notity||notify
 notfify||notify
 nubmer||number
-- 
2.50.0


