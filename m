Return-Path: <netdev+bounces-160882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 981C4A1BFF6
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 01:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B321188B56F
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 00:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36B25A637;
	Sat, 25 Jan 2025 00:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tqY1IWPm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838410FD
	for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765977; cv=none; b=i0ef1l6vr8R+XHa5NJtrWpjmU3UuCEXObshFBqlAtfSHvpapZLDkGkbFa4qgBgBrDtfQs6KIK+FjH/zl+Znw/7ljwdZ3e2e7EtyJT9WtvAsKbpu+PpkQydOoc/n4CJcG1O4yI03W8bEqYrGi3/shylWaIWplmwz9j+vSqWjDCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765977; c=relaxed/simple;
	bh=0+3p3kH9CNLLrcqv0eIBiuC9IyMdh49AOIj1pF356oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NalvDykuIg1ljVkU3WmeZSRpYP1WE6VQHrRo/OxkeNdbFORfNZ5FDpMQubf7JsAYiDk7LJrFkAPdLIawIA+yK8NZCzz8mboqQgXVd1IsmD4JTJEZmto5MNTbCbEeSbkIQFvEdwxHE5pqg4cXmPKcydZ1olkab3S2WWmISqT+JCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqY1IWPm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u1sGOwah1Q8I15RK0F+/kBbggHwHbUNoWphQV4slxH0=; b=tqY1IWPm3aHKBa20T8Z55t4Bfu
	PkEXI4hT4Yeo79ar5dO5MNgQi8LErYefqjxgww/aYbYFyEy/avzHw3EuVgMfMsyePd0vzbusHqrLr
	ISRlv5g1ichPG/ex9R4HfOquQV9JMsSl5bpkDY82l1IonrUwJExyfrU4A8zufDa+4qD0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbUJG-007njw-F4; Sat, 25 Jan 2025 01:46:02 +0100
Date: Sat, 25 Jan 2025 01:46:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v6 04/12] net: homa: create homa_pool.h and
 homa_pool.c
Message-ID: <c5a5f0da-f941-4818-8dd7-b181cbfdca30@lunn.ch>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
 <20250115185937.1324-5-ouster@cs.stanford.edu>
 <a39c8c5c-4e39-42e6-8d8a-7bfdc6ace688@redhat.com>
 <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmw95dDUxUFNa7UjV3XRd66vQRByAP5T_zra6KWdavr2Pg@mail.gmail.com>

> > > +     homa_sock_lock(pool->hsk, "homa_pool_allocate");
> >
> > There is some chicken-egg issue, with homa_sock_lock() being defined
> > only later in the series, but it looks like the string argument is never
> > used.
> 
> Right: in normal usage this argument is ignored. It exists because
> there are occasionally deadlocks involving socket locks; when that
> happens I temporarily add code to homa_sock_lock that uses this
> argument to help track them down. I'd prefer to keep it, even though
> it isn't normally used, because otherwise when a new deadlock arises
> I'd have to modify every call to homa_sock_lock in order to add the
> information back in again. I added a few more words to the comment for
> homa_sock_lock to make this more clear.

CONFIG_PROVE_LOCKING is pretty good at finding deadlocks, before they
happen. With practice you can turn the stack traces back to lines of
code, to know where each lock was taken. This is why no other part of
Linux has this sort of annotate with a string indicating where a lock
was taken.

You really should have CONFIG_PROVE_LOCKING enabled when doing
development and functional testing. Then turn it off for performance
testing.

	Andrew

