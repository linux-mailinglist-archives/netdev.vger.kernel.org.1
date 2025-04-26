Return-Path: <netdev+bounces-186195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E4A9D6AE
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7A168DCC
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3307189902;
	Sat, 26 Apr 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPRqPDDW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BE15A79B;
	Sat, 26 Apr 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745627450; cv=none; b=r1pz+2JHJpDFlj7G8SM5YYvMWorFxuxvSXd4nxO6zhQ7cMKWEcDsCY+KFiE0XuNFdWNwGbK53fjXwbPtlS7WbSDL9a1bJCTD7aQ+P8mbZr/IUL7uJ7YYfUc8IF40XpjLuOByeDHlD0MKRyzGaIY1yam4Wh9ymhJ2HdPXPqm58Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745627450; c=relaxed/simple;
	bh=SryPCpR4EGSjB4aF38Gv+X+JmpIOrr7QDRaMCvge2A8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdvsf20Inf0h83Jc1mUKB6ANAxkQITwztcNalIg7NJk9+wSSeJX2hnI84Wes1rQajJ9BNw+ynjkJBF79MyyAfxNW7Z0QFVo/eaf1z4g4ycDADqeMP2gdEDCYc4S413/wcpF4e21YLhZxRkdxIjgq6og8yzVduqhseMH0MyCf2YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPRqPDDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DBDC4CEE4;
	Sat, 26 Apr 2025 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745627450;
	bh=SryPCpR4EGSjB4aF38Gv+X+JmpIOrr7QDRaMCvge2A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LPRqPDDWCj0amvSCM6UmxgZd6W7L2JSNdZgzQOsFzvoSZbHC+G6KN9eHFE9iShY/o
	 mDjZO3JetIshyq8ZlCNvn/oFaeKl4ru0vtY1x9p6RpCJiDWxTk7AIIINNGI4hlB8MC
	 zWcuvkMmDQ5cVJBoXH49YbCGlgVdqCJhiiPhxXT3gcOnl/hvOJ1Hc1Gcv3IY9yoXx7
	 52Eru26pTSgjp4eMrHil3cRQNEl0FGOPg8roP2OjxrBX2pXOxH3bWm/MFhpCMDYl58
	 VOZuEjtQGYjxd+Y19oBO6/itASm6EqYhm5/1bocqmT/VvUC/ZHoN+y0kyIGyFkPInw
	 IPLpCH6a6PizQ==
Date: Fri, 25 Apr 2025 17:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net 2/5] dt-bindings: vertexcom-mse102x: Fix IRQ type in
 example
Message-ID: <20250425173048.36dfa282@kernel.org>
In-Reply-To: <20250423074553.8585-3-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
	<20250423074553.8585-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 09:45:50 +0200 Stefan Wahren wrote:
> According to the MSE102x documentation the trigger type is a
> high level.
> 
> Fixes: 2717566f6661 ("dt-bindings: net: add Vertexcom MSE102x support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

I noticed after sending previous reply that the patchset already 
got marked as changes requested. Let me use that as an excuse to
ask to drop this patch (and resend to net-next). Happy to oblige
if DT maintainers disagree but I'm not sure we should be treating
changes to an example as a fix.

