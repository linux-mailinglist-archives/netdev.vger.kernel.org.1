Return-Path: <netdev+bounces-300656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wQCXIR8HNWq7mAYAu9opvQ
	(envelope-from <netdev+bounces-300656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B96A4DBE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:08:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=QdmgG595;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300656-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300656-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8101B302FB51
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027AC35FF5B;
	Fri, 19 Jun 2026 09:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965B35E1AF;
	Fri, 19 Jun 2026 09:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860085; cv=none; b=Mwsh43uHoDLDgPR+0cFX9S0abEdk9jqHJfTJQZEp+j8ZQ15xcdIKEGTVJTqLQl/Ja/Zhdarp/xoz54FaGAGTjeQ82MFMBlogYw1wBwztx06Weq9i19QAaoe26G9hQs5xnGh35OxO1n8rhr+cP58wJ7ICtMtgrwjbyGDQWcl+B1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860085; c=relaxed/simple;
	bh=GT4XJimCf96zzm59YHnU0fQA4/qjtRjy8slru0yHrJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dX2EmjYRiVhiqg5Hi4RzNpgh5L/wN0J7my2/jK3zb2wFgo6kQNdnF9UFtLT1veyb6HpG6ffPFi8PxmirS1r3qIiMjZxpfTVyoqI0L01P0MQFn7qFfJmKuuYKNB18m/DaHHUIMt5LKN6uPYgIcgM7AE9263hkV5pHAFdAG42gGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QdmgG595; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7R0e31746649;
	Fri, 19 Jun 2026 02:07:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/rv4IlLrEjoMJS2/DCc9bnY
	iBRVBLFZmya3f16wLs1o=; b=QdmgG595d3ZzpFsy9fI4NcjEPdev/GAfgqwnAgQ
	gTtP+8+S6elvYJ8S6mlZGxYetQqZM1NIpMRL2I5dfkhjxFmWeku0thSzaBa2V2vX
	PkXXTVWDet80NcZXsEU7P3mBrgIX5m6OmRYfN0Fjr6pvdf9jElHeoRU1u9ygOpzD
	Jkq3DtdVYOM+7+jEzKUc3YNJuonAIQ8gq4e51iyg+Ue5RiJb0dP0QTDUJHGyuc/B
	cMUQFOK3c0Z0E4X20OHTk5v7uU9/I2iGuHHjU9kYY/uPKzvkquNx9hXVYhx3zsD3
	NRvIDj6zLPqvrmFhJmtnJrDDaB+UcN+4z8apR/qI6HOTs4w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ev59ddehd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 02:07:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Jun 2026 02:07:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Jun 2026 02:07:54 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 0F7B45B692E;
	Fri, 19 Jun 2026 02:07:49 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <Sunil.Goutham@marvell.com>,
        <naveenm@marvell.com>, <hkalra@marvell.com>,
        Nitin Shetty J <nshettyj@marvell.com>
Subject: [PATCH net 0/2] octeontx2-af: Bug fixes for KPU profile and VF RX mode
Date: Fri, 19 Jun 2026 14:37:44 +0530
Message-ID: <20260619090746.1829416-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3pumuXnuR50AUuuzPp0gLbuho3Zkyn5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfXzuFxii8zQyN+
 4LyUR8ng/5HWOojg7eMpbIA5vMu1SFmuNOEIH7OzlaobCoSzCXgxrdMadBVLHk8HZNIS+ug2D+f
 KRK39DBlQjvR0EkdHJWQ8OCCc9EKYOyW9DacWo5eUaMm8XWtVBRbDysmANsUlaGrFEUIHpBquA2
 aMINWFgeuTxNFkYWhCe2M3rCiSO57Stc0jrtETnid4av4+326QWMFRpoFr8+14rai3IiZVLRUn8
 dKJbN7VoAuPZm3pYvndsRx8MvmxHRao9YyOt6y9Rc6Ofu9Cyp3jV+qf4Al0kZsQoX+I5pbUlt8+
 wrHnEK+tFIqCB/ylwH3SkqHNhnqr/Poz3EkQEoG+d+nRfquskAJxr02H3rZGfmF+DlTn+FiucZC
 Im3hJywJh5qORYIaxrg7ExZY4F7IsM4VRBAcDvUYT6uClhYwo8A65sBfdu60QFaNeulezrENU6v
 pfoQu5fu8EoBmcDMx0w==
X-Authority-Analysis: v=2.4 cv=c4Cbhx9l c=1 sm=1 tr=0 ts=6a3506eb cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=l6dbmrFur8glAP0BWfsA:9
 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xcR01sG6PTns2CkfTbVt715lBDKWSGli
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4NCBTYWx0ZWRfXzhq0SUemiQp1
 mlTqSmFOoF82PhnLLCKe1EwWITBEktYQAsasUCAQ+FGAT3EuGm4bNqg3C9sgOAS5eOKvreytQj3
 JMsfhZMtQyvV9btLJM3itHRr2XowySo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300656-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Sunil.Goutham@marvell.com,m:naveenm@marvell.com,m:hkalra@marvell.com,m:nshettyj@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nshettyj@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D26B96A4DBE

From: Nitin Shetty J <nshettyj@marvell.com>

This patch series contains two standalone bug fixes for the Octeontx2 
administrative function (AF) driver targeting the net branch.

The first patch addresses a spurious firmware loading warning by 
switching to the non-warning variant of the firmware request API when 
falling back to alternative loading methods.

The second patch resolves an issue where a VF changing its interface 
state could inadvertently delete the RX promiscuous and all-multicast 
MCAM rules belonging to the host PF.

Harman Kalra (2):
  octeontx2-af: fix VF bringup affecting PF promiscuous state
  octeontx2-af: suppress kpu profile loading warning

 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


