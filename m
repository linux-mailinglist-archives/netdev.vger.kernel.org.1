Return-Path: <netdev+bounces-168692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0762A4034E
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9A18995E0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1969B204685;
	Fri, 21 Feb 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFYwwobX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703C202C4A
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179401; cv=none; b=AKSOLaL0/pCb43yiKuR4uxXE7l2aSU4bMyAdXVi3Rfs75JXYNIOGl+HpUl34kW2EzqxtwcIADy5Px6x9xbeMBtIYq0RhykLQH6h/Pko6P6dmFDRcri6AVCgPfEAT5FGY32CMdqqcN5bO1820GM+6l1y7dyGq7izw3H7HvcmQRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179401; c=relaxed/simple;
	bh=Cf23GGLqZyUYiLVvfWf1R1mpv38mYgykmRZovfAV2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nmga9o7FZmGmpPVXfAVXhzbMEWTVO/2ZYZyqVIKqgxV1Vw2GxhQoNjXDgjMNJvKONdQGhIjpQh/YomtoNc+W7i/DU4b/V8E6hxU5u8uyyE/qyLqul3giQVwPh0wLpUc+IGhq3Gdzw5RxttwCTK3zrecdhic6E8Jl6HceDWY+Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFYwwobX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E082C4CED6;
	Fri, 21 Feb 2025 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179400;
	bh=Cf23GGLqZyUYiLVvfWf1R1mpv38mYgykmRZovfAV2d0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZFYwwobX5Lp1Y1nVbD8HJltFsTGWciMz3c1TgpAvf9RTgQw9fyb3vutU6AOcABUgB
	 ChqDGwOUnjs9ZBjGwstKXwMYDIOB1T/EaQ5AndBAept0bP7SqfR7pen+Nnu74H1JLx
	 jvkRUjVtMTXubsLDo6cpi3hAiOgdQq7r+kv0J0WDIHB5wAcxI79iwnbysvrIPaB+Uj
	 wBLrco0GUroljMscjCQJHWIzON3LCWs1yQ8a6158OGLv4MPY024Xo2or6yZ9SKz96e
	 w8MJQuoruoPxohgCNM1+qNdSvOnZgdtBS0OhIKhUlDsqyDUcMaYJZHkEZDqO7LC9pZ
	 4SkdOAX9LiUJQ==
Date: Fri, 21 Feb 2025 15:09:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RESUBMIT net-next] net: phy: add phylib-internal.h
Message-ID: <20250221150959.16c8cbbb@kernel.org>
In-Reply-To: <82e4dfdb-5140-4b8f-8f61-099a52545389@gmail.com>
References: <82e4dfdb-5140-4b8f-8f61-099a52545389@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 07:52:04 +0100 Heiner Kallweit wrote:
> +++ b/drivers/net/phy/phylib-internal.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

nit: checkpatch is displeased with the comment style:

WARNING: Improper SPDX comment style for 'drivers/net/phy/phylib-internal.h', please use '/*' instead
#100: FILE: drivers/net/phy/phylib-internal.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later
-- 
pw-bot: cr

