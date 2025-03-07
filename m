Return-Path: <netdev+bounces-173015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11912A56E6A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21BC3AA400
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B223C8CD;
	Fri,  7 Mar 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVpLkgsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6A221D92;
	Fri,  7 Mar 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366560; cv=none; b=KFbZE5m/2AqB/KJ7rZ6+4j+j7EWf/rIUJBO6mKzIIOAz9bXxP0RcyaQk4tCaS/wGM7uqECzI7oKloqF2GQUadsR6hVXTlrUYY+GID5YD43n9n8r5GwPVoUTcpdGuqZEAoswacmzPBBXsX6WL5nE6ZYcY4679vHWH3ZXPd/JA4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366560; c=relaxed/simple;
	bh=zm4IUNRU5F9Q7F6IslhySw9XY0LvJZqmHl7UPH2oVUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBN34UTWiLbT68FEjBf4A5OrC/2in1y4dFwtPTO1Vsl7N5rSzRbftcpb2ScBCJske6hfW+ZYvzKvroV56lu0uTKTSQiq6fw+FWVViNj5A6y7W84SVlhaX5WJ+4H/CVQ+f7sFgL+RGCVtB/p5i04bdEf+y4YgfPQdgLMmjz0zPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVpLkgsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB91C4CED1;
	Fri,  7 Mar 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741366559;
	bh=zm4IUNRU5F9Q7F6IslhySw9XY0LvJZqmHl7UPH2oVUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVpLkgsm+rJ1/+ojcbOf8+M3KoFzyiiESQHwjozKAPjF8B36+xTNHrBJm+OV0IzoP
	 9DIl30BifTky83nb+ef9gFAfamPXZoSgWIfmpA9euJYTrs3wu9ivgapJI6JR3gFCA1
	 CmjG6ORlNPfFLBEhuTr35fy8VNDn2/WcqANJ0KGlI4nwtFgIJwW2aIS2H4i8v4MZV/
	 5ubKCGk/uJxRELly6gsEXqtT/B4vlKspg7bln92m2n9XTmZwRFUEnruBztw+BLShQq
	 APwS0a6x/LJuzZQ7QklhKw3O/u2zP8pBoWkBqbqNfww/A8IKi8k251LDbdwJQX11IJ
	 v5MuibhQrFa/g==
Date: Fri, 7 Mar 2025 08:55:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
Message-ID: <20250307085558.5f8fcb90@kernel.org>
In-Reply-To: <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
	<20250306210950.1686713-3-jonas@kwiboo.se>
	<bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
	<1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 00:49:38 +0100 Jonas Karlman wrote:
> Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
> 
> [encrypted.asc  application/octet-stream (3384 bytes)] 

Is it just me or does anyone else get blobs from Jonas?
The list gets text, according to lore.

