Return-Path: <netdev+bounces-108217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936F91E69A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CD41F234C8
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A016E89F;
	Mon,  1 Jul 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOuUFE2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786C16D31E;
	Mon,  1 Jul 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854857; cv=none; b=Nb5LkQ6vUT0e+JOOh2Ui+CBeqYlf6jnnV5sEfmDV237F5H4IyelEf4EVwc2Zq9IJH8igiFdmMdSka3Re17qJRanMAjGbP0jRvAUNfxw4B6Gw4bHSfI01lkSdsWgDFJ2atzPGw4jpmdWtqXKW9AYRNoy8VJ8SQ3fFkxAvsrGtRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854857; c=relaxed/simple;
	bh=WhySC+CWoDzq2eZaqyGSWY4XkTyZrFTCeeNH2YSu8oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5Kq8O05b/rmYLMnAfB8S/ReJ5QHVSlY7NEo2DDfShOxE6rH/0LP4gEHGbYI0V+X19ojVtndmp3sauvoxD2vHoXoOizs/LNEEWFPLHxLXa55Qs8MqtNU3vD/q6iDzfWTGHJNU/hOo5ZtD8z4XWHokS/lbev34O4nwFh/XQm6Cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOuUFE2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24720C116B1;
	Mon,  1 Jul 2024 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854857;
	bh=WhySC+CWoDzq2eZaqyGSWY4XkTyZrFTCeeNH2YSu8oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOuUFE2IosfkrW4xYzcTId5L674CpOxtkB9KTj6mobFD08Co1NjyO9m8BpOT3gmFI
	 X8EfygDahr0JkavhfcR8UafMgCxljoUctyHsV7ECFnUiM3m2gXCTdVp0LleybtEekA
	 Af2Q2Q8pky/pEU2/LWLp1O6qb4bB+r0vzTCGaJK95Iwqq4a4Tyg5UPpdrbt5Xkizbp
	 Hl3Ky2tzi7YVMSlbz25kuaQM4ecn4Xe9izWRl3YLyMopiOPqaD6ybAcUKOrHrG9K4P
	 qy0paVhHPEyzP+l/yNWckCdpva3kDk9Tk3FuMex0SI/zqgfjgJ+ci0q8YXehtnEXHr
	 PInpNJN/u7E7w==
Date: Mon, 1 Jul 2024 11:27:36 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>, netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH 2/2] dt-bindings: net: fsl,fman: add ptimer-handle
 property
Message-ID: <171985485502.144984.15918205840917891186.robh@kernel.org>
References: <20240628213711.3114790-1-Frank.Li@nxp.com>
 <20240628213711.3114790-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628213711.3114790-2-Frank.Li@nxp.com>


On Fri, 28 Jun 2024 17:37:11 -0400, Frank Li wrote:
> Add ptimer-handle property to link to ptp-timer node handle.
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/fsl,fman.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


