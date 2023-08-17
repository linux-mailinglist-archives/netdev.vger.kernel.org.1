Return-Path: <netdev+bounces-28571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FAE77FDF4
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 20:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A928217E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB99168D6;
	Thu, 17 Aug 2023 18:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6214AA6
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 18:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF3EC433C7;
	Thu, 17 Aug 2023 18:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692297466;
	bh=hnAMtfnR4/iCHxdxaSawxihOjEQt74MbELRDgzaV8So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXbaIqI9IdNYpD2zFGkNI8g++T1jJ3HtJ2+dI87d774CF6W+ANVRwsdsIScV5DcR1
	 uSBkoFiNoQFX8bmDZGMIzP81jQVNjDMvd1sjlXiktL52LQb/4uldw+L2uFynQ0/QzK
	 o7z4glysXIzkVfDSO6bwCDuUKTbJ/9emQUms6nFi6PLKQqFW9Dod1oFb8o+A+tmAKJ
	 hE+coPh9MXkjAYcMEmgoRVJwXVZn5IAGLVC4pNWeWLvbUcZtMNI2dFu/qKNyre4EmX
	 4Twka88lH9CP813acwZXzqZLaB9nR+7nkVcu9HYKINB6nxSgXmkTeVAW0eaw3+30oC
	 yb1g/Ej+8dOdA==
Date: Thu, 17 Aug 2023 20:37:42 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, idosch@nvidia.com,
	petrm@nvidia.com
Subject: Re: [patch net-next] devlink: add missing unregister linecard
 notification
Message-ID: <ZN5o9l4skPXjamuj@vergenet.net>
References: <20230817125240.2144794-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817125240.2144794-1-jiri@resnulli.us>

On Thu, Aug 17, 2023 at 02:52:40PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Cited fixes commit introduced linecard notifications for register,
> however it didn't add them for unregister. Fix that by adding them.
> 
> Fixes: c246f9b5fd61 ("devlink: add support to create line card and expose to user")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


