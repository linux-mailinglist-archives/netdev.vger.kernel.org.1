Return-Path: <netdev+bounces-40867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBFF7C8EF5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD82A1F2164B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92511266A6;
	Fri, 13 Oct 2023 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+B39+xj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ABA25113
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8BBC433BD;
	Fri, 13 Oct 2023 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697232233;
	bh=J8G22RaEvjc+PPZZ5jg0GTMwTqJY3VzeOAA4tOMwQM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D+B39+xjSVz9bQcW32AAWhlWBwTW10sE1xFcEyUn/Ji5/ir+LXZl1y6WVC/B6xwdF
	 S0Mp8mb3OoF10A7Bv5cgI8wZgkpEWaVrjpWAblwmakvncic456A2OzzRsAjDKyEhZn
	 T0me2CirchqS+9wmPHcu46oyXgRFxMxEPV0DdJeifdOhGeT09U31ZQBFINTFSrQD2C
	 AcRRAFkHzX+0rY/qo0MNKDKDBsKYazdcKOBgaGrSsD4iIPiFuWhGaMNcrcVQl4qjlA
	 zLYi9CNJ5M8HKXwWG/pS3ahETFqc1EKJSoXn0apQEJCIGkKitXv4TPXKSkQ41OhymQ
	 LVK+fhiFvh4KQ==
Date: Fri, 13 Oct 2023 14:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH net-next 00/14] net: tls: various code cleanups and
 improvements
Message-ID: <20231013142352.3e8ba167@kernel.org>
In-Reply-To: <cover.1696596130.git.sd@queasysnail.net>
References: <cover.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 22:50:40 +0200 Sabrina Dubroca wrote:
> This series contains multiple cleanups and simplifications for the
> config code of both TLS_SW and TLS_HW.
> 
> It also modifies the chcr_ktls driver to use driver_state like all
> other drivers, so that we can then make driver_state fixed size
> instead of a flex array always allocated to that same fixed size. As
> reported by Gustavo A. R. Silva, the way chcr_ktls misuses
> driver_state irritates GCC [1].
> 
> Patches 1 and 2 are follow-ups to my previous cipher_desc series.

Nice cleanups FWIW! Sorry I didn't get to acking it in time :S

