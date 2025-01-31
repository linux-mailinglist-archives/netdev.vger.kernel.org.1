Return-Path: <netdev+bounces-161759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5CA23B88
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 10:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA436164261
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF32815F330;
	Fri, 31 Jan 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5EeZYA4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4528EC;
	Fri, 31 Jan 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738316531; cv=none; b=QECTDdUfPWZdE+TWqYAHiFsNduX5hlgk8BBVIRKbi+ILniLWdMvGczwl1g6senhap0VUmWVMBsIQ2VsvEJjytTxqMKBvr//oKtW+6Q65Re76pNfWH1rU6kSCQR0upRosr9u6Op/qLkDdk5Cp7ZvvGwJLr6r8MqGbYkqzCw6Rrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738316531; c=relaxed/simple;
	bh=+7GB+WlvdA8/mRnAlxmTfQfynRmBQBMgpaIGw/mj8+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN8WifX35/LPnApXWVQg+2SAXo3DdC32MzU4nhcyVhhdcz4sG2qHhcpAZhN43uvGdbARpwIsZ6QxX2HhNuQfcuvgFS33w0jYMZCZT50QlIbaJudrJIJWsXw3df0QzNpz2FykK7IWi4qxWZX9IraObhzWVQIczE854VtvjYui0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5EeZYA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9108C4CEE1;
	Fri, 31 Jan 2025 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738316531;
	bh=+7GB+WlvdA8/mRnAlxmTfQfynRmBQBMgpaIGw/mj8+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5EeZYA41xRpYVOSdeGRxslsjPAnvUIF8Zw9qse+9JOEUVIrjIocBYgrZigiAAIab
	 jUlEH0h+gVASKu4BhZvWbWv2jj5ppezUEStrLVZd45deLll6Xto9mjCM7VLtkkjzqo
	 aGIsG0Pr/d+eFOquvavcxavlMm8eP0cMwSGHXpWdJL9Hc9OnXG1Fzh/Jde5nZtzTH5
	 Q0iKZTlUicnyjHxrbz7SvZceLa2GmZBB04Lo2XERjhpooGxC/gVC8vNNE1X2PUidwe
	 cRhnS/yBLpk/D4p/qB4L/TthXtlPwesdYvz9jBF6lmNuvuOPJfBgJMT78vtoE+w/ZF
	 3euJo36IiAyqA==
Date: Fri, 31 Jan 2025 09:42:06 +0000
From: Simon Horman <horms@kernel.org>
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, george.shuklin@gmail.com,
	andrea.fois@eventsense.it, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] tg3: Disable tg3 PCIe AER on system reboot
Message-ID: <20250131094206.GD24105@kernel.org>
References: <20241129203640.54492-1-lszubowi@redhat.com>
 <20250130215754.123346-1-lszubowi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130215754.123346-1-lszubowi@redhat.com>

On Thu, Jan 30, 2025 at 04:57:54PM -0500, Lenny Szubowicz wrote:
> Disable PCIe AER on the tg3 device on system reboot on a limited
> list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
> on the tg3 device during the ACPI _PTS (prepare to sleep) method for
> S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
> as part of the kernel's reboot sequence as a result of commit
> 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
> 
> There was an earlier fix for this problem by commit 2ca1c94ce0b6
> ("tg3: Disable tg3 device on system reboot to avoid triggering AER").
> But it was discovered that this earlier fix caused a reboot hang
> when some Dell PowerEdge servers were booted via ipxe. To address
> this reboot hang, the earlier fix was essentially reverted by commit
> 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF").
> This re-exposed the tg3 PCIe AER on reboot problem.
> 
> This fix is not an ideal solution because the root cause of the AER
> is in system firmware. Instead, it's a targeted work-around in the
> tg3 driver.
> 
> Note also that the PCIe AER must be disabled on the tg3 device even
> if the system is configured to use "firmware first" error handling.
> 
> V3:
>    - Fix sparse warning on improper comparison of pdev->current_state
>    - Adhere to netdev comment style
> 
> Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Hi Lenny,

For future reference, please post new versions of patches to netdev
in new email threads.

Ref: https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

