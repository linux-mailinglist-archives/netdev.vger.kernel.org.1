Return-Path: <netdev+bounces-39194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BFD7BE4A6
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2077281A1A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2D37152;
	Mon,  9 Oct 2023 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxoGdX7z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90837148
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638CEC433C8;
	Mon,  9 Oct 2023 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696865054;
	bh=Kaj3Z1tW1udqMMePJvXDVKy+9Nhy223eBQjA1Yw3D5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxoGdX7zxlhxGhhl4Ah1dOAeE6EEl6CLB1lqKjtaOEU3JWTvuk9WNEfZLCVV2gZUv
	 kWMswm4XyKMW4cVei9WtelWjjj5Rg72d/IBLSizDicH2x2QSVrYL9AguKfTBmL7oDG
	 uWZmUpbPo6ICEE2NutNLqzGIFhjeJsxQSE8qvosM=
Date: Mon, 9 Oct 2023 17:24:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wpan@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/10] staging: rtl8192: remove unused legacy ioctl
 handlers
Message-ID: <2023100900-plunging-pajamas-2d7a@gregkh>
References: <20231009141908.1767241-1-arnd@kernel.org>
 <20231009141908.1767241-5-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009141908.1767241-5-arnd@kernel.org>

On Mon, Oct 09, 2023 at 04:19:03PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The .ndo_do_ioctl functions are never called, and can just be removed,
> especially since this is a staging driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/rtl8192u/ieee80211/dot11d.c   |  41 --
>  drivers/staging/rtl8192u/ieee80211/dot11d.h   |   2 -
>  .../staging/rtl8192u/ieee80211/ieee80211.h    |  12 -
>  .../rtl8192u/ieee80211/ieee80211_softmac.c    | 563 ------------------
>  drivers/staging/rtl8192u/r8192U.h             |   2 -
>  drivers/staging/rtl8192u/r8192U_core.c        | 109 ----
>  6 files changed, 729 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

