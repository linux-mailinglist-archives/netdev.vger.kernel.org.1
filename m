Return-Path: <netdev+bounces-249619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C7D1BA3B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7D1301AD16
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 22:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC534A797;
	Tue, 13 Jan 2026 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFdasWx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B4241690;
	Tue, 13 Jan 2026 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345044; cv=none; b=WkTEHvRXukVhP10Baju/Lve/b6xp1qq5Gy00wcugt/L5tg8v8uIiYNyg1bNesNvxuI0RPwJQSDE/tCkr/+MNkIGUtBdvpTWGtf1+U1V/gunSEG8UMaVYoqkNjGeFaGpy6Eda7rI3FiYxDIHmefcRgkiMU23thJMwDEp/FlBgowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345044; c=relaxed/simple;
	bh=/VOHhg+BGXPkNRZ89eA1uek4P5riQp1mlGx8ZixiYbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUDJCIMZheIzFqJseerF3GrKDlvCmw5ZNSCW+1pfBfOxMWpKkh+D7mm5/ZMY2eg2/vkKUhnFbAuwYzyEjty5z0MAiFZzSLkwoCnHvm034lP0OIALN5SUCh3M86CylrOlYib+GkjS9zRt2D70GRFQwpIfni0YYSntUhtUUBarHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFdasWx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D34C116C6;
	Tue, 13 Jan 2026 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768345044;
	bh=/VOHhg+BGXPkNRZ89eA1uek4P5riQp1mlGx8ZixiYbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFdasWx5pC6fVJ1H8GZcX26x6Gj49Z3Eo2u2mv3//WQIHweZaauLn9+EwlX7pcU+M
	 066YUvqnxHXqVwFrvOJa0o6C/tLjve6l3sI794elsbdVtASK3YJM3Y8fAAse+pnnrU
	 SMwNf3uJNb66kwi4v9DatKsP4SMLUQhjrl/j14qpKIt27fhc3p/OLqsBbBKk9e1B3J
	 DcJxKg2XKFYlJR7qWSiEGTcLs8cc0sGYQvL8l6cxaAcDUGiP42ltDO5n5l2GEh6/R+
	 ANdgMjn5VOUd1wNyr9Z9MXLKQRDA03EKsMRdi4s9eENmZGytvE0etq8fgKmMBNPacV
	 GbcO9kPVEhiQg==
Date: Tue, 13 Jan 2026 16:57:23 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mamta Shukla <mamta.shukla@leica-geosystems.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: net: altr,socfpga-stmmac: remove
 TODO note
Message-ID: <176834504228.390747.7474815974148199421.robh@kernel.org>
References: <20260108-remove_ocp-v3-0-ea0190244b4c@kernel.org>
 <20260108-remove_ocp-v3-3-ea0190244b4c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-remove_ocp-v3-3-ea0190244b4c@kernel.org>


On Thu, 08 Jan 2026 07:08:11 -0600, Dinh Nguyen wrote:
> The 'stmmaceth-ocp' will no longer be used as a reset-name, going forward
> and 'ahb' shall be used.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: Addressed Rob Herring's comments and updated commit header/message
> v2: Introduced
> v1: n/a
> ---
>  Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


