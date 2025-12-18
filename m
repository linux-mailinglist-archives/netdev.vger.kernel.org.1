Return-Path: <netdev+bounces-245405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C238ECCCFA2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2FB3015ABD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E9A25A2A2;
	Thu, 18 Dec 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Msrz4DmY"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB32C0284;
	Thu, 18 Dec 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079216; cv=none; b=R2OdJXdM9S8lHFWV5XhHq1gizVJpKtFIZqKOXBbKpdUlvr7/w4hc497LQUBdOFLMHeHNeGIP3Ilk71HjKOR0RenN/eeC1D9WsDlJWJzSCtkf7n15ZsMT/2SlsGodPKG0bXdHr+O60tprN1lE7pxd1RU+58IYcmwklT6i6/ZAWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079216; c=relaxed/simple;
	bh=c3F7nPgv+C6Nl83O9sMQ3C1ks8WGn9OPTnBY9SVVfFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtbUgeN8Uz506UTFvH+8eWTxGW8W5Z+xn3RimXji94AT2krJ+uplcbT9ZNaZa43haUBhNA7puUjbknVIKEoFCsLJiVqQ0eMheW5mxik3jeIZjYxtB7c9ngd5COvuBMVzDhar/cQOGm7zSxPpYoOfbVck9S0GYx39S/b8xVcLgIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Msrz4DmY; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dXHnZ11D6z9stb;
	Thu, 18 Dec 2025 18:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766079202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWQ0Znbe2bXJpqXmBfqJx+hLRXxH67gKi7nUOzN/hao=;
	b=Msrz4DmY80u7/15+3ljbe+2DElTl4kBYOZeC91VG2qaq9u2cZQVpPB95WYLa7YnbGUzZb0
	HZqctHOZDjKk2DeseAc6WM4nbTfLO1TPAL2jNR74tPj/WNOSWxzFaxStJ5WtOmqQb0cCZS
	PDx1u5YRDc1k75siC7tMMJt0xl4PZ6ozywa37QaEPh4DeEAxf0jyl/FC4TOp1FKcxOElVY
	LQjiKraB5UynkApVtgRyKvDF6yVs+gutr2zGI2mX7WWOGxwyw/2HyYZvo92A4AUntpeXCl
	aqEKPaEJaf5WaB2vhcWxlZpU6zcczES3qO4r+t+L4kr8B+oI4uJZE9Iw3Dp48w==
Message-ID: <115b421e-7e36-43f2-8307-6671d548fb84@mailbox.org>
Date: Thu, 18 Dec 2025 18:11:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v2 1/3] dt-bindings: net: realtek,rtl82xx: Keep
 property list sorted
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251203210857.113328-1-marek.vasut@mailbox.org>
 <20251205-adamant-unselfish-cormorant-aa5acb@quoll>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251205-adamant-unselfish-cormorant-aa5acb@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0a435f21a8ca99fa900
X-MBO-RS-META: qg9sd4reg53h45gct1zmiq4fedzwydhx

On 12/5/25 10:03 AM, Krzysztof Kozlowski wrote:
> On Wed, Dec 03, 2025 at 10:08:04PM +0100, Marek Vasut wrote:
>> Sort the documented properties alphabetically, no functional change.
> 
> That's just churn, we don't do this for bindings.
It hopefully helps when searching for the right property.

