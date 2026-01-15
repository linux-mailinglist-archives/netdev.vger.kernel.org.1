Return-Path: <netdev+bounces-250158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4ED2460B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B847300DDAC
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AB38B7C3;
	Thu, 15 Jan 2026 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Evw17v6+"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AC38A715
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478646; cv=none; b=qOg0Fz2F+RoPzN76ot9rq1+vFpW1MKZYmT3MhZgwB6oQio/rErOl2fImc7f4TBj8Hj0s8saNN1NsmAnnDclCttzD7clcRnR7D0Pa3GEeUQZHfgP31GmsR2yXsh1/YmQFh2KtFn8vymcvxdBFh7HGbfVneFSFEJG86vF08htAG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478646; c=relaxed/simple;
	bh=R898Fc6ssxGySTgRvGTHHkzt8kV+bIH/zb/QW2d12DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzpH1XU8UPoeqi4IZuhhgjrSi9PTXCs7p2rH+qI1ZOxW/rC9X6vzFA+G6+g7vHcW6mCNvOdaGbOZjMWEygiKGdp0qCIx4RGSK4f6+d+FQ2v3gOJtmQ2B4uNkgH0yG1p7sy3wQbU5FaHm0sSbYRDLc3bmHOQOXdcPt6v2i/S3iWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Evw17v6+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 928E64E420F3;
	Thu, 15 Jan 2026 12:04:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5AF53606B6;
	Thu, 15 Jan 2026 12:04:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BC9110B685CF;
	Thu, 15 Jan 2026 13:03:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768478641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R898Fc6ssxGySTgRvGTHHkzt8kV+bIH/zb/QW2d12DA=;
	b=Evw17v6+w0HucnDY1c9V8xVI0X1QSVLep7FBlQBayXYLO+zkJnkNT2qFFlI9ZKtZD847eS
	eq3FJowVvqZ3gqxjtHut1QomBG5kjGp3K03gkxrxzXGGmiAXd3x++2dKjvkABWa0hLpTT2
	TQPrMMT6nQeQIseTlVt5X0o3Y+L0jqqDC6rDOdADzv4Sg3QcVtadKl9mcFGRgKVUYSGSVn
	WKHwY7DlpEYhUyKJ7a3Lz0HZZLmo+UwoaHeWm7KVKUBsJVwg0LYYNhCQNeYfE2fJRRXgnD
	RVOqklEpvnIlX/m+oYf05DrsV2PhjGfeduRXK8uYtgbvf+UmE90Knm3MDobXng==
Date: Thu, 15 Jan 2026 13:03:58 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: extend HW timestamp
 test with ioctl
Message-ID: <20260115130358.35cf193b@kmaincent-XPS-13-7390>
In-Reply-To: <20260114224414.1225788-2-vadim.fedorenko@linux.dev>
References: <20260114224414.1225788-1-vadim.fedorenko@linux.dev>
	<20260114224414.1225788-2-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 14 Jan 2026 22:44:14 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Extend HW timestamp tests to check that ioctl interface is not broken
> and configuration setups and requests are equal to netlink interface.

I am not a python expert but it seems ok to me.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

