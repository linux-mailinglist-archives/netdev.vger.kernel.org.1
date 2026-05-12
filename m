Return-Path: <netdev+bounces-287209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNryAlhBA2ro2AEAu9opvQ
	(envelope-from <netdev+bounces-287209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:03:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFB52337C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4710D3201D31
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5D3B83E3;
	Tue, 12 May 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOI3/1Jf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B473BB66E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597076; cv=none; b=XQxmJwQ5zvA3ZL+/geC+msBEd4OQ9qW7Uo//liFKIZDlDSW5ZpbRZoyqDZpgMDs2Czr1TD/wopp8cvWwF1YMf+U0ZfeMCIh0QSuuWZFvwFWjefqSXuoMucYwZrY7lsVxPoS5Pj4Z9GpBPR/S37JW0yMOzDQqZBgaL1NJ9Z3tAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597076; c=relaxed/simple;
	bh=+2mlVVyC8rNfQKGiNjq8NYbKcjmNDprm2GMVkzAJa3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzEaJ+CUZ9jzpuAx8NZ9iSVVVbsC4YYLXJTEaSSQ7tS/tGwa8vEXMOhzek84e7WLV+ZSx7233yWXYst1yHJbQmc3OZzs4mAsKnXfnnoiu9SyJ1wfYdyYe3DAS5k9h8lOsvbXS69p52CJud81gYmqGjKG2Ygp+qXKWIWltfic0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOI3/1Jf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778597075; x=1810133075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+2mlVVyC8rNfQKGiNjq8NYbKcjmNDprm2GMVkzAJa3E=;
  b=NOI3/1JfIsCVeNY6n6tAAr8cHaVcPHLHnwDP3nU+hog3qf7mRmrT8SX0
   NBpZeNcyHvIOdXfB2jooBKXdx2RVAWcwtVBU8kky027B6DzkzrNhwoJsR
   bZg8/g5pq/MKoA35gplh5DDDZDwOQ5IwroK0FTUEBcZx2Bl3SfxsinNcQ
   /nhTH4VMm5kylRqPgVtynJmSbBt6wbW4s1dxBQ0ENIBAJPOzWtr3Dl8Dm
   kyEpMf2VfwAan6kkURgOLMXRz+klqElFXYFuPWjUsUVeKSZiWTAgzjFoW
   +hNMnSIhI66iX/9MLV5+sCo17PjqxfBus4kBG1VTfKyHaDsjW3DioQQUj
   g==;
X-CSE-ConnectionGUID: uMipjqG3T22yrXfEK99qtQ==
X-CSE-MsgGUID: FZRDYdIRSbeR4ag6J/yd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79491145"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79491145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:44:35 -0700
X-CSE-ConnectionGUID: f+vJYqrCSW2Xpqci1/0FiA==
X-CSE-MsgGUID: cUk01pY5RcK7VJ4iUtoQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242784455"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:44:30 -0700
Date: Tue, 12 May 2026 16:44:26 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com, soham.purkait@intel.com,
	anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 09/11] drm/xe/ras: Set error threshold support
Message-ID: <agM8ynv2w-iqsp-O@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-10-raag.jadav@intel.com>
 <5e90b9aa-9432-43b5-ae40-1fce383bb043@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e90b9aa-9432-43b5-ae40-1fce383bb043@intel.com>
