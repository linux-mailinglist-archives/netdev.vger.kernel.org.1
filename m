Return-Path: <netdev+bounces-127249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4FF974C08
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9DD1C20CD0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E777143889;
	Wed, 11 Sep 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="eyhqef2i"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE13B582
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041818; cv=none; b=EeBdelwS/vuHmLTQ6us3TkNs6fasXBLM5u1juvinkrF2yyG1jsCIhouEalMScGjBkyAMzaH9sXa9XwjwQuhybcZS4o7IYI+JT7e0dgvRP97lJwumsCjoOiCk1lhj2eO3hss6Ws4TQPn843PAQGzCHygzfSAqWGdeWdf3RpKctb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041818; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=mgJGJYwrJfrX2Zbye4lmiJCnZG4fHpq076XHp+WhPftwfolSBuVtp/YNnDeCparQsEVE/DdPzXCY9KoRukznpe3NZA/axhGzUNsMJKl/33q0uO7/nAeL+ueTh3u46YeujmqnXROPMCWroZD9SOcxSq/dCf7aPe6sj8KX0lxKK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=eyhqef2i; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 4694A25071; Wed, 11 Sep 2024 10:01:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1726041742;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=eyhqef2i+1WpMKvrFDFGH22Be5ni9MhzL7AB8c569nCOXHV9n8Gyd5uF9o0snIEJz
	 +/tfo2yzl0Jmlhpnc+wkYw1eHb+E287xLqQu7Juw+s0Q/3t/JH7sccO3p2jfVyVUE1
	 0tsH273BD46o3ZtuTg7Cn/fO6eN2y1JNmPfsuJ6I7YU3hXVIWe+C16Q2E3aG8G62ed
	 TevGd9SmAxBgOMqdpg77eBLiBVobe4QT5GgFOd6Xs3o4+aLXPqAE4CZzRyephG7mGF
	 tf/K/keqotMT5bNYjIgVZov5n9DE6WwmmHiRKreuYGLFVJeFEceAYZc+KMuxoRLnPk
	 GVByyowel57vQ==
Received: by mail.tradeharmony.pl for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:01:10 GMT
Message-ID: <20240911084500-0.1.8l.305gc.0.9jm8a6kz7x@tradeharmony.pl>
Date: Wed, 11 Sep 2024 08:01:10 GMT
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

