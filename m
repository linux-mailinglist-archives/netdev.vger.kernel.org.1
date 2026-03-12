Return-Path: <netdev+bounces-267009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OglI9uSsmnONgAAu9opvQ
	(envelope-from <netdev+bounces-267009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:18:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC1270410
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 11:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02353024138
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBC21D00A;
	Thu, 12 Mar 2026 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6bF6945"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD085222590
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310659; cv=none; b=oQ+XOqXR8ASjtKzrFujNRTDc4omfFJ+mFUqLO9bXKLzCxuT3ogGuJvGuzUnweZ3mNEkhpU10IRxe6UjT5QRMbcZIRU83rAvw4QVPfUwjSY6cX5swXVCOdRKHF8AJcQU0ooTZ2TaAI7vAxma2StdT95f6Xbc4xuS3afKN1l63kOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310659; c=relaxed/simple;
	bh=q10lpM6sZRUITHwwKuTv+xH4LIsg86jKPcy0faoM7Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnu2hNS0cTym+PJM4cz8EyfliHZGcUmmANa4l3OA31b+XvsuZav0TJklhW1Zv8iUegMisPVcy3NJwbTKlEhj0wjNqnzrPT8ylmsxyi1gDo61mKFHMzuzdVzOsFjcO8ihtALjUyQ7IyOixvZn59a83hKRJaWk6ZE8cIIZZaMnN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6bF6945; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773310658; x=1804846658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q10lpM6sZRUITHwwKuTv+xH4LIsg86jKPcy0faoM7Es=;
  b=a6bF69457qd5u4VYfWxCJ7pwNbh82azu458xwESN3fY4gq7iBhopmRlM
   B4dWBNNpRjLJRuJTaloTK6DVcSrxdXqXN8C9QmEETGGliT4ycls0fw9Qf
   y+puzaZmFfp510YpDWHP4auem4VZeaIzktY/ZR3JP7IqCdN9Tuxi+sqw7
   MxIg7JqxoPa/5t0Glfmut52zPfvXbBaejz543oP5alHTtwxpCbGNpmWdD
   3/Hoyjg5SVU6inHNI+sEQnqmQJ1AeT5KNdbdoFuFgrZz/zcLvW16tlhDD
   WEG6BoWXHAxmvQmscrYrHp00o1pUoWpNEDsmP591gK0SxCqBWauxEBUsf
   g==;
X-CSE-ConnectionGUID: Z8iVVXm8QDe4Me/qSRpXZA==
X-CSE-MsgGUID: oes4WYJOQbqOt0GMBWXa1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85873116"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85873116"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:17:37 -0700
X-CSE-ConnectionGUID: 6U0YCNtlS/uFf4lm9Auj8w==
X-CSE-MsgGUID: 4EJFmJB5QieJ72tRPRK7Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251270236"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:17:34 -0700
Date: Thu, 12 Mar 2026 11:17:30 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, simona.vetter@ffwll.ch,
	airlied@gmail.com, pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
	anvesh.bakwad@intel.com, maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH 2/4] drm/xe/xe_drm_ras: Add support for
 clear-error-counter in XE DRM RAS
Message-ID: <abKSunbqoLw7uxmd@black.igk.intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
 <20260311102913.3387468-8-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311102913.3387468-8-riana.tauro@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,linux.intel.com,intel.com,ffwll.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-267009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: EEBC1270410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:59:16PM +0530, Riana Tauro wrote:
> Add support for clear-error-counter command in XE DRM RAS.
> This resets the counter value.
> 
> Usage:
> 
> $ sudo ynl --family drm_ras  --do clear-error-counter --json \
> '{"node-id":1, "error-id":1}'
> None
> 
> Signed-off-by: Riana Tauro <riana.tauro@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_drm_ras.c | 35 +++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index e07dc23a155e..c21c8b428de6 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -27,6 +27,16 @@ static int hw_query_error_counter(struct xe_drm_ras_counter *info,
>  	return 0;
>  }
>  
> +static int hw_clear_error_counter(struct xe_drm_ras_counter *info, u32 error_id)
> +{
> +	if (!info || !info[error_id].name)
> +		return -ENOENT;
> +
> +	atomic_set(&info[error_id].counter, 0);
> +
> +	return 0;
> +}
> +
>  static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_id,
>  					     const char **name, u32 *val)
>  {
> @@ -37,6 +47,15 @@ static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_
>  	return hw_query_error_counter(info, error_id, name, val);
>  }
>  
> +static int clear_uncorrectable_error_counter(struct drm_ras_node *node, u32 error_id)
> +{
> +	struct xe_device *xe = node->priv;
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE];
> +
> +	return hw_clear_error_counter(info, error_id);
> +}
> +
>  static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id,
>  					   const char **name, u32 *val)
>  {
> @@ -47,6 +66,15 @@ static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id
>  	return hw_query_error_counter(info, error_id, name, val);
>  }
>  
> +static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_id)
> +{
> +	struct xe_device *xe = node->priv;
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
> +
> +	return hw_clear_error_counter(info, error_id);
> +}

This would've been much simpler if we had per node info, but for now

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

>  static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
>  {
>  	struct xe_drm_ras_counter *counter;
> @@ -92,10 +120,13 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>  	if (IS_ERR(ras->info[severity]))
>  		return PTR_ERR(ras->info[severity]);
>  
> -	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
> +	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
>  		node->query_error_counter = query_correctable_error_counter;
> -	else
> +		node->clear_error_counter = clear_correctable_error_counter;
> +	} else {
>  		node->query_error_counter = query_uncorrectable_error_counter;
> +		node->clear_error_counter = clear_uncorrectable_error_counter;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.47.1
> 

