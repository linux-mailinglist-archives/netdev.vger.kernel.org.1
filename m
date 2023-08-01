Return-Path: <netdev+bounces-23132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1C76B16E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7721C20E27
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09AA20F88;
	Tue,  1 Aug 2023 10:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF001DDFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33556C433CB;
	Tue,  1 Aug 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690885041;
	bh=uKQHNBewgHF9nEvZqJ3rqmkkqgDwBDK4hB+7/BHEJjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIpAm0nEG3Jpp1/Pi6Bswkiqze6qEHlxde0uYIp3NVvJ+KY5i/Zz/oHoiKePWLeYW
	 Z1wB7kkLjYxLz+SMbs3CRU3xMSUmhQn8ggxG3ZgjEhk54UXd4uRYSIpsiZ53Kpu7nd
	 SmG0PHcG0bGy509Jp7KtxNasH1PGeYgaURi092slILzeK1Oyqxg4LT+ZDKtJ7CuE2G
	 Y9rPMor1n1uuAMu7UknoT5EcWkAxncrqVcB53MZl/rVVJE+jFh4G7bWh3LOmzCUrlc
	 QWm38ysQG92kRdspNaszvfyBDOoi8ZRdqtbTM/yFN1yWeaLi1qJiqZwzfSxkMWGGv+
	 +TW6SJngdwyGQ==
Date: Tue, 1 Aug 2023 12:17:17 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nbd@nbd.name,
	pagadala.yesu.anjaneyulu@intel.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211: mesh: Remove unused function declaration
 mesh_ids_set_default()
Message-ID: <ZMjbrQWaXU+qpEQe@kernel.org>
References: <20230731140712.1204-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731140712.1204-1-yuehaibing@huawei.com>

On Mon, Jul 31, 2023 at 10:07:12PM +0800, Yue Haibing wrote:
> Commit ccf80ddfe492 ("mac80211: mesh function and data structures definitions")
> introducted this but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


