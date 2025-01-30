Return-Path: <netdev+bounces-161677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB8A232B7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1116B163C3A
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE31EE00E;
	Thu, 30 Jan 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5My1YfF4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B41E9B39
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257645; cv=none; b=jAoqxDh9phMFBWhZ68oeUfFfBaifApPPPEMoc1vFzuKmB3YF8v/kH9dPLf9JM92xnQCchbcrZ5iekSkDIu4N1ihk8R626O7KhgNSRGg+4CUD7b2JCQu4/57z0sAJrKvXaanVUKpBnFYaj6KFXKoU/PRniDUaeMVbHtEBIbQRjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257645; c=relaxed/simple;
	bh=6jUG/FPXcaE/HiJxY4akdZdHmQ768F46jYAVzMYR8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP7SQFahDljbOe5dVEA2BdOkvnAwDEloiNYYNTceZuVNYu8aTDid69o7OGXnIPHRUv+UHz511V1RCaOtguvTuAGuEVHnSVC0JPzKE+AvP5YtN7ZMf6GQF4RSjkgbJdgIeg93+KSmHBhth5Z9Vw8vwKct1MBFIMIIp5Mhs4pmwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5My1YfF4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cZiTUwb2aGSwVIJ4hFCKe5rxCV0Gc3euo9PRAd+A4SQ=; b=5My1YfF4mWgpjOG7k5kBBSQlEx
	uD7VY1PEmjtgC+zQB1OjzwvO9vkoPYvPRp9JQnpnj4H4rs+RBj94YC1DkvIIR1w66gQZI9fDswH4p
	Jt9+K9Y3Z8GCFt60u3g2z1KPMsgfkpMMxHaBhx5EToiYbgimnBQyaqvq5GEB9XRfooNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdYDV-009Suo-Ay; Thu, 30 Jan 2025 18:20:37 +0100
Date: Thu, 30 Jan 2025 18:20:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"matt@traverse.com.au" <matt@traverse.com.au>,
	"daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
Subject: Re: [PATCH ethtool-next 08/14] cmis: Enable JSON output support in
 CMIS modules
Message-ID: <05a6045b-b4d6-4739-8352-dabd1ad386c6@lunn.ch>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-9-danieller@nvidia.com>
 <20250127121258.63f79e53@kernel.org>
 <DM6PR12MB45169E557CE078AB5C7CB116D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128140923.144412cf@kernel.org>
 <DM6PR12MB4516FF124D760E1D3A826161D8EE2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250129171728.1ad90a87@kernel.org>
 <DM6PR12MB451613256BB4FB8227F3D971D8E92@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250130082435.0a3a7922@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130082435.0a3a7922@kernel.org>

On Thu, Jan 30, 2025 at 08:24:35AM -0800, Jakub Kicinski wrote:
> On Thu, 30 Jan 2025 12:38:56 +0000 Danielle Ratson wrote:
> > > > Yes, the unit is implied by the key is hardcoded. Same as for the
> > > > regular output, it should give the costumer idea about the scale.
> > > > There are also temperature fields that could be either F or C degrees.
> > > > So overall , the units fields should align all the fields that implies
> > > > some sort of scale.  
> > > 
> > > Some sort of a schema would be a better place to document the unit of the
> > > fields, IMO.  
> > 
> > So should the units fields be removed entirely?  And only be
> > documented in the json schema file?
> 
> Yes, more than happy to hear from others but a schema file would
> be my first choice. Short of that as long as the unit is the same
> as in the plain text output there should also not be any ambiguity.

Sorry, not been monitoring this patchset.

If units are an issue, you could just use the standard units hwmon
uses. milli centigrade, milli amps, milli volts, micro watts, micro
joule, etc. I don't think hwmon has needed to handle distances, but
milli meter seems like the obvious choice given this pattern, although
160km in millimeters is a rather big number.

      Andrew

