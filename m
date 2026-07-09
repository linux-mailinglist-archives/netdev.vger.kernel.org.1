Return-Path: <netdev+bounces-306153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rT3VGqN1T2qchAIAu9opvQ
	(envelope-from <netdev+bounces-306153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9972F80E
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:19:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=CzVKGG4H;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306153-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306153-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 334E13051CB0
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A62404BDA;
	Thu,  9 Jul 2026 10:04:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D853C5546
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:04:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591451; cv=none; b=rT+z3Va//oHJn5cM/nEHJxJV5o+vTHMWeAOLK+9QEUHkz4V+NqSmdU02fRDmDAhIJarQR05Tk1GxaWsvbVnAreDOfkN0ty8SJ4QYDTeRfg8ORloB3xfGgiV+X24wvKz5cYAMl6PFIAbXK9Lp/6mQ+otKbP7idBY9UyvT0hYC5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591451; c=relaxed/simple;
	bh=ifXbCxYpUjHu59OiIIZZCt4wGRbPAoNS773qHevYFm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WltmzY/OApZ4dHr+z+cwrL57YlGgrAUYaTz1R8KgEOnrj9IyKa6mrKL9wflnKBG2t2dqiH3JedzORbSleDFwH39SGc14LynrHlfuZbsBDuyJoWT7HNUoViqtBEDSe+hp4FNwKQvHJ5XNzC5S1yPMiPlPlcXJaEqhy+XuFUOyNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzVKGG4H; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783591450; x=1815127450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifXbCxYpUjHu59OiIIZZCt4wGRbPAoNS773qHevYFm0=;
  b=CzVKGG4HaUJso/XWxJc4OEmm8hH8elWq+H5lBeQxa2wxPXgrdRhEjC8u
   9rE3ohXFJGk3eNO2J3iFU93gNc736pbRq2v4ULZzPSlklqRAUGlGrJq+o
   ILoKSD6oP1j3vtUse/5f82cAKFeXQzv82oXzJsxkp0GhF2VNZAF5IJ7du
   Ws2lRnxbpbR5cbiLldKXs0hiY1W8kHsdSZPbBppJeem+/Osh/wUlF9+ye
   LsUPcRW6yeCsriHyXHM/iifLYLkLoD+uIfy8s73kk3+wSA0kjaZBJWvDD
   QgTOowRaP1kELXoL/ilRMMpAdAvB250euXZyurmNonr5D0JaMnMy692+d
   A==;
X-CSE-ConnectionGUID: HqugKl0gSDy585J8JWWyAA==
X-CSE-MsgGUID: shQVPLnAQIesugwQa5hlGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101815710"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101815710"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:04:09 -0700
X-CSE-ConnectionGUID: 8qbiF+8CQ5+VdNnlVzpgpA==
X-CSE-MsgGUID: 9cJlt2YKT8eEZeCyv8fSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250137721"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:04:06 -0700
Date: Thu, 9 Jul 2026 12:04:03 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, kuba@kernel.org,
	simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701094409.129131-8-riana.tauro@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306153-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:riana.tauro@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:michal.wajdeczko@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black.igk.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5E9972F80E

On Wed, Jul 01, 2026 at 03:14:13PM +0530, Riana Tauro wrote:
> Add error-event support for Correctable errors in CRI. Report an error
> event to userspace for every component that has crossed the threshold on
> receiving an interrupt.

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
> +		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);

This is uapi and not coming from sysctrl, so the message is a bit
misleading. But if at all it needs validation, it should be done in
drm_ras layer.

> +		return;
> +	}
> +
> +	drm_component = xe_to_drm_ras_component(component);
> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
> +		xe_warn(xe, "sysctrl: unexpected component %u\n", component);

Ditto.

> +		return;
> +	}
> +
> +	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);

No, instead of converting back and forth just do get_counter() using
sysctrl values and send_event() afterwards.

> +	if (ret)
> +		return;
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
> +}
> +
>  void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  				      struct xe_sysctrl_event_response *response)
>  {
>  	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>  	struct xe_ras_error_class *errors = pending->counters;
>  	u32 id, ncounters = pending->ncounters;
> +	u8 sent = 0;
>  
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(XE_RAS_COMP_MAX > (BITS_PER_BYTE * sizeof(sent)));

I prefer it the other way around. Also, have you tried using BITS_PER_TYPE()?

	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX));

>  	xe_device_assert_mem_access(xe);
>  
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -154,6 +211,24 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
> +				severity);

This should be before "detected" log above.

> +			continue;
> +		}
> +
> +		if (component >= XE_RAS_COMP_MAX) {
> +			xe_warn(xe, "sysctrl: unexpected component %u\n", component);

Ditto. Also, use xx_to_str() in both cases or don't but be consistent.

Raag

> +			continue;
> +		}
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |= BIT(component);
> +
> +		ras_send_error_event(xe, severity, component);
>  	}
>  }
>  
> -- 
> 2.47.1
> 

