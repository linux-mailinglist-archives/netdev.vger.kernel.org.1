Return-Path: <netdev+bounces-99323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB88D4760
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CD8B22D15
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F2E17619C;
	Thu, 30 May 2024 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="decvkoUh"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BF17618F;
	Thu, 30 May 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058539; cv=none; b=YbPp4Xsdv9z/zHNxGfE+cswOR1sDlzZ/H2Dg3VLJsuDOMoCP3QCkJqYEpWKZiZhjm9/B/nFJJgyb6mAzdQNlAfI+FxIUnpXHXndjZsrDwU1FXUn5jkpuOj/SH2Xlx5IBRZ3QurtFOZ4yzzvmHkIoIi53QyIvFpGulbZXZl9cJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058539; c=relaxed/simple;
	bh=ccfTa9kgkRhsQsZ00GPmyDzIklduifKIaXc5PbcyPds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h60mue8R+D9Mglu95q8j15Gr4mGr+w4pPkH97/t+kEWZ4oJJ3UgJ8nYsrubMvRdpYYTjIpTJDxPLGRdLmTY2JVO6siEN1cPlNTkqQ6W36tL3XSuzxQeO4bYhsIbQ2UV+7uoA13PHOo4zF8d7es2XiY9EOlEKyEgcxke6t0Vd9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=decvkoUh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.2.60] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 48FC22012A;
	Thu, 30 May 2024 16:42:12 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717058534;
	bh=ccfTa9kgkRhsQsZ00GPmyDzIklduifKIaXc5PbcyPds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=decvkoUhi3BQsNXPWdEwki3kHb6All/6KACr4gdMzoBerw0hEoFmoQ7gFuz/HW1Ji
	 D5/r0ziKW87Gt2NQW8uG9ZlIff6uwwvgTqCoe+goyxeFy0KjPYNE1TM+BN6eDOKT/T
	 ZbpoFSBPydvBVgvOXZfV/3c9+E6LXTweDGkjejPxhqCdCz9CL5bkegZEWOphC0mjGp
	 7bCkFGrqSqoRphTvR3tw/P5wgECdlGyScW3hdBlNLnyWQOzQlSfqizbwua4JwjPmHq
	 biSiOssLUf5iVjKWqJzKRMkFy5Ocr6USAh4NasYPmEnTBgqe6jskYkShhfVPaC3mYH
	 z5gNo9FbkZL6Q==
Message-ID: <a9f559ac6da9e44cdcffe1cb80a4468096efb1f8.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: Add rx trace
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Tal Yacobi <talycb8@gmail.com>
Cc: matt@codeconstruct.com.au, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Thu, 30 May 2024 16:42:12 +0800
In-Reply-To: <CAN7-cG5w9rjhJnDJJSOTiopxkj75mOJEC9eKZqmJaqbeMudPQQ@mail.gmail.com>
References: <20240528143420.742611-1-talycb8@gmail.com>
	 <520cf8db945cf8dce4afdaddb59ceda65463a406.camel@codeconstruct.com.au>
	 <CAN7-cG5w9rjhJnDJJSOTiopxkj75mOJEC9eKZqmJaqbeMudPQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tal,

> > > mctp-i2c rx implementation doesn't call
> > > __i2c_transfer which calls the i2c reply trace function.
> >=20
> > No, but we can trace the i2c rx path through the trace_i2c_slave
> > tracepoint. It is a little messier than tracing trace_i2c_write,
> > but
> > has been sufficient with the debugging I've needed in the past.
>=20
> Oh, I missed that.
> I had to test it with an older kernel without i2c_slave tracing
> so I looked only at the regular i2c and mctp trace paths.

OK! That tracepoint was (coincidentally) added in 5.18, same as the
MCTP-over-i2c transport. So we should have coverage for both features
on upstream kernels, at least.

> > > Add an mctp_reply trace function that will be used instead.
> >=20
> > Can you elaborate a little on what you were/are looking to inspect
> > here? (mainly: which packet fields are you interested in?) That
> > will
> > help to determine the best approach here.
>=20
> Sure, I basically wanted to trace the i2c packet buffer in a simple
> way.

OK - did you specifically need the i2c transport headers? Since the
MCTP interfaces are regular net devices, the easiest way to trace
generic MCTP transfers is generally via a packet capture (tcpdump,
wireshark, etc).

Cheers,


Jeremy


