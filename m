Return-Path: <netdev+bounces-281918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPgDMqbF8GkxYgEAu9opvQ
	(envelope-from <netdev+bounces-281918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:35:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08674487154
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B795319A31E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B9A44BCAD;
	Tue, 28 Apr 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="PIZ4Qaif"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454983F210E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385984; cv=none; b=ft4FOhp9PoHT2wqMzUefCQXb8uZszppYJ8cEBZGk72YVC2PmRiRFDMX0fSOnUlCLmrhHXGoRvTIPAlOgzr0yL6k9geW0Ds+GuHvsE+s9zhHb6tzoVdN1dwCBtrZUKOJo6STHtSYOw47CAe7cP7JKxer4GF3AOQoikhHWy0JxSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385984; c=relaxed/simple;
	bh=E1R62W+o1WmGZp06ICLOzXQDlN3TsonSPNlvtwPb/UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVnh7dV+nfouxho/amn+Is5KNakckcOF7A1uUc9rbccV136zg1q2K81jw/yBLq7N14FwC1gobYVHdQF5zEpcjteT7jbb+vQXFjZ0hrgBoJkB/M+7zRsPDVxDmzryE+Ejkf8UMe23dstpXAD1vvohkfOHWzKrAULVUI2gxN4YL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=PIZ4Qaif; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so141174395e9.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777385968; x=1777990768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phN5F8mLcoCvE/uTX/spuQix6+rfPB7/DUcXpG7XTqI=;
        b=PIZ4QaifkvORapPZsfflMMJrnMNnkp6rvcLP+R2jeAJVpNmq8vnJyR1nXaihLeXQ6J
         AbWJGEobkDxWTDeXfkzNQXAEb8IF96XnONCGAf/SW0HOQ+IZk+4oJvMP3JOT5wEVN57l
         Dj/6yq/fPiIJUm1Wgb2dJO8TYwtKDzP9eOn1H0WoXG7SjvEOmE7RGEBm3xC/hyfhyzbN
         nCEiL+oJbzQpUGeY1eXm5Ze/OEcm1I33IPwQzZedRVZ8BrgiRsUf2ASJ3n1bVNxwNT5i
         K5WZLDIigK5ToMLTU2qyL2zm7IcjwqLwD4w6MHoUiI8F02rhbcDVXdYnCVX3Sqo+TSlj
         yKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385968; x=1777990768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phN5F8mLcoCvE/uTX/spuQix6+rfPB7/DUcXpG7XTqI=;
        b=D9Q+DUAEk2YE9yiFeW3xsFVrc3cPKkgWF8zoeRCNYbEl2entFAMNHnHxOUPgG1MekJ
         hu1fMXI4kI+j7h5z7xJrY8Js2jerRXLaNCb5poOViBW83C9Vqx2XsJjAN3O2tlcFPg9K
         cVZbyqFdCvJac4eFHu30cRJWrZbqtclX3xdJypynGF4q2Ab0Y7WaAtmes6TKDgc88DC5
         1hRVs9LVSnJsnspLi2/wIAnPtEHBHtN/brI4N8wwBbfrl14dMMdQYNV/t7TJuXnFOJeb
         b0CgBHzxkuHYDc9d6RqLq6T4Ow2++Ao2RjDaKNoQDZMCah6rXHBueN5qgxqr67JcGGcJ
         E+kg==
X-Gm-Message-State: AOJu0Yx4VWgFfoFRuBHGK3hNAapHsbXwyAp/7XLPSCOJ6v0BJmXG/TLc
	H0DECi0D2kt9539l6roxpJIerVMoliD8Mxtyo21tgibZZk5T6siUjK8pSIVSbXhdnChb9NvetzR
	5BlcX
X-Gm-Gg: AeBDietr2ysgtAkg9ODZ6gETbfnHLAiQmqrRy6gKOVj3SLjMp8WR0RRJKYoYRZSj9s5
	feqrQUbn3HGypJ+6od2wREOl+G3phrbjJpKquFOgPcDdY+dYU5jJTHjmfd6PHSuGUE6LcAONbuX
	9KqOcZMWHPDu49KLULS17RacQu/tHEzOzsd37N51N80D4F1Hc1l4L81yHjBnLartPKK/lDuh9Ct
	g8T+nIxIAErWry/AYBqZGHiDFKS9MmodRHkmFMWB/+gh94yBqHRJjORV7vkPg+WH7PB3sZQkSZR
	FbjfXS5jwhEQHVhfh3Hcb7xHxmOl4ExDk7HTsdrgnczBbXSO1LTgeNssVDHD+Z0qn++Oxp4BIOo
	ecjYJuBqIfQHgA2O7MimHyJ4IjfPdfFUYTc2h2MTeagkkYEDlhSlJ6vLtgghjRBddPoeKwshcxV
	75WIhQiMMF+4SC9ebkQ99+P3jkR6HAMIBnZhpXEisEBg==
X-Received: by 2002:a05:600c:3b8a:b0:48a:56de:d640 with SMTP id 5b1f17b1804b1-48a77b0a367mr58817265e9.16.1777385967866;
        Tue, 28 Apr 2026 07:19:27 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77af1b86sm53550275e9.5.2026.04.28.07.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:19:27 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:19:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>, 
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next 1/2] devlink, mlx5: add init/fini ops for shared
 devlink
