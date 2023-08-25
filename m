Return-Path: <netdev+bounces-30751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC61788DF3
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75659281855
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B418041;
	Fri, 25 Aug 2023 17:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E4107A8
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 17:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C77C433C8;
	Fri, 25 Aug 2023 17:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692985537;
	bh=FvFWJfTHnCJBuxAYcJU2vDvioeoRGpbuDc+4qUjlpqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NN+b5k9geYk3K1cJNOm+eHUaw9RzRYKdAr4Uhf7S2hAmpYRTMJhHbj/2am0yxYpJ9
	 bv9j/ZLTkpogSFptzQnG2KHXQaDWzKdECGk4Z3uYsfobS/dEuA9riZB+3nVor+fY1D
	 uisXjvytC7giuKf6N1PFGEfB6HemZ7wAy6HBvvDPRPCV6YjaGbo1ZJQepZhaqixTtg
	 I/FA7A5Sw8ui7n4MWwxa7MvKfPG9q5XF3f4BokNLhGO4P/zp0Ck1/05xcrnuYE81PF
	 ZIko3rkLvjUnBWW2Eff9jzWLfh3GICQJUEZq3TuMkvT+8SNHK8rO/kwhZqPQkCXqf1
	 64m7NywDjaW5A==
Date: Fri, 25 Aug 2023 10:45:35 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: fix config name in Kconfig parameter
 documentation
Message-ID: <ZOjov4PvI19Jdgs+@x130>
References: <20230825125100.26453-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230825125100.26453-1-lukas.bulwahn@gmail.com>

On 25 Aug 14:51, Lukas Bulwahn wrote:
>Commit a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
>adds documentation on Kconfig options for the mlx5 driver. It refers to the
>config MLX5_EN_MACSEC for MACSec offloading, but the config is actually
>called MLX5_MACSEC.
>
>Fix the reference to the right config name in the documentation.
>
>Fixes: a12ba19269d7 ("net/mlx5: Update Kconfig parameter documentation")
>Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>---
>Saeed, please pick this quick fix to the documentation.

Thanks applied to net-next-mlx5.



