Return-Path: <netdev+bounces-266665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DoqGcd8sWmACAAAu9opvQ
	(envelope-from <netdev+bounces-266665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:31:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60C265657
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FC2303BB08
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3C7317161;
	Wed, 11 Mar 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hceTyOki"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B91EE7C6;
	Wed, 11 Mar 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239483; cv=none; b=uH9DPnZCRvqYSHVaYpLcFVR/2xzalNGAcugBg5xtgjaVmWcmCb6es22AhKl4IUAcvB919O1mHcM88s2weFkDrkn4QMQTcvykGe9zwggOYBDZEWD1Pvh8+6Kz2f9Tp/jzsd2BW96B7iJ1zH66i9jKSqwAq+g41UuV9B2gx/QPBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239483; c=relaxed/simple;
	bh=qoQFQXrsMqpMb6pa2vqn40PkmYW2xPRkrO7wi9JDogw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCvUi7rmtJEj/op0ZSlPSC/wbJvJ3dpBLsirZpWO47ZsWOcMBO0Pt7Y4C+3wnkd3x+voZ1/+u2SpEdSdQy9FDTbPgUsO9dnvEUoEx3FRVMHF1lMRi2uqCFxE1CmJd8BothY0C9Do1/uNEGV6aCI3SnCnMkAbgxW7MbXtWU4h93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hceTyOki; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9mrEZ077819;
	Wed, 11 Mar 2026 07:29:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=qoQFQXrsMqpMb6pa2vqn40Pkm
	YW2xPRkrO7wi9JDogw=; b=hceTyOkiHeYM7RZmIEFynCz6kbPo2DQBXYJS0z7l8
	6H6A93LlxQtMDAAuuMYsd0jlJ+wxd/488iuuspc6VefbhN24tV2gJRJTq3F5iHiK
	m9QO5bsf43KfGQKLeuyqDOYfjgORthDWioRpJJ1o7ex84+coMHXkrMzWpcnq65MH
	UFe9TrSOpV643ODX4re8HqsljZ/IANOZt24/nMXZlFj4tFR/Zc8NsFZYQMRVe3dC
	iuGVPbuctqS83ZgOsEoTV0BqX4cL/TS7AofAO5ldvwLyRlfuOIQNeP7tCHbNgDfG
	uJplcXyHu+kZeN/JxXNnIbZpE4xQv/L0FjRQy1SMeTGEA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cu63frjhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:29:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Mar 2026 07:29:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 11 Mar 2026 07:29:02 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3071C3F7076;
	Wed, 11 Mar 2026 07:28:57 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:58:57 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <cjubran@nvidia.com>, <matttbe@kernel.org>, <chuck.lever@oracle.com>,
        <shshitrit@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <saeedm@nvidia.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <pabeni@redhat.com>, <donald.hunter@gmail.com>
Subject: Re: [v3,net-next,5/5] octeontx2-af: Add support for loading custom
 KPU profile from filesystem
Message-ID: <abF8KYez6x2luE5a@rkannoth-OptiPlex-7090>
References: <20260309024619.898211-6-rkannoth@marvell.com>
 <20260310172100.890161-1-horms@kernel.org>
 <abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090>
 <20260311101450.GR461701@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260311101450.GR461701@kernel.org>
X-Proofpoint-ORIG-GUID: unUX-rkItc-8XV4QIztonUvTQKvW2Jwc
X-Authority-Analysis: v=2.4 cv=daONHHXe c=1 sm=1 tr=0 ts=69b17c2f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=CPffLNsNvW7s1x_9AtwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: unUX-rkItc-8XV4QIztonUvTQKvW2Jwc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyMiBTYWx0ZWRfXw34qv1nlbzsj
 4azFBt1uQREX9G8oODPDXCQG/PlpvNDgCOU51EWKNqE2mBkjG5+c1ZtgxONAtdkhQc/m6ZnEDlI
 WHBUmnYjbGQBn68NJ0mlO2VqEo8amDWG0WSIhtrNU0LeHqrVayhAlexrT/zSntl61eyt+G7kOe+
 2ZjlMUbn0O+2e679/1SC9i3sIjyR6FoZ+88OVhKoo3YpbP3a2T9HH+pdr0iYeAE102Y68AuzPf8
 qQN+x11AF0cIhKEa0iUexYFw4HzP5tYb2s7YfLGlVyn7wH6JtxZsAAoZnNZ2Q9+5YfzGQOxbUt5
 uESQg1oKjN9+EAQr8tmP2zcgucyB+6yKpjN/nQwLGGeqI7sPEQNrraXjK/diribrxbofS9ojBJN
 rGqVX+M/N2MNobY+vWM6qCJ2ijF9JCOJRY4tzWqc0yiCeC3LYer9Nx7KZg/cS8otwW88U5oZW5W
 94X4fEkifvDkmOdmwUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266665-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,oracle.com,vger.kernel.org,marvell.com,resnulli.us,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BF60C265657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-11 at 15:44:50, Simon Horman (horms@kernel.org) wrote:
> >
> > The filsystem binary contains entries for all KPUs. So we can ignore this
> > case.
>
> Maybe it is just me. But I don't think it is entirely satisfactory for
> the kernel to rely on data supplied from the filesystem being well formed.
> E.g. what if it is corrupted?
>
> I think all the points in the AI generated review hinge on this.
> So let's try and agree on the basic principles and move on from there.
> ...
ACK.

