Return-Path: <netdev+bounces-22419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E97676FC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAB828199F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906415481;
	Fri, 28 Jul 2023 20:32:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13A328ED
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 20:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E913AC433C8;
	Fri, 28 Jul 2023 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690576371;
	bh=frhPHiRfpPqYZf6uuoHT7JY6orxZUIkWA3ezy0Z94dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sr1qNV7jjIF/TSagRPlD3ltbrxwjXbyzLVCaXTtkCc3VEmrJBKHaq0P/fA57/gsXu
	 34s08kzGSJUAFGrRGQdAPB4NKQ7l9sVGbU5yH0MmAHvaHMervv/6vso6sg7oYg9yBd
	 u+/7ihud9aBRzdZv0FE1ss5udOyefWGDj0unDa9ADKGk5xfAkVYhkIZeSOAq7J4A8U
	 UhbzioJloaUGpYMkBMuTqoAyKeb9kVR2q7qvfpxfAYDpZdgl73bThbWNARCOcI1Zbt
	 KWQuclI0w9qIExSaaRfwBvH3O5FjC/7j1CjG3bo9a/JRWjtpac5MK0x3wQ8DTK4ta1
	 WkYEiqe3CMPLQ==
Date: Fri, 28 Jul 2023 13:32:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Patrick Rohr <prohr@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Linux Network Development
 Mailing List <netdev@vger.kernel.org>, "Maciej =?UTF-8?B?xbtlbmN6eWtvd3Nr?=
 =?UTF-8?B?aQ==?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 David Ahern <dsahern@kernel.org>
Subject: Re: [net-next v2] net: change accept_ra_min_rtr_lft to affect all
 RA lifetimes
Message-ID: <20230728133250.1aff0f95@kernel.org>
In-Reply-To: <20230726230701.919212-1-prohr@google.com>
References: <20230726230701.919212-1-prohr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 16:07:01 -0700 Patrick Rohr wrote:
> +	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft) {
> +		return;
> +	}

I'll drop the superfluous brackets when applying, hope you don't mind.
Otherwise some script kiddie will send us a patch to do that :|

Applied, thanks!
-- 
pw-bot: accept

