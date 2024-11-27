Return-Path: <netdev+bounces-147548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E29DA1AD
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E5DB2143D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C713B590;
	Wed, 27 Nov 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="CEIwO/P8"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F329CF2
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732684751; cv=none; b=OH1pBvSSLjRtfMCKsJrw2LI7J2jU1T76z0CseskVKhA9oydZUwD8cfSwhLQBsAUp9szSAJu+t5iSNKjA2BthtCIcSQeW5iwbQtG9s9I3BDOdkopzanJ8C3/6ygNdhzPHP4ulcvA9vODvpHSSanQDuCg6kaXCMfEFYdj5JK4iQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732684751; c=relaxed/simple;
	bh=L6//DIAZpHPBSVR9Brc4fovOE/zCzkZbLQFpWviOWRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBGHVVuwU3vD5fhm6t31D04UyESD+/kFRdCY1Tnu6bH9TFZzP3FaoDNhpW85PQGVr5HaTv+Ex1fDEAmxq5nzN2YDdjkF72UACh7QagfwsR5jliW9vkGFYCJHcmgTRtnzRtfxPSGENxds5WHSGco7+afxMDeTl96t3XhrUcJEFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=CEIwO/P8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HNKiX1vZyfymNM0GaQCO5Zzt1DR7noI0ThowlsrFM8c=; b=CEIwO/P85CmRtylXhjuHbSrFkp
	wtjfxopd+OU+tPlBUay2ftBuI/rI3FJO9rMJ2wZCwfdDAQ0hfWEAFuGr2fqQXu2XTSzJ/l8YJxXXg
	yXnDouGtQJ0mRKq0XKfXqNFbzyY0LlqMIrc6M/c0fpubc0sOg8oT7QzZXfBz8+KPcw3MBxDqpO9XR
	8QGG0cbZ/Z72RHN0vGOdWLj8wYTO0+GtVCSPQAtpzhEUvIYktVVSY7FloBepFqivK/d0V6OUsWWeH
	Fj7ma/TFTK21mPxiFX09dXnCs6qNiswbAY6ZCaqRJYt2Z464qnvseC/bgzHqkZp12Z4tii1wk1bur
	xzbv5Lxw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tGAS1-001uqs-1f;
	Wed, 27 Nov 2024 13:18:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 27 Nov 2024 13:18:57 +0800
Date: Wed, 27 Nov 2024 13:18:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0arwVfOKlTGKLER@gondor.apana.org.au>
References: <>
 <Z0VQZnLaYpjziend@gondor.apana.org.au>
 <173268458312.1734440.13279313139938918812@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173268458312.1734440.13279313139938918812@noble.neil.brown.name>

On Wed, Nov 27, 2024 at 04:16:23PM +1100, NeilBrown wrote:
>
> And that is what my
> 
>   https://lore.kernel.org/all/152210718434.11435.6551477417902631683.stgit@noble/
> 
> was designed to do.  If you are willing to accept something like that,
> I'll try to find time to write a new patch.

Let me resurrect the insecure_elasticity parameter, and I'll
try my best to root out any insertion-path errors and subjugate
them all to this setting.

Hopefully that should make you happy at least :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

