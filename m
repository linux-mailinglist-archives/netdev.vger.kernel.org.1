Return-Path: <netdev+bounces-250743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31008D3915D
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A82B3011B35
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ADB29DB6C;
	Sat, 17 Jan 2026 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leM9V+k0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E7229B18;
	Sat, 17 Jan 2026 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768689466; cv=none; b=dfnc2PRQJrR1M5pdeBuDPYrxRUXq5iurdf6fVASiImRXgC01D7oGmFlVk7bIFalKPC9wfx94bFBKQPNkD98tOgBhdtaXjEk0OIfDxKlmVhuY/JZ7qog/TpI/xz7LE+0QOokpA5L4dgFS/hb8kPsvBm9JLWswRi5yoFiFeI4BIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768689466; c=relaxed/simple;
	bh=FbqclWGXqUUmACXyc6tnDczsG7M5Sxojm7cLQUyAhpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHh7Tovp6ER7YyvjfXM86iXDGrPHRc5bhaNj3im1WZHZ+32iIyzifMVB/2u+WI6zYdOj1RDnoR1RDuv0HSOeVwU0mk8g1rH27WqIeduju+k2fGeK85G1h89zl0LmMVRzj7QG5wRvvQL2ay7I+EExK91KTEbVDJMH3yJlhua492M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leM9V+k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A3C4CEF7;
	Sat, 17 Jan 2026 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768689465;
	bh=FbqclWGXqUUmACXyc6tnDczsG7M5Sxojm7cLQUyAhpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=leM9V+k0wbXXNTOQf1Zvtk35WODuM4u2diDvBGrDSeh9XfABxIk6zpwQzzfeVHuFw
	 82WORYTgQJ1iRwTT+zbw8HvWsIM5Rwyg3BpQp1vg+/9QVrfxtuVsV8cKh4c5J12fi+
	 Zodw0KH+4C8frvlyye82dwQpIBRZ73yTy19qf3XpppR7RrLqKkywyzvyiooyhf6ja7
	 LH4rsEM0IRB2i681uJB57x0Nw2ueq2juNtGNs3qu8X1yDeuViy1NcCS5MiSnKAitXi
	 lguemJgTvUeTYjEHzyC5tJiYd6xpMkMUcXv0ATi2KM2Xa1jGwE8qmnKgwflYe/3woc
	 odIlJ7Aa8TeSg==
Date: Sat, 17 Jan 2026 14:37:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH net-next v2] nfc: MAINTAINERS: Orphan the NFC and look
 for new maintainers
Message-ID: <20260117143744.61cb18cb@kernel.org>
In-Reply-To: <20260116180535.106688-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260116180535.106688-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Jan 2026 19:05:36 +0100 Krzysztof Kozlowski wrote:
> +N: Krzysztof Kozlowski
> +E: krzk@kernel.org
> +D: NFC network subsystem and drivers

Thanks for all the work! Would it make sense to add the word
"maintainer" somewhere? It appears that folks who wrote this
code are not listed in CREDITS. Tho maybe in this case the word
"CULPRITS" would be more suitable than CREDITS :)

