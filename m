Return-Path: <netdev+bounces-51239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B97F9CD8
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4192811C5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D6171AC;
	Mon, 27 Nov 2023 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PSWLExw4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA0185
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:41:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so5250688a12.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701078073; x=1701682873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUCQNPnxA0WhE9IVSXozKQomqPo1RPr5tq7lygXHnZw=;
        b=PSWLExw4Qo895aEHnG4Gm5EW/d6TYz4++ADzxLY2kZiKJB2IMnjiXbl0CA86YYd9j9
         H+UzEiKPuF2gi2FPgvnoUQh53XkmDwS+U3hAOLOLnY02Q3CsCImSZ2BaG1JpTYu+MLGh
         kzb/5NXrpwygR6NO5reYlqB2Dcb9YeHtPzdcTdP7fPfP8dbynMWfBEEDH+fvNG5OVufD
         Get5ONdnCmmxcFYiAP+2moKsgjoFGWPgnK6p6mskCtKI0JTGLmmemqWSQeFi4alaqgbg
         UyZvsioRLl2pmUrpJak29FUtsWdtlXp67X/WEsRsQWCo9DioRDF/lQSwAaSZHjCisyWN
         4VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701078073; x=1701682873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUCQNPnxA0WhE9IVSXozKQomqPo1RPr5tq7lygXHnZw=;
        b=J52dFZE34xQycw/18XXgggRpxdIJUwBFx1rw4fu1RwdVE4NOUBmk81AFBe4SOLTMUi
         JY0U3/FszEXOSDT0GIefFjB46KUUiq7N2fl0D1rUf4xYqax9uzIVDw2WteI376QFvB4v
         Qu3aQF820D8eBDc0UanqDcJOSiCLL3NZ+h5PQu3q32Cn016+NvHyNNEm7VKUaVfHGL+d
         tMn7gRL/a1KTDpNhvGZC/GaG2nM3I/0Yd+k5Nd/EPRfDm0t50BZ9USe9xtZI4CYVvtrp
         sGQCl5zMh68CuuqOkIW7OZ85DaFyBCthapFcc2k/Zihh7ugw2hLLtmF56/cT+mRpJeqx
         XRuA==
X-Gm-Message-State: AOJu0Yyf7vm/AVhHXsfER8B/SDCRTXCgZUXeOkoZWbo6keIEgGxd0zIP
	2vSQD+Xn95/ps2Y5jEyMVx4jciCX9Cah8uLddiE=
X-Google-Smtp-Source: AGHT+IGeUdvZVC5a7Ar3svAcCBK16pGi6SCrexZsSH+Aonc7To6tkU/2mL2ZItVW0+Ph42jB8baJFA==
X-Received: by 2002:a50:9e0f:0:b0:547:b96:1172 with SMTP id z15-20020a509e0f000000b005470b961172mr7473450ede.28.1701078073323;
        Mon, 27 Nov 2023 01:41:13 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b00548a2d1737bsm5053723edv.35.2023.11.27.01.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 01:41:12 -0800 (PST)
Date: Mon, 27 Nov 2023 10:41:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sachin Bahadur <sachin.bahadur@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWRkN12fhENyN4PY@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127060512.1283336-1-sachin.bahadur@intel.com>

Mon, Nov 27, 2023 at 07:05:12AM CET, sachin.bahadur@intel.com wrote:
>PF interface part of Bond should not allow driver reinit via devlink. Bond
>config will be lost due to PF reinit. PF needs to be re-added to Bond
>after PF reinit. ice_devlink_reload_down is called before PF driver reinit.
>If PF is attached to bond, ice_devlink_reload_down returns error.
>
>Fixes: trailer
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index f4e24d11ebd0..5fe88e949b09 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 					   "Remove all VFs before doing reinit\n");
> 			return -EOPNOTSUPP;
> 		}
>+		if (pf->lag && pf->lag->bonded) {
>+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");

Nack. Remove the netdev during re-init, that would solve your issue.
Looks like some checks are needed to be added in devlink code to make
sure drivers behave properly. I'm on in.



>+			return -EBUSY;
>+		}
> 		ice_unload(pf);
> 		return 0;
> 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>--
>2.25.1
>
>

