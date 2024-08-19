Return-Path: <netdev+bounces-119604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B99956501
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E895281FA5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A313BC1E;
	Mon, 19 Aug 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="gEOCp2ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284D12C52E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053908; cv=none; b=nUnA1BsH5cF8PqhiVxdTtBu7GRePgwEribe4CBWg8jP/ngffpT59Mxd59FM3UGmE8X/MzfCnk7Z8wji+A5s9sC9o9+vDQi0R5ZMUkIyqI8nJPNtSHOomHQ1csFn5XuBroww/EeHZfb4Aa0BMz+i5KQJPfDAwKmQNnFg2wdwzz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053908; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=eaatszYCeNHhI/WGyIG5zFTKgrK7AcLA57Tfw5UGJCAPbyfNjN1QE8BV+FhdYLdXN/DswDuTQvZRUw5TAIQPFFI5a49MqPv2ftjomSUFkgQtvZxXC88n0iVrUiw8SX4bgI0B3jAq53TyXXg2WZIs8fMzqIqeSXdmMXvW5DN2LAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=gEOCp2ka; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id CF44022969; Mon, 19 Aug 2024 09:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724053896;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=gEOCp2kariBzu8v9SloXV9jrTGw20TVMrWfX7qlCadtCHeGuFYibzmdrDb91VZ1+s
	 HqGEiEBuwlDMvaeijPrFNEQUT9bPWbAo33/mpEaPUyPlt5KDeNVCXBoeGJPR7YDyHE
	 H4zvg3R/UGqh2v12ElvKMUEFn+LUO9h6rL9NMIIjxVm9a55RKB25dtCfmXz+CUWZoe
	 +YYFSM0X4C6NI9qCyN2T1anjG/0SoocYczmwo80kyc7NDvSLpnx2sGQ9M/RhDp0BJm
	 gKNy5efjAd6fhebkVFKqcxz+j+EYCaaCougE5V5ePLisPkQL/Kr+gwQqxnomBklGEs
	 00Ew/ebQFvz9A==
Received: by mail.tradeharmony.pl for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:50:58 GMT
Message-ID: <20240819084500-0.1.84.2t9e7.0.e160nkoai7@tradeharmony.pl>
Date: Mon, 19 Aug 2024 07:50:58 GMT
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

