Return-Path: <netdev+bounces-250413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC1D2A9DB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5139A300FE37
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DD2147FB;
	Fri, 16 Jan 2026 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OadD1y5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348D18FC86;
	Fri, 16 Jan 2026 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533397; cv=none; b=J1Gyux9kTjLHZznCE2xm2k9ncb2v1dPwYWS7rwea8mDVRTW/QEYuep9EWtH7qCA38cojE3D1AXMMAYfElA9HJp1hDSObeIUA6Bzq0GM3XIac0DLWtYdsjBGXanjM+hnakM9t3FjMQZe/Z1JvPKtboytklwmPu5dK/C9niQNw1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533397; c=relaxed/simple;
	bh=B2+FCAQTC6FVsVubt6CQsBCJNComdynPbHPZmy46ChI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYxyHZaLJRWi1MhQIj0Epgchc5a6g55azp+bGXuQkJiONb9kIoXTE8h78O5EyEdjpaHsZlnYTyqoGt1rUv9vgt1jX8U7Iur+Y/vTH5xpqeUtpyiI57jgs00ra5QWtuu9HuZKYEBjk2E8pJRTGPgXEyJ0BkE1q1RqYdS30XESZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OadD1y5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFD6C19421;
	Fri, 16 Jan 2026 03:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768533397;
	bh=B2+FCAQTC6FVsVubt6CQsBCJNComdynPbHPZmy46ChI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OadD1y5pzThcRXgoOGbwyy0e3rC1wHFHn/FBWBj07osgVMonggwCQ8i9/uRKUtQrV
	 B6GWHgrlHd6WyvQ1VATKmGsDNNcrm7Ox0DUuCGCQHzqgL/s6qgceLdNAo++4UGLS3t
	 5sbDj1BVZau4SPy8PTe1tUFZNYjZ0xh2OLzBOUK8ImjRU5st7F3peTEWJMl+HckT91
	 Rb1gi7AUhdEAAM+/swupIlSqiaJXQZAuoKFOcn+NZbtiC2HMKbzIDc68P+jjLdamul
	 1KUDgLwQXNwcgUBDpGyu4lPCPiRPyij+kXEVxSMB3gs8hqJ0I3TpVM+HoaU3Vasck3
	 2AdDsM7LITAdg==
Date: Thu, 15 Jan 2026 19:16:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Eric Woudstra
 <ericwouds@gmail.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Lee
 Jones <lee@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 net-next 00/10] PHY polarity inversion via generic
 device tree properties
Message-ID: <20260115191635.33897ee8@kernel.org>
In-Reply-To: <aWeXvFcGNK5T6As9@vaman>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
	<aWeXvFcGNK5T6As9@vaman>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 18:48:52 +0530 Vinod Koul wrote:
> Subject: Re: [PATCH v3 net-next 00/10] PHY polarity inversion via generic device tree properties

You can submit the PR in reply to the series, but please rewrite the
subject to a typical PR format. Patchwork does not register this reply
as a submission.

