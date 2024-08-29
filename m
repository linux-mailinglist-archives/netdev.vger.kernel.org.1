Return-Path: <netdev+bounces-123158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC8963E36
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262682817DC
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5129E189B82;
	Thu, 29 Aug 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="jEc9aFLB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEB16C877
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919491; cv=none; b=GBRZYOc5d0S/6o4EP+VG+9Ob9eZtGjlucQuvc7l4+vLE2t4ygYd1TahJNCHUhmAtC2KTi2ZwdSCKgwHOI4TSZMAzXeqTbuhomjm9zAvK86CW7nsQ7TwN3HkcQ229eWUPtb0ME2aGaeBZfDObh8FKv+v/3GWPlU1mMl/E17MIixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919491; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=JnYTfQUNI47+1BJ9j4JXs3SmdsiAUYUgMHKBFi3mtJX9sJF2632sBFSTHnY9d8PVnmjgP40kmeef3W8wAaWs5TBISUgDSCgmzbjB4jXfpiZGkCKVBSWGEnKyJ2r72ZD2ad6Hsi3GLoK5LqwpoMrwtdv0dnjDnN4WKKUiA6NOhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=jEc9aFLB; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id B3CFA24698; Thu, 29 Aug 2024 10:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724919412;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=jEc9aFLBdvVWKYRauFKigX0mD4I3ryo9pQfvSMK08oIYi6NszjkecGTYqzoONP9oo
	 5NlKX+UkjVPaGnN0+9UXpzmu3ZnfEfWa+sQk3VeWEuJqUqD+oMzgPLszAdtJuyj4pi
	 GH7JpbvzBAAl3InfjXAKSBFwYhYCSD/qVsem/louFZCRKjpGeSHCk4ftP4S8pUpwqJ
	 O/EwiAisA2HgQgoC08V/WzzciIhtMTJFpWcpJyl7uRQ8VR8SKNciOb2rJUb0YQI97V
	 WvDdkmgDEYMKsYGu1tD2Y98NWxBkuNTmTBuHalksCCxvECjey3pW5fFagDrH1y0P+u
	 Mulftud58h1Tw==
Received: by mail.tradeharmony.pl for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 08:16:00 GMT
Message-ID: <20240829084500-0.1.8c.2yerq.0.r4px73go0p@tradeharmony.pl>
Date: Thu, 29 Aug 2024 08:16:00 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <netdev@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun

