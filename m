Return-Path: <netdev+bounces-182817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F65A89F89
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2417614B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7050450EE;
	Tue, 15 Apr 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DDoY3gID"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A4A25771;
	Tue, 15 Apr 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724094; cv=none; b=kKAGQi6xyWSUYWnSnTtW3yRWge/HN+Dz43l1VEDybOMNma7Pzw2DEQbuk0IYHkNgrKJ3Ia0vRnn7Vvtg5QGH53PhN0l1kfQtilALh5F/cfXIelCrifxyFXma7/iiH7LevsNEX98ZEqUN06NA/fi8CyQxbSG+Tv6FnecIoX3GdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724094; c=relaxed/simple;
	bh=ZbvVGnkFnCTdW8MWHN32kqUIqhHk59XjTd85RXWZa7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kO8rRTZmRBKhgTvn0ZLh5dfBblaWbWHpv2sWp28EYMz9dz+2w93bzhlFhI+PWmqDvop6WCF9GOnARcy6uKvo05tJL8ioxjQ9D+DEDeZo8XOx78lGnSq5UC9TAheK+fVzqzByZyXbOCol1wUIUNYsAfMNSN3wQDZBMpE+YikRHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DDoY3gID; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ED3CE41086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744724092; bh=qq2xMJBZXzE4K+QY6hdl58GPqersIi74JVHAVzQ7s9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DDoY3gIDfJxPZpUxEk7czh4g4VPoH6KuBIk8B0Ubx62VEFY9V5X7ZIu49/Owiz12G
	 7FUD59tpDgpWxTZHHzfRKYxzn49Gbm3g0LsnA+P60ctkx5SmjOeMxHWH2rWsIuNtKl
	 SDow1+t2psIiOdAe7lt7SB18VPmJof+j5kN4w/SsITMRsIqmAfP543rPYuVjt7ObEG
	 m+gYUfigYs2gKi298yRmgWP3kunGSNkP4PgFqnR5jfJWvg6g8BCC89QWlaEgzEx84z
	 /ZMGQJYP/V/FGuyBXwL4HFQOkV8F2N3aXjoj0AWJHPrnthbA1R3DUqX1x0HUDg1G4F
	 BdZrDoZQnrL+w==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ED3CE41086;
	Tue, 15 Apr 2025 13:34:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <20250415180631.180e9a9f@sal.lan>
References: <871pu1193r.fsf@trenco.lwn.net>
 <Z_zYXAJcTD-c3xTe@black.fi.intel.com> <87mscibwm8.fsf@trenco.lwn.net>
 <Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
 <Z_4E0y07kUdgrGQZ@smile.fi.intel.com> <87v7r5sw3a.fsf@intel.com>
 <Z_4WCDkAhfwF6WND@smile.fi.intel.com>
 <Z_4Wjv0hmORIwC_Z@smile.fi.intel.com> <20250415164014.575c0892@sal.lan>
 <Z_4sKaag1wZhME7B@smile.fi.intel.com>
 <Z_4sxCFvpqs7qmcN@smile.fi.intel.com> <20250415180631.180e9a9f@sal.lan>
Date: Tue, 15 Apr 2025 07:34:51 -0600
Message-ID: <87bjsxblac.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> I'll try to craft a patch along the week to add
> PYTHONDONTWRITEBYTECODE=1 to the places where kernel-doc
> is called.

This may really be all we need.  It will be interesting to do some
build-time tests; I don't really see this as making much of a
difference.

Thanks,

jon

