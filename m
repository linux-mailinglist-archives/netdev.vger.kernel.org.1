Return-Path: <netdev+bounces-215043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE99B2CE38
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 22:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116EB5E16A7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D8342CA2;
	Tue, 19 Aug 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVYpq7zQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F82BDC2A;
	Tue, 19 Aug 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636234; cv=none; b=Yl2fVogfGJW506w2TR3HxFOgR54b4iLVEY6sjI4xG4fxO+jJxwH7ftH4WzqJ2g0hZBBRkV+bp2TQP69WMkFaNucAWziGKQ1UE/ImwmQTUtWF+WmAfn1u+keNQDy/O+Ak6QUlsPobq9dw5je6SrQMSp0AntkGSaorutzyHF8Z/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636234; c=relaxed/simple;
	bh=fJayKz1iUIRUckBQ8dHMrsmPlqiqM0tYfP5QqS+HrQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLwaut7OZ1KhtrJY3J4qzJsdDQCzEEsDKJTcz1mHCzF1MBmTOFyACBgJs73LCFjbAK4NikQC40WaBShfJtYplPjc2yVSSfRK/LsX0GCYgOV0Tc3L56AuI7hXJkT9b+a+DzDuZx5aQcNtXEQG8Z2XyCZ3vs+XW3k/mEzdGldLJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVYpq7zQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34C6C4CEF1;
	Tue, 19 Aug 2025 20:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755636233;
	bh=fJayKz1iUIRUckBQ8dHMrsmPlqiqM0tYfP5QqS+HrQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVYpq7zQCDzaP5Jey+pgSlIjoyYr1H3CePAcxHgYgeyBAKkcih6y269p9yC7oce1Q
	 IliUTtK33jrdmwBihvAwLpo3Hr5MN2uTNKzMEwrV/k/L0AOZdONpA/5g6dqtK+S2Wv
	 2Ur1c9LhbCmXJC6HUQ67Nzrn3lm0E1cxwsT++TBrvA3cM1ChGCCZtAzDgPxp+S8pYp
	 v3aOkqhmAshLnLDxFsjqDPiN+IIA5W14SCbQyA0fHBaE1OfXiJ5g8s2DmGuG+4PyYC
	 VgZNiAsEzSNlRY5jC9eVF01DyPT583rius/TToZxQ2sqmfGHk1/wNVCjwORHLVrrkl
	 VXEiE61UQWYMw==
Date: Tue, 19 Aug 2025 15:43:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	s.hauer@pengutronix.de, edumazet@google.com, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
	festevam@gmail.com, fushi.peng@nxp.com, xiaoning.wang@nxp.com,
	imx@lists.linux.dev, krzk+dt@kernel.org, Frank.Li@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v4 net-next 02/15] dt-bindings: net: move ptp-timer
 property to ethernet-controller.yaml
Message-ID: <175563623228.1286028.14650660035550911275.robh@kernel.org>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819123620.916637-3-wei.fang@nxp.com>


On Tue, 19 Aug 2025 20:36:07 +0800, Wei Fang wrote:
> For some Ethernet controllers, the PTP timer function is not integrated.
> Instead, the PTP timer is a separate device and provides PTP Hardware
> Clock (PHC) to the Ethernet controller to use, such as NXP FMan MAC,
> ENETC, etc. Therefore, a property is needed to indicate this hardware
> relationship between the Ethernet controller and the PTP timer.
> 
> Since this use case is also very common, it is better to add a generic
> property to ethernet-controller.yaml. According to the existing binding
> docs, there are two good candidates, one is the "ptp-timer" defined in
> fsl,fman-dtsec.yaml, and the other is the "ptimer-handle" defined in
> fsl,fman.yaml. From the perspective of the name, the former is more
> straightforward, so move the "ptp-timer" from fsl,fman-dtsec.yaml to
> ethernet-controller.yaml.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> v3 changes:
> New patch, add a generic property instead of adding a property to
> fsl,enetc.yaml
> v4 changes:
> 1. Change the title
> 2. Remove "ptp-timer" from fsl,fman-dtsec.yaml
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
>  Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml    | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


