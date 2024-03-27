Return-Path: <netdev+bounces-82525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D488E766
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA90302087
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8C130A6D;
	Wed, 27 Mar 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wfIgDJIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073812E1DC
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547770; cv=none; b=p5q3V447j/e6l3iit6lfs5LjcRa6ZTyaswdXypKYA/XHw/VI8jQYeczCr61przaRoYz1woed4ffbizx6kkDLZZnwpUVruEXbNvK5QDwFeKZJvRqVtseBindGOK5Cyef4OupEyS61Bkcj5Y0Q4bwUjrVv+ZWq8soyyBXetxjJ62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547770; c=relaxed/simple;
	bh=6tIp+zaTDXYmhqassrVTNTK3w1T8+XLd6cvJNJqeEN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfD6lQ3npXExKIwiLg+uEqyRsyOefoO8C8b2AGEF7pTy8BAc/Lf6Wu62dT5DJNau5dgI9JSuEi9lUxJ8AGahpOlHUXFKyvYGBwLBQmmZJb6Bxt6xKV5bXFj94jA59W3pgVjls6CQ+L0tGghKks/Zi6/6gqS618kr1iXZy14B8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wfIgDJIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1833FC433F1;
	Wed, 27 Mar 2024 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711547769;
	bh=6tIp+zaTDXYmhqassrVTNTK3w1T8+XLd6cvJNJqeEN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wfIgDJIM9GGPNESPtlKS7c++bX4Qhk7ZV/EEPvOuUCUwLiuwVUyMFQyYJO9zakiM1
	 /B1tDYayHt89uzyWD/Uxy03nZc7Kdt5TY+Yxnru5GN1xC7FhJ4VPWq8pkGwe9HpgJM
	 kyNqxokhltyukv5iq9xlLtw42w1HU4/bOkHgHwTM=
Date: Wed, 27 Mar 2024 14:56:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Ben Hutchings <ben@decadent.org.uk>,
	netdev <netdev@vger.kernel.org>, cve@kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Is CVE-2024-26624 a valid issue?
Message-ID: <2024032743-wildfire-amusing-1875@gregkh>
References: <95eb2777e6e6815b50242abb356cfc12557c6260.camel@decadent.org.uk>
 <CANn89iKnQZWNw3NS0uGCWSejKxaUh8iL=UwZ+9+Lhmfth-LTxQ@mail.gmail.com>
 <20240311140043.GR86322@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311140043.GR86322@google.com>

On Mon, Mar 11, 2024 at 02:00:43PM +0000, Lee Jones wrote:
> On Mon, 11 Mar 2024, Eric Dumazet wrote:
> 
> > Hi Ben
> > 
> > Yes, my understanding of the issue is that it is a false positive.
> > 
> > Some kernels might crash whenever LOCKDEP triggers, as for any WARNing.
> 
> Exactly.  So is it possible to trip this, false positive or otherwise?
> Being able to crash the kernel, even under false pretences, is
> definitely something we usually provide CVE allocations for.

lockdep warnings do not trigger a reboot for panic-on-warn, so I'll go
reject this cve, thanks.

greg k-h

