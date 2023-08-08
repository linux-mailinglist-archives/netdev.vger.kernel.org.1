Return-Path: <netdev+bounces-25453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539FC774222
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8576128165F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A58C14F6D;
	Tue,  8 Aug 2023 17:35:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A501B7C7
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B272C433C8;
	Tue,  8 Aug 2023 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691516126;
	bh=j79vbDy7H01fnazYU9wmsmyWwIm8vpPLGwr5Zz9bZEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7udmcWmJ7pdKPn2xAs28DgWjrWpQVRJrXXLn/EUNRHNxdr+H4T0aQKZ/SeJ8f5UE
	 Gi1xz7bnLmtIswAMjOy5O6UpC+rhONEGI4wYChjihbB2m+JlZNIzH5gBcKlPzEumFN
	 BtIdXLrLrWN7ySUWdT+dtYTaU15CWTUbUuCq9TQ3+qqmbuiNaH0PjaDv/u7GPcHIds
	 2gruLokubl2uOIbie/ub7dtVFWNJM8B7TEUDtfjfuH2eaIFLNuj5Lybv3UeY+B647J
	 NwLpouJ0bQp8obDe1W9cARso4Jc8rBuyqGWySmZR+kwtwAzUbCHF/lts3IJR/aBzyY
	 IMxYCxht+PQpQ==
Date: Tue, 8 Aug 2023 19:35:23 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: fq: Remove unused typedef
 fq_flow_get_default_t
Message-ID: <ZNJ829PQK1Okaqem@vergenet.net>
References: <20230807142111.33524-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807142111.33524-1-yuehaibing@huawei.com>

On Mon, Aug 07, 2023 at 10:21:11PM +0800, Yue Haibing wrote:
> Commitbf9009bf21b5 ("net/fq_impl: drop get_default_func, move default flow to fq_tin")

nit: Commitbf9009bf21b5 -> Commit bf9009bf21b5

> remove its last user, so can remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

