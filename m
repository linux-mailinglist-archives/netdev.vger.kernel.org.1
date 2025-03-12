Return-Path: <netdev+bounces-174285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB45A5E23A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E203B2CFD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19223A9B4;
	Wed, 12 Mar 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUkNneDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DD1E8325;
	Wed, 12 Mar 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799192; cv=none; b=UO/2ks/QeGfLpjop3KcSV41ShKbsiF4BFfB6Qcf4lMFVJwXE5uVOPYHbq+vcAqwSmNKJ/8bQ71jnPBjN88OLORY1vSwzV0oZgJkUbBYe6s93V6+ps2CW57sFB0Fmhk5HtXlZGJEVx3B+btgo6d1e0NiWfr7q0PdGYNp4kD+r3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799192; c=relaxed/simple;
	bh=Ku0zOGsgy8nW6TnGyeloxNuOmdzoa1Y4XqlQKPQdjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtw7KebgQLQjxzEci4XPh/G/XNjCM2FQa2oc/dEThE2F+FE2KdMxr9NWs8sx0HHD9yB0wzDmZdPwrxGX0poUUsOgZe/1AwAunfKz8MCdLt0SCzQkNpTwcQ/qSHbgq7NPfO7hNeOW6JlXW8qQ+/rUgARGwg9sPVh0Cn9ThZQDLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUkNneDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3862FC4CEEA;
	Wed, 12 Mar 2025 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741799191;
	bh=Ku0zOGsgy8nW6TnGyeloxNuOmdzoa1Y4XqlQKPQdjPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUkNneDdy4EQ1GGzUpIewE4E4iTQmS0e9bVbzsMi3PHjvkj/O783BQSn5VTPFDGxt
	 vuoTI0RaaY5t6ILNVue9uAIPvOq0kMnkTgl7nCMOhXZlkF++JB7ZrZPOOPiRqrJdSk
	 +65SdIAYPreQ+sHathgQZz6hLTU6KOeAM/unXaVoXTrqu8VILDKEJqH5dmcueyfsfh
	 niXA2hvWzDVU/nG1EBbBiJ1bkU0LlMYugSqNxEEAGc8ohDaEnOlQAPw3Nmifoy6EmK
	 CwUPkmPAPJOnKVFkDCVOLiB3XBrEvLS4tzRW+29IxIToXuU+s4pcECGhuYLO0UzvRY
	 prTE+ERTfIQ3g==
Date: Wed, 12 Mar 2025 18:06:21 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/3] net: stmmac: dwmac-rk: Remove unneeded GRF and
 peripheral GRF checks
Message-ID: <20250312170621.GW4159220@kernel.org>
References: <20250308213720.2517944-1-jonas@kwiboo.se>
 <20250308213720.2517944-4-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308213720.2517944-4-jonas@kwiboo.se>

On Sat, Mar 08, 2025 at 09:37:15PM +0000, Jonas Karlman wrote:
> Now that GRF, and peripheral GRF where needed, is validated at probe
> time there is no longer any need to check and log an error in each SoC
> specific operation.
> 
> Remove unneeded IS_ERR() checks and early bail out from each SoC
> specific operation.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Simon Horman <horms@kernel.org>

