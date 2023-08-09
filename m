Return-Path: <netdev+bounces-25911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47177626A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7491C211A7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9A19BBA;
	Wed,  9 Aug 2023 14:27:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE1319BAB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B804C433C8;
	Wed,  9 Aug 2023 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691591235;
	bh=tYlEbi5+evjgrHRVEwMcn++R/SQS1SOurpc2+D9Uskk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AC8ucGXuG8RHJC+TX0N+aTMkVi6mIRHw+Er0iaEFMvkgo7na+i6ulUpxpqYHS9on9
	 mhKPcfSR8lMdiKMy2h1DaD0osIWgvGk3ElzPOyyB/pXNPnB1cqbqbncAQO0k6AnjwR
	 Shsxr3SiJdjvYZTWvjtSDCfqzo5MTGyDiciRlwXAIWAiPSf+JN3vHzqeUs6wEh01fr
	 qA/TAyW7Y9BuGKXeaXGw/xSvnXEz7/q/Lx2fjVjVNPiGtNMJrAuXosCe/qbc0GQHct
	 JY3jSZ2Qrk4N302GY+Lm6JojYS8Wpanoprr99z2oG82imMClq+/cQcP/HNacekfCxc
	 HbxD1rY7UktSw==
Date: Wed, 9 Aug 2023 16:27:11 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next] devlink: clear flag on port register error path
Message-ID: <ZNOiP7yu5h7d9mPQ@vergenet.net>
References: <20230808082020.1363497-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808082020.1363497-1-jiri@resnulli.us>

On Tue, Aug 08, 2023 at 10:20:20AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> When xarray insertion fails, clear the flag.
> 
> Fixes: 47b438cc2725 ("net: devlink: convert port_list into xarray")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

