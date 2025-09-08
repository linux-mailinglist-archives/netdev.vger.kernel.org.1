Return-Path: <netdev+bounces-220693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702AB481F4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 03:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CC17C578
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DD19E83C;
	Mon,  8 Sep 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HWsG69qh"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7915E97
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294412; cv=none; b=B8pW9aaDybAV0jjd+0VjbC2XwDc4seO7XqAtK3WUKuZd3njSlxHjpk7ptGGLycRfJ8Xe/FDkwUHE3UIiDckp0o4QlOtjlMFGokf7k8x2kenmgwSanTq1wfoxzldWfX0hifNJqoYFf5hmzOeodvTArNssQX0CzesJi43QkljUmqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294412; c=relaxed/simple;
	bh=j9LSY2yilz+FFrAMt9G342OrkesKrDZJkr7I48yUhII=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUU7j2EAaeIeVkL6S0pe4ywlAIBk1EGxdw7hHQo1ORqtJmvKp/rsJXSYUGZQE55nVng04cTQBVvtHbVhGN9ZLx4HDLqvGezyFAI7WNWz+1WZ2ildYS/+1dCFgutJB5rPe9YSbLUyZ8aqckfbs3m/hxmRl5DbX0/sbWa34O8ahpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HWsG69qh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757294402;
	bh=j9LSY2yilz+FFrAMt9G342OrkesKrDZJkr7I48yUhII=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=HWsG69qhOHIcsJVRoKZNgeVuZ+jrgxEFUyj/mgvX1N+rebIPDWDeC3xX6MjnV3Zaj
	 h+xmruixLDq4X4UYJtheRV7jESCssN8o32oLc+a3K3qHgyaSlvwVhw+Gx+L2P4Ie3n
	 N6l/8rRMJ1d01oEG6a8Dh8P9rNhHGEFX4eo9D1guoCbgXBLxALDFec5lNq6nOaWbK0
	 YjOWR5FOOolDH/p7k1phzBvJgKTJ5n54mqHD7nrjxkXIUDdfOPt2BBwapeUTP8HhHi
	 LF/raw7bc43bKDK2EAtfWW8Jqyk4q051WvwNfFdKjb6sqHbKXoZVJ7TiVjLXzFzpAF
	 F+L6ofUiHtVCA==
Received: from [192.168.72.160] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6EB46472E;
	Mon,  8 Sep 2025 09:20:00 +0800 (AWST)
Message-ID: <9529c4d417636e87691ef815e7055fe5346c4926.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: fix typo in comment
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, matt@codeconstruct.com.au, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, netdev@vger.kernel.org
Date: Mon, 08 Sep 2025 09:20:00 +0800
In-Reply-To: <20250905165006.3032472-1-alok.a.tiwari@oracle.com>
References: <20250905165006.3032472-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alok,

> Correct a typo in af_mctp.c: "fist" -> "first".

Thanks.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

