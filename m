Return-Path: <netdev+bounces-62089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FA825B2F
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 20:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC541C23849
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 19:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407B11DFC6;
	Fri,  5 Jan 2024 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbEzAETx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755236094
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 19:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972DBC433C8;
	Fri,  5 Jan 2024 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704483633;
	bh=rcr+TygorjDrVPlq+/a122ACXhjFcwR7X6x0Ab1dv/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbEzAETxtM21U8TyvrwuBdB6pujrXyQz+CBOpLd4rYMiv8VnMjUgbiDz72jDaBHWM
	 0Aa3y+sxl1tW5RFOP3XkM1HBRbbw56XTZ7SBS4ziMNBpRu8nG9xn92A4ajA/yGLJTh
	 EgBUnw78w9l8HTgx5tmluYSW9Nfh//q09CVMH1SjKIrwfIxwDxdhbO6BVnzxzlcboE
	 sq5tDmQhIOvE4LrKUyhIc5ZvPqQBCuOV9NU9U5mgk796hz45aTYtZM2+vmKw9hCPJ8
	 jhxc+TxdRPXtPVnezSRmGSunbFKfmWykY9Wfh74HXPWQPhUD0GOdTPVps1nEC8tzmQ
	 /kWWjJ2YFhzhw==
Date: Fri, 5 Jan 2024 19:40:29 +0000
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadfed@fb.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ptp_ocp: adjust MAINTAINERS and mailmap
Message-ID: <20240105194029.GA31813@kernel.org>
References: <20240104172540.2379128-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104172540.2379128-1-vadfed@meta.com>

On Thu, Jan 04, 2024 at 09:25:40AM -0800, Vadim Fedorenko wrote:
> From: Vadim Fedorenko <vadfed@fb.com>
> 
> The fb.com domain is going to be deprecated.
> Use personal one for kernel contributions.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@fb.com>
> ---
>  .mailmap    | 3 +++
>  MAINTAINERS | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Thanks for also updating .mailmap

Reviewed-by: Simon Horman <horms@kernel.org>

