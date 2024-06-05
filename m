Return-Path: <netdev+bounces-101110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDD28FD618
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B81F2294C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31F2E634;
	Wed,  5 Jun 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmOKoi22"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56753DF43
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613678; cv=none; b=Cijo6+As0s1jydY0HXmU6HH7dmyQ9QkoLOpKAzm6b9qmDQZ802xe8rzXUK5LLqdWfURt2uVdHW0sREfDRooeBi4vPt5VpSl/mfMY++PNiJ8PQTNBB8ns5/LFchKrjbejwtVzZjnl7cs2e/GHWya51oI3aS3EvZ/nJ8xJbaU3OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613678; c=relaxed/simple;
	bh=yIFGNoUovXxvVpfbeNZt2oxdCFWufF+lsZ1uhtdDKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpdai3lr/iiIux1TvhQ0hbFltqA9Z+KKwawbuYOnBQJoNUg9/vKy1h3HXb6n01y/NorVvm8wm7VrnAaeWkLVsiFfw0lRYJ12k5r8h2r80jiJ3KKCYHjFYWLdZbpJD0X9J5BFN2xumCVDnjLArz4r4Eo94UqkMtRkssNVD2c3nbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmOKoi22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725F1C2BD11;
	Wed,  5 Jun 2024 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613677;
	bh=yIFGNoUovXxvVpfbeNZt2oxdCFWufF+lsZ1uhtdDKo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmOKoi225JAlsMwSJG9XxR6zYBn1BI5kj6N7+W/gui9zottAH75BcazK4lVcSyb5t
	 YZDIvZ4FAwjJKBgfVhPDaitSCLqeAFYiPTNYtWTuDTzlQb+KBGxofpyP65+xH9wK7+
	 tD09VMLAj2lig/Ij+NsHfDVJgDEYJv9qVHQ6CGiz6bUno7t0xOxXgXqedMah82koq8
	 Ydk8JP0eLXDTAFvTE9iZLRhppZpGIeEvjuSZzOLxZRiKj84Ca2/CiJo/1707btSfnV
	 gZ+WW1rp6gTyhtLKoeY/JdUIF/cXiCX+qZynr4xSTKPPWXFwhLz720vYjCRW1vHjgt
	 2S9GYqXY4xmkw==
Date: Wed, 5 Jun 2024 19:54:34 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] inet: remove (struct uncached_list)->quarantine
Message-ID: <20240605185434.GU791188@kernel.org>
References: <20240604165150.726382-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604165150.726382-1-edumazet@google.com>

On Tue, Jun 04, 2024 at 04:51:50PM +0000, Eric Dumazet wrote:
> This list is used to tranfert dst that are handled by
> rt_flush_dev() and rt6_uncached_list_flush_dev() out
> of the per-cpu lists.
> 
> But quarantine list is not used later.
> 
> If we simply use list_del_init(&rt->dst.rt_uncached),
> this also removes the dst from per-cpu list.
> 
> This patch also makes the future calls to rt_del_uncached_list()
> and rt6_uncached_list_del() faster, because no spinlock
> acquisition is needed anymore.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

