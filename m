Return-Path: <netdev+bounces-178099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06461A749A4
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34192189901A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD521ADC5;
	Fri, 28 Mar 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AinElruk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15717548
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164032; cv=none; b=s04nT60vYT5RRnZ/m8LBFZP6CSa8l1uCVWUuZzNXUQGfeBCL6e/W+8zKXKEEcTm5BV4atSZ1rtw8nHc0e7cXYPTbUfgU65yZE4QytdORE877paPTDXRUoUVrIzGZ9DMnDUod13ZtAgcwE8Ixe+mPd31MvtSNPQxVzKKdKQMia0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164032; c=relaxed/simple;
	bh=iGNlSHjFv3p0VawGhfsS7uxHBx8NruSpd/UPvO4BxwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwTISMZlZ8SI0mO+z2UicZghZ6FKWuBoqcnuFDNVSaJMvwsSnmqZt8Ut3IylC0tUSdhFu2vewQJERCMCHsgLPTFWDmUwY2eFdRki5CvtOaCvYvcKLUKEBBKMB+701jAil3dMVOenTXHDrT2qnJVbnJYMXY+sSyl8b56LMJ5fZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AinElruk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0079C4CEE4;
	Fri, 28 Mar 2025 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743164032;
	bh=iGNlSHjFv3p0VawGhfsS7uxHBx8NruSpd/UPvO4BxwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AinElrukTKkiBrDEZvQoB4dQG/k9e7j00odTufipSO7AVT8Bfqf06hEP94I5qoNHe
	 jFUh0SRp6GBUr+Z15w5NiGzhgzr+eiifAA+njROlYKvLHsgf+DN2wFf2YfnevvgU+o
	 eHvSImfKTk5G97hdB3Fk0N/N1ZJ4+B1qAVdXolGuVhW8MYoavYrbmoNu3bZo+i4PRu
	 SxjtYmelseyjTC3p65sPdsrM8TmxPcY28u4X8VY2XUnGQGyn+OCOi3M3E5oH4ydHUr
	 Bo2PWz0XG6yWDlYecsw+ppc+57Fpbep95RMK37P7DfPRPwEDa2FafBUGUL6gacVh3S
	 6z2qWLCnu7Yew==
Date: Fri, 28 Mar 2025 05:13:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
 <horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: net-shapers plan
Message-ID: <20250328051350.5055efe9@kernel.org>
In-Reply-To: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 14:03:54 +0000 Cosmin Ratiu wrote:
> It is not important which entity (kernel or hw) classifies packets as
> long as the condition that a given txq only sends traffic for a single
> traffic class holds.

> Furthermore, this cannot be done by simply grouping txqs for a given TC
> with NET_SHAPER_SCOPE_NODE, because the TC for a txq is not always
> known to the kernel and might only be known to the driver or the NIC.
> With the new roots, net-shapers can relay the intent to shape traffic
> for a particular TC to the driver without having knowledge of which
> txqs service a TC. The association between txqs and TCs they service
> doesn't need to be known to the kernel.

As mentioned in Zagreb the part of HW reclassifying traffic does not
make sense to me. Is this a real user scenario you have or more of 
an attempt to "maximize flexibility"?

