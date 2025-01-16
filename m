Return-Path: <netdev+bounces-158922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64377A13CB6
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73283ABA98
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9322D4D1;
	Thu, 16 Jan 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7gWuPjY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021022D4C6;
	Thu, 16 Jan 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038901; cv=none; b=DFVrsqG3HHjkc17mPYMq7dMkyPoVz8TxAEFBcMXioF/yGETtsIW5brRX7SBaZB4tEDCm7j/N7sUpN/uDAcCwxIq/XJ6bUD7MzeXY+hiMjWEE9DNULJPXfZ6corv1dSJVJbMYR49FsewUiIBt6b+0Yth+JAo+YxL7SY0l63PaG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038901; c=relaxed/simple;
	bh=kS1K6s9fmeCJ57o2iulNzC774Qqxf86e2tf+WDO/RDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYYQlXF1gqhpqsObLm+stIKlO5e+f3P5l5H20I9Dxo7hbpsXgGxJWo44NrqsM/hOMm7KSSXV/mYpummju8rQvDb9bACk1EwDlZ3pjS0g+B4DJheT9Z/HdVzZwEw4cQdECR37+7BmLhKw2zEKTBRAerSnAHuf4A/q+nC36BB9OPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7gWuPjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C87C4AF09;
	Thu, 16 Jan 2025 14:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737038900;
	bh=kS1K6s9fmeCJ57o2iulNzC774Qqxf86e2tf+WDO/RDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7gWuPjYUDO+/EWctbZWV+AMVHKrCywMDcLItASnzieeMyQY3J5pRyoxlE3HB4JBv
	 yqOxikmYUw658NzU0t5IdPAVxOdMjUzyPTMkyR3BEh/NgyrIdQwT7QElDKGXkaVQ/l
	 1sk0ws2PzulzxViYIwEPQFGG5u+wRF6RaHJqK97MZ1H5su57RFSmKNXNCqtDbTj77F
	 3ccvynueLKPCLuhWyriHbX490mHK9SbDYVNl8ZzuU2EODvhujjW1PPy7e1wAiQREP3
	 p/VgwPuvt2vzwj15L8xSTjKWg3GhMJ5UPRqUHJ3OHo50SMi5uI7IaoEmpkvuBA9yLd
	 fctRPjnDoInQQ==
Date: Thu, 16 Jan 2025 08:48:19 -0600
From: Rob Herring <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, minyard@acm.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <20250116144819.GA2270032-robh@kernel.org>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
 <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
 <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
 <10c06fec-b721-4a7f-b105-c3c4c8358a47@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c06fec-b721-4a7f-b105-c3c4c8358a47@linux.ibm.com>

On Thu, Jan 16, 2025 at 08:19:25AM -0600, Ninad Palsule wrote:
>    Hi  Krzysztof,
> 
>    On 1/16/25 04:38, Krzysztof Kozlowski wrote:
> 
> On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
> 
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> 
> Choose one - suffix or prefix. More popular is suffix.
> 
> I was about to say that, but this matches what gpio-hog.yaml defines.
> Why we did both, I don't remember. We could probably eliminate
> 'hog-[0-9]+' as that doesn't appear to be used much.
> 
> Long term, I want to make all gpio controllers reference a gpio
> controller schema and put the hog stuff there. Then we have the node
> names defined in 1 place.
> 
> Which one of the following are you suggesting?
> 
> "^(.+-hog(-[0-9]+)?)$"
> 
> This. The second part of pattern.
> 
> I'll send a patch for dtschema to drop the prefix version.
> 
>    Thanks. Also thanks for the other patch. It helped a lot.

Please fix your mail client to properly quote replies

Rob

