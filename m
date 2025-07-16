Return-Path: <netdev+bounces-207342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A267B06B35
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F21F564766
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743526560A;
	Wed, 16 Jul 2025 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2wjWYYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1C264FBB
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629843; cv=none; b=Ox3gd/lj2jL54EFaTrTB3p2DRRRP8uSJBDpN2ddrcfow14qPWyFwkyqq60wTyPvkMZoGU2GxW22rQ9kUA8/hqtf/k9/WgbwBvcCKGSaS44XVpVF9p5Cq6I1y43p5jFds6ojG7A7v1gW09dyheXF5Oz85SHdPj+0ymdS1+4OsPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629843; c=relaxed/simple;
	bh=wOr6+uXIFBh/+DTMjgFVXtaoZWzUaFr3JJgBKW4ZHRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dswMX5IxdhtTonwrUS1fqgJpIe08cp9Oe36+6y8Obn14uWlfoPBm3AKc2UykoBIXjmP9tgltOeEtQ7ZSzb/KICvjmhH4iNDtVURCe2FeQkG2wgILWQ+n0eWaNRzm9nrz2OC745rmdeysiOiGvU1qMAA525/zt0BmGR2IdPGqwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2wjWYYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA52C4CEE3;
	Wed, 16 Jul 2025 01:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752629842;
	bh=wOr6+uXIFBh/+DTMjgFVXtaoZWzUaFr3JJgBKW4ZHRo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X2wjWYYoyc0WeI1ebmCUQn3VXewN8aNZznHdQLDHciiCP6Xlc0yTdeNJe5pB7Vv2x
	 SXiN2qztSrL+ycZrvOAoehjqxPbfuBkKkA7MnUjE4zJ/xVxClnGlnaKL57qLWo/I3s
	 9tcCaO8kJuVm6fi9ltydGh0Yd6DrlbQxcUIF30RWQ76ng4pb2941LFpxsayp4uY9ev
	 U6YQxbUrsJ5snjpASesdhT8MJitaf6imB2EBapJlGnva51FdzgEN6yjI7kHPC0LZtu
	 drS/fIFPo0GVjmFiYEZZQWNvIIJAmRgEoxB2HTF/kz6PiDy1/mja2cQEx1Ztt67ju9
	 5sTGxWFfMG3+g==
Date: Tue, 15 Jul 2025 18:37:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 08/15] neighbour: Annotate access to struct
 pneigh_entry.{flags,protocol}.
Message-ID: <20250715183721.5e574b33@kernel.org>
In-Reply-To: <20250712203515.4099110-9-kuniyu@google.com>
References: <20250712203515.4099110-1-kuniyu@google.com>
	<20250712203515.4099110-9-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 20:34:17 +0000 Kuniyuki Iwashima wrote:
> -	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, pn->protocol))
> +	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, READ_ONCE(pn->protocol)))

I don't have a good sense of what's idiomatic for READ_ONCE() but
reading the same member twice in one condition, once with READ_ONCE()
and once without looks a bit funny to me :S
-- 
no real bugs, but I hope at least one of the nit picks is worth
addressing ;) so
pw-bot: cr

