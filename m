Return-Path: <netdev+bounces-182305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437FA88731
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF41888AE8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8577923D2BB;
	Mon, 14 Apr 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nAXG+lJU"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609F252287;
	Mon, 14 Apr 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643880; cv=none; b=uu8UTj0ZS6eM3egTjQm6sl6TzIuaUxI24zRxWZPUbxX1pkq1SgRfLnegAvSzpgGUxkks/h1rLgLoNLSKqG1YPlDMWpGIoWPiVUDisNmaZKdariPvEjLs5Y+irVof5n1Uu+Q8wA2pCSS5Ty/eA87F/J57lyap8eteX2e6uxLU738=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643880; c=relaxed/simple;
	bh=rDkXLDwYmt/2joQ7m8tnzWcJ/cvpR3dyNsQbz6Tegy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pcxwLBPbPI10+993qVwxgcX69HuSwVMgSEFELxsPSqUrr7iIHl+yUyZSSGT3VNgJR/TNqgpzIyFcE3ljQ11oveNLGWpDhqWjOSR8QCb4SLl3H4HBS5ITBFHisv2VpQVcR0WpirKzMF+L4zKcJvMPiI3XOl+D1w+y6F73Dr9/Sdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nAXG+lJU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1B5F041062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744643872; bh=u8pfzpkwPnivH/uUd7ymXPRbzzsoj+QwmHnBMg5MiJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nAXG+lJU4P9TqdrFiH7oUxrIem1hLJOWx6rPuqQ9lfQTXmucrr+2it9+Nrx6Y8zn1
	 0xIMtlEG9po6SopSoSnVou103P0UWSib3HtPH6Tr75nh+Kvh3KCk47fmswCOYOEKRV
	 IPf2jtEDogyFTbVm7Q17+FbFzsAkXmXnehj4OTYID6EQS4ResxUdwlR3HHhdHdy26h
	 q38j29NYd6EOD1SNk5dx9ziKdawizm3CFxvbeAqZ0sxnd8HXE6laKtubt1kDN1oq4D
	 WYwiZw2kQ/RMlA25df5NDU6vEA7qV4bmaGcd7YqVTbkaN+9eX9XwbpT7PvsfnJAX4D
	 GZmk+vFOmyRNg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1B5F041062;
	Mon, 14 Apr 2025 15:17:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell
 King <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net> <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
Date: Mon, 14 Apr 2025 09:17:51 -0600
Message-ID: <87mscibwm8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> 
>> > This changeset contains the kernel-doc.py script to replace the verable
>> > kernel-doc originally written in Perl. It replaces the first version and the
>> > second series I sent on the top of it.
>> 
>> OK, I've applied it, looked at the (minimal) changes in output, and
>> concluded that it's good - all this stuff is now in docs-next.  Many
>> thanks for doing this!
>> 
>> I'm going to hold off on other documentation patches for a day or two
>> just in case anything turns up.  But it looks awfully good.
>
> This started well, until it becomes a scripts/lib/kdoc.
> So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
> "disgusting turd" )as said by Linus) in the clean tree.
>
> *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.

If nothing else, "make cleandocs" should clean it up, certainly.

We can also tell CPython to not create that directory at all.  I'll run
some tests to see what the effect is on the documentation build times;
I'm guessing it will not be huge...

Thanks,

jon

