Return-Path: <netdev+bounces-280347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFjWDGyI6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:35:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EF443867
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA52530182A4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4804E3BF676;
	Wed, 22 Apr 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l8UP3Od6"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3CA3BF695
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846743; cv=none; b=e4ADfqVDpKvyH9HP5BLtKj7Cf/gvhcec5GW3599vI2f3oOgCVjp7lV6ZS9lnlk9J2elnQkXZDfN/lkqTW3btyVPFl4KHecHYE3j1eMF5wk+fXsn1yc41eWQqd3jts/Ia9wGGqmTFt2i588kKqTYEHyZgXoNWlI9bI1PpbE077w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846743; c=relaxed/simple;
	bh=ND+ndGsSvpuoov5b6PdL2BGaGfrwCL/bOxZfNCcX/RA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Mo/GhpD0PRyrRv9SYyyfG+H4S+4LqOftbTJtz0qW06QNqbjLmFQS8ZGhpBJUG5YlFWy7tBILiUci+isW2BYoDoi31Wd8DDrYX8TzMsqViYsnQqQTeSJIko+905YFLTzGvZhaS0y9aYxevQYZfCnqaEkjRPvNtMbunvuImoXopvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l8UP3Od6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260422083218euoutp013c9f4b593d2c00ce4efc9213563bc747~ooLHVf9BW0998509985euoutp01c
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260422083218euoutp013c9f4b593d2c00ce4efc9213563bc747~ooLHVf9BW0998509985euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776846738;
	bh=6KEwBFNl1WwvmqFNjndDjulH1Q7j/Lbc88+2DXd8d9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l8UP3Od6BGUMosrpuJ76ljCD6yIFXlebVxCUUnuyMYccBa9jaeDOWvYBuIxN0EdUD
	 +eI1IADsIrT2KZgSgwWC1r0ofuDPcl3LAzey6btnsB+xW64NRSAWR/tNuh8yZ7TpFU
	 GRx90Aqgrg9yZCYAGriz3gmZqpS64umUWqAfXKjw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260422083218eucas1p19e4c668f95b21e640dd6d77125de4537~ooLGzqB702839728397eucas1p1y;
	Wed, 22 Apr 2026 08:32:18 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260422083217eusmtip1801f14871bad825b600e875a20f896a8~ooLGfk7nq1124311243eusmtip1j;
	Wed, 22 Apr 2026 08:32:17 +0000 (GMT)
Date: Wed, 22 Apr 2026 10:32:17 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Dan Carpenter <error27@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/intel: Replace manual array size calculation with
 ARRAY_SIZE
Message-ID: <aeiHkejLjhRKyj/u@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aeeFh1zQqhVysvxI@stanley.mountain>
X-CMS-MailID: 20260422083218eucas1p19e4c668f95b21e640dd6d77125de4537
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2101e_"
X-RootMTR: 20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124
X-EPHeader: CA
X-CMS-RootMailID: 20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124
References: <CGME20260421114034eucas1p1d746ffe32b49aeb57f10e729d1331124@eucas1p1.samsung.com>
	<20260421114029.2689961-1-j.raczynski@samsung.com>
	<aeeFh1zQqhVysvxI@stanley.mountain>
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280347-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A15EF443867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2101e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 21, 2026 at 05:11:19PM +0300, Dan Carpenter wrote:
> On Tue, Apr 21, 2026 at 01:40:29PM +0200, Jakub Raczynski wrote:
> >  
> > -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> > +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
> 
> This still isn't beautiful.  There are so many parens.  The !(foo < size)
> formulation is weird.  The cast is unnnecessary.  Better to write it as:
> 
> 	if (aq_rc >= ARRAY_SIZE(aq_to_posix))
> 		return -ERANGE;
> 
> >  		return -ERANGE;
> >  
> >  	return aq_to_posix[aq_rc];
> 
> regards,
> dan carpenter
>

Alright, will beautify it and resend soon.

I can see potential original intention of not comparing unsigned from sizeof
with int, maybe that was original compiler configuration to include that
warning.
But at this variable range it is irrelevant and it is probably most disabled
warning ever.

regards
Jakub Raczynski

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2101e_
Content-Type: text/plain; charset="utf-8"


------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_2101e_--

