Return-Path: <netdev+bounces-210284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97333B12A46
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 13:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEAE1899B28
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E830219EA5;
	Sat, 26 Jul 2025 11:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAD1E5B95
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753529393; cv=none; b=mdJxpHyUPzLlzWR09ZYZA/f+6GIvvjctoq9kXkkIG7sCMYLxkXqmIRU/r0FLKZvlJkTLokDVSACfwHK5wEwNNO5MOPQctFtebBdLr+0xWkZbLDcooOSIy4hRM6e/zRrhtfrorZyhFBLxc9MLTeG06SUVeiGfIJ8TdMdNUV2lUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753529393; c=relaxed/simple;
	bh=7XLOILsQGQ9wf3jwubZ4vpTXCL+6HQ7j0z5mG/5X1xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHN0zYOKIjbAF5x0xKhEqPMnPJirxakeojy7cPyrFeIo5l2LFhXZ0G+wJELvRC226Q/GbCoRbKyGoSFNo9Tqy/hL/LHGZFM/cLZicOjAKHeXSKSdrlE07N9RQt07TH/BlNO0HgXRGnvFxs8hmqo78uRAktpIRjRWjYJ7ze4atHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from equinox by eidolon.nox.tf with local (Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1ufd5z-000000041PB-06OS;
	Sat, 26 Jul 2025 13:29:43 +0200
Date: Sat, 26 Jul 2025 13:29:42 +0200
From: David Lamparter <equinox@diac24.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Patrick Rohr <prohr@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net/ipv6: RFC6724 rule 5.5 preparations
Message-ID: <aIS8Jsz2CEKhOiP6@eidolon.nox.tf>
References: <20250724150042.6361-1-equinox@diac24.net>
 <20250725173958.4d77792d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725173958.4d77792d@kernel.org>

On Fri, Jul 25, 2025 at 05:39:58PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 17:00:37 +0200 David Lamparter wrote:
> > let's try this again, this time without accidentally shadowing the 'err'
> > variable.  Sigh.  (Apologies for the immediate v2.)
> > 
> > following 4 patches are preparations for RFC6724 (IPv6 source address
> > selection) rule 5.5, which says "prefer addresses announced by the
> > router you're using".  The changes here just pass down the route into
> > the source address selection code, it's not used for anything yet.
> > (Any change of behavior from these patches is a mistake on my end.)
> 
> Would you mind reposting after the merge window (>= Aug 11th)?

ACK, I'm {hoping,waiting} for a Reviewed-by from Patrick as well
(@Patrick: hint, hint), and for the actual RFC6724 r5.5 code I'm still
working on a kselftest.

