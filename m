Return-Path: <netdev+bounces-285152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECxPCy8p/GmXMAAAu9opvQ
	(envelope-from <netdev+bounces-285152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A16574E3444
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 07:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C4F301A3AE
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CE30C631;
	Thu,  7 May 2026 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NcS4O5M9"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0593E32ABCD
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133275; cv=none; b=HXIFpY7oByD9ZDUQNfTq5VaWloTWorOOxXt0dysiLUqwyQFesX0CgFG2KZjJ3PVL8zZenoozLRL1KrEWxixFw9A6EQER0d+wUPS3zHhMXEHXF/CMUGIQe87YDROa6c3Aw+vi5aDJ6WJBoA8qvnkg+pLUcCz9W5vWDFSmodvoS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133275; c=relaxed/simple;
	bh=ahllHU4EtM98J0LeAI/a0+L7phqoCz3qZN2o7fF+VWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdmynkHKT0PPvSCTLX/0QxbMS72PIkp1vGUH+Fb0sQi1ZxmyXByZw4pNdRFfM/Bce2XYOyy8+Hixs1Jiegx5ualr3DMZEBpKWkE0XI2sNdvq3QefFZFkT0pVF5ZNuFaam0+VKXByep4PdpWoNx2g80tRdyge3ChRYMta8INZVW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NcS4O5M9; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7B461207A4;
	Thu,  7 May 2026 07:54:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JeSzXMcnyuAc; Thu,  7 May 2026 07:54:32 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id EC5842067A;
	Thu,  7 May 2026 07:54:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com EC5842067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778133272;
	bh=5UmbbemK2mU1HiIKGzZLhaJEIKdEZ0Nrelq/0w9MXnc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=NcS4O5M9Rfr5kyw/rkzwuMCeDTMjUPWLPzmhubyI7AQDa0zThrm9SjXKlLIc/SxdH
	 uIc/fDx/y3LuYrtB4OTlJG8YisISWmenEc14PtMqyj4Je5AVSxeZOwaZU19MeopZQH
	 PzTP0z5W0KjVZZeEWCaHE5cA71G5VK57KfmbBd02ZgJG07SdMvI6g8IvrTKmrhXCAE
	 P5r3boT0px2DH3yFA6Z/ZaepF0dIe65MhggLbjp3VExpWe0MhXqJL/lG6kQHkprqY6
	 XSyqdRYuotO2oh7jxC6k1n5CpXrTrHH0wWUCWKoGD3FFgcq9U5G97tSfHX0q7A7ED6
	 o06GjNsKtWL/w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 07:54:31 +0200
Received: (nullmailer pid 1287318 invoked by uid 1000);
	Thu, 07 May 2026 05:54:31 -0000
Date: Thu, 7 May 2026 07:54:31 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/8] tools/selftests: Add a VXLAN+IPsec traffic test
Message-ID: <afwpF5ItRQ5Bjc9e@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
 <20260505132326.1362733-5-steffen.klassert@secunet.com>
 <20260506170435.34984dfc@kernel.org>
 <20260506172310.64188c0e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506172310.64188c0e@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: A16574E3444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285152-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 05:23:10PM -0700, Jakub Kicinski wrote:
> On Wed, 6 May 2026 17:04:35 -0700 Jakub Kicinski wrote:
> > Oh, sorry, changed my mind we can't pull this:( both the Makefile and
> > config break alphabetic sort, our CI will flag every incoming as red 
> > if we merge this as is, we need this on top:
> 
> Eh, let me just commit this and move on..

Thanks!

