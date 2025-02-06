Return-Path: <netdev+bounces-163541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E131AA2AA83
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348C63A5728
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E21624F0;
	Thu,  6 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m+5AHm/m"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0E1EA7C6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850356; cv=none; b=T97kDfLlpBprpbM0jZS0I72CbWsIO74qQXaNOJUNf3nQTkRjUQSbMoV+CNfRfH/HilR6ND+ej1R53RjTP+NIDtzho5HIFb0ruWunEQ1ITbdcApWaI6kpW5Kk0f/t6pPXeGTguexT18kR8t8dY7z+hIwJib9Q+C0KeoSU42esZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850356; c=relaxed/simple;
	bh=sjhyLgdubi8BUQI73IOnQ1Ztl2nhsYGD5WhFYnihoAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEwnkLUxzpZIDHojl9VYrWAnDF3AtO8uXMFotoWU2aBRrOaK/3Vx4soi2bckzu0dOoUBuHN/cTajN44QTTLWMIbiqO8fBKjFRbyH5+PgYilTfw7yrh6tFTzev4IvYO36Zv7b+o/wYrXa8fQidz0RyjWIW8/oeF/TCiW8eDViGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m+5AHm/m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5DUXroibXducNlmqw++SAiBUumFVNVJQ+BGSQmCmOIg=; b=m+5AHm/mHfYaFyQTOOqbNxGNQV
	CDilIyW1hSbhMEXUKLsQMJ7ZzJPFHp3XJ5958HtfAlVJJcPSSg46zk3Olq81/L/QBSKEPzWRVPWhK
	PQZ+5o2kYa4S48NPqD1rF9fLjmWF48nIg12crz1SnGs2Zm04hJEMt8+kxbv3duzUSJhM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tg2PM-00BXIK-OZ; Thu, 06 Feb 2025 14:59:08 +0100
Date: Thu, 6 Feb 2025 14:59:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event
 reception
Message-ID: <0b81ee70-efe3-4a06-b115-1a56e007b9a7@lunn.ch>
References: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
 <0a921f6c-a63d-4255-ba0e-ea7f83b8b497@lunn.ch>
 <DS0PR11MB7785AA7575BBA0E6FD576B31F0F62@DS0PR11MB7785.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7785AA7575BBA0E6FD576B31F0F62@DS0PR11MB7785.namprd11.prod.outlook.com>

On Thu, Feb 06, 2025 at 01:05:27PM +0000, Jagielski, Jedrzej wrote:
> From: Andrew Lunn <andrew@lunn.ch> 
> Sent: Tuesday, February 4, 2025 2:09 PM
> >On Tue, Feb 04, 2025 at 08:17:00AM +0100, Jedrzej Jagielski wrote:
> >> E610 NICs unlike the previous devices utilising ixgbe driver
> >> are notified in the case of overheatning by the FW ACI event.
> >> 
> >> In event of overheat when treshold is exceeded, FW suspends all
> >> traffic and sends overtemp event to the driver. Then driver
> >> logs appropriate message and closes the adapter instance.
> >> The card remains in that state until the platform is rebooted.
> >
> >There is also an HWMON temp[1-*]_emergency_alarm you can set. I
> >_think_ that should also cause a udev event, so user space knows the
> >print^h^h^h^h^hnetwork is on fire.
> >
> >	Andrew
> 
> I am not sure whether HWMON is applicable in that case.
> Driver receives an async notification from the FW that an overheating
> occurred, so has to handle it. In that case - by printing msg
> and making the interface disabled for the user.
> FW is responsible for monitoring temperature itself.
> There's even no possibility to read temperature by the driver

https://elixir.bootlin.com/linux/v6.13.1/source/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c#L27

ixgbe_hwmon_show_temp() is some other temperature sensor? Which you do
have HWMON support for?

Or is the E610 not really an ixgbe, it has a different architecture,
more stuff pushed into firmware, less visibility from the kernel, no
temperature monitoring, just a NIC on fire indication?

	Andrew

