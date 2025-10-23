Return-Path: <netdev+bounces-232116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44EC0149C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1833AD499
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80F314D18;
	Thu, 23 Oct 2025 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="icTzxUHI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B6314D15
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225260; cv=none; b=BQTIrG4JOgBZTQZEwgxZPtNFAqO60paHZq/pawj+w/hmEvACXD/zavtrC0LjXYdv0lmvq6wd3hy1fRkYHmu7RZCgl4eRktiPjNTLwkwfzDWZj2dYt5BDibuu1a29KZDadsXjPyi5bVT9zYF1ei0e0Y8/4AqQsFzpQ4qq9y2GwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225260; c=relaxed/simple;
	bh=I2mLNPFCiPMUuwvpI3Rdlpb7t6tKwnfd+40w14ArJJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpdmUqP/dKhrAA7wDhX69W49G7yQEdWURnTinujLq7XEtf/9rz83VeubPNVFwi0LG8YjcsjUsyTLl6BNEe1lQh83ts8dOAIz/FxlqPtvy/JabmGTUuJtLazPxV+jRDFiWzcZwC6TMmqNVptsxJ7zQA1+7RerlqTayhdcM3QIv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=icTzxUHI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B7S8BZj4ngwtahm+9QRPLp0qDIx6Vp2hhAlvxpP/weE=; b=icTzxUHIMKuhrcaAKksJ7ty5+X
	lvKyyscQ9a/WUwIcgqoXINBpfPQ9nYeTnh59zAEPNHacwrSlivOeZtjEcAXDU1IMrk7sNZ5n0ymA/
	YZJsh3oqEqMaPEzW7gXa3w5sPu04Rp1LCTJ51jK3bH2yCWDkmD/503iRW6aMmlEvE12w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBv8x-00BsjR-3t; Thu, 23 Oct 2025 15:14:15 +0200
Date: Thu, 23 Oct 2025 15:14:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Eigner <johannes.eigner@a-eberle.de>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Message-ID: <af10599b-a698-4a60-a7d2-35a898b9a04a@lunn.ch>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
 <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
 <aPjxYbbiYAexF9nQ@PC-LX-JohEi>
 <82ab2f16-b471-4d60-850d-ee4b83712cdc@lunn.ch>
 <aPn9HkM-mjQHEo9v@PC-LX-JohEi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPn9HkM-mjQHEo9v@PC-LX-JohEi>

> > As to ABI breakage, we have to consider, did this never work, so it
> > does not matter if we change it?
> > 
> > 1) Does the first patch suggest it has always been impossible to get
> > this part of the module dumped in JSON format?
> 
> Yes for SFP modules it was always impossible to get this part. But for
> QSFP and CMIS modules it should have worked before.

So we are potentially causing regressions, if anybody has an
application using these types of modules, and a forgiving JSON parser.

But the JSON is clearly broken, so we have to do something. The commit
message is important here, because if somebody does have a regression,
they find the commit which makes the change, we want to convince them
the consequences were considered, and they should just accept it,
rather than ask for a revert.

But we also have more flexibility for SFPs, if they never worked, we
can rename properties which are specific to them without issues. But
again, this should be explained in the commit message.

> For SFP modules it never worked, but for QSFP and CMIS modules it should
> have worked before. So I will try to minimize the effect for QSFP and
> CMIS modules.

Agreed

> For the biggest possible backward compatibility, I would suggest:
> * Keep the function sff_show_thresholds_json() as it is, so threshold
>   values remain unchanged in the JSON output
> * Only rename the measured values if needed to avoid duplicated keys
>   * Keep name "rx_power" for all module types
>   * Keep name "laser_tx_bias_current" for QSFP and CMIS modules
>   * Rename "laser_bias_current" to "laser_tx_bias_current" for SFP
>     modules
>   * Keep name "transmit_avg_optical_power" for QSFP and CMIS modules
>   * Rename "laser_output_power" to "transmit_avg_optical_power" for SFP
>     modules
>   * Rename "module_temperature" to "module_temperature_measurement" for
>     all modules
>   * Rename "module_voltage" to "module_voltage_measurement" for all
>     modules
> 
> This results in only two keys renamed for QSFP and CMIS modules. As a
> side effect this also aligns the key names for the different module
> types.

This is good.

Thanks for the research you did into this, looking at difference JSON
libraries, etc.

	Andrew

