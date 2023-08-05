Return-Path: <netdev+bounces-24687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460067711BD
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 21:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A7A1C20A4D
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0D1C8C8;
	Sat,  5 Aug 2023 19:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF02CA6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 19:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C3FC433C8;
	Sat,  5 Aug 2023 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691263500;
	bh=qoVovonkDlCZAGyHdpkcLhNyRI9P5U68HXbWXLRHeeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iq9AqL8t+LduND4co3bPZubsqBrA8Kkg4SFb8PFmOr1qN6jUW7tjAUfETfvySdhaX
	 bAsyX9TRz7XeysHeq6AGx4fbH7Oqod9pYfgnrhOeBNoXhwWB/RJX/diSv1Wx5cDVJG
	 sNBkpQx0jPieBMlbjpgSdXjkebLkRXSEoBMf6We5460yRi907NIp5PVFzLdAJ0MZMd
	 5g2X6remQeEZklQa1pTIp6C4uQ5Dqdk994YVa1kBK1V+2oJzzoKI7KUYgvsHM5sKNv
	 sKTxx4wuG8ak23vOgxl4TnY8xyXfbNHvS6TCeZ2Wpq+fAHwW7puNZHGJ1H38aZQQR5
	 wOK4ERwfqOxNg==
Date: Sat, 5 Aug 2023 21:24:53 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] netfilter: conntrack: Remove unused function
 declarations
Message-ID: <ZM6iBSr3/Sd8Uarl@vergenet.net>
References: <20230804134149.39748-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804134149.39748-1-yuehaibing@huawei.com>

On Fri, Aug 04, 2023 at 09:41:49PM +0800, Yue Haibing wrote:
> Commit 1015c3de23ee ("netfilter: conntrack: remove extension register api")
> leave nf_conntrack_acct_fini() and nf_conntrack_labels_init() unused, remove it.
> And commit a0ae2562c6c4 ("netfilter: conntrack: remove l3proto abstraction")
> leave behind nf_ct_l3proto_try_module_get() and nf_ct_l3proto_module_put().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


