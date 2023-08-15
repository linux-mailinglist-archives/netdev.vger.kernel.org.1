Return-Path: <netdev+bounces-27605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B26177C843
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B149281390
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C5E8BFE;
	Tue, 15 Aug 2023 07:07:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3791857
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F48C433C8;
	Tue, 15 Aug 2023 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692083227;
	bh=L0E+Jf8ds4KSMC1jMXWy3ZSWVnQ4s+30hFJBjhe745U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pk2WjsSxvBWFYDb4QNIMQD7A/gnUhkxy1awInwPyC0VZ1WPNqKU2MGZDFJChSlfIX
	 2l0i0dJIRdYQMmzooAmw0BiyUgfsBtAmisRwoGPwGuXLPlxmbuqKxpWK1IZUYEan0Q
	 /FA/FOrBWZCMDEN0MfuL+MloZhO/Movp/IVj8u9HgYVJrijuWcMNqFNsOnByrww9W3
	 8AzenrOpI7o+/hpO2KMTzLa7NjAAOvnHkCJCwACJSEPt9z8t/mt5Nm2v7JmcZ8c0DL
	 bCoR+0ivt/mNDSQhKOdp6VXNOh3QN7uYPWxAd6bysh5ELcwKhYMg5V2AsoCfyKF6K9
	 pHiKL86P4wU5w==
Date: Tue, 15 Aug 2023 10:07:02 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] broadcom: b44: Use b44_writephy() return value
Message-ID: <20230815070702.GH22185@unreal>
References: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>

On Tue, Aug 15, 2023 at 12:00:30AM +0300, Artem Chernyshev wrote:
> Return result of b44_writephy() instead of zero to
> deal with possible error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>  drivers/net/ethernet/broadcom/b44.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

