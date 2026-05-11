Return-Path: <netdev+bounces-286627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFYzHpzAAWrKjQEAu9opvQ
	(envelope-from <netdev+bounces-286627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:42:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B5450CF89
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF3E03061D6F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534837648F;
	Mon, 11 May 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="U3g9rhLO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942639B94C
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499382; cv=none; b=B4G+Yx6DCy4fO8dgOLkIMdKuZGA0eiVG26nmAWWB8sa6wyQ82x+8uoH5/GbcrMQBZndi41znBR1rQ572Z1TMJbmyQp77x+ZrZHXEfYVZZMRBYudbdqGiIDCyeH/8SpojEsWMfypoc6kY+XsJ53SuWcu/d2O00TeNiI7pdG2iMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499382; c=relaxed/simple;
	bh=6lgM29MwkOytksRAiWzL6chMGKfDlzwqkxKBYliY8Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzCIXpvJDkyx/eAc+k5Jd6O2y+rtvGvBgE90IP/W4kpTB4VXs1A9oBiim3uhjK5w90aRm39jOGfKlrpzrVKn1gMMJh1g6lSDk72c+ld3NCsBLjEU8wXk1HNpEUIYsLtAJenAkDwKx7jHlTPiqUxSMExVfywOP8x0lXyqKrrGdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=U3g9rhLO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488d2079582so45104575e9.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778499377; x=1779104177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HPZurc9+/xqmPXUOQk+tYxGrrKgq/zuz8+mWyO5VOBE=;
        b=U3g9rhLOOVG/5wN4HxBVSItvy3WZ4rM/XmhUpxdZM5rpMILYOAc1ZsIJIWEC2f6L/W
         SAGssi722Nl9e9sh1INYsVnOy10PvqR5brnQ24SXKUMqTtTh53A4oDdgNhzIX/9KHOcS
         RswLQe6jyVyQwfTLz9cFr1Ymi6txkUKJf+d2wbRpywdP1SXLNiOmtl+TQfM+Ic9cvxWg
         5fm7FpZIEnmuZuS3fFFFwvQiHZdhGSpayDpEmv1adTPCVcrLhBlvEAo3MzVuIm99qUt2
         SvVyauNaeWtuRdZI0BxAYPqRbrKBMWEZV/5dQ0G2mnLTqunLmSr13fbfYzUPUHiF4z16
         2HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499377; x=1779104177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPZurc9+/xqmPXUOQk+tYxGrrKgq/zuz8+mWyO5VOBE=;
        b=N+lNNCtAnQc9dqxj9mdd6lMjBEYaYcZdqjxpZ+/heCNutwXWhXywFQcRLYc7fCp8W8
         oJkoFuroxfQh4xXP9Vc+uuqC7w9rJJ0Rao0m0hwUOLQgwm9TDfzwqd0fZifg6mUoIofR
         WwzHgFBos7ZBa3bRiJ41TZHdy04duZpB1CfSDNS+X6tZGBfUGWzxsAc346uIL5qkeOMH
         FcItN5uUlOd7htq5TmRSqLjFeauwryyE29sSaMQ4mhHsw9qmh3GNnDvDNzzK3/zHMbpD
         EVmPkmoIQAQqVPavWR8eqPmQLVZ6zHHMaKr0xlUg4eWNt1cNmv6V8Y8y6ffnaXAmY+GK
         P6BQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HogV/7NGy9PHybJ0GN9v76mw0vTl8Z++PI5PRm/aJ+nV5qbH/r1O9T+oZor1D/RLGCTxtZFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj+dJ8CBy6vXTfHXUsDcCUmbPqjC8EpuuzBELJxekHuLjPMGh
	jdvJV1fgRXXhXLAIBBCw2mY5grrzqYOynXM5ydsHTeSpCj0U0036g2Crezc4uaaBcZI=
X-Gm-Gg: Acq92OG0mD/hqG8z75wm31U+nwHLn2oC02i0AFZCBo//dUqZyO3bQb1mMUMRRPfkfhx
	on1tKuDu0GaaB0lWoSnQXjds8G1t0nPnm9PiHqvMUpTt/3/1oRm2wtDlN4ubZk1iQ5PGpt6cXLg
	cphZ3EHATMa6WNWeMVL2IXx7BdBUmUAWHoxx2pDo0+mS6FdXzVqc4b5s0+adAf3kBODeP+1C+kM
	4NYxJLDE8z3iDffylOpMtKxXtoT8k/z2AY2KcQ5jQpC5lR28ftwiHN6mNDda80JC/RDKJCJP0dQ
	wk7pTnNafzsBkIgb7B8QD0tQn+NtgG1WRK2V3m98Cj3jwf1iVsZXR5aKMgOnXfuomYxKYSJe70M
	CEYigLy6Dad3UhoqFTVHU0eSZ4VTNWIOmdyvZLefUVk1u9RjdBqz7C2JWGVrlGDmZVNxE2XCO3K
	QvKz4ib0dCzrY3nmOXZJD+w+f4SXVUvWfU
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48e51f3c4f4mr312345655e9.25.1778499376887;
        Mon, 11 May 2026 04:36:16 -0700 (PDT)
Received: from FV6GYCPJ69 ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fffba5fsm173243735e9.2.2026.05.11.04.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:36:16 -0700 (PDT)
Date: Mon, 11 May 2026 13:36:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	bruce.richardson@intel.com, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
	padraig.j.connolly@intel.com, ananth.s@intel.com, timothy.miskell@intel.com, 
	Jacob Keller <jacob.e.keller@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH iwl-next v1 01/15] devlink, mlx5: add init/fini ops for
 shared devlink
Message-ID: <agG-09NEyj4r_INc@FV6GYCPJ69>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
 <20260508124208.11622-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508124208.11622-2-przemyslaw.kitszel@intel.com>
X-Rspamd-Queue-Id: E3B5450CF89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286627-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Fri, May 08, 2026 at 02:41:54PM +0200, przemyslaw.kitszel@intel.com wrote:
>Add .shd_init() and .shd_fini() ops, that will be called for the first
>devlink_shd_get() (to initialize driver' priv data) and on the last
>devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>
>.shd_init() could return an error, which will stop creation of shd
>instance. The initializer also gets an additional, optional param,
>that driver could use for any needs.
>
>If any of the callbacks will need to get devlink instance, it could
>be accessed by shd_priv_to_devlink().
>
>Both callbacks are called with devl_lock held and devlink registered.
>
>Next commit will make use of the callbacks, another one will make use also
>of the non-null additional param (outside of this series).
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
>(v0) first discussed at:
>https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
>
>v1: remove redundant added blank line (Jiri)
>---
> include/net/devlink.h                         | 26 +++++++++++++
> .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
> net/devlink/sh_dev.c                          | 38 ++++++++++++++++++-
> 3 files changed, 63 insertions(+), 3 deletions(-)
>
>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index bcd31de1f890..5d3a1337bfa1 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -1586,6 +1586,30 @@ struct devlink_ops {
> 				    struct devlink_rate *parent,
> 				    void *priv_child, void *priv_parent,
> 				    struct netlink_ext_ack *extack);
>+
>+	/**
>+	 * shd_init: Shared devlink instance initializer
>+	 * @priv: shd_devlink' priv
>+	 * @init_param: additional param to pass to driver callback

The "param" word still pokes me to the eye. Could we figure out some
different name? "init_ctx" perhaps?

[...]

