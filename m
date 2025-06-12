Return-Path: <netdev+bounces-196753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498AAD6422
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA6189E1F8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499E3D69;
	Thu, 12 Jun 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjyn+Noh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853A11CA0;
	Thu, 12 Jun 2025 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686532; cv=none; b=k7r6T3ddH2yyaZS2f/fnxw7oumNB1Kaxm6X8MqNP06odIgEwOCqqmQWTheKw8wqkfhZNpccMzvmQyYykJwX9rSpk8hMIQvpNV79YD5EetlFUHd4+6wlhnQJzcjHKJOfJaeKoblp3iJ7wwchva5XN/e7bLRw0+/p2qZ6XTB6I7rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686532; c=relaxed/simple;
	bh=QZ/fn76hbIECH2SJNsLWkYeQQ/XFL72WxozjIyCrQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R46Kx0iM2w7EwXGbryjiPqSa7r8/r0HSK3qptnBMWBOUpPUvD0EcdnHZiSm6X6ATQl2estHmqWcw1pKMxWrCbjTIg1LOxgb4Vr+TUVCdkiAGNpRkUCbzYx/jbsMeduRzKCRrgPp5MXg95pzjjMkRy4kTDcz5mbS0L8AImBLiNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjyn+Noh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7590C4CEE3;
	Thu, 12 Jun 2025 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749686532;
	bh=QZ/fn76hbIECH2SJNsLWkYeQQ/XFL72WxozjIyCrQXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rjyn+NohjKOQ7SiU6IF8v3IyU/H/Usnw4tSJgqG3xE+AjD1k7f0Ig2AYXS03qf5IR
	 x/wXVykDQhY3YAWqcFMaGU299A+AcmYsxx9QMN0lTOeUvUiuys2jH8lkkBqu5uwmZQ
	 zLmevpnwbcMgMAcyjDg0n3C2JQDsJ6JPL1YdX9UTdT9A6+x48iZCZHMn4wr9iEYzic
	 ILxaXO2VhjID8LkGbQ+vrq3w3h8PRPhSK5WzzB2LGARMUkW4dE0uDnDRHQEay5942G
	 BuRQa8Qmcc+2kqw1tPMiugEo4CavoFYgbcTYU/SZNfdZrBYwzsZCQKzQknHytUaE0V
	 9pyQ3m1EF0kLA==
Date: Wed, 11 Jun 2025 17:02:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg-prueth: Read firmware-names
 from device tree
Message-ID: <20250611170211.7398b083@kernel.org>
In-Reply-To: <20250610052501.3444441-1-danishanwar@ti.com>
References: <20250610052501.3444441-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:55:01 +0530 MD Danish Anwar wrote:
> Refactor the way firmware names are handled for the ICSSG PRUETH driver.
> Instead of using hardcoded firmware name arrays for different modes (EMAC,
> SWITCH, HSR), the driver now reads the firmware names from the device tree
> property "firmware-name". Only the EMAC firmware names are specified in the
> device tree property. The firmware names for all other supported modes are
> generated dynamically based on the EMAC firmware names by replacing
> substrings (e.g., "eth" with "sw" or "hsr") as appropriate.

Could you include an example?

> This improves flexibility and allows firmware names to be customized via
> the device tree, reducing the need for code changes when firmware names
> change for different platforms.

You seem to be deleting the old constants. Is there no need to keep
backward compatibility with DT blobs which don't have the firmware-name
properties ?
-- 
pw-bot: cr

