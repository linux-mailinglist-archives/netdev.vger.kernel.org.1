Return-Path: <netdev+bounces-282652-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ87LFTW8mnIugEAu9opvQ
	(envelope-from <netdev+bounces-282652-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:11:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7E49D394
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E7E53004909
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB3359A81;
	Thu, 30 Apr 2026 04:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Q5s4eh+v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C125B30D;
	Thu, 30 Apr 2026 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522258; cv=none; b=KXXeZuQo1eriMNFRr0m+QGiZahE+D6UMJZYtPw4VOtZOSW98M8eqBfVnBS80s0cDzgSKjTQ7nscmAGIaZOUHhMAsI+WKHOWTcHmuTp6I4qJrlnTCIvNrOJU05tDXhT+mihhRXRI5PVSnLoNg/ovzwJDLg6y+dAREuqNyYtz0S68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522258; c=relaxed/simple;
	bh=kc6WE4AWJNv4MudlVpnv1JvFfzMmyFujSiNkm7m/7U8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udAbxl6U/E5ZSJktvI6uHwztEpT7QooZKpaSEUrSAgGC2Tf2qsI66mu/QSsrNbbaWJa/jQLaY7M+rmrFTKOdHV6SoUnKu6OF0nNH5TbGQKhg4oAfP7KrmZr64oOgN9QHvu6G/7SEnBc/IvORTMR0sfykrnYaTApFI0lZZdsWZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Q5s4eh+v; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TLUroH1642611;
	Wed, 29 Apr 2026 21:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=wXHdspk87EFvLGtJunX+lDjPU
	a+n2evPe8Wga9nvhGI=; b=Q5s4eh+vPFNZtZQTgSsNhL1LlzkEotzDmRMcRw3o3
	oCu7FSAzV9O9VaXjinwIVJY1F2wSdZbJYFu0FJ063No4/b8Ucie+qseANrMYnlKv
	FsEVsdmFblGAbDKaAEdiphRparVwaXbsf5HgZ7skQL6tLL3BYz/Xd2ZKLa+tIWIe
	mIK4qB+jBkgb8oE43gwARIil6MKg0Mj9Zg8Pxx7TZXFpU0RpWc41lHmHGiRV72oC
	gAt6agrpkf8tsDH4bUdw+YWbehjcpw+Mf+/nLCE2a3dqEwFdmjCIqIeC5Egd6nbM
	5laWbzzBku2E/PMtARosYg0Kc+XXK7aZW51rbFbe06X8Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4duet8au5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 21:10:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 29 Apr 2026 21:10:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 29 Apr 2026 21:10:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 26BFE3F7062;
	Wed, 29 Apr 2026 21:10:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:40:38 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Dan
 Carpenter" <error27@gmail.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v5 net 03/10] octeontx2-af: npc: cn20k: Propagate errors
 in defrag MCAM alloc rollback
Message-ID: <afLWPiDqEonHzOek@rkannoth-OptiPlex-7090>
References: <20260429022722.1110289-1-rkannoth@marvell.com>
 <20260429022722.1110289-4-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260429022722.1110289-4-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzOSBTYWx0ZWRfX6iPz0ncFzr2L
 w6vGd6iBF8l7wbIF1DtASpMBEf36AwBsKb9kcdITQ5tPAwX2D6WudHkJ3yNBME92gFNzzi19uxn
 zOxmUfwi/0P63Js/fkJbHinGXhLZEPugbVaHWcNUY9e7z23dBvwIUAhyNmIOr5qr9yM7IF87MBB
 2j4DbgjGvanrfsAtSViFLT0+X3iuUN0W3kQ/O1L/3OZMHB5PNspkM4OKdstTxcINkPcaVontQrV
 6uW8331/8E9jP46VPGRjyseoRi1440dfA6AkkWo/q+LXMYFsT3vkQTsURRwb5Cm3Z9c+ZdvBWkW
 /Zi3xFif/qeMn+rJo4BNECl9n8noItQuHJ+qfJCJcKqGTmR1BEraUBp+I0Wbs7MU962v6Fr3Cph
 PwQHpXaRJgEGi6y64lqS/GHhl1KR2gopEgltyT1zZnxjp7e7TH4ug2ZbZm8HZY4V5R1bmbqbC8h
 8jewHxsC66B0QIrXdHw==
X-Proofpoint-ORIG-GUID: RfaVyVZd1G2VaTR1VF5Ek_lWDR1vTb_Y
X-Authority-Analysis: v=2.4 cv=NqDhtcdJ c=1 sm=1 tr=0 ts=69f2d644 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=EM8fMfiB-ErqJA88EKcA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RfaVyVZd1G2VaTR1VF5Ek_lWDR1vTb_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Rspamd-Queue-Id: 52B7E49D394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282652-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 2026-04-29 at 07:57:15, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> npc_defrag_alloc_free_slots() allocates MCAM indexes in up to two passes on
> bank0 then bank1. On failure it rolls back by freeing entries already
> placed in save[].
>
> __npc_subbank_alloc() can return a negative errno while only part of the
> indexes are valid. The rollback loop used rc for
> npc_mcam_idx_2_subbank_idx() as well, so a successful lookup stored zero in
> rc and a later __npc_subbank_free() failure could still end with return 0
> when the allocation path had also left rc at zero (for example shortfall
> after zero return values from the alloc helpers).
>
> Jump to the rollback path immediately when either __npc_subbank_alloc()
> call fails, preserving its errno. If both calls succeed but the total
> allocated count is still less than cnt, set rc to -ENOSPC before rollback.
> Use a separate err variable for npc_mcam_idx_2_subbank_idx() so a
> successful lookup no longer clears a non-zero rc from the allocation phase.
>

>>could the commit message be updated, or are there missing checks for the
>>return value of __npc_subbank_alloc() in the code?
We clearly mentioned that if both fails rc is set to -ENOSPC.

> @@ -3529,6 +3530,7 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
>  				 NPC_MCAM_LOWER_PRIO,
>  				 false, cnt, save, cnt, true,
>  				 &alloc_cnt1);
> +
>  	if (alloc_cnt1 < cnt) {
>  		rc = __npc_subbank_alloc(rvu, sb,
>  					 NPC_MCAM_KEY_X2, sb->b1b,
>If the first __npc_subbank_alloc() call fails with an error like -ENOMEM,
>alloc_cnt1 is set to 0.
>Would this make the alloc_cnt1 < cnt check evaluate to true, causing the
>code to attempt the second allocation instead of jumping to the rollback
>path immediately?
Roll back is already done inside __npc_subbank_alloc(). So no need to rollback.

> @@ -3544,15 +3546,17 @@ static int npc_defrag_alloc_free_slots(struct rvu *rvu,
>  		dev_err(rvu->dev,
>  			"%s: Failed to alloc cnt=%u alloc_cnt1=%u alloc_cnt2=%u\n",
>  			__func__, cnt, alloc_cnt1, alloc_cnt2);
> +		rc = -ENOSPC;
>  		goto fail_free_alloc;
>  	}
>If the allocation fails and sets rc to the actual error code, won't this
>block unconditionally overwrite the preserved errno with -ENOSPC before
>jumping to the rollback path?
You are correct that if the first call returns an error, alloc_cnt1 is 0 and we proceed to the second call. This is intentional. The defrag logic
attempts to gather the required total entries (cnt) across multiple sub-banks. If the first bank fails or is full,
we must still try the second bank to see if the combined total can satisfy the request. Since __npc_subbank_alloc()
handles its own internal rollback on failure, there is no leaked state when we 'fall through' to the second attempt.The use of -ENOSPC here is intentional
 for the defrag context. Even if a sub-call returned -ENOMEM, the high-level failure at this stage is that the hardware simply does not have
the contiguous space required to perform the defrag move.

