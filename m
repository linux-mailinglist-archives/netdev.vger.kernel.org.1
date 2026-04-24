Return-Path: <netdev+bounces-280962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOGtA0wo62mPJQAAu9opvQ
	(envelope-from <netdev+bounces-280962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:22:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477F45B5FF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 527533004C68
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C631D757;
	Fri, 24 Apr 2026 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KOu3+anh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF621CC5A;
	Fri, 24 Apr 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018917; cv=none; b=U3Jb6PQUHDWTiHstpFZ0uZEcEtqqHHlzjkbgyzmht4O7I2BeK+fjoHCbtIBWEZrfRf/HxFZvO95fwtLyam9tcHoIkg8Nlq7cViY+C2gfR6pASRnsqylrlZanmBg6jSBZxwEjWRArPaZkiD4zWVi5V1NEla5j48r2tMm4qkQeBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018917; c=relaxed/simple;
	bh=ar+ol1cdwoqSAZuu9nObOMf477NTW5tzAmCEP6s1FyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewg4hxfVfQFrtNM64nklCgoVMHx7Ua8x4OsftEq8i09XdJRdyMGoQHimFoflTjuHUkAI4Nv9mCWTf5NyAaJpynsVz+ssAJZJbazd8nvN2upe8g5pTsAA5cgmpkvQcmq7Ttp5pjnESn7haOCqnVjNHyX0YNY83opYxxVd7u2K+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KOu3+anh; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O771Uf1922659;
	Fri, 24 Apr 2026 01:21:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=EPP6dnHw3cesM9mwNFVuTtELl
	uhSBl47lf6F59cUzzE=; b=KOu3+anhzZfcdUzKE3VK6feX38cEkvBh8aWWO1qU5
	7Aj3AtwnNrk5vJ3Qe5VFMCnB8N1wW4cyK+M/AZoKiQQ7m7Pm4PaVNbW73byuKrpu
	z1xRy9Nsb0a7yUV2obXbNPFEOSdzHRIMVlgsyeEw5efr02eHlUy8q8/I5mjiCj+g
	VKZBgBOmZat8rZlaT3nZ+fVtfxtWypFa4PJxFQMX0jqsnXvuVZokXdu1/giaZNVB
	GHaKTNC2buesQzkLWFT6r/tff0pXZUx42j02JHTtGTToNW3HvkUZ7Y0ILXG6gYvq
	ESn+OZR6cxGaS4E+SvzGYPuApoDF2JXPgDZHjoEzKE0XA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dqc06ur0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 01:21:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Apr 2026 01:21:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Apr 2026 01:21:44 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 056EE3F7044;
	Fri, 24 Apr 2026 01:21:40 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:51:39 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        Suman Ghosh
	<sumang@marvell.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 net 01/11] octeontx2-af: npc: cn20k: Propagate MCAM
 key-type errors on cn20k
Message-ID: <aesoE4yMwK0JrSQx@rkannoth-OptiPlex-7090>
References: <20260423104317.2707923-1-rkannoth@marvell.com>
 <20260423104317.2707923-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260423104317.2707923-2-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA3NiBTYWx0ZWRfX+F67tiAansrj
 juiDrQGG9MApw/GmPtzPmPyTJqJUn58kOMu0SHxO6h4jKejTBp2baNk2kMyiKXAk8kA8ePiym1i
 SymqzYhyCJKiK3EAyPW13+PtKttDyERmcGUzl+b3wdq4VmiS3mjhlZfMif8MQru45ZNBRzOJe7A
 vuUwlCp5RgpBdpKDrlkK/xON3kWFfUQ2PyqEPZcwgj5nh0WisVznJH2yr+5R8TsTIVsDEL3KV6E
 z8qIByxuVitVkFuxDaCEfvkjXNGaIMKvFh5kULZ7ExY7GtxSKKTlS+gRucwBVRPR9Bdv2uQ4qjy
 ePR1bRPs2djm0tAjY6/y0QaiCut/eTqAKVejnZa1vcaySZVJdlfhmETRnq90cjk5no2Fuq/6h1R
 MOdUJTBXpini5iudWYoiw9mylIpsJ7NTumQVOiSybJmC8JLyjDLKZJdMMQ/9n2jq7/qf9n0sTUa
 wjWWq1k/EBJGKSpLkDQ==
