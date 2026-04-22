Return-Path: <netdev+bounces-280322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LJ7Bp5q6GlZKAIAu9opvQ
	(envelope-from <netdev+bounces-280322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:28:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C744266D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F96F30131C7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E422D060B;
	Wed, 22 Apr 2026 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aN1GEFoH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E92C0307
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839110; cv=none; b=XmNV1OYofDwaVtzCBqBM022BksrfNmM4ZojCreVGi6yGd3CJQE0/cEZ6uoU5IkaRG9qXoIKAZKfKRQNjcZligIrIayz0rlOlyp7caMGpYcQ/krwA0lFKfiPUjmwpmWWPQ2LLnWV2FX8Dae2qXsRrRueSF0qgS0T/JnOHbyA1U5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839110; c=relaxed/simple;
	bh=8+N+fKv7H2h5VOO+Z+El8qnaR3Ry59uYnjVpAB5dqX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZyZkASSGNJs8yt/VjCwZYTwQb6QK529Y+XoGBCvTcxRnFy3W49FH8Rt+hb7ZC1Zkig2nOafkLV6qu7OjYt0+3GC6ngvGQ3yrm3WnCfCmgaPEXFqPSd59w1ZyLwa0BqeL2ZBvzSSu1V7vhDFFQtshL22BaUvmf8e8gNwh3pmvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aN1GEFoH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776839109; x=1808375109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8+N+fKv7H2h5VOO+Z+El8qnaR3Ry59uYnjVpAB5dqX4=;
  b=aN1GEFoH4YnM4odfCJzRKwBJBVnfCysjZTYaAj5es8BPZOY20QZXN2S9
   onrYZxvp1AXxCdq2D/doPTNw/Kd9q5qk97S/h4KBMQR8asPL8lsRHR0kT
   K/wFD70stm36mPt5kus8439iHyJuvjjKZ6zj5bYNhmA3OVfcJ/5X+oDon
   BKf9p/d3/e7m6DRz3cpDz54J/Xw51RmkDbSXdCQGyREam0msHZGKNmTQB
   YdshpixuJxhQdLZEbWqEypsBksg6GTMxZFAQLywMRAat25fKFxJ+fWP5J
   uVLBQJWdJEEb7bkN49YnGYSjpGw7+xWgUBgOs1UHCRgG8ZrtvSwsEYoJv
   A==;
X-CSE-ConnectionGUID: 4HMvFoMQT36iAUA/buecLQ==
X-CSE-MsgGUID: IBQbqB18Qk6hnz2hrF8jig==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="95198571"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="95198571"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:25:08 -0700
X-CSE-ConnectionGUID: 5xau1z2JT+m3G+MrMCF//A==
X-CSE-MsgGUID: C3Q3kNx0RVS1Mq4uVTmnqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="237302928"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:25:04 -0700
Date: Wed, 22 Apr 2026 08:25:01 +0200
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
Subject: Re: [PATCH v1 05/11] drm/xe/sysctrl: Add system controller interrupt
 handler
Message-ID: <aehpvfbxFX9V3_i3@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-6-raag.jadav@intel.com>
 <c5ae7bab-ee42-430f-abf1-e062439c1356@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ae7bab-ee42-430f-abf1-e062439c1356@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-280322-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,black.igk.intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 810C744266D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:25:44AM +0530, Tauro, Riana wrote:
> On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > Add system controller interrupt handler which is denoted by 11th bit in
> > GFX master interrupt register. While at it, add worker for scheduling
> > system controller work.
> 
> Why do we need this series in the threshold patch. From what i see, we need
> only structures
> Can't we only redefine those here?
> 
> I know you will have to rebase again once any patch is merged. But this is
> unnecessary noise
> for the drm patch.

We have threshold crossed event so I thought it was relevant here. We can
merge it independently if you're okay with it.

Raag

> > Co-developed-by: Soham Purkait <soham.purkait@intel.com>
> > Signed-off-by: Soham Purkait <soham.purkait@intel.com>
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> > ---
> >   drivers/gpu/drm/xe/regs/xe_irq_regs.h |  1 +
> >   drivers/gpu/drm/xe/xe_irq.c           |  2 ++
> >   drivers/gpu/drm/xe/xe_sysctrl.c       | 35 +++++++++++++++++++++------
> >   drivers/gpu/drm/xe/xe_sysctrl.h       |  1 +
> >   drivers/gpu/drm/xe/xe_sysctrl_types.h |  4 +++
> >   5 files changed, 36 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/regs/xe_irq_regs.h b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > index 9d74f454d3ff..1d6b976c4de0 100644
> > --- a/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > +++ b/drivers/gpu/drm/xe/regs/xe_irq_regs.h
> > @@ -22,6 +22,7 @@
> >   #define   DISPLAY_IRQ				REG_BIT(16)
> >   #define   SOC_H2DMEMINT_IRQ			REG_BIT(13)
> >   #define   I2C_IRQ				REG_BIT(12)
> > +#define   SYSCTRL_IRQ				REG_BIT(11)
> >   #define   GT_DW_IRQ(x)				REG_BIT(x)
> >   /*
> > diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> > index 9a775c6588dc..e9f0b3cad06d 100644
> > --- a/drivers/gpu/drm/xe/xe_irq.c
> > +++ b/drivers/gpu/drm/xe/xe_irq.c
> > @@ -24,6 +24,7 @@
> >   #include "xe_mmio.h"
> >   #include "xe_pxp.h"
> >   #include "xe_sriov.h"
> > +#include "xe_sysctrl.h"
> >   #include "xe_tile.h"
> >   /*
> > @@ -525,6 +526,7 @@ static irqreturn_t dg1_irq_handler(int irq, void *arg)
> >   				xe_heci_csc_irq_handler(xe, master_ctl);
> >   			xe_display_irq_handler(xe, master_ctl);
> >   			xe_i2c_irq_handler(xe, master_ctl);
> > +			xe_sysctrl_irq_handler(xe, master_ctl);
> >   			xe_mert_irq_handler(xe, master_ctl);
> >   			gu_misc_iir = gu_misc_irq_ack(xe, master_ctl);
> >   		}
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl.c b/drivers/gpu/drm/xe/xe_sysctrl.c
> > index 2bcef304eb9a..7de3e73bd8e0 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl.c
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl.c
> > @@ -8,6 +8,7 @@
> >   #include <drm/drm_managed.h>
> > +#include "regs/xe_irq_regs.h"
> >   #include "regs/xe_sysctrl_regs.h"
> >   #include "xe_device.h"
> >   #include "xe_mmio.h"
> > @@ -30,10 +31,16 @@
> >   static void sysctrl_fini(void *arg)
> >   {
> >   	struct xe_device *xe = arg;
> > +	struct xe_sysctrl *sc = &xe->sc;
> > +	disable_work_sync(&sc->work);
> >   	xe->soc_remapper.set_sysctrl_region(xe, 0);
> >   }
> > +static void xe_sysctrl_work(struct work_struct *work)
> > +{
> > +}
> > +
> >   /**
> >    * xe_sysctrl_init() - Initialize System Controller subsystem
> >    * @xe: xe device instance
> > @@ -55,12 +62,6 @@ int xe_sysctrl_init(struct xe_device *xe)
> >   	if (!xe->info.has_sysctrl)
> >   		return 0;
> > -	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
> > -
> > -	ret = devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> > -	if (ret)
> > -		return ret;
> > -
> >   	sc->mmio = devm_kzalloc(xe->drm.dev, sizeof(*sc->mmio), GFP_KERNEL);
> >   	if (!sc->mmio)
> >   		return -ENOMEM;
> > @@ -73,9 +74,29 @@ int xe_sysctrl_init(struct xe_device *xe)
> >   	if (ret)
> >   		return ret;
> > +	xe->soc_remapper.set_sysctrl_region(xe, SYSCTRL_MAILBOX_INDEX);
> >   	xe_sysctrl_mailbox_init(sc);
> > +	INIT_WORK(&sc->work, xe_sysctrl_work);
> > -	return 0;
> > +	return devm_add_action_or_reset(xe->drm.dev, sysctrl_fini, xe);
> > +}
> > +
> > +/**
> > + * xe_sysctrl_irq_handler() - Handler for System Controller interrupts
> > + * @xe: xe device instance
> > + * @master_ctl: interrupt register
> > + *
> > + * Handle interrupts generated by System Controller.
> > + */
> > +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl)
> > +{
> > +	struct xe_sysctrl *sc = &xe->sc;
> > +
> > +	if (!xe->info.has_sysctrl || !sc->work.func)
> > +		return;
> > +
> > +	if (master_ctl & SYSCTRL_IRQ)
> > +		schedule_work(&sc->work);
> >   }
> >   /**
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl.h b/drivers/gpu/drm/xe/xe_sysctrl.h
> > index f3b0f3716b2f..f7469bfc9324 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl.h
> > @@ -17,6 +17,7 @@ static inline struct xe_device *sc_to_xe(struct xe_sysctrl *sc)
> >   }
> >   int xe_sysctrl_init(struct xe_device *xe);
> > +void xe_sysctrl_irq_handler(struct xe_device *xe, u32 master_ctl);
> >   void xe_sysctrl_pm_resume(struct xe_device *xe);
> >   #endif
> > diff --git a/drivers/gpu/drm/xe/xe_sysctrl_types.h b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > index 8217f6befe70..5f408d6491ef 100644
> > --- a/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > +++ b/drivers/gpu/drm/xe/xe_sysctrl_types.h
> > @@ -8,6 +8,7 @@
> >   #include <linux/mutex.h>
> >   #include <linux/types.h>
> > +#include <linux/workqueue_types.h>
> >   struct xe_mmio;
> > @@ -27,6 +28,9 @@ struct xe_sysctrl {
> >   	/** @phase_bit: Message boundary phase toggle bit (0 or 1) */
> >   	bool phase_bit;
> > +
> > +	/** @work: Pending events worker */
> > +	struct work_struct work;
> >   };
> >   #endif

