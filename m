Return-Path: <netdev+bounces-81233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1597886B4F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6BE1C21431
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912A3EA9F;
	Fri, 22 Mar 2024 11:33:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC01F224FA
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107218; cv=none; b=p3DXD3gPRzA2xGN5i88oYEClwZJVNEzReH+ilj+t//zG4Ra4bls6ZUjjdeqO1fDZ+IBInj/TsPh96tdyWueNnjsT/mtVt8QEfi4IqszNZtevntfwBgRaiDo/RIP+FersPtCNq08EBBE0+OuW9FdAXX48u7LGEWRBhTYaJvzcpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107218; c=relaxed/simple;
	bh=WZwNjACrAfYRU0Wf/emw0apbAdsK78eYOk967AMJrOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBw3D/V824Gj8rCFT2h2jZim/cYYMpzpiCvXT1X4aFvzlelj975OqGlvxoqsn+mF8QaXI6qMyTbDACoyOrPcXU9+dHPwwfBS0Ff2o7qxPHZGjWJxKCdCTsSEKrLEpP0uuWTtQVzsmVpKWAhKBGRJ659Div0f1wG/1sufr2+V3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rnd99-009XDY-Tt; Fri, 22 Mar 2024 19:33:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Mar 2024 19:33:32 +0800
Date: Fri, 22 Mar 2024 19:33:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
	dtsen@linux.ibm.com
Subject: Re: Cannot load wireguard module
Message-ID: <Zf1sjAgBYCnJ7JEp@gondor.apana.org.au>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse>
 <87r0g7zrl2.fsf@mail.lhotse>
 <20240318170855.GK20665@kitsune.suse.cz>
 <20240319124742.GM20665@kitsune.suse.cz>
 <87le6dyt1f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le6dyt1f.fsf@mail.lhotse>

On Wed, Mar 20, 2024 at 11:41:32PM +1100, Michael Ellerman wrote:
>
> This diff fixes it for me:

Yes I think this is the correct fix.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

