Return-Path: <netdev+bounces-220545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6777B4685A
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE33A0418D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4504F1F9EC0;
	Sat,  6 Sep 2025 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKX6HLxm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18425199E89;
	Sat,  6 Sep 2025 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125148; cv=none; b=hQ7k3u5goUCJ2XjFFq2/Eq/lytFIr1CJZWlqqsSuQB7/TAoyCEFK2vcQZ2U3lAMWD+Kc+BgbYJj4FxgAJRTBas3VYa/OE0FyVMMDV7OtiTRA5UJpaK9PJOJNUpYtc+Gohpk5VXt9bjQ0IARzLK+buDu6boCaCX4XE1aDrMkWrSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125148; c=relaxed/simple;
	bh=uMe1YrMuMNNz4HUF0m8TMFFGt1MXxt8sXdVXg3Kqslo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7k7nQJG4QHrEihOTTTSPfw/Z+9ODGIGuKL2BZ7MjbtMFWWjnV7vNafrjdlL+DLg0x/xQ2cJKfdkmj8IAvQ2On5EfdmC1DAxH1tGqRdDn5o+2OY00g+g/JNZ/CNHG3dO3jRUAwbK5jbJDvZcYjnH3pqM8jiKVy+3YzZrfspbtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKX6HLxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B2DC4CEF1;
	Sat,  6 Sep 2025 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757125147;
	bh=uMe1YrMuMNNz4HUF0m8TMFFGt1MXxt8sXdVXg3Kqslo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CKX6HLxmIva0bjrgtUi8ftJpGqGfg22KhRIpULLCrk4wDumqvyt9dWH2c/VFlhX0s
	 KJahHw/twOYO9y3Bf147IjmZM3zfxIKldUvL8W1SaW9jzZom5c03W7JpJIs5HAU5rf
	 qbutuvlkUZIM5kxZ1kfW4hyjBksMzYkr3EeuuBDWBh3oAUSJWZdS7GIVlZMTivVsBD
	 k4nThYgnxxBuqrWC1wahd43JcKqcrPkN20N2SSHkt0l+SHjdvgzCCOpmvvyRPEtH1n
	 e7iLhuURjoV6Y21s2zx85E7VoCw5IcpBLwj74VDaMGezuGmC0+VcDDt1S4XWsvkQHl
	 zBuFofVuN4clA==
Date: Fri, 5 Sep 2025 19:19:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 2/5] dpll: zl3073x: Add low-level flash
 functions
Message-ID: <20250905191905.05476586@kernel.org>
In-Reply-To: <20250903100900.8470-3-ivecera@redhat.com>
References: <20250903100900.8470-1-ivecera@redhat.com>
	<20250903100900.8470-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Sep 2025 12:08:57 +0200 Ivan Vecera wrote:
> +/**
> + * zl3073x_flash_download_block - Download image block to device memory
> + * @zldev: zl3073x device structure
> + * @image: image to be downloaded
> + * @start: start position (in 32-bit words)
> + * @size: size to download (in 32-bit words)
> + * @extack: netlink extack pointer to report errors
> + *
> + * Returns 0 in case of success or negative value otherwise.
> + */
> +static int
> +zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
> +		       u32 addr, const void *data, size_t size,
> +		       struct netlink_ext_ack *extack)

function name doesn't match kdoc, and "Returns" -> "Return:"

No idea why the kernel-doc script doesn't catch this..

> +		rc = zl3073x_write_hwreg(zldev, addr, *(const u32 *)ptr);

you're sure data is 4B aligned? Otherwise get_unaligned()

> +		if (time_after(jiffies, timeout)) {

time_after_jiffies() ?

> +			if (signal_pending(current)) {
> +				ZL_FLASH_ERR_MSG(extack,
> +						 "Flashing interrupted");
> +				return -EINTR;
> +			}

Is the flash dual-banked? Normally random signals interrupting flashing
is recipe for bricked parts.

A little odd to use "timeout" for periodic check. check_time?

> +	/* Return if no error occurred */
> +	if (!count)
> +		return 0;

Did I already accus^W ask you if AI helped you write this ? :D
This level of commenting makes me think of code generators :)

+	/* Enable host control */
+	rc = zl3073x_flash_host_ctrl_enable(zldev);
+	if (rc) {
+		ZL_FLASH_ERR_MSG(extack, "cannot enable host control");
+		goto error;
+	}
+
+	zl3073x_devlink_flash_notify(zldev, "Flash mode enabled", "utility",
+				     0, 0);
+
+	return 0;
+
+error:
+	rc = zl3073x_flash_mode_leave(zldev, extack);
+	if (rc)
+		ZL_FLASH_ERR_MSG(extack,
+				 "failed to switch back to normal mode");
+
+	return rc;

Should we be overriding rc here if there was an error on entering
but we cleanly left? If so that _is_ worth commenting on..
-- 
pw-bot: cr

