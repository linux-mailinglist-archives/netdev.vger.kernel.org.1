Return-Path: <netdev+bounces-37662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96A17B6813
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 71FEF281586
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225142137F;
	Tue,  3 Oct 2023 11:36:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8A208DD
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C18C433C8;
	Tue,  3 Oct 2023 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696332997;
	bh=EOAx/Sls7moMrznZ9XdCubZYS0GeC4469Z6iTVQkG5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTR/wtxgPnnv4AkPLphIGAtsECUWlhwWMSdwuyYIMpOqWTZIl53yxziqz7gmjoH9Y
	 own6UBMKcIUYzONnRgwHodskvkx0qYnK62qwSKHVYpv8jlin0Ew1+7rw3BCo96XUCG
	 FSzq2/6osEjrlnpIVpViibYxo5xuvVVYNh2lxFwoci9BF2fGUVux9Qvo/VpiBbZDO7
	 m3q/jyXLWVNpeEklgVl7SRmQXY8bwhvh+YFOi7Lm637RaMFsca2Cj0iP3mCGcJuPzw
	 n8jnh14xm4KdKPjr+qAwboSEFshe5jou/z/gj8H8PntmOU4UbiKm8amAdTIvAg/+W0
	 Cva8UlIRXxbrw==
Date: Tue, 3 Oct 2023 13:36:33 +0200
From: Simon Horman <horms@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] devlink: Hold devlink lock on health reporter dump
 get
Message-ID: <ZRv8wZwVLbdrUafr@kernel.org>
References: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696173580-222744-1-git-send-email-moshe@nvidia.com>

On Sun, Oct 01, 2023 at 06:19:40PM +0300, Moshe Shemesh wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Add devlink lock to the callback and to any call for
> devlink_health_do_dump().
> 
> As devlink lock is added to any callback of dump, the reporter dump_lock
> is now redundant and can be removed.
> 
> Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


