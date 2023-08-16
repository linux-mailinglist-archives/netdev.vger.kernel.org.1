Return-Path: <netdev+bounces-28098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8863977E3A0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4390B281AC1
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403E107AA;
	Wed, 16 Aug 2023 14:32:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AA1079B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 14:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F59FC433C7;
	Wed, 16 Aug 2023 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692196374;
	bh=yz3mExc/Khw1bsByECExMmkjKVdaFcBkmberfyUhEi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pP60Lj0c3VxgEMvc1mPT6UhQR9MIJCwdiXXKZNUCUU+vSQvS/yIngU4xFbO6q5ULG
	 1KMZEMLQGCTVTClpxcoyt3isxBH7+JmVpEpL4smmSegpYidqxn1RS+L7cc2V3bZF8o
	 EtzbbxSDLqyPk2aBdvzPcJoNE69J1Udyzj0sEwQli+Fnlb+u6hR1E9VRRm52hhm+bS
	 PWGEeyso7vKauNDoRgOPhRH9U3pfjk0WAkWS1ohYaAaifA1oceKiMEl8ogAtatNu9Z
	 fgbKa72sW0NduqFGqtcOEeQ+MKdj3MLI7911/fEVYyp5dblDLfm9/AP7HUwFKQ7KI9
	 ay//1UKCXbIgQ==
Date: Wed, 16 Aug 2023 17:32:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH -next] net: dm9051: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <20230816143250.GY22185@unreal>
References: <20230816090722.2308686-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816090722.2308686-1-ruanjinjie@huawei.com>

On Wed, Aug 16, 2023 at 05:07:22PM +0800, Ruan Jinjie wrote:
> Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
> simplify code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/davicom/dm9051.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch subject needs to be [PATCH net-next] ....

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

