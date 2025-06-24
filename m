Return-Path: <netdev+bounces-200663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A01AE6822
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF614177395
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474982D1911;
	Tue, 24 Jun 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3jPnQGA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DF3FB1B
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774393; cv=none; b=eDN/7PZgu6yb55QNe2jycrRp6lLEb7B7Fn9XZ/1lJMb5ZfnJ+Av+MOIz9HTluM3Pd9xj+f9+aukZvqgHrlsOOKjCxfRt7r0o/Cul0fM2tsB08E0gW0raxeO7ArTPl3CzsyCBws04fyKStuOQI2sY+7wM2LU3tbA27e4LOIMjKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774393; c=relaxed/simple;
	bh=M7Jkij5dL6RJ8tUvYJpQZDxyKby0JHAppllMDhq7jTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQ+63Rq8TDUhhRfVDjPoHUMnkmJSALK8W075ymjKv6b2YUIY3dXn1t8CW5W2ASLYmnbq1JN9WcHLsS2pEISTUPEEB7l6MwnhcnhAGJIWycoMry0aJLhobenoechGkVpieZ8vThuoxI/c05zkuVerg7fVH3H12mzXpEPeI5VXfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3jPnQGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A87AC4CEE3;
	Tue, 24 Jun 2025 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750774392;
	bh=M7Jkij5dL6RJ8tUvYJpQZDxyKby0JHAppllMDhq7jTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3jPnQGAI7au4SO8MDug4REqlFnHtYnksa7+W9VeTUI6ZHFzyMYL9tn7/gudbHL6n
	 N4pXCWi4TNrUBpSJuO1F2H+0U2xg36+SMlEwWbumlJBdtW5LM3yhQ5Xsq4LWXJusNq
	 ZaHqg4nCVFNJklDXKIa+q8gKzck8tw+yubb5hVQWx5ckB8ecgGDVsdh3JtP1P1aFZV
	 9XRCSdsWd2hFjalqexg+N5b1aFGAaoiRkGu7nk0SDwy0jas2XoQBahM7ygc9H7WlDi
	 1LdbkyTwv5XkX7AgoUJOSVMUDPDerfveQu+X5opw9qJbJX6QBlm/02aBtwcg3FHUD6
	 uirrv2n3cOsSw==
Date: Tue, 24 Jun 2025 07:13:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, jdamato@fastly.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 0/8] net: ethtool: rss: add notifications
Message-ID: <20250624071311.69e48ec4@kernel.org>
In-Reply-To: <20250624080004.7a36543e@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250624080004.7a36543e@2a02-8440-d115-be0d-cec0-a2a1-bc3c-622e.rev.sfr.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 08:00:04 +0200 Maxime Chevallier wrote:
> I was able to test the PLCA path, which works fine :)
> 
> So, I reviewed and tested some of the ethnl patches in this series,
> though I wasn't able to test the RSS-specific aspects.

Excellent, thank you!

