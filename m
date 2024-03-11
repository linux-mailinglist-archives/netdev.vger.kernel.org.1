Return-Path: <netdev+bounces-79205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A087848D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0020F282E00
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CA41C7A;
	Mon, 11 Mar 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqQi97d/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997174CDE0;
	Mon, 11 Mar 2024 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173023; cv=none; b=bCRLvhrv6t41JQwYNBTIlZI8nTXB9kib/fCHbvL6XRQIKFAqqgaN3h1cpXh/HbHRpbVEBEvOm7Tm4ggjLciZHzYysmTRVJ5qwhnVqz0tW1PIOM+jOYUTPkuScuirZwsDhoc+pQpWHxUXOj3srZvgdtlHjb0HEI/5hFpeKszdDwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173023; c=relaxed/simple;
	bh=IQ2AfFxikmk5U+8nWeI3XB2vOqdm6NYFDmK5mhJMrjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uc7VYOjN4ZaKJ4cFy1s136KDlswyn21WOLSpOQnWPL5T1fGyaBHGvO6CZfRRxdYczZ0Qd3r1TRt5p34Uremya1L2vhxh86Hl+KYjDzxa7P1uFhtgk1WngoRsC1oqDUmy6Qmd+nEsUau0IfoIDOIImcvWM1dYifZ9GkAoGe93ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqQi97d/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD972C433F1;
	Mon, 11 Mar 2024 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173023;
	bh=IQ2AfFxikmk5U+8nWeI3XB2vOqdm6NYFDmK5mhJMrjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jqQi97d/3zBbY8YxDP7/y+JGZYkqLDyXP5Zylg4mrmY9V499OoKyW9ha19xDT1s2j
	 cG9Lfgs/cCWdJDIGOWQOJeZDvM3zDY6xi8HIbCvhizDoI8s5HIMiQnyzqh7xaTp2up
	 Onpyy/703Z6kVFkWiIZ/b238xKS88I0RVTRcV2wZEg9lTdGqd31OZzEGbCj9hG4zAi
	 OXo0mx9W6G0S0CudeQnmh5eql5XEzc2M6QMsS7w2npJjATNpLNw0MI0ujSi2vuVFfZ
	 BZYBvl7T9lKAE5/Nqb5wt4p0r70E7e+C7Rj3tjlrTyRr8Z7GMm/+THMOQHuo4PlOv4
	 w3PueFmKlJAdA==
Date: Mon, 11 Mar 2024 09:03:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v11 4/9] dt-bindings: net: convert
 hisi-femac.txt to YAML
Message-ID: <20240311090341.32509303@kernel.org>
In-Reply-To: <SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240309-net-v11-0-eb99b76e4a21@outlook.com>
	<20240309-net-v11-4-eb99b76e4a21@outlook.com>
	<SEZPR06MB6959090F2C45C3E5D6B3F9F496262@SEZPR06MB6959.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 20:30:21 +0800 Yang Xiwen wrote:
> > +  clock-names:
> > +    items:
> > +      - const: mac
> > +      - const: macif
> > +      - const: phy  
> 
> Still not very correct here. In downstream the core can also have an 
> external PHY. The internal phy is also optional. So maybe this clock 
> should be optional.

You are responding to yourself 4 min after posting?
What is the purpose of your comments?

