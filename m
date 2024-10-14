Return-Path: <netdev+bounces-135270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 494EA99D46B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFFE28109C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E96D1AF4E2;
	Mon, 14 Oct 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL/TU/gf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A81AE01F;
	Mon, 14 Oct 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922376; cv=none; b=twudfaxidN39shc0o6RMU+LiT6mE9Gevynb3PAeAjE6k+UoLz4Lkwfb8iBnoD/LcwphfqTvQKJqNv2gY6fWjAfSPPoZXlg0T7eJnRZ113TcDid9Bl3Qj82K7QqD5bNMTs82rGaGAIbJ97xt4u020xHJAnAL3yzc4JHGEi0dnF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922376; c=relaxed/simple;
	bh=Jy9qCuF3F6u+NQh7djhxUE/RTDKCSzOtuawvTPfOFcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgpX45bGRgG7L5OetYB46VTee6cq8SVfCEK2X5Rqh6i3rVkM/AcvAJV+ghVpfhTst3BY8TQSKUcpyOLogDn6nDRNQfPkjSmXdZdj8CPLU9cRtTxG5BILbKfKH5l+02Y1R/lUKTzGW+uJhTzZrfimILEsYCk9pIDLDFfFuqU1xoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL/TU/gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F645C4CEC3;
	Mon, 14 Oct 2024 16:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728922376;
	bh=Jy9qCuF3F6u+NQh7djhxUE/RTDKCSzOtuawvTPfOFcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sL/TU/gfmlU1eMyN4/FqXz3D4IevbzTuYlwDWCUtkh4y9RhF4tXVJV8BPzAGfVCtP
	 KVgxXrdc7WIx7VnaXrhCA2kU+UeebcLZoMSP3bajP88ewsJOGOfsm/vhVIbskoRhsv
	 DsIjYxqQFwxE8bukCBcmoRKmzCzw8Xj5FTPdFhxMOWhkaHM+uVXL0ICKB4UmRPWTKa
	 lfQVU5i6YKb3YbKEyS0KdAp6SeGIa8jCq+f1zJ5RCjJ9R9UKW/ch3+aWaVXxBKqi5F
	 wOZt5WyaYdxO4k6II+po7WO3ge5n38OpOSUtItPSZr3ydibGNq/zCM71xWPbtlpYZx
	 7qnUxXRNH9SrQ==
Date: Mon, 14 Oct 2024 17:12:51 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: systemport: avoid build warnings due to
 unused I/O helpers
Message-ID: <20241014161251.GW77519@kernel.org>
References: <20241014150139.927423-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014150139.927423-1-vladimir.oltean@nxp.com>

On Mon, Oct 14, 2024 at 06:01:38PM +0300, Vladimir Oltean wrote:
> A clang-16 W=1 build emits the following (abridged):
> 
> warning: unused function 'txchk_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'txchk_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> Annotate the functions with the __maybe_unused attribute to tell the
> compiler it's fine to do dead code elimination, and suppress the
> warnings.
> 
> Also, remove the "inline" keyword from C files, since the compiler is
> free anyway to inline or not.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

