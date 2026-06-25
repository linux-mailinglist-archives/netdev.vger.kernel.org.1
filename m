Return-Path: <netdev+bounces-301862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RN3BEey7PGqArAgAu9opvQ
	(envelope-from <netdev+bounces-301862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E3D6C2C8E
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=MpmiA6JZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301862-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301862-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8CD3018740
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7042DCF57;
	Thu, 25 Jun 2026 05:26:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09702C15AC;
	Thu, 25 Jun 2026 05:25:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365161; cv=none; b=GZNBgnUiCuhGls+iYduGl5abwyOVZezSjNcd/XkRMXz4ngtIuO6falr/G/kRJiOJDRLyOAmSbWX08OYY2ML0RPE5Ra8hXGjvLhalcOlS1RYiSd4agOwPXwITA0dC8PxcjZHWeu7jQtfC1ax54PV07rGPmxUv3HV0Z2DaheCmtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365161; c=relaxed/simple;
	bh=NvIL4IMa+G9g/EXudvS/VwgBjoWxZ2qJZ2+uKT1nQTs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gip63AZ8lCJks0BqjtP6X06biDCzvDLjQwc98vn1jqa282ML799LKUZgsJfU1rd3XqJjefBQ9KIY+boZQJnZNuxmKcIbiXHStjIcZJgcd0bpogIiazo0l9K3Ehk5l1AlVWVpXqqmv1JhwJk9s2D978DR/Pi8Y8ZH2S2vj60c6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MpmiA6JZ; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eMpA4155074;
	Wed, 24 Jun 2026 22:25:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
	ZmR54zijcjBucAA0EL2V8gzRYT4uYEWtgosI695QOs=; b=MpmiA6JZ/bsEu3YK8
	yOrrt1KcugB2EICG3OJHp70nYuSHx0R9GJMf1XiCDMTWWMikZhSmE9odATKS0WrF
	ZDsJi+W+rD7OloS1u5RVPeR63mkyz8Hs/2LrIMgk6JdKti9GvC9F0/W9Oqk1o/5y
	SfjeoAow5GgeDLj+IgMFFMD4CMacwvNCjt3dgIXYlGCNr9SOfOwTf1DV4/9ajS7h
	baZosAHyYGlfu1bYSxPzko2qBt/xpPOpol8HxhMy99WCVDwDHwByoeqxm0dcVQgZ
	Tpg0oywv+26yRYL2yu5TVs2k7oUEt/667ZMy8YJNQqCbQJ/iqNhne2VQyvEZO+8+
	VQUBA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u84yh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 22:25:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 24 Jun 2026 22:25:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 24 Jun 2026 22:25:49 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 1822E3F706D;
	Wed, 24 Jun 2026 22:25:46 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:55:46 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <gakula@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [PATCH net v2] octeontx2-af: Block VFs from clobbering special
 CGX PKIND state
Message-ID: <ajy72q43tVFSeLE8@rkannoth-OptiPlex-7090>
References: <20260625044621.2841831-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625044621.2841831-1-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0NCBTYWx0ZWRfX9ZNWzgfMhWEo
 fDzuoOz2/5Pq3ejvFQe3p4MIBQUOkzDbkePaJFFNODU7pi6LQ09sfFBd03jZZJlFIv0X+FfiXNu
 1HKl2YEPEqn0+yX08cOvpzgkKkj8EWSGDEp1SotYHVtorjA9t0xmkLT7TI11zZStUAcZC+CHH65
 k2v0zs//4HaCQLzkOn0XlandQStQqhj5JSnc878wwLc8QbfVw0ekLoIh8xO0JIOXzeY+K/6cNtQ
 mrjiZzyOSRwWm7JuafRfmbKe9wM4qveZqsV8VZqLoWn8vqgdIlsyXJUipoi/CgZRUmPLg+9BssJ
 HiF7f4AAaefFG5/wwKHAVDDLx/kU5Qfv/8lyNbuv/X/1fgSBY5bHk6UlSKk4r7M51nlvXxlD9BO
 nfvPw8KFrkTK7kHW0hPTjD0hO6Fp3A/s9eVA39nxTbtDmIIry7CeW5atsrW0JiQQIZ9VmKk9PX4
 GD8DuLy06FY6Z7adyJw==
X-Authority-Analysis: v=2.4 cv=D9N37PRj c=1 sm=1 tr=0 ts=6a3cbbdf cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=yjNKIy0og1E6pNJisW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: 8rylDWr-Kb_J-9W_DS06bmsFXOO1qorp
X-Proofpoint-ORIG-GUID: 8rylDWr-Kb_J-9W_DS06bmsFXOO1qorp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0NCBTYWx0ZWRfXzBT2eF5f+MHo
 VWS9wbc5GYgKdVHco40gGF+D6I/3WTZVXN3B5O2z0p9TRq6mrj1bEKvw4H4ks2wf3yGJdy8pZAv
 e1ZbCJcje7hQJT36OC/MKW2J/EAFTc0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,rkannoth-OptiPlex-7090:mid];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:gakula@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hkelam@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6E3D6C2C8E

On 2026-06-25 at 10:16:21, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
>
> PF and VF NIX LFs that share a CGX LMAC reuse the same hardware PKIND
> programming. When HiGig2 or EDSA parsing is enabled, a VF NIX LF alloc must
> not reset the LMAC RX PKIND or default TX parse config over the PF setup.
>
> Add cgx_get_pkind() and rvu_cgx_is_pkind_config_permitted() so VFs skip
> cgx_set_pkind(), rvu_npc_set_pkind(), and NIX_AF_LFX_TX_PARSE_CFG updates
> when the LMAC is using NPC_RX_HIGIG_PKIND or NPC_RX_EDSA_PKIND.
>
> Fixes: 94d942c5fb97 ("octeontx2-af: Config pkind for CGX mapped PFs")
> Cc: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
>
> ---
> v1 -> v2: Addressed simon comments
> 	https://lore.kernel.org/netdev/20260619041002.1773822-1-rkannoth@marvell.com/
> ---

Apologies for the inconvenience — it appears I submitted an incorrect patch.
I will abandon it and post a revised one later. Thanks.

pw-bot: changes-requested

