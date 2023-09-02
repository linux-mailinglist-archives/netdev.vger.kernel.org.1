Return-Path: <netdev+bounces-31820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF979065F
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 10:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9252819A7
	for <lists+netdev@lfdr.de>; Sat,  2 Sep 2023 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6323AF;
	Sat,  2 Sep 2023 08:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2F15AE
	for <netdev@vger.kernel.org>; Sat,  2 Sep 2023 08:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D006C433C8;
	Sat,  2 Sep 2023 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693644318;
	bh=D0VKU97IUIqN1bvcHCUYCp6kzWS5ndv73r4TdZg6LEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o16YLLhT69i2vF6xGy67WPGceqraJOO3yohv2/UY7wo2GrApWjzfLsB1hyvHKula1
	 UfFPX2Y12JAWj3NvgYhaVtfqVMZBCzX3WdkuF4d6iJMUkrIgSNJkPh+RxhVyZ9APLr
	 LHhWWQBGOgPiL2pjbWsZbxaSxv/blZD/GATDX6t9KXn4e48LEpuGsKS1iNtwHg/dEk
	 zK7G3ud5lAOhseADajxGI3My4Hx1c2rwuCtgEY+47sFssxJG0De0HLIkl+NAESnPiE
	 AVvE7z71O7kBsgep31PdeMGpCplnhaKiJFoT5TE83T+H1ckxloPxYxL5QTENZhyIdJ
	 fdRcrT9PLT9cQ==
Date: Sat, 2 Sep 2023 10:45:14 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] docs: netdev: update the netdev infra URLs
Message-ID: <20230902084514.GA2146@kernel.org>
References: <20230901211718.739139-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901211718.739139-1-kuba@kernel.org>

On Fri, Sep 01, 2023 at 02:17:18PM -0700, Jakub Kicinski wrote:
> Some corporate proxies block our current NIPA URLs because
> they use a free / shady DNS domain. As suggested by Jesse
> we got a new DNS entry from Konstantin - netdev.bots.linux.dev,
> use it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


