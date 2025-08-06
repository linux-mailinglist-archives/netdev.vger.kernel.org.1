Return-Path: <netdev+bounces-211919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62192B1C7DC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899997A4D70
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03BD1A23A0;
	Wed,  6 Aug 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kExoOBhr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F22E3715
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491682; cv=none; b=dMMwuTmsmrYVH9MYYi958qU9lm1V4tSQhT7cjHAdQ4TrO2Js0F7OyhWQJjSMdYOXF+vebKSULQeJUBCLn8ohtwsEFplborK8JNwSIKMLfvUlde3zztQZhxhvr08BkG2fs2oFw1/3m8KupgFqsiJ3rryyP7iBYgT42ycRJ6UA81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491682; c=relaxed/simple;
	bh=SrdgMUPq0Ho91eBWpfGKFPWGJ9MzebVMHQFQaIWp80A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDD0ftdbP2pr3butR3XcfwO/kWy4jwDDnoglxwUWmteYzS4eyoGpuSbNCtbhsGo+mtiSvV7Q0RLGQH+qPB43kvGBTs/l2uYg1f6VmGFPYaqSjS2sBYnOUxXRRQ0p5HhAualpMy0lWW/95EX76R/A8MNkK+wjSKR0Mr2Ueo1/qkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kExoOBhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECC2C4CEE7;
	Wed,  6 Aug 2025 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754491682;
	bh=SrdgMUPq0Ho91eBWpfGKFPWGJ9MzebVMHQFQaIWp80A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kExoOBhrJiJftHRKZtTgkIa1Jl2qzokvazJOSWnqyD9WoUAOFm/GIhjzHFgkbscpa
	 t5+e1gYWenTdTBCKqNwBxBdjIP29x7rEId2ZI8D4OV3LEeGj0rW6u66pRWXq5TeSYL
	 z7yZs0a1NriPOH7/ek+MbVa8nFm/noWqnWKDnPxd5gLqhpPt8nI4MdtJ+fC2wHWiUS
	 stJMzTBd5YJdSh3m1qDVK0IVBBmRH8hO9FHShS0Ieo++agnG0SRB+jqPqsNCXZC922
	 dqXD7KbMFdFU9qV28l2HJWYYo66JoBIbvuOp01w3mjDH2ynArobMT84e+FCl5WbAqM
	 USTORfv3uID4w==
Date: Wed, 6 Aug 2025 07:48:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dennis Chen <dchen27@ncsu.edu>
Cc: Dennis Chen <dechen@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, petrm@nvidia.com, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 0/3] netdevsim: Add support for ethtool stats
 and add
Message-ID: <20250806074800.65fa46bc@kernel.org>
In-Reply-To: <CALSBQO=Q5fPxAuAAdgN8eUgTGVzdRYhthLvb6052SzsDV0uZ3A@mail.gmail.com>
References: <20250805213356.3348348-1-dechen@redhat.com>
	<20250805155550.3ed93078@kernel.org>
	<CALSBQO=Q5fPxAuAAdgN8eUgTGVzdRYhthLvb6052SzsDV0uZ3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 10:05:27 -0400 Dennis Chen wrote:
> > The tests for netdevsim must test something meaningful in the kernel.
> > This submission really looks like you need it to test some user space
> > code.
> 
> This test would help verify that ethtool_ops correctly propagates stats to
> userspace, would that not be significant enough for a test?
> 
> My thought was that it would be similar to the patches for ethtool
> --show-phys here:
> https://lore.kernel.org/netdev/20250710062248.378459-1-maxime.chevallier@bootlin.com/

What are you trying to test. Like, what _actually_ made you and Kamal
write these patches? I can't think of many bugs in the area. And you
clearly have zero familiarity with our recommendation of what stats
to report and how :/ so if anything your code is hurting more than
helping.

