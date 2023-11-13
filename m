Return-Path: <netdev+bounces-47425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F237EA292
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93C41C20918
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BE22EFB;
	Mon, 13 Nov 2023 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5u+VDi8+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8E22EF6;
	Mon, 13 Nov 2023 18:11:12 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869FC2;
	Mon, 13 Nov 2023 10:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ILSZE9/+acMQ5UCYwW4X/ljLaf1vcUCrGIfSeBLTBSU=; b=5u
	+VDi8+qFm+Ar+6h8/c6u50czBnCpcv/fSy9fgL5E+D+cXvzQXTtgrPGgVj3Dhb4rRJmBPXvxcio1Z
	ZN0dx2sQW/mR/+lnEQoV6xy4YBa//luWyaSVZF12Gbrs80Ug250XzXlUSvlnY3bgEV8EcduG6bU3S
	FvqGKo2OIBL9E5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2bOr-0005qO-Hz; Mon, 13 Nov 2023 19:11:05 +0100
Date: Mon, 13 Nov 2023 19:11:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Prasanna Vengateshan <prasanna.vengateshan@microchip.com>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: ethernet-controller: Fix formatting
 error
Message-ID: <a4e5520f-b45b-47f8-94a1-7ab09398ea5d@lunn.ch>
References: <20231113164412.945365-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113164412.945365-1-niklas.soderlund+renesas@ragnatech.se>

On Mon, Nov 13, 2023 at 05:44:12PM +0100, Niklas Söderlund wrote:
> When moving the *-internal-delay-ps properties to only apply for RGMII
> interface modes there where a typo in the text formatting.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

