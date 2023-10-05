Return-Path: <netdev+bounces-38286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970B7B9F6F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DFFCC1F2339A
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE429401;
	Thu,  5 Oct 2023 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWBrYILR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58FE286A6;
	Thu,  5 Oct 2023 14:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC80C43391;
	Thu,  5 Oct 2023 14:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696515845;
	bh=FGuHU46Lr0jpYh1Ku2bBcUUkixhkfj8A97mOmqhLY9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eWBrYILR5Rxm/aZmNMhNTfzK/arOSg0g7uUmQewyzH8/KQD5440TohNLi6YJuf04p
	 hKxRS00DhzINa0WAPlEbs9ZJ+nOclUO/N/2icyew+WDO40FEj5McWKRv52QpBbmCyz
	 Se9yCumv7J4M8tMFIJJWST+brCocBob76e4QeDReUgvnES2/mTb3wvjK6FkvHnRfKG
	 4nSCJvlvf/940W82imytwM4wfG6OGe0wwgLEFJVVwwvrQQS0A3PliAY3HAaOMhp9Xw
	 3rK2YcpHxZPsIMbNppRzZsB/8yH05xrwBAXqSw/10Szoyufyeo7FM6tDyQLRRrKdQK
	 dhHRB+5LAv+AQ==
Date: Thu, 5 Oct 2023 07:24:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christian Marangi <ansuelsmth@gmail.com>, Luis Chamberlain
 <mcgrof@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
Message-ID: <20231005072404.783b00f9@kernel.org>
In-Reply-To: <56227e76-f01f-4b90-b325-1cd9ecb8d5a3@lunn.ch>
References: <20230930104008.234831-1-robimarko@gmail.com>
	<20231004162831.0cf1f6a8@kernel.org>
	<56227e76-f01f-4b90-b325-1cd9ecb8d5a3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 04:43:51 +0200 Andrew Lunn wrote:
> The Aquantia PHY and its `firmware` is just weird. It is more than
> just firmware, it also contains what i think they call provisioning.
> That is basically the reset defaults for registers. And not everything
> is documented, and i think parts of that provision contains SERDES eye
> configuration. So i think you end up with a custom firmware per board?

Ah, that makes sense, thanks for explaining.

