Return-Path: <netdev+bounces-222497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10ADB547D4
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03CA1C2142C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763228B4FE;
	Fri, 12 Sep 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="y2h6V8Es"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10696.protonmail.ch (mail-10696.protonmail.ch [79.135.106.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AE28BA95
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669555; cv=none; b=OL40NoWQyQVq4pgIxvf2N0Xkbe052WYLWbpVu7OOzKyCD48ddLdpo0QTknHJZ99HImIPJl8n8+7Y3MzRsv7jSVaaaAl55ow1XvXKu26SXoMH54YURNXF+vNd7HRXyLE74k6EqZKhW/KxNIZPJACoweZClotTfMAcQm11emrI01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669555; c=relaxed/simple;
	bh=449REAjmzKyZZCRxqF75IxbofWTGzye4W/HkQCUR1DM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JImSsXOU3ll1u5WqTXs8bqApWXOr/ZC6wosJkv2Qe8iiTTm6oU8KATsCwsu6UDpGBCVrOAYCzgOVyFcS88m9e71oYRbqhjC3UQ+GFQkCrU192hUSu4czwjZu/xR1+pFARMIyo462Ap1o/Nt9Jt12eY04rJp73OmdEw4kD6EtDV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=y2h6V8Es; arc=none smtp.client-ip=79.135.106.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757669551; x=1757928751;
	bh=mKupjn7ejfCcu7B0h/isuQWh8V55vUBuKyP5/Ue7u+U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=y2h6V8EsR1DgZsiwCg6M/AOfP3AgUquSgEHtTeWLJhvYtiFB+hCP6Y/e0mmXlWgc4
	 Zz4LWGi8nzsqhv4kolPaht4uKZ+pugnVp0+F+lilcnLPTfH0gHstePx7Ma0dbvhw0t
	 EIaWsi+IsjWt9K6IkLbZ+MQaMhALEsLPQCZDx7F/W54h58pZqod5TUOABk/BxN3Hbt
	 6s3cEKADjg7cnYbQSro8JSotL9hdjSRumKtt1FGecdG3uT7AvyXlND5hy69tBS9Q2l
	 QOLEnQdW2N3BHByQbn2JhKLlYhTAES/Yuty+r+dH9bt+Ir2/6sifdp6Y5qmvWKAtXw
	 4Bva9MF04K7Uw==
Date: Fri, 12 Sep 2025 09:32:26 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: "Named T. Relay" <namedrelay@protonmail.com>
Cc: "dsahern@kernel.org" <dsahern@kernel.org>
Subject: Re: Cannot select IPv6 in menuconfig without including IPv4?
Message-ID: <yHftSrMjQBVGwggLsgBF9hRwwRUF8CS0Sfn4eRfOgm2Rku50-sJfo0aQt3zSVAJEHUspFcxnox2miGOflaFyrrdyktUa06q-SVVE-JuDTzc=@protonmail.com>
In-Reply-To: <O0MpigXMo6xF3ly3-KV3Lt1jwRZGyYlHwz-qHmca6gSgqS20WcZhnoUYpW_hGaozLSYOMAyo3jfvTKPvYkBP5ZVgTNf58WW3rpoSG1nzlrE=@protonmail.com>
References: <O0MpigXMo6xF3ly3-KV3Lt1jwRZGyYlHwz-qHmca6gSgqS20WcZhnoUYpW_hGaozLSYOMAyo3jfvTKPvYkBP5ZVgTNf58WW3rpoSG1nzlrE=@protonmail.com>
Feedback-ID: 19840174:user:proton
X-Pm-Message-ID: 275011b141eb236c8bd7dbdc457db5252b57ec4c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>  Greetings kernel people,
Given the lack of response, i presume that my email was forgotten.
(Or are you supposed to add individuals? I'm new to this.)

>  I wanted to compile an IPv6-only kernel. That basically is a Linux kerne=
l
>  with only IPv6 networking support. However, if i want to select IPv6 in
>  menuconfig, i am also required to include support for IPv4. From my
>  understanding, IPv4 is not a dependency of IPv6, so it should be possibl=
e
>  to select either of them independently. Right now, this is not the case.
> =20
>  I believe the inability to do so is a bug.
>  Woud it be possible to have this fixed?
i later realised that this may be a result of historic design choices.
If that's the case, this wouldn't be a bug but a feature request.
(I hope that calling it a bug didn't sound rude, apologies if it did.)=20


Thank you and have a nice day,
Named Relay

