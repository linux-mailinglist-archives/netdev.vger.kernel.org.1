Return-Path: <netdev+bounces-154221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5765C9FC283
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 22:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F26164D70
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68818FDD0;
	Tue, 24 Dec 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="P1cU2TEj"
X-Original-To: netdev@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547B7632;
	Tue, 24 Dec 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735074735; cv=none; b=KyXGcCBpZeGIG5HS2+wYrbqp6nerGmuXjT7uh8J6wS0OybK4uEo6FkQUQlrDKroE0wvI3oDixcImXZYd0mg3DmtZqU0Xi792lx8c9/BFHX0iKPArDPYON0sja5rdinaH29dell+XmdW6jZwyVKXYe6u0pesKDth5/5adJcu0hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735074735; c=relaxed/simple;
	bh=491cSF7LJvUawIvquQXMcEBfcNPtn2qI+rNChsFR/zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bMmhQ8K2BiP7zXd0tmfn0G5hPLinpnE+njuzxuyHWSNvYnfLkRfHM8YK0PcA70SOf5PLYCUdtSOVckue2Z2VmIN/gPW9Dn3bbh6xDvRcSVZRB7VV7WUjPhnAkDEzDQQEBFpJ0Yvdy/Jtv6bqGDit5ih86886ZbvhIQ3hfwHSjgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=P1cU2TEj; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id E3E44633BF6E;
	Tue, 24 Dec 2024 22:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1735074307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=taQm4XxtGduwWfvw/iGse424SuauPdikVpwQ4BIbPL8=;
	b=P1cU2TEjofQahYFORMOe+i09VlwXUZoV28dIC6T3mj0AjhreBjT44uNGEYW3gHofWOYQV7
	D1wF7pJOk5eIrtmE+JCh8uvFNWWq+y7bHaPQaESoNNuY0sBgaabFYYB1/JyWU4uBKvN9an
	rzCLyA8lWbmmEsfjCinG/2ctQTfE+vY=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bbr3] Suspicious use of bbr_param
Date: Tue, 24 Dec 2024 22:04:53 +0100
Message-ID: <4616579.LvFx2qVVIh@natalenko.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2349887.ElGaqSPkdT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2349887.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [bbr3] Suspicious use of bbr_param
Date: Tue, 24 Dec 2024 22:04:53 +0100
Message-ID: <4616579.LvFx2qVVIh@natalenko.name>
MIME-Version: 1.0

Hello Neal.

One of my users reports [1] that BBRv3 from [2] cannot be built with LLVM=1 and WERROR=y because of the following warnings:

net/ipv4/tcp_bbr.c:1079:48: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
 1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
      |                                                       ^
 1080 |             bbr_param(sk, ecn_factor) &&
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~
net/ipv4/tcp_bbr.c:1079:48: note: use '&' for a bitwise operation
 1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
      |                                                       ^~
      |                                                       &
net/ipv4/tcp_bbr.c:1079:48: note: remove constant to silence this warning
 1079 |         if (!bbr->ecn_eligible && bbr_can_use_ecn(sk) &&
      |                                                       ^~
 1080 |             bbr_param(sk, ecn_factor) &&
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~
net/ipv4/tcp_bbr.c:1187:24: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
 1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
      |                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
net/ipv4/tcp_bbr.c:1187:24: note: use '&' for a bitwise operation
 1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
      |                               ^~
      |                               &
net/ipv4/tcp_bbr.c:1187:24: note: remove constant to silence this warning
 1187 |             bbr->ecn_eligible && bbr_param(sk, ecn_thresh)) {
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/ipv4/tcp_bbr.c:1385:24: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
 1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
      |                               ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
net/ipv4/tcp_bbr.c:1385:24: note: use '&' for a bitwise operation
 1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
      |                               ^~
      |                               &
net/ipv4/tcp_bbr.c:1385:24: note: remove constant to silence this warning
 1385 |         if (bbr->ecn_in_round && bbr_param(sk, ecn_factor)) {
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.

The usage of bbr_param() with ecn_thresh and ecn_factor here does indeed look suspicious. In both cases, the bbr_param() macro gets evaluated to `static const u32` values, and those get &&'ed in the if statements. The consts are positive, so they do not have any impact in the conditional expressions. FWIW, the sk argument is dropped by the macro altogether, so I'm not sure what was the intention here.

Interestingly, unlike Clang, GCC stays silent.

Could you please comment on this?

Appreciate your time, and looking forward to your reply.

Thank you.

[1] https://codeberg.org/pf-kernel/linux/issues/11
[2] https://github.com/google/bbr

-- 
Oleksandr Natalenko, MSE
--nextPart2349887.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmdrIfYACgkQil/iNcg8
M0tUvhAAvH9vhE+m5NFQnz1waI/hMctv+xK22xR1DMDzhObQEMhj1F+5ljXcutbT
MXX8A0br87BjFasYd/kaSrbxPXqoNk5dYKm+WyEOpMDrT2SSIrln61FgHRQIBrAU
su8+8EALeJ4lnFgxGN6Wi9E4iLYVXN5VdJiwrcu3ks1b2JcPVkRWNSev/SObeA3e
fuQdIb6A5rigvqiF93qTTtr+/Rgf/yRPlZ331HopVTMHIhGbcMoHYpQ2GHd3jgb3
cnC8r+Ddo+209gBxPJs3Dyqous6Ujitm0b0O3nBclPyCqLclfcHYnlse/SCUA4Xe
7xUjvoBnGSwQRVQdart9gm2cjGNpunJoIGY2qYZU6vlPh8HMx4rkGGk8xl6W6Ned
bk963DJCr00FUG9d+pa/wXJD6Fx1KORZZd7o9vqiO0TluSmDxxNzvZZ6mdngX0Zc
7OEQ0kfevqfQvo1Cg7cn0XAF1qVquzcIAxmGalWXI8vxLA+J4sMDrMziy6PpoGAs
nAlw2B8f9g4NxYbfFXMDM2vsgEQ+tGDfti58iwl7dpUBYw69jHZ7CpZ8MPH1DBro
+s3s4Usxr0AqaYQQgvXJ5zF+hb0HdauZwEd8OCs0R0C8TrLMcu8hY0nscxyJPGMS
7HfDUNer9WjGegoAqyRdZwfJobEwYLTiOiGqOTeOJ1UUavu2+CY=
=bHUW
-----END PGP SIGNATURE-----

--nextPart2349887.ElGaqSPkdT--




