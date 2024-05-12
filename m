Return-Path: <netdev+bounces-95749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96938C34DC
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 04:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E2FB20F90
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 02:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7BE63C8;
	Sun, 12 May 2024 02:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=16982.aqq.ru header.i=@16982.aqq.ru header.b="pcIbzIHo"
X-Original-To: netdev@vger.kernel.org
Received: from lake.multihost.cloud (lake.multihost.cloud [37.230.118.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A352F52
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.230.118.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715479955; cv=none; b=a6G/1YbEZ9PDedjgOi3hf+XG8wkTb9wqu4X0Qr1+9vDzcqit+Vmq6G9YVtd+TCJhhO4e4eLbwN6YEIAV+HYZCvwgilwyIIrCZ0IffHwjHWdzk4ASL5gd6QVtj1x/ZbNLU6XWYIJdGPpOd8PzF+oXmJJdnVuY9SOPl3jicoZiO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715479955; c=relaxed/simple;
	bh=lli/Wy5IaMVuZVdGOC4sTPB9OtIsGe9pKDhrnxLnBcY=;
	h=To:Subject:Message-ID:Date:From:MIME-Version:Content-Type; b=CZWuZgNYLxu2DSL/uBlnESGZ+3Nr8liHz4n6E6u5pA9uMAjg12W/u6awNyEXb/Ye4qlndYM5GC9DHqtwZzDQ0hM2oAyWp9Fsdk6wKrIVi5HjZfX47eMBTgtXibkJ/TEK3dKBFnsklKQWrwJUS2IdmyZZLBP3pLs/vQNgl7m45g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=form.ru; spf=fail smtp.mailfrom=form.ru; dkim=pass (2048-bit key) header.d=16982.aqq.ru header.i=@16982.aqq.ru header.b=pcIbzIHo; arc=none smtp.client-ip=37.230.118.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=form.ru
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=form.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=16982.aqq.ru; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:From:Date:Message-ID:Subject:To:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lli/Wy5IaMVuZVdGOC4sTPB9OtIsGe9pKDhrnxLnBcY=; b=pcIbzIHojAWrO0Ddt/0YqJclCS
	u2cdHaU6/yK8a8p6ftXVT9Rw1jS6mLfyKa+3Lwani1SiQfCC2KGcv7bPFqarH7j+bYa0Xe6v2hllI
	61eQGrsfkc7Hnu5ixp8NNAOzNfK/a/BjtNQPWo49OkqYmEZEnqtfrHBWyHGhOGlNh07odxvuss8Ru
	TqQjN4g4V2ub7zl+tI2Mu6yIsYHRpVQEHWzqWA5xVoXp4RkrKfNh6Njdii14ggxExBKc6sMCkME6U
	PCkJs/e56LPD8GQ5Y6d+EsOaIO5aB6XbBpABd0HhWUeAVc0x1W9tgBlhnzBQZCJNCQqqP6VC3kJDF
	hIIXxK3A==;
Received: from mailnull by lake.multihost.cloud with spam-scanner (Exim 4.97.1)
	(envelope-from <admin@form.ru>)
	id 1s5yGQ-00000009G4h-3KfG
	for netdev@vger.kernel.org;
	Sun, 12 May 2024 04:44:34 +0300
X-ImunifyEmail-Filter-Info: UkNWRF9OT19UTFNfTEFTVCBIQVNfWF9QSFBfU0NSSVBUIE1J
	TUVfVU5
		LTk9XTiBCQVlFU19IQU0gQVJDX05BIElFX0ZPUkdFRF9GUk9NX0RPTU
		FJTiBNSU1FX1RSQUNFIEZST01fRVFfRU5WRlJPTSBWRVJJTE9DS19DQ
		iBGUk9NX0hBU19ETiBUT19ETl9OT05FIFJDUFRfQ09VTlRfT05FIElF
		X0ZPUkdFRF9NQUlMX0ZST01fRE9NQUlOIFRPX01BVENIX0VOVlJDUFR
		fQUxMIEhBU19YX1BPUyBSQ1ZEX0NPVU5UX09ORQ==
X-ImunifyEmail-Filter-Action: no action
X-ImunifyEmail-Filter-Score: 0.18
X-ImunifyEmail-Filter-Version: 3.5.13/202404301715
Received: from aqq16982 by lake.multihost.cloud with local (Exim 4.97.1)
	(envelope-from <admin@form.ru>)
	id 1s5yGQ-00000009G4F-2n2o
	for netdev@vger.kernel.org;
	Sun, 12 May 2024 04:44:34 +0300
To: netdev@vger.kernel.org
Subject: =?utf-8?Q?=D0=92=D1=8B_=D0=B7=D0=B0=D0=BF=D0=BE=D0=BB?=  =?utf-8?Q?=D0=BD=D0=B8=D0=BB=D0=B8_=D1=84=D0=BE=D1=80=D0=BC=D1=83?= "I promised." =?utf-8?Q?=D0=BD=D0=B0_=D1=81=D0=B0=D0=B9=D1=82=D0=B5?=  =?utf-8?Q?_=D0=93=D0=9A=D0=9E=D0=A3_=D0=9C=D0=BE=D1=81=D0=BA=D0=BE=D0=B2?=  =?utf-8?Q?=D1=81=D0=BA=D0=BE=D0=B9_=D0=BE=D0=B1=D0=BB?=  =?utf-8?Q?=D0=B0=D1=81=D1=82=D0=B8_=D0=B4=D0=BB=D1=8F_=D0=B4=D0=B5=D1=82?=  =?utf-8?Q?=D0=B5=D0=B9-=D1=81=D0=B8=D1=80=D0=BE=D1=82_=D0=B8_=D0=B4?=  =?utf-8?Q?=D0=B5=D1=82=D0=B5=D0=B9=2C_=D0=BE=D1=81?=  =?utf-8?Q?=D1=82=D0=B0=D0=B2=D1=88=D0=B8=D1=85=D1=81=D1=8F?=  =?utf-8?Q?_=D0=B1=D0=B5=D0=B7_=D0=BF=D0=BE=D0=BF=D0=B5=D1=87=D0=B5=D0=BD?=  =?utf-8?Q?=D0=B8=D1=8F_=D1=80=D0=BE=D0=B4=D0=B8=D1=82?=  =?utf-8?Q?=D0=B5=D0=BB=D0=B5=D0=B9=2C_=D1=81_=D0=BE=D0=B3=D1=80=D0=B0?=  =?utf-8?Q?=D0=BD=D0=B8=D1=87=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC?=  =?utf-8?Q?=D0=B8_=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6?=  =?utf-8?Q?=D0=BD=D0=BE=D1=81=D1=82=D1=8F=D0=BC=D0=B8_?=  =?utf-8?Q?=D0=B
 7=D0=B4=D0=BE=D1=80=D0=BE=D0=B2=D1=8C=D1=8F?=  =?utf-8?Q?_=C2=AB=D0=94=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D0=B5=C2=BB?=
X-PHP-Script: xn-----flcbhhaxmvucc4a0b.xn--p1ai/index.php for 154.47.21.190
X-PHP-Originating-Script: 1092:SimpleMailInvoker.php
Message-ID: <b1fa6185e0e73b4f43803fda4b4af93f@xn-----flcbhhaxmvucc4a0b.xn--p1ai>
Date: Sun, 12 May 2024 04:44:34 +0300
From: =?utf-8?Q?=D0=90=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=82?=
 =?utf-8?Q?=D1=80=D0=B0=D1=82=D0=BE=D1=80_=D1=81=D0=B0=D0=B9=D1=82=D0=B0_?=
 =?utf-8?Q?=D0=93=D0=9A=D0=9E=D0=A3_=D0=9C=D0=BE=D1=81?=
 =?utf-8?Q?=D0=BA=D0=BE=D0=B2=D1=81=D0=BA=D0=BE=D0=B9_?=
 =?utf-8?Q?=D0=BE=D0=B1=D0=BB=D0=B0=D1=81=D1=82=D0=B8_=D0=B4=D0=BB=D1=8F_?=
 =?utf-8?Q?=D0=B4=D0=B5=D1=82=D0=B5=D0=B9-=D1=81=D0=B8=D1=80=D0=BE=D1=82_?=
 =?utf-8?Q?=D0=B8_=D0=B4=D0=B5=D1=82=D0=B5=D0=B9=2C_=D0=BE=D1=81=D1=82?=
 =?utf-8?Q?=D0=B0=D0=B2=D1=88=D0=B8=D1=85=D1=81=D1=8F_=D0=B1=D0=B5=D0=B7_?=
 =?utf-8?Q?=D0=BF=D0=BE=D0=BF=D0=B5=D1=87=D0=B5=D0=BD=D0=B8?=
 =?utf-8?Q?=D1=8F_=D1=80=D0=BE=D0=B4=D0=B8=D1=82=D0=B5?=
 =?utf-8?Q?=D0=BB=D0=B5=D0=B9=2C_=D1=81_=D0=BE=D0=B3=D1=80=D0=B0=D0=BD?=
 =?utf-8?Q?=D0=B8=D1=87=D0=B5=D0=BD=D0=BD=D1=8B=D0=BC=D0=B8?=
 =?utf-8?Q?_=D0=B2=D0=BE=D0=B7=D0=BC=D0=BE=D0=B6=D0=BD?=
 =?utf-8?Q?=D0=BE=D1=81=D1=82=D1=8F=D0=BC=D0=B8_=D0=B7?=
 =?utf-8?Q?=D0=B4=D0=BE=D1=80=D0=BE=D0=B2=D1=8C=D1=8F_?=
 =?utf-8?Q?=C2=AB=D0=94=D0=BE=D0=B2=D0=B5=D1=80=D0=B8=D0=B5=C2=BB?=
 <admin@form.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - lake.multihost.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - form.ru
X-Get-Message-Sender-Via: lake.multihost.cloud: authenticated_id: aqq16982/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: lake.multihost.cloud: aqq16982
X-Source: 
X-Source-Args: 
X-Source-Dir: 

=D0=97=D0=B4=D1=80=D0=B0=D0=B2=D1=81=D1=82=D0=B2=D1=83=D0=B9=D1=82=D0=B5, A=
nonymous!

=D0=92=D1=8B =D0=B7=D0=B0=D0=BF=D0=BE=D0=BB=D0=BD=D0=B8=
=D0=BB=D0=B8 =D1=84=D0=BE=D1=80=D0=BC=D1=83 =D0=BD=D0=B0 =D0=BD=D0=B0=D1=
=88=D0=B5=D0=BC =D1=81=D0=B0=D0=B9=D1=82=D0=B5 =D0=B8 =D0=B2=D0=B2=D0=B5=
=D0=BB=D0=B8 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D1=8E=D1=89=D0=B8=D0=B5 =D0=
=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5:

Email: netdev@vger.kernel.org;
=D0=A2=D0=B5=D0=BC=D0=B0: I promised.;
=D0=98=D0=BC=D1=8F: <=D0=BD=D0=B5 =D0=B7=D0=B0=D0=BF=D0=BE=D0=BB=D0=BD=
=D0=B5=D0=BD=D0=BE>;
=D0=A1=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B5: Hi, this is Anna. I=
 am sending you my intimate photos as I promised. https://tinyurl.com/2apbj=
4zy#KuKaaa;

=D0=92 =D0=B1=D0=BB=D0=B8=D0=B6=D0=B0=D0=B9=D1=88=D0=B5=
=D0=B5 =D0=B2=D1=80=D0=B5=D0=BC=D1=8F =D0=B0=D0=B4=D0=BC=D0=B8=D0=BD=D0=
=B8=D1=81=D1=82=D1=80=D0=B0=D1=86=D0=B8=D1=8F =D1=80=D0=B0=D1=81=D1=81=
=D0=BC=D0=BE=D1=82=D1=80=D0=B8=D1=82 =D0=B2=D0=B0=D1=88=D1=83 =D0=B7=D0=
=B0=D1=8F=D0=B2=D0=BA=D1=83
--
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=
=D0=BD=D0=B8=D0=B5=D0=BC, =D0=90=D0=B4=D0=BC=D0=B8=D0=BD=D0=B8=D1=81=D1=
=82=D1=80=D0=B0=D1=86=D0=B8=D1=8F


