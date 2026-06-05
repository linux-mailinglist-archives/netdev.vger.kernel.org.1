Return-Path: <netdev+bounces-295706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hl44LpR/ImqLYwEAu9opvQ
	(envelope-from <netdev+bounces-295706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D4646215
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:49:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=U17QZSBF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295706-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE7F3026F17
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E2346AC0;
	Fri,  5 Jun 2026 07:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B893FFAA2
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:36:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644970; cv=none; b=R8SO0kZr+jOmDizwdpJLJ4X5uFD2t+iMUp7irWxjq9LCeSzu26zuSl66eZCgSbgZw6orug6XhIk/SBACErfkXTtbdZhHft0AaNsglqIeoeCr4AuRITBVM+/lr/YdoN8i5YjQl1SEhDuFp94JN/t9OpYGKjDjHS6rKaPcZc3Fajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644970; c=relaxed/simple;
	bh=aFF9Umm8FVnsgsM0y5CWqs8lg083FOTv4okmUacxVGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgG2xPEUsoqawfNICVRMDvgRVba9YlBcSQeYT8imKRNOk6K7F6+p+Bv9BNEQH2ElMVky8PaB4hBELvVfdP0eGRR631YbELKt7hd6dOETkQ58M5UZ6rv1wlKB8mjgnGvE5Lsx1Js4bOL/j8q1jrj5oqC2ZUg7Vet0rtkAROxjzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=U17QZSBF; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 313D720826;
	Fri,  5 Jun 2026 09:36:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VInwIrziV_8z; Fri,  5 Jun 2026 09:36:00 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id ACAC22080B;
	Fri,  5 Jun 2026 09:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com ACAC22080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780644960;
	bh=hH6p9gqJVb8rDCuwg5DMee4Qw/fl8wJ5+/fbSURlN6k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=U17QZSBF0HnTVsp0XhTES1Zg8EZR6dxYC6JKL5Gj52ve5OykmbnesDk/VfOuqYU13
	 RIi53cs0RFdPU2clFyKYze+HrlSQsLZ3lL8WhqqWIynEnBhu3AoZaBrdVcmv/S5lfg
	 rOkSWzjOOmPIlUIVOJiXKol9A6lTbl+8iDiVgHVyz4qMhcX41ytivU9ZMA3O+K4Cvm
	 6RIUGs5USbPsh2ciAn4Yeeu0uevV3fOU1o5OIfkGs22BNUdZ1/uhGzZEqRSIsL55Cb
	 SHG5DSXjQlQkVHNayd2zE8z9Qu1sFPmBVsh3s0W74jrLmJ+7OnEMMv/JQ2Gy8n2Bwx
	 0g+NfVDYDGhgA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 09:35:59 +0200
Received: (nullmailer pid 175521 invoked by uid 1000);
	Fri, 05 Jun 2026 07:35:58 -0000
Date: Fri, 5 Jun 2026 09:35:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: rootlab <rootlab@huawei.com>
CC: Greg KH <gregkh@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>,
	"security@kernel.org" <security@kernel.org>, xiachenglin
	<xiachenglin@huawei.com>, cenxianlong <cenxianlong@huawei.com>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, Christian Hopps
	<chopps@chopps.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IFtTRUNVUklUWV0geGZybQ==?= =?utf-8?Q?=3A?=
 espintcp: local root via read-only page-cache corruption
Message-ID: <aiJ8XqKKYBhKcK-I@secunet.com>
References: <b576ff7acc1444319371f296e42017ff@huawei.com>
 <CANn89iLrKSJp-w8XEPR4rFFfD=gxwA1ACu5MfzTDELVDOoNDbA@mail.gmail.com>
 <ace944218e2b46c9bf6ba84ade5e3a3b@huawei.com>
 <2026051830-spirited-harmless-57d0@gregkh>
 <ffa0f9112af746d785607d56374d8daf@huawei.com>
 <ahVe2Hm2NZjUMoaG@secunet.com>
 <7581c1462aad449f8457fe5bbee39d1d@huawei.com>
 <bdf734d9a6ed444fbaf2038ae7ef78bb@huawei.com>
 <aiFNRNf6Ukg4WIFu@secunet.com>
 <1a931f75105d405db00c918620b20aa1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a931f75105d405db00c918620b20aa1@huawei.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295706-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rootlab@huawei.com,m:gregkh@linuxfoundation.org,m:edumazet@google.com,m:security@kernel.org,m:xiachenglin@huawei.com,m:cenxianlong@huawei.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:chopps@chopps.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 125D4646215

On Fri, Jun 05, 2026 at 07:30:07AM +0000, rootlab wrote:
> 
> ok, I update the patch and cc netdev@vger.kernel.org.

But you did not read Documentation/process/submitting-patches.rst

This is not the right way to submit patches.

