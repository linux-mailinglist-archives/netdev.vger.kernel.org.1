Return-Path: <netdev+bounces-49034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E67F0757
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E91B208C5
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618D13AFD;
	Sun, 19 Nov 2023 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlud+6eA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D714001
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 16:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E07EC433C8;
	Sun, 19 Nov 2023 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700410320;
	bh=FviOo4+HTPFpVUCgfNxlIvuh0YvLmOQEGbiuswYPjOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlud+6eA3nh0LxIPG/wYRVifl43OK984NNQfehKMhpfQ2AaXlAfGHo/1bqMhoA3fJ
	 FIzTXm2vfOD46JEkF3btnF6gUe/LBr/415OkV/F8DJ0tKxCPCL5Kvj2nlz/2LeH0Fc
	 H5jsthlTQasv8tVnep5+g8Yuiz2TMdgGMpbqDlrwT+BEk8FdxJOe8DgkNavmJ6bQPt
	 vPBmUJKR+8oslKAioo+epMfJj5vkOMrBxnXKEGgdIlho0uCpH8TNBHAcStvWb6X+NK
	 arxVOLFH8+rZeDto2k2VBiaogj/OHGT2zTJgYayXvTd2Hgs6JObeXqoRidr+ad/Dml
	 KtMYFSVWP5k1g==
Date: Sun, 19 Nov 2023 16:11:55 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v2] octeontx2-pf: Fix memory leak during interface
 down
Message-ID: <20231119161155.GB186930@vergenet.net>
References: <20231117104018.3435212-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117104018.3435212-1-sumang@marvell.com>

On Fri, Nov 17, 2023 at 04:10:18PM +0530, Suman Ghosh wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Updated fixes tag

Thanks for the update, this now looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

