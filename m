Return-Path: <netdev+bounces-224510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0BB85C54
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5019E585EA7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6830F942;
	Thu, 18 Sep 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETy5Jc+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348553128D0
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210333; cv=none; b=sl4pbYzyW+bKn1Sy0ocwN0/PFk323k2e/4CbEGfnJmj5BIjsbczZl/Zvezh+/jzojR8YAxVaCNlDGaCwmYEoUS+biMhoiZ2pIwkxGeUH2Qipy9Hv54Ro0EQ3RaATiqsAMH6i8zE3mDT8Lsz27E6K/umL4Tst6F6VbA/KJULxQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210333; c=relaxed/simple;
	bh=k+o8V00UY3Lwb7Hv9K2ILNjTEYBIduaH7WclFbLmI/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqLHr8tOOhXWYXpnbNjEgwQItYgQC7cEKUSP8jJky9c/k4ijpTkrvdZDeihJ6BGOk5bA2RZmcyYAtt/YSuFyeY1M32X+0BOKMALJ3iPqhuoJnTKWF45Jm0JdszEG/cOgDpLtVDP12TQdaSlVPudzR2JRuBaQOF2ljqac1qxL+s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETy5Jc+v; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9961E4E40D46
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:45:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC64606A8;
	Thu, 18 Sep 2025 15:45:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92F3B102F1D23;
	Thu, 18 Sep 2025 17:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758210328; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=35NWme8b8OsSS57EP8m0LCDhn1NlHjtCzKoRiR++ww0=;
	b=ETy5Jc+vPFhYB1IR+xry7jt713akS1jNAYJ4Q5jWaFSaFm3HIdE7uQX1T9lvVkJUcEfD3G
	WsvP8dUjmFo5pR/CZBkugRuTYaFP+jZPiqaSaT/HABYJjq5rv7BVDLr4obKpjq/gmHZti9
	T/Fy+glML484Utf3XFN9dd0Zfb5bSb79ujPGgnY/YSpox73bBSgSnQR+XlnLNspvSLYeYX
	BXc2QIS8lJ821zgbO80FBLKd9a2H/NlJj5yy2iIjsINNmDUeiFWRC+UDsCi3jgjekLaVDC
	0WWlky9UZ/j6taJZeBjJPR210pwf2j3uR2l2Zt235JnqI/7cufuLfltms5PPhg==
Date: Thu, 18 Sep 2025 17:45:22 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: wan: framer: Add version sysfs
 attribute for the Lantiq PEF2256 framer
Message-ID: <20250918174522.5f34615b@bootlin.com>
In-Reply-To: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
References: <2e01f4ed00d0c1475863ffa30bdc2503f330b688.1758089951.git.christophe.leroy@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Christophe,

On Wed, 17 Sep 2025 08:24:01 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2:
> - Make DEVICE_ATTR_RO(version) static
> - Split version_show() prototype into 2 lines to remain under 80 chars
> 
> v1: https://lore.kernel.org/all/f9aaa89946f1417dc0a5e852702410453e816dbc.1757754689.git.christophe.leroy@csgroup.eu/
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

This patch add a new entry in sysfs.

Can you provide the related documentation in /Documentation/ABI/testing/

Best regards,
Hervé

