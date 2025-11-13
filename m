Return-Path: <netdev+bounces-238225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8CC56287
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4094E3061
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A04732F762;
	Thu, 13 Nov 2025 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WiVDDwPA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777602857EA;
	Thu, 13 Nov 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763021141; cv=none; b=pX6GuzXiNWhfXQTHzfObyN/LFriHFvPyjiaoUqJTNhSc0Cp5loUah3jH2x4F/9GYCNFhJs4EFO0nWSZx/EU520xNcDM1+1+7RgYYI15yf45opsAdlvbnZkOGKp1ocVoaPj3H56h4IsFArkm7HyZIe1u2upa96dA5vvs9kcsn3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763021141; c=relaxed/simple;
	bh=oOH3lGEWTOSYFHLg1uSa+hF+Z75jM1Nb9DBBQAkpzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvtAgPaiybMcQS9QtKwjf3mC6l+U8lWiKK4voy9aT/sa7YfR53MDbWHA0EDnbOBAWdq1DF2U3tdXUZ8t7BPZPmeGSmEGFlf3Fo+zDSHqXxB3fTb4me7v+6Qbpv6lCavJJ88NbpfXAyjk42ZJ3K8VHi+hxfenzV/EvAq0PqRI5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WiVDDwPA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gcm7019693;
	Thu, 13 Nov 2025 08:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=DpkW/1BohmzS7PepsbJSAV+8NaxBi
	xMbafLRMu8a4Pw=; b=WiVDDwPAwLzATh6ZCu1de20Mtfp0IaXiOTPt8ayWFb9I7
	O4HPfmaijFnsejO118mYYLUmmYytuqEf7DW2sRu+IiRD/DVdUZk9Yl7+CI4hfP6L
	V4PkpBHOMf2Yy8zAIshIYfpMFsFmK4mPwvA+YvMNyJIcE+XyHchOMzrHJ449a+sK
	gl86y3rM6QPNBwolnat5YYAJ6gfkGi4hiLD8ot4n27cEXuRJay44yIbswjBYErT9
	ys9Wp6n/8XiQhfjbHVs5nl4RiKMCj95XLTfYg96FrPwm+GHT7hUEcQkLXDArKDmR
	zzVsmQULfwNK2+ngvHs+aRBQbaQq5GPLvlEzQvJig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjs95xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:05:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD7NLUV009925;
	Thu, 13 Nov 2025 08:05:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacar7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:05:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AD85N4X021139;
	Thu, 13 Nov 2025 08:05:23 GMT
Received: from oracle.home (dhcp-10-154-173-166.vpn.oracle.com [10.154.173.166])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacar3f-1;
	Thu, 13 Nov 2025 08:05:22 +0000
From: gregory.herrero@oracle.com
To: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH v2 0/1] i40e: additional safety check
Date: Thu, 13 Nov 2025 09:04:58 +0100
Message-ID: <20251113080459.2290580-1-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130057
X-Proofpoint-GUID: SojHRh7z1TDAtPC6uEN-pzquSEsN4HnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfXz+v1aWYCHuM9
 mE+OHm8Y/C2ZSptxYcTA6BvC0Wj1pPIcrOIrpn63vNSWs9p0uKlxloZHXzv1SOhyyn1rDNUWW3N
 ZtNdcAzoPVxky3XLAflW+LJ5C8EsXRq4TZDMJmRKF2TKjLJuJSsBDh9FhIp65qnrMJWLTqrkeRl
 IIghFo3FDQ0wKvD0TjTChYQhE4uVhGwqe9UF+C4Q35jC64FJcMGU6PlgM2x6X4LX5mq36udCXtX
 Y1akG/NO4Geqxta6BBJs4z5MCSTFazg8FcveaDgaQ19wJ+TB2j8rBDLIWJcezyrn+KzWSGUgleB
 GFhZ+oaZEvgdcvdmSb4BqmWC6AwpV0I4Ld1dVDMAO4UpUHNJKADTaBaaZUYhpFRuRTQays50IAu
 vNUb5HZ+sgd3OVVldeVk/BPPpFcbgA==
X-Proofpoint-ORIG-GUID: SojHRh7z1TDAtPC6uEN-pzquSEsN4HnR
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69159145 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9rXuIt3xGVaoFKTACzIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22

From: Gregory Herrero <gregory.herrero@oracle.com>


On code inspection, I realized we may want to check ring_len parameter
against hardware specific values in i40e_config_vsi_tx_queue() and
i40e_config_vsi_rx_queue().

v2:
- make i40e_get_max_num_descriptors() 'pf' argument const.
- reword i40e_get_max_num_descriptors() description.
- modify commit description to explain potential behavior change.

Gregory Herrero (1):
  i40e: validate ring_len parameter against hardware-specific values.

 drivers/net/ethernet/intel/i40e/i40e.h          | 17 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 12 ------------
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  |  4 ++--
 3 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.51.0


