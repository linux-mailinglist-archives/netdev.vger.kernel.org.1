Return-Path: <netdev+bounces-20609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3BF760389
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 02:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1A21C20D3D
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 00:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FED2570;
	Tue, 25 Jul 2023 00:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC023C9
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6A8C433C7;
	Tue, 25 Jul 2023 00:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690243261;
	bh=vFWcxNrqs/3bjdjv1MlTZ0jQWQPXzQQ6vU2vG8JA8rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LySGdum0GU9ZJtvWR7WaRsv5fHidJAaQY0f8hhV0s6sL8ZEZGrrO105/61E0n0niM
	 jUQoFJ5HgyCFtaI9OGouU9+NNfykwVRxfGQWPRkaMDIAzsDcXndFk6+PdsMPvZFlk2
	 W0W3eVFuixiUm5aYWK9CIYe+kZhDBwH/d+bQqlYNpuvQqBQgq0uADnW22HrJCl2OKA
	 QKr0yeoyA0bEg/cKxGTl88mxefQQW+29RVZYZ56rH1t8GH4aB3R61JQ7z8+8ERTz28
	 YRrD2FG+UKvsWfBW9QQeZBlYa7x70DfXEk3EjE/fDiZVG+mJPYACU1ma0v1GMNBcZo
	 P4Nx1gAl1lxmg==
Date: Mon, 24 Jul 2023 17:01:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, Yinjun Zhang
 <yinjun.zhang@corigine.com>, Tianyu Yuan <tianyu.yuan@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Message-ID: <20230724170100.14c6493a@kernel.org>
In-Reply-To: <20230724094821.14295-1-louis.peens@corigine.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 11:48:09 +0200 Louis Peens wrote:
> This patch series is introducing multiple PFs for multiple ports NIC
> assembled with NFP3800 chip. This is done since the NFP3800 can
> support up to 4 PFs, and is more in-line with the modern expectation
> that each port/netdev is associated with a unique PF.
> 
> For compatibility concern with NFP4000/6000 cards, and older management
> firmware on NFP3800, multiple ports sharing single PF is still supported
> with this change. Whether it's multi-PF setup or single-PF setup is
> determined by management firmware, and driver will notify the
> application firmware of the setup so that both are well handled.

So every PF will have its own devlink instance?
Can you show devlink dev info output?

