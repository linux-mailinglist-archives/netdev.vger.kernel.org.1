Return-Path: <netdev+bounces-33787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2E97A020D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D73F281F32
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7353208C8;
	Thu, 14 Sep 2023 10:58:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BC208C7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 10:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72486C433C8;
	Thu, 14 Sep 2023 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694689088;
	bh=rUYhkyTuPj7ApZAOUD6dArBv3dyDSPnmyCzau1cFCjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M6wtWjAAF7WGBRZnKIphw8mUEmVkovGFAXaqBr30m2bL5aXGOSsjprP+jUwzbJsYY
	 ySMfW4/zqW3RLQlcQUSeT/+7yDZ9SIwOiEKT3B2mN38XX5IDRltFUreU0Dnec5pqs+
	 zs6L/KIg9Gcltbt1RBvz+XPQaRfBmDxEqCvdLNRRn0fLURHPqu5vsWd+DLZkLXYoqk
	 5Z7933TxFbGi5AajdnYQe4nLBi17JKp51yId+BWfGfpWIFjeoaA14KM4MxG126FtuA
	 Y4sfEKHyoyDTg6roynomr5ZSc7KeH39/1whVsnq2StG01F3VPiP5QFlZsGmTdQPDL7
	 JdJ7pyULyrbVg==
Date: Thu, 14 Sep 2023 12:57:59 +0200
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com,
	egallen@redhat.com, hgani@marvell.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, mschmidt@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, sburla@marvell.com,
	sedara@marvell.com, vburru@marvell.com, vimleshk@marvell.com
Subject: Re: [net PATCH v2] octeon_ep: fix tx dma unmap len values in SG
Message-ID: <20230914105759.GY401982@kernel.org>
References: <PH0PR18MB47346CADA6D087CB1BF2234CC7F0A@PH0PR18MB4734.namprd18.prod.outlook.com>
 <20230913084156.2147106-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913084156.2147106-1-srasheed@marvell.com>

On Wed, Sep 13, 2023 at 01:41:56AM -0700, Shinas Rasheed wrote:
> Lengths of SG pointers are kept in the following order in
> the SG entries in hardware.
>  63      48|47     32|31     16|15       0
>  -----------------------------------------
>  |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
>  -----------------------------------------
>  |                Ptr 0                  |
>  -----------------------------------------
>  |                Ptr 1                  |
>  -----------------------------------------
>  |                Ptr 2                  |
>  -----------------------------------------
>  |                Ptr 3                  |
>  -----------------------------------------
> Dma pointers have to be unmapped based on their
> respective lengths given in this format.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


