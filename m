Return-Path: <netdev+bounces-29532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4245783AB5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE3B280FE9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759056FBC;
	Tue, 22 Aug 2023 07:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDC6FB6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E3C433C7;
	Tue, 22 Aug 2023 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692688631;
	bh=8j0GmyJHT6fG0NfD1j5R5EkAuxD1rOGMTqcjw9QLvUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMFz5fLqI/oYaZ2pW2uqdsysNFRV428tq091dJD18nKjp76tsQeRod1eTb28ftwtE
	 hrOi0IgoFP9+exicm95Bz5WZZJZX86Rto9BQqwhfG9DIPT5NUPC12ZTENG9CgmE9tH
	 vwrsaXZluchltL3J0aQ4AuMrP8H0DC//jgCUGWqNF0WsRcZcm0pP8mAmBcneBBpX8y
	 Sm+a+kJ7kGhoMChRNUfOcOCLkcIGzugJGt/g3BLNI+HXJQRpGJucozuggKPU1grjY5
	 DeRi96lOvWs2Hwjvg8NW0ELmFPIR6i02a/A6x5iczEJbsh1hY0xBJvC0MHa8I7pP55
	 zfj7HbWpdPkPg==
Date: Tue, 22 Aug 2023 09:17:07 +0200
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH V3 3/3] cteonxt2-pf: Fix backpressure config for
 multiple PFC priorities to work simultaneously
Message-ID: <20230822071707.GK2711035@kernel.org>
References: <20230821052516.398572-1-sumang@marvell.com>
 <20230821052516.398572-4-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821052516.398572-4-sumang@marvell.com>

On Mon, Aug 21, 2023 at 10:55:16AM +0530, Suman Ghosh wrote:
> MAC (CGX or RPM) asserts backpressure at TL3 or TL2 node of the egress
> hierarchical scheduler tree depending on link level config done. If
> there are multiple PFC priorities enabled at a time and for all such
> flows to backoff, each priority will have to assert backpressure at
> different TL3/TL2 scheduler nodes and these flows will need to submit
> egress pkts to these nodes.
> 
> Current PFC configuration has an issue where in only one backpressure
> scheduler node is being allocated which is resulting in only one PFC
> priority to work. This patch fixes this issue.
> 
> Fixes: 99c969a83d82 ("octeontx2-pf: Add egress PFC support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

