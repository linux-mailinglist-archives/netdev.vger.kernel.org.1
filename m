Return-Path: <netdev+bounces-126854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102AF972AE7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424BA1C2386B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2A17DFE9;
	Tue, 10 Sep 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFWX5UBO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396917D8BF;
	Tue, 10 Sep 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953795; cv=none; b=iFDX9ZfMAV6RvD8TnX7AFHwICTwliPavhT1L3/HCEpYLpAuONJQeP+AKSP7fy3PksUMV3lk2d9YeZ3qjKwYYbvxP49c0/UPcCYUP0ozbr5udUZ73hulWSAvBNRy/UswZeIFs+xJb/13w/PDWPonoleQJ/bOpzkOyGIZr4Mk+Q1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953795; c=relaxed/simple;
	bh=ITn2Rn02uOxUMwunV+FyrfoKzyBtVa+mpdpYLRIZAFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XewwsDe3dKblQW5ke3QKEVajQ2HWlHxyxo00WzBNgeEKyg6Umt2eDigOtpJ3y7BofaMgfgqrEUeNCU1SI6v3HNkAdt/OP9xkYysf3z1JFnOo3E09QFdBpWW9uTt8CkLBE5l+6EubaF3Fuft5HYf7nxmH219iNF7bQWsNHsdZ0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFWX5UBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00141C4CEC3;
	Tue, 10 Sep 2024 07:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725953795;
	bh=ITn2Rn02uOxUMwunV+FyrfoKzyBtVa+mpdpYLRIZAFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFWX5UBOo4/eSqAfVomeHfa+dp0cNkRJNWajzquz6U9O71yc1C9YwUGeu3XcOxX+T
	 Y7igQOldPchZ5cAUyxZnoQ26K5wzVbeWB5tKzPBw0kdpAaxWn4clKzM+GgU/Mi7hPc
	 FkZJoemxDBDP11NJDUtfN2CaESOTa9CaaptU4rUs2mFJ/qkLn10eEO6kbm41r9vmAb
	 lDpmHWSzVxoUUMQxS641ghSa2N1g25AjTsyG4guPXP10U3uizhoIwTDkCWeiXl1H0l
	 XoZfSl5Ww7wS1uy4xDuN+F0bMkLiQCuywt+uZGmB0ehGck230nbd6aukl30sa9O2Iy
	 cu5LYWNI/zHiA==
Date: Tue, 10 Sep 2024 08:36:30 +0100
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] r8169: Fix spelling mistake: "tx_underun" ->
 "tx_underrun"
Message-ID: <20240910073630.GC525413@kernel.org>
References: <20240909140021.64884-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909140021.64884-1-colin.i.king@gmail.com>

On Mon, Sep 09, 2024 at 03:00:21PM +0100, Colin Ian King wrote:
> There is a spelling mistake in the struct field tx_underun, rename
> it to tx_underrun.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks Colin,

I've confirmed that this addresses all instances of this problem
in this driver.

Reviewed-by: Simon Horman <horms@kernel.org>

