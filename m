Return-Path: <netdev+bounces-296343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iHVgGmEnJmphSwIAu9opvQ
	(envelope-from <netdev+bounces-296343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3D652362
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 04:22:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=WDJM136l;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296343-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296343-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71EB73001FFB
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1FF312834;
	Mon,  8 Jun 2026 02:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203E3101B0;
	Mon,  8 Jun 2026 02:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885343; cv=none; b=EgytoA+uuwEUbmwkioBdK95xpIW4ww5G68LMVZzo0tMeGV8z0/kH9XB3RvDhCbKoBwmC4akcNyI6yyLJCoXeB+rH0dAim0cpiQIGBDtlDib0iSRF8sgpoIg1/69Qg/KxvGR4RcH01303xN5tg1XbxufK+Nt3lrTSxTFLby/j0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885343; c=relaxed/simple;
	bh=xvOoqco9dwU3X3XFzeo7jF88zraiZQxApGT22ShlaMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UscDBt1YySKZAOmjzKb/6tWKD+PRFdSLTE0kNjIUYq/Dik5pPlXWUjynFFMO8mxSoJ5WaeQnA4SusASjHb4KlCOHGZJgshaOb9LmwGfbAZBF2eG+YW2fCdtU2oZGMHLM0VozrxRscA/SgfVTnQSJqQtSsHx1XphYvKU+Shnpnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WDJM136l; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580ElQG936625;
	Sun, 7 Jun 2026 19:22:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ETHgFE2mbtIfJYR61afM06NqO
	1jiiybK9cK7CYCUqOM=; b=WDJM136lT5yQv8KHmVIWk6r41t64H5mhg6m5G6zb4
	8ctmeDbj4xWZ54FBl39yAR1rYDs81lFTyr7rZ6rLwcu++ofB9L1je1+OYeGjWQD3
	ux/yy6EaOSXcNbY+xgCRvK9AO70ZqDVC2olikEymglidi4d275QPfAcu9mjrUQ0o
	vLYnG4BKaYT38Kxa9ncB27jqm1xAnAS+wYo1O1t/hwTyhfVvVButkzmi6cTLKdNX
	Oexj1tzPjsnUpjRiSsMCeYlubovOBoi594hwv7JRFyPA6vqKn3XFe/kMkR4qm9Ts
	CJBtwCSmAg8afYpksjLEi1n18vgzCguNh/LBwIlb5IX0g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2emrfy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 19:22:13 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 19:22:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 19:22:11 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 9F9C65B6932;
	Sun,  7 Jun 2026 19:22:08 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:52:07 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
        <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <aiYnT_3uXRCAfszg@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
 <20260605063245.3553861-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605063245.3553861-6-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX4bFZlIzxnQvj
 kl0n9MS2rXK6FTfzGQ0k2YUeCpLFiqSWK+z0wAnIFY7tMDowI7KoX5wRqYMCkBsfe024rIeegJZ
 tgWd3qK1vu+1/7EaM1+dqXx8nRO/v6ZamhuuYMSnnMSwUkOp+pxGK0K84Q5qo1qmCna1BamT+Pz
 yd7ullMgJUxTMxbqsFawHv938mNmGqcLr/G/jm11ptS/iCARwhkkoToLddx7knpYyTG3FeGANpx
 g7Y26zin8yVOLICDpjDQDqO2VOTEHKHi9WMI5cKtISxfamzS1CykkEAfsiHWCIJKpfwgRKSTGn+
 Cq4KmqFhalVxpg3WaPlwFyu5O14H+nRUtLgCZ0DArOjCoaItMxqR1V7OhANg+B/gVErJLhAnJdL
 CUMFCAxAXjPlckggRT0wYXXmkV6c1Ngi8smqn7e+VjZMFofXzAoP8wHuHhuuQxXRvNJJ6MeBpi3
 9euC1dDYKdDelVI09ug==
X-Proofpoint-GUID: AQV6HOAJxhKs6yQIZrqDL6gOSoKTxQ4C
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a262755 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=c92rfblmAAAA:8
 a=M5GUcnROAAAA:8 a=xf30bXlcfD2pyG46aycA:9 a=CjuIK1q_8ugA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-ORIG-GUID: AQV6HOAJxhKs6yQIZrqDL6gOSoKTxQ4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-296343-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,rkannoth-OptiPlex-7090:mid,marvell.com:dkim,marvell.com:from_mime,marvell.com:email];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2E3D652362

On 2026-06-05 at 12:02:41, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

https://sashiko.dev/#/patchset/20260605063245.3553861-1-rkannoth%40marvell.com says

> @@ -1566,13 +1569,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>>
>>  	/* Alloc NIX RQ HW context memory and config the base */
>>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
>> -	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> -	if (err)
>> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> +	if (rc)
>>  		goto free_mem;
>>
>>  	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
>> -	if (!pfvf->rq_bmap)
>> +	if (!pfvf->rq_bmap) {
>> +		rc = -ENOMEM;
>>  		goto free_mem;
>> +	}
>This is a pre-existing issue, but I wanted to ask about what happens if a
>VF or PF repeatedly sends the NIX_LF_ALLOC mailbox message without an
>intervening NIX_LF_FREE message.
Pre-existing issue, will address as a seperate patch after this series
is merged.

