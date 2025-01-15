Return-Path: <netdev+bounces-158419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129E4A11C56
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CD07A0350
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC701E7C07;
	Wed, 15 Jan 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcxC6SzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F390723F276;
	Wed, 15 Jan 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930754; cv=none; b=Nv6iK/xdb8403DrQm/5x/b+IFLPjbgia8SLjrulZ+82UmAT9RuGaeXonMAIyOKBjNuk7NLS+XeD5GWBMiQqw5bS0fqUIrXsJXKiG78VyiGifsPETDSViOM4fIQpWtUHoHBA2IfRL+oiy/yOMVHZDXdfopeA1wWpqvTCn9WHQ0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930754; c=relaxed/simple;
	bh=BO+3m4FMfOEG/15U7sR7NT9LJguDOTS3576NIxYCBC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOTksKtI/JAdVoTZWs21K7UQK4YJsAlPn0/nNoDbDJevCmDLLns2YNJcdsbyzVgt6UhIO4wuFltaoT0tYSVRPvsdj5tHIFgv4kFix4j4er4E8eLTmNVizKeAj7/b+PBRzZnl2TZkKb8Aw8d+Ns6CBSPOs1DO2euTmvCUHVBPLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcxC6SzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FFC4CEDF;
	Wed, 15 Jan 2025 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736930753;
	bh=BO+3m4FMfOEG/15U7sR7NT9LJguDOTS3576NIxYCBC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcxC6SzVOVwXLkfQSuzJsVT1MbWuFE4DDr9Lmivl1awzuPTfYhtERml6+ZC1PhY3i
	 E05cAcYI5oEg/VnRWQwfJZhslpuwCsVVI3K3k/uH9xtXZ7yCJf/5xe5/SSeF+o2VHL
	 LGu3WkcCOtQHu6Ri0NKZ3oPHPplPkBr/4CXAebb+bc8YuF3ncvIlHJEwrk9T15/Rjc
	 buCSPyl8nZjxCkJZcNuOjphLNrOctF2hhaPnSO5T0AS34Ii2KHquycjySlvOPxZYLf
	 vDksmIIexXrJtsr0S+gzVQhn15ZIX7Y4OYAJ+S989RAHX80XhDs8Y76x0V8FycvmmZ
	 lK2QqzNmRTNXA==
Date: Wed, 15 Jan 2025 09:45:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, openipmi-developer@lists.sourceforge.net, 
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114220147.757075-4-ninad@linux.ibm.com>

On Tue, Jan 14, 2025 at 04:01:37PM -0600, Ninad Palsule wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> index b9afd07a9d24..b9bc4fe4d5a6 100644
> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -46,6 +46,12 @@ properties:
>      minimum: 12
>      maximum: 232
>  
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":

Choose one - suffix or prefix. More popular is suffix.

Best regards,
Krzysztof


