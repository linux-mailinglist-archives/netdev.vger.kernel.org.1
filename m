Return-Path: <netdev+bounces-216065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E263B31DA4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 17:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11231897B6B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79281DC198;
	Fri, 22 Aug 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rbmIm9Di"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200991D63E8;
	Fri, 22 Aug 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875186; cv=none; b=abs2U68nyFbzT2KNIhZIkDfJlP1TYvLk21/qTQw7uPfRugN14J5A/QdtLj3TX4XVhMyyss4zrhhUOoVUt4H7zaa9RUqALMCuwJiXnZOhuWmus15A24Rdsj7IZHea4Lsq3brbZguBPIIhQkKl4sbMfORH2Pqr20NsWMEY5UndiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875186; c=relaxed/simple;
	bh=nFx4SitBgKvpBoMIHIeC2jnMHcJO2iqNTQ+yJXq99tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/LWQS+z2NsVc00bHsLEi5NBsV1xmIuCJ5jrCAcBz0dgZ7eOkli7SxZ1OmcEnSUy7scM8uiQHxowBgqW1X1uWWTq141MbrUSN+Qo83CFzcUVsT+Nza2ey6zOJxiKbnIXzfuTV30uDpPXqEX6N0hDN0PRCyS5LsqeBmHivwuqcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rbmIm9Di; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eZ+hmLIUg/dB26LXq+Xb6ycLseoaXyIsUKUrBLdYLQo=; b=rbmIm9Diily/hJ/p4qXomerB17
	FYkEzE7RKjqqOyaUqrzy52oHBmvfm8GE9hI9wTM1+1bXAyR9i8miJcCBlPQQ5KnJbZPmQq1SYRUF1
	45F7ydUPR8hgaCZqrH2MeGTKcHcBX6N9ezT8en0WhYGrAQu3ZrhoBHg/Tr6jdbSkj9F0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upTLR-005akn-BZ; Fri, 22 Aug 2025 17:06:21 +0200
Date: Fri, 22 Aug 2025 17:06:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next 0/2] Add MxL Ethernet driver & devicetree binding
Message-ID: <d369e95f-7660-4771-8494-7cd83aa01906@lunn.ch>
References: <20250822090809.1464232-1-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822090809.1464232-1-jchng@maxlinear.com>

On Fri, Aug 22, 2025 at 05:08:07PM +0800, Jack Ping CHNG wrote:
> Hello netdev maintainers,
> 
> This patch series adds support for the MaxLinear LGM SoC's Ethernet
> controller, including:
> 
> Patch 1: Adds build infrastructure and the main driver for the MaxLinear LGM
> SoC Ethernet controller.
> Patch 2: Introduces the devicetree binding documentation for the MaxLinear LGM
> Network Processor.
> 
> The driver supports multi-port operation and is integrated with standard Linux
> network device driver framework. The devicetree binding documents the required
> properties for the hardware description.
> 
> Please review and let me know if any changes are required.

"if any changes are required"

ROFL. Have you ever seen a new network driver where v1 got accepted?

Anyway, thanks for starting small. But there is still a way to go
before this will be accepted.

FYI: DT patches go first in the series.

I suggest you subscribe to the netdev list, and spend 15-30 minutes a
day reading patches and reviews. You can learn a lot that way, and
avoid repeating mistakes others have made.

    Andrew

---
pw-bot: cr

