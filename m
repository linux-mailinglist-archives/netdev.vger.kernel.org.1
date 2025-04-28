Return-Path: <netdev+bounces-186351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3484DA9E9C1
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DEE3A5720
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 07:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BFB1DDC2B;
	Mon, 28 Apr 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMltwXXm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105C1D54E2;
	Mon, 28 Apr 2025 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826173; cv=none; b=dVujouk6kKxOzAkXnolxK5LJKBSTT3Kvh2xZ7u1EC5q/hCJRxt2hfWBg+Xpsvk/4NdTHHB5ZtKGHf/ND1W7D+ea1Js/2g8n+VBCHLSEKeV4c+hqqX4XN8wHKaeVpgO0uK94ivsxZogkgLZ93mwXW0MVjhp5Xa7MxIVlMvxBmV/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826173; c=relaxed/simple;
	bh=oyd9dtkqCPtvdE9R9U4L8YgZjX7r8eHxpORaswiFRaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6K8TAxMJAPQxcjv0K54XOag3PFbjs4Bl8gOEZqL6H6UHctc3JiGhVFxl33sbBxy50hKWTt7l56Q3384Ic/7ij2vZmLBpdLxAVLNPIYU43pFJQWRQG5bZVG9Ek1AB0EgTtsNch7snp0lDJcUYphgPVoI0HNsHMhHNDy2dRql9ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMltwXXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B8DC4CEE4;
	Mon, 28 Apr 2025 07:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826173;
	bh=oyd9dtkqCPtvdE9R9U4L8YgZjX7r8eHxpORaswiFRaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMltwXXmbnKVkjAEEjNe6KepcxGcr9NL2v3jvq3Ty8R2qL1eyPSsJlfxxuMf4bMds
	 OCCXeeajYyyZXOkgsZwjBv7j9p6Z5byhmmtzn6Xff956IefGp1znsix7d/90uq9pWD
	 DYRTw+OCRDBNt1xKd/Eh0aDovtue/O2XW/9C13U/E/9UAV7hXQPfscO50WviSa9Hka
	 YwVhFBOgd3BhQEzMehb2EAYAV1NFsyjn028Za2szONulX/eyeflvhXuRgV44GMlS1y
	 buwD0JEz0nG0S6nkeDPICTljC9/QiRIWqymEGU2fV1MzYjx6SLrLWXQoLs1yVb8KRj
	 lViD2uTloC8wg==
Date: Mon, 28 Apr 2025 09:42:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	Russell King - ARM Linux <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
Message-ID: <20250428-alluring-duck-of-security-0affaa@kuoka>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
 <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>

On Tue, Apr 15, 2025 at 09:55:55PM GMT, Heiner Kallweit wrote:
> These flags have never had a user, so remove support for them.

They have no in-kernel user, but what about all out of tree users in
kernel and other projects using bindings?

Best regards,
Krzysztof


