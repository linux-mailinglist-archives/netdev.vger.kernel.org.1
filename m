Return-Path: <netdev+bounces-217304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF696B3846A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794A2367BBD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6042FDC56;
	Wed, 27 Aug 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HJvKnkw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o9vwByD2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17A28980F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303558; cv=none; b=WCG2PKN5randl5vDLkjxwx2XRCyaHsNCljdJ2Y8ncg2+u1hb/fMYua5SPZfgd6S6zJaYaTKFDAJ7ETpiUdZPqVfoJ24QxuynNus3xImq/E476DET8tgbp++gqg6h534xxH1ohmojE4uIGh06HjlQBjAWJQw9MdlbS9lKKYEowvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303558; c=relaxed/simple;
	bh=e5BVtBpCtOJyC1Pkcou+8CrjG0HCXemPLs+PbZIHaVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SW2jvoZiBKW28G3A9CA0SHHh6Vc4R7SY9PuhIzVmkM3lRtSyDCO2tiOGjpfrmqRrVrvhi6y05xnZNR0F4OtaNF72Z0kzcapkRuVk2j+2qzhjp7AQgbAb3IimAQCsRY6+igd+W2wLeCArjkrHw3K2bejR3lnCWhv0dzvtdRls9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HJvKnkw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o9vwByD2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756303554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5BVtBpCtOJyC1Pkcou+8CrjG0HCXemPLs+PbZIHaVE=;
	b=3HJvKnkwWt5wuklmTFsJb/PzlNIcYTM4h7cjpMMqG5CQWR6XwrDxpFuYyDCdcvj/9VPvwj
	pXr0x5NRwx0ft2sJxyjSczgRlC/MHWS9YvBLIdH87DxuRAfR9f1tyPCQXj6+KyMstE+aJH
	P07PbJrfHlguQjqr55XZFcvSLudkNsHHwZwhMExEMLAv4v3742KNRU/2Lj6VCtZjKI6OL3
	ac1t/2Ch/A/1+f9JEHUgxM2B4amIKvo3Xalc4VvNVJqTwZYqbeRWR+EChd+AduTjG/lEG8
	3LWyItZLxsBVb8x9v6qQvMqyhQ9va2r16D2arm/EXQ+L9hYN7EGw8ZYYHf2Wxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756303554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5BVtBpCtOJyC1Pkcou+8CrjG0HCXemPLs+PbZIHaVE=;
	b=o9vwByD2aTF8gtV+jrXX286j+J01pXzFjFqxqa0SjLlQjrFlq946R8Zxg1mauNIkOSR+Qb
	7tKXucAwX6x5qNBA==
To: Miroslav Lichvar <mlichvar@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux worker
In-Reply-To: <aK8OrXDsZclpSQzF@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de> <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de> <aK8OrXDsZclpSQzF@localhost>
Date: Wed, 27 Aug 2025 16:05:53 +0200
Message-ID: <878qj4q2pq.fsf@jax.kurt.home>
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

On Wed Aug 27 2025, Miroslav Lichvar wrote:
> On Tue, Aug 26, 2025 at 02:59:12PM +0200, Sebastian Andrzej Siewior wrote:
>> The benchmark is about > 1k packets/ second while in reality you have
>> less than 20 packets a second.
>
> I don't want to argue about which use case is more important, but it's
> normal for NTP servers to receive requests at much higher rates than
> that. In some countries, public servers get hundreds of thousands of
> packets per second. A server in a local network may have clients
> polling 128 times per second each.
>
> Anyway, if anyone is still interested in finding out the cause of
> the regression, there is a thing I forgot to mention for the
> reproducer using ntpperf. chronyd needs to be configured with a larger
> clientloglimit (e.g. clientloglimit 100000000), otherwise it won't be
> able to respond to the large number of clients in interleaved mode
> with a HW TX timestamp.

Yeah, I realized that myself while testing :). The default
clientloglimit is too low.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmivEMETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgluMD/47MKWmL3M7Yq+ds4JgDuT8hQ0abUGI
e3sT05iKddJemgYsc9tyMQ8C8DfHVOwRKZ82/ZiZ8J5cltb/5kWWYYGKjDLU8tsE
pTGpDh/NEcEUZlC9Vz+joROWnZSsYIoMa5Nc758d+eNIXzlykesYjsnnMQ3uYb8F
CWzY1K97uz6lwBbKyXN2S4clWL1PwAKfVrYzkunTsfvpljq5JwdvmfP1dZuYqHmN
iEi+dlbMry8pMN3Nu5Gf0kin4TkjFDa2H4GFaMjdnFhh1srNK7cPzAGO3p6dIGJH
lHvqeHJp0a2xP86XZyrT9l5Lk25VEG3rFidmO2D5ekbAT2hTBYzNtnkmM+qA1gbF
jaH2VovcgJ1Okg4SxCqEtoXabcVP+/mJIlOmdpmUiGs4VeLq18DxjwBa5jJnBCzt
xgUuIXiCp/7j4bBQTdbyN8CYyV8hF+jCs5npSUCTeWqGFpkcOSUNWfxW84htwh5g
GyhKVAh8mUsqFBzjBjKIk3d5y7gStqWpAbZBnthrr8dFdxXCaGyWntkJcnuvldJl
fMghrAAC7V+16tDxxD4rNHk8TfXy1gJFzqQ9CAm7nAp5ax7MIwdyJ4a1yc7ARk5k
ndpLPY/Kz3f1i8WSZd9VGqJRFSuLNeONiTeTiHuwYoZICOwr7ljaX3AUoKMo5gsZ
fMMhDbY79rh5Xg==
=6dcc
-----END PGP SIGNATURE-----
--=-=-=--

