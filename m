Return-Path: <netdev+bounces-286583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCI6ONSqAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:09:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE1250B969
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B64306D439
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5223491C9;
	Mon, 11 May 2026 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zlbMpr/M"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEC344DB5
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493738; cv=none; b=F4x+d2klTuothe1HKoNrdkXPRkLuKMjOcn/cH2BOI5KoijDZEZ1KS9cCe7VmKFVkaQ7BsHC5StEWKZS1YCZZQ2i967nR0OeEQKMy1ow7IrEQvFmqTVKIhOJXHMgTO0yocsxkPDWXsRIVX/OB7m9mdpJrVGy0F51FBrXgmEUnyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493738; c=relaxed/simple;
	bh=gxr9pavRElNh7wh4l2v6vm1riscc6vcnj4mRFG36syM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1iVfuZ5qFlG0HMUuvl60lZc4RZGi60W3fFNsqdwQX7Ar9GLXsqImJPOx0YqZuAWYVLj0Dhc1gerkDWphfAT9JCoLC4lJ/EBjs+UuLsz0TRwJRxg2FTNtVa3M/0PgLZODjqMLhl2Jf+GYTVOqF+Di5KeY+lkgXHvOlAjr4kPm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zlbMpr/M; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 68CAA20704;
	Mon, 11 May 2026 12:02:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2TlJR6UyHjGn; Mon, 11 May 2026 12:02:05 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8646B201AA;
	Mon, 11 May 2026 12:02:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8646B201AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778493725;
	bh=lKGB39JXJTxL8tUDgD/z4BYCZRQYs8mxvCJtK0ZDbPk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=zlbMpr/MurgPXcba0qUfGV83F7lDrPMJX7ZArIdlixNjf6s2AT1ncQG1s7IHLWFaA
	 Yy943tHLHBmXWdmeLsuPXS8WMQQ+O+YXNh6B7lquOWBYmQI2odH8nPf2DSvQ77eilx
	 geIEcDbHtSkR5V4v7IWMjF+8PiISgNaMrZ4UtNP/kA7W7iLG1bfvwDVeC6i07zuGY4
	 cuMKxJbvCji93xa+bsJK0KMjdTQGCw/fVdEMeqkNQpx+q+iugzCYm2l8IY6WHEdMRv
	 xT6JmzexXCMK9cRViTTwbPWp4DKoI+52oGMJiGtJ8blubuog6UKq0FWnp08VROyZKD
	 GLhBc/DeovvBw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 11 May
 2026 12:02:04 +0200
Received: (nullmailer pid 411050 invoked by uid 1000);
	Mon, 11 May 2026 10:02:03 -0000
Date: Mon, 11 May 2026 12:02:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Orion Zhu <zylzyl2333@gmail.com>, <n05ec@lzu.edu.cn>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<yuantan098@gmail.com>, <yifanwucs@gmail.com>, <tomapufckgml@gmail.com>,
	<bird@lzu.edu.cn>, <ronbogo@outlook.com>
Subject: Re: [v3 PATCH] xfrm: ipcomp: Free destination pages on acomp errors
Message-ID: <agGpGyzaX_0Eg4op@secunet.com>
References: <CAAAOPT9Jw_TKnuqyQ_5es_ot0SNLprU2fSJwtEORj3OLf_QECA@mail.gmail.com>
 <aftA0Iwi2aX_4ORo@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aftA0Iwi2aX_4ORo@gondor.apana.org.au>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 3BE1250B969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-286583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,secunet.com:mid,secunet.com:dkim,apana.org.au:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 09:23:28PM +0800, Herbert Xu wrote:
> Orion Zhu <zylzyl2333@gmail.com> wrote:
> >
> > Thanks, but I think moving the label is not safe for all paths reaching
> > ipcomp_post_acomp().
> 
> Thanks for checking!
> 
> We could fix this by checking whether req is NULL and whether
> sg_page(dsg) is NULL.
> 
> ---8<---
> Move the out_free_req label up by a couple of lines so that the
> allocated dst SG list gets freed on error as well as success.
> 
> Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks a lot everyone!

