Return-Path: <netdev+bounces-257528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2DO6DNhWn0GgQAu9opvQ
	(envelope-from <netdev+bounces-257528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:16:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DF5FD16F
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 459D03032CFD
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7138B9AB;
	Fri,  6 Feb 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MtR/SRYA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB28324705;
	Fri,  6 Feb 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376524; cv=none; b=VVW2ji4gSuV03pY7TPFZOhnfaN786cCPBWG6fTSWd4ykNT0JacfsxdHAZKa5tKXI9WBPcbfGfculzVXlOvXR/fwFxSYYfGKdnXlL8VZOReqTZ8NMtgSugLaevN9/mLd6x6t4/I6MAZsNzpxtd8vUwPEl4fG794S4ZrbKqS/Um+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376524; c=relaxed/simple;
	bh=UMWCWwy7NB1/SJ/vUWSzzwpjZYg/hkSY4bZJOt17l7Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sfx8Ihdo02ysWmKtrp3rpXaEzqV5Jq2H5DSNIA5ga6lvT98zGNlJINAgTLtG4ThjxWJMNDLnn1WO3cs+RIFJBXYLw4+ro8DhEqZQMXRhLR8td2xkcElV/PV46FjlF6W2+gr/Zu9SF7hzGACwe6T2o0bPXpGtBIEB8YnqhD/7CUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MtR/SRYA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61600oPg3893111;
	Fri, 6 Feb 2026 03:15:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=6iF7J8Fa0xqvhGTQXIOOX5M
	BY0cMfx8T68df5LF/tgI=; b=MtR/SRYAs/U8Jhdc8LxgmrCa7q/z8y4zcA18Uhw
	Bah2PRi3aYndZnht/rh9I8dC4cOxoe0iPbnF7sEM7cOFHnxuHlSysTIOnEccwoVg
	zLdrBLxEYD3sJuRRc3tMPhz0EbW8qUx72FTniLNhnSOJmvGAw6BkoiXEQWAOg78F
	HxjXhi3iOFdL2ud5cjmg3r//xci4u6I8iTHLJmhztVeYyUmtGKbnD5D3hpPeYxAm
	DJfiVig+NYlQhz2OYRkn0Rci6BOHRDCUc+ZCjdqb3IRt0xU6ccFzEsNCffN9KhqU
	nfbpBOIzKUjqWplJY1lCql/Qv+0eKUwdnkDVGOku/7Y7FMw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c4eqf4nxn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 03:15:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Feb 2026 03:15:33 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 6 Feb 2026 03:15:33 -0800
Received: from sapphire1.sclab.marvell.com (unknown [10.111.132.245])
	by maili.marvell.com (Postfix) with ESMTP id 89C143F70BC;
	Fri,  6 Feb 2026 03:15:16 -0800 (PST)
From: Vimlesh Kumar <vimleshk@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sedara@marvell.com>, <srasheed@marvell.com>, <hgani@marvell.com>,
        "Vimlesh Kumar" <vimleshk@marvell.com>
Subject: [PATCH net v4 0/3] disable interrupts and ensure dbell updation
Date: Fri, 6 Feb 2026 11:15:05 +0000
Message-ID: <20260206111510.1045092-1-vimleshk@marvell.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: HmZKryJ_9bbbJokwzJkwSlCk3NSL-x_t
X-Authority-Analysis: v=2.4 cv=Da8aa/tW c=1 sm=1 tr=0 ts=6985cd45 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=X-Ui8SO-rprf7uT1GNgA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: HmZKryJ_9bbbJokwzJkwSlCk3NSL-x_t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA3NyBTYWx0ZWRfX2BU7zQGbEe5r
 kEZLjJJrfEg1xxH0ODEgSJm4sHHDjy9eNpLW7098M/kole3vDLx9k5Lwcq9pyFX8nWsgAydX56r
 BOJd2BYimJr1rT55AKQwENfqCU5GgTFCnICidpvi2K4BGGHlEtLMiREGfkHwDZl7Ojtq+lZ10L/
 tQOcsgeX/dzjM2I30R2YJI9ZeCnzZO/PpuPP5jPLia36RjbU5MwBu8v+UWUDgrExn1DuiTgmh1c
 5f8wIeHjD/J5V+IQ0FunZs2g0OcAnLIMr1Q2yC62WHCEEz6td9CJnpTp2lzK1Qv3zX9sOhjBAAe
 4JsZsmZ0e0ItfTYLN6B9RK2PEvYrVbh4ulBgu9zrJe9bFZr80W/9NXEnkihTogiQQNopc0M+x1B
 VkJxvIH0FQ27ZTJsuulq06x4SgKHOEC+kXV3zuh+O4Us9naL+4oswsgG2d/A6YBE9sJ9dx3t/ky
 yoGUx2V0BAeP9snjYpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_03,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257528-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[vimleshk@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:mid,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 58DF5FD16F
X-Rspamd-Action: no action

Disable per ring interrupts when netdev goes down and ensure dbell BADDR
updation for both PFs and VFs by adding wait and check for updated value.

Resending based on discussion with reviewer. 

Vimlesh Kumar (3):
  octeon_ep: disable per ring interrupts
  octeon_ep: ensure dbell BADDR updation
  octeon_ep_vf: ensure dbell BADDR updation

V4:
- Remove unnecessary brackets.
- Add a new label to handle oq setup error case properly.

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
 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  8 ++-
 .../marvell/octeon_ep_vf/octep_vf_cn9k.c      |  3 +-
 .../marvell/octeon_ep_vf/octep_vf_cnxk.c      | 39 ++++++++++-
 .../marvell/octeon_ep_vf/octep_vf_main.h      |  2 +-
 .../marvell/octeon_ep_vf/octep_vf_rx.c        |  8 ++-
 10 files changed, 126 insertions(+), 23 deletions(-)

-- 
2.47.0


