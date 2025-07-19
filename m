Return-Path: <netdev+bounces-208282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94FB0ACC7
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 02:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D23A4737
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6010957;
	Sat, 19 Jul 2025 00:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFce9dm5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1921FDD
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884798; cv=none; b=gB71xFFTAtfcw4XcWK88RMBmNk4f9z/GJq8czNEnUyZNl0AP6jsFxevhBOeVHgfjAWniZJwCFtjslMJWQ/KQGR83Y2yTPihkvrpBZ1cpDUFptwWX5iuAlMhFg+FQBwdzeSl0pNI7tHTa9llGhcH3M8aTap8GIK9TDGGhOwqSKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884798; c=relaxed/simple;
	bh=h/6xCh63ol9rF/YCoyfyG60Nvw3w5iN0gxe7vQgkmrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZraKMUKlbWH2zAIsRpaj5giKWlfaUJ2w7G3qObqXtMLp+/y2oe/lr5fbXi82a+2n2b4Wg797cfFkn2mpElYvRtz1EDsmx/5eOIS7N8+1a42bNqjYAnudehGPD+cAdj0igmyr2Rne4AEUy985ay8I6BLL8r7k9jguuOwCFFMNaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFce9dm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61463C4CEEB;
	Sat, 19 Jul 2025 00:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884795;
	bh=h/6xCh63ol9rF/YCoyfyG60Nvw3w5iN0gxe7vQgkmrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VFce9dm5kLiEM94XoRZpvs50U/x//4kRLpGunJLh+K9KlWT3Q8KW5H28n0+vwAbfQ
	 JupXfXV0k4JZwEKTL9S8CHn8YIvS2a5Kr0CTUozA4o13r9fwv9AQ0T7qIGoDnwayqf
	 aWiUk1EPYHCZx4Aik1zjWN5+zpiJD39MkxllheIhPgqYeDmxKJ45boZ5obHyB+10Qf
	 L82IASAS1mVP6qqQwK3aABBWTlSz6NCXvF6Wi9Cjpxs7r6+J+TwCO35bMENpsQ3hBI
	 CBCWFvxad/UrmX9+Un5UQBooHhQcw6iUkVeZ/m6lnyVxF+0fdHbnXii413Ut0MU6/d
	 E8Fas+mtLsrQw==
Date: Fri, 18 Jul 2025 17:26:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, pablo@netfilter.org, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: netfilter: tone-down conntrack clash
 test
Message-ID: <20250718172634.18261f54@kernel.org>
In-Reply-To: <20250717150941.9057-1-fw@strlen.de>
References: <20250717150941.9057-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 17:09:37 +0200 Florian Westphal wrote:
> Stop this test from failing.
> 
> This is a stop-gap measure to not keep failing on NIPA CI.
> 
> The test is supposed to observe that clash_resolution stat counter
> incremented (code path was covered).  This path is only exercised
> when multiple packets race: depending on kernel config, number of CPUs,
> scheduling policy etc. this might not trigger at all.
> 
> Therefore, if the test program did not observe the expected number of
> replies, make a note of it but do not flip script retval to 1.
> 
> With this change the test should either SKIP or pass.
> Hard error can be restored later once its clear whats going on.

Hm, someone set this patch to Deferred and Archived in patchwork, 
which is rather unusual. If someone did that on purpose please reply
otherwise we'll apply the patch.

