Return-Path: <netdev+bounces-59704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BB381BD64
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F521F22244
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B462810;
	Thu, 21 Dec 2023 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPYNpsQJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2262809;
	Thu, 21 Dec 2023 17:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC47C433C7;
	Thu, 21 Dec 2023 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180288;
	bh=MnlVR6g1JlvH75LJxa4t7EwwnJTHya6Dp6FThj6ij0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPYNpsQJgP8QP0QOUBvdjqF3sTAU6knVJ/Mlv3O8zCezPmE+7FgpGt9OalBfDc4dx
	 3xQp0sEyCI0Gs19ToAEeho5g6tpoJj3Y07NKdX+YUvnhKfs59sRfw9crkKzn+X/Y0f
	 k5/r5BpnoBFm5FopuCf34x24+8KOQ4V4ndqY0b7LCceFVkWQ5NJT1aO3yM+M4iabbZ
	 MiVGLu9iU/Prlmd4byPsfPaWWc3hnojRXPogL0Q6ezh8+hEEEaiHxcb5ggc+i4MHGm
	 g+CdGXSjB+MrvsC630uvJsne1K5cC6fYmYpYpXunoxfFnsf1MOnlVGI6tKvOJnF9qO
	 QJM4VLIYe28nQ==
Date: Thu, 21 Dec 2023 18:38:01 +0100
From: Simon Horman <horms@kernel.org>
To: YouHong Li <liyouhong@kylinos.cn>
Cc: paulus@samba.org, linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] drivers/net/ppp/ppp_async.c: Fix spelling typo in comment
Message-ID: <20231221173801.GB1202958@kernel.org>
References: <20231221024448.1317341-1-liyouhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221024448.1317341-1-liyouhong@kylinos.cn>

On Thu, Dec 21, 2023 at 10:44:48AM +0800, YouHong Li wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> Fix spelling typo in comment
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Thanks.

For the record, I checked and codespell does not flag
any spelling errors in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

