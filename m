Return-Path: <netdev+bounces-59254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C081A166
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816F01F2308F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823E3B79E;
	Wed, 20 Dec 2023 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meSHw2KA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE533E47C
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 14:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372D1C433C7;
	Wed, 20 Dec 2023 14:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703083653;
	bh=9z1U3RetWEudOfRoW+2Rsw7gaHtLz2e7/4TZyR47V9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meSHw2KAwoJZP3H/55GdnAdDBwpljY2OAaZEsP9u9IdY4KuCVRdgzUqYaHpDOAoPy
	 5dnKZhZ70Q8BrKghGRjdgDa18KCDDAbTx6PAt6S3MMBlCj4BHsJpKyKn1Bs4nVf/J7
	 Qf4XbEsXURBIEXI19It1p4kzcm8QzT9lDhNbzWT9W1by59qcp7gJa6sho4Msr4yQ8v
	 ncmPHD9ePIPcXsEFljKxhzZvDhi1NKEGFilZpu2ZZVXnF0SOMU43rYG0nOxfu7ONNm
	 /4vdDa6I9Zwq/vUvpzurw+69uA9Of/iXXn8JyY0SaETRsPpSnfDI6MZZYMESJMbT9h
	 28+f4WzwEmDRA==
Date: Wed, 20 Dec 2023 15:47:27 +0100
From: Simon Horman <horms@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] dpaa2-switch: add ENDPOINT_CHANGED to
 the irq_mask
Message-ID: <20231220144727.GI882741@kernel.org>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
 <20231219115933.1480290-5-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219115933.1480290-5-ioana.ciornei@nxp.com>

On Tue, Dec 19, 2023 at 01:59:29PM +0200, Ioana Ciornei wrote:
> Commit 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
> added support for MAC endpoints in the dpaa2-switch driver but omitted
> to add the ENDPOINT_CHANGED irq to the list of interrupt sources. Fix
> this by extending the list of events which can raise an interrupt by
> extending the mask passed to the dpsw_set_irq_mask() firmware API.
> 
> There is no user visible impact even without this patch since whenever a
> switch interface is connected/disconnected from an endpoint both events
> are set (LINK_CHANGED and ENDPOINT_CHANGED) and, luckily, the
> LINK_CHANGED event could actually raise the interrupt and thus get the
> MAC/PHY SW configuration started.
> 
> Even with this, it's better to just not rely on undocumented firmware
> behavior which can change.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v3:
> - removed the fixes tag
> Changes in v2:
> - add a bit more info in the commit message

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

