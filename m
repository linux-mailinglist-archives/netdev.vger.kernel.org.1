Return-Path: <netdev+bounces-186826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BAAA1B0B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478713A5E72
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD2254B03;
	Tue, 29 Apr 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9g5QemO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354224C81;
	Tue, 29 Apr 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953176; cv=none; b=bPtKcxBIYmmJcDHPurr8HcuSc9zS6qDKBc7VfcFjJzgAcMrtThT/M+tnLtPIbYNQzHzV9jBEpV0yYRakaePtnBHIY0S9MorPRFynvoPgTzpuBIrZE+xCE6zJXMpQHh9LVqQq4icwJrDA3L+LFEJTkpajCkyaS26FTR0XYm/JNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953176; c=relaxed/simple;
	bh=IwuY276gXMXUoDkxiZng8S0b2nH7rkCxOVSBBBNPPHo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UC133/IDjPV+zUvHRaGS2D9HdkOpw0rRdrKpnKlwqhY0s8GlFaLHgBe5C63WYr3IUDqoFcsU8CKlgOn1jFCl+1BgLHwXWvuWwLGIFbR5ONNZihvyPVBkDrEP4odP2FeVm0SVaKvEmNudPhQEA7PAJn27aTqpBVKzZTdfw2i/BLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9g5QemO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CE5C4CEE3;
	Tue, 29 Apr 2025 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953175;
	bh=IwuY276gXMXUoDkxiZng8S0b2nH7rkCxOVSBBBNPPHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9g5QemOAHdnQP3jwshUtWUdAIhUeA0ZudSeeYQ9aho1qlqq8hw29fKCK3/77J5kf
	 KE8ZAUpRm6RF0B92g9n/NH2WBesJZFIgM3j314/szT1RNYzGoQ6A0zZ5MKSaJbQ6Tn
	 eYtJkOVSS4yM5Ddc/RNsUE8SFyWid3Qk/ZpwVAtWToqyy/x3EQBnycXN02XPWlcl+x
	 kZcYcFy3JLiVipz3uVqL4/GUBrwCSiLLsaczly9Lqt9zWZmqn6TmBSr6PtahTzlbrX
	 djrSBIbEWo8/sFQegLWXnS7U2eASvpk9MirsSBnCHih0Hnzfe92otAzfAdxU47K9IU
	 WQeK+ByCTOGcQ==
Date: Tue, 29 Apr 2025 11:59:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko
 <jiri@resnulli.us>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/8] mfd: zl3073x: Add support for devlink
 device info
Message-ID: <20250429115933.53a1914c@kernel.org>
In-Reply-To: <20250425170935.740102-5-ivecera@redhat.com>
References: <20250425170935.740102-1-ivecera@redhat.com>
	<20250425170935.740102-5-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 19:09:31 +0200 Ivan Vecera wrote:
> +static int zl3073x_devlink_info_get(struct devlink *devlink,
> +				    struct devlink_info_req *req,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct zl3073x_dev *zldev = devlink_priv(devlink);
> +	u16 id, revision, fw_ver;
> +	char buf[16];
> +	u32 cfg_ver;
> +	int rc;
> +
> +	rc = zl3073x_read_u16(zldev, ZL_REG_ID, &id);
> +	if (rc)
> +		return rc;
> +
> +	snprintf(buf, sizeof(buf), "%X", id);
> +	rc = devlink_info_version_fixed_put(req,
> +					    DEVLINK_INFO_VERSION_GENERIC_ASIC_ID,
> +					    buf);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
> +	if (rc)
> +		return rc;
> +
> +	snprintf(buf, sizeof(buf), "%X", revision);
> +	rc = devlink_info_version_fixed_put(req,
> +					    DEVLINK_INFO_VERSION_GENERIC_ASIC_REV,
> +					    buf);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u16(zldev, ZL_REG_FW_VER, &fw_ver);
> +	if (rc)
> +		return rc;
> +
> +	snprintf(buf, sizeof(buf), "%u", fw_ver);
> +	rc = devlink_info_version_fixed_put(req,
> +					    DEVLINK_INFO_VERSION_GENERIC_FW,

Are you sure FW version is fixed? Fixed is for unchangeable
properties like ASIC revision or serial numbers.

> +					    buf);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_read_u32(zldev, ZL_REG_CUSTOM_CONFIG_VER, &cfg_ver);
> +	if (rc)
> +		return rc;
> +
> +	/* No custom config version */
> +	if (cfg_ver == U32_MAX)
> +		return 0;
> +
> +	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
> +
> +	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);

You need to document the custom versions and properties in a driver
specific file under Documentation/networking/device_drivers/
-- 
pw-bot: cr

