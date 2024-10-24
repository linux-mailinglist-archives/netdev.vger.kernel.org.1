Return-Path: <netdev+bounces-138883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F9A9AF4AB
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFC11F2201A
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D51C830E;
	Thu, 24 Oct 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lbRK7FY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804D18784C
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729805238; cv=none; b=POaZZe1iwZnYibTjG0rduybnj7hIcO5yfRMUh6MiLXej4+eiiDeN+qqMhV2QkExJCjhLrHV47mx6y5MaZBjQXgdw7OG55rCMg8WQUWFYQb+ZGBwIZ33j5VpvDC2gexe1z32/dSGlCBBhJ7ns8SBglphs6CCp1IMOEOErVsM76ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729805238; c=relaxed/simple;
	bh=ScQSvkrbHxh/gBEdZ1lLNOP9gFWP2d4ET/XAkmlQGxs=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TILhRx3zxBK5wPZSghp22fQ4bG9t/WTYsDNANpXj18vHRKJ8s+gcMcrzuZGJXIeOmfM6M5nYur6Hd/ydsWEBqN5pXMQx8u7bdiksZDCEY2ID7JuTR2QM1D2LSiLDH438fBqcxjVPOrCf+e8+FXLDp3nusK9QeV4xjnYz9biD+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lbRK7FY8; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729805228; x=1730064428;
	bh=ScQSvkrbHxh/gBEdZ1lLNOP9gFWP2d4ET/XAkmlQGxs=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lbRK7FY8q4lySin2YJpONTFIk3Z65XV4EQJyhLMc6nZDJ3S+zUfzKV/maGnhRVl74
	 QSy9n3oJptMJ9c4BUF7/CtKhP1btERfSQKHWXbnWpjQDK8LvpudNFfdVjvQj0VhAAD
	 zi+Dlma8xl5syyZbgKOs4RqDGREgOi+EzEaz1Jh5e4twHASVN5numfXzeQ2aTV4iNq
	 qDPe783lPQ5fOtrlZk8+R2aesMeFQB9P3oBz0yqLHnp9wzcDyGhvOztixwWsulq+HM
	 WxSwaMPReiDC47LvBHsFkgKwh639CgdOqjW0B7OhDBz0bz/A4ZpxIrh62QqCvEkGdM
	 N4d6exfzo/n9w==
Date: Thu, 24 Oct 2024 21:27:02 +0000
To: "nic_swsd@realtek.com" <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: caiopinheiro@pm.me
Subject: Fw: Error with r169 driver: unknown chip XID 64a
Message-ID: <zwypkMnfvgrWYC82a06P_VAOuVNQ82YT624Wx11obbtLFlzuLdyDr1NgVM-xnng71aHzo4YUR9JQVUhdMzpRVrv78PI0w56Aj8g40j9-VG8=@pm.me>
In-Reply-To: <D5U_WwXkhTuSWcHmuHLoh-T6QApOAq9VZJ8eiJD-mreT25RvMUUKixX-5dcWu2goCaec1O8AP_drisk5sEXz78hfLruIZatl75KHS66IOAY=@pm.me>
References: <D5U_WwXkhTuSWcHmuHLoh-T6QApOAq9VZJ8eiJD-mreT25RvMUUKixX-5dcWu2goCaec1O8AP_drisk5sEXz78hfLruIZatl75KHS66IOAY=@pm.me>
Feedback-ID: 6963182:user:proton
X-Pm-Message-ID: 5c1ed047b7dd146268316e9b6372718fc737128b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

------- Forwarded Message -------
From: caiopinheiro@pm.me <caiopinheiro@pm.me>
Date: On Thursday, October 24th, 2024 at 6:25 PM
Subject: Error with r169 driver: unknown chip XID 64a
To: hkallweit1@gmail.com <hkallweit1@gmail.com>


>=20
>=20
> Hi there! How are you?
>=20
> I saw the following error, and it instructed me to contact you.
>=20
> # dmesg |grep 8169
> [ 412.149320] [ T6541] r8169 0000:07:00.0: error -ENODEV: unknown chip XI=
D 64a, contact r8169 maintainers (see MAINTAINERS file)
>=20
> if there's anything I can do to assist, please let me know.
>=20
> Best regards