X-Rspamd-Queue-Id: 1EDFB52337C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-287209-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,black.igk.intel.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:51:38PM +0530, Tauro, Riana wrote:
> On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > System controller allows programming per error threshold value, which
> > it uses to raise error events to the driver. Set it using mailbox
> > command so that it can be programmed by the user.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   drivers/gpu/drm/xe/xe_ras.c                   | 42 +++++++++++++++++++
> >   drivers/gpu/drm/xe/xe_ras.h                   |  1 +
> >   drivers/gpu/drm/xe/xe_ras_types.h             | 28 +++++++++++++
> >   drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
> >   4 files changed, 73 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> > index 3e93f838aa4a..26e063166c5f 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.c
> > +++ b/drivers/gpu/drm/xe/xe_ras.c
> > @@ -163,3 +163,45 @@ int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32
> >   	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
> >   	return 0;
> >   }
> > +
> > +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold)
> > +{
> > +	struct xe_ras_set_threshold_response response = {};
> > +	struct xe_ras_set_threshold_request request = {};
> > +	struct xe_sysctrl_mailbox_command command = {};
> > +	struct xe_ras_error_class counter = {};
> > +	size_t len;
> > +	int ret;
> > +
> > +	counter.common.severity = drm_to_xe_ras_severities[severity];
> > +	counter.common.component = drm_to_xe_ras_components[component];
> > +	request.counter = counter;
> > +	request.threshold = threshold;
> 
> We might need a max check here to avoid unnecessary values from user.

We may want to avoid hardcoding it in driver since it can potentially be
different per product.

> > +	ras_command_prepare(&command, &request, sizeof(request), &response,
> > +			    sizeof(response), XE_SYSCTRL_CMD_SET_THRESHOLD);
> 
> Nit: command, request, response seems to be a better format

Sure, I'll likely create a separate sysctrl helper.

> > +	guard(xe_pm_runtime)(xe);
> > +	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
> > +	if (ret) {
> > +		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (len != sizeof(response)) {
> > +		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
> > +		       len, sizeof(response));
> > +		return -EIO;
> > +	}
> > +
> > +	if (response.status) {
> > +		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);
> 
> Status should be converted to visible error codes. check [PATCH v5 3/6]
> drm/xe/xe_ras: Add helper to clear error counter - Riana Tauro
> 
> <https://lore.kernel.org/intel-xe/20260504065614.3832331-11-riana.tauro@intel.com/>

Coming right up.

Raag

> > +		return -EIO;
> > +	}
> > +
> > +	counter = response.counter;
> > +
> > +	xe_dbg(xe, "[RAS]: Set threshold %u for %s %s\n", response.threshold,
> > +	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
> Again not required. Value should be visible to user
> > +	return 0;
> > +}
> > diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
> > index 982bbe61461e..d1f71b1de723 100644
> > --- a/drivers/gpu/drm/xe/xe_ras.h
> > +++ b/drivers/gpu/drm/xe/xe_ras.h
> > @@ -14,5 +14,6 @@ struct xe_sysctrl_event_response;
> >   void xe_ras_counter_threshold_crossed(struct xe_device *xe,
> >   				      struct xe_sysctrl_event_response *response);
> >   int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
> > +int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold);
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
> > index d5da93d65cf5..d7e4a02a661d 100644
> > --- a/drivers/gpu/drm/xe/xe_ras_types.h
> > +++ b/drivers/gpu/drm/xe/xe_ras_types.h
> > @@ -92,4 +92,32 @@ struct xe_ras_get_threshold_response {
> >   	u32 reserved[4];
> >   } __packed;
> > +/**
> > + * struct xe_ras_set_threshold_request - Request structure for set threshold
> > + */
> > +struct xe_ras_set_threshold_request {
> > +	/** @counter: Counter to set threshold for */
> > +	struct xe_ras_error_class counter;
> > +	/** @threshold: Threshold value to set */
> > +	u32 threshold;
> > +	/** @reserved: Reserved for future use */
> > +	u32 reserved;
> > +} __packed;
> > +
> > +/**
> > + * struct xe_ras_set_threshold_response - Response structure for set threshold
> > + */
> > +struct xe_ras_set_threshold_response {
> > +	/** @counter: Counter id */
> 
> Nit: ID
> 
> > +	struct xe_ras_error_class counter;
> > +	/** @threshold_old: Old threshold value */
> 
> Nit: prev
> 
> Thanks
> Riana
> 
> > +	u32 threshold_old;
> > +	/** @threshold: New threshold value */
> > +	u32 threshold;
> > +	/** @status: Set threshold operation status */
> > +	u32 status;
> > +	/** @reserved: Reserved for future use */
> > +	u32 reserved[2];
> > +} __packed;
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > index a1b71218deca..b865768e903b 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
> > @@ -23,10 +23,12 @@ enum xe_sysctrl_group {
> >    * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
> >    *
> >    * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
> > + * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
> >    * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
> >    */
> >   enum xe_sysctrl_gfsp_cmd {
> >   	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
> > +	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
> >   	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
> >   };

