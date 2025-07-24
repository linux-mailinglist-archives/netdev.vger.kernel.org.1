Return-Path: <netdev+bounces-209807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7A3B10F0D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932E93A69D9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C511DF985;
	Thu, 24 Jul 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igiezwh5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF44EACD;
	Thu, 24 Jul 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372008; cv=none; b=kzepY+wwgP2Cue8KD0Rd5i8VhM/ZtQo97J7YltG4ACHih/WiI8G2m1sogotLbBTZotawVkvp+D/lw0u8vtem6xCqnIntdcvVG9pA0Lu6CI/2LnkSUxEYz23Lsktj8fFjDEI612+WMATgQ1O+oTy2w34dEGPG74HYCjqg3yqGxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372008; c=relaxed/simple;
	bh=aUpzQk5F+ilIOEzUj6sp1Y3UrATILLsScrYyimr2cio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a2hOJYUZIu2WAGhgPIFnaQZDiEwH2utQUi3W2aj15XccivsD/fktarAv5kLEGKd+X9rY/kU9ds8KAgeISyeJ+I7WQG++LHEHcoo4O2b1CBByGpznazCjYy2o5tqT+eVhE0UwMKrbKOnat1Xi/2Jo37jwBtOWjQgHlGnQ2PCXP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igiezwh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C84C4CEED;
	Thu, 24 Jul 2025 15:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753372007;
	bh=aUpzQk5F+ilIOEzUj6sp1Y3UrATILLsScrYyimr2cio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=igiezwh5C8BzR9EP4Lp0hAlQriRoSrADvo/x0CxXe1BRddjMVzItKwhDwPEc7UgT0
	 2OpaQGr+mGeIeVMY2psKbDI6Ofeab/8lTifqJOiEU5bm1gKLbh6CZJQRC80qB70wbW
	 0KYIz+EJOPaQdfd2kj40Gnxgtcc26nBd5D5K5YQkBbmXh4j70e0HGq+nR8k8JfgEA/
	 ihEQoissumegwwVyHvyfzbokqym1z3iT9urW7jinQUoDaWj3ura2aVEmWqP+hGWAMf
	 IcV9VW57oT5Jl2N+cWXbYZB4U1HKn/UyjgsWzQFRq1ZUa03WttqKaIxf1vQkHZAy0v
	 BkDbpZ0F0UZMQ==
Date: Thu, 24 Jul 2025 10:46:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] net: Fix typos
Message-ID: <20250724154646.GA2939522@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e2a164eee44c5ba8b5f0b14ca7ee06@amazon.com>

On Thu, Jul 24, 2025 at 05:49:31AM +0000, Arinzon, David wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos in comments and error messages.

> ...
> Reviewed for ENA. Thanks for identifying this typo.
> Shouldn't think patch be for net-next?

Thanks.  It is actually based on net-next (56613001dfc9 ("Merge branch
'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux"))
but I forgot to mention that in the subject line.

> Reviewed-by: David Arinzon <darinzon@amazon.com>

