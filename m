Return-Path: <netdev+bounces-51798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738A47FC0C4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D6BB213F7
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1341C88;
	Tue, 28 Nov 2023 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIh03LlE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C141C85
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 17:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D70C433C8;
	Tue, 28 Nov 2023 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701194119;
	bh=0rCg5RfXuenhqtUxdv5nuksBTpTKxICg70W357bb9Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIh03LlEwedwkmZCyjph16WJKXm82mxAnjv3MTzaSPMNXxXoCatPUyCWYMmLzqZXn
	 EHVMxvpNd7RCgP0JQSDSotl5XT/u7D3fDiBPWi5tVtiB0nQ6viH/SsuEESQMrufBql
	 7MfBlRGjUSFtmW1nVb2p62KNQx2nkDjc4rxNq1MC66CeWWDznMJCWnFBqjh54EdtP1
	 EN3zRCKZBTKPvImHkXEaq2KvaPuFdtzhFy/oD9K9FvGnfdExMZ4v7QLjDRgeFM47qr
	 q7himwCh9J5uSpc0xzk8i9k8QC+jiLKSxDHkvAIEyR1IrzjtvQZrfhPgel5GNiZf8U
	 stXSuvTrM7O9A==
Date: Tue, 28 Nov 2023 17:55:15 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next] nfp: ethtool: support TX/RX pause frame on/off
Message-ID: <20231128175515.GC43811@kernel.org>
References: <20231127055116.6668-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127055116.6668-1-louis.peens@corigine.com>

On Mon, Nov 27, 2023 at 07:51:16AM +0200, Louis Peens wrote:
> From: Yu Xiao <yu.xiao@corigine.com>
> 
> Add support for ethtool -A tx on/off and rx on/off.
> 
> Signed-off-by: Yu Xiao <yu.xiao@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Reviewed-by: Simon Horman <horms@kernel.org>


