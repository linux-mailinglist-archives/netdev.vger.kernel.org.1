Return-Path: <netdev+bounces-143513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C77359C2BF8
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 11:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6D1C210B9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 10:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74401527AC;
	Sat,  9 Nov 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqU4m1Vl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF44EB38;
	Sat,  9 Nov 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731149034; cv=none; b=hVQSJDbHWIp6ojV26kYDqBkbVJwHlFizHMi1pwcEcQfevqALueYlMez6kplseTFzoO3FNP53bOC0eEXsYPozmKUnsLICQO4RnAi0HK/RtZrKLKm8SJ207RvngXsdOzw6vkaVaSBbwrWTe0mOtPItoFjXnKlRzMHLFqcs4rqq7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731149034; c=relaxed/simple;
	bh=eCtZ/IwzV7vbhYPvNXehejQggYYWN8xCL6Ypf6ij5n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKXi9F+gKq2+ap3j2R95p0KA8t9oUUT3JWqL9OHmWHh1jb9tDVfFeS+kuTqB0AoJ8olOUP++7gCmKgJmcTONi5iBi92E8/RofIUn7hQet2f86bPJLu9uRqcoqE0HeLXIMmhM9E8F/NtTTLJsxmvFUnPjGJhwAQt0yoUQiiY+mTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqU4m1Vl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67564C4CECE;
	Sat,  9 Nov 2024 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731149034;
	bh=eCtZ/IwzV7vbhYPvNXehejQggYYWN8xCL6Ypf6ij5n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tqU4m1Vl/4wIEI3DgPkMQhoP/jZb7N4K3gsre9simwOB9gbJH6RHLn2Mb8/ANKZde
	 hmH6ry0kdwthEYeiSUiY9hkwsDa7wOvPFMvs0YEM0li6vB1cnS+J6NSys7kpfgeA0/
	 D3f7VDvhd6CDAIyRfi9ugDRqgI16AJRtXeM//EXzzr6GsskBNXVTYGpBuV6LdJzxL7
	 LObbzqHGoSMx+RPpo3hasyfd9N8V70ePfr0gOvoVURSPvBpzzdgmllsI+W31AkWjes
	 JrgHsycNT1GtwpBuEkVx76LAwl82dO5DFkxlvon7lCZgwkJavoQ7dReH1IDUFH1n/W
	 OQtJBmD2zLVIQ==
Date: Sat, 9 Nov 2024 11:43:51 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>, 
	UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: Add SGMII
 port support to KSZ9477 switch
Message-ID: <vy2bqhyyfvi5kum3sfefva7lquw2ixqmstx355egkqbplmte4y@5hovbiuwmqqk>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241109015633.82638-2-Tristram.Ha@microchip.com>

On Fri, Nov 08, 2024 at 05:56:32PM -0800, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> Update the KSZ9477 switch example to use SFP cage for SGMII support.

Why? That's just an example. Why do we want it? Why no changes to
bindings? Your commit msg must answer to all these.

Best regards,
Krzysztof


