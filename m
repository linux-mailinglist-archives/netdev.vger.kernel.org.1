Return-Path: <netdev+bounces-24214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD376F3F4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 22:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18DD1C2166E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABBC263B4;
	Thu,  3 Aug 2023 20:19:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94C63BC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 20:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D85C433C8;
	Thu,  3 Aug 2023 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691093988;
	bh=segpZ9DDZhzLgZ4TQcGyxCReQsAHXRSxgCdvDQSLixc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq+Y2NQ2K0nlDzft+2YXSXu1OAvueZ620JQHkSEuvniTPocmTxP2Bw0labS7sqqWW
	 0/1KCXKy6Sz8RQJmr6Tb/0Ma5MapoycbkYJs94QhosKeFtI4cMDPiX1SSiMFxeVONt
	 3Tj0cFrepFFMNFS4GZggmo3SWR+RexV02IFyFz8bqMTC+2GFaD+UvqmxDdrGXcfVVl
	 JaJ4RZrkFEC7tZu1d2kXq1aTFyOcEMU6mXiNwTrDjchKJOXqVXE0dBebcSMT9X6f0S
	 xmN5Z0fYm9xlSN8VITFFOPQ8r5lf/7/NXZ/u72RaOHXIXHmIZUQNmdcBryTiQs7U/9
	 emHY/zXUl73mg==
Date: Thu, 3 Aug 2023 22:19:42 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: 802: Remove unused function declarations
Message-ID: <ZMwL3nRXBuvkz7lF@kernel.org>
References: <20230803135424.41664-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803135424.41664-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 09:54:24PM +0800, Yue Haibing wrote:
> Commit d8d9ba8dc9c7 ("net: 802: remove dead leftover after ipx driver removal")
> remove these implementations but leave the declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


