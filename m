Return-Path: <netdev+bounces-37705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F7A7B6AF3
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 34D9F2816BB
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43912AB42;
	Tue,  3 Oct 2023 13:58:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9932941F
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9876FC433C8;
	Tue,  3 Oct 2023 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696341486;
	bh=ai0DuCjyGD2l5/5x0bHJ1YHAv82RmsrUbrt1jRnZTg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5DHY/Bd3kZXCEjaIPEt2SwmpqwWwvYTldQMIFYaHPuqcAGIjl9YiewtjWuFBng6e
	 m4ML72IHWC6+DjzZJnISnRzECzC1M9fdAxtA8bMbRvVd+y/zmNGOcbmxRsRJpKI0we
	 gKaIv9/d8/KyiJLOuq1Nh8KMtVdX8Yfp7lG1RU5NBfQZGA3BPaCEIEyoE4qLURNJ13
	 0NIBfVlZAFvx8U1Yf/DQJpH925DBfIQNJ+VnvcYlz6sJAXaqcO4vbGwLGdhHshyN4A
	 IxXEEkPy0C6FU1K9cjRutjx7FzFk3oyJfhPEy40rV24vuIwd4qw9EijSa95afACZ7M
	 +i+IUjTHLoFKQ==
Date: Tue, 3 Oct 2023 15:58:02 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: lan743x: also select PHYLIB
Message-ID: <ZRwd6r3GnSUgxwwZ@kernel.org>
References: <20231002193544.14529-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002193544.14529-1-rdunlap@infradead.org>

On Mon, Oct 02, 2023 at 12:35:44PM -0700, Randy Dunlap wrote:
> Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
> a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for FIXED_PHY
>   Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
>   Selected by [y]:
>   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
> 
> Fixes: 73c4d1b307ae ("net: lan743x: select FIXED_PHY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309261802.JPbRHwti-lkp@intel.com

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


