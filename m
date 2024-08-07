Return-Path: <netdev+bounces-116467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 011D094A882
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03B81F23CCD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2FE1E7A41;
	Wed,  7 Aug 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ERHApvv2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C81E4841;
	Wed,  7 Aug 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037105; cv=none; b=CkAZEYvBKGNmlBLUinr9sqPbQOGnYMdc9BmxaYkq24fOZxRSfhOxtOeX5O52vgXlmJW5T2EO1BDFausnfBtiZVtR5QC+wbxbzIWZFWWBlB4pGKdCFDj1oU4TTc4qZYbOUBttDihrxGpTDsdpO/NyQhM6skd9fUctNkl3JMJ3Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037105; c=relaxed/simple;
	bh=5sTsQmQzYhRTAbmChHE+o+gvUzG3WVCy6zCqtU/RKF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXfhX/9e5gmU5uIlfRM/A1tFT9r1KYcF7lvC7I4X4yGGVS06C2CcO9164mFW1F5MeB+xQjZ6XVPhdPaq8oAkPbvtrgx4tfih/trTJ/HSetZ84PzNDBwwT9DMwFg0atSv8u/KewuCClLXvoVcNmcGGE+TM5OodwHqu33jZlIjw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ERHApvv2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C8IaSNiVMhb8QCqL5FFLaHsUZ/2W+UHTURc1tvPuCUA=; b=ERHApvv2o7BX21z+NnAAfGluDF
	1Y7ibZ7nly4+LVi5A1TylpViB02QyPsB4jBRyE6Y2ApdlgN/zcZf2b6LIF8XpnIvjPaaP/Dynx8Md
	rWlEnNwvmMHcy+B+ckDvmqfTnZLCjFwB64NX8R6OYyUdrME+GSCp0n/eHee16hm1lZrA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbgeq-004Ccc-7S; Wed, 07 Aug 2024 15:24:52 +0200
Date: Wed, 7 Aug 2024 15:24:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: dp83tg720: Add cable testing
 support
Message-ID: <ff096c1c-00bf-4e55-9400-fb869749b07f@lunn.ch>
References: <20240807093251.3308737-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807093251.3308737-1-o.rempel@pengutronix.de>

On Wed, Aug 07, 2024 at 11:32:51AM +0200, Oleksij Rempel wrote:
> Introduce cable testing support for the DP83TG720 PHY. This implementation
> is based on the "DP83TG720S-Q1: Configuring for Open Alliance Specification
> Compliance (Rev. B)" application note.

Does the OA specification describe all these registers? Should we
expect other devices to be identical?

> +/**
> + * dp83tg720_get_fault_type - Convert TDR fault type to ethtool result code.
> + * @fault_type: Fault type value from the PHY.
> + *
> + * Returns: Corresponding ethtool result code.
> + */
> +static int dp83tg720_get_fault_type(int fault_type)
> +{
> +	switch (fault_type) {
> +	case DP83TG720S_TDR_FAULT_TYPE_SHORT:
> +		return ETHTOOL_A_CABLE_RESULT_CODE_SAME_SHORT;
> +	case DP83TG720S_TDR_FAULT_TYPE_OPEN:
> +		return ETHTOOL_A_CABLE_RESULT_CODE_OPEN;
> +	case DP83TG720S_TDR_FAULT_TYPE_NOISE:
> +		return ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC;

You could add a new type for this. I think some implementations will
also re-try a few times to see if a quiet period can be found.

	Andrew

