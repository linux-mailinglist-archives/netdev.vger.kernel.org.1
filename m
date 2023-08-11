Return-Path: <netdev+bounces-26720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1F778A74
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8021C20B18
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A5863D7;
	Fri, 11 Aug 2023 09:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0F63CD
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFDCC433C7;
	Fri, 11 Aug 2023 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691747876;
	bh=IWEzOGFlkiCaa8WQRfeZqYf1TPywOjZtPgg7LNZcOng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKC4KFHtn8DPv5+T66P6WZ7Z3eCcoiNIvPTP3rLhMiWlqDysd1O9p/QTlWQjJt45i
	 tv3IA+UL3U0srgdeli0x7xgVaUv04gs3YA0LXHNPp/qQ4tBOlDI1MMORfVK+woA3mT
	 2cGzXllwwexvptF6239vXlW1DZdFHUoiSRPTOCCAB6mRbc7tHgijShFb/0I0BRqWZJ
	 sWbzmE36Ox3BXvz+KqhSljIPBY9INs0Oc05Z+tv7nKSczyQy3xi6kqcM4umu9+cgZD
	 kzHlBYVMW9Eg63X7/ukUwNV2swVwjpYFcbENCUE1oX6ctFTxJClwL97ALnpHJaWVc5
	 CRSXCmvjXxXbw==
Date: Fri, 11 Aug 2023 11:57:52 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
	jbenc@redhat.com, gavinl@nvidia.com,
	wsa+renesas@sang-engineering.com, vladimir@nikishkin.pw,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: macsec: Use helper functions to update
 stats
Message-ID: <ZNYGIH5SjfbxM+Xx@vergenet.net>
References: <20230810085642.3781460-1-lizetao1@huawei.com>
 <20230810085642.3781460-2-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810085642.3781460-2-lizetao1@huawei.com>

On Thu, Aug 10, 2023 at 04:56:41PM +0800, Li Zetao wrote:
> Use the helper functions dev_sw_netstats_rx_add() and
> dev_sw_netstats_tx_add() to update stats, which helps to
> provide code readability.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


