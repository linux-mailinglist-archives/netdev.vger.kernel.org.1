Return-Path: <netdev+bounces-17658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2740175291B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DB3281EAD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A23717AB5;
	Thu, 13 Jul 2023 16:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B7101C1
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8F7C433C8;
	Thu, 13 Jul 2023 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689267078;
	bh=W/DBBtggNPxcx48u53LFNXfUII6LqEjS3gR/CAjXJoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EGb2yZNBaWH+ToInoE+zVz4NcSNnvQ2sehjIbmSHQAZUY3d9Sc0DT5eWml7jxFe2r
	 /fFVd5O1P/0LSHFMAiOqlNFvgnLhjrRfCzVvs9kwIZQu7y0WG67m0aVQVYbZhSmHk5
	 91K/zFbHLPshK9KvgGVvRHuX6k817Qj0G+iF6K4yRkYgyd3qFYYFc0iBXiCqzvcDbD
	 gazRIW3SWfP54kzPnnW4Le2RAKt8kgcc3rFG5NJQUvUh3oRrl+lHAcVGeAYnd9TUgX
	 4Qr/Q5hOpCAYqrh5JlSA9iHJyAjbDmeMUAK5RIm7CvYlMH2kl+SCgYYDtD6cQfyNoz
	 jR9ec/aQYg7ew==
Date: Thu, 13 Jul 2023 09:51:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Dinh Nguyen
 <dinguyen@kernel.org>, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, joabreu@synopsys.com, robh+dt@kernel.org,
 krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] net: dwmac_socfpga: use the standard "ahb" reset
Message-ID: <20230713095116.15760660@kernel.org>
In-Reply-To: <1061620f76bfe8158e7b8159672e7bb0c8dc75f2.camel@redhat.com>
References: <20230710211313.567761-1-dinguyen@kernel.org>
	<20230710211313.567761-2-dinguyen@kernel.org>
	<20230712170840.3d66da6a@kernel.org>
	<c8ffee03-8a6b-1612-37ee-e5ec69853ab7@kernel.org>
	<1061620f76bfe8158e7b8159672e7bb0c8dc75f2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jul 2023 14:39:57 +0200 Paolo Abeni wrote:
> > However for ABI breaks with scope limited to only one given platform, it
> > is the platform's maintainer choice to allow or not allow ABI breaks.
> > What we, Devicetree maintainers expect, is to mention and provide
> > rationale for the ABI break in the commit msg.  
> 
> @Dinh: you should at least update the commit message to provide such
> rationale, or possibly even better, drop this 2nd patch on next
> submission.

Or support both bindings, because the reset looks optional. So maybe 
instead of deleting the use of "stmmaceth-ocp", only go down that path
if stpriv->plat->stmmac_ahb_rst is NULL?

