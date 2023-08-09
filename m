Return-Path: <netdev+bounces-25825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04139775F23
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14DF281C56
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9317AD3;
	Wed,  9 Aug 2023 12:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2E17724
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54E6C433C8;
	Wed,  9 Aug 2023 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691584440;
	bh=7l8kO+6zOZK3MuFYeOSq/4zZ7g0P5ZmTcIrqgHuSSH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIa5uptBGTWXJr8C6f0srIZVR6CEP7OwiLIPygjKPcNtJEyIpzBUxT0AGql8pBokZ
	 S3PutH6zvjEQzAY8bNTwjyinfBLJR+EulCg4d3S5OP3W05M8kjYGoyUlY7OWRC3PeF
	 1zsH+lJimMNXi2MwZC1zeYsfPfhoeq3XCTYtA9WBqVKNcl5/n6YhAo8Fc8+ShYOKCc
	 jcDNz5zT/DbUJVbh9DDc6wCrau4MlUL4fWn0/hgGCM5kgV1iw4BW9AjAU8XCGo8UZP
	 eqsLemfOCmA9dMM+glkvW+bCCcZ6iUAPYayHwPOAeuLuM2HKwTlejoxvhOdkSacam/
	 FLups85D5+0bw==
Date: Wed, 9 Aug 2023 14:33:55 +0200
From: Simon Horman <horms@kernel.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shayagr@amazon.com, thomas.lendacky@amd.com,
	leon@kernel.org, khalasa@piap.pl, u.kleine-koenig@pengutronix.de,
	wsa+renesas@sang-engineering.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] bcm63xx_enet: Remove redundant initialization
 owner
Message-ID: <ZNOHsy0lQBwuqoVc@vergenet.net>
References: <20230808014702.2712699-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808014702.2712699-1-lizetao1@huawei.com>

On Tue, Aug 08, 2023 at 09:47:02AM +0800, Li Zetao wrote:
> The platform_register_drivers() will set "THIS_MODULE" to driver.owner when
> register a platform_driver driver, so it is redundant initialization to set
> driver.owner in the statement. Remove it for clean code.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


