Return-Path: <netdev+bounces-195820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C857AD259B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E753B15D9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD0B1B425C;
	Mon,  9 Jun 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Y9CMZLa2"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE311FAA;
	Mon,  9 Jun 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749493813; cv=none; b=fQpqx4gvKdJ9MevLjNt/jui4z8C/lqoS/lhT4qC9T/SDoHnwAogDF4CdUaZuqXhZGq0KsOpSMlA+vEyBfeK3ww/T6n0kk7V+h1vuHeI+erMwpGZuhxeac3mFT+X5gmA6lup7o8nyds0KA/WClssOiiVfxwn6+jcF++EZ+WjpB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749493813; c=relaxed/simple;
	bh=kjW3bXWtT9KddxypLMRSdi906UpsccRqwwYpDQtcvUo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/9dHvXNZk08Bt4GmKNLI7S6BKloY38j/A4277f4KbQ65pSvAYdGZ3KPYnAiVr17h3cEu87+s7rtBZK3dTUACyzguNDEXetrctALAAvXlcOYtB1V0esvlXNHEUIqJOwYJHcyNHbN8ng6wb3JQh0q6fnCiD06QtCOg5Y2Bcj96k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Y9CMZLa2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8A51F41AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749493808; bh=XYGYRkyG9IlI4ZNS524wiPaT2tN2DQXtYfqupXo9Sms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y9CMZLa294WgXKldnbrEh35bU4APnaG7nk+M8zmqx425Okivh2L2eg/21Yb85JUOs
	 fLbXebU2jcIhWoZNGYXoIAGCJyiRrZXr7ysc5nyYV9EbfBWEzU44NniApGEYi0G1vm
	 C3xYeE1f8lRiNgS/SsghKA2EycbugpwFPj7eYsPnZiX/YkCID4YO2sQohuVk86H9bY
	 zERaN2ovvWVCpN1vfTr859JZgVDAJV+El7rghnoo1EuUZBbsMU1vRAw/HNGuP4QyDY
	 SY8LSDGvmBamXubCVvYbDqS3z0McmJeWzVKji5xGp7ai47MJGWLOo5nX3CJofxUZoz
	 gV3U0iRK+63JQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8A51F41AA1;
	Mon,  9 Jun 2025 18:30:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Collin Funk <collin.funk1@gmail.com>, olteanv@gmail.com
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>
Subject: Re: [PATCH] docs: packing: Fix a typo in example code.
In-Reply-To: <e532b992a79999d3405a363db4b2bd4504fed592.1749434907.git.collin.funk1@gmail.com>
References: <e532b992a79999d3405a363db4b2bd4504fed592.1749434907.git.collin.funk1@gmail.com>
Date: Mon, 09 Jun 2025 12:30:07 -0600
Message-ID: <87jz5kbweo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Fix misspelling of "typedef".
>
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  Documentation/core-api/packing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
> index 0ce2078c8e13..f68f1e08fef9 100644
> --- a/Documentation/core-api/packing.rst
> +++ b/Documentation/core-api/packing.rst
> @@ -319,7 +319,7 @@ Here is an example of how to use the fields APIs:
>  
>     #define SIZE 13
>  
> -   typdef struct __packed { u8 buf[SIZE]; } packed_buf_t;
> +   typedef struct __packed { u8 buf[SIZE]; } packed_buf_t;
>  

Applied, thanks.

jon

