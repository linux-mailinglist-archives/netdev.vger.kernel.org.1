Return-Path: <netdev+bounces-153758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B29F99C6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073751883AF8
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58D219EB8;
	Fri, 20 Dec 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3gK4mSQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43F218E8F;
	Fri, 20 Dec 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734720512; cv=none; b=mQmLbAy6LwJs4qfmcY7uycYKLd07LtDEToslzj5NlR476srQc+Cil9tOp7kCOeqszNgSdJQYeAWVBEzLN5maQWFqxs/mKGytmNt/8D1fItWlUmoQwoUJu3nFvN6HSPwYo2XpvgLpe0rUsXKSzEiiWDV/0SORQZLMuNHxeCpSNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734720512; c=relaxed/simple;
	bh=1JLXwwJE0UBSaPTNzFqJoO1mWCh2j2CTmNX8XJFabFk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKQ8Q8mnK3vf3lGCDL07UMsfs7lfhrDd14u5PgBl0EMTIisknO56f15k6gGBoMjf84FTpGzyEz1SLfRIgnDrmKoMdvW3qoLxzlPgyMaX+XzJiilA/itumwPZ75oRQX194g/T/D51nTh9rXRW1SiAY21pSln0mYp1JbTjN/VG5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3gK4mSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1896CC4CECD;
	Fri, 20 Dec 2024 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734720511;
	bh=1JLXwwJE0UBSaPTNzFqJoO1mWCh2j2CTmNX8XJFabFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W3gK4mSQrCXGg9l30M3p9LkM6XIBSn97gFX3pmvgBNymweX7uuvJh6haPZ9BJQsIz
	 FN7N3g4O+xIVXJWfhN36vn/54RaRbcKGWHRHNHBECI2EuZR58j3ecxBesUCcWjflTw
	 qsQw7x0/IdhfBSz2ktIxZgGs1OlldIHfvuuwxysdBm1jqT2d2DhHrqLkJ8z+Y7j33j
	 fIav93vVD4zV0QVFZX6iElmw+XiFOI/Nt69RpKpWoF1fTbEZsx3EOtmE7l2Nk9CAVv
	 aCWqN7MLD/46FSFhNtqOrfz1NHDRTIW9Dy810rTH3DtkEfb+DX/Kgu8acQyf9oWVTN
	 A4+HrtZdwLTdw==
Date: Fri, 20 Dec 2024 10:48:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/8] Introduce unified and structured PHY
Message-ID: <20241220104830.1c38da07@kernel.org>
In-Reply-To: <20241220130836.1993966-1-o.rempel@pengutronix.de>
References: <20241220130836.1993966-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:08:27 +0100 Oleksij Rempel wrote:
> This patch set introduces a unified and well-structured interface for
> reporting PHY statistics. Instead of relying on arbitrary strings in PHY
> drivers, this interface provides a consistent and structured way to
> expose PHY statistics to userspace via ethtool.
> 
> The initial groundwork for this effort was laid by Jakub Kicinski, who
> contributed patches to plumb PHY statistics to drivers and added support
> for structured statistics in ethtool. Building on Jakub's work, I tested
> the implementation with several PHYs, addressed a few issues, and added
> support for statistics in two specific PHY drivers.

Unhappiness about kdoc persists.

make htmldocs says:

Documentation/networking/kapi:125: ./include/linux/phy.h:1152: ERROR: Unexpected indentation.
Documentation/networking/kapi:125: ./include/linux/phy.h:1153: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/networking/kapi:125: ./include/linux/phy.h:1172: ERROR: Unexpected indentation.
-- 
pw-bot: cr

