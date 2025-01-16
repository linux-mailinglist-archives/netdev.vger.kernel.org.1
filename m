Return-Path: <netdev+bounces-158844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2F7A13810
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866741675A9
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B81DDC28;
	Thu, 16 Jan 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCw1Hb3J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB24F19539F;
	Thu, 16 Jan 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023903; cv=none; b=X1oWcNTUo3/waOl426lU3aEUEtwMTR+Ya/YBFxeKD+cOmIcphUnP5cVk+R7y8aXu+8Pf66e15XoEoYhzCXBnzOW1Ji/1vITdUPuw7g3Q0ONjph7uLiDOhxgAm4FSsGmOyWedzcTqu7MXF8RLQ73WuBYOzMkHT1uTH1Y9s1Cj3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023903; c=relaxed/simple;
	bh=FxvjYb2DWjhqzHI2LNTmYl5TuYZ4ikMl0bpGCml6Q1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHKCZeYDDSnZnKUJ47PugWKWY2wDNGyro1x76uIrCC9Pq8cc8nc18WfNtm+7VL8F4TWg+UXlR+TdNQbk7A60v4nFFuU4Leq2FEqsYt3mxIr/K6MUMD5DhZMjHxNV9iFGznuXcGX0h/f8NechXW+mE4KIhjSPLfDJrykMtyS7Dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCw1Hb3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1225C4CED6;
	Thu, 16 Jan 2025 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737023903;
	bh=FxvjYb2DWjhqzHI2LNTmYl5TuYZ4ikMl0bpGCml6Q1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCw1Hb3JaeryBSelmXm/W7aZWkrxne1V6qJTMbT5wzUB0FLJb1HDVSxQs7L3Adk/J
	 h1jIgU3u8NtUtpMZzt59EKG6jWvD0UFM2aGmmMBywcxN0mvUC+SXnoaH6zwC9Y8ixV
	 0N4sgYOyBEb+mBtiV6qFripiT9i0WVcjWmKyFdexG6GtbzLRzdX7pr3N2gw3m2GYKm
	 KUjby//nop8j6RYVyZYzhQPJKQF5s/6tiY5a33mt3i5ohcQ1sJcIIXpLXXXJ7TjgDw
	 0tf+1KC5DkK6Yirs9t9kyDLWGwGJtBzwIga4CdNopnGWlom31Q/lmyG4CVS+r875GW
	 56144sKuxFylA==
Date: Thu, 16 Jan 2025 11:38:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>, minyard@acm.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, openipmi-developer@lists.sourceforge.net, 
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	devicetree@vger.kernel.org, eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
Message-ID: <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
 <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>

On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
> > > > +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> > > Choose one - suffix or prefix. More popular is suffix.
> > I was about to say that, but this matches what gpio-hog.yaml defines.
> > Why we did both, I don't remember. We could probably eliminate
> > 'hog-[0-9]+' as that doesn't appear to be used much.
> > 
> > Long term, I want to make all gpio controllers reference a gpio
> > controller schema and put the hog stuff there. Then we have the node
> > names defined in 1 place.
> 
> Which one of the following are you suggesting?
> 
> "^(.+-hog(-[0-9]+)?)$"

This. The second part of pattern.

I'll send a patch for dtschema to drop the prefix version.

Best regards,
Krzysztof


