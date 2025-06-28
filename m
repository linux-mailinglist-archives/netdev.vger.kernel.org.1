Return-Path: <netdev+bounces-202174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8DAEC802
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5187A91B1
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 14:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3696247291;
	Sat, 28 Jun 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QsXDyBOW"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB07248F70
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122630; cv=none; b=t3l2T0O5gMXGX8jmkndKfdy72cXVI/Ug2Giyj2YYzvlNR92QCQtpPpXlLMCWNy25tb2WpOmiG3RLkrDYmKUHxWtMTjPVzLuEvxBvvqpZjUB5PSMJt0d8KtVFf0/RD2wLbn3zBWuZbzOz2BhCwaTtFX9mwszpg8RSgsWoFMKogsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122630; c=relaxed/simple;
	bh=uXBO9wGx9824iq79q6QS6/MyRkKkCvxDbtA1w7r++fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZWPEqXk3xC+ZajMYwESjOxtrkIO+IVWxCRwnpfglYrjn5S51vPzkHKpmdq2V51A/V/KTLbObYdGT1w192/qqE6ofMwaznvM5b9l10dgsMcpIL6DuMo6GtPEM3Y0GJLjSTsJhY20bKehIucqBzmLFeaAbRYKMN8eRyR+Ajfq2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QsXDyBOW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SE3LMB016125;
	Sat, 28 Jun 2025 14:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NL7IwHrdNNI6ATINK+RRt3S4EACGJ
	BBVPSu+vEzfDmo=; b=QsXDyBOW8zojno26JohZ5fqOUGK5QnqnTQBCVDzbrehd7
	NNpnVcERtHilDsICvIGoefF+SoRHK6Ah6ny/Cva39xD31ulD6kE4keScVhMDUFCt
	Nd/tXLl5h7/H+5YQK85gmlYyxx0mzwH0pbrXkyG2db0n9hdxCvRoZg8vkq/PVM9r
	q+TIKezTltH6c24SaGLZTM/0A3S7Oy2e3G1xEWxS14nlfWBUoOmRcgtGR2nQws2s
	3FaSWvVPjua8lKb+z2tCRlj7PWg+nIuuxAOP/+gy/XjqYGBSe5KqTZrmqnDQH9VS
	mmKVlO1CDZXLehx5W+hDyIVLM1C5GL6oJ5vmDC8JQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef0apn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 14:56:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55SCHU2x028984;
	Sat, 28 Jun 2025 14:56:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u6vvbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Jun 2025 14:56:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55SEufAl037459;
	Sat, 28 Jun 2025 14:56:41 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u6vvb2-1;
	Sat, 28 Jun 2025 14:56:41 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: johndale@cisco.com, neescoba@cisco.com, benve@cisco.com,
        satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] enic: fix incorrect MTU comparison in enic_change_mtu()
Date: Sat, 28 Jun 2025 07:56:05 -0700
Message-ID: <20250628145612.476096-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506280124
X-Proofpoint-GUID: n9rfWQuKq6PvOtqVxSYrCCF8eIPH4dlE
X-Proofpoint-ORIG-GUID: n9rfWQuKq6PvOtqVxSYrCCF8eIPH4dlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDEyNSBTYWx0ZWRfX0xVi/R5QG2OL HZn1XsYTLoB2JQq35XH0GWETv7TUytrNrtZ84InKisy/juY+rUCDs5xyoSbqO32Qyn38SFErGHr LxJ35oOJXnY5oIhPAtW8uxEhDpGVplzoXft4RgX77fgpnVI3T4sKuC1nChkCPzAilAJeQGVwAFw
 fFkNE/GfJkyUBTfUT0eOFjfTomL8Cn9MG+QiyzTVV+ZgYBybq64lSTQkKvf1CBiKlmZ/+m0E5hC uIEKrGymVrU+W+0hJ8kPFjHjxd7EQE52u9ha5XaO6eREetaG/3yWFDcTBIoiEvWGr/OMhNZjfa2 CprY0VzER81YUcjPaOCyRsJbHnQe10oJdi+e5jAMKQK4ngMVm7qUaCi0AjwRfJdLopnhfXZykK+
 1yfbrT2XDb7pybPMSi8nViUCgJ38r8pcTDEvVC+eSttTQYhWNOK2Eym2ruAjsEyvegXKCXHi
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=686002ab cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=BaBcy4A32iMVqfrlXGUA:9

The comparison in enic_change_mtu() incorrectly used the current
netdev->mtu instead of the new new_mtu value when warning about
an MTU exceeding the port MTU. This could suppress valid warnings
or issue incorrect ones.

Fix the condition and log to properly reflect the new_mtu.

Fixes: ab123fe071c9 ("enic: handle mtu change for vf properly")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 773f5ad972a24..6bc8dfdb3d4be 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1864,10 +1864,10 @@ static int enic_change_mtu(struct net_device *netdev, int new_mtu)
 	if (enic_is_dynamic(enic) || enic_is_sriov_vf(enic))
 		return -EOPNOTSUPP;
 
-	if (netdev->mtu > enic->port_mtu)
+	if (new_mtu > enic->port_mtu)
 		netdev_warn(netdev,
 			    "interface MTU (%d) set higher than port MTU (%d)\n",
-			    netdev->mtu, enic->port_mtu);
+			    new_mtu, enic->port_mtu);
 
 	return _enic_change_mtu(netdev, new_mtu);
 }
-- 
2.46.0


