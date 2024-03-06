Return-Path: <netdev+bounces-78083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D1F87402A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588EFB237C4
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F1113E7C9;
	Wed,  6 Mar 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="r+NvCW9E"
X-Original-To: netdev@vger.kernel.org
Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082975CDE2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752309; cv=none; b=Z1CyKox7+2RGzO/iXt+a2pWHR0LwrPtcVr3krEHJSgt7qWGIzt5fNsFeVVkJ45xrR+CpIysBuLozE/2hveWI3BMhSyGavfoVs1nh7HHH9CLl9z6SjjXcBgtc5xuqoB+ComPvkTmrGAocRagRtdg0RlIEKmp0dzMwK9K5YpFFz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752309; c=relaxed/simple;
	bh=LdLZPPA44PqHoLrQkrGu/O7Yo+i/Dgm1mJ4CTeWg2uI=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=R92rQIkUsptdo0STEYaXjAl4V84OgU2+VJ10UimzIHeMhGPkaU11+yCrgx54QyayjSWT3rfvutr4DBFETOo/8NBVrYpa2cF1zQ01Mib7/XHGxEW9B+jlPl3iv5G4o1lQLC5pTo2AeoSGOCIWsZ3I65zEpoFVlx0ajnnjfXHT3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=r+NvCW9E; arc=none smtp.client-ip=17.32.222.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S9X00XJCUJ7ZH20@ma-mailsvcp-mx-lapp01.apple.com> for
 netdev@vger.kernel.org; Wed, 06 Mar 2024 10:11:40 -0800 (PST)
X-Proofpoint-GUID: ILf8_g76dkA9YAb3SEeFA5QvDswcLfqp
X-Proofpoint-ORIG-GUID: ILf8_g76dkA9YAb3SEeFA5QvDswcLfqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=645 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403060147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from : to
 : cc : subject : date : message-id : mime-version : content-transfer-encoding;
 s=20180706; bh=hG4WHnvcZfcWtSoMRwoPfO3KoVJ4gVuAR3QVaz4rBIw=;
 b=r+NvCW9EpxzsmZ/pTj+YIinenrlDDF9WAaZ4nauKbVmTZLV5A4W3sqHnk1qJQ0/2peV0
 iXm2/5HKpAtJWB7xy86yoJcWuIxO2RVwfb2752W2DeU6QabxUArwOdPeQFzggkHkO+BK
 RjARHleD4HxUCO4tBtxq5XO9cP2ucK3/5b8uBwmyhbJVlGMD1ob/RwpaROPlwVogCUiz
 tIwVCn2P2gEk1cR2vPTsquI+aIDovxX9EGwmTeXIc7oXQZ/vMrVrfCpK10sJj/6B3hCJ
 2tf5NyX34+B/TErmPOcBg9TOMRt7euqS0xW527u1b1phLVnClfJSnuyEE3WGYGoX5Via rg==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S9X003RPUJ7JJM0@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Wed, 06 Mar 2024 10:11:32 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S9X00800U423600@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 06 Mar 2024 10:11:32 -0800 (PST)
X-Va-A:
X-Va-T-CD: 1ba8c2a53241c89a4c21693cf99a7a58
X-Va-E-CD: 77d476694fd6a91bc649ac9e32834ad3
X-Va-R-CD: 7a7b5d6f1c1eae0dd0c67cd86e3723af
X-Va-ID: 452667e7-301e-4962-a0bb-a08b828a7662
X-Va-CD: 0
X-V-A:
X-V-T-CD: 1ba8c2a53241c89a4c21693cf99a7a58
X-V-E-CD: 77d476694fd6a91bc649ac9e32834ad3
X-V-R-CD: 7a7b5d6f1c1eae0dd0c67cd86e3723af
X-V-ID: c98bd895-4e4b-4708-982e-b34b4b8e62e2
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
Received: from mr41p01nt-relayp04.apple.com ([17.233.29.193])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S9X00VF4UJ7TB00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Wed,
 06 Mar 2024 10:11:32 -0800 (PST)
From: Christoph Paasch <cpaasch@apple.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Craig Taylor <cmtaylor@apple.com>
Subject: [PATCH net-next] mpls: Do not orphan the skb
Date: Wed, 06 Mar 2024 10:11:17 -0800
Message-id: <20240306181117.77419-1-cpaasch@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit

We observed that TCP-pacing was falling back to the TCP-layer pacing
instead of utilizing sch_fq for the pacing. This causes significant
CPU-usage due to the hrtimer running on a per-TCP-connection basis.

The issue is that mpls_xmit() calls skb_orphan() and thus sets
skb->sk to NULL. Which implies that many of the goodies of TCP won't
work. Pacing falls back to TCP-layer pacing. TCP Small Queues does not
work, ...

It is safe to remove this call to skb_orphan() in mpls_xmit() as there
really is not reason for it to be there. It appears that this call to
skb_orphan comes from the very initial implementation of MPLS.

Cc: Roopa Prabhu <roopa@nvidia.com>
Reported-by: Craig Taylor <cmtaylor@apple.com>
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
---
 net/mpls/mpls_iptunnel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index ef59e25dc482..8fc790f2a01b 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -55,8 +55,6 @@ static int mpls_xmit(struct sk_buff *skb)
 	out_dev = dst->dev;
 	net = dev_net(out_dev);
 
-	skb_orphan(skb);
-
 	if (!mpls_output_possible(out_dev) ||
 	    !dst->lwtstate || skb_warn_if_lro(skb))
 		goto drop;
-- 
2.39.3 (Apple Git-146)


