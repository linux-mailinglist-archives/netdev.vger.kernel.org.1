Return-Path: <netdev+bounces-179232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E640A7B68F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 05:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74BA179A9D
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD72940B;
	Fri,  4 Apr 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="PLLOeVPC"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720F282EB;
	Fri,  4 Apr 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743735979; cv=none; b=DGQViXAu+w/nB6DBWaXA+Ir4htWWQKf3BxGNGimhw4vdjoJkmp/5FkEoMfKAsGuLtP5QEvSFpuJBPpheWZplg1cEBTjpaW3sD4CfvT/ZJyKA3VKqJgO4ibvI5khMzrD4dz/WkIvvh74x9qIgX1RpUwb2MTQ3mJ7GYdA033HyHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743735979; c=relaxed/simple;
	bh=OOzjTNsaoeztiuaUUEKgQnbbeDt20tTPv/xP9IFlZAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FxgxYeFXWfT4u6fkLItuEoZNvrHVAS2r8M9FrwbJq2FoR/m775wbaVNNO/A1jHaCsEaGCI73e+3K52T8JEscMCKeWfGDP6WMwsmq518u8NkAPDgE85PgNYcz3eTIFpUU8gThRjBm9pAPuZimjAiVse4UivVMvc6i7rW7N4aaDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=PLLOeVPC; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EULONde+eAu9B+Vu7ZbRkaj2yQsdB6BaOde6KnVIdgw=; b=PLLOeVPCiEoRmTAy3V+XWdfKbz
	MtLQ4ECjLWfSgKRowAkLnJJ+mUeei24k7Xe8qgAwyXziEOu0KHy8QpiPte+WLsYgdUb42vr3q0B8C
	jovztRg5dbvuyLeRg8ykOyzg3Q1k8aapoh2hQke1irk4/z4a9oVDrPG5HakgJQgjW8KIe0a7k6Vca
	tAZrZASU+q4V2rONS+17ksOLelT1FjV/eCKCB0XtUSJAV8WmzcCURGzFiUfSYg4Ztu0bhW5xWIsBY
	+iUte5VlcfyFvCxWkUdGyiJI0PE4tkbRqiXf34bXa6YK8+wyOJgD6JE15VGkYAmLsZwwOSh9uNE1X
	715mazCQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u0XNI-00Ci7R-1K;
	Fri, 04 Apr 2025 11:05:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Apr 2025 11:05:44 +0800
Date: Fri, 4 Apr 2025 11:05:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: andriy.shevchenko@linux.intel.com, przemyslaw.kitszel@intel.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: Re: [RFC] slab: introduce auto_kfree macro
Message-ID: <Z-9MiJ0nuBxYCaV2@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121935.GJ25239@noisy.programming.kicks-ass.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev

Peter Zijlstra <peterz@infradead.org> wrote:
>
> The compiler *should* complain. But neither GCC nor clang actually
> appear to warn in this case.

Linus turned that warning off in 2020:

commit 78a5255ffb6a1af189a83e493d916ba1c54d8c75
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat May 9 13:57:10 2020 -0700

    Stop the ad-hoc games with -Wno-maybe-initialized

You need to enable it by hand to see the warning:

make KBUILD_CFLAGS_KERNEL=-Wmaybe-uninitialized CFLAGS_MODULE=-Wmaybe-uninitialized

W=2 enables it too but it also enables lots of other crap so it's
useless.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

