Return-Path: <netdev+bounces-38023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2817B8700
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DF30F1F22B70
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C181D522;
	Wed,  4 Oct 2023 17:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E451C2AB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1398FC43395;
	Wed,  4 Oct 2023 17:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696441998;
	bh=LTu2Bz+uaRRsDt3o9GbnxUenQJtJb+UgTi4E6dBfxU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZPNJbm1lU6aKZP+vpkX2TCKRzT1EefnCdRlKE6Fv/SZg07H2c5mwjDO2qPP8ynpWg
	 iaz5b0mXFeSLuYGXxtoFehSLf2LkYDhZYdGUwp46zI1WAbC7AnWXsgS8w+49QkAhWQ
	 jnPLY5Db8CDQ/z49mkZsTXcJgcKU4FGDymy8bQJLpN1L2rhgN6p0kgzVPWGWe83Y3t
	 Rcq223xAwhoPjbgytffWIB33zCBdgZBFoRcJL8eut97zVES1EGrniVy0KCvXZ2ausB
	 qpaXvTYWYRG8oobDp9lenu7my+uGE5SBebJWrbUJep3e2khdvWgNWp0nLCsxdxW2/p
	 UnQf/K1MTBGsw==
Date: Wed, 4 Oct 2023 10:53:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Chengfeng Ye <dg573847474@gmail.com>, jreuter@yaina.de,
 ralf@linux-mips.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-hams@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Message-ID: <20231004105317.212f1207@kernel.org>
In-Reply-To: <20230930161434.GC92317@kernel.org>
References: <20230926105732.10864-1-dg573847474@gmail.com>
	<20230930161434.GC92317@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Sep 2023 18:14:34 +0200 Simon Horman wrote:
> And as a fix this patch should probably have a Fixes tag.
> This ones seem appropriate to me, but I could be wrong.
> 
> Fixes: c070e51db5e2 ("ice: always add legacy 32byte RXDID in supported_rxdids")

You must have mis-pasted this Fixes tag :)

Chengfend, please find the right Fixes tag and repost.
-- 
pw-bot: cr

