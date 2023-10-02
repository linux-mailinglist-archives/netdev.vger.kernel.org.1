Return-Path: <netdev+bounces-37504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05D7B5B57
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 21:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D04E22817B2
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FB1F93D;
	Mon,  2 Oct 2023 19:32:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB181F198
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 19:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E3C433C7;
	Mon,  2 Oct 2023 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696275145;
	bh=wrjcR/RUvlY7MZlanG9jQpQTRsnR1TBAcdfg/+LiECg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6BZkNpx+7Gxl2lyum+F09RYhH8Uj3vjLX7c0wwTEfMcdqZfY80ArkFIVmAG9bSil
	 5j8KDXSUq7hUq5esVQhxsR+iHiz+06MPJh7nmlp44SNem7OYy6M082msoNOwtNf5gc
	 amqEEq+91+6aWcTWwQsY0OZ6IXsEzJ8B7z8wZ9qHyVbvBcOse4o86a9C2yDRytKl9M
	 wngJgUg3XUzJiEMuN/SAk1L70Vsb1+GFsUxpzdOITsUrhz9mSoxNEDaB3wsbF2GThw
	 6dfx0/RyWThqI43f1DLrentis8PLqU7FL3SYSc+1d23F3gg0TdQjf2t6eeLz6hRhaA
	 LPQAZFhKQXzMQ==
Date: Mon, 2 Oct 2023 12:32:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: heng.guo@windriver.com
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, filip.pudak@windriver.com
Subject: Re: [PATCH v3 1/1] net-next: fix IPSTATS_MIB_OUTFORWDATAGRAMS
 increment after fragment check
Message-ID: <20231002123032.19aefb3e@kernel.org>
In-Reply-To: <05faefff-181d-3a69-8b74-69381c62cdb7@windriver.com>
References: <20230914051623.2180843-2-heng.guo@windriver.com>
	<20230921092345.19898-1-heng.guo@windriver.com>
	<20230921092345.19898-2-heng.guo@windriver.com>
	<05faefff-181d-3a69-8b74-69381c62cdb7@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 10:11:59 +0800 heng guo wrote:
> Could you please take time to review this patch?

Please don't top post.

You need to CC the area maintainer (dsahern@kernel.org), 
looks like you mis-typed his address by skipping the leading "d".

Please repost with David CCed as a new thread, not in-reply-to.

