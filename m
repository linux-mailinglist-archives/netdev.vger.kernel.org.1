Return-Path: <netdev+bounces-121433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40B95D1B2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2F11F26AF1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D318C90C;
	Fri, 23 Aug 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWtb7PqW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC7318C34C;
	Fri, 23 Aug 2024 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427518; cv=none; b=m326xfLbyJbdNyC7VD46I4OGyblqnAMOqR/xXm7gcX3B1wg8BSVjHTM+7Gc20zQCj0J5xqWvDQP1rHynjq2B9Kw8Jbpsy54/iabZzEoGncuEs7nVNiKysJLaC+M4KJBJmlXJozo3qSxaQScaozt7lqSueQg61FDFIn055kkNPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427518; c=relaxed/simple;
	bh=kQZ22FHnfpV09ja5wKKZ9f8Zpt3V/CPMYnoisa+mWkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcL/Jn9hwWbMPhrhErttxPBfls27Wpprkp6Pbby3AeNgiGCHRZZfVm11Cfbn3a4J+frANvBO+0LWtjWX0xs/hSwBg8UfWKhJLuWRIeJKAMIn/jn7r867Wgsmbq5lUerb6PN0Zwre+bOu8lDezsntob6Njp3oP3v1niU4leKDqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWtb7PqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73455C4AF09;
	Fri, 23 Aug 2024 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427518;
	bh=kQZ22FHnfpV09ja5wKKZ9f8Zpt3V/CPMYnoisa+mWkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWtb7PqWeJpb2f3n5KYDAAx5tnBQPGEq/uyB5SYeuPI9jac29w3Wvljm4vOEXxK6r
	 RB/qfoDNFPwyhwKJUxMzXSet72aX+fWg/4/04R5tYZH/9DZm6TZR9G+u2kukEWtnZ9
	 MYh4OXqhsWzeXML3lJfhbkSjs838ZggglbUf/SRZ0Gp4QjhHLsu9BVaqdpkL5D1ucD
	 WE0TumVDo6zFbzUR/mgpi67RETIRoXquwtiqRVo9+LxSBncr7yfdN3OQl8iIX9rQJ0
	 FFp56r8P+L8CHXctz8gfhRhm4PGDRmFRoUb1gU+sRPfXz9/CQbM/3liTjW7mHCBK3H
	 UA8YJfrG/NtSw==
Date: Fri, 23 Aug 2024 16:38:34 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julien Panis <jpanis@baylibre.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v1 1/1] net: ethernet: ti: am65-cpsw-nuss:
 Replace of_node_to_fwnode() with more suitable API
Message-ID: <20240823153834.GU2164@kernel.org>
References: <20240822230550.708112-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822230550.708112-1-andy.shevchenko@gmail.com>

On Fri, Aug 23, 2024 at 02:05:50AM +0300, Andy Shevchenko wrote:
> of_node_to_fwnode() is a IRQ domain specific implementation of
> of_fwnode_handle(). Replace the former with more suitable API.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


