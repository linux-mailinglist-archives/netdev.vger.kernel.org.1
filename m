Return-Path: <netdev+bounces-117663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68DC94EB72
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B86281EFB
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F3170828;
	Mon, 12 Aug 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYQA7LNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3516E866;
	Mon, 12 Aug 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459677; cv=none; b=DSCLJcdfM9+jvRevqSmJNSNZHHB9bduZmEKll8/jtAEI58k1ijEema0HUrYsVNnw5OV8KNG8Jl76h+x+1nQLDWEj39XSi01LLb5JiGPdLK6Lne3ICm9AGW0Ci9yZ/OQbiEcNvLOwwXH9fcWdaXDa1yaXSw1MkKS5BMssDHHso/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459677; c=relaxed/simple;
	bh=+eZwHjXG9/YRGWedIAHEi2SgF8XJyQypv3ioCyuK2gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIF90RH9aS0YGX3KqBJFPrgG0IJtTVZdfIsG+dlVvaobBBOpxcGdOUxdXD4psvNnY+YCZfP8eSq9Ijqyp/On27NYwCOqlzKTnFUEndtkggCJFZH73WGotEHGps4ocJ/eoMSf84ZIziCTnnV8cntVozkzR4moBofZ8TNxKVShEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYQA7LNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AB0C32782;
	Mon, 12 Aug 2024 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723459677;
	bh=+eZwHjXG9/YRGWedIAHEi2SgF8XJyQypv3ioCyuK2gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYQA7LNYx1WExe7n+HCY0CAID7RoXv1wVcw7clWW63Pc7VGPbjlshx345kZHqTGc3
	 6BZ3wUHh6xl2Y4aw1I6lPd86rC/tUX8yWc9D+NJevchaYmHedVssyj8FNcUwY55r3j
	 Q2RFP9UVWHEYSDotFoCe+pv6ISUfLSDyxJ8msyDQW1NqMHoBCMgi3X1X1kIuJmbxw/
	 SOti1zKJfi0V4X+yfRiYYbd3iuaNNxtjrrZtsHxepCG8O84A7EWXwoz51gUDSodqtH
	 e2HekE6pHEQAAdd8Iz4C2Y9tEwBAJKrB7t9ada/of13q7NX9m9n/0WBsSgjoZzBpw+
	 /RwcvxDCXNd0Q==
Date: Mon, 12 Aug 2024 11:47:52 +0100
From: Simon Horman <horms@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: dlink: replace deprecated macro
Message-ID: <20240812104752.GC468359@kernel.org>
References: <20240810141502.175877-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810141502.175877-1-yyyynoom@gmail.com>

On Sat, Aug 10, 2024 at 11:15:02PM +0900, Moon Yeounsu wrote:
> Macro `SIMPLE_DEV_PM_OPS()` is deprecated.
> This patch replaces `SIMPLE_DEV_PM_OPS()` with
> `DEFINE_SIMPLE_DEV_PM_OPS()` currently used.
> 
> Expanded results are the same since remaining
> member is initialized as zero (NULL):
> 
> static SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
> Expanded to:
> static const struct dev_pm_ops __attribute__((__unused__)) rio_pm_ops = {
> 	.suspend = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.resume = ((1) ? ((rio_resume)) : ((void *)0)),
> 	.freeze = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.thaw = ((1) ? ((rio_resume)) : ((void *)0)),
> 	.poweroff = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.restore = ((1) ? ((rio_resume)) : ((void *)0)),
> };
> 
> static DEFINE_SIMPLE_DEV_PM_OPS(rio_pm_ops, rio_suspend, rio_resume);
> Expanded to:
> static const struct dev_pm_ops rio_pm_ops = {
> 	.suspend = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.resume = ((1) ? ((rio_resume)) : ((void *)0)),
> 	.freeze = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.thaw = ((1) ? ((rio_resume)) : ((void *)0)),
> 	.poweroff = ((1) ? ((rio_suspend)) : ((void *)0)),
> 	.restore = ((1) ? ((rio_resume)) : ((void *)0)),
> 	.runtime_suspend = ((void *)0),
> 	.runtime_resume = ((void *)0),
> 	.runtime_idle = ((void *)0),
> };
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>

Hi,

I don't think that there is a need to repost because of this.  But in
future, please consider explicitly targeting Networking patches at net-next
(or at net for bug fixes).

	Subject: [net-next] ...

That notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

