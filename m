Return-Path: <netdev+bounces-19657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318F175B97E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672C0281E89
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A33719BBD;
	Thu, 20 Jul 2023 21:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142E1BE66
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD44C433C8;
	Thu, 20 Jul 2023 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689888353;
	bh=NFP685XN668i1Crn2t0Bt62w8dHk0p52c2Ko9JGGOCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cNoDFFqTSXqybZpPEF/mONpPfTyPLW/y5LMo5AgSd2I4Vfxzhi+LsBGmgNcZz5x/e
	 YVDXsHhirXMnUrDeeIYriuVXhu9e6crW42PACH93eBHjdGCBEcebe5MjWqq/6gDeWO
	 QAgLR4343UdE5+HFczeLt9/qnP9rDoQPqXpD3ebJIJLKCX5lgg72fCEK4AOJOqElHc
	 2hZm+3ZygyQL12WsM8obBF0cLKEUarlrBl0y/BfPYaL1olm7BKjFgvfoJHTDdAxtBj
	 1F+bDEN+3CB+8Wz+USZ0aQZYetyo3x9FnoKCOsJRvJSgmTYYdDWeugEtM8R4aDnzbe
	 HslYCZrg1k7xA==
Date: Thu, 20 Jul 2023 14:25:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: pull-request: bluetooth 2023-07-20
Message-ID: <20230720142552.78f3d477@kernel.org>
In-Reply-To: <20230720190201.446469-1-luiz.dentz@gmail.com>
References: <20230720190201.446469-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 12:02:00 -0700 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - Fix building with coredump disabled
>  - Fix use-after-free in hci_remove_adv_monitor
>  - Use RCU for hci_conn_params and iterate safely in hci_sync
>  - Fix locking issues on ISO and SCO
>  - Fix bluetooth on Intel Macbook 2014

One bad fixes tag here, but good enough.
Hopefully the big RCU-ifying patch won't blow up :)

