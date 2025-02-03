Return-Path: <netdev+bounces-162198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8FA261CC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA351658AD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0F20DD54;
	Mon,  3 Feb 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sjSngrha"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165C20CCD3
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605511; cv=none; b=BOM9bY3Z3bslsrAjbPn3nhWM61AXeDLVWw6FF5Vb/0tmn+6Fbeqm8j4hNeHxAwO/MfEwVFwZA8DeP10YmcfdiAqHyDTdaBKd9Mr2lx9xAkaWhE8sp5E7pCsKo6WpP9YJfhIjkM0y18N0LK1MIFLNlErhp2nC6+ONnDhkxORtUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605511; c=relaxed/simple;
	bh=nfyDnJUGni11z0oWXRMbK+y5HEKjgu/eIh/E3XCVZgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGEAl/ZNdmAE+FWdNiCeElNqQKzUEX2F8ad91nY+CC+DX6d0hWLWGO+C8adGhlrdcRm5bQ+2FeldWIQ6N2xF2NcKSCdapZm7BwmhKzRgnKIXnlVsv7A7026YOyQkzqewfCYVlL35qc04hGcUSgR+UM/wKKXmHxaZBnCqu4bc5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sjSngrha; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pfrYAbTXz0bcxfa238vFS0a00vgAybaX2TUqcspwZUk=; b=sjSngrhaKszGpAHpoWgJ4Ypben
	IEYwlIpJXdE9pVkHhh7PjxkDzoEy0IZF/QicqaFKZaP1h9ZmHqAo6uDmbgUI6Gn00etjZToBdN/+D
	AWrREDGkkGvThEsea+bMJ7xq906WrylZa86xQ60mkMloHe29rQHmL5vGH0mVA6Q67+74=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tf0i9-00AbGU-2b; Mon, 03 Feb 2025 18:58:17 +0100
Date: Mon, 3 Feb 2025 18:58:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v6 08/12] net: homa: create homa_incoming.c
Message-ID: <9a3a38c2-3752-4ad2-a473-4d8f47ce7bc6@lunn.ch>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-9-ouster@cs.stanford.edu>
 <9083adf9-4e3f-47d9-8a79-d8fb052f99b5@redhat.com>
 <CAGXJAmxWOmPi-khSUugzOOjMSgVpWnn7QZ28jORK4sL9=vrA9A@mail.gmail.com>
 <82cdba95-83cb-4902-bb2a-a2ab880797a8@redhat.com>
 <CAGXJAmxLqnjnWr8sjooJRRyQ2-5BqPCQL8gnn0gzYoZ0MMoBSw@mail.gmail.com>
 <e7cdcca6-d0b2-4b59-a2ef-17834a8ffca3@redhat.com>
 <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmx7ojpBmR7RiKm3umZ7QDaA8r-hgBTnxay11UCv42xWdA@mail.gmail.com>

> > > If that happens then it could grab the lock instead of the desired
> > > application, which would defeat the performance optimization and delay the
> > > application a bit. This would be no worse than if the APP_NEEDS_LOCK
> > > mechanism were not present.
> >
> > Then I suggest using plain unlock/lock() with no additional spinning in
> > between.
> 
> My concern here is that the unlock/lock sequence will happen so fast
> that the other thread never actually has a chance to get the lock. I
> will do some measurements to see what actually happens; if lock
> ownership is successfully transferred in the common case without a
> spin, then I'll remove it.

https://docs.kernel.org/locking/mutex-design.html

If there is a thread waiting for the lock, it will spin for a while
trying to acquire it. The document also mentions that when there are
multiple waiters, the algorithm tries to be fair. So if there is a
fast unlock/lock, it should act fairly with the other waiter.

	Andrew


