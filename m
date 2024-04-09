Return-Path: <netdev+bounces-86137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035E889DAC6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631531F24AA5
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2613281C;
	Tue,  9 Apr 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZyYEMOrG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201B131BB8
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669956; cv=none; b=oav2BVBL7X/7UqPyLSceurKW3+4dP9HXwD7r+T2d/cfnWCBYhMrolR+H5ry2ni/Kkl/iJ9km+aPdYaWbBCWWF0ohg4HZWpn9rw8PtzSqLLXfBbZZxTNT5bFMaHdS6BLUhskaDSB1nbNzSpQJRlnro8tKSqKHSyN3mOS/LOLUY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669956; c=relaxed/simple;
	bh=pggNsCuA2c3MpOl07TMLcMBLc52OofzgsaO8d6VC9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFEAt+cJaX199mO3GnPGhNe9xAa0fZM/QkCrVLs/yNEwN3FRs6dEtgKy4pL29q0v+JJ8ZFGnE/4WY1LQuBjbhnXz5ttW7DxrGTeUSMfzYSxItWzYSAftYH9Z+E8ZVvVsh81kWfR9sxbZIWXVzC4nwovxRFxmPMtqhJx1R+9g4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZyYEMOrG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T/r8BfXohVHFI2G7WWPeP1tiK6eBX+Y2sctROwXYGoY=; b=ZyYEMOrG0/R+2XPecvJOEkGO6e
	6hcO1kbUwIQX8H0eUIPjS5r69bF2sdEoXOLoM9cm53mb62vjkFAJFrOAvvNwRok/ixsfQHVgTxbts
	xPvnMPenm3v05CArVJMaijZK/yorXMIszUoas7NNGfhdj/SJcRR/SGvNLRiWfbcmI1x8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruBgs-00CZvJ-KB; Tue, 09 Apr 2024 15:39:10 +0200
Date: Tue, 9 Apr 2024 15:39:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <c6258afd-2631-4e5d-ab25-6b2b7e2f4df4@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
 <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>
 <61a89488-e79a-4175-8868-3de36af7f62d@lunn.ch>
 <206686dc-c39b-4b52-a35c-914b93fe3f36@intel.com>
 <e4224da7-0a09-41b7-b652-bf651cfea0d0@lunn.ch>
 <cf30ce2e-ab70-4bbe-82ab-d687c2ea2efc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf30ce2e-ab70-4bbe-82ab-d687c2ea2efc@intel.com>

> This is something my current design supports I think. Using
> ETHTOOL_A_MODULE_MAX_POWER_SET user can get what cage supports
> and change it.
 
> This could be done using ethtool_module_power_mode_policy I think.

All these 'I think' don't give me a warm fuzzy feeling this is a well
thought out and designed uAPI.

I assume you have ethtool patches for your new netlink attributes. So
show us the real usage. Start with an SFP in its default lower power
mode. Show us the commands to display the current status. Allocate it
more power, tell the module it can use more power, and then show us
the status after the change has been made.

Then lower the power to that cage and assign the power to a different
cage.

This is something you can later reuse in the 0/X patch describing the
big picture of what the patchset does, and it will guide others who
want to implement the same API in the Linux SFP driver, or other MAC
drivers.

	Andrew

