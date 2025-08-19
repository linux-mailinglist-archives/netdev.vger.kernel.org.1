Return-Path: <netdev+bounces-214847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B986B2B6EA
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 04:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9321B65BC0
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D6286D64;
	Tue, 19 Aug 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCqNb6jY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBF4A35;
	Tue, 19 Aug 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755570125; cv=none; b=lRXCfDJNlSIsIg5a5+XoAzrGFp3fK+WnIpfgCx6MdlE+QD/+dg/mAeUjFxtAVG/Z7mmRfaCIO44NjiGOUWIr89DHRjBJq37a9L/L46he6Vz2ZTKcrYwzjR0/daOLxys4ndztJ7pPESqJyt75jq8d+HEsQ8SsCGErSiEB3ZigqtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755570125; c=relaxed/simple;
	bh=KmNwlcboE1hOA8QF2iB4ukhUt9lpbYp4L6F45Hz+8G0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u50/uoLkE7zltZHQMu01o15oxl48XFqbUzdpfoOB8GJkDnRESJYMJn0fiFXm8JkE3w71YQILSrm2gF5hArA8exT3wCxJ1frvzdNylFJb41MBWL6O1ht/j8jp9xTl+kGx29m89CONChIbgaCEl4RvfluSKoJME3l+87aluz6Hr6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCqNb6jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998A1C4CEEB;
	Tue, 19 Aug 2025 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755570125;
	bh=KmNwlcboE1hOA8QF2iB4ukhUt9lpbYp4L6F45Hz+8G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCqNb6jYUj8kZaH/NZeCOyTwxbO6d+d8bWHmyvDrhoNAaSxSoPhQjow5g70nXD0sS
	 +lK2AgTjLbVePrDMzNsA1xo9RDUxthtVdtiJscZZWdKknMIZOx8th7K0c5svAxWeYX
	 lUeUAoIiufxnLgb0o2cKeZEkn7rXspQV9mcM9RWQ6M7MbYnjslckJKlxJkLzjQrwFR
	 BqEghYfTcC8Dt0HDsEl432JEFAFU32ivNvjkkExk1wDAUo9WPFtnCDn9B/O1KjCRaI
	 Ar69D74wqSbFRPb2vP5rGydADniJZzGKNEKXM6BTu8NFzFIdxkym0W7OQuHHD4E5Gq
	 GI3l9ZZUAaO+g==
Date: Mon, 18 Aug 2025 19:22:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v3 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <20250818192203.364c73b1@kernel.org>
In-Reply-To: <20250813174408.1146717-4-ivecera@redhat.com>
References: <20250813174408.1146717-1-ivecera@redhat.com>
	<20250813174408.1146717-4-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 19:44:06 +0200 Ivan Vecera wrote:
> +#define ZL3073X_FW_ERR_MSG(_zldev, _extack, _msg, ...)			\
> +	do {								\
> +		dev_err((_zldev)->dev, ZL3073X_FW_ERR_PFX _msg "\n",	\
> +			## __VA_ARGS__);				\
> +		NL_SET_ERR_MSG_FMT_MOD((_extack),			\
> +				       ZL3073X_FW_ERR_PFX _msg,		\
> +				       ## __VA_ARGS__);			\
> +	} while (0)

Please don't duplicate the messages to the logs.
If devlink error reporting doesn't work it needs to be fixed 
in the core.

> +static ssize_t
> +zl3073x_fw_component_load(struct zl3073x_dev *zldev,
> +			  struct zl3073x_fw_component **pcomp,
> +			  const char **psrc, size_t *psize,
> +			  struct netlink_ext_ack *extack)
> +{
> +	const struct zl3073x_fw_component_info *info;
> +	struct zl3073x_fw_component *comp = NULL;
> +	struct device *dev = zldev->dev;
> +	enum zl3073x_fw_component_id id;
> +	char buf[32], name[16];
> +	u32 count, size, *dest;
> +	int pos, rc;
> +
> +	/* Fetch image name and size from input */
> +	strscpy(buf, *psrc, min(sizeof(buf), *psize));
> +	rc = sscanf(buf, "%15s %u %n", name, &count, &pos);
> +	if (!rc) {
> +		/* No more data */
> +		return 0;
> +	} else if (rc == 1) {
> +		ZL3073X_FW_ERR_MSG(zldev, extack, "invalid component size");
> +		return -EINVAL;
> +	}
> +	*psrc += pos;
> +	*psize -= pos;

what if pos > *psize ? I think the parsing needs more care.

