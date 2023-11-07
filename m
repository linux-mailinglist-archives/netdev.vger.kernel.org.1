Return-Path: <netdev+bounces-46437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F07E3D71
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD96280FDF
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8DF2FE21;
	Tue,  7 Nov 2023 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj/eqrYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716372FE1F
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DEFC433CB;
	Tue,  7 Nov 2023 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699360123;
	bh=UT5lonrit2LlwIl4rjREVNZ9SW/5EAlLOpoZpmK5k7M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Nj/eqrYonXF9Ey1XVs4bi2m8NCH39uN/5Jk1/OzY/ljhQc+SstaXiZsVReDpzavau
	 yp50EwXgmu8CNpW2tSd68BvrYHO/X4bKKJPG8B28nDpHyC/eT1gw1WNNhfvoRw4CxK
	 /bHyQrexQeaA4+Tsqr2Vtc+jHVbl8DGOl9GzpdfFIhfwvR2m+5shuMpKjQsF/X24Ft
	 twJxlq60JLJw/nA6BXfGHpehUZriNiR5rJnthEXp5l9olR8SFflQRVlS89DbAQE6U/
	 3GWWuyk29p27/yGTbVUp9exAmjulih20pLukuyVyJjrJSdn5nIjSChJJD/E8DWryir
	 RL682gtcIwEmw==
Message-ID: <973bcee0-a382-4a8d-8a2c-1be9b6d9d7ad@kernel.org>
Date: Tue, 7 Nov 2023 13:28:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hawk@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20231107113440.59794-1-linyunsheng@huawei.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20231107113440.59794-1-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/11/2023 12.34, Yunsheng Lin wrote:
> I have added frag support for page pool, made some improvement
> for it recently, and reviewed some related patches too.
> 

Yes, notice your frag stuff was applied while I was on vacation.
Thanks to Ilias, Jakub and other reviewers for handling this.

> So add myself as reviewer so that future patch will be cc'ed
> to my email.

I think is a good idea and I appreciate that you will review your
changes to page_pool.

There is a format issue below in patch.


> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Jesper Dangaard Brouer <hawk@kernel.org>
> CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> CC: David S. Miller <davem@davemloft.net>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Netdev <netdev@vger.kernel.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14e1194faa4b..5d20efb9021a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16242,6 +16242,7 @@ F:	mm/truncate.c
>   PAGE POOL
>   M:	Jesper Dangaard Brouer <hawk@kernel.org>
>   M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
> +R	Yunsheng Lin <linyunsheng@huawei.com>

I think there is missing a colon ":" after "R".

>   L:	netdev@vger.kernel.org
>   S:	Supported
>   F:	Documentation/networking/page_pool.rst

