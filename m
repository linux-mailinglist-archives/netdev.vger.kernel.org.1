Return-Path: <netdev+bounces-273986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLriBbrazGnnWwYAu9opvQ
	(envelope-from <netdev+bounces-273986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:43:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BFF377039
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9FDB3148F8E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40A3A3802;
	Wed,  1 Apr 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hrWLykOU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0A324B16;
	Wed,  1 Apr 2026 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032387; cv=none; b=qQWsqZtcO7mHYmmRpE/UAMvgnPR0Xel5xx7f0UXHZXl8hrKROagQUkahtmLA/oeZaj3S7P2CuTExNzrqRpYsCKsfA+2wLvTwIp7pPXnLd39xrjuLl8QASRWdHHU0H82NiaNwncLPzAfXuUouG0SkpsCpqL5NSEaIZXng366g+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032387; c=relaxed/simple;
	bh=SZ1JOMQHVg/HDtpGHBrLFS3rZZ0IhX2cXTun7gd1PjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTaGKKLW9+EYC7f8SitKSwpT0vjIAB9RTVkGKgd5IRbwrWdS2WZz+EreaFV3sKHA6FGpIXnHo4AVsnSGXKTkq+rL/TNU46IazGoCz5/C7ug0IKhxQDvCiVWV3MkDd00TnE+RShKj52vIp7GxWhEpv99f+wEICo+WJ3lXMrfvUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hrWLykOU; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311tqVt2699231;
	Wed, 1 Apr 2026 01:32:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	dMtl++c7A3ycv7YADbAupxesFesrrjEFZkIpQ12X0I=; b=hrWLykOUq7K940jqS
	G53Nuo+GOzHzLhC7hXURl+pPLzxbtvaeAJBfaCK9fkwVf30ZlARsfmomO5DUzUm/
	fVlyxhuxMhGBQvZ3mER2KxMZ0n6HXgs9uQDgTpeVsnSugFPtG+WrcwypgK1oGMlq
	uZ8fXYSBpzAGqf/UZSER0AUutiNlcZlKUE1hLbCWC8mNodHUE8I7PWavRQrv5781
	/FS22yIcGlm6S8QHR0CWOZrl9pquZ6QE6yajCbBBYswskwoFDQbOdsRV92BjsbBT
	RepqtFsXjss0eO0SJT9aWSDdFaxL6CRE9W0ErHnkF++tYOySl1XoXS2AkB8woujT
	pASHg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d7u0rnu1r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 01:32:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Apr 2026 01:32:38 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Apr 2026 01:32:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Apr 2026 01:32:37 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id CD1CC3F7044;
	Wed,  1 Apr 2026 01:32:31 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:02:30 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Marco Crivellari <marco.crivellari@suse.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker
	<frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Sunil Goutham <sgoutham@marvell.com>,
        "Linu
 Cherian" <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Jerin
 Jacob" <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next] Octeontx2-af: add WQ_PERCPU to alloc_workqueue
 users
Message-ID: <20260401083230.GA1481407@kernel-ep2>
References: <20260330095405.116990-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330095405.116990-1-marco.crivellari@suse.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3NiBTYWx0ZWRfX/nj44amALtgu
 +8CUkStM3aXkrEdRVnj+N9DkyXbpJwrvjijWEmTxpcLBznMIOtvFI3L/47nMBMESeYx6TIe8ItU
 Nhoo/4VWAtFzDV0gP+XWbLyJzNOUMDnbVMSWz7FmavkeHwMAyT6wjcYBPP/SNIiyI/MBPt9awgP
 ay8GH7Bml8Y6lGiAoV5FNYKNHglglaJFS9m+Mz0pkeOfubkec88Mpi2cLHYJwz/3uaBuQLcwDFN
 lBGWBkgv1UCnSfchzbPsUvdL+1xCqNvf53s9onsXzLK9nm7wVvV41ER2+7hboyNElHNGIK+2Ckt
 wY8zVkUWWEldzcPigH2ILB3nmxBNUnZPNrUKWJcvgJlxvBlolPlslNJoZFccv3yyw2JlLHrtnQV
 DVPob9d9UB+Q0ixnU6qXBrRgyutZ0OruvojqRcqyW+BG+qV8NtBRnCOeXUokpb7PXRiA7WGIjQz
 OX/LvqGRpSY06G3qfHA==
X-Proofpoint-ORIG-GUID: f2yvSiTrhwZnj2axG7cISaS4ESvHrGVj
X-Authority-Analysis: v=2.4 cv=UJzQ3Sfy c=1 sm=1 tr=0 ts=69ccd826 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=iox4zFpeAAAA:8 a=M5GUcnROAAAA:8 a=j8Fb16kTpk43c6-pS-oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=SLl0K066jgiTy5fFaZhE:22
X-Proofpoint-GUID: f2yvSiTrhwZnj2axG7cISaS4ESvHrGVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273986-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:dkim,marvell.com:email,suse.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 51BFF377039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-30 at 15:24:05, Marco Crivellari (marco.crivellari@suse.com) wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
> 
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

 Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

 Thanks,
 Sundeep

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 5b1129558e8b..1a1a863199ee 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2576,7 +2576,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
>  	}
>  
>  	mw->mbox_wq = alloc_workqueue("%s",
> -				      WQ_HIGHPRI | WQ_MEM_RECLAIM,
> +				      WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
>  				      num, name);
>  	if (!mw->mbox_wq) {
>  		err = -ENOMEM;
> -- 
> 2.53.0
> 

