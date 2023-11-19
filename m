Return-Path: <netdev+bounces-49055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D77F0876
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 20:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B161F2224A
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8814005;
	Sun, 19 Nov 2023 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+jKYt8k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270210A20
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 19:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE2DC433C7;
	Sun, 19 Nov 2023 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700422026;
	bh=9xe3Q3fs3OKxEKDYqaXsNGqQGIRylSjf7JwSJSD1XhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+jKYt8kLE1vW4dlyqIGqAMYv1O//lNcmpHouYzZdzsSauq26AinhL9u1kKAfeRZj
	 fM2wNaNBBuAHA6Jaq3bSyNs4LUYhOW2z4GHOLWe6f2b2SL7GU8diP1ehY1AHdzk1Ji
	 rNSPmTaHO5jIqLwiesnNo9xYipxaz/xTwpIpxNlwnpSXyZxToEjI/2SsQBNnBlUzgt
	 joxvMFd8FJsag7KLkEBCv5oEF30q45yoNOERqDMy1OLaImjq+q106uE0cGamysfb3U
	 HcJpFJi7tWTsPCOQpAuoaYue06bPck5pQXYua/ppk7vO/74hAZYnIMXBtbyoxUZF2e
	 x34ujdmVkKsVw==
Date: Sun, 19 Nov 2023 19:27:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: wangxun: fix kernel panic due to null pointer
Message-ID: <20231119192702.GF186930@vergenet.net>
References: <20231117101108.893335-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117101108.893335-1-jiawenwu@trustnetic.com>

On Fri, Nov 17, 2023 at 06:11:08PM +0800, Jiawen Wu wrote:
> When the device uses a custom subsystem vendor ID, the function
> wx_sw_init() returns before the memory of 'wx->mac_table' is allocated.
> The null pointer will causes the kernel panic.
> 
> Fixes: 79625f45ca73 ("net: wangxun: Move MAC address handling to libwx")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks Jiawen Wu,

I agree with your analysis and that the problem was introduced by the cited
commit. The fix also looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

