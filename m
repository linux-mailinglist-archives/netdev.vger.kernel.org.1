Return-Path: <netdev+bounces-157960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50BA0FF29
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C67F3A484C
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2782309A4;
	Tue, 14 Jan 2025 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="XVo4zAoi"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C86231A48;
	Tue, 14 Jan 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825053; cv=none; b=sCdoEpBEPZA5MhJRAATSmQFb+eG2WbARYvobeNW78rT+kR5+ScUwn7rizqt66XVjvXTEd78E4fIwBx8jioIx68rXS9VeRA/h7+OpyelI/j0CY0NsrDPityJtbU/tp7ZB4psrgJ2M7UDp/GTfCIkuYZ0M4UAYpStnyOg1+NsGKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825053; c=relaxed/simple;
	bh=5eB+v5y7a0S7ozASMJhJBZW6/n1IaNxrt/MFjsqxWJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T14Sf8Kf4eFXCbu7WXM+l6NjZA3K6fbndOPEE73WJ5jqm0OcPYw1+Ek+ARcR0488503+dGonOzVyBbKFz7eNImGjvwIl6Lb5Bs58+8P6c7JGiG8pjLUN2pnNC16jtPT57QyCEjjFZiG2o5UhQgrRJ2dwtCPxg+nNKgH+GpqE9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=XVo4zAoi; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=m/L7P+qbDs+wGT6qC6Jzb9UGmeaK50Kc/N50docTS6E=; b=XVo4zAoiyt9SieJM+3CKhNVidz
	2tVB6liBKtWp65ucOvXT172qF7Wenh4uIh3G/LRb16mHg7fCt0934Cbt6TcgZeddN20wYvmiqOMfb
	m3Of1ogSPvMaX4pORktaUUzIomZcBVY5xNWlW6FinuhvizMMUtRzcillYAKsZ87Wx2pgQWQZ3OaRK
	Ew9T9mqdHyYK+F24OP2hkrpZsFjvY3FbivSBMzMLxuV7XIy5XOOryhwkAUUkcEN+Nzoolp4y6l0qj
	NGNartVZfCz8qNWcO901ND4A/U3Bsm4CVFQAmDixPdHURlgWPHWbBxU2Eg4ZAdZVenHQqN60xCe6L
	aZRx/lyA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tXXJv-008xH2-1d;
	Tue, 14 Jan 2025 11:23:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 14 Jan 2025 11:23:44 +0800
Date: Tue, 14 Jan 2025 11:23:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Breno Leitao <leitao@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>, Tejun Heo <tj@kernel.org>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z4XYwOeZv8dexDm5@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <6a0b432d-284a-45eb-991a-c7bba2c93e0b@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0b432d-284a-45eb-991a-c7bba2c93e0b@roeck-us.net>

On Mon, Jan 13, 2025 at 11:50:36AM -0800, Guenter Roeck wrote:
>
> With this patch in linux-next, I get some unit test errors.

Thanks! This patch should fix the problem.

https://patchwork.kernel.org/project/linux-crypto/patch/Z4XWx5X0doetOJni@gondor.apana.org.au/
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

