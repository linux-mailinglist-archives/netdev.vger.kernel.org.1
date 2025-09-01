Return-Path: <netdev+bounces-218954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E1B3F147
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 01:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE088201E7A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35035284B25;
	Mon,  1 Sep 2025 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F8oMa22t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002332F76C
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756767790; cv=none; b=Mub+se11reVfUbqDErTr2GpCa9m6zOu8V1cbseDiH2okOGEzghCjsF23GIGZoQ1cPNUFgAIZQVdpIRGhTu6WiajE7WZ6UzUJStqyWayGxX9mXqAoHv+CegYxj3HN9I7bbbNUMFyFK0dTTgydbNBRURES1ZxhCpC0VNFI25VIJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756767790; c=relaxed/simple;
	bh=eNpkvG6oNo6oNFTwjCSyeCzF7aUEE39aeNlCnxg56LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etqy6RJineEOwyX+dDaWH4CLe0xJOwxyvk2pHQA5acoYw5+BqRJmBkHpkjVNq+Iwx5TYyqUZSwCC393sFMYcxnnnauZ5USmJIt7tHyDdVb1hW8JwzYQHj2C/lLdRJoh6tkF4uh1Sl4ikAkKp8ypuy9MV779OKmyqZvRTJmr96zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F8oMa22t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5YvP9dO/RPsVWSDH9uOBuy9Wrm1CQ/FOTg1OAczgM9I=; b=F8
	oMa22tN31CjxXKjQUWGVovpRNxWnq+DY2t9aZzv6SPBoG6qd9jpfR4i6qgtKa1e2dHF1iJLcjM+gu
	YBwqo4IhNAm+yNQ+UkO0cqkZS1gevleUq1iQbJucisWrFyRZxKZvIo6EABdNY9CqLRAT+7xlbgGVz
	LlJkkTlRn38LUAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1utDYE-006p6Q-N4; Tue, 02 Sep 2025 01:03:02 +0200
Date: Tue, 2 Sep 2025 01:03:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v15 14/15] net: homa: create homa_plumbing.c
Message-ID: <04716a9e-9dad-47e6-9298-5b5cf6efe7cb@lunn.ch>
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-15-ouster@cs.stanford.edu>
 <a2dec2d0-84be-4a4f-bfd4-b5f56219ac82@redhat.com>
 <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmztO1SdjyMc6jdHf7Zz=WGnboR5w74kbmy4n-ZjJHNHQw@mail.gmail.com>

On Mon, Sep 01, 2025 at 03:53:35PM -0700, John Ousterhout wrote:
> On Tue, Aug 26, 2025 at 9:17 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > > +     status = proto_register(&homa_prot, 1);
> > > +     if (status != 0) {
> > > +             pr_err("proto_register failed for homa_prot: %d\n", status);
> > > +             goto error;
> > > +     }
> > > +     init_proto = true;
> >
> > The standard way of handling the error paths it to avoid local flags and
> > use different goto labels.
> 
> I initially implemented this with different goto labels, but there
> were so many different labels that the code became unmanageable (very
> difficult to figure out what to change when adding or removing
> initializers). The current approach is *way* cleaner and more obvious,
> so I hope I can keep it. The label approach works best when there is
> only one label that collects all errors.

This _might_ mean you need to split it unto a number of helper
function, with each helper using a goto, and the main function calling
the helper also using goto when a helper returns an error code.

https://www.kernel.org/doc/html/v4.10/process/coding-style.html
says

6) Functions

Functions should be short and sweet, and do just one thing. They
should fit on one or two screenfuls of text (the ISO/ANSI screen size
is 80x24, as we all know), and do one thing and do that well.

The maximum length of a function is inversely proportional to the
complexity and indentation level of that function. So, if you have a
conceptually simple function that is just one long (but simple)
case-statement, where you have to do lots of small things for a lot of
different cases, it’s OK to have a longer function.

However, if you have a complex function, and you suspect that a
less-than-gifted first-year high-school student might not even
understand what the function is all about, you should adhere to the
maximum limits all the more closely. Use helper functions with
descriptive names (you can ask the compiler to in-line them if you
think it’s performance-critical, and it will probably do a better job
of it than you would have done).

	Andrew

