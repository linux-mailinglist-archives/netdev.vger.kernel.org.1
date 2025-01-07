Return-Path: <netdev+bounces-155892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72B8A0436F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0647E163E06
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB661F2379;
	Tue,  7 Jan 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ1pttSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6C19ABCE;
	Tue,  7 Jan 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261727; cv=none; b=W5UpjVUbEEgdPUO9Y+8WtYqawLG8QfEy2XiOzFtakZ48qrVzKW9ANFteeXZgj+vhZ7voMrplXbTqYb8NlOT6KzpTxGusm2JXEYCvOYqRA8WQ+SvC2DQUCYUwdAnBtDU1CbwWRmtQ6UrZG5U8eanN2rBRaVmLmFHLsEafjr5k7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261727; c=relaxed/simple;
	bh=0CPyJsW4YG2H2oUjlR5QtvBcYIf3ixcFQrbFQ2W+hD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk9DMxIKBmnFMWeoSqGhPE6A0Ht2j0D+sr0og600/isp+zugy9utbu1XxUHZcgcOr7ArxMHG8dC2rhQ7D3cAyJNt2CveE1Kwd/cMe0jZhCnI+7pMWT8LyB/skPdQlUFBI65R8FyYHAtsjJoiKNW5XrYTbydQVLL6dyJVvG44mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ1pttSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5A5C4CED6;
	Tue,  7 Jan 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261726;
	bh=0CPyJsW4YG2H2oUjlR5QtvBcYIf3ixcFQrbFQ2W+hD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fQ1pttSYrQa9rFSiaK1VMTgmdotogdUqMpF63BgwRicUxSAS6JYi/0fC+KBVb7H5+
	 kPd3XqR4EsB6yrT2EYXyP+gdU8I6xee7Ekkz2PAwDmrb4wRm8Lr7UHO9MrH8VzBeyO
	 zZJARfcdXRtZgcta/y5q4PoBjKnWRbllJaQPDxPP/Y0KGYG/HayI+1/EC8fDk5ThWM
	 +J1bjjy3UdsKnrc0PWUd5tsmjvzzuFmgNMkYuFlnMrD5/qOse2jRG4S2lDBnbKme8t
	 gLVHwmCJd37bnLRdMqNRgmXxeg8r96edDXT0HeKJlW4Ge80GiiDKwQ0/5H9OKGdZaZ
	 KOKxBoICD+J1w==
Date: Tue, 7 Jan 2025 14:55:21 +0000
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: net: pse-pd: Fix unusual character in
 documentation
Message-ID: <20250107145521.GC5872@kernel.org>
References: <20250107142659.425877-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107142659.425877-1-kory.maincent@bootlin.com>

On Tue, Jan 07, 2025 at 03:26:59PM +0100, Kory Maincent wrote:
> The documentation contained an unusual character due to an issue in my
> personal b4 setup. Fix the problem by providing the correct PSE Pinout
> Alternatives table number description.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> I don't use net-next prefix as I suppose it would go in the devicetree
> tree.
> 
>  .../devicetree/bindings/net/pse-pd/pse-controller.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> index a12cda8aa764..cd09560e0aea 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> @@ -81,7 +81,7 @@ properties:
>                List of phandles, each pointing to the power supply for the
>                corresponding pairset named in 'pairset-names'. This property
>                aligns with IEEE 802.3-2022, Section 33.2.3 and 145.2.4.
> -              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145\u20133)
> +              PSE Pinout Alternatives (as per IEEE 802.3-2022 Table 145-3)

FWIIW, I checked and unicode character 2013 is an En Dash.
So this looks good to me.

>                |-----------|---------------|---------------|---------------|---------------|
>                | Conductor | Alternative A | Alternative A | Alternative B | Alternative B |
>                |           |    (MDI-X)    |     (MDI)     |      (X)      |      (S)      |


Reviewed-by: Simon Horman <horms@kernel.org>


