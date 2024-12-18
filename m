Return-Path: <netdev+bounces-152925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AF9F6572
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64611887088
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371991A08B1;
	Wed, 18 Dec 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="FroTQ6+M"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FD19F422;
	Wed, 18 Dec 2024 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734523163; cv=none; b=oGu3/J5r+wuzxF8K/F8kMUo1buTgHF8D1dFBGgl0oxSc/cxGprE5IbLR1Vx9m8h180iJKJPDiH59A622wF5aBFCpRPSBfnUB2BBANJj1x5F3xz1OBgaugoTJi2z5dv7EY/o66CK3z6gVZp3hQSI9GCdjyEVlchozAxa8IFiNW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734523163; c=relaxed/simple;
	bh=yiZT+zgyBtvbWw8XjBXECMyehJBWlJrNl0wBu4Dp3Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVknND8n/o0EtShCc/Lj5gWYnrFC/JilTDGcEDAVUx53h/hmSSoDYcmJxKjflNGGP1TQzMBCD/XEtqUOYYqy244ZMUAAkiFMFZa8IdsQNeZ2oIeF8at0Mqf0R9WzyDhRhro74+KPUL/7zfOllt9gyNI5XOpkaN/t9TRfJ89sWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=FroTQ6+M; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OW0y2IpzhJkNdhWNb/VkJVFWXHp4qHaaxBGPF8TsTeQ=; b=FroTQ6+MO2zH4Tnv0PwtHxLm+Z
	kF2riz1rloEbUK2wa/95HBqJyQhsfEkPOPo98XIDGtHiEzweDJ77JUrfvwXl9xDOKx8WZ+tTZznEF
	YaiMp1J+qjWFY09HS634oc9ySK1hEMov7wzMunOj1p44Sh5NR/vlkLQnDaS9OUkgh5oW/7B/FpqLo
	wzxipY8DH+fS+MgmhbCYvF5hqkkh2DQq+1t0ATrkSkSXGgVY1kJf21lTYnJnobvtc8XJosUHfVFxa
	bFeflCcwb/o/gBJCS0+wQ26wMqE2BhaDHu3G+Ln934MLc1aCmV3KYQd1eTZTG4iuDh+tn4RXtTixy
	3yie2/OQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tNsUl-0029Cl-0H;
	Wed, 18 Dec 2024 19:59:00 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 18 Dec 2024 19:58:59 +0800
Date: Wed, 18 Dec 2024 19:58:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net] xfrm: Rewrite key length conversion to avoid
 overflows
Message-ID: <Z2K5Aw2Mma9Crr1G@gondor.apana.org.au>
References: <92dc4619-7598-439e-8544-4b3b2cf5e597@stanley.mountain>
 <Z2FompbNt6NBEoln@gondor.apana.org.au>
 <053456e5-56e7-478b-b73e-96b7c2098d07@stanley.mountain>
 <Z2KZC71JZ0QnrhfU@gondor.apana.org.au>
 <cedbaec9-d149-48af-8068-182f0af5a89c@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedbaec9-d149-48af-8068-182f0af5a89c@stanley.mountain>

On Wed, Dec 18, 2024 at 01:54:38PM +0300, Dan Carpenter wrote:
>
> The length is capped in verify_one_alg() type functions:
> 
> 	if (nla_len(rt) < (int)xfrm_alg_len(algp)) {
> 
> nla_len() is a USHRT_MAX so the rounded value can't be higher than that.

Good catch.  I hope a similar limit applies for af_key?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

