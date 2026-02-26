Return-Path: <netdev+bounces-261321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ONfCEw5oGmagwQAu9opvQ
	(envelope-from <netdev+bounces-261321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:15:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB981A59B5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB693309BB5F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7149237BE76;
	Thu, 26 Feb 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UuJ9uiXA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6C374739
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772108105; cv=none; b=XmyK4bci2aUqZwZtOKWv5gioWKNGP12EFLGgvR2j9tNo5YNfR7Z3rbRN4XR2JLsXkI+vnlreDxWstkxn9DKCeRV4DlkYiwEI2c5ObXFRiX77aeo+HZELLjlleZ4/fSM8xDMfsOZXMbUDjWnR+W/A6kyEOHsppMO1HvOSi4FKnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772108105; c=relaxed/simple;
	bh=/D0VCH1e7vsWB1v0cdB1ZLfOAz73ckmBH9AksnbJKPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQVdNvHNPZ8zEkx9G0YIIwh2eF/fIW8/DvisHoIrR+uiS5GiQurfLrDEEYbXq9Uo8KMuJd9GNDo89BE+DBijIyanlA3sbxIStWB7RlurmUDsP2y17pG2d6+r1WTzjiqTIFWX87nmhzRT3rreNwUvnfIimi3WNCQo1Us54AW7mmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UuJ9uiXA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvACg3276941;
	Thu, 26 Feb 2026 12:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ZiuYe95N/r/0iknTHRZ9InuRGSr3m
	tKlZye6xhqNupw=; b=UuJ9uiXARZ711p2n4q2DcarCuR7ZJ+O2gEaybQ7YAGiIH
	LynNmDnvRLJVPjLSwlexNNdEsKBJKzuDvFqrioPe3oF40g32w9li/ygwVhLK5gbi
	oEqNulcTcBxZAjyvVcQWoqsDtgV35bp8kzaw3RxE5Zwq2D1YdxK/G2D0lqbRlMW5
	wXuJqvEG6v+qPqIJE4g+18cbRrSOsTKwmyZbVSH6317/qDpHGQ9Q3Kn1UbDebgJL
	8eDGlcLY1TuZFdKxLRiKq6v+EOj6Zym+fxnwmlybjTZMXWyPL08hRHAQfHmGCzxE
	LOsSnLblKXi0+mNgfv3eHpsrb5Dhn+4HPIKM0MB4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k60307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 12:15:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q9xJD3028525;
	Thu, 26 Feb 2026 12:15:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cd86m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 12:15:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61QCF0k1007805;
	Thu, 26 Feb 2026 12:15:00 GMT
Received: from ca-dev111.us.oracle.com (ca-dev111.us.oracle.com [10.129.136.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35cd862-1;
	Thu, 26 Feb 2026 12:15:00 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [query] about max_hw_ring_grps override in bnge_hwrm_func_resc_qcaps()
Date: Thu, 26 Feb 2026 04:14:53 -0800
Message-ID: <20260226121458.4177513-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExMSBTYWx0ZWRfX2rWH+4j9nBv7
 SAva8gfE2BZs5QJuVxv5ohB9t4XXXEAjkN0mFST9yI+JXKXNLk9uD0bVAHbmjXl9F21vx9OPYw6
 JPjfaeMlgkGUd3dI/7uAZwvn1hTxJJjcwIpJbh89O+Vptk0lYBFjCex8epCEoC3B+wdICM6W6aR
 UEV2jBD8EJONrcliPtmCbpvd2ra6FJCZoSxSi5Hgj/ktj8sq1Ssnnu7IydAM3bxfKgKfk8M4Rj+
 coBOGLVnpTiU/lyTR0LZEGesex4OL+S/+PYwMg7gZ0t8DKmrFEp1on5w90wdFtjNPmwPaOZjfkM
 XmB3+TfJsuIXIxWlyWKZfGUw2SttFL82WL3rOQouQtxhn0UMOkqLODBzauSYee7v93Nc1fe7uPk
 DDEaN8J2KMiZFgkG2w+Hm96YGUF2uetGr0ZD5ielogo3mGKlITLgBpFXM870IeXPwr8TTgaV1b1
 mmXQjC6ilitFlP/r9TA==
X-Proofpoint-GUID: IOA2J_e5fWh-RS7mXBcgmAd4W4-T2gLe
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a03945 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=MQtGhKDA80uH7Jz0ISIA:9
X-Proofpoint-ORIG-GUID: IOA2J_e5fWh-RS7mXBcgmAd4W4-T2gLe
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5FB981A59B5
X-Rspamd-Action: no action

Hi,

In bnge_hwrm_func_resc_qcaps() we read the firmware-reported value:

hw_resc->max_hw_ring_grps =
        le16_to_cpu(resp->max_hw_ring_grps);

but later overwrite it with:

hw_resc->max_hw_ring_grps = hw_resc->max_rx_rings;

This effectively discards the firmware capability and assumes
max_hw_ring_grps == max_rx_rings.

Is this intentional?

Thanks,
Alok
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index c46da3413417..9ba72c6b4604 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -565,7 +565,6 @@ int bnge_hwrm_func_resc_qcaps(struct bnge_dev *bd)
 	hw_resc->max_stat_ctxs = le16_to_cpu(resp->max_stat_ctx);
 
 	hw_resc->max_nqs = le16_to_cpu(resp->max_msix);
-	hw_resc->max_hw_ring_grps = hw_resc->max_rx_rings;
 
 hwrm_func_resc_qcaps_exit:
 	bnge_hwrm_req_drop(bd, req);
-- 
2.50.1


