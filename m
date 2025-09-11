Return-Path: <netdev+bounces-222007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05FFB529D6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 09:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D539164D93
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 07:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86022459FE;
	Thu, 11 Sep 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jsg6ldPS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFniVzrw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE51329F11
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575629; cv=none; b=EmIe8AbdE+hwU4IfOV/Flk2YwO/6Gb5uBwn/3N6SApf1qPIXK7rcT2pmNwg9vSA+r5cZIYg0L00BUgJvGg6ST1EOy0cGnUmwl6goGZ/B1U5D6pTQV1TR/OUW6FCVc8MxjYeilgtHFYEY3Y2EmqF1NnsRgVoV8Tl+FttE19rzUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575629; c=relaxed/simple;
	bh=2MzhFcCHYd2rMrz+jthJu0X8jqMlb5XjnZvINgj30Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UbISLzzOkBvAwSyWjnb2gnASyxNUKJAkXJ6JmxSImCyc7rWwWstldBWgarz/rIV3g/KMTu23JfhOAXG6UP9Qhmr1MJsN6+twhySVT6sAuchFsqnHRgt9WXBnXcCGOPliifxOpwaKU3pp/6FSV/3QPL/fOHC+E11glcHxJfqFd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jsg6ldPS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dFniVzrw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757575622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxoRqRXqoKpRnVayyesoDxNe1k2DbyGFUFDxp1DbRBM=;
	b=jsg6ldPSaiKsLnKcDrcgjlywTlU2NYekzlsTrHyf/5Pw+lEJaljciZhFr4ZEaAueO6+cgP
	0RfsKg/3hbdcV9q0lNuAOG3WrLPo2ECX5jjyQkJyxuZA3vFi3NFKr3T0JQ4Db+FJM2+7jc
	oQxbV7uLo4YTom/8U+idSaV32P/CPFZqdug6PiqEJcWnfBytpyqDwMu7OUzHeRZlvCNrXg
	5e7GvfixSK9LxCAB4F+HS9bS0RY7kyvhuTrxGmQ646+DoRtpROYZEoDzKkvz18MyKPh0NX
	FlDjzkIyNJvV45VtH5G+OqSA26rnpBgYe7hhgDA/X57wcyYf8fEk7VOwCmdqxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757575622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxoRqRXqoKpRnVayyesoDxNe1k2DbyGFUFDxp1DbRBM=;
	b=dFniVzrwYeAGOWQifnwv6OJwg7fxqwqgCcK0t1SvvWpS8TJRTl1mg5baRgWfRFG12/gY+M
	qxGY4IgsQ+1jy9Cg==
To: Kohei Enju <enjuk@amazon.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, kohei.enju@gmail.com, Kohei
 Enju <enjuk@amazon.com>
Subject: Re: [PATCH v2 iwl-net] igc: don't fail igc_probe() on LED setup error
In-Reply-To: <20250910134745.17124-1-enjuk@amazon.com>
References: <20250910134745.17124-1-enjuk@amazon.com>
Date: Thu, 11 Sep 2025 09:27:00 +0200
Message-ID: <87plbxwit7.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Wed Sep 10 2025, Kohei Enju wrote:
> When igc_led_setup() fails, igc_probe() fails and triggers kernel panic
> in free_netdev() since unregister_netdev() is not called. [1]
> This behavior can be tested using fault-injection framework, especially
> the failslab feature. [2]
>
> Since LED support is not mandatory, treat LED setup failures as
> non-fatal and continue probe with a warning message, consequently
> avoiding the kernel panic.
>
> [1]
>  kernel BUG at net/core/dev.c:12047!
>  Oops: invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>  RIP: 0010:free_netdev+0x278/0x2b0
>  [...]
>  Call Trace:
>   <TASK>
>   igc_probe+0x370/0x910
>   local_pci_probe+0x3a/0x80
>   pci_device_probe+0xd1/0x200
>  [...]
>
> [2]
>  #!/bin/bash -ex
>
>  FAILSLAB_PATH=/sys/kernel/debug/failslab/
>  DEVICE=0000:00:05.0
>  START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>          | awk '{printf("0x%s", $1)}')
>  END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
>
>  echo $START_ADDR > $FAILSLAB_PATH/require-start
>  echo $END_ADDR > $FAILSLAB_PATH/require-end
>  echo 1 > $FAILSLAB_PATH/times
>  echo 100 > $FAILSLAB_PATH/probability
>  echo N > $FAILSLAB_PATH/ignore-gfp-wait
>
>  echo $DEVICE > /sys/bus/pci/drivers/igc/bind
>
> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmjCecQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgouOD/9wg6uDEBn9/vhNheAKhC/ywBUqkkiO
RSRwdgqdL14Opwj/K1d24X9SN5Hrk/2qVaBAHJciRFuuUNCBDjoAS4m1q2QEi6oJ
u64KakTLwxlNk1wrTJ9k05bGzILT0yN1bBjwzb8xKhpAoZE7oTTYAPWk9E7+J4tt
IrxnITZhDDvfnzxyBOQdRy0FIytz/+zgGUfvYnIYNuSXm7NyD3CTFqI4nnU49BzY
jvfizwKoqmZGBv5yKI+jgX74BnG78NsjCMFs41VxJPez2zJ+4cseNUeNuBSGbgZl
4BO6TfuswIM70esYMay8CzhtZhbWfqVyKWBFvqv/8xkXihVIDn+YHsx2qaNmfGab
Vdy8XKpnDynmkvvuLWQM2g7TmJCqbXiV0lYgQ2MyWmP0k7o0bYoSlMACm1oJBhba
joUI6g1Iqkr9K/ec/D9UJhRm87S0PLxAbEbRxIXfMrbqtxvfMQUcda/miIYyUvg4
8mOHRLTcGAJKdWbkgNSnJNJLzbJOAYaVnX0yxpQDJmt+SE3V6FqaBprV2b5b4nFP
5Myz1cAtb0+anT1MIt74ksUQHP8VeynSSreR4sMzTt+Zqc4vi0yQFzHUEVlZUv8N
eW3tGHns1g3xNx1RGF3SSEa9yCdYr6F8/nSclePq/W+ZZFz3wOZxyTUpAf5gKNt/
T1MKdw/Ll3/vbw==
=zhJS
-----END PGP SIGNATURE-----
--=-=-=--

