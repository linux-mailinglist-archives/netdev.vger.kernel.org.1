Return-Path: <netdev+bounces-44106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253BB7D641D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA007B20C8B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D31BDF6;
	Wed, 25 Oct 2023 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjM6U44q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D519461
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 07:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DBDC433C8;
	Wed, 25 Oct 2023 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698220426;
	bh=4KN5OuPz21CBwLkkVWqB5o6WRdRU40YDCChza5/ASkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjM6U44qaYYgfKY+U47l7lBp6rfq2ixCwBo+5lsPZ4tLo3xhaoe3z/Go1R8uHxbo7
	 d9Xh8d9s+VSzxn5A9o3BcoSGAzA+cCtlj94I3QE3YaEWS82DgrOFaMeNJhkNeW9Cca
	 2N0G72l2gFzUrwwzxy82HIntZutGbJ2moRl8aO+VemI7YMYVuicmY5am0KM1/HIrHl
	 KZkDlTDtKs3rueHLOE8PVBWPgwG7SJNiYOUoIjepAKAJ33Z8qXCdxj1ASgDqxlj9hs
	 n83C/3PFZd4bf/a2Cdx8liJc5bEWq0QJ0ekQqjH0ufHKZ5AHcHU4Zyky4CmEiy9gPO
	 qK0RCPIItpOtQ==
Date: Wed, 25 Oct 2023 10:53:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org,
	thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org,
	Paulo.DaSilva@kyberna.com, mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <20231025075341.GA2950466@unreal>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
 <ZTiu0Itkhbb8OqS7@hera>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTiu0Itkhbb8OqS7@hera>

On Wed, Oct 25, 2023 at 08:59:44AM +0300, Ilias Apalodimas wrote:
> Hi Jakub,
> 
> On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> > On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > > If the page_pool variable is null while passing it to
> > > the page_pool_get_stats function we receive a kernel error.
> > >
> > > Check if the page_pool variable is at least valid.
> >
> > IMHO this seems insufficient, the driver still has to check if PP
> > was instantiated when the strings are queried. My weak preference
> > would be to stick to v1 and have the driver check all the conditions.
> > But if nobody else feels this way, it's fine :)
> 
> I don't disagree, but OTOH it would be sane for the API not to crash if
> something invalid is passed. 

In-kernel API assumes that in-kernel callers know how to use it.

> Maybe the best approach would be to keep the
> driver checks, which are saner, but add the page pool code as well with a
> printable error indicating a driver bug?

It is no different from adding extra checks to prevent drivers from random calls
with random parameters to well defined API.

Thanks

> 
> Thanks
> /Ilias
> 

