Return-Path: <netdev+bounces-183134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888C9A8B0F8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 08:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734677AEC12
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702A123C367;
	Wed, 16 Apr 2025 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtQWMM37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6D23BD10;
	Wed, 16 Apr 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785896; cv=none; b=Bp8vOTdSHcDY0RVa71Vw25BzDik0yIavZd8cq02JWoF3N+XrIb67AWOTk6YXhi2V4q6gZG7auVeEssBIY3ZcwaYbfcKZ0EbfKt9OePHEXrwPOiAbgQ0DyS0Y9IUgOHdYZiWkJZXrgTrZx8xFNhOWmIjAIXHGNolmdzlVFWcAqlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785896; c=relaxed/simple;
	bh=icwYmq64EY+NpKO6KGeOrpRAYg2WpXhDbAvCZwmaBb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITTnhS4oXcxcrMMmBTltHyNMCswikbhWKW+GsLmgmhDk/fgEVk7jWqrh8pKQImy2oQ7LUawANUkazcf1Ml6W94zmIq42eV5UcPVX9TFgPCoKMcVGYnQC7yxB07TzzlHIRyET+hVM6eLZyxEMluguHaJ/Wy0uUugLXMrf1Ul+qsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtQWMM37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2DBC4CEEC;
	Wed, 16 Apr 2025 06:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744785895;
	bh=icwYmq64EY+NpKO6KGeOrpRAYg2WpXhDbAvCZwmaBb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CtQWMM37lAjm+PdMWy9hh17aQKuyoADamxcTyqAOlbwpenEv8XMKltCtlgTqDvQLD
	 CeReGrbJGRZ0LvMCFIPHUZjghZV9lRJO6qQJUAbFoTWiber/HXZ4LVgPE+Raco6gCK
	 zmPaDgxmNzmlseeJ6wlFT9BAmjWzCEeGWq23WMXIE6E38dX79jMjS5OY+UUhSGt9I+
	 i/3vg7dWWf+UxDAltKKTUFXm2NTAYCPt9T17RlZHWyUgYRs+esVEv/RS2moY/cf8tD
	 ZLMK6kpl6j0Josk0uwKkXZOEyaaq984ASBRsKq/jbB/9oQ4qbXiaO4jODE7rp0/X/l
	 rYwh3Hp+YPQvg==
Date: Wed, 16 Apr 2025 14:44:36 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <20250416144436.2ae80791@sal.lan>
In-Reply-To: <87bjsxblac.fsf@trenco.lwn.net>
References: <871pu1193r.fsf@trenco.lwn.net>
	<Z_zYXAJcTD-c3xTe@black.fi.intel.com>
	<87mscibwm8.fsf@trenco.lwn.net>
	<Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
	<Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
	<87v7r5sw3a.fsf@intel.com>
	<Z_4WCDkAhfwF6WND@smile.fi.intel.com>
	<Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
	<20250415164014.575c0892@sal.lan>
	<Z_4sKaag1wZhME7B@smile.fi.intel.com>
	<Z_4sxCFvpqs7qmcN@smile.fi.intel.com>
	<20250415180631.180e9a9f@sal.lan>
	<87bjsxblac.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 15 Apr 2025 07:34:51 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > I'll try to craft a patch along the week to add
> > PYTHONDONTWRITEBYTECODE=1 to the places where kernel-doc
> > is called.  
> 
> This may really be all we need.  It will be interesting to do some
> build-time tests; I don't really see this as making much of a
> difference.

Just sent a patch meant to fix it.

Andy,

Please test.

Regards,
Mauro

