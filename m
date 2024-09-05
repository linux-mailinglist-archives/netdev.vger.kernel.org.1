Return-Path: <netdev+bounces-125711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE5196E4FD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BB61F22125
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841C1A42C7;
	Thu,  5 Sep 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CcvLXzIs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F97194C69;
	Thu,  5 Sep 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571374; cv=none; b=g+vrRY5SeaggIkD03SkkP/TEcmJtO8+PszXz+mqGSODRhPiOv7oyzkdz/FXuQzZzED3dGm41NEai5BaS2oroNOboHTDGAeoeEtKGW3fE/OJHE5b1D9N0uS8YupO+Zkq99RlxFHwxYgp+l2aK7puhQF5e4gFTmnMfReiFTefUoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571374; c=relaxed/simple;
	bh=N7fa6cNzUHAH9gtRy7A5YtddH/582fmmyPQKtWDpzTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9tKCE5QOhJT6OO9EHQKPUE2Q0Zktq7jAbzyGoIAFbcdSBsueFFw7FCe7Ttbjp4kxhQBnCZFGqWyWdZXhZyH6J0ca6wqUriqV6EGJ9MWpLLaI5gJBvfLuBF/8OGY8ErWYcrGilck3f1DkJNfswnv9QhMJz+RNea9bvX4YyOJiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CcvLXzIs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DePmXEe1FqcxY5TS4rD2PMk94p+rGsaSN4SkaQP9boM=; b=CcvLXzIs/f+QwssyYvEZER5qaK
	d2greWAUK4lPKyPxF/Y2Asv9/U3ULnMgkGDhQB3GFfIRK8k4kMIutDIKfxq0tDpusYJhtIeq6xHTq
	WYeC+HvKKAVmEMSoDEFKCjMiJmCI4i5jPDahSLAkbiOr0ge/HaOWW2v2RvcbW6D02of8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJwF-006ivU-2F; Thu, 05 Sep 2024 23:22:47 +0200
Date: Thu, 5 Sep 2024 23:22:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 7/9] net: ibm: emac: replace of_get_property
Message-ID: <24384374-0978-46d3-aa3c-48bfe8cd8760@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-8-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:04PM -0700, Rosen Penev wrote:
> of_property_read_u32 can be used.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

