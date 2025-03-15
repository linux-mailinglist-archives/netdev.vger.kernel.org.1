Return-Path: <netdev+bounces-175018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EAA626C2
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 06:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E10CA7A74AE
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0939318C031;
	Sat, 15 Mar 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="qL2/rjVw"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFC10F9
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 05:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017739; cv=none; b=Z3kn+asmSodn15x/T9YA6pK9oiBN2no8NcBdjgmovzb+hJTstOUlT1iPG2895ED78Vmmp7ykB+IxpEdf+YP0I0NLs/oJGlccGKxrWrRaMeEB8cTE66dlWt9vDt1sC/fvC09OmeSTndRbzc89XHROIxa5JZDlcJiPMaomVtlWPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017739; c=relaxed/simple;
	bh=TAtqdHcRlaf9BoLjYAvseB80Q0ue2o37eIO9UBC23H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMy3sg5nORc4TvQZKF3jhTBDjtlbpnsWDuMHYIG0WXirkWgLmC+LlxFyjrfrBcsLDkf09gBScVYa+X1vkqe4mS0kxS2g8pZTaCNweRixLJn71ntr/q+joySb62Cn6a5drIFQJg9e1E9G/obpOzCi65qA5GkOWa9jese3pPJvOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=qL2/rjVw; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fXRjQFI+YyAvgdKnsYqeb2j33xZsRftOITrlK6ehQAk=; b=qL2/rjVwqMvtTIvJuthaapcDQn
	piimI3CCuW0LLtpkcU5XWXfjFFIuO88UieaqUJ0HpPpjLVbQosVSsjzctvovZO2BpbQ3Q95BZnWVM
	gheJlErFXj5PWXVGJ7eAdIrJNIrbYPgPZu9hfdlFrHkTrOBbOpYHnDYG51sOusQKhOJL64SdKVK21
	jQblHzULa2bbysrG4u5BvohStQXE5bg8O+niiP6x59kP6/atUfcOJ3PuFCpvc0aZAKll/QQgoJYSb
	y/OwarCSFmx4rc6VjgGjKzNEARn+8g5YoWkbUhIW6tfTL0xWxNj/mKI9wtVCWSQorggSe27scV/Os
	0Y4bnyNA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttKOD-006mJs-1g;
	Sat, 15 Mar 2025 13:48:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 13:48:53 +0800
Date: Sat, 15 Mar 2025 13:48:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
Message-ID: <Z9UUxb2dclH9hrWo@gondor.apana.org.au>
References: <Z9KTIYVFwEIYXgd7@gondor.apana.org.au>
 <Z9T3V/M0hXIiHsLB@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9T3V/M0hXIiHsLB@gauss3.secunet.de>

On Sat, Mar 15, 2025 at 04:43:19AM +0100, Steffen Klassert wrote:
>
> This looks like fix, right?
> 
> Can you add a Fixes tag so it can be backported?

Sure I can add it.  Do you mind if I push this through the crypto
tree so I can base the acomp work on top of it?

I'll push this fix to Linus right away if you're OK with it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

