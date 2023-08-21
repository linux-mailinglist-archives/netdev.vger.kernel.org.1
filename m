Return-Path: <netdev+bounces-29422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15447831AF
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E799F1C2094B
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A981171A;
	Mon, 21 Aug 2023 20:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70D1171B
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B3C433C7;
	Mon, 21 Aug 2023 20:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692648108;
	bh=W7Ji++cOhIQqMJKMwq+kmy7NW+a6Fk5Bqnmo4ENYh/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQvaSX0elIpe2uN8BNQRz3dkKzlgqSAg+7F3P5h6kfuxYrwCw/F2mlUHF38jGFd6x
	 hgGRshehw1XqTnSYdEZ/RAmEC+ABhAfcLu9oaLrqhZUTyXQ3ZnFvDox9mQ10vCsRfY
	 jujYaopLhx0rYZ8WGoMl2npFS9SPcd8jcSpEiLTYACe5ujpv3+djdBr7L0F9xDDloD
	 4u17BYXURf3moWa8aeLCyzMNyiUW/KrZwJ+C0g9Wu5rAwrIS5cbiVnzd67WPj/6eF3
	 UVpI0fhLxrh2rySQh3YhTJlVqEFvrTIKZHZ+78aCdbC+FVo6DLKI9uNDzQMZP3gZhI
	 Mf1QIAu/96i6g==
Date: Mon, 21 Aug 2023 22:01:44 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	rogerq@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: Remove unused declarations
Message-ID: <20230821200144.GF2711035@kernel.org>
References: <20230821134029.40084-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821134029.40084-1-yuehaibing@huawei.com>

On Mon, Aug 21, 2023 at 09:40:29PM +0800, Yue Haibing wrote:
> Commit e8609e69470f ("net: ethernet: ti: am65-cpsw: Convert to PHYLINK")
> removed am65_cpsw_nuss_adjust_link() but not its declaration.
> Commit 84640e27f230 ("net: netcp: Add Keystone NetCP core ethernet driver")
> declared but never implemented netcp_device_find_module().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

