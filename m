Return-Path: <netdev+bounces-205080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CF4AFD134
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75E51C2227C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F342E5423;
	Tue,  8 Jul 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3JoKTaX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864621773D
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992314; cv=none; b=T0XQrepwsdozKnyBB1GEPtZGlNEDCM48Wjnx3odZsYAvXk0pPYfre5qtK9UQv/h4DB/N/K8dNekVXhnaUdOHVc0idIW1m91Raw+KWg36NFFIUlIWA3lpCddEIJV46CxdxIyYvacq98UBUULjb7rIrgJhTaVHVaqyBkqWiwzGur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992314; c=relaxed/simple;
	bh=DVsdgoa/d+ExpJvnG8KNpGkW7aHcxcAC1wnq+SPYp6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7rpqN/jQyNX9ES/0r7/rBgWYCcP7cQRk5rwpXnSahc3ZCeUg6gey81PpKPrjDLSn3q0MP+osclJtCuG7NjBI9wvPSGjbmCiIFDJO+4VoPaqMbqgxiE84kQGWFTJQ3Pfx8Z6FjtoCpDLeXHfsshb1WBWiCPDs4yeeUtY+lGmoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3JoKTaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CA4C4CEF5;
	Tue,  8 Jul 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751992314;
	bh=DVsdgoa/d+ExpJvnG8KNpGkW7aHcxcAC1wnq+SPYp6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3JoKTaXd0o3Jy+v6Mc2DCx+BRm1jEeXDe/WwPtJYZllkULNbeXIA1mIzinuIZ/8+
	 6qUvO5jxYmeb/pHFdMecTKFxi0RE7RuKeW/op9H1vCC9URuT5/do5K6LTUec30jhLH
	 NJdDSQRBWHkmcxQH5enodE5lWxq3iK9m9slxGOzRsZj+LCVeu9KH21EujkRRSlK9t1
	 iM2C7EMmoiycLq+G2hIq3kATz2XWO1I4MJJAGNvX5JJgHlWM1TuRxOSCjEtF9dLy8o
	 Us/GbDAs7eu0frJboPnQ3cUXFUXdkh4OilnJ/skl9/KfHFTxKyERi/y8SaO9/LWtMb
	 8HB5sxp/HWnlA==
Date: Tue, 8 Jul 2025 17:31:51 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [net-next v2] MAINTAINERS: remove myself as netronome maintainer
Message-ID: <20250708163151.GR452973@horms.kernel.org>
References: <20250708082051.40535-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708082051.40535-1-louis.peens@corigine.com>

On Tue, Jul 08, 2025 at 10:20:51AM +0200, Louis Peens wrote:
> I am moving on from Corigine to different things, for the moment
> slightly removed from kernel development. Right now there is nobody I
> can in good conscience recommend to take over the maintainer role, but
> there are still people available for review, so put the driver state to
> 'Odd Fixes'.
> 
> Additionally add Simon Horman as reviewer - thanks Simon.
> 
> Signed-off-by: Louis Peens <louis.peens@corigine.com>
> ---
> v2: Changed state from 'Oprhaned' to 'Odd fixes' after a quick offlist
>     discussion with Jakub and Simon. Also added Simon as reviewer based on this
>     discusson.

Thanks Louis.

Reviewed-by: Simon Horman <horms@kernel.org>

