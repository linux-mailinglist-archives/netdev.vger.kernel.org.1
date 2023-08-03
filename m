Return-Path: <netdev+bounces-24216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4F76F3F6
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D15528235C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282A263BD;
	Thu,  3 Aug 2023 20:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BE263B2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:20:16 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B0420F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:20:15 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373KB6bd010167
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=PLRASjmceMGK0zRbNtV9kmaVXwhQxJM0rzYSEi5nLa0=;
 b=fmbW34U0h5BDtxTvHdNakH9AZTyy9lE+xL/PZ0EBE5xR43aLqGDyhoBRQVlxlybonS1Z
 RXpVoi15fNsNyUTN3AnpDB6TSF4fxcGBFwjwKtinTR6Wk1EafAQMGvsSuahPWaS6gCFE
 Km1IkISdzePLhWT53e8YC9I81gm33BPIHROOc0Dxjb5YFoheeJhm9KAJuDVeW7fqotBR
 hiebTOFmZ18HbvEYMqU/4KeCEjVgvBQTvGjNV7Yppk1sQBMEIivdd76LdwBGSQuKQvDJ
 bepolzNMSdvyjgUP1/CHrzGDqAQpPEIXXjhJamFlgnqMHAtn2Ca2WkK+oQATa0HFG0An LA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8k23gmkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373KFvlC018903
	for <netdev@vger.kernel.org>; Thu, 3 Aug 2023 20:20:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5ekm0d25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 20:20:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373KKBZD3277400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Aug 2023 20:20:11 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8572658051;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E4605805E;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
Received: from li-8d37cfcc-31b9-11b2-a85c-83226d7135c9.austin.ibm.com (unknown [9.24.4.46])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Aug 2023 20:20:11 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: haren@linux.ibm.com, ricklind@us.ibm.com, danymadden@us.ibm.com,
        tlfalcon@linux.ibm.com, bjking1@linux.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 1/5] ibmvnic: Enforce stronger sanity checks on login response
Date: Thu,  3 Aug 2023 15:20:06 -0500
Message-Id: <20230803202010.37149-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z68cHGX8lwCI1bPEGh25AcV2jydWZbPE
X-Proofpoint-ORIG-GUID: Z68cHGX8lwCI1bPEGh25AcV2jydWZbPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ensure that all offsets in a login response buffer are within the size
of the allocated response buffer. Any offsets or lengths that surpass
the allocation are likely the result of an incomplete response buffer.
In these cases, a full reset is necessary.

When attempting to login, the ibmvnic device will allocate a response
buffer and pass a reference to the VIOS. The VIOS will then send the
ibmvnic device a LOGIN_RSP CRQ to signal that the buffer has been filled
with data. If the ibmvnic device does not get a response in 20 seconds,
the old buffer is freed and a new login request is sent. With 2
outstanding requests, any LOGIN_RSP CRQ's could be for the older
login request. If this is the case then the login response buffer (which
is for the newer login request) could be incomplete and contain invalid
data. Therefore, we must enforce strict sanity checks on the response
buffer values.

Testing has shown that the `off_rxadd_buff_size` value is filled in last
by the VIOS and will be the smoking gun for these circumstances.

Until VIOS can implement a mechanism for tracking outstanding response
buffers and a method for mapping a LOGIN_RSP CRQ to a particular login
response buffer, the best ibmvnic can do in this situation is perform a
full reset.

Fixes: dff515a3e71d ("ibmvnic: Harden device login requests")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---

Hello!
This patchset is all relevant to recent bugs which came up regarding
the ibmvnic login process. Specifically, when this process times out.

ibmvnic devices are virtual devices which need to "login" to a physical
NIC at the end of its initialization process. This invloves sending a
command to the VIOS (virtual input output server, essentially the server
that this client is logging into) requesting it to fill out a DMA mapped
repsonse buffer. Once done, the VIOS sends a response informing the
client that the buffer has been filled with data.

If the VIOS does not send a response in 20 seconds then the client tries
again. If this happens then several bugs can occur. This is usually due
to the fact that there are more than one outstanding requests and no
mechanism for mapping a response CRQ to a given response buffer. Until
that mechanism is created, this patchset aims to harden this timeout
recovery process so that the device does not get stuck in an inopperable
state.

 drivers/net/ethernet/ibm/ibmvnic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 763d613adbcc..996f8037c266 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5397,6 +5397,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	int num_rx_pools;
 	u64 *size_array;
 	int i;
+	u32 rsp_len;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
 	 * because only ibmvnic_tasklet tests/clears this.
@@ -5447,6 +5448,23 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
 		return -EIO;
 	}
+
+	rsp_len = be32_to_cpu(login_rsp->len);
+	if (be32_to_cpu(login->login_rsp_len) < rsp_len ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_txsubm_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_subcrqs) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_rxadd_buff_size) ||
+	    rsp_len <= be32_to_cpu(login_rsp->off_supp_tx_desc)) {
+		/* This can happen if a login request times out and there are
+		 * 2 outstanding login requests sent, the LOGIN_RSP crq
+		 * could have been for the older login request. So we are
+		 * parsing the newer response buffer which may be incomplete
+		 */
+		dev_err(dev, "FATAL: Login rsp offsets/lengths invalid\n");
+		ibmvnic_reset(adapter, VNIC_RESET_FATAL);
+		return -EIO;
+	}
+
 	size_array = (u64 *)((u8 *)(adapter->login_rsp_buf) +
 		be32_to_cpu(adapter->login_rsp_buf->off_rxadd_buff_size));
 	/* variable buffer sizes are not supported, so just read the
-- 
2.39.3


