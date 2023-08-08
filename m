Return-Path: <netdev+bounces-25455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733B774243
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E3B2816BB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207CE14F78;
	Tue,  8 Aug 2023 17:38:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048671B7E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C77C433C9;
	Tue,  8 Aug 2023 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691516336;
	bh=8oVfLBBqGqI7DcvT29u5CPpxigzLRJWUs92oRTXCWIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+jtXPT93govYU3Pm7dfbiIeQCuGowl5SpGY3KzKobvPutsNqxdCQ1R7eIrP2Zd+8
	 RKFzP0j6RxuwaLnjmGR0mtALPrKq8/7Q/CnXpPgu3UWGQRknE5f7Ivkc9WIYwvDZiQ
	 EJjnFqCBvaWMfU2iuROq6dZHRYN2pRLhv9v3qA5U6ujN3E0H6wG8k/sS78sIF+wcmV
	 p7JDWHMalnWAhZcYCJKwaS/OQ7v0qAkU6JqyfjRjm1W9ukYouo5hlS2IPU9OS+O2Ha
	 byjdLA9KOVLVqUcPIOPuof6DQgmsQAI6Ms+mtgHy4SuJFEDFgY3cPXNA24pPuRaHJ0
	 60obfecetG8hA==
Date: Tue, 8 Aug 2023 19:38:52 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next] tipc: Remove unused declaration
 tipc_link_build_bc_sync_msg()
Message-ID: <ZNJ9rAy/882uFlQX@vergenet.net>
References: <20230807142926.45752-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807142926.45752-1-yuehaibing@huawei.com>

On Mon, Aug 07, 2023 at 10:29:26PM +0800, Yue Haibing wrote:
> Commit 526669866140 ("tipc: let broadcast packet reception use new link receive function")
> declared but never implemented this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


