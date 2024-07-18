Return-Path: <netdev+bounces-111999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A293474B
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 06:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264E8283283
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B877538DE5;
	Thu, 18 Jul 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I7RfWNzK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594A1E515
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278551; cv=none; b=uR+kDe3FtZaD5NxTSg19krYxm8vRDzkHpldr5aSri+SJNGrt5q1BmXkYzcHPfsraWXi4YtXz5Y3vXd60DMImV4WdK0IFkK0bDKAZ/1sswwygSO6hJ4nCl7T5daebh0CUvsXi9jvIfA8MV3AqqQwuTYjuX7RWiB3Fui396H0qBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278551; c=relaxed/simple;
	bh=5whHljIK83xoQGTv1LH0pWbRELkWRQb/sE4r4yFQcr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYamyG7z366BGHms5ML+KrfrrLDhycAj3Q46aySl6o5Kv1TdYxWTRRtIKcKGsjEpgND3EF8ev6/fnNW6Ek9sym3OLogIVusBpBTj9T6VZ2YafK/PGOCwCfQxo2PN1JqMjh5+lWOzeH8CEJQ7l011dgdzU0fep26pnuuCbbIUuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I7RfWNzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CC0C116B1;
	Thu, 18 Jul 2024 04:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721278551;
	bh=5whHljIK83xoQGTv1LH0pWbRELkWRQb/sE4r4yFQcr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7RfWNzKtroZQiVfn0Yk8B9RG333kZBX2wKafgGIX4C/zliPpuQRWhfQaHRii5M01
	 UFZEZEvWenFBg+7ufW9qWAe/zIDWVx8NU3rWbAOnpZMVfHdOtvQX2lm8VPQwmSQIER
	 /GM7MTWbSgVSXoEh/w0lxjf7QmKK4zR2eRdwDIAw=
Date: Thu, 18 Jul 2024 06:55:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH net-next] driver core: auxiliary bus: Fix documentation
 of auxiliary_device
Message-ID: <2024071825-resurface-ruckus-b875@gregkh>
References: <20240717172916.595808-1-saeed@kernel.org>
 <20240717170254.39dc7180@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717170254.39dc7180@kernel.org>

On Wed, Jul 17, 2024 at 05:02:54PM -0700, Jakub Kicinski wrote:
> On Wed, 17 Jul 2024 10:29:16 -0700 Saeed Mahameed wrote:
> > From: Shay Drory <shayd@nvidia.com>
> > 
> > Fix the documentation of the below field of struct auxiliary_device
> > 
> > include/linux/auxiliary_bus.h:150: warning: Function parameter or struct member 'sysfs' not described in 'auxiliary_device'
> > include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irqs' description in 'auxiliary_device'
> > include/linux/auxiliary_bus.h:150: warning: Excess struct member 'lock' description in 'auxiliary_device'
> > include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irq_dir_exists' description in 'auxiliary_device'
> > 
> > Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> 
> Thanks!
> 
> Greg, please let us know if you'd like to handle this yourself.

I can't, it came in through your tree :)

> Otherwise we'll ship it to Linus tomorrow or Friday.

Please do so.

thanks,

greg k-h

