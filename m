Return-Path: <netdev+bounces-120266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB871958BBB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8411C22188
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD10195FE3;
	Tue, 20 Aug 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="x00s4fu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F319408E
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169492; cv=none; b=BOVnlvJ7KTiCmEkGpWeZ7KAAEIb0U5YLaqha8hziG8V5t1sve59RcCKO8j1yfAqLlX0LrZ3B7SLmx414+4MC8P1vCudDMeEXgm2Ntmctaw9kmRVvsc9KP8rpTFrazXoGIZACzTbGxWDthVn9SB5YK/J/Uoar/MmER1kHcs5MEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169492; c=relaxed/simple;
	bh=qau0AZsttkTMDre7qzTMPATogDqEToRJf7Gckq4n0As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCwI6BEaihjUUpk4466tpuMhP9ASntCcCE0d7nOvbZ4/x2PVqG4EP/SIDkasQ3MR7RZiScxPjKUzEZOC+W+r0C1FxR0FI/6yrvmFjibfeOT6XySPHaR0Z0U66Ujb/OOvWSDQzoDsXzdT9/S/r6UpC6EJCKpDIt/mUxKJb5Er+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=x00s4fu6; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WpDdV5BVFzFQp;
	Tue, 20 Aug 2024 17:58:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724169486;
	bh=+BR8L0axucrbNk5CJOLL6QFgYFq0cmy2eGES+WXtrdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x00s4fu6OWYfApJPJyMssLpi6cNIM9UiwB+BAru6VNxzde4Ed/APfusz2LokH5+ow
	 psGM/lbTXtX5efMde9XXuwyteJlTDpEUBewPSoJa/DMpCtKjnus9bY/9x09Y513VEP
	 ZG9WV45Bp5jksGuEuVSbfqplxD1RiQMVpVvWKltI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WpDdV1gQZzvmZ;
	Tue, 20 Aug 2024 17:58:06 +0200 (CEST)
Date: Tue, 20 Aug 2024 17:58:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v10 2/6] selftests/Landlock: general scoped restriction
 tests
Message-ID: <20240820.nah8bahngaiF@digikod.net>
References: <cover.1724125513.git.fahimitahera@gmail.com>
 <6c0558cefc8295687f8a3a900b0582f74730dbb2.1724125513.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c0558cefc8295687f8a3a900b0582f74730dbb2.1724125513.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

"Re: [PATCH v10 2/6] selftests/Landlock: general scoped restriction"
This subject is still incorrect, please use this instead:
"selftests/landlock: Add common scope tests"

The same rule for the subject prefix should be followed for all other
commits (see my previous review).

On Mon, Aug 19, 2024 at 10:08:52PM -0600, Tahera Fahimi wrote:
> The test function, "ruleset_with_unknown_scoped", is designed to
> validate the behaviour of the "landlock_create_ruleset" function
> when it is provided with an unsupported or unknown scoped mask.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  .../testing/selftests/landlock/scoped_test.c  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/scoped_test.c
> 
> diff --git a/tools/testing/selftests/landlock/scoped_test.c b/tools/testing/selftests/landlock/scoped_test.c
> new file mode 100644
> index 000000000000..aee853582451
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_test.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Scope Restriction

Landlock tests - Common scope restrictions

> + *
> + * Copyright © 2024 Tahera Fahimi <fahimitahera@gmail.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/landlock.h>
> +#include <sys/prctl.h>
> +
> +#include "common.h"
> +
> +#define ACCESS_LAST LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET
> +
> +TEST(ruleset_with_unknown_scoped)

"ruleset_with_unknown_scope" makes more sense (also in the commit
message).

> +{
> +	__u64 scoped_mask;
> +
> +	for (scoped_mask = 1ULL << 63; scoped_mask != ACCESS_LAST;
> +	     scoped_mask >>= 1) {
> +		struct landlock_ruleset_attr ruleset_attr = {
> +			.scoped = scoped_mask,
> +		};
> +
> +		ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr,
> +						      sizeof(ruleset_attr), 0));
> +		ASSERT_EQ(EINVAL, errno);
> +	}
> +}

Good!

> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

