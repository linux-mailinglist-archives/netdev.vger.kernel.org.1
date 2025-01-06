Return-Path: <netdev+bounces-155411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8FA02479
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A286B3A2FB0
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFD1D54D1;
	Mon,  6 Jan 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9xAwIld"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4521184F;
	Mon,  6 Jan 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163827; cv=none; b=OLYi6bc8bh4qHxkTLl8ACSqJ7B4TuPYE4dxDbYDmI6WCL2YqTYRwEAH8uCOXjmYMW3F1RkYPNJj4ZVkJ44VQlBu09rWPtFczHOlEhGgwZ52sgaXcKuK0iztD423PLHla5/hKLwr/NOBLfLZVXecZ/XO4tNq29Hi+Nt/TOL/7rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163827; c=relaxed/simple;
	bh=2ld1k+H+qBHYHKkgSbFa2Dfp5jAxjuza0MrZmW7YN0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttlskhp29BeMYOiyl03l1jNqQtm6b37e4LnW366HAQYixECMUtIsmHwYk2rzNLCAIcqDxT3nSSL8XwCfxZkvOP8L9H99zj6JzU2y4uaB7BHbuB4drPz0oaTosIhV9NZ1922tTWy/zctnRbVuxmJoGwM4zlTozlRMggT8amDC44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9xAwIld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB1BC4CEDD;
	Mon,  6 Jan 2025 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163827;
	bh=2ld1k+H+qBHYHKkgSbFa2Dfp5jAxjuza0MrZmW7YN0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9xAwIlddfb44RWO74tve99JFDXbzi1H65E6efSrl9gzub86Pd1aGYMJVgYtpqLGL
	 lFdOUmkKmuiRyRSS0E9+/06ri++u+MLUyS9VIlrJnL3A6NjT37D9Gg1Lg9ix827Nbo
	 9NztVD+21fn3o08mBIqHO13rAp9AALDvhvtGEvD1ZxTcsdqgysVtIffTAyYPTw1YVg
	 1PnNTGKF3x/bzL5Aj9bzrHKXYwr/dqhhv7YiQ1y/7yi9yDRd8rVT+TXMVzHmkGLpky
	 Eab4ZEzfeQxp6s+zXKNOrhVkwheYt/1/7tboPKgkV3sy6xQzFJ7g5B+tIh5S0TXpzO
	 um20DAh3HN2lQ==
Date: Mon, 6 Jan 2025 11:43:43 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/9] i40e: Remove unused
 i40e_(read|write)_phy_register
Message-ID: <20250106114343.GE4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-4-linux@treblig.org>

On Sat, Dec 21, 2024 at 06:42:41PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> i40e_read_phy_register() and i40e_write_phy_register() were added in
> 2016 by
> commit f62ba91458b5 ("i40e: Add functions which apply correct PHY access
> method for read and write operation")
> 
> but haven't been used.
> 
> Remove them.
> 
> (There are more specific _clause* variants of these functions
> that are still used.)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


