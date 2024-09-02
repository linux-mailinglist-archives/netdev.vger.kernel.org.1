Return-Path: <netdev+bounces-124213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AD396892D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912EDB2039A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 13:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12F920127D;
	Mon,  2 Sep 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="CuAMm6Pn"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCE19C540
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285155; cv=none; b=rwtBUV9DzNscOn/ffgjT754L9WvuCxqe0mB8rD5flPZKQXr24Micw+iAn8db6XuSYmHDJnn1p3zZURTE987hYz0TMKGBiV8Sdd1G+K2DYVqhqQpA/Kh6lFkT8/hhAGEy0kaLdSuBGWcINd2+C9YLY5B1Y0RW99cDtWmKpgTnI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285155; c=relaxed/simple;
	bh=YObB5qCttvHQvd99nO47j1posUGg6lmOUtOZV7nMpYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEF2J5+nG4V8EMs7GVZOjAPTLPl91D9qwEwOoffawOytaouX1bQV5vqb5pR+Bm9ESgXEBdioFtjabT+j1ocCN3r35pJsKwzq4lK8KzqKLesNkyD++CDPDjtx1K7W1kzJZtGAyp3wLpgrufnpP3Cp8ci8HYEAOA0cJaMZr2ubmn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=CuAMm6Pn; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 94696212-6932-11ef-895b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 94696212-6932-11ef-895b-005056ab378f;
	Mon, 02 Sep 2024 15:52:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=5RoesgltgmKLJiIo3lCrR93UdF0x54gulukpBwybFUw=;
	b=CuAMm6Pn+RRS9nAsjg1oSX4gS6lA6EhPXQ8JJCs9DtTYXe6PrR8MY1eGrqxIISZufEvdaz/RhPOgW
	 MBm+9WceWG38m5Pr9F5X+yRjstp7fRqbTJF7OcRJbgGLXutV8iTtnQNG/lwZ2Beg16iiBA9RO1U1RE
	 UimxAX6GWai1BKvI=
X-KPN-MID: 33|E1Y9n33RHbMdhsIEcP27lj9ctr/CEBTjkrsEmxveJdy8iIOioFuWlDWAnR3bvSC
 3tmt5U7dp2MiOclQMBzyYcRDtuM7EhWnL1mP6lc1J7j8=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|TBJMljmR8PWG8tVlxztISZt8osl0xwL6nRUksFOD7DFzHKoMlscxlvL9MO43GbK
 Vt1XkTURJfvLumpNRnis+zg==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 93cc4229-6932-11ef-99a1-005056abf0db;
	Mon, 02 Sep 2024 15:52:23 +0200 (CEST)
Date: Mon, 2 Sep 2024 15:52:21 +0200
From: Antony Antony <antony@phenome.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	dsahern@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [devel-ipsec] [PATCH ipsec, v2 0/2] xfrm: respect ip proto rules
 criteria in xfrm dst lookups
Message-ID: <ZtXDFWpPVdlNE8NP@Antony2201.local>
References: <20240902110719.502566-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902110719.502566-1-eyal.birger@gmail.com>

On Mon, Sep 02, 2024 at 04:07:17AM -0700, Eyal Birger via Devel wrote:
> This series fixes the route lookup when done for xfrm to regard
> L4 criteria specified in ip rules.

Hi Eyal,
This isn't a review of the patch set, instead curiosity about use cases.
This sounds interesting. Would you like to elaborate on the use cases 
supported in this patch? From what I understand so far, it seems related to 
'ip rule', but I'm wondering about possible use cases: inner packet routing 
rule of tunnel? May be you could explain it at the IPsec coffee hour or 
share some use case or test script.

Is this only for route based IPsec, i.e. with xfrmi interface, or also for a 
policy based without route use cases. In the later case there were 
discussions why do we need a route for the inner packet.

-antony

> 
> The first patch is a minor refactor to allow passing more parameters
> to dst lookup functions.
> The second patch actually passes L4 information to these lookup functions.
> 
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> 
> ---
> 
> v2: fix first patch based on reviews from Steffen Klassert and
>     Simon Horman
> 
> Eyal Birger (2):
>   xfrm: extract dst lookup parameters into a struct
>   xfrm: respect ip protocols rules criteria when performing dst lookups
> 
>  include/net/xfrm.h      | 28 ++++++++++++-----------
>  net/ipv4/xfrm4_policy.c | 40 +++++++++++++++------------------
>  net/ipv6/xfrm6_policy.c | 31 +++++++++++++-------------
>  net/xfrm/xfrm_device.c  | 11 ++++++---
>  net/xfrm/xfrm_policy.c  | 49 +++++++++++++++++++++++++++++++----------
>  5 files changed, 94 insertions(+), 65 deletions(-)
> 
> -- 
> 2.34.1
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

