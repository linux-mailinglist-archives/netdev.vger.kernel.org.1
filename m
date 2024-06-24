Return-Path: <netdev+bounces-106244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BED2915730
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFC21F228BE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40091A00FE;
	Mon, 24 Jun 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tKEtzaNQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F51A00E2;
	Mon, 24 Jun 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257527; cv=none; b=SzBZudYxfI58eZ3v70AxIscC7zLMzK99XEifQ0163YKi6XFX7nO4iyZcHP/jmHOO3pwNvUue2zF/26Q/0dX0DjNK3FCk7wjpDuj7U7819cUtRekQKtYL/E0Q+UB3zNAZ1ezHgcqWP3Oe6CI9tH40zJN1TbX7670N49ZA0wVj+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257527; c=relaxed/simple;
	bh=hQCiqJqyxAPMCoZUq7GJ8SLJIJrJydrlj58IGzH4M44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2fSrK38aCdwIDjyvyfn8YGMU7K3eq483iO+MP/vYVthGkQs9Att3RabrbQbeqhQDgdhEsA0Ys9dEjxWp/Y8V5akTWpPsJpBcARZyWaO/ccJnpLf8I0LXQXPdvH9RtU2Aa6Q0BZMFyGq7yLRiGnAHzVfyC7nO2XTmplrx8eSUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tKEtzaNQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NYNKCmMuGnIqNRPKZ//fm4hSeGjYx5/U1LJRTZRk87k=; b=tKEtzaNQ2MetrNPIfPIEOtrTKr
	30W+nUqJC8JNmPj+hnU01RpwXTHDejoANYQk84uDo0yUDxs+WuVOHAqMwx639QPvsHz278hs/5vvJ
	BeFGfxzBQfsX93fheSSif0+RuzbcPTLe+ZBYOAPs3ozoifC9dck8Jh/HF6G9au2YMXyc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLpPt-000sds-RS; Mon, 24 Jun 2024 21:31:53 +0200
Date: Mon, 24 Jun 2024 21:31:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, sdf@google.com, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, vladimir.oltean@nxp.com,
	przemyslaw.kitszel@intel.com, ahmed.zaki@intel.com,
	richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 6/9] net: sfp: Add more extended compliance
 codes
Message-ID: <cf3c0c90-45d8-44c9-b730-c6e364fb4a84@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-7-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624175201.130522-7-danieller@nvidia.com>

On Mon, Jun 24, 2024 at 08:51:56PM +0300, Danielle Ratson wrote:
> SFF-8024 is used to define various constants re-used in several SFF
> SFP-related specifications.
> 
> Add SFF-8024 extended compliance code definitions for CMIS compliant
> modules and use them in the next patch to determine the firmware flashing
> work.
> 
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

