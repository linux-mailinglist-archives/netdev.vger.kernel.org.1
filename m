Return-Path: <netdev+bounces-177064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05989A6D9EA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373D23A5D22
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C981A5B85;
	Mon, 24 Mar 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhLHd5ZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE882F2E;
	Mon, 24 Mar 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818544; cv=none; b=e/hu+EwEDUYvR7EqAJayl9rmPE0Q8H+BzNv5a0ukU4F0iLxzmQ7/AXENQ9aqNnOs8TE712WGhRfgGl7sw+qIvVcwXwcZG/0b90XeXcLLZdvQ1I8lpiPqCTu/HwA6GblUGGqzO/vdLKa1fpyGZlE9+r1I0tZAVxU0gsF67jNSw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818544; c=relaxed/simple;
	bh=7Od0yigsdi3G7FXfza92XqylwRszAu+pduq2G1plwKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOf+mNrDGuBN9keOCQwA9NnRNvjtBbLRn6V8XWMn07u4b3ZgEhdhYkjX+uCLmcWlvR/03kGRXr0VhPx7lkXLfJ9XvJtHB8Ugjot4PhXKu5ahLy/fuCSsj4RWb/Wc1f4+rrlQApzZf31ipV1VdYYMSyCUIMiBQ+sYHuJ9sUUDFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhLHd5ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75458C4CEDD;
	Mon, 24 Mar 2025 12:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818543;
	bh=7Od0yigsdi3G7FXfza92XqylwRszAu+pduq2G1plwKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IhLHd5ZFO3bnGW6NMKJqZYdSFMOhTl+p0Sep80717xASyYrNa0tGUYIdq0HtIot2Q
	 Vgtz2hSqNIT2CGnJ8oQHjXEEQt9+7Jg041i/jPx9aNk76aQMrfN3XDefh4U4a9G4P8
	 ne7PqqzNxlYxNd72/BaEtaeoOU6E4NwEdJlku3G8yzt/xYKNg0Fxlbuol9vgcr6HQL
	 e5agd49o7hUeoSNQH54NSqMfldi9Hiu828BZYg7cgtQ2ssrmt09Gk+zQYsk6pYnQNs
	 6yJ3TXz+po+pG6yMbMv8MvWqro90HD6hzjtnfZfDn07JUYTXSpCLa+G6p6SwNYwOgp
	 bZt6+B3cSiHkw==
Date: Mon, 24 Mar 2025 05:15:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
Message-ID: <20250324051535.2ea9f3b6@kernel.org>
In-Reply-To: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:30:06 +0100 Maxime Chevallier wrote:
> The infrastructure to handle multi-phy devices is fairly standalone.
> Add myself as maintainer for that part as well as the netlink uAPI
> that exposes it.

Makes sense!

Acked-by: Jakub Kicinski <kuba@kernel.org>

