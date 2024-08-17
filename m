Return-Path: <netdev+bounces-119409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA29557FD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 15:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF5E1C20D7B
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2E14C59A;
	Sat, 17 Aug 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="DsBJMzwE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpdh17-su.aruba.it (smtpdh17-su.aruba.it [62.149.155.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD431459F6
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723900539; cv=none; b=uIJmXGnwDYRCWfgb77IiAlaib9Z2WaX83mQvi1yhG6YXq+r0nCQ/uEJQ/2tKXjVCi/SrT2B7ehxYbtqxbVywNaP+nR948+4Y4+Fo+h6f04b8GfzUvSLMqf9v4t+i0evVbQtXmFLzOVAid6ioB/MveOFd+BCcKXr7BYDxxOKycPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723900539; c=relaxed/simple;
	bh=2F8nLXpu6utciwf73TEHErlUBn07rnVVcj0FX8O7uko=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QJ7Z4t5vq27xzJShnWHy7nciIo2jvzSn8JXZ7bva/65irkLkz2UShozWxM6/LtitEJ7YQR4bLjF17FE3dwvcG9EKcG87ht9oY5Kwfp8uSFsVzOgSquV31LGkeOKf0FGPuPlNUF8VMFQi24wSnIYj5BM77K2nvJcQD1R6PDwh5Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org; spf=pass smtp.mailfrom=xhero.org; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=DsBJMzwE; arc=none smtp.client-ip=62.149.155.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xhero.org
Received: from smtpclient.apple ([84.74.245.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id fJHIsuVgIJLbHfJHIsulm7; Sat, 17 Aug 2024 15:15:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1723900533; bh=2F8nLXpu6utciwf73TEHErlUBn07rnVVcj0FX8O7uko=;
	h=Content-Type:Mime-Version:Subject:From:Date:To;
	b=DsBJMzwEhUbJk9XnllJFQKQZh/t3xA3C8KAlVMv0kuRx9K0UQyVvqfm8b1TPP5nGX
	 lzk1munk+k9e0BOKKyLZNh4CzsUNwZgmDHzqecyPZ324J1a/QpfQ7/Y2g7shHUnC4z
	 jmItHJfpWbKfxi8Btjf0Hvi4ZShqackrI7A4rnV7cJ4t0AzB9C9XT4LhpLkR0QEQLw
	 ndinMmOk5mwyt58ZUznt+QBt6FhoML1Jfxi45phanBejoXw57I0n8aFhr6QkzFfIDh
	 UK6IBdfSP1C5GY03hMSCdCaTJzScJmg7AHGj3BTDjqZYBX+DAeplLeZDwmVOPw/ypI
	 aY8/Yba/lzZeg==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net-next 1/2] tty: Add N_TASHTALK line discipline for
 TashTalk Localtalk serial driver
From: Rodolfo Zitellini <rwz@xhero.org>
In-Reply-To: <2024081717-mating-uncle-6e4c@gregkh>
Date: Sat, 17 Aug 2024 15:15:21 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jiri Slaby <jirislaby@kernel.org>,
 netdev@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Doug Brown <doug@schmorgal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <245045A2-2B0A-4232-8B3E-8FB29F0167CA@xhero.org>
References: <20240817093258.9220-1-rwz@xhero.org>
 <2024081717-mating-uncle-6e4c@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CMAE-Envelope: MS4xfNOvGofd9QYNAgEfrGFmsPeg9WvA4gVEyadhY3I2Nssi18CulYFa+uawW5HRhqrqiqGIXpPoaN8GmFOF6+OqQCQj5fSHjEAj84QWGPXOZk0KxXOqm2zC
 qjgOkjaHAwq35PYVjJkZ+tmKtIVJ98gFes3oxZUlmDwB2uhBNhI2StOJHNrOG1aGcaLKts++026e6/K0k3zI/f46gd2qL2A84hsnUi/ow7NP0haEVIqppQev
 Zz+WJBMDGuJUiZiAWO8vFCt390m0FruvgC+XID0EJsXaQNbIcLb84pRlKMkCwoyrGJosQM/jykIvpeK3xYwUW6XRQ7vYI/LW0DoqNz7wgdeaXGIp+npg+wTd
 xMw47wUWMWhPfTKu5Li34NGJ7UMZY9fqviEno0Ovb3eXGII9ZOJGjMIc3egRTKPWMQ8BIpEgCqDO4U4/dJILntbBJIxyrS0+UaFfNchjaXG5PJo0Xr5IcbBF
 z+iEb48f7MVQB7Hbn38J9xWa61t2X6YVb0DQjeOB2U0YH0DZczGWWu3O7ZsSfg2ecIWo4FJ4R4i/aMz621Tw8JY6flOK3iqcawh0hw==

> Please look at the kernel documentation for best how to write =
changelog
> texts.  This needs a bit of work.

Hi Greg,
thanks for your review! I will absolutely improve the commit messages on =
both patches in the next version of the series.

Kind Regards,
Rodolfo=

