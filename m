Return-Path: <netdev+bounces-26716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915E778A63
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A3C2816A5
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94F863C0;
	Fri, 11 Aug 2023 09:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AAC5690
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF87DC433C9;
	Fri, 11 Aug 2023 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691747593;
	bh=u8bULopGztMMXDUlY34aexEHjdKcFlVqp4+mps7Hlto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEOfoWwsm4u+avTAMjCNM0I+BhgmX40uO3SjypS0LkfWEUPy8/g1TP4OsY8FKKA9m
	 6AxfVr6mhqMLui/q9ltAbQ18+1lKb6rsrlNRdzneE30y/7R+XBzFsUOIwIM/dKWg2W
	 oWRPkGIAoWLz/tdjJ3DA//54n1G+cxlcCnL8ddkgH+PKoDNfwi/t0ysoL7u1bT+IMh
	 ii/0+V68aIgH237ARY7hfSt9bBkELa2gPwkfOOd9j96NrbrEmXBRddqGs+rBR+pfvH
	 JFSE9vw0gOsPI+87/XqNMFVEUnjzBGLmdItaiEsIpwyJcujJGyr2xXNpJeKIq4MJpi
	 RQGENS8CgQYGA==
Date: Fri, 11 Aug 2023 11:53:07 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: Simon Horman <horms@kernel.org>, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	rdunlap@infradead.org, void@manifault.com, jani.nikula@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] docs: staging: add netlink attrs best practices
Message-ID: <ZNYFA6CbHHQdAAsd@vergenet.net>
References: <20230809032552.765663-1-linma@zju.edu.cn>
 <ZNTw+ApPS9U4VhZI@vergenet.net>
 <41722e43.1049b3.189e02f50f6.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41722e43.1049b3.189e02f50f6.Coremail.linma@zju.edu.cn>

On Fri, Aug 11, 2023 at 12:02:24AM +0800, Lin Ma wrote:
> Hello Simon,
> 
> > > Provide some suggestions that who deal with Netlink code could follow
> > > (of course using the word "best-practices" may sound somewhat
> > > exaggerate).
> > > 
> > > According to my recent practices, the parsing of the Netlink attributes
> > > lacks documents for kernel developers. Since recently the relevant docs
> > > for Netlink user space get replenished, I guess is a good chance for
> > > kernel space part to catch with.
> > > 
> > > First time to write a document and any reviews are appreciated.
> > > 
> > > Signed-off-by: Lin Ma <linma@zju.edu.cn>
> > 
> > Thanks for writing this up, from my perspective this is very useful.
> > 
> > Some trivial feedback follows.
> 
> Thanks sooooooo much. And feel really sorry that the v2 still has so many
> typos, grammar issues, and word misuse. I will prepare the v3 carefully
> with all those suggestions. Really appreciate that.

No problem. Much of my feedback was subjective.
And Randy managed to spot an error in my feedback too.
It's hard to get things right :)

...

