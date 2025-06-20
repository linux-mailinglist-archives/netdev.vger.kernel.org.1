Return-Path: <netdev+bounces-199836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0CAE1FF3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD941891E07
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556B12E612A;
	Fri, 20 Jun 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j20KO7j+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFB2E3387;
	Fri, 20 Jun 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750436106; cv=none; b=oAuwhQLLwtiZasMFVTEnvxhFQAXnDSLLQINp19Sxlinujc/gs04N6q0zk60P3aNp8G6RV4/5Rf2jVEicw+8W64tpqQu/6MDR67Dno63kIkSdWxqqgoE2NBee6DnClWIJZEgAYE7YFviCfkeCX6aBELW/IeiHQH0OW2S8FKLHzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750436106; c=relaxed/simple;
	bh=CJPn9bbmNcJ/RzelH8cowP+F52Wew3w01e0e4IXwTFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOqkPOQ/b5z8A3LkG0ql2jgjLu1pdhyOF/bAd01ykNwcYriEUEJNxI8bMINydEmlsDqQlBi9DfM2JxM+jdGie1a+NhohGS40DWckA/pKCkjGxBkYW4u2WwBM5TZSKRC6XLbW5/uFOSivo6itMIwB90ObP3V4y4dzHAODS9W2FNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j20KO7j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9D4C4CEE3;
	Fri, 20 Jun 2025 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750436104;
	bh=CJPn9bbmNcJ/RzelH8cowP+F52Wew3w01e0e4IXwTFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j20KO7j+j0nGfe1BWQ6zQlqbGUNcjR+S5/MTCQJs/ZBj2rc8+fnaSxmn8wUOk4BU0
	 mmJkEoBdLAaCRZ5WWs9guEW9AEWs9qdqpRtsp49vgObbvEpbdrMb0eJTz8YMXtt92M
	 2LJ2WJwAnUe9/CBbe50n2DIUBIAp8r3rQD1EJ46o=
Date: Fri, 20 Jun 2025 18:15:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH net 1/4] auxiliary: Allow empty id
Message-ID: <2025062045-velocity-finite-f31c@gregkh>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-2-sean.anderson@linux.dev>
 <2025062004-essay-pecan-d5be@gregkh>
 <8b9662ab-580c-44ea-96ee-b3fe3d4672ff@linux.dev>
 <2025062006-detergent-spruce-5ae2@gregkh>
 <91a9e80a-1a45-470b-90cf-12faae67debd@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91a9e80a-1a45-470b-90cf-12faae67debd@linux.dev>

On Fri, Jun 20, 2025 at 12:09:29PM -0400, Sean Anderson wrote:
> On 6/20/25 12:02, Greg Kroah-Hartman wrote:
> > On Fri, Jun 20, 2025 at 11:37:40AM -0400, Sean Anderson wrote:
> >> On 6/20/25 01:13, Greg Kroah-Hartman wrote:
> >> > On Thu, Jun 19, 2025 at 04:05:34PM -0400, Sean Anderson wrote:
> >> >> Support creating auxiliary devices with the id included as part of the
> >> >> name. This allows for non-decimal ids, which may be more appropriate for
> >> >> auxiliary devices created as children of memory-mapped devices. For
> >> >> example, a name like "xilinx_emac.mac.802c0000" could be achieved by
> >> >> setting .name to "mac.802c0000" and .id to AUXILIARY_DEVID_NONE.
> >> > 
> >> > I don't see the justification for this, sorry.  An id is just an id, it
> >> > doesn't matter what is is and nothing should be relying on it to be the
> >> > same across reboots or anywhere else.  The only requirement is that it
> >> > be unique at this point in time in the system.
> >> 
> >> It identifies the device in log messages. Without this you have to read
> >> sysfs to determine what device is (for example) producing an error.
> > 
> > That's fine, read sysfs :)
> 
> I should not have to read sysfs to decode boot output. If there is an
> error during boot I should be able to determine the offending device.
> This very important when the boot process fails before init is started,
> and very convenient otherwise. 

The boot log will show you the name of the device that is having a
problem.  And you get to pick a portion of that name to make it make
some kind of sense to users if you want.

> >> This
> >> may be inconvenient to do if the error prevents the system from booting.
> >> This series converts a platform device with a legible ID like
> >> "802c0000.ethernet" to an auxiliary device, and I believe descriptive
> >> device names produce a better developer experience.
> > 
> > You can still have 802c0000.ethernet be the prefix of the name, that's
> > fine.
> 
> This is not possible due to how the auxiliary bus works. If device's
> name is in the form "foo.id", then the driver must have an
> auxiliary_device_id in its id_table with .name = "foo". So the address
> *must* come after the last period in the name.

So what is the new name without this aux patch that looks so wrong?
What is the current log line before and after the change you made?

thanks,

greg k-h

