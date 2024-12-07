Return-Path: <netdev+bounces-149916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DED79E81EB
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2B7281DC7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911A153835;
	Sat,  7 Dec 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fMc+1EA4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6756A38FA3;
	Sat,  7 Dec 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733602961; cv=none; b=EvzMU1v1SyN8A0lVBxa15gLzGEn7kBZlfS51p7BSdMyoehJlQn8SNFJf6jQ/HfisOXlrKqOqtB0kEN9sNpxgnMItPj11jcPFAnN0NysOhUyhh8crwpxEMmSv9HRtNvPkrRryC046Nn6kuAhWyDkgFEo28aJ6Dgmo6v+DLMMyXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733602961; c=relaxed/simple;
	bh=dJeQR7JHkDb+R+n19PfgT79IMI8iDZvMntrXyI2vNgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGdxYD/9yX125uM9cSmqTvczKFkxvQS/GlAY87zLbCf6hUm/SPq/+yoCxl3az9cjfAoe/ApoLC3rHpPZcs4GftcSy72UCIBldmBfRut/QY8uwVX/WwrwcjxkAo+0+XR31O57IEJDwXKkNSWuksK5IFRBNXRkM/BvMdMljpwSLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fMc+1EA4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AdQDxGNQHNVKv36ErwTX07LnqwQfzWDJudJ+JjKzK40=; b=fMc+1EA4XaEGbVLwWgiuWR0mRc
	mlO5GK7r9DZrcMPs9DAZwmCHKJ2KFj06FeOc5Vl3Kxq7Ytwvf5pEU6/BGx0By3vQDkcAaDb57LUya
	FS6SMNua8lKbSErliWYWevW/bsJQg/A2t+wd6D/tcPGGOQoRib59OAjGGQIIxAt3GAqc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK1Jy-00FVGB-Us; Sat, 07 Dec 2024 21:22:34 +0100
Date: Sat, 7 Dec 2024 21:22:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 1/6] dt-bindings: net: dwmac: Convert socfpga dwmac to
 DT schema
Message-ID: <031e9299-4722-42ef-94e9-ec4985a0e73d@lunn.ch>
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
 <20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-v6-12-topic-socfpga-agilex5-v3-1-2a8cdf73f50a@pengutronix.de>

> +  phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phy mode the ethernet operates in.

I think you should be getting this via ethernet-controller.yaml. And
it is not a phandle.

> +
> +  altr,sgmii-to-sgmii-converter:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the TSE SGMII converter.
> +
> +      This device node has additional phandle dependency, the sgmii converter
> +        - compatible that should be altr,gmii-to-sgmii-2.0
> +        - reg-names that should be "eth_tse_control_port"

Is this a PCS?


    Andrew

---
pw-bot: cr