Message-ID: <afDBiwauIoLhhCcj@FV6GYCPJ69>
References: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
 <20260428090912.3461-2-przemyslaw.kitszel@intel.com>
 <afCU-3Xmole6v4X4@FV6GYCPJ69>
 <b94a55c7-3d86-47bf-8acc-b82e31766116@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b94a55c7-3d86-47bf-8acc-b82e31766116@intel.com>
X-Rspamd-Queue-Id: 08674487154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281918-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]

Tue, Apr 28, 2026 at 03:44:54PM +0200, przemyslaw.kitszel@intel.com wrote:
>On 4/28/26 13:10, Jiri Pirko wrote:
>> Tue, Apr 28, 2026 at 11:09:11AM +0200, przemyslaw.kitszel@intel.com wrote:
>> > Add .shd_init() and .shd_fini() ops, that will be called for the first
>> > devlink_shd_get() (to initialize driver' priv data) and on the last
>> > devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>> > 
>> > .shd_init() could return an error, which will stop creation of shd
>> > instance. The initializer also gets an additional, optional param,
>> > that driver could use for any needs.
>> > 
>> > If any of the callbacks will need to get devlink instance, it could
>> > be accessed by shd_priv_to_devlink().
>> > 
>> > Both callbacks are called with devl_lock held and devlink registered.
>> > 
>> > Next commit will make use of the callbacks, another one will make use also
>> > of the non-null additional param (outside of this series).
>> > 
>> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > ---
>> > first discussed at:
>> > https://lore.kernel.org/netdev/20260325063143.261806-3-przemyslaw.kitszel@intel.com
>> > 
>> > Sashiko suggested to convert devlink_shd_create() to return ERR_PTR(),
>> > and propagate that up to the driver. It think it will just make code more
>> > verbose for not much benefit. And drivers could just store err if they
>> > want in the passed @init_param.
>> > 
>> > ---
>> > include/net/devlink.h                         | 26 +++++++++++++
>> > .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
>> > net/devlink/sh_dev.c                          | 39 ++++++++++++++++++-
>> > 3 files changed, 64 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/include/net/devlink.h b/include/net/devlink.h
>> > index bcd31de1f890..5d3a1337bfa1 100644
>> > --- a/include/net/devlink.h
>> > +++ b/include/net/devlink.h
>> > @@ -1586,6 +1586,30 @@ struct devlink_ops {
>> > 				    struct devlink_rate *parent,
>> > 				    void *priv_child, void *priv_parent,
>> > 				    struct netlink_ext_ack *extack);
>> > +
>> > +	/**
>> > +	 * shd_init: Shared devlink instance initializer
>> > +	 * @priv: shd_devlink' priv
>> > +	 * @init_param: additional param to pass to driver callback
>> > +	 *
>> > +	 * Called once when the shared instance is first created (by the first
>> > +	 * devlink_shd_get() call).
>> > +	 * Should initialize the driver's private data embedded in the shared
>> > +	 * devlink. May be NULL.
>> > +	 *
>> > +	 * Return: 0 on success, negative to prevent shared instance usage.
>> > +	 */
>> > +	int (*shd_init)(void *priv, void *init_param);
>> 
>> 1. "param" has specific meaning in devlink context
>> 2. You don't use the arg in driver
>> 
>> Care to drop it?
>
>I have a user for it, but it will be a separate series
>(I have already 15 patches there), will post RFC to link here
>to the user, will that work?

Add it when/if you need it, no? I still believe there might be a better
way instead of this.


>
>my intention was to not tie touching mlx code with big series for intel
>
>> 
>> Otherwise, this looks fine to me. Thanks! (small nitpick below)
>
>ack for the nit

