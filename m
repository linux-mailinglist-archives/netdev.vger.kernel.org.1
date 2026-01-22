Return-Path: <netdev+bounces-252451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NLhAl9ecmnbjAAAu9opvQ
	(envelope-from <netdev+bounces-252451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E716B478
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50E8F3008D1D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC6372B2D;
	Thu, 22 Jan 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jobm9ckU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D836F431
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099559; cv=none; b=GlcMY+X/dfaBQY342DMS7NZrMkHP0N6kF1G4e8Aakwy8lkUPHwV+NjeSUikpqUVitkAc/4QmiaorreaDCtaIjOc5+GlDzGCdcZkElgGilphWshw1J5gXjptuuOxHhcjNr5b8I1uGbP4oyepEcP4ZQ9YZXMVt+vg5ZrttOJktVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099559; c=relaxed/simple;
	bh=gB4/fRdDJPTKfYU5nVslML07mH9G1NyS8+PNLFryg5w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McAZmWDZrVxHGzdYm/gogdcJ2v5W/RI+59rbtKmaiEx62g5HXJQgQ1YTOd57eSvFcb7tozQsM1/MA8OmpU/nUpA2s600FjhbKE7+B0IAPCtJ9hnNWeJx3WRRo1JWiUwo5sLTRR6F/Ms70UB0s/erNV2YBqLyJr1HeShgq7CfvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jobm9ckU; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M5vcEl1834527;
	Thu, 22 Jan 2026 08:31:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=/4T5QFtwOyTMlHKcSBvSas7lS
	FwPcVs+KYOLaa7mE8E=; b=jobm9ckUprkQUjow8EwUKjg65wF5VByI/UO26z8R0
	CZqsA4ikGoiambDhYbVQcNIDBGru2gnn7ALPmJVuqnheKuGGVooV4IumbLlcvcFR
	1ah8VBeUe6g0Hm3MPKGM3J5kKjA6i7iogRZFSWCsDvoJXmjrSfl5GdcCoQXo4tpu
	ForHuomMt9hvTNjjDU6B0DPE1SjqmNRqess6sLv1cO1z6ngzjmN1OYKcyZq3007j
	zmHoUqvuZKzRWQE3L3badK7Nfrpn5hcbxk7eCoj3ctS8pN3bCdE9xQANxFgFQl80
	VMrimkd3/kY78bffgBSkSi1zWFhX4OZoN6TFk1cXO2vlA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4btm3nmq78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 08:31:55 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 Jan 2026 08:31:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 22 Jan 2026 08:31:54 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id CCA383F70F0;
	Thu, 22 Jan 2026 08:31:50 -0800 (PST)
Date: Thu, 22 Jan 2026 22:01:49 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
        <michael.chan@broadcom.com>, <sdf@fomichev.me>,
        <almasrymina@google.com>, <dtatulea@nvidia.com>,
        <asml.silence@gmail.com>, <dw@davidwei.uk>, <daniel@iogearbox.net>
Subject: Re: [PATCH net-next 1/6] eth: bnxt: always set the queue mgmt ops
Message-ID: <20260122163149.GA1545062@kernel-ep2>
References: <20260122005113.2476634-1-kuba@kernel.org>
 <20260122005113.2476634-2-kuba@kernel.org>
 <20260122080420.GA1544331@kernel-ep2>
 <20260122073643.4d36e299@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122073643.4d36e299@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyNyBTYWx0ZWRfX97Nwu7Y/I1Xe
 YiVpNyfsx/cyuf11PA9lVonftzAzrVlyONSkXmFm4EUw4N42XeriFQmNo5BlmZVZcyDKEpKdH9V
 +GtsPUVLw3j6V2jo98TIDgRD4yt3soNt7m4bxaJxpLKYvrV9TEUKz87cGO80y55s7zvExn9A/AZ
 DTzKWfMz7jRfvVVMlic4wAM6edKYU86f2y+eytV2w7nN5ZHJI6U9bzg8zBBE1KBSOyO/+PfV8U/
 mGsFrGh/WpkfR2CRnStPqgauDWUnaZjfDUXOBr4RFF8g7B+7PcJeFG10vccLR0GL98n+F3DK8Vy
 7GWgqxZl4O5jjMRrNn7UNhIZU9YOpDN3GpKzr2K+Ec+i63JYgfh+Hc8lIbdf3EEShEA+EW39jiB
 +pvvTgqv/qgbe5rcDK8UwAxbDWvY9W0A/i3sAjom/bPShPgD+LzPYBQDE8KVxe4cJyb6W1OyUEq
 kwV4XVAg6ZTU4YLH6/w==
X-Authority-Analysis: v=2.4 cv=JeSxbEKV c=1 sm=1 tr=0 ts=697250fb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=RE_BLl2kp7n2li6tOYkA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: 8gxBgowyostGQ8LA76emmXXV2FORMNNY
X-Proofpoint-GUID: 8gxBgowyostGQ8LA76emmXXV2FORMNNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-252451-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbhatta@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 79E716B478
X-Rspamd-Action: no action

On 2026-01-22 at 21:06:43, Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu, 22 Jan 2026 13:34:20 +0530 Subbaraya Sundeep wrote:
> > > +
> > > +	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
> > >  	if (BNXT_SUPPORTS_QUEUE_API(bp))
> > >  		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
> > > -	dev->request_ops_lock = true;  
> > 
> > Can we also mention that driver with queue_mgmt_ops set makes it as ops locked
> > driver in Documentation/networking/netdevices.rst ?
> 
> Did you check if it's already documented there before asking me to do
> it? I know people don't read docs much but asking someone to document
> stuff that's already documented is a bit funny..

Okay it is there:

"Note that supporting struct netdev_queue_mgmt_ops automatically enables
"ops locking". "

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

