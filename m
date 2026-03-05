Return-Path: <netdev+bounces-264189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIwQJ80iqWkL2gAAu9opvQ
	(envelope-from <netdev+bounces-264189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:29:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9CD20B97D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 07:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDD6E30131B4
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 06:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3F2EA732;
	Thu,  5 Mar 2026 06:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J2ab/VCa"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EC2DEA8C
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692167; cv=none; b=HZBkbXf52Zl7p8dXlvmpKNnTG1MsmnX2YEM78/LiZ1oU8YVzDFdGA/uZg6XDustnYKExzdepO6BTQli1D4aBGVoGYECmTO1i+IbGQRARNuGlj6fZDUpQHwPOxKoG1CQuzCNXHOXqFKLFOrv/mgmSohKWXg6hHYy7OCcH8tVIfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692167; c=relaxed/simple;
	bh=JK1R8UHWw4wfyV+JMHezBXGLaNfklOL94dZCYgIAuLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYg825xDyAE0vVViwsiGwvvNGA2sw0ef32n/OzdGDiZ0WZlXlRsdmUKmaoViv0UfLPfIIl9dCwtqThx5vK7KePgzkDz7yV9VQ+IX8ZH7Gw+ZrOENoHxSa/cIfMHt//TO83g73Qu1K6n6+r+2c+IADX9hFWE5YTb1GW5WE49vghI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J2ab/VCa; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624N7LJ72339921;
	Wed, 4 Mar 2026 22:29:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=KO+wODBMIt1b3VgNJMZAkGSCw
	jcFOk5CtqDVt3W+Axs=; b=J2ab/VCaU0Es2geR4vbkEB7ulaaCZFJzNQPMYg0lT
	pfqTj8amNcufMP5RdAMtpZ8BxoSO9a9KEBgjINVQE6aWHCYxIveELtpeYzicEzk6
	Tuvf8OGjzDT0fYViwhOqp2mM24JLZddvLGbWQscLGVtaOtu1aZIKpJYALff26o3K
	psX2MJkSm7DHxvW0ThPhkPPleuQV/7ab89fbV+MiZC3ke2cwjfbNjC4OYh17UfQJ
	+TdOZK+U677T45zZ16zy6MC3EVMmAPst+1K0CTnzzykwliL415pd1iat55WfjG9S
	+c/T+xMs+OkP0TUlzn9kAbAVHAqjng4jpbIUl+QXDwY6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cp6pgc65b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 22:29:01 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Mar 2026 22:29:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 4 Mar 2026 22:29:01 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 443395B6947;
	Wed,  4 Mar 2026 22:28:57 -0800 (PST)
Date: Thu, 5 Mar 2026 11:58:56 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <hkelam@marvell.com>, <jerinj@marvell.com>, <gakula@marvell.com>,
        <lcherian@marvell.com>, <sgoutham@marvell.com>,
        <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <alok.a.tiwarilinux@gmail.com>
Subject: Re: [PATCH net-next] octeontx2-af:  make PF_FUNC comparison
 consistent in NIX XOFF handling
Message-ID: <20260305062856.GA3263260@kernel-ep2>
References: <20260304193950.2467391-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260304193950.2467391-1-alok.a.tiwari@oracle.com>
X-Proofpoint-GUID: hBhx3UUMV5z2Sf3ybP7wYLcGRQX-f95m
X-Proofpoint-ORIG-GUID: hBhx3UUMV5z2Sf3ybP7wYLcGRQX-f95m
X-Authority-Analysis: v=2.4 cv=O8c0fR9W c=1 sm=1 tr=0 ts=69a922ad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=yPCof4ZbAAAA:8
 a=M5GUcnROAAAA:8 a=Z3nqp5ckdWN0-4B_sgYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=8_z660xuARpGUQqPBE_n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0OCBTYWx0ZWRfX/VaywXQ2aWdh
 UEb2VO0MJVh6aTWqaZOlYIyWi4vhn101r97Kq0s4a9ELyc2KMHdb9/EfygM1/d4W8mtOIak2mxK
 AP5o3anOAkzollCTdbzJdkoZhP55v7Mdphy2J5OLjOyPz6XU+bBOHd6cOELDTFFDc4CNkqlD0FQ
 biJMrnuy6HZLwvE3ZMmWipCqlcYJaXVc+oVX0rZepABvFgDWpgLE7XcSSADIMFnlqDxPi0l95mw
 ez//pJ2VQeXcq2uILP5d5A057sTJqpYZrMqXYonIFZG2UlmYE91gnOV8z9dg8hK2ECYJozQ+nQv
 ffDVCCKD8QrS1/QKaeQrEhiko5tZGjKmURSZ0vsgViBHey+ZxRhxnL7W4hhe2Col652JDHi/Vku
 l/qdOHsHgB/g/KPg+bmXUa7TRIjOmGpP3zv7B5Q9fLnpy+nh14opcw0KjKRt/3n8yZTPj58TGGH
 1GNm1o8LiO7gM6syPHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Rspamd-Queue-Id: AB9CD20B97D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264189-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-05 at 01:09:48, Alok Tiwari (alok.a.tiwari@oracle.com) wrote:
> nix_smq_flush_enadis_xoff() compares PF_FUNC values with the FUNC bits
> masked off, but one operand applied the mask before extracting PF_FUNC
> via TXSCH_MAP_FUNC().
> 
> Apply RVU_PFVF_FUNC_MASK after TXSCH_MAP_FUNC() for the TL2 scheduler
> queue operand, matching the existing handling of the other operand and
> making the comparison consistent and clearer.
> 
> No functional change intended.
> 
Yes no impact on functionality.

> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 98dd68137a09..32f1b1676a1e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -2391,8 +2391,8 @@ static void nix_smq_flush_enadis_xoff(struct rvu *rvu, int blkaddr,
>  			continue;
>  		/* skip if PF_FUNC doesn't match */
>  		if ((TXSCH_MAP_FUNC(txsch->pfvf_map[tl2]) & ~RVU_PFVF_FUNC_MASK) !=
> -		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq] &
> -				    ~RVU_PFVF_FUNC_MASK)))
> +		    (TXSCH_MAP_FUNC(txsch->pfvf_map[tl2_schq]) &
> +				    ~RVU_PFVF_FUNC_MASK))
>  			continue;
>  		/* enable/disable XOFF */
>  		regoff = NIX_AF_TL2X_SW_XOFF(tl2);
> -- 
> 2.50.1
> 

