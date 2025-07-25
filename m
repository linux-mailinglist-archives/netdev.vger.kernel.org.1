Return-Path: <netdev+bounces-210233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAF4B1273D
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B40AC1185
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178B25E451;
	Fri, 25 Jul 2025 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsjicyBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C761E5B82;
	Fri, 25 Jul 2025 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485651; cv=none; b=sMqyOHgcEujrIzvqgg/9vnB8BkH61x+fRIKV8cjwRyzwrtiLVqhX3nNK4Dho+aXNWedKknf78xU4wFQBP1z0OgBKdbKUPhafRA+y+3a6km7hRgM0y+x4lNlypqZqyPi7VTdTnJ0WAjd1LOJcNqSZS2Xv0HOpUu8PYKkxIx1nbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485651; c=relaxed/simple;
	bh=P0Be5bDqu9md62WLMfdC5YJpwp1OUVSI/ayOTeFv5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsRMJioH2OEMrHw4BPUMtuE5yq94BhvZWhf6/GjntwqLJ+UF2p6lhFPhQm1lJnkslSQnvi2QXMDQ78oQD1SrgSLisaj/aI8VqvQRcizrI4auTyvzBjwNmCIFnn99U4dYYCSwzMn6B8NoU5hbVv9i76SkKYgPdq0SKxu7VOaB1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsjicyBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E26C4CEE7;
	Fri, 25 Jul 2025 23:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485650;
	bh=P0Be5bDqu9md62WLMfdC5YJpwp1OUVSI/ayOTeFv5gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsjicyBL5ra/3EOkCNyIaMBr/fmRzqfnzhPCW0KvkRTKE9FPpKBTbtuE2BEHwtCwV
	 h3FXmnekkQJSiCSJGFSMVWGXYtsCSNaJcWYJYEGV7vAbIhF2rwQ+RQdBdTqjDxtS73
	 7f3u22iJvadeL0XZ3dRUg4kgVr9Pcr6q90mUxhRWKpVKlTdKJ6DAdE74uB8jbuDusG
	 OEvblu4ORa9FB+FUzxRd+w+bWpDLpabqfckFE5wctZ0e/ajpoPLdm/ggCKkM4GkNCN
	 7cNpKnwgm2ERxFGMvJ/r59r/CqxpPZeX7p96PJNKaygCa9dfY71g3c4WjrRlvR4hFH
	 3oF7M2yqFqEdg==
Date: Fri, 25 Jul 2025 18:20:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru
 Tachici emails
Message-ID: <175348564867.2018896.7868293571864957620.robh@kernel.org>
References: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>


On Thu, 24 Jul 2025 13:37:59 +0200, Krzysztof Kozlowski wrote:
> Emails to alexandru.tachici@analog.com bounce permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace him with Marcelo Schmitt from Analog.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Marcelo Schmitt, could you confirm that you are okay (or not) with this?
> ---
>  Documentation/devicetree/bindings/net/adi,adin.yaml     | 2 +-
>  Documentation/devicetree/bindings/net/adi,adin1110.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


