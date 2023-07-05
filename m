Return-Path: <netdev+bounces-15599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCA748B0C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBA51C20BA0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211F13AC0;
	Wed,  5 Jul 2023 17:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E08134A7
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2799C433C7;
	Wed,  5 Jul 2023 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579679;
	bh=N7sGdkBjCg7uDcdrIzid6xum02yBViRZ4+50FG92ltU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I8PASMGW8SK8nIzCSY9XlrBjrvJtrThgT2sthjX5KV7C2ZtLVRVR26EDAqrcKJJuT
	 s+Ysuu/JB1WbXbvd86Y+iwFULUtxNhS3mrAeaShS+VNGZK6F0Mp7/9iJgvj4ynKWd3
	 99O0IQHwHIoR0eRjA89YLOgb0sZebLiNLdYCYG4cpMmgjoSvj3XctBv2ng7gjv5WpF
	 i3Cq0hh4FxQ+rCpVQHCdV7v0mboF+mZD9dFgxWPjkbF4s8m8HTkVQwuFPNUDFA49Gt
	 2jHUnHHHMoipWidvx1hE/fe4JF+JrVUSHqHC5tjVcoFxWA4wS31JTiu2VrUCzfW+Bg
	 a1bimSgx0rtEw==
Date: Wed, 5 Jul 2023 10:54:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net] net: ftmac100: add multicast filtering possibility
Message-ID: <20230705105438.67446814@kernel.org>
In-Reply-To: <20230704154053.3475336-1-saproj@gmail.com>
References: <20230704154053.3475336-1-saproj@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jul 2023 18:40:53 +0300 Sergei Antonov wrote:
> If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
> incoming multicast packets. The chip has a Multicast Address Hash Table
> for allowed multicast addresses, so we fill it.
> 
> This change is based on the analogous code from the ftgmac100 driver.
> Although the hashing algorithm is different.

Fixes go to net, new features go to net-next. Doesn't sound like 
the patch is a fix? Please read:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Unfortunately net-next is closed ATM.


## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


