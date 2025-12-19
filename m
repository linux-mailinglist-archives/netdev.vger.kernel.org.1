Return-Path: <netdev+bounces-245475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C916CCEC82
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC1E300DC99
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B222F74D;
	Fri, 19 Dec 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g1ZstS0V"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378622D7B5;
	Fri, 19 Dec 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129404; cv=none; b=J8UQsQ35mqzfDGPu5Nt6Cdf8GMkuOgkpwyyaCHlih1UTKKoFnEaNazARmVobuAgzfmkxnTHGNXac460hhLFZ+14ObxJf0wM9IOGf97Ph5NmcK/g8bep370I2BVDtxRwOwmcmLwF4l9IeWR0q6+lAlpf4+/qSM7PW8xsrMyE00+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129404; c=relaxed/simple;
	bh=PK1HKQDjoWvu5KMzYygoqxwAFi+0ASMeR5/D+dhqMYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RJT+/0PkMNFCRclePqdMTC2AbedMYme9r6Z3cijAvNttdAb3IWeBJUqbQJ8Ze5TeNrG7EsoHWnYIJg3za9cPNsdPL1KOcn48KMU6aQbJEMGxxjNS2k6lFktwdKxHGRKZdkzj/FxlwhjPuxPpsSggeGSqxFDPx5QoTfDP6vCyjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g1ZstS0V; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjOhH679874;
	Thu, 18 Dec 2025 23:29:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Kqcl+4vFjyYPNxiqJMHe+Jp
	QeEQeb1TEd9MOl5S+gGU=; b=g1ZstS0VYleFJgyYipiW3GK3TVEimrwDvK3IS6q
	Url+RG/tB31cVzVpSlnsClHLCpXeucVdGjS4G5bauhd9IbTxYxJ+cI512OQz6xpB
	R9lsLan/YvWYavUMcnBToNBxr6FsxuK3SV5xGpFUKWyKB27LaOjR0GbmOEwgJF52
	QR7c4X2NRBZRjbUFFxUYyhW7afYaFUubfRkCTbvo4Q39Q9DPccwyxI6gvrBxkQ9H
	4z1jiB9NFxRCOuadJg9MiZ18lJ6HrRoK/gmBYq05c+zZF10id8EjK/5v2oKeE8QC
	mC7PcoLGQm7oE3ep6CykAkKlmuSpqrPmyCgL1cxmSq9Rlcg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r2416ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 23:29:59 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Dec 2025 23:30:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Dec 2025 23:30:12 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 72BE03F7093;
	Thu, 18 Dec 2025 23:29:58 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v1 0/2] avoid compiler and IQ/OQ reordering
Date: Fri, 19 Dec 2025 07:29:51 +0000
Message-ID: <20251219072955.3048238-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA2MSBTYWx0ZWRfX8MPO5X6BtKwp
 L1YmxBI22/OsVmaa5uAxhkmmavFGG/at/9dNutS4MxcTAcgzPZViG+IKKybL9s/tRtI+2sj4p8m
 f8YzOhkdAOwvKpEkBgGcEtOpy3qKddNiMiNF0teTcbnU46nb6HusxawUnfUlBpdAIbAGNs8dKry
 RYY/7adGyQW2kBv00RvqAqV4abnFSU+8ZK5yq/Qs4CODzTg00Heh9dxNyYrXaWQLqA4CFU6C2F0
 HSnD9Y0eNMlk+vuQuE9XCFBCYHJOvgNSVDAX6znkblzyEuCJTulDJgLvslRCF04vfl5gqUjQ+iL
 f2UBfZ/oaxvyJ2zeSWjGJ4VaER9nWIRstb/Z/90qsRUu1dV2a25BYpelxeDFc8vg1OyPdlSjQ5G
 7hDeW7qju9u+taiokvtBlfHDfC0qjUQPFUHosEdlrvfb6dUDpRejsmOYYSpG5jTAcpIuqjXo8av
 dU4z4cBChZqDS42hNMQ==
X-Proofpoint-ORIG-GUID: bELGxX47DonNvfD_zwSvE2gEuio1B26b
X-Authority-Analysis: v=2.4 cv=T4uBjvKQ c=1 sm=1 tr=0 ts=6944fef7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=LcfSQsnrkOK16RxlBc8A:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: bELGxX47DonNvfD_zwSvE2gEuio1B26b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_02,2025-12-17_02,2025-10-01_01

Utilize READ_ONCE and WRITE_ONCE APIs to prevent compiler
optimization and reordering. Ensure IO queue OUT/IN_CNT
registers are flushed. Relocate IQ/OQ IN/OUT_CNTS updates
to occur before NAPI completion, and replace napi_complete
with napi_complete_done.

Vimlesh Kumar (2):
  octeon_ep: avoid compiler and IQ/OQ reordering
  octeon_ep_vf: avoid compiler and IQ/OQ reordering

 .../ethernet/marvell/octeon_ep/octep_main.c   | 40 +++++++++++++------
 .../net/ethernet/marvell/octeon_ep/octep_rx.c | 27 +++++++++----
 .../marvell/octeon_ep_vf/octep_vf_main.c      | 38 +++++++++++++-----
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 28 +++++++++----
 4 files changed, 95 insertions(+), 38 deletions(-)

-- 
2.47.0


