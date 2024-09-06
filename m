Return-Path: <netdev+bounces-126006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514B596F8BC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10728282B85
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F271D31AA;
	Fri,  6 Sep 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d/dX/Yqd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B81D0DC6;
	Fri,  6 Sep 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638105; cv=none; b=OQbxXBJbKPxkst8tvncQEinfvu4LZShtg1C547tvf4ZCOfF7P0NuWHPq2AFmcVWoKlYsUnU6f8VCkPhHhh6+Ar3aZY3YiwkRncw4IIxM1i6gQ23LCVQc6wno8O6Z82m9/zoQriViY5kElltQTuHAdc0RXfcNymJG2ux/ZgZCFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638105; c=relaxed/simple;
	bh=vZcy0j14JHhKQjyRF3aCzSfotzc+fODYaeaV+eyJ68k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuzyawXWd+BpVmCtwNdzGwsJDs5ICxcpmOzmh9o8jGneUegmJ/QJT20jl7kALPAMiARQYUayWwusmxR2wus9IdARZZXC5WivuKhZUHNb+cP6/66Z91S/UnllyiueqbVwv0NUXYjSVHLZsq6ZAEE2pAaWM15U8GNzCB0S6cL+WnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d/dX/Yqd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9gmhx+3YknuSIRL8TWBm0tczYK/bI4fx8rop8t+Isog=; b=d/dX/Yqd0hvLno6IuvSrJq3xLG
	PbkPQAz2jDR0MsAmvM+UHgwGumgp8WU0yfGOJ+1eaXlo02U7z9N2n86a60JsHrRxCEREopRF7hjaB
	zgt77qavOK9oYqjQjAvGWb5O5G77kcRFj/J1uZFc9js/BsCQFSfCZHyVnbKlpZnczrZM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smbIP-006qHD-FL; Fri, 06 Sep 2024 17:54:49 +0200
Date: Fri, 6 Sep 2024 17:54:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Daly <jeffd@silicom-usa.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ixgbe: Manual AN-37 for troublesome link partners for
 X550 SFI
Message-ID: <becaaeaf-e76a-43d2-b6e1-e7cc330d8cae@lunn.ch>
References: <20240906104145.9587-1-jeffd@silicom-usa.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906104145.9587-1-jeffd@silicom-usa.com>

On Fri, Sep 06, 2024 at 06:41:45AM -0400, Jeff Daly wrote:
> Resubmit commit 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link
> partners for X550 SFI")
> 
> Some (Juniper MX5) SFP link partners exhibit a disinclination to
> autonegotiate with X550 configured in SFI mode.  This patch enables
> a manual AN-37 restart to work around the problem.
> 
> Resubmitted patch includes a module parameter (default disabled) to
> isolate changes.

Module parameters are not liked in networking code. They are very user
unfriendly, and poorly documented.

Why do you need it? Is this change risky?

	Andrew

