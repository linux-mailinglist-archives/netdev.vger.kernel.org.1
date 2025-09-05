Return-Path: <netdev+bounces-220243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A24B45058
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DDD7A9CB3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D72F39D0;
	Fri,  5 Sep 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHq/Q+AB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D12ECD34;
	Fri,  5 Sep 2025 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058814; cv=none; b=XpxburkXpzkuOcoM7LQOUzl1KUuA4kYPhfVJPiVFyB/Qd+k+cQjOeTTCfQ/hyTE9HNvkQ3EyK82f1s2HHnVuE5Go76CHy66L/hT5SRODlOgIm8XdSj1B8yc/srzs/tCL0Dw+k9KWzBdJDESCyz5b7KR1MH7FNdcGRuU/dYqznzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058814; c=relaxed/simple;
	bh=tTfuVxL0tJfbFNZIAPWlOg3hJrctEWrR38o7eJHMoW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/wiA7Z1+yyEjSZtc9MveQRyeDQ9+NdTdxKDZcLakD3SSYMEFa33GLMnM+PC+JTrujUoRhgwHgoxReOJkIKeDxzLoQGdN98dgmlrESIi1nK2VL64TGD0eIx73DhcVNikXwPLGhK+s6k8sbfobThv8T0YbaNV0MOZNiPv4yi4U7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHq/Q+AB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD639C4CEF1;
	Fri,  5 Sep 2025 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757058812;
	bh=tTfuVxL0tJfbFNZIAPWlOg3hJrctEWrR38o7eJHMoW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHq/Q+ABhcD5UQfn7jq1ts55lGplUJdn2IoIYKmokP3etjrHQqMg/gHOgZvvkRm5G
	 /GywyuGH8gptUPW18QCJXZuBA0WWJBmkpADlBKdfFyPbnoZka/476VoOTxknW4s0+H
	 rO06xx1GdKGMkQsjspj3nXY0yfSZZVbHAeIaExJ4Xkt9tuTH72JF06kV5qxpW5qfOX
	 37tGPYiTVeT+zkd/1ZW9KZEbqrYufpaEaobaasUcZfcZfZtgYw6J7JB4+im3wduGiB
	 m26G6Iz/xQubB6cHV/wqd9yGFuKsN+Yr8PbXOHEhQe1EU2QSBXNvDGcG4RVq5uVNX7
	 fBPtROte2MkQw==
Date: Fri, 5 Sep 2025 09:53:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: weishangjuan@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, yong.liang.choong@linux.intel.com, 
	vladimir.oltean@nxp.com, rmk+kernel@armlinux.org.uk, faizal.abdul.rahim@linux.intel.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, inochiama@gmail.com, jan.petrous@oss.nxp.com, jszhang@kernel.org, 
	p.zabel@pengutronix.de, boon.khai.ng@altera.com, 0x1207@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, emil.renner.berthing@canonical.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v5 1/2] dt-bindings: ethernet: eswin: Document for
 EIC7700 SoC
Message-ID: <20250905-hissing-papaya-badger-1b2ddf@kuoka>
References: <20250904085913.2494-1-weishangjuan@eswincomputing.com>
 <20250904090055.2546-1-weishangjuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904090055.2546-1-weishangjuan@eswincomputing.com>

On Thu, Sep 04, 2025 at 05:00:55PM +0800, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add ESWIN EIC7700 Ethernet controller, supporting clock
> configuration, delay adjustment and speed adaptive functions.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


