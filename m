Return-Path: <netdev+bounces-49859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A07F3B54
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1270328287A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74617F7;
	Wed, 22 Nov 2023 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umy9jIaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1C17CE
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD09C433C7;
	Wed, 22 Nov 2023 01:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700616720;
	bh=qaorCPvEiiop6X0P+iQta0utJinO97HMHOl2n4Xaxfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umy9jIajVcCFxMVpup3w0gSEiYUPqFr4iBuYixTJ5EQ1yWRhNVDlBj1GPxt2QXR8D
	 +NexApS6oaNneDN8krvc4R53h/GHNKwI0BAJs7M60+kiI27TB5PLyFjJu8D+lhUx/r
	 /01Yj22vujF3V5kWb3CaJEz8ZoE2xTMaTiLfaeldrbjTmz2yPzx4Qx4FHsqf9s6tAL
	 Fe8vEMHJizUW8x5qAbjrSLJw0InpgW6/wARlwi1jr67t7oYJ6QwOT0/o4/UQ+htkU1
	 tmQqwZ20i1B5t3lZKzrk67GUjYzTfQrN2BZH4PfxZlLEKHVej+MCqkWr3CwVQXZM7o
	 xa96AFqwuTBQQ==
Date: Tue, 21 Nov 2023 17:31:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com
Subject: Re: [PATCH net-next v2 00/15] net: page_pool: add netlink-based
 introspection
Message-ID: <20231121173158.32658926@kernel.org>
In-Reply-To: <20231121000048.789613-1-kuba@kernel.org>
References: <20231121000048.789613-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 16:00:33 -0800 Jakub Kicinski wrote:
>   net: page_pool: split the page_pool_params into fast and slow
>   net: page_pool: avoid touching slow on the fastpath

To relieve some of the pain and suffering this series causes to our
build tester I'm going to apply the first 2 patches already. I hope
that's fine. They are pretty stand-alone and have broad acks/review
tags.

