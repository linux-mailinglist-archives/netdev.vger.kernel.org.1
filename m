Return-Path: <netdev+bounces-227642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC9BB4765
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 18:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2781A3C2246
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71781242D87;
	Thu,  2 Oct 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7SsNmlD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8C2417FB
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421696; cv=none; b=oDFdxL1JNFoCt0PsP1DbLmSh2aPMJj0V56AxOqtAkxGQi08qE8o5xIPdu53VE0xQx/pA4Hj6SkVe8HBI8my/EBXvuA28qHD6zKllNCDLwoy71gDFct1vSGxsHzuWG5RIWHtdtbR7R2qZdN1LI6GuLNDOCrzsMClgGqWpUk4m1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421696; c=relaxed/simple;
	bh=fD+Zt0EqbMkVksyjoRCHvjYMOI2R+NiKyvTPc8xqhH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZtudHf+jE7DSm1PHVInbmJH6abvZngkjAlMgS3gEEm+9BJxlo+dwV/8KevUkmOMPEDcb72kR4JQN6fjBJaDL0KN3IySqfViKC/2aBzRNaVO6DiOklG5g5RY2y6zQHfcuDLf9y++Sk0xzLoDqnieQN/UiwnGZ866ncdRDXFQ7Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7SsNmlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5F9C4CEF4;
	Thu,  2 Oct 2025 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759421694;
	bh=fD+Zt0EqbMkVksyjoRCHvjYMOI2R+NiKyvTPc8xqhH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7SsNmlDq/AOkQJiCxj9awsvwOgT+PVUkXgOXYQ3+xujCxz5OOL64d0aiHbVZEr/7
	 0/MyfVBHZTr64jinFYktKgtu5tkltaVcH0WZowoNcU9KXWQ2nst9DRjiT+mVwiBkoq
	 J1rWkUiz+RAMflcTKZtwb/bBLUj5rV+j+TNWCvSn3YMFoH4JclEFfv7jJA1xLrn9R1
	 GDDz1oU+zQqR5i4KmdmmDoPdnIqd0KjRcFzCq50oFAyzWQcgjHusKKKuCBgMlZt3jI
	 VZsx/QVMg90W7jm7MQ5ZtNdvZy2762M+j5G9N/bZnLYiAmdlgE+n7IdLWKXaPAAGjb
	 FQDBX9cpdhxDA==
Date: Thu, 2 Oct 2025 17:14:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, petrm@nvidia.com
Subject: Re: [PATCH net] selftests: drv-net: make linters happy with our
 imports
Message-ID: <20251002161450.GA2873873@horms.kernel.org>
References: <20251001234308.2895998-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001234308.2895998-1-kuba@kernel.org>

On Wed, Oct 01, 2025 at 04:43:08PM -0700, Jakub Kicinski wrote:
> Linters are still not very happy with our __init__ files,
> which was pointed out in recent review (see Link).
> 
> We have previously started importing things one by one to
> make linters happy with the test files (which import from __init__).
> But __init__ file itself still makes linters unhappy.
> 
> To clean it up I believe we must completely remove the wildcard
> imports, and assign the imported modules to __all__.
> 
> hds.py needs to be fixed because it seems to be importing
> the Python standard random from lib.net.
> 
> We can't use ksft_pr() / ktap_result() in case importing
> from net.lib fails. Linters complain that those helpers
> themselves may not have been imported.
> 
> Link: https://lore.kernel.org/9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Sending a fix for the driver's __init__.py first, if this is okay
> with everyone I'll convert the rest. I'm not super confident 'cause
> my Python isn't properly learned.
> 
> Sending for net, even tho its not a real fix. I think that getting
> it applied during the merge window may be okay? No strong prefence.
> I'm slightly worried that merging it in net-next after the MW will
> leave us with a release cycle full of merge conflicts.

It looks like we are off to a flying start on that front:
it seems this does not apply cleanly to net.

...

