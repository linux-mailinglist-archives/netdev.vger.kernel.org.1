Return-Path: <netdev+bounces-152143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DE9F2DD4
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D9C1882F54
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D68202C2D;
	Mon, 16 Dec 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNiTDxR6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DD2010EF;
	Mon, 16 Dec 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343693; cv=none; b=M4Lo6+ObM9KUCrYAZDmXlAHjpDe4r5DyiuP+qDPJhRvtRm6H7Cd9RK8rXZZZHyMt2gPaFxGswcS3T1lDiCvXmFSTEi79OmsR55XmlYVzOD0rA3c+SwEYziISwO+cOosHkh0WUZP/C6VsEf/wZmAuHCkMcCsJBJfp/cbGWfSB8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343693; c=relaxed/simple;
	bh=X5Z+IXmO0qKaN/lunFl6z0UWeW3fLnADEWChSD7a5wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjZzU32jvSjEUMEXUDHWJCqPstcnUyBlZGzS8ZTi+iWaECipfREJ8ohuc3eW2unPcVXyemvS4kaje6fYxoxi5YVk9VUkAQ+iKYMYS8ilQAjIQzQh6S3XpfCyXH4aikL5LucK0cRV7xnXFvRQsWU9qqcO4NLvUW1EHCu7cfpiexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNiTDxR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94335C4CED0;
	Mon, 16 Dec 2024 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734343692;
	bh=X5Z+IXmO0qKaN/lunFl6z0UWeW3fLnADEWChSD7a5wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iNiTDxR6pFToe67puHvWwXRuGXo6Vf/FNXHe43S5vgKXZ/DuXKfmW2sv525g4yOZq
	 LLRjgiLR7sHaXm/g06Qi5Vi0qFMoR2pWcpfbHdL6+YiTGYcpYG8mMg4AAxA7bEvzDO
	 QGNjCH0kO37LvGR2GDdoU06VDxhsviR0sQcDQ77r0p3Pho0+5Le+mXaaVeAcAqpInG
	 4ZM6f2c2yqm7A4Cdr79ME74Rd/yhdAGXpMISuP+B9Ud3MvdJSl9Me9aSdUj9ngpqsB
	 eERMX9qpgXdK6uK7liQ8yfHU4XKYwK402cCkL/B6m20sYKK+u/asPgKlbK30f/Jnwg
	 7Z7b43UY8/V3w==
Date: Mon, 16 Dec 2024 11:08:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: sophgo: add clock controller for
 SG2044
Message-ID: <ld5mr252gnj5qd7qksf3lbd2iwldm3vdiqhu6ji7ipnhc342fa@phqq3xzgsn22>
References: <20241209082132.752775-1-inochiama@gmail.com>
 <20241209082132.752775-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209082132.752775-2-inochiama@gmail.com>

On Mon, Dec 09, 2024 at 04:21:30PM +0800, Inochi Amaoto wrote:
> The clock controller on the SG2044 provides common clock function
> for all IPs on the SoC. This device requires PLL clock to function
> normally.
> 
> Add definition for the clock controller of the SG2044 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/clock/sophgo,sg2044-clk.yaml     |  40 +++++
>  include/dt-bindings/clock/sophgo,sg2044-clk.h | 170 ++++++++++++++++++
>  2 files changed, 210 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