X-Proofpoint-GUID: gTU--qBiWriy5asarLSWMAJo58GOPguO
X-Authority-Analysis: v=2.4 cv=N84Z0W9B c=1 sm=1 tr=0 ts=69eb2819 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=9R54UkLUAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8 a=cEb6nvIuI1qnDul7i20A:9
 a=CjuIK1q_8ugA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: gTU--qBiWriy5asarLSWMAJo58GOPguO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Rspamd-Queue-Id: 3477F45B5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280962-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-23 at 16:13:07, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_mcam_idx_2_key_type() can fail; callers used to ignore it and still
> used kw_type when enabling, configuring, copying, and reading MCAM
> entries. That could program or decode hardware with an undefined key
> type.
>
> Return -EINVAL when key-type lookup fails. Return -EINVAL from
> npc_cn20k_copy_mcam_entry() when src and dest key types differ instead
> of failing silently.
>
> Change npc_cn20k_{enable,config,copy,read}_mcam_entry() to return int on
> success or error. Thread those errors through the cn20k MCAM write and
> read mbox handlers, the cn20k baseline steer read path, NPC defrag
> move (disable/copy/enable with dev_err and -EFAULT), and the DMAC
> update path in rvu_npc_fs.c.
>
> Make npc_copy_mcam_entry() return int so the cn20k branch can return
> npc_cn20k_copy_mcam_entry() without a void/int mismatch, and fail
> NPC_MCAM_SHIFT_ENTRY when copy fails.
>
> Cc: Suman Ghosh <sumang@marvell.com>
> Cc: Dan Carpenter <error27@gmail.com>
> Fixes: 6d1e70282f76 ("octeontx2-af: npc: cn20k: Use common APIs")
> Link: https://lore.kernel.org/netdev/adiQJvuKlEhq2ILx@stanley.mountain/
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 109 ++++++++++++------
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  20 ++--
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  18 ++-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  20 ++--
>  4 files changed, 111 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03..49b5cd2838b5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 7291fdb89b03..49b5cd2838b5 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c

[ ... ]

> @@ -3607,9 +3627,30 @@ int npc_defrag_move_vdx_to_free(struct rvu *rvu,
>  				   NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(midx,
>  								      bank));
>
> -		npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false);
> -		npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx);
> -		npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true);
> +		/* If bug happened during copy/enable mcam, then there is a bug in allocation
> +		 * algorithm itself. There is no point in rewinding and returning, as it
> +		 * will face further issue. Return error after printing error
> +		 */
> +		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, old_midx, false)) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened while disabling old_mid=%u\n",
> +				__func__, old_midx);
> +			return -EFAULT;
> +		}
> +
> +		if (npc_cn20k_copy_mcam_entry(rvu, blkaddr, old_midx, new_midx)) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened to while copying old_midx=%u new_midx=%u\n",
                                               ^^
This isn't a bug, but there's an extra 'to' here. The message should say
'Error happened while copying' rather than 'Error happened to while copying'.

> +				__func__, old_midx, new_midx);
> +			return -EFAULT;
> +		}
> +
> +		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, new_midx, true)) {
> +			dev_err(rvu->dev,
> +				"%s: Error happened while enabling new_mid=%u\n",
> +				__func__, new_midx);
> +			return -EFAULT;
> +		}
>
>  		midx = new_midx % mcam->banksize;
>  		bank = new_midx / mcam->banksize;

AI review report: https://netdev-ai.bots.linux.dev/ai-review.html?id=9923f145-31df-46b0-84e8-b15f1e307ad2#patch-10
pw-bot: changes-requested

Grammatical mistake in string will fix it in next patch version.

