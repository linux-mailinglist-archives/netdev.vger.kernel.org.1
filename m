Return-Path: <netdev+bounces-201048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4AAE7E99
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E9D16D3F3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27429A9E4;
	Wed, 25 Jun 2025 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjlymxbX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2A1F12E9;
	Wed, 25 Jun 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846071; cv=none; b=NWhMUabURr7oG6eQnSjMN0qNgwBEh0ybmyD+aVHErPo6OWS97B10ds+oJQOi9WN6/mQz2+Bv8vGbapWVxslzpYEoX1Pe0MhQM/0RyEDPr0cSuO7w2xqsnuiWblx7rzTHzsxKk2bD1XMBlZaR25Abzu/qL5Cl+pKl9sB7+qUVNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846071; c=relaxed/simple;
	bh=8kL53wUxhyeTo74iXjVU0IZdTi1MXnzx/j11F2AlHXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ3nvCtaYiphZltVy/nPAL2g+EaoaGYNbqdrh8hA+Z2fNI/XCaYvZzDkWrONMJFaQOSJt0uBKO7ytRfcxr4W6PTC/EU9RjC7NvwXjLxVtveBQ0kFSyWp10FZkpu4Lhxdr3VZoQ7VeQFRX1rSra8Li4Pzwo+3HKhfblFduDkgHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjlymxbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A80C4CEEA;
	Wed, 25 Jun 2025 10:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750846070;
	bh=8kL53wUxhyeTo74iXjVU0IZdTi1MXnzx/j11F2AlHXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TjlymxbXxJ5mfN4z5vvLHqUc41TrBsKLKzy/GHpQpvJADQt1PbXjgQceUN+3EyOJL
	 2nTdimYmWFdxKzRqnkWUr/XOVDmTCYXIVFiTLNXrBEaEUiZquiWpNLdPI+dSxCNWHE
	 jhvxgwZ0b1iDauisLJUGZlO4Yg6Vwl8GHTqH+eG8xivV4uXk3e2VxRFP9dP6IyhmJC
	 aD9va7vTr6e8mUDE10ji82jV9Vr+t5zKddmqJ9kikCwAY8GmLxtCxv1KeEql/SXyJn
	 sch27QTY9+ePi5L3/7lr9Cq71Y8ZUvL/Mh7N8hUuv7zZmyicuXa9adWVPQRJY2KpGZ
	 W5a6+CDtqcf3w==
Date: Wed, 25 Jun 2025 11:07:45 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] net: skbuff: Drop unused @skb
Message-ID: <20250625100745.GU1562@horms.kernel.org>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
 <20250624-splice-drop-unused-v1-7-cf641a676d04@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-splice-drop-unused-v1-7-cf641a676d04@rbox.co>

On Tue, Jun 24, 2025 at 11:53:54AM +0200, Michal Luczaj wrote:
> Since its introduction in commit ce098da1497c ("skbuff: Introduce
> slab_build_skb()"), __slab_build_skb() never used the @skb argument. Remove
> it and adapt both callers.
> 
> No functional change intended.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Simon Horman <horms@kernel.org>


