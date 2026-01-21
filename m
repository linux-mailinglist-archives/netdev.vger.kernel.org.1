Return-Path: <netdev+bounces-251721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PVDL8w9cGnXXAAAu9opvQ
	(envelope-from <netdev+bounces-251721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:45:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C564FFE5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C72254FF1F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4534105B;
	Wed, 21 Jan 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YFcnBBl5"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0F133EAFC;
	Wed, 21 Jan 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963237; cv=none; b=m/AKh5Lz76f0HRyHWVdJyUt0nLGPSzi7376RuOJBaBGkBF+L8CdNGbsnu4hbhCXyka7lEUsBpRifZlkwW9Ggd89C10wVkm4iIUvYYXF7+uJ6E5Ro9meRpDz7sqx3Ll43csurcFp1e4EQSsEEmP6gK+g7HhXVBx8WStfx5dJqXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963237; c=relaxed/simple;
	bh=vG7ulgE2NUllkPcMs+V1ywGFD3/4k7rJY0X0rzYk5lU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXIxw5D4rKzub/bHMxE02KCzSgsthUh5ibpVDD7HLdJlCdCv7suBCzk5Hnz0HdBRfPKnJm6jyDTx3gZigeSL02PIzc82FiDON9caJZ2eYOEFzTTlQyRYdZ/qzgQCi4LiRMI5KD3jW2JR857H5LR9uisxaMxvGzWPaswuNONN0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YFcnBBl5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L0FT1g2555854;
	Tue, 20 Jan 2026 18:40:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=cMWlC7xdlRK0vyCH1eXs+UN26
	n/M5K4L08dMcXF9euA=; b=YFcnBBl5EuHAkMlSQx9TiPOLkFWHtGYhZWc2Kbvgt
	TVnq3SMOXn9AoiHhTNBTnGciFg4f9X7uOWAYMOP9awMCDnYb71UPqKvemh1bq2i1
	qPRCFbmx488RgendILu/d6MoAi63lGLs0CuKetMdNHIayVOQ2DqFDUJOEdZKcFjk
	gr6Ovyi2NJcEgWTLkfsUBdo8lmStLCOdeajxxdqDcFmFndIhjJZaBiBjWEUKBmWN
	R0JGcFz+fDf+BNccFrCu4UD0p54RVAnwWCslmXEJbvUWUPEKWumQKIMzwamr/N8J
	wGDa1Pl9Xmwddiac+Iq6W+hdbhbGC3/1Fk0fNA7KUwJnw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3kg7qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jan 2026 18:40:29 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 Jan 2026 18:40:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 20 Jan 2026 18:40:42 -0800
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D837D5B694B;
	Tue, 20 Jan 2026 18:40:26 -0800 (PST)
Date: Wed, 21 Jan 2026 08:10:25 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net] octeontx2-af: Fix error handling
Message-ID: <aXA8mVKyRO3Ufm9N@rkannoth-OptiPlex-7090>
References: <20260120024012.1292307-1-rkannoth@marvell.com>
 <20260120234951.1888325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120234951.1888325-1-kuba@kernel.org>
X-Proofpoint-ORIG-GUID: N8OtgmOzJhnk64jpjpS84kM3fRGHwH7c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMSBTYWx0ZWRfX/nSZKoTKeqSg
 PTPSf0wmeiNyYIKrGlkOwx1qT9Nlcxh+qYyqYAB8fNxDlCecvHA6CH/laTXOKth4MbU9lWwOFsx
 XnLolDI054IhxV7zH5ZEYQ965hvq+Ln7aZGArggWgPF2AvQTNEPU5659GK6FAhwci1SYBnYEFAS
 sb2fl2nS2mufGzYF0yeMajgDgsI2sBxGuHSDGrR9hW25r412yl/sSFnyD8biH2fbLqyrqyrXTFe
 /IjgAHLM9nM6YWUgportQz5NZHI0FUGjZbvJfWelfFlUdhd8uPkZyei1jO2qdK1lQRmXqTYx3gk
 /9BAksPIXM7nspTFnOyHJIbMVUKzZt/E4LkJSt8ufNyGg4/IdxxhbhiVeJ4k4X8Vdlq+ZTVgm4V
 YpNRS4dgYzi/tTPcF5uJh0sfKwe6/M/6ke3mXzcMbNA9iDgpMv8rXgcNj0JK64VqyO5drMmszGZ
 Sc9W2MFgK11sW2bNJag==
X-Authority-Analysis: v=2.4 cv=Mu1fKmae c=1 sm=1 tr=0 ts=69703c9d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=bDKQiEsANi2LzoeKkOMA:9 a=CjuIK1q_8ugA:10
 a=16MAPSKLCI0A:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-GUID: N8OtgmOzJhnk64jpjpS84kM3fRGHwH7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251721-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	DMARC_POLICY_ALLOW(0.00)[marvell.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:url,marvell.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 32C564FFE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-21 at 05:19:51, Jakub Kicinski (kuba@kernel.org) wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> octeontx2-af: Fix error handling
>
> This commit adds error handling and rollback logic to
> rvu_mbox_handler_attach_resources() to properly clean up partially
> attached resources when rvu_attach_block() fails.
>
> > +		err = rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
> > +				       attach->cptlfs, attach);
> > +		if (err)
> > +			goto fail6;
> >  	}
> >
> > -exit:
> > +	return 0;
>                 ^^^^
>
> The success path returns here without calling mutex_unlock(). The mutex
> was acquired earlier via mutex_lock(&rvu->rsrc_lock) but the success
> path bypasses the unlock at fail1. Will this cause rvu->rsrc_lock to
> remain held after a successful attach, leading to a deadlock on the
> next call?
ACK.
>
> > +
> > +fail6:
>
> [ ... ]
>
> > +fail1:
> >  	mutex_unlock(&rvu->rsrc_lock);
> >  	return err;
> >  }
> --
> pw-bot: cr

