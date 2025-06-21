Return-Path: <netdev+bounces-200029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315A9AE2C29
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 22:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894CE3A8262
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8727054B;
	Sat, 21 Jun 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="opPTrMwI"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634B926A0E3;
	Sat, 21 Jun 2025 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750536903; cv=none; b=I2FaoUU9eQqO+ytG4iC0RhzlhzzsWO55FT10OTmqQ1m341JNMyMxWaU1jBaVx0PGFpR6QypxUkkmmS+WlBDx0gSoXPDwG0lH/K6aqS3umz92nui29/35oKIHF7M+m/6/+bJqo4HbRZYfG+fcnPCgMT7vfRZin4sAXlR7cBcCmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750536903; c=relaxed/simple;
	bh=u7aylu5TOqIeQOqjZx8nLxreknEl1RVRNdSUyILHyIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GV5mz3O0RwsPnKZkHh4+g/PPjhtx9UzIYbFGNvXtrX1Ccj+OMgtRnKt/9ijQb6ExFHhqqnyP7CImUO1gysyVl4mMuxT3vzWfz3LsGuKDg/wWQXihnis2WF/7laQSNjHb/JlxBsML/9cP1GcXIW6Ik3yOhOCLttgNDcBNRSIup+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=opPTrMwI; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9BD0441F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1750536901; bh=pZcnjCOPw3KukbrVQFXvtRd4dj2DZVwSivx9jDPCwjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=opPTrMwIMhf6VKTImNMe8bm9qiN9PceLV7Le0Rhh1DKt5nQNrhxHU3IyZdKGMgLI0
	 tmIkgUW7OiZw82PL9IEp+a8W3Ag3JV0VO7mq0oUkndsMio2uGhE0+Sk1lNY0Chczkl
	 KoCf2HUfHpnnthH4uvI2NQb9N9Mj/wH7IjPVj47XzrP3BVeLQpmshPl1hrT7lesn2E
	 eZ/mO35MVcpK8dREOY7eNpAgsyt23X6M3AqXFWZFZ5h/qR8CQMg66Q3T1IqBAg8Vx/
	 4XL8mchPK1fLiG8gA2noQ1aukbwN1e6Zl8c0K6bNvTf9MtlmrKF82xrnjF8zKoArs9
	 VFd65bkrm2Faw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9BD0441F2B;
	Sat, 21 Jun 2025 20:15:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] docs: process: discourage pointless boilerplate kdoc
In-Reply-To: <20250614204258.61449-1-kuba@kernel.org>
References: <20250614204258.61449-1-kuba@kernel.org>
Date: Sat, 21 Jun 2025 14:15:00 -0600
Message-ID: <8734bsdf7f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> It appears that folks "less versed in kernel coding" think that its
> good style to document every function, even if they have no useful
> information to pass to the future readers of the code. This used
> to be just a waste of space, but with increased kdoc format linting
> it's also a burden when refactoring the code.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/process/coding-style.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 19d2ed47ff79..d1a8e5465ed9 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -614,7 +614,10 @@ it.
>  
>  When commenting the kernel API functions, please use the kernel-doc format.
>  See the files at :ref:`Documentation/doc-guide/ <doc_guide>` and
> -``scripts/kernel-doc`` for details.
> +``scripts/kernel-doc`` for details. Note that the danger of over-commenting
> +applies to kernel-doc comments all the same. Do not add boilerplate
> +kernel-doc which simply reiterates what's obvious from the signature
> +of the function.

Applied, thanks.

jon

