Return-Path: <netdev+bounces-25457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2540377425F
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6BC1C20E38
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6914F81;
	Tue,  8 Aug 2023 17:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C014F7C
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610FBC433C7;
	Tue,  8 Aug 2023 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691516566;
	bh=94iIyGM04zZcBtLodB23NRck92fPzkLkeSTS+OWUALw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqNYHeT1pJh9YxVKJoi5nzRDcj0f+8G+tVRNv4aNOkPsiWewrcKc2N83k+VBG/WkA
	 Ac/Fzd9QUajZIYdEdl6ecQHqjdiscKSy6trnrClPz6uxlbc2+LfLhiV8P36pxIFCdx
	 JXupn5ymAmsjvHaD19f+febYqOZKWcelLpQdXO9RkR8VFoKGUCgSHpYfa5r4SzlZ79
	 OmEUk6zE48/Y2EUgxu5mtljmniJc9UWt6TlsE8dcsg/B1W9PafEaeq2LR7WNNVvKaa
	 QDRYbBzdrCBtuS2qGVsMhOoXst0j61iJYNeHwv7dkhuihQrXl0BsDNMomtLYj4JUwa
	 emVi6bgmMdDKQ==
Date: Tue, 8 Aug 2023 19:42:41 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH v3] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZNJ+kc30fcNirPc1@vergenet.net>
References: <20230807145032.44768-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807145032.44768-1-yuehaibing@huawei.com>

On Mon, Aug 07, 2023 at 10:50:32PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> Commit 11433ee450eb ("[WEXT]: Move to net/wireless") rename net/core/wireless.c
> to net/wireless/wext.c, then commit 3d23e349d807 ("wext: refactor") refactor
> wext.c to wext-core.c, fix the wext comment.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


