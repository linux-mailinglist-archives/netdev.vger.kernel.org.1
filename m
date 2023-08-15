Return-Path: <netdev+bounces-27726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E477D03C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5031C20DA3
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEA1428F;
	Tue, 15 Aug 2023 16:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B012B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEF2C433C7;
	Tue, 15 Aug 2023 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692117721;
	bh=Rfijzb+AvsQNROry15/L1lOKh//7QI+FBiHHQqA9bBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GDpMWIlmi2wSEQr9pkY8RBMOAdwDNNLV7n5iiKkHmZRBhojDSPhsIJ0g0CfDQxCdl
	 1xM/9OKG1fuvU3/nc3vzOfQ20E88SeiGjMInb8KWINuj59OgUb0Mcqere9k0T35Rss
	 TJRex30cdvwqlwhoDIB7BFMYBY/pq43zuoXIyKjJ7ljmc0qzRLITixgckfT7tYdtPd
	 IAWrMsoaeWzTqSbkO3EeO5VmiQjRvvyd1xtiApftIDatkfuhvyQcBN6NEDjj+d99bt
	 LgXODbJoucf0eXu/PZrZ7hb3qKw1FtbNoI9XpSp4xHPuPZKE2H2plOrecl787Qljqv
	 s4YXFY5Elutag==
Date: Tue, 15 Aug 2023 18:41:57 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com
Subject: Re: [PATCH net 0/2] sfc: TC probe fixes
Message-ID: <ZNuq1Xmkr6Blyelh@vergenet.net>
References: <cover.1692114888.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692114888.git.ecree.xilinx@gmail.com>

On Tue, Aug 15, 2023 at 04:57:26PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Fix a couple of minor infelicities in the error paths of EF100 TC
>  offload setup at probe time.  Both found by code inspection.
> Patch #1 will produce a conflict when merging net into net-next
>  (with 3bf969e88ada ("sfc: add MAE table machinery for conntrack table"));
>  the resolution is appended.
> 
> Edward Cree (2):
>   sfc: don't unregister flow_indr if it was never registered
>   sfc: don't fail probe if MAE/TC setup fails
> 
>  drivers/net/ethernet/sfc/ef100_nic.c | 2 +-
>  drivers/net/ethernet/sfc/tc.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

For series:

Reviewed-by: Simon Horman <horms@kernel.org>


