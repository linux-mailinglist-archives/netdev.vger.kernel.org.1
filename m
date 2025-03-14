Return-Path: <netdev+bounces-174878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECA9A611C2
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780873BDB65
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3041FE44E;
	Fri, 14 Mar 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="a2HHrqmX"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CB1C878E
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956682; cv=none; b=luN7nxtWXMwA0XhrrDH8xhjvx4cHDAGk7Ggxcr1N4RIQnrw1wWtWyPTvrHdAOrMn5ZyJjBBRdXHAaddLyts8n+EL1EzJzZBlZ9QkwjhUhhLzOBz9ZPJDijgA/2J8cD6MR/PqTrDXHjMvXg87Llr3UXwYLkJlQKjjXvRI5djZEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956682; c=relaxed/simple;
	bh=CTn54sAh9B+sBGi+h+DHLKJSH4WfH9yAl61uwCEzPNI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXN/mRtArPxFMpNHSXSKQwAu4pOhTBA3tL98W6U2CMF3SIyUtGCGONMEmzV6xXuVzISEUITC6/bmQZ4TvkrT9NQypKlrbU25bN43H1P/Kiacqn8Vvs4hVg5+cSB/O5ZxMuR+DDS2K4YEpXr/IiryY63ANKTZsSbKO+Y/V/LqF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=a2HHrqmX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1741956672;
	bh=CTn54sAh9B+sBGi+h+DHLKJSH4WfH9yAl61uwCEzPNI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=a2HHrqmXPzkVB3lTm3wyCuIsBK36szC2eIA8zwUJgdmnJRxdtGVtXaY3VbK5mdo14
	 kTiVr3C8tI7qvvOEwKopwKNIuF1yXjLVy/Tglpawd0sxjNgX+OWBsZHLeV+w45/6K2
	 g3JWeyNf7WqDn1hYWDifTMnEwrEgi8+9VpHD7LrkwmFjl6uK/n6Zvw83B7Yi/tiB0d
	 RgDjlAcYLTRAuctyp++M5EYfA246WxIPlKlDLf+2ba7iy9Q+jZbA3E4jmK+A2yiNMJ
	 vFRhdTItbjqLC1eqntc0s88e3QEJn8Hwrda2wblQCHPnW4iTh9TzJCgSERPdhFki0x
	 KhmAlWVuji1KA==
Received: from [10.103.165.192] (unknown [1.145.50.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1134A7941C;
	Fri, 14 Mar 2025 20:51:09 +0800 (AWST)
Message-ID: <47993ccfe45deac346e9243bb35e7aac0ab704fc.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: Remove unnecessary cast in mctp_cb
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Herbert Xu <herbert@gondor.apana.org.au>, Matt Johnston
	 <matt@codeconstruct.com.au>, netdev@vger.kernel.org
Date: Fri, 14 Mar 2025 13:51:05 +0100
In-Reply-To: <Z9PwOQeBSYlgZlHq@gondor.apana.org.au>
References: <Z9PwOQeBSYlgZlHq@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herbert,

> The void * cast in mctp_cb is unnecessary as it's already been done
> at the start of the function.

Thanks for the change, all looks good to me, and now we're consistent
with __mctp_cb() above.

Acked-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy

