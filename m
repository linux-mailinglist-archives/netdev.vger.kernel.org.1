Return-Path: <netdev+bounces-198987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2EADE956
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320923ABAB1
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90228505F;
	Wed, 18 Jun 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ3qRFXa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25401DDA24;
	Wed, 18 Jun 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750243375; cv=none; b=OVbrCbSPWm1ccwt9M6OYgaXiQkX2fJSO+o7E5bugB6HpBec8e6lEW37RzJNZeXAd41mhJTP7JWJLBgpAPrV+l8Nwm/eBLo9mEtE2FJHfIofl+jGnSw7BMTh+Vf5LHFEP4n7maK+TSQ9TwC5kc+VobYWTxa6M/tl0SiSVW0h2cM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750243375; c=relaxed/simple;
	bh=d5kyxp2BL+9+TNglvdVDKaFudzh1QFaGGdvtoQ+OgXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4eNRs5W6FqCUeXOiLGQMcoeNTvQY99/xZxy95/LMnaztMTdQnzc6nHxRqnx8enfxBQPeYtpqEgE74vr0dAIUrfsbe8DFUuasPLgNiloQ1qNHbWHOzAr3A5EgCWXq/pgry0NGQabooyUtv1arZXDc0rRsLasm5D0V1/WtesUAXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ3qRFXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C787C4CEE7;
	Wed, 18 Jun 2025 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750243375;
	bh=d5kyxp2BL+9+TNglvdVDKaFudzh1QFaGGdvtoQ+OgXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ3qRFXapXezadzsKxiw5i62jmD/DVJVvAj2feePmAvTv443uRnBcq3K087+3SV3M
	 //PwTF03BA0RiLTbytcHwyyffpU/ptYN+xuxsTIw9ghlAoDTuzr5bZ1q3f1C++VMEE
	 yShHHN8YuZXF3tDfOM7t9dob3RDJRcdRbz0fdAdndQ/LxC7jmhTvb8E210YWbyUaBg
	 bbeaHuM/qGBgv7HgolMmF3+s6dj7tmuujKR29cp9Tgn78Ud9IBCqRdp9uNzzRz0CuI
	 OrgMyUCN2dotCSQp5HOHLySctLESnBt7Iaq+Qm7K1vYmDqn2HMOlJC/OVS83EfsXhb
	 bdsnB0Ytvb46A==
Date: Wed, 18 Jun 2025 11:42:51 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net-next: gianfar: Use
 device_get_named_child_node_count()
Message-ID: <20250618104251.GD1699@horms.kernel.org>
References: <22ded703f447ecda728ec6d03e6ec5e7ae68019f.1750157720.git.mazziesaccount@gmail.com>
 <aFFVvjM4Dho863x2@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFFVvjM4Dho863x2@black.fi.intel.com>

On Tue, Jun 17, 2025 at 02:47:10PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 17, 2025 at 01:58:26PM +0300, Matti Vaittinen wrote:
> > We can avoid open-coding the loop construct which counts firmware child
> > nodes with a specific name by using the newly added
> > device_get_named_child_node_count().
> > 
> > The gianfar driver has such open-coded loop. Replace it with the
> > device_get_child_node_count_named().
> 
> Just a side note: The net-next is assumed to be in the square brackets, so when
> you format patch, use something like
> 
> 	git format-patch --subject-prefix="PATCH, net-next" ...

Hi Matti,

It looks like this patch has been marked as Changes Requested in patchwork.
I assume because of Andy's comment above.

Could you address that and submit a v2?

  Subject: [PATCH net-next v2] ...

Otherwise, this looks good to me.

