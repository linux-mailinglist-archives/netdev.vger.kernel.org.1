Return-Path: <netdev+bounces-162520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B206A272DB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A42166290
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A520FA8A;
	Tue,  4 Feb 2025 13:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MVlhPuFi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D320D51F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674563; cv=none; b=QgKUIqSoaVOUTutuGVBf4z7AZKQoVC6fjOQ5wfqvL5q2mpHSjk77ql84BrXJHgzF9ovhnqNB2ii2/o2ovnpN7P/lEQGOqFduvOssCbgc0VC4hhgOjsv1OAQK4U/jK2IfVZUuJEBOeFVR2jqbBXne0w9vKSoXHm7pEcR7jRfpUSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674563; c=relaxed/simple;
	bh=tOWpb7kzKt0OlkB96UTXZUlvs0CAQuYkByRg+ubfW8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh0i0LPebyFaQDI+w2VuYKr91SPl3zrpzSlzLtBRCBYquyKmsIfp/yqeg55v71/X98w2EtbBTwHAbUyWJIivkRwJ8y/ZnbUnj2R7Onm72Z+vZvoevX6eEb25Egfs8zPCSvyCMKT6NqQlhpco9SynY7kKoM2jpG9UPYcwx2Gv7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MVlhPuFi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Yy6poegxu45rnXHOUFtUu6Vu72DWeMa6JipGCBJcIok=; b=MVlhPuFia3zE9pkS3H4S+lNjYF
	ThPbu8xHOIeyeNCCSh6vMdDYXWfd1y0aQLii+1sWhl9Ld5MU3Lj1G945wNJjeyMqDgA/geE8F8rvf
	B67+IxArOk6sf4L5vW6845c6d9w416JLCezE0H1mizb7m1K5pUcVZgmJrPZZcossFuRU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tfIfu-00Ar61-Cf; Tue, 04 Feb 2025 14:09:10 +0100
Date: Tue, 4 Feb 2025 14:09:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, pmenzel@molgen.mpg.de,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ixgbe: add support for thermal sensor event
 reception
Message-ID: <0a921f6c-a63d-4255-ba0e-ea7f83b8b497@lunn.ch>
References: <20250204071700.8028-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204071700.8028-1-jedrzej.jagielski@intel.com>

On Tue, Feb 04, 2025 at 08:17:00AM +0100, Jedrzej Jagielski wrote:
> E610 NICs unlike the previous devices utilising ixgbe driver
> are notified in the case of overheatning by the FW ACI event.
> 
> In event of overheat when treshold is exceeded, FW suspends all
> traffic and sends overtemp event to the driver. Then driver
> logs appropriate message and closes the adapter instance.
> The card remains in that state until the platform is rebooted.

There is also an HWMON temp[1-*]_emergency_alarm you can set. I
_think_ that should also cause a udev event, so user space knows the
print^h^h^h^h^hnetwork is on fire.

	Andrew

