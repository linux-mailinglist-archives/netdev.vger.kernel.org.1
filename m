Return-Path: <netdev+bounces-223223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65869B5866B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4D63AFA1F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD012C0268;
	Mon, 15 Sep 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCsfbJ5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088F299928;
	Mon, 15 Sep 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970737; cv=none; b=BH3vIpOAV9RH5aIqJuVQQvUiCVJYqi/dPlOZ/GLfzX1W3w/3iq1QP0T2kv/pVcwskeTTpPFbX5P6yV7BJ5z6C/CbzOaJitms15vmLA2BCy3Fa0cLjiTH8yDGifRIjS+K5VU7kRk2hvRmYl+BPHd3uqReXagEuuzkElqfhqDRpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970737; c=relaxed/simple;
	bh=e569DrqW2wMdKdUghqdXGaKuhZNiSwu4jgI3c2gzifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4PRurkXYjOQ/MDr1ORP6K/ev6GMhXohPsnH23KIxd3F63CPRKdF49gD/tIqOwFAxJctoNUAE0b+byOlu4m/PCXm8CeRBXQcS+tVo1kNaWjraQi1sXlwNNI39RilGVYyuPTwuyX17CMavkR6ClBP2HbFHrPnEL67aUEnfIkZaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCsfbJ5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E766C4CEF1;
	Mon, 15 Sep 2025 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757970736;
	bh=e569DrqW2wMdKdUghqdXGaKuhZNiSwu4jgI3c2gzifQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCsfbJ5M/5cItyKlGpLu0+FewUKxylXkTGq32RPBjuilUtVa6xZgga1VSf8dyjHBh
	 GTGO0pJvwDkzUEK/Wd9572CKz3i5j7nvFhi2itKZGwUkBrguWf59zUWbO5sgdauL2f
	 bHAyQ5tB61iaa1gVDPd2mP5D65zyrbAs/OmPOC9+3etuFLAO83v7jrcrTN9b1JR1+I
	 Vd9JlDNQqwJs7Gq5ugW0TB0zgVklynyq+rgul3DGoPCyS9iHJTGtG29ZiDehGnHesw
	 I793zMwgvc/GHsNV16toip3mZwgnU82UYH9cVOWLQ8BMSVXyyeI34Kj1CabR/MfjJs
	 t1BTtEGca7+wQ==
Date: Mon, 15 Sep 2025 16:12:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <Woojung.Huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	UNGLinuxDriver@microchip.com, Jakub Kicinski <kuba@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: dsa: microchip: Group
 if clause under allOf tag
Message-ID: <175797073499.3420691.8350751863375484890.robh@kernel.org>
References: <20250912-ksz-strap-pins-v2-0-6d97270c6926@bootlin.com>
 <20250912-ksz-strap-pins-v2-1-6d97270c6926@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-ksz-strap-pins-v2-1-6d97270c6926@bootlin.com>


On Fri, 12 Sep 2025 11:09:12 +0200, Bastien Curutchet (Schneider Electric) wrote:
> Upcoming patch adds a new if/then clause. It requires to be grouped with
> the already existing if/then clause under an 'allOf:' tag.
> 
> Move the if/then clause under the already existing 'allOf:' tag to
> prepare next patch.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 68 +++++++++++-----------
>  1 file changed, 34 insertions(+), 34 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


