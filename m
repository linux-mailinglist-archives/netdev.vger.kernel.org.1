Return-Path: <netdev+bounces-226154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD08B9D098
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D9216934C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E543D561;
	Thu, 25 Sep 2025 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4nSRlP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5F1C695
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764201; cv=none; b=jVc5DtYcR2kyxOHcjYYrpj28Q6aHr5B+chLa3fdd9g3Qvcf0F7Wj8NvYyj7Dnond8407o78jRTM9GYdZm6pNt4+Kxp/lt2me5x5B64fEdTXHTScojVCcBj1x29N55X2S41GNnWV5nJSmJdEkitOmpfpNDR4c2EsLfgAwOQUF6js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764201; c=relaxed/simple;
	bh=GTnWhJI8gqYdcNPp+BVJUEeK04vMYbABlg3EYBx6wL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSLoz+z3kVRtPCw4Tz6Fkj138m/SnsssbwAH6G4p4Mt5VqtPobrIrVEYqEh+jdhe/8j4JDvf4vgRNLJcxGb3KJ1BcpCnYDOaZkBmLDFyElROhDyOOOCoylGsq5xS0rtw4xVIXWricQWS+PXuDXCWEj3K7a21W8ToPFpuxe0Nhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4nSRlP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010E0C4CEE7;
	Thu, 25 Sep 2025 01:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758764201;
	bh=GTnWhJI8gqYdcNPp+BVJUEeK04vMYbABlg3EYBx6wL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4nSRlP6NaQ8Jcp1sd+mcO5DiqH7f+M/hJX+1+siisENif/tgYp4+yCaEMeQoMGCN
	 pIIj9E2UfOsXVsqHsxxVOUSh4Ymhz7QGLk2WursTeuBpwYGFg5cVD57q3XBmgBpOc4
	 M/emck/ntuXMZtxgSwB0XOt0tEVuZcf9YMx4V7Ut56gY2N0rxIUPy7anoHWuvAFbyU
	 u0Rad5bZTwOjYCPRTSwuJW/GFp2ilBFy0H6qreuvvO/9XMvZHHeSZb+cAFpl40G5/z
	 L1cIA2EyHheJdJ85noplYPjsDAxpyYqzI8S0qGHCNOBPqqbItEl6RVcTb3HTkr+2xt
	 uVavzBSYGbwWw==
Date: Wed, 24 Sep 2025 18:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 0/4] net: wangxun: support to configure RSS
Message-ID: <20250924183640.62a1293e@kernel.org>
In-Reply-To: <20250922094327.26092-1-jiawenwu@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 17:43:23 +0800 Jiawen Wu wrote:
> Implement ethtool ops for RSS configuration, and support multiple RSS
> for multiple pools.

There is a few tests for the RSS API in the tree:

tools/testing/selftests/drivers/net/hw/rss_api.py
tools/testing/selftests/drivers/net/hw/rss_ctx.py

Please run these and add the output to the cover letter.

Instructions for running the tests are here:

https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

