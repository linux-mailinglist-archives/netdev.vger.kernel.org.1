Return-Path: <netdev+bounces-130616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C350198AE92
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A430B20ED6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02051174EF0;
	Mon, 30 Sep 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GmeAP3E2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB9B2C190;
	Mon, 30 Sep 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728803; cv=none; b=IFK7/rUuO8SoC+6XFfPHRpxPT1/ou1OUoAj0AzFUCdtj2WIuhDcfwg0hYfPtrsTN0CfwACD984p2U0f7xqKF3KnUITcX1WQPDeS3ct0li1rx0tR/o/EUhRkzF6N9SDg7FQWAMhn22AMmQyNiU2ce+2OvobJP8tWU0mzpArrw390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728803; c=relaxed/simple;
	bh=bhXfvGZDVJHVgM7xQOfYMGdb7f3NeP19/gm9FEGOc6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMjnVGsXylc+SHwmByU3IlDAqPVHaRVoPF9Q/QHorW+YANC7qKp1p8PEdDUjckT6ENbZ5XOU0tCxVrpwYxFCEwdvOwy/Unp7U42McAW6sXQvSCx1Nag2rKhOMr3fKxxvEuQdrnXChgnGyFxpZvPH/ThOsZ2pjY7az6lo12dg5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GmeAP3E2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MCv8uzyJdTNamrWhSOefnlx6mapAKvjaWzNFNqjV9CI=; b=GmeAP3E25pLefMkfEehtbhdRhS
	sjdre0xUqNjGjJOl/bWxCzAaJYzHqLxrVbR4zmvN1glmZDe6da7mIjgDZxiX6Rwd1+PPZvkCg+ZbM
	nCEvMrTuUD6BnPOamcs7PVUxSsTCtiGigZtyKCmt53gviGkVSwkeWiFBp1rSOy4bjPv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svNBT-008fGy-01; Mon, 30 Sep 2024 22:39:55 +0200
Date: Mon, 30 Sep 2024 22:39:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: mv643xx: use
 devm_platform_ioremap_resource
Message-ID: <ef667d4c-8158-4fa5-be1a-ed92e1a07534@lunn.ch>
References: <20240930202951.297737-1-rosenp@gmail.com>
 <20240930202951.297737-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202951.297737-2-rosenp@gmail.com>

On Mon, Sep 30, 2024 at 01:29:50PM -0700, Rosen Penev wrote:
> This combines multiple steps in one function.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

