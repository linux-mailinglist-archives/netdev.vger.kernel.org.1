Return-Path: <netdev+bounces-208814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28304B0D3BB
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3623ACA3A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC92D8369;
	Tue, 22 Jul 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bWMI3G2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DE2D6630
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169868; cv=none; b=gbDE5T8i5Jg0UwbwLSuqDxRZDP8JLfa+cBWBFVJENz3akDVTmgxB8DM2PdNf0ElypH2nQo4dd+0DzoCcF11ZcgcJswIn9t8fcuaoZN68faqUffccqK3WMu5vl3T4nnrmsjUYo9SXvXtOEN7P6LXAb6v3WUORQuUI8oDdX7Q2Cag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169868; c=relaxed/simple;
	bh=pif+UloRwSr0Am2GfxtN6NiAOi/V8GWq84r2WOxYR0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbHojvND2GakvqeTjvQJcO0YABoZElmtYX83+3fKh6PeKSIJYXxBgWe2sNk2vtRaAphXxTQCXpHylsvn2t/QOqlO5+sqepz6HbHIAaH8R72hur+8e9Rfda/bABSNwjptV/Ngk0bKg6nSO8vrb0yEzm98nUQaEKh0FPMxzjMayNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bWMI3G2t; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753169790;
	bh=vYmY+9tqPioPK6cSdujQjMbixbob4YHFsEPo+u1e8jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=bWMI3G2tg2sQ9TLlEb/YhuFjuscFDegOce5lLCzYm5nVtlxwel+1d6njCILzlmJ+h
	 5O1nt+gP9NfvaOse7fagdnf1XvO8MsPnxG3Kx60lKVs39s0nsso3iu+m7wysyb5kQZ
	 nanlWLFBJsPeTGmJLDzVKPEzoFt9vOI9y0Exqj0s=
X-QQ-mid: zesmtpip2t1753169729tcf86fa72
X-QQ-Originating-IP: HNLldTyG1udNmPKueSkK9C3LgPlbsP2VGGl0nQkGM08=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:35:25 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14499228657243384026
EX-QQ-RecipientCnt: 64
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
	wangyuli@deepin.org,
	x86@kernel.org,
	xen-devel@lists.xenproject.org,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v3 7/8] xen/xenbus: Fix typo "notifer"
Date: Tue, 22 Jul 2025 15:34:30 +0800
Message-ID: <C6633C66376C709A+20250722073431.21983-7-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
References: <576F0D85F6853074+20250722072734.19367-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MiCmIIZEBTbfIA3fVM9nfaZP43qp6oRhRUYQO579CYgUESz+KjMTIhhm
	QveNyEGs7Gdkl8AzJOWDduvN0x7ArBvgCuA7aPbc/AIZ2gzMhnVclu1eXPIox3S/ie4Y51z
	oag+eAifkqz3Bpupqb1ISWsc9JBDx/SlpAQ/sl/dTdZM4uz1ICk58Pr+SnaEiVNqxnWpwGC
	xkCCndJVpb84o/DBjYz1ESZx8CgPmI3O20ApzLpJYJJomlkPQ17bLDoCW07vabLHWJTTN/l
	p5S+EQRAfR00cxmcRdsyqijMcVLV3l0L0p2tlFSJIfLbHX+0wolh6EXlw+4v4vH/Wn1DyPI
	4CrkwFR21roElYI7GWrzd/lSD3HCq0HBAQ65sziKInrObryC1j6BeD7rAZAcc0upNPQ5Ff1
	GWdqevBFBUiPm8D/SuqTAEH0jOKIE5PvBgA6bxEnRnFFInMYnqA9h30l6jAqtF+c8GdwdRM
	ejE6nkl97Ui9dDyB/mi8ERv5gyGzqaBbaHFL/AYAKgrVLQ7UNuHJHWeKebnHm/gGcTrlfQo
	fzwH84aIakjVBC9Mt3/705saV8QB+zK5RMGTf3uJJznws7MTg+JuE5PO/VYTJNmEVZXOP0O
	JK5JiCDmVjUpYXX2PuigHqdkG7DcGLrscRvyFEsj4lIFjfD1ppRJTfXkfpLmWxbYqgwb2WW
	CjEuW7ceX5ezPAF2kVuhOYdqbMNpNxr2LHDwbtEj3cEJV9oZfJ4Nvq3Aq/aMBf9KdfT+ToS
	u+c31KvOfMD6Yeu38z3IGR69uznntJQ6/jXNAkUp082BN7ov2Up4Uaxh3YZrmsbgJouh00g
	PXNt7TIRuac2OwM14s6O0EhilddxH77lm9W93G+DtNqlnLYP2eXxiNGOSw1ZWasImnE437g
	ZVzbz3V++9XpU9x39WZBkOVCQ3cZLEmfys7LSRsnd++c9v8f+gZl05WXss3sOus2jX4MYO1
	yZjlU6GFZOhyLcTAmsbuEyGM8cjlzlJLkNC9dulR8O7puxTWzNgzG4ET4bLo5k62coPB5NR
	JtTovou4sT303tL3BrMMwEOxWVi3ve9206oa7AfpcfmwDpehjrSAxJo82Cspy05pM98aP9p
	bibQ6cSLjQmYaDuCYqJztUjse+79M7FLNcwnprfnZY2M3DfvZhSQ/MlHYrh04vSBg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'notifer' in the comment which
should be 'notifier'.

Reviewed-by: Juergen Gross <jgross@suse.com>
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


