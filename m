Return-Path: <netdev+bounces-253897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOMkB+rEeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:00:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B937C9542C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F6B30C0FB5
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599235A95F;
	Tue, 27 Jan 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m6MVRLeu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6CA34D938;
	Tue, 27 Jan 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521968; cv=none; b=EkAidkIVQ6mmSTIZAeQR6hsNJp4OkSgEnpt91FQX1uPpLiwrx0+Ep/dbPbWYW4IlVhZYYv+F5WFBnyb4naHw7Ps1GCxlodl7KQ6reASZC94pEXgrQuxTWB5IrNvX2q2XkPFm2dTqd3XS7uDDeqYVAq1uWm0QgidXDuplFUuyzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521968; c=relaxed/simple;
	bh=F8XnPSK1WV42BiKx6nBfPnvD7hLslXmHdEE8LU5fzIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW2QMHTYHl93f6IybE2kr3cU8AbN+eXOaW6G8QL2syxKx7SpIVe49ZBf9DL2TVk352C7kEfZRsAqoRcCQUBeict7/ZB/ruPRm06tO1Bk9AmYFkSOBgdGbYmruRC4XkzabGBkVrhKhLR4ACZ2SVK8794Qb97c9hyePcYk2J23qFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m6MVRLeu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769521967; x=1801057967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8XnPSK1WV42BiKx6nBfPnvD7hLslXmHdEE8LU5fzIc=;
  b=m6MVRLeuPUXFheedIu7k1EoPlLY7EE4rCo6s79h6uddpnm/hD+yN5Ov+
   zoxLcWnNddq6xLXXofaOdlFfu4IXHf3AH0JnATaJtV2n0+FDiMlsby4oG
   3u+Cuepa+5J8AgGn9CMP3uOgb01xZZbpAtKoiVWaaKbrY+ciDVX7luTCO
   qK0Di7KkL935zMchy5aqYswAdVwuO3WXK7Z2r88gDfVBdxNX6cY+h2NGU
   ZTArCBxyPNWHIcknRlYT/DfSfloCL7Wrs8txfNuHm0NCLfe9jm02w3az3
   meptO1ImhpuBiokjxMF7soJEZ7/PxLN7yVO8fz+7PZrMjxfVyWcErI6dy
   g==;
X-CSE-ConnectionGUID: oMISwTkAS9aZMNoZMb1xNQ==
X-CSE-MsgGUID: 8Qc4/L74QfWz5I+HtSo8+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="82082541"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82082541"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 05:52:46 -0800
X-CSE-ConnectionGUID: B7snmXXfQdG1wgwWWIMeYA==
X-CSE-MsgGUID: m4+GHUwUQVuIn0+vgrCUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208414929"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO kuha) ([10.124.223.181])
  by fmviesa009.fm.intel.com with SMTP; 27 Jan 2026 05:52:43 -0800
Received: by kuha (sSMTP sendmail emulation); Tue, 27 Jan 2026 15:52:16 +0200
Date: Tue, 27 Jan 2026 15:52:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Matt Johnston <matt@codeconstruct.com.au>,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
Message-ID: <aXjDENOsmWe5_VqS@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
 <aXdyll4KVOF6SWni@kuha>
 <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: B937C9542C
X-Rspamd-Action: no action

Hi,

Tue, Jan 27, 2026 at 08:32:24AM +0800, Jeremy Kerr wrote:
> Hi Heikki,
> 
> > Since we use kernel mode device drivers, we need the kernel device
> > instances (struct device) that bind to them. If you want to deal with
> > user mode drivers then you can always do that with the i2c-dev
> > interface, but then you will not be using the kernel drivers such as
> > the mctp-i2c.c in this case.
> 
> Sure you could - the userspace ARP implementation would be responsible
> for binding an existing kernel driver to the newly-allocated dynamic i2c
> address - say, through the new_device interface. The choice of driver
> would typically depend on the enumerated UDID.

Uh, no. You should only use interfaces like new_device with the
devices that really can't be detected in kernel, which isn't the case
here. There is nothing preventing the kernel from detecting the ARP
devices.

So that really can not be the solution that we'll use with these
devices, but regardless of that, relying on user space in general with
the ARP protocol has considerable challenges that I don't see that
could be solved easily:

- You still need to deliver the UDID to the kernel because of things
  like the PEC flag, and the drivers will also need information from
  it.
- With the static (not hotplugged) devices you need to assign the
  correct ACPI node (or what ever fwnode) to the ARP-device.
- When the device is hotplugged, you would need new ABI, like I think
  you already noticed, but this really does not make any sense. We
  simply don't need it, because the kernel can process this
  information on its own very simply.

On top of those there were concerns, like what if an ARP-device is
needed relatively early on during the system bootup, but I don't
actually know how big issues things like that are.

But in any case, I don't think you would ever be able to make the ARP
work from user space except with the simples cases (possibly not
reliable even with those because of things like the PEC flag) which is
not enough.

So why would you want involve the user space at all since it would
just add complexity and limitations without any benefits? The SMBus
ARP is a standard, and _simple_, method of enumerating devices, so why
in earth would you not just let the kernel always take care of it?

> > But just to be clear, this is not only
> > about MCTP. The ARP-capable i2c-clients can be anything.
> 
> Yes, I'm not just talking about MCTP here either.
> 
> > So even if you still want to scan the ARP-devices in user space
> > separately, the kernel must enumerate those devices independently in
> > any case.
> > 
> > I should also point out that to my surprise the i2c-dev interface
> > (I2C_CHARDEV) isn't always enabled, even when I2C seems to be
> > otherwise fully supported in the kernel. We simply can't assume that
> > it's always available.
> 
> I don't think requiring a specific functionality to be enabled would be
> a showstopper for any particular implementation. We need CONFIG_I2C
> already, why is CONFIG_I2C_CHARDEV any different?

Oh, if I just had the power, I would place this requirement on
everyone and everything. Unfortunately I don't have that power :(

I think this would mean that either we take care of the ARP
enumeration in kernel, like honestly it really has to be done
(regardless of this requirement), or we have to continue maintaining
(and adding :-( ) the code in the drivers and board files that create
the i2c-clients for these devices.

Br,

-- 
heikki

