Return-Path: <netdev+bounces-207142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28622B05F34
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F127500082
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE82E3386;
	Tue, 15 Jul 2025 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="A3sIOoxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D52EBBBC
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587199; cv=none; b=loQCCOfhg21xg5iveLKtAsJqXA0E19sMg8MqqQMMVh0SvWN9uhHQTBJbwdY3ox5jJC7Mxl1kERp5pi911eGARGHabupJH8lyms5qCB4zbboc55158jHJk/XSMu7Ter2KM+b7LHtLYUD3Zcckt4DkIL4QPU12FLi8q1nbroMhfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587199; c=relaxed/simple;
	bh=HjU6PxyUlCUhs2dvYf0iMA7Zry8aPzm7Aen+lVRuL90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/mNgPSOnJNJTK7skYWaZQk78djWSDNmuRWOFsXksJpwVkoFrBvSuZLWEVvNjOu3Ez8+0L6m4sG+NkQThMFk/XgM1TaDv79+sR4t1k/o/TFgnAr3QlykwZ3XXygx39Vg1F+YyrMGgEcKfgXEvTrjHKm464Lrq7jR2Tz8NgK7+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=A3sIOoxq; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752587136;
	bh=ltFUUSzAPz2OoVfH54nkwDpFnO/axW/szGNu9HIiAOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=A3sIOoxq8qCcErnRKrwZqcxB61P7coOwgAn1V8WUJ2licka7PBrzVtxm3qXhQQV67
	 64yVTQn0oswUZT2lAhCRrAX6i5gHwHWc6YcD/GgbpV1dZ4BKVSHdRV1sdFspGjW4x4
	 1lBR9E07CbFunXqywDuJ/d9i6iE/7DtltT3Va5xY=
X-QQ-mid: zesmtpip2t1752587121taaa03ec6
X-QQ-Originating-IP: IIvVAyKvuXb4Hz7pVF2rGJuCkoWUtC78LZlVFBjDx2g=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 21:45:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8982638937609059235
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
Subject: [PATCH v2 7/8] xen/xenbus: Fix typo "notifer"
Date: Tue, 15 Jul 2025 21:44:06 +0800
Message-ID: <906F22CD3C183048+20250715134407.540483-7-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: M0vH/xy+mm2+jN6c4WGTdeZjsrpi+JQtsnTDdG1x9FGOZX7SZgo+cUCm
	t37lSOf7yQFsVMLdFDCRezb/LROAB3NDOjPsKxjdjQFLSEsyxxUl9+qQ+J+Gk4+nEP1TrkU
	JisWnONIPowGJmVptxWoWvzDbwPpJqdf86IWmncHlW7jPeRKxIU14VXaHKrK6yuHMP8eMgJ
	z8p99qqK7XgXmTXvWiM96ZDey2wqJ+ItEvYo/N0qdMSRtM+n3M07gDpgkmCh/CaEkr7g0mT
	YqOJQK5nWZV4+hyHKtW6IK3+kw8URz8J7Q67Gu/xpTeJoFMcSO21oSXlzVC56JNQnQbDYeW
	PVHerz1Nt7FhoWdf3kWqPqmG9qjrxdLNW5A0g8BzjURO4d0SjL1IUSukzWrBb/UpuMC4xbt
	8ixIne0xM+vspzfOL7eS7Kmb88tk06oCrB/r7TBAmh38DqXZeLJU74mqhQM1I/l3xAg/Npe
	L8HcGBcJYZ8/0kieXpuCiH5xI5QJNbYayvydeSr3tP0uFShIPs/w2jyJHdCgN+hhbWkIjYs
	7SArdoFyAQjVFwBTc2FwaKt/btnNUSmK3LC+QHtvGArHXLcfKs2PaRXfHjWUS6MirFTyzkR
	LLRBX4SbBO1L9LLTzln4N0/qdsQhRWEQJgZscdE6O1f9Nm78vEk5gXPT5Bp6UFqK2NwFV9b
	Al5LhzvGxk5t9r5ewi9AHzA2pI4SDLHBWecWHdIVk+ok91+lQVKEpAGFv66dIuqC7vJx6JI
	hnpiMr0vLMQKiWqTV2iVy0vOY8ElIHjWP7xmGEK+25qU2LiQxehwC6bi3YKYilD60bLDR5+
	U9IQCaprga6pMI7ZEeO/1wnRLyQVvhRvvg/SikPFmxJ/oiPx1i0ps21NwhKl2bdVvECNhmm
	mHsIRe5PAe6I3oxnYTR/Nc3BqY1lQ2I/+4jiRvYvTpT4h3XV8uIBUm2IXfha1hOyr06vW5N
	oyFrdoF5yjIhR4+F7RDVWoY8Ra+IAZBXPxeFl3nKssNKJBU1tC5Ds9MFj7jyb3GRGjthaEd
	NO/F8tDNjIs046zc/55pYvh9Jor79cNBHwXd9Cu1dgd1G5jyGTk8zm+yZGHkq53T7yZAWTN
	oDNMOTChdZMAJMRJ955OHii6HYZ22iHSkv1eH8/gOYi+ndhGzVl54A=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Link: https://lore.kernel.org/all/B3C019B63C93846F+20250715071245.398846-1-wangyuli@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 include/xen/xenbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 3f90bdd387b6..00b84f2e402b 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -180,7 +180,7 @@ int xenbus_printf(struct xenbus_transaction t,
  * sprintf-style type string, and pointer. Returns 0 or errno.*/
 int xenbus_gather(struct xenbus_transaction t, const char *dir, ...);
 
-/* notifer routines for when the xenstore comes up */
+/* notifier routines for when the xenstore comes up */
 extern int xenstored_ready;
 int register_xenstore_notifier(struct notifier_block *nb);
 void unregister_xenstore_notifier(struct notifier_block *nb);
-- 
2.50.0


