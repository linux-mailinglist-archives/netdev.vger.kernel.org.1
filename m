Return-Path: <netdev+bounces-33789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326E7A022B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 13:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38393281C42
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9F208D3;
	Thu, 14 Sep 2023 11:09:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514E208C8
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 11:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBC0C433C8;
	Thu, 14 Sep 2023 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694689766;
	bh=cFVfRA9cjg+kDzvltt/LQHkMRTCNop8crs1SYEksVo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5aJ19mK26dNPxJdGbbRHvmrXSCeSguwxZ7de8Z5rCCtMHQ07wO/N7wr0BoYFmZPF
	 f6ws/PkoljmNt97C9AanNNAW4OrjCxDfvevkayCxawFoDJgZmsTUqDVB+fFQVCr8Bx
	 ptw/gaJwzRilkiVUo6EQ8rMcXDsGxVfmbFgrMiLhJqRNK3q92PP+j8OVt5kajqqY3A
	 V1vtwfuQX80hAv7OpxtSfX8Qe0Nm5D7iwfdhnF/ogQ+BrC2MzGKtgRrVV11eUGpwsv
	 RHKMXFwpacYlirk6m3UEJmsCLXqNZfvoRcuFTj4+XOjaqF+QtsjofdhTGzjJ6j59zH
	 utOk++3NJoZpw==
Date: Thu, 14 Sep 2023 13:09:19 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v2 net-next] net: ethernet: mtk_wed: do not assume
 offload callbacks are always set
Message-ID: <20230914110919.GZ401982@kernel.org>
References: <ea9e1313e01f7925b9fc4040f3776070447f261d.1694630374.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9e1313e01f7925b9fc4040f3776070447f261d.1694630374.git.lorenzo@kernel.org>

On Wed, Sep 13, 2023 at 08:42:47PM +0200, Lorenzo Bianconi wrote:
> Check if wlan.offload_enable and wlan.offload_disable callbacks are set
> in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
> on them.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - move offload check inside hw_lock critical section

Reviewed-by: Simon Horman <horms@kernel.org>


