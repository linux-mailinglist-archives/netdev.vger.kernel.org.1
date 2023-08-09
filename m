Return-Path: <netdev+bounces-25845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BC775FAC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E8C280DB2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B2B182CA;
	Wed,  9 Aug 2023 12:45:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63C18008
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E9BC433C7;
	Wed,  9 Aug 2023 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691585140;
	bh=M88IJBO4YiWBUGy1m6kbP7R0DUQRC+ov1yBfuhseJwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDPv80CY54K2qo91COhFf/5ehtUL/fcQs5vs7BN6WTVG5+YIutw9plg+Qbah1nSGR
	 9E8gFQ993gre62fYiXGNq4CBXhfSRAMZ6tOqYqcD0u5ocQ/xxgXqAEYC3HKo0ONGUI
	 EzTBheTYnkRZnPnh7ox2A71KRT/qXzpj0ZtmCpsu/qMznWJCumj78/1+Hc+nem2Rrf
	 G7TJiLU5KeEW6/oTFWYGOAJY6L9dV2sii0qWq7OqiGzLerou4ZtxCmAm72Z7CrhDFr
	 m8J6uaa2bArFKO2yBbDCYALSVm2PBZV+dqpqkLejqeIlc9MXdjg95XE49sTvxxlwwF
	 QzHfmMMiGapHQ==
Date: Wed, 9 Aug 2023 14:45:36 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, asmaa@nvidia.com, davthompson@nvidia.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxbf_gige: Remove two unused function
 declarations
Message-ID: <ZNOKcA6flZf7Fuxv@vergenet.net>
References: <20230808145249.41596-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808145249.41596-1-yuehaibing@huawei.com>

On Tue, Aug 08, 2023 at 10:52:49PM +0800, Yue Haibing wrote:
> Commit f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> declared but never implemented these.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


