Return-Path: <netdev+bounces-24106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82276EC8B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5121C20777
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1546C24168;
	Thu,  3 Aug 2023 14:32:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FA23BC9
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 14:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36FEC433C8;
	Thu,  3 Aug 2023 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691073173;
	bh=4HAkcAOwU6vcVH3gv5kqQeeKfI1WPDHGE5jrJywS7IQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RE9OQTxKrfJxlS9hnrh9eGA+Umym9u72ceYORXR7rStKtk50mHPXu/f+e9Ag4mme/
	 hsXAQj0fwJltADqY+dPDxMS2Qn0IqruTGT7ashw/FCH64wStsZPJjAx9ZQpr+Ml7dz
	 D4dlcl6p18IPK2FWW87YE+lXlYYjcvXfnvrqAFdDS6IAWP9mxXq/jboMl7FYVrrx2+
	 jgd1+XWAh1kulXj64OBQ6M3nFBFOIqv+KtpPt6ysWbRgfuVvKUIZ3TEkRUjL/LyCKC
	 3paFpPzYSJE8x0CtRFdfIT7Iz+0jDkA642Ao8/614m372FB46bsjMWwkl/37nt1WTr
	 Qi4stX6wE2QYg==
Date: Thu, 3 Aug 2023 16:32:48 +0200
From: Simon Horman <horms@kernel.org>
To: Zhu Wang <wangzhu9@huawei.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] net: lan966x: Do not check 0 for
 platform_get_irq_byname()
Message-ID: <ZMu6kDiHMD1TjMUW@kernel.org>
References: <20230803082900.14921-1-wangzhu9@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803082900.14921-1-wangzhu9@huawei.com>

On Thu, Aug 03, 2023 at 04:29:00PM +0800, Zhu Wang wrote:
> Since platform_get_irq_byname() never returned zero, so it need not to
> check whether it returned zero, it returned -EINVAL or -ENXIO when
> failed, so we replace the return error code with the result it returned.
> 
> Signed-off-by: Zhu Wang <wangzhu9@huawei.com>

For non-bugfix Networking patches, it is appropriate to
designate the target tree as 'net-next' rather than '-next'.
(For bug fixes 'net' is appropriate).

Link: https://docs.kernel.org/process/maintainer-netdev.html

Otherwise, this looks fine to me.

Reviewed-by: Simon Horman <horms@kernel.org>

