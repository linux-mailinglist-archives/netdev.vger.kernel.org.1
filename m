Return-Path: <netdev+bounces-253063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vECxH7OZdGmP7wAAu9opvQ
	(envelope-from <netdev+bounces-253063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:06:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 985C47D2FB
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F4CB3002B44
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C220298D;
	Sat, 24 Jan 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Htk4OK2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AFE3EBF3A;
	Sat, 24 Jan 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769249198; cv=none; b=rpcHulVA6gDtDY2JEImKcORgta7nRq28wZkdKZOapbvCwanwR01ytyTOn9+pm72Xj9hH9E7oYQ6LKQDWP237BcQcBaqLkpOK+9DH8sTre+c9a4VVBTm4zsMnUJ+hN3iLQ32BEkLnkwSGc2cC4425aggeW6SH+TW6HNPwzCk/xuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769249198; c=relaxed/simple;
	bh=bZKzyOHJyJ9VyqzCxia7oi2wqO4KxX8XWBpYJx4pwwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLwzI9DkRQ3xzl2JB9z0mJU2bD9fm7YPxdAAgszIm0/a2jfs3IFpCsTqSiJ1vT14cKWUrWPxhw2IjAitmA38D76zMg5NiyXUqrU3jAXRQDXETXLT8mXfHHbJ2HqRQs/y78VXmLEQTP1K3/uWMeC0L0Lq/KE5KXkh7nh91K48kH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Htk4OK2Q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769249197; x=1800785197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZKzyOHJyJ9VyqzCxia7oi2wqO4KxX8XWBpYJx4pwwM=;
  b=Htk4OK2QWBj4bt1GnUWht0OReIh/VMn0v12PkIKslWohPSMTcsnjvo2t
   DIP2AuVclmVe2xMX5dXtIlrkTx3GYys1UbInUphJ7i61YVcxAXpnThZMl
   Ij+8u8JtbP8u+eb2HBanLZbzdpMWrirntfiN/1xwdq8QagStgL9/U8v4r
   15H58MIdFg6h3yNZb/1vhUKRLzrs9BQrHO0zMIUycVdKlCFqXzxmrdnqy
   b0hiMPTbO/kqEFbygRZNxktK8RbUTJt4kqILEQNiegwjyecfSokWbV2LW
   M7Qut7QBcDZFRXqEbehEVeQgRkP73P/PZVzf4eN5x5F5XVY7g/GYMfAsk
   g==;
X-CSE-ConnectionGUID: R4CGzHAsRp2QJ+9Hx3EusQ==
X-CSE-MsgGUID: 8CpUm8BmSnKeF7rRWITDgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="93152143"
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="93152143"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 02:06:36 -0800
X-CSE-ConnectionGUID: YJpgOAmNTzmsFPxGYuDKQQ==
X-CSE-MsgGUID: 1JJmVYE0TlC1Ij2W5kFOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,250,1763452800"; 
   d="scan'208";a="207138653"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 02:06:32 -0800
Date: Sat, 24 Jan 2026 12:06:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Petko Manolov <petkan@nucleusys.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Oliver Neukum <oneukum@suse.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH net-next] net: usb: remove unnecessary get_drvinfo code
 and driver versions
Message-ID: <aXSZpWJnfuzpDX-C@smile.fi.intel.com>
References: <20260124092423.97481-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124092423.97481-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,nucleusys.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de];
	TAGGED_FROM(0.00)[bounces-253063-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 985C47D2FB
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 01:23:26AM -0800, Ethan Nelson-Moore wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> static void catc_get_drvinfo(struct net_device *dev,

>  {
>  	struct catc *catc = netdev_priv(dev);
>  	strscpy(info->driver, driver_name, sizeof(info->driver));

Side note: and we usually require blank line after the definition block.
On top, strscpy() in such cases can be improved to use 2-arguments variant,
as it adds a check for the destination to be an array.

> -	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
>  	usb_make_path(catc->usbdev, info->bus_info, sizeof(info->bus_info));
>  }

...

> static void rtl8152_get_drvinfo(struct net_device *netdev,

>  	struct r8152 *tp = netdev_priv(netdev);
>  
>  	strscpy(info->driver, MODULENAME, sizeof(info->driver));

Ditto.

> -	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
>  	usb_make_path(tp->udev, info->bus_info, sizeof(info->bus_info));
>  	if (!IS_ERR_OR_NULL(tp->rtl_fw.fw))
>  		strscpy(info->fw_version, tp->rtl_fw.version,

Seems the same, and so on...

-- 
With Best Regards,
Andy Shevchenko



