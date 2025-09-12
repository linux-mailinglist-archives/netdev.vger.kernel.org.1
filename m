Return-Path: <netdev+bounces-222370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B1BB53FF7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3550F1C8297B
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C517A2F6;
	Fri, 12 Sep 2025 01:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL2lHga7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C2415C0;
	Fri, 12 Sep 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641410; cv=none; b=IwfdyBlOwQZmOEeCYIa64ZZYsd10zgVYddb1r3BZbSTL9G+lopSUuLraQJqXhE1OMaU9yJ/OF+I1vO/LO4zn4YKrBR7lrea9LOnkRKLZjJSzaWZEW8iTuA3RP0Hlg1eTrEOor1DLeBNS0z7Ng4Pr9kN9dmRIBOkfBZYXm0QgXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641410; c=relaxed/simple;
	bh=oVjZI9vyqzeUh4xUrL+0OX408bLyDcaaLWFzVRBXa5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DweDn+DmMmwlYeKG09khRpnSJe351OX6s1hv4YRG82OofD1FBMuws69cuA55gShyHPtWXgmnyqaBe3JDPLoDSgfAH1E64n5OaND8MtvkRkVX6HPA49eFzfHKJRAXYcG9pwYpZM5hlYTgyVzg+Q11rZleGLss+/w9au5RlxeWJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL2lHga7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA488C4CEF0;
	Fri, 12 Sep 2025 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757641410;
	bh=oVjZI9vyqzeUh4xUrL+0OX408bLyDcaaLWFzVRBXa5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uL2lHga7ZJPnDGI2KadMLRDlhZjvIwdx7Pofa297bjS8qizF+qOZxPpgn18uTrOxL
	 5OE7CbUIvBImVft25p5TIAdsMSzb7qtMcwkUOcbOYFljktGR1hP5yxQDWaJxeQN9Uu
	 JkrhFORlvYA4PkcGfwjqdvNTslGhbYd9FHfMFIRBXmKS4xzGTHgTz6k46IBSKqeKj6
	 OFds7B43uH6duAUFMucx3HP1acWeX/IEDGjboJUgnV/t9SRnz+BD+0oKFepyDupD9n
	 Q8qfdB9B5AFuGCbGzW8kkmkVMOMihG0zCJYnDMZ6BVc7Iuib20UzJ+Tu48WSvz+dQo
	 MXyhw3T/Ri+Jg==
Date: Thu, 11 Sep 2025 18:43:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: Drop duplicate
 brcm,bcm7445-switch-v4.0.txt
Message-ID: <20250911184329.2992ad3a@kernel.org>
In-Reply-To: <20250909142339.3219200-2-robh@kernel.org>
References: <20250909142339.3219200-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 09:23:38 -0500 Rob Herring (Arm) wrote:
> The brcm,bcm7445-switch-v4.0.txt binding is already covered by
> dsa/brcm,sf2.yaml. The listed deprecated properties aren't used anywhere
> either.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/brcm,bcm7445-switch-v4.0.txt | 50 -------------------
>  1 file changed, 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt

cc: Florian


