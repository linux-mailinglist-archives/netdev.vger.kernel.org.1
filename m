Return-Path: <netdev+bounces-29118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1065781A75
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1E12819C8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3111772E;
	Sat, 19 Aug 2023 16:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE7AA57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 16:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB7BC433C7;
	Sat, 19 Aug 2023 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692461609;
	bh=9A60vYcuHVQ0JVnVn9Fac8bDwlC317uaEYCYeR5BViA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELKcx8IhchMOLXFPA3nJ1J0+PT7hnIOdNz6ZSgNn5hpdkppabM4u/bNIAU/EnCILX
	 Y252q8xwZxwEK5uHL9dkcUCvpEBwF9uAuaS+SlMUrLKqc+t+39g7AKqL5OkTiHFsGJ
	 wEXSXsFKQkFeNc1t6/Wb08vgicx8nBM1RNDa8m3+HMXm7XDcKHWUrZmH9ydi6tyRnF
	 qlj9ZQQHrC973owN6sWrohpnhHEJ63Qz4AzPw9wNga47iWuAs28q+uwh+rrm0Qk3k6
	 npPBreBLNHxAdCEu8tSpeP24z7BX94Z/tTln0gN4zfiQmpnShvLWqZS+/TBSXhmT1F
	 rG2ChLYw7h6CA==
Date: Sat, 19 Aug 2023 18:13:26 +0200
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: add entry for macsec
Message-ID: <ZODqJkA7VxJjxUpc@vergenet.net>
References: <7824cdb3ca9162719d3869390de45a2fc7a3c73d.1692391971.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7824cdb3ca9162719d3869390de45a2fc7a3c73d.1692391971.git.sd@queasysnail.net>

On Fri, Aug 18, 2023 at 10:57:49PM +0200, Sabrina Dubroca wrote:
> Jakub asked if I'd be willing to be the maintainer of the macsec code
> and review the driver code adding macsec offload, so let's add the
> corresponding entry.
> 
> The keyword lines are meant to catch selftests and patches adding HW
> offload support to other drivers.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


