Return-Path: <netdev+bounces-73293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22585BC8A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A1C1F21D27
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11069D0F;
	Tue, 20 Feb 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnKT9Vjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501768814;
	Tue, 20 Feb 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708433239; cv=none; b=stbnSB8RTLF4Uk+PB9bgjVZ2j/9Fr62QlLjCRJgQHG8saZnjcbo71JNOOtYzTi4W6ppNFLa4qWJj/cX5JCSH6axVukqZ2c5g+382e0kKbUI4FFyC5HKLvBxcLTtzhlNSjtj0veLG8YHvXKwX5sOru2PZgEEUyUdOXTogY2Uvxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708433239; c=relaxed/simple;
	bh=ShM9njjCxawrjQ/ZQDOu2m6lUpiT5zfxfZ1QJIMyxCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT864As0XAE+UAcbd7oEwp8pQA9SnjQjjztsEAiTr0hlO9DACyOZoV4KFWtb7WmGXp+xPnFKGeRdVksWKgRqw9J5ac2w23GKbYUnfw06j/8wzbf13d5bLUsr9+RTvqpCQdWe/d7wRyoup+BxVKFilRbQubEG+yCMUNF3+o1Z3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnKT9Vjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B92CC433C7;
	Tue, 20 Feb 2024 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708433239;
	bh=ShM9njjCxawrjQ/ZQDOu2m6lUpiT5zfxfZ1QJIMyxCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnKT9VjrUMqyDQrYKel4WSgau86TunXqwSFMQE+9PRrh3qtwrPflVSKAN4cJcGvuP
	 R8z2NhEwro7lMHdV9rFNNsKLVevei0YNk7fMSlp3K3vjeBNon5Ea9F330tSPiOd7fV
	 Atkk3B1mV1H8O0GKUbmqAXK3RSV3szM4t+0g8zCguFqvS2d91WJt/MsIFcJHpDI2dj
	 CiizMsTwhyODEa368kXAQDwX+8YBauRRD6JQRI4KsblbBbf/W3r7G4ln9LAVgTlW4r
	 no3e4MuxKdi++Ygcp+xrEMFoB9BTqVGQ5W+PZEBYcS7Nsg4MiQf7XWzjbmdAdOtWR2
	 H8qA3FdAL17RQ==
Date: Tue, 20 Feb 2024 12:47:14 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 9/9] net: ethtool: eee: Remove legacy _u32
 from keee
Message-ID: <20240220124714.GF40273@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-9-71f13b7c3e60@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-keee-u32-cleanup-v4-9-71f13b7c3e60@lunn.ch>

On Sun, Feb 18, 2024 at 11:07:06AM -0600, Andrew Lunn wrote:
> All MAC drivers have been converted to use the link mode members of
> keee. So remove the _u32 values, and the code in the ethtool core to
> convert the legacy _u32 values to link modes.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/linux/ethtool.h |  3 ---
>  net/ethtool/eee.c       | 31 ++++---------------------------
>  net/ethtool/ioctl.c     | 29 ++++++++++-------------------
>  3 files changed, 14 insertions(+), 49 deletions(-)

Nice :)

Reviewed-by: Simon Horman <horms@kernel.org>

...

