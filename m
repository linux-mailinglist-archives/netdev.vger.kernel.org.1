Return-Path: <netdev+bounces-24680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A5771059
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C441C20ABC
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13962C2C9;
	Sat,  5 Aug 2023 15:29:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67D1FA0
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 15:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E4C433C8;
	Sat,  5 Aug 2023 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691249386;
	bh=1Pa5TB+z7Nn+ZHCGLRTSizWtVNvcIpKw6YoTtkM365M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCIEITfIFlKwtfeeALeOGYFqG2Abm5vkSz7L7z8T3r1yO0Z8R90etpOE6aT7wcKgT
	 A4eqaqZ+pKFJ6COr7YfMfkxdh4SCzFOVL8vl4XpjfPcnZ+k7inVI/MOrl+qOasR5b/
	 wWlFxNjm3K3P/6oDfKOxEXin7q8EON93GidI3UHbOqDNGFGR0u5DyDwqynoagBgJsM
	 TYwEV2J3sORliqo1ily/T0LWaarGceBxllmoai1MMzL0Uw8aaP9b+f5BGIrl5nXWNQ
	 RlnuVqPigf0cT2FjntSk0rremncrQswWA+vJAvkgtQCyaJMj3rost0xW91fKPaVM/5
	 vzOQNQRuKmIMg==
Date: Sat, 5 Aug 2023 17:29:42 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@veobot.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbe: Remove unused function declarations
Message-ID: <ZM5q5hk5i+4xahKG@vergenet.net>
References: <20230804125203.30924-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804125203.30924-1-yuehaibing@huawei.com>

On Fri, Aug 04, 2023 at 08:52:03PM +0800, Yue Haibing wrote:
> Commit dc166e22ede5 ("ixgbe: DCB remove ixgbe_fcoe_getapp routine")
> leave ixgbe_fcoe_getapp() unused.
> Commit ffed21bcee7a ("ixgbe: Don't bother clearing buffer memory for descriptor rings")
> leave ixgbe_unmap_and_free_tx_resource() declaration unused.
> And commit 3b3bf3b92b31 ("ixgbe: remove unused fcoe.tc field and fcoe_setapp()")
> removed the ixgbe_fcoe_setapp() implementation.
> 
> Commit c44ade9ef8ff ("ixgbe: update to latest common code module")
> declared but never implemented ixgbe_init_ops_generic().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


