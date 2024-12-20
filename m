Return-Path: <netdev+bounces-153807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E0A9F9BCA
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D9018899D7
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1121225A4B;
	Fri, 20 Dec 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pWwlBO93"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262722236EB
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729498; cv=none; b=n3FNqUCh3+iYtaf+E4WzcN1NjdNaPa7HjruWpZmV7CuCDA8giifhkwCoemGp22sVf05+U8F581B+f41KIPFayZwlETVZ7UejnWHHioEzafQYeI4pnLJkCsqvm0EOM3GVFLA5c2hNWtYWrUWIyWOx7L8hdiaw9tYTfoedUwjzK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729498; c=relaxed/simple;
	bh=bu2es6nORC8JKMNPX1MjOM4HAst1UXKhN52efr1UnpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnpve9u78wg4KSQ17UkoSQWT7io2eBULg6BDyMD4YhS1Oq6PlxpN4NQCEHtXAbDjYhaqtjAkTRrYX6WBbqcS9Hq8iAoKVqPShEryF71ecF1pKJkwgpl0IYVNmDZgNdlvxUlJclXbNtYRl9bE80qAi8U/Oc3FRZXC/4J79FxIlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pWwlBO93; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=x5PM5i8YvzbmNcvuCWzwiwfgZ5lT1CXnOqDs4ougUxQ=; b=pW
	wlBO93zmZ38L9F602D47N1l/ObG0J2v+/tq9mPDgfEtQbUzKRW7507CSBC/HP7JN9MA+HPAgw2yC9
	fIKXIMd8wZHF3jKaAnIcmrFGaFZrMRNK+Yy4bv8UVOH/okn6ijYId0GnQkff3wyxNfNb6itm0IV2o
	WRzAv72yMKtdlUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOkNu-0027DF-LT; Fri, 20 Dec 2024 22:18:10 +0100
Date: Fri, 20 Dec 2024 22:18:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API
 for Homa
Message-ID: <98864170-ac97-43c9-b8b2-39fd02ac198a@lunn.ch>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
 <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org>
 <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>

On Fri, Dec 20, 2024 at 09:59:53AM -0800, John Ousterhout wrote:
> On Thu, Dec 19, 2024 at 5:41 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > > Any suggestions on how to make the header file work with C++ files
> > > without the #ifdef __cplusplus?
> >
> > With the little C++ understanding I have, I _think_ the include site
> > can wrap:
> >
> > extern "C" {
> > #include "<linux/homa.h>"
> > }
> 
> I have done this now. I was hesitant to do that because it seemed like
> it was creating unnecessary extra work for anyone who uses homa.h in a
> C++ program, but since this seems to be the convention I have
> conformed to it.

Do C++ programmes directly use this header, or is there a library in
the middle?

Often kernel APIs are too low level for an application to use
directly, and a library is used to provide a higher level API. That
would allow you to provide a different header file which is more C++
friendly.

	Andrew

