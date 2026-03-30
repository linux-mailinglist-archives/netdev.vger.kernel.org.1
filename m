Return-Path: <netdev+bounces-273063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A7uBMzwDymlO4QUAu9opvQ
	(envelope-from <netdev+bounces-273063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:59:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506C3556B1
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 06:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 105E83006F1E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900B30FC21;
	Mon, 30 Mar 2026 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HBiky7mj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E07262F;
	Mon, 30 Mar 2026 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774846776; cv=none; b=S0fkdSiW9dSPVyxBWEIJ2tgy18i2RpamBkGp1JPTTerLVZT4znDYM3+oqS4TgAKWNU1gQGghNbZ7vT8PgbuZYOLPBFyVmFewX7/doIAStBPhVgN1pxWK+8bc+Dn4ERUb+gLP2/hKt8ktNJrNAPhBRsLdgZOn1sXC/nkTswJ+dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774846776; c=relaxed/simple;
	bh=0mHfXMh21yV/mUvgNTP9bUiAc4Ujev2+d9ic1DfXW5s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXigxMsiPYWz54v5Dw9Emgq0HhbEZAPlctWoy9t/2V4oVy53VCRyaoB4TyZ6JZ32L3Wos7WJLIi/ByGSOtaBbjPFPgHIE8BMSi6jWA8t2lNDWNje07QlLuXClJHz2e2/N2uIvkWGGJfDOoalNMSdsxpIs+YSsEygHPsPYAjMQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HBiky7mj; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNrtGG1344104;
	Sun, 29 Mar 2026 21:59:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=T48LjFP7tnFLZJpp7R9Jnjwvq
	sRTlZ38lbQWHPtwVD8=; b=HBiky7mjkhC9a5wMYs7zx0lfn9dT8D1pKjWpJbKIe
	+vtg89iIXiVB4Rm5P4vLBFyP5JUnuLG7T1yydaToYiMbBrNgvi/STwQ00b5+Br6D
	k9lRBaOLTwFzngz/pkiGnNGg1pQ4CJ3g87b599w1YCBQ99B6u7URj/ozs8XNxkuI
	HD2HMHX3jqJZjmHX4DQjIqMMZYGlg5bn3zun9/Ve57pKGZT1WOnre2qhdWJ4vjGD
	XC3w4+kg5LxKg0jMEqpi2knkSJtFWQ4DdO15cfLGZjpgqdmd5cDZnkD6U8/1ukxt
	/zbOPHSq2Pb47tGsCc9R8ZPE3fkRmW9rge504Iwko8doQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d6yr71e1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 21:59:24 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 21:59:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 21:59:22 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 303B23F709A;
	Sun, 29 Mar 2026 21:59:16 -0700 (PDT)
Date: Mon, 30 Mar 2026 10:29:15 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <donald.hunter@gmail.com>,
        <jiri@resnulli.us>, <chuck.lever@oracle.com>, <matttbe@kernel.org>,
        <cjubran@nvidia.com>, <shshitrit@nvidia.com>, <dtatulea@nvidia.com>,
        <tariqt@nvidia.com>
Subject: Re: [PATCH v8 net-next 6/6] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <acoDI_L8wuRRso-z@rkannoth-OptiPlex-7090>
References: <20260325072159.1126964-1-rkannoth@marvell.com>
 <20260325072159.1126964-7-rkannoth@marvell.com>
 <20260327133036.GE567789@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327133036.GE567789@horms.kernel.org>
X-Proofpoint-GUID: fAVaFSk8ml1oRL-X0Eoct_lIveeOH4h9
X-Proofpoint-ORIG-GUID: fAVaFSk8ml1oRL-X0Eoct_lIveeOH4h9
X-Authority-Analysis: v=2.4 cv=a949NESF c=1 sm=1 tr=0 ts=69ca032c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=jLD6hGjqBhhHsm1mV9YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzNSBTYWx0ZWRfX39yxiRb8BGcX
 8XOAm+evfOfA1nCrqj84s7e50YMpdORl2+XijabvlnqnGxrf+ncCyATDnsik53WJ/88gnUcNyce
 RLnSuiZ4rYAogU3tyhdmMZ5J2N5Me9VPsODkC0q/efFSNgLe0HHf4SyVWAaRl+BGoRwb3rDJrcs
 BUT7pKSkeJK1W0t7Wore/TaYhZwUwdN+zELpNUi1rGZ3GjDb6o4aA/ny/tAdo6KETcKjET60Hay
 uKdQR7f9HeIXj/8n+OIxtpciS7GWYM2qJ2+dim6cr9vle5yM5YRgoP5h4A6bP65vTfmXut8Lpep
 gZyJODz45RvAKL26BnxtxHoQZ3uaqN2ZOql8ExtMBIRG7k8+7Oq72kHFJtzCrt6UUeiUuNSRnoW
 3NmcFjW9bwETQBz7LgwsuMFmKZS59myLLuyv0Ch61i6SlTznGbRjFvCWnugfeUEcstQ4+F3zyb3
 BB9og6OoyCDGf9kEL0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,resnulli.us,oracle.com,nvidia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4506C3556B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-27 at 19:00:36, Simon Horman (horms@kernel.org) wrote:
> > +void npc_load_kpu_profile(struct rvu *rvu)
> > +{
> > +	/* Order of preceedence for load loading NPC profile (high to low)
> > +	 * Firmware binary in filesystem.
> > +	 * Firmware database method.
> > +	 * Default KPU profile.
> > +	 */
> >  	npc_prepare_default_kpu(rvu, profile);
>
> Is this call to npc_prepare_default_kpu() still needed?
Yes. If both filesystem and FW database method fails, default KPU profile is loaded.
>
> ...

