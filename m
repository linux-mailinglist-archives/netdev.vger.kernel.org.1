Return-Path: <netdev+bounces-265410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAd4Mn6GrmnKFgIAu9opvQ
	(envelope-from <netdev+bounces-265410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:36:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB862358AE
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CD930086FC
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA7238C0A;
	Mon,  9 Mar 2026 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2mEel0z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA0169AD2
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045336; cv=none; b=K5eBYg7Db63++40TSJIJp+7EatlXHBxlaXbJSaE86RE+bFT1WSeMvHrdMeqWqft6fB1gVPcupNx9XgBSpxNA7UfGlsbSLTaJJjZ5YA8L6dJa6Tj2nXHQ8a1c1XBUfB/1Abx7AYampz5bGlTshcbjSSh/P/gC6nb0bjCjE2XjIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045336; c=relaxed/simple;
	bh=qOqiVkph/8zjmtN4+mdspfe+MLPcrHlnN8h98oCe/H0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRDGdVngd+Qzfgb9I6AhaqhxJGSTr89eIyHuSrP0fkFF3y0nCVWBFMHV5ALCiKIF1JxV/pVdqAUtY6VB48oA5P37UOzZ97vUukWSJx6Etdf0QLVw0O0DeyviP1qc+ieC1WDl66lOXVet750kH5yqbl6N1kKddo18g3IVy4eHIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2mEel0z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773045335; x=1804581335;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=qOqiVkph/8zjmtN4+mdspfe+MLPcrHlnN8h98oCe/H0=;
  b=I2mEel0zWj2sy5Aa2zPOR8guJFlCGq3e27b5xpvtiz4Gg9huTnEzYx/L
   MMgYU4535UBONF2/PqQkUV8I6Cg0PkSJoUd1JcdqJKEZ4PW2V0v1LGp8h
   SWW/KXjWlE4SzOnhIBQdCyoJesJIZT9BAQkoBs7iQMqLpX/2r1bI4RG3g
   GF1fDFmE0ZuZ/SUTcoA5fsAu9OHER9lNLGSILUQ8eK2FG0lKLCgBeIccA
   eDZN7hFxno8zbFyfyLUWXsE0runK3pJ7npGlUZZI6miUm9MmEOSJLSpuh
   pJj5ezx9pO9p3u5lZI2mEbDptsez9L2gDKxiYNXXVWwm7sJz20zVXm91u
   A==;
X-CSE-ConnectionGUID: Pkac7cowRb67WBORTKDRlQ==
X-CSE-MsgGUID: GH0FlzrQRIWmMFqVScFs/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77940899"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77940899"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:35:34 -0700
X-CSE-ConnectionGUID: IpyLOqx6RbSW9QHWgfNdqw==
X-CSE-MsgGUID: aV5QNBGhRGukG3SmV20ZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224617899"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.239])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 01:35:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Riana Tauro <riana.tauro@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, anvesh.bakwad@intel.com, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Riana Tauro
 <riana.tauro@intel.com>
Subject: Re: [PATCH v10 1/5] drm/ras: Introduce the DRM RAS infrastructure
 over generic netlink
In-Reply-To: <20260304074412.464435-8-riana.tauro@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260304074412.464435-7-riana.tauro@intel.com>
 <20260304074412.464435-8-riana.tauro@intel.com>
Date: Mon, 09 Mar 2026 10:35:22 +0200
Message-ID: <4d0a00281e4e69a5366699b1ee3fbb40f402c6ef@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4CB862358AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com,oss.qualcomm.com,amd.com,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265410-lists,netdev=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jani.nikula@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

On Wed, 04 Mar 2026, Riana Tauro <riana.tauro@intel.com> wrote:
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 0d0657dd1b41..5386248e75b6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -130,6 +130,16 @@ config DRM_PANIC_SCREEN_QR_VERSION
>  	  Smaller QR code are easier to read, but will contain less debugging
>  	  data. Default is 40.
>  
> +config DRM_RAS
> +	bool "DRM RAS support"

I encountered this with 'make oldconfig' today:

  DRM RAS support (DRM_RAS) [N/y/?] (NEW) y

Is it too much to ask to spell out "Reliability, Availability and
Serviceability" in the one-line bool documentation instead of the TLA
soup?


BR,
Jani.

> +	depends on DRM
> +	depends on NET
> +	help
> +	  Enables the DRM RAS (Reliability, Availability and Serviceability)
> +	  support for DRM drivers. This provides a Generic Netlink interface
> +	  for error reporting and queries.
> +	  If in doubt, say "N".
> +



-- 
Jani Nikula, Intel

