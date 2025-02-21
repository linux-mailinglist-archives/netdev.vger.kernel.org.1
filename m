Return-Path: <netdev+bounces-168690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08560A40318
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A3919E0F7F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93B253B6D;
	Fri, 21 Feb 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpQAWCC3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A62512DB;
	Fri, 21 Feb 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740178671; cv=none; b=Rfdjn5EMTgjq2m/9SOh1bvdr/er0cKkA8Gliak94b+Ca1f3rUHXEMKEa8zitB2Nbe/p0LJ8oTJ+jx0INTCFBvdnCuPYlBHSqlkgbcgWUbcjeanL2J2qgcmHGs5m/HjrnyE+Nz2iJAYuisOrNzSECGDJN6yvhX7/Q2KBbzUcO57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740178671; c=relaxed/simple;
	bh=9UAABk4E/VgDjgAnJdKT8B95CipHDB1ItXLDEM1AbPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHgHbCy6wg6kUeLqFnKIv0bij/avBR34xTv/4qlEbhSJ3YPkUg6a9cPKnRMnMqNa9gsCsYFIVmofdaQbIprXjauSg+3xzGi1DSUvafzL/zYtoYYYUMbApPCyJ9QuWkWiAkEtUa1CtbfiEb5FM2OZf23pJ3Vo2rJcsnNzDbY0qT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpQAWCC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23E3C4CED6;
	Fri, 21 Feb 2025 22:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740178671;
	bh=9UAABk4E/VgDjgAnJdKT8B95CipHDB1ItXLDEM1AbPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpQAWCC3eqXwgubC6od8p3r5bF+00Jzvkqw6Cf7YnQVmJH1DurCtRFt1SwPukphbL
	 l8tsNBHi1ASGGh57MGgH0pu957TLZtCFRFUN68PPtGuX714gpD0HlK0FnPfDJSnvaH
	 jiycw27Rflrw+afVxE7EzU5vUoM4q/E0BgS7jkWNIOIlD6uLDKLmMz99CK5TSR9VlX
	 ySXYfeW4dv85m9OpKi6CGV3B4xTze01KVhAA4ed8xC7oRHdoOvDkenkqkakncPapDE
	 JYUkqkxgKsjzYGlgRyc4LgFWy5jOyTBAKOPFwQ3KNuS+KbemzHVUpPwc5np7k4WPlB
	 6VW1MJqKThMEA==
Date: Fri, 21 Feb 2025 16:57:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	kernel@pengutronix.de, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: convert ICS-43432 binding to
 YAML
Message-ID: <174017866853.223124.7022433872565615720.robh@kernel.org>
References: <20250220090155.2937620-1-o.rempel@pengutronix.de>
 <20250220090155.2937620-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220090155.2937620-2-o.rempel@pengutronix.de>


On Thu, 20 Feb 2025 10:01:53 +0100, Oleksij Rempel wrote:
> Convert the ICS-43432 MEMS microphone device tree binding from text format
> to YAML.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - add maintainer
> - remove '|' after 'description:'
> changes v2:
> - use "enum" instead "oneOf + const"
> ---
>  .../devicetree/bindings/sound/ics43432.txt    | 19 -------
>  .../bindings/sound/invensense,ics43432.yaml   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ics43432.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/invensense,ics43432.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


