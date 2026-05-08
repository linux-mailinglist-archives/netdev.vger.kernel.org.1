Return-Path: <netdev+bounces-285959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGqGM9Iw/mkNnwAAu9opvQ
	(envelope-from <netdev+bounces-285959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:52:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3004FAC6A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 20:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCC16300729C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78553D1CA8;
	Fri,  8 May 2026 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKY0sp2L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F73750CB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266317; cv=none; b=btOMl2uEjZqpb73VkuOwEMOwDt6WqQfP1n4zEbFcBfS2gLh/odcmmF/DGLKKL1uwPKh0YIdbBxYgubTUAxc484UuQmzYGpKXEIgJEmOTt32s8fwZ+Je8ldYpiRa8lsliV4k21Qcczh91lbCvY/I6Sale7EK/PUCoVdAGnJ6QoDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266317; c=relaxed/simple;
	bh=exE2CDtnqf6G+NqwIB4VMa29pHf9bnB+n/htEfpYH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCpglg5aCEI1n4NoyBEQWWkPQ6vkhhyoPuwDA5OfM6DTmOUXevK1AsN8Qm88tYCy2scB8jxEH2J6OEjn6WgRNgGyPnD7E5Q+wcM0aW04AnNyXa/wKzobmIAoSTXxLzt8c+VT4NfqEF9Cm+1VLw5LkZ9j9AUERBgnFQOb/HU078o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UKY0sp2L; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648FcotB1859383;
	Fri, 8 May 2026 18:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=FgCgVXyKFsKz2Q4i/AaoeOgRoIURZ
	dweYmSmTtUvZ1Y=; b=UKY0sp2LN2rn0/S7mkMSELbAdk/eAktF+CQps+PWbx8Kj
	3vnFO9jN843Tq/z4DL18tKJkmzbbjP1EtoUAMUmux79IKkJkNb0PCixMZ9GVP+CV
	XzFN7QqK9JXLYx0OCZmvNDFaL+MLKLgjHif1IzL4dq4+6eNYLtaR5kmxmHj3kVxd
	xSyqEdaphxa1nmn2gDmPiqstagZ61H9NEhdLF0NNDEswsM2N/r4lbWYPF2em2Kqi
	bUdNF8P5Eulx+RIohfjGjL5Hrz3nANxOJwyRFl8sWLFu7/HqAoLxo3NV9JuFh0DP
	42aUWrlm9nln7w/D5f45OTPGKXxRLFA3lly1/o81A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9dh3awk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 18:51:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 648IpMNf025260;
	Fri, 8 May 2026 18:51:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx5825hdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 18:51:30 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 648IpTkV026972;
	Fri, 8 May 2026 18:51:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4dx5825hc3-1;
	Fri, 08 May 2026 18:51:29 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
        milena.olech@intel.com, willemb@google.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] idpf: fix mailbox capability for set device clock time
Date: Fri,  8 May 2026 11:46:17 -0700
Message-ID: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080188
X-Proofpoint-GUID: yQjVvz1kjyO628iO2juuJbSNTWxbUDno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4OCBTYWx0ZWRfXwg14xMiHWRaV
 x+9ZRwO9twGE01Yqzp/oam5CoNm/dN1obE9jrYKAi0AHaOKdr3bFrd2pZs7U6bybiw+LVj6gVPh
 WAybDHWWW5zUI7Zi2EfK6IVW2r9KZYIO+aGe7KpYJELwnDjg0OJV2PYNhNfje7N2g+MjWUCgQGv
 rj9DQ4rZBd6NHn1KKhipnEmVENqkXl2R78MN+x1j6cUzq2b9sZ1E/rd+jHRXCqawkTZK12IUZrm
 ZJp6JNUE3BQOByFMaQxjN933GLF9PI23Q8SJo51kSzKacN5ckedEvZ62KcKiFSjrKZ+2Waj7UUm
 MIVdzzdR3m3qckv3YOk/p3oQ/I727c8hJW2m1knYBd5VPpzPYZYJJOv5mz6lqy+k2hGk/uWcdgD
 EegQBMD6Z2SlxUGeZueTzZP3iv1zqvbRv9ZpTBy6yGawdXJj4XaYjPfnLlzZQU4L4IQZ8HC9SEm
 f0kQBn6651mk6jH7CpRcdpjOVM+siPaDC3UfnSvA=
X-Proofpoint-ORIG-GUID: yQjVvz1kjyO628iO2juuJbSNTWxbUDno
X-Authority-Analysis: v=2.4 cv=HZckiCE8 c=1 sm=1 tr=0 ts=69fe30b3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=havJbWvXqL2eL2CLIZYA:9
 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf awl=host:13839
X-Rspamd-Queue-Id: CE3004FAC6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285959-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The current code incorrectly uses VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
for both direct and mailbox capabilities, causing mailbox-only support
to be ignored and potentially reporting IDPF_PTP_NONE.

Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
I did not hit a runtime failure directly, but this logic is inconsistent
with the capability definitions.
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index eec91c4f0a75..3295e2f1db9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -51,7 +51,7 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 
 	/* Set the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
-	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
 	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
-- 
2.50.1


