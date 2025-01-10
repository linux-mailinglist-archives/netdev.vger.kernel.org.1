Return-Path: <netdev+bounces-157209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B34EA096A8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571A0188E5F3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5E212D8D;
	Fri, 10 Jan 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni5EALDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A07212D7F;
	Fri, 10 Jan 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524978; cv=none; b=PUngJQBEDuPfCuxvznQ3Y8EWxNmULmXWm0D40u9AOt/WfTr8m+teRLnfvsB9LF5e5L7+bqM7M0El3iM+7pesWLFqEpf8Ae6EgRuGtrILrwzlx7JzeKtrGCpgKIIRMCcU1sgOcxsZlNU/OUFsNJiHSnOKf/vNVOSTc/CyqSwlRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524978; c=relaxed/simple;
	bh=5diCFIWZuIJV4OjMCTWDxa0Zly+MOIMNEFHwJP7l1Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pq7T9jszJ1DsPHmWkyU539lWmXnj6sfVSrIAmmiBFnbOReXoM0FYqzQG3ORG6KCB7GRw5bbkd3sJ6KsU3122Ac+xpWE3af+rWNp2TeW6H9ogmeNybyavZ4LZ/1QiDYSuJdrC+4bJffK8xYP2jnPKYDJreX0NBtChmo0wqhRisyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni5EALDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CD1C4CEE1;
	Fri, 10 Jan 2025 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524978;
	bh=5diCFIWZuIJV4OjMCTWDxa0Zly+MOIMNEFHwJP7l1Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ni5EALDsWJZer0hLZHbaLS+k6dsytqsVi5PzwKotztyPzlieVlJX0W4MSNwPuJjaY
	 gqE0uYsSBccFOY1YUJXoe6I/pAGCFtHWbUwP/sOvjjkE/TEee86FlejI32+Ql0hVvy
	 6ecrvKY/zIO99leBuMepgyseEnJEAzOi3wiGG2MZPihYHNNfnZbOkPZXqPyEJwMZBf
	 Z0h2518+suWkTNpqYocRGSwgPGjp3w06qGmJPi6m3OXqvd/hrebnb+8C2ZajQgeIQ0
	 toIYd7K8WJoozZcs+9CzqOG1FnT3ydtowvi9edIUvgI/E6I4OOhM3MaQEAE8R+hXUu
	 aubW6LpC00vZg==
Date: Fri, 10 Jan 2025 10:02:56 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, conor+dt@kernel.org, devicetree@vger.kernel.org,
	andrew@codeconstruct.com.au, kuba@kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	andrew+netdev@lunn.ch, eajames@linux.ibm.com, minyard@acm.org,
	krzk+dt@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, edumazet@google.com,
	ratbert@faraday-tech.com
Subject: Re: [PATCH v3 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
Message-ID: <173652497637.2952052.6627595246829829775.robh@kernel.org>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108163640.1374680-2-ninad@linux.ibm.com>


On Wed, 08 Jan 2025 10:36:29 -0600, Ninad Palsule wrote:
> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
> document them.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


