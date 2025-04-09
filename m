Return-Path: <netdev+bounces-180892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE2A82D53
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4250A46363D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C9270EDE;
	Wed,  9 Apr 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbb1fHML"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F2270ED4;
	Wed,  9 Apr 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218686; cv=none; b=QQJzMhKnru7Q9srxfgInDVxQR3RfHSw9AxSC6NvLzCLclx8CcHS8rhgtCBhUnIGkajVhO5i+x1fKBKIzb468mBGKM/o77iU7J83LCx95mXOBSRglHVEv6YiCmCDpwr1uOoUyprypG2r7l03rUSJ5DEEEA1tXdg7uWw3bADPAEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218686; c=relaxed/simple;
	bh=cuJOArFdoXW4RDNLZsYZJfM03dST0qITehEF7xJ9LOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wammawn7fwwB+5ZJe5vpKTcCkDQdzmZmFK2aakDUnOFyUXcY89xUAuGoZA/6uugFGaA5EJcjG2dkRGjPa9Dqd8zmzRBdY9Vuqm+Tv+NoZlji/XA39+Y8veQ1YPI9sTZFZXS5zHy1l73M4erqolbg3Qh4c0NMVCsH72sTrKX1xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbb1fHML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E4C4CEE2;
	Wed,  9 Apr 2025 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744218686;
	bh=cuJOArFdoXW4RDNLZsYZJfM03dST0qITehEF7xJ9LOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jbb1fHMLyJegCS/SVq02NtWOyny5wTpwRBlj6wIQ4xFXegOUbnKFhxgCT5o1MDt5n
	 qKfZuHwGNk4+lbrD/aTFXkEriipb0RYh+aNbmaUWZW7afRtX56crCCahJXKd6XhYdL
	 2cnnTGs3sht38sxBMvGL+ylvqHGlmL4bGYPY4Dox5iYB3NAqSGOqRlem2K3MvvhUrA
	 0NKLI/SvQpv05Kz3D6TdFMJeuUJJxcGxdWe0aXmamaNhbidAmXAN5EGSAFpsaY3Ork
	 hmSnjKH8gL7z6IFNu0JJ7QL6i+th5Vj7x3AfXiuRilXq7aD1E5fSkgUXaoc1daNzHC
	 y5OrIJjSayH8Q==
Date: Wed, 9 Apr 2025 18:11:22 +0100
From: Simon Horman <horms@kernel.org>
To: "Rangoju, Raju" <raju.rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: Convert to SPDX identifier
Message-ID: <20250409171122.GP395307@horms.kernel.org>
References: <20250407102913.3063691-1-Raju.Rangoju@amd.com>
 <20250407163051.GS395307@horms.kernel.org>
 <14d67256-13a1-4e51-996e-317bd5edf6bc@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d67256-13a1-4e51-996e-317bd5edf6bc@amd.com>

On Tue, Apr 08, 2025 at 04:39:24PM +0530, Rangoju, Raju wrote:
> 
> 
> On 4/7/2025 10:00 PM, Simon Horman wrote:
> > On Mon, Apr 07, 2025 at 03:59:13PM +0530, Raju Rangoju wrote:
> > > Use SPDX-License-Identifier accross all the files of the xgbe driver to
> > > ensure compliance with Linux kernel standards, thus removing the
> > > boiler-plate template license text.
> > > 
> > > Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> > > Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > 
> > I note that this patch changes both the licences and copyright information,
> > and not just the representation of that information, for the files it
> > updates. And that the patch is from and reviewed by people at AMD. So I
> > assume those changes are intentional.
> > 
> 
> Yes, it was reviewed by people at AMD.

Thanks for the confirmation, much appreciated.

