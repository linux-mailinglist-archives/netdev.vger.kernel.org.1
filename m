Return-Path: <netdev+bounces-255161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLY0Hiq9fGlVOgIAu9opvQ
	(envelope-from <netdev+bounces-255161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:16:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143DBB833
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F013002F69
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5F2F3C1D;
	Fri, 30 Jan 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LnDCGwHa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A121ABB9;
	Fri, 30 Jan 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782565; cv=none; b=DA5bIphGcs+VMRqSz/1KQhEyrOshdLicDHMAzJRZEXzNfayL/1cJ7IJLIshRKP+bdLDdu80/0nbnOss3bRgXJthiSm/NVjsHahsoTh5Wda6M3q7XGYiJJ1e2AozzNjzssJvLpEakwACFpbc9v1QVvZrUga493lnW/Qs1MMRyPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782565; c=relaxed/simple;
	bh=zYvh5SJx0J+ykZgKVolO/Sh+059x6w9OwLwRZeMSvx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwfbetSe5SlGoIcHa2PzV9/T0cSIqXaZfTbuLeKu5a1pyj9EVIYRxbAfXcJcWnWErVmbrA4K0dS8Ag+FAYp5iOnjFQDjgjgTlmAa5bxewR5vyb3TkuwBpNrlOjl5YAFiKeEPFd3pWROwqw0khIsoqqueOKordLbdw03cmmuZ+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LnDCGwHa; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UB10bv1373632;
	Fri, 30 Jan 2026 06:15:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=AxMMk9qY8+FWUBvq+R+5srw
	+wbOnbxsqsowg9PZIxrc=; b=LnDCGwHab/VcfYoDbmx+rnXu9BBeB3MVsH2XhWV
	lKeCSykniRbETH93kgnFJh0uyxmltvUx63SbnHiHxMSb0kpWwjlja3/aWBvr1kjt
	LF+aF0cOZszm/PLqIOJ7N0ePbSbOVZTNZZZNZgpbz8KIDBbfuHJYsp3XDyjMSYBJ
	Mb14N1svJwUufKpw6/aI7F34eCm1sVmo/CLFav1miNS9r4gyR3OHAKHagPiMrgdB
	eLvMRyDI53PXtuCY6iBWaEdXwXCkNaOWx9i+MTQg5VCRzwkmPDhQrA32n10vLQs9
	H7dL65ot1jSNA/jeOrffGFmM+RgAQHqx+apyQ5MQH6JBi6w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c0ucx8aq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:15:56 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 Jan 2026 06:16:10 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 30 Jan 2026 06:16:10 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 2AD343F7120;
	Fri, 30 Jan 2026 06:15:55 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH RESEND net v3 0/3] disable interrupts and ensure dbell updation
Date: Fri, 30 Jan 2026 14:15:44 +0000
Message-ID: <20260130141549.827020-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 02AGKzWmb6ap8eoY_tToRqnCnozYDpHp
X-Authority-Analysis: v=2.4 cv=T92BjvKQ c=1 sm=1 tr=0 ts=697cbd1c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=6bxer7aP3YgKHE6BY9wA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 02AGKzWmb6ap8eoY_tToRqnCnozYDpHp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDExNiBTYWx0ZWRfX4xaVmnOiuDeg
 BcPG2H2lgpiVXQd+pd2rwXCPOaJ/k6qeppcDKhJBrsYgPFyM5HfzbM3ojykTwEcF3BaBm7tp/67
 fOn3/NeKBpVaQkDWhYqGXiJE6AknoSbOImr2iOezMTohF4fRpR6BNRfw7nUd1KvfAdlsTJcWi5Y
 /oBPKPiv/rZVvdAJl+Hq5XBzBo+Wf2EVltkZKybYnF9BA2CrI4GDaotULTi3hwdFaYrNYvnAgX9
 0aUlHACRp0qzi9N+Gicg1XYnO2dki9ecgqdWpq4Ci0fAS7vA9Iiq3P6CAoGjABs6nRSmzG8vN+6
 reIBVuVpMYxU+Jl78q8TevFf+8Yb8AVGnWB33Cb0xRRvCVCXSSI3kJu9o1inKJ4P5U8YNjAc1As
 EpvB5CMuGBIM5KqoI+J80Y950rMkVKuoITazntcafZklghsIczU5TnXHMdknBOyxGVGUGpd6AFA
 RGFmdRje+kjy+BIVuqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255161-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 3143DBB833
X-Rspamd-Action: no action

Disable per ring interrupts when netdev goes down and ensure dbell BADDR
updation for both PFs and VFs by adding wait and check for updated value.

Resending based on discussion with reviewer. 

Vimlesh Kumar (3):
  octeon_ep: disable per ring interrupts
  octeon_ep: ensure dbell BADDR updation
  octeon_ep_vf: ensure dbell BADDR updation

V3:
- previous discussion: https://lore.kernel.org/all/20260107131857.3434352-1-vimleshk@marvell.com/
- Use reverse christmas tree order variable declaration.
- Return error if timeout happens during setup oq.
 
V2: https://lore.kernel.org/all/20251219100751.3063135-1-vimleshk@marvell.com/
 
V1: https://lore.kernel.org/all/20251212122304.2562229-1-vimleshk@marvell.com/

 .../marvell/octeon_ep/octep_cn9k_pf.c         | 21 ++++--
 .../marvell/octeon_ep/octep_cnxk_pf.c         | 64 +++++++++++++++----
 .../ethernet/marvell/octeon_ep/octep_main.h   |  2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  1 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h    |  1 +
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  4 +-
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 39 ++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  4 +-
 10 files changed, 118 insertions(+), 23 deletions(-)

-- 
2.47.0


