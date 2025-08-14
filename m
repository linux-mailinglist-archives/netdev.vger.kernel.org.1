Return-Path: <netdev+bounces-213625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B48B25EC8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50187B5BB2
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0A2E92BE;
	Thu, 14 Aug 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY0w+pPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798D2E92A6;
	Thu, 14 Aug 2025 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160060; cv=none; b=t7ZkiWCCFnnw8Cqp2FGTy4rlBsGGOo1K3it/XcS/zEZp/gFWoFUVnGHupQd2E20YPa6UqyhbuJIJ3QEVT87NXiTgkOhmbleyy7KY4jAuS2EC1RSSAYHWGe5Q/DtM/0/XzvLE5hVdXWdZKZ2Kjo7YUFP5+VEMeHzRL4rAKLHpJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160060; c=relaxed/simple;
	bh=eBNqxL8xbh9FbFpZHtEdueQLB4k/JgbhTZ6T5smPqmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2xxft2nZYQFGKvOefazyJIqgJ3hiHt1xrDAev/X9WeKdKsLlVqE3330yUZH/Iav21NDKdh0z6FLwnvKC0LEJr7xyrbzksmguiuqig82LgC/7fc6nPFirbFYAuoO3QoGU0/YX6FaJNpQsfyAr96hhyZKohp8AHtZSBki+WLf3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY0w+pPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A383C4CEEF;
	Thu, 14 Aug 2025 08:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160059;
	bh=eBNqxL8xbh9FbFpZHtEdueQLB4k/JgbhTZ6T5smPqmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JY0w+pPJyBMijIG29BFD7uVwbZG1a5GqJ6r/mdil8fW9VAnKwk8z8xzZCeIAk84nC
	 Enhn1cq0Xp8rL1AWKLfXEaUp5gB4oHlIGnd3dfVp8CmJn9JyJYRlVCNa/wVEPz7nx9
	 3kdKTzJe6WcwXwUtbKA5CD74rYNXappJQq2vWbL56uQvf+W5xTLzlpO1o/Axm6o3v/
	 UHf6LV4s0wpk9TN4oY5o2PUn/bL9X7u7KbRyIQ7xUwZlK7V9GDb+MNUHpEelQux4Hz
	 C/64O2E6+uxcv3VSNixFxdHcQPIwItqbE7iyHUHGhX3SZPDkZfnDmzRHcWyTjz3llC
	 hx5ujnjYh5NiQ==
Date: Thu, 14 Aug 2025 10:27:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	richardcochran@gmail.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, 
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev, Frank.Li@nxp.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v3 net-next 02/15] dt-bindings: net: add ptp-timer
 property
Message-ID: <20250814-icy-intelligent-sambar-e504ec@kuoka>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-3-wei.fang@nxp.com>

On Tue, Aug 12, 2025 at 05:46:21PM +0800, Wei Fang wrote:
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> ---
> v3 changes:
> New patch, add a generic property instead of adding a property to
> fsl,enetc.yaml
> ---
>  .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)

In the same patch please remove redundancies: fsl,fman-dtsec.yaml and
maybe more. That's always one logical change. Otherwise you introduce
redundant or duplicated code.

Best regards,
Krzysztof


