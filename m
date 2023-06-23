Return-Path: <netdev+bounces-13258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C802173AEFB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAFD1C20E00
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C4621;
	Fri, 23 Jun 2023 03:17:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7D38C
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61FBC433C8;
	Fri, 23 Jun 2023 03:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687490230;
	bh=WWvTAKlt2pLTF9gdReD9TjzraQHo0GHOe60/Ea+vS/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exRP+Sq1ER+psJshrVLYdhHs1z29betIkKxgUbyRmGXPjhuSYjY7h7Xkt/THEQOrw
	 89vqi4GflMZiRPeHgVBZSyRlrGwYnVE+f8bEpqj9G6O+4Qbb+dn01vL6wgobYRSjxj
	 MQO1QiBxO7QYSdKu3CQsUmNtygDuhT+XWCrL4UT2E58D6tJ236rQihYCIWhlOi9gVL
	 pxOVdkPUFnjVUUZr44B43+dkdLPE9RZip13PgK9K2hWmliStjjIkEUy6YJ5sKI2Ggr
	 6epP2TB3nOVEUOCfuNnFFQgaGovYhOS6taZ9GbWmewf4X7l9tujqr6grsDYLJ2rv8+
	 A9WqxueHd9xGw==
Date: Thu, 22 Jun 2023 20:17:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Roi Dayan <roid@nvidia.com>, Shay Drory
 <shayd@nvidia.com>
Subject: Re: [net-next 11/15] net/mlx5e: E-Switch, Fix shared fdb error flow
Message-ID: <20230622201708.12574a23@kernel.org>
In-Reply-To: <20230622054735.46790-12-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
	<20230622054735.46790-12-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 22:47:31 -0700 Saeed Mahameed wrote:
> Fixes: 6704fef92002 ("net/mlx5: E-switch, Handle multiple master egress rules")

hash should be 5e0202eb49ed on this one, could you fix that up?
patches themselves LG
-- 
pw-bot: cr

