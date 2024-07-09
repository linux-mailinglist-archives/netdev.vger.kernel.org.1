Return-Path: <netdev+bounces-110234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FF92B90B
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E61F21961
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1C15884F;
	Tue,  9 Jul 2024 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LIKGE4tF"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802A15886A;
	Tue,  9 Jul 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720526899; cv=none; b=BQojMKzRYOcEgraj4PbFjw0XATABMUGfdGJTHnqqE+TWpsZW6sODseWTWseqvwT2jkr85lPMicuVi2ESni5O78FU6uoEzmjiP6u4o+E1FwtWqs2Yoex3lOTOtrVblQ7LjnfA/XXfdCRLbHRvJIQh7fNf27LsQIb7hODQmT6/3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720526899; c=relaxed/simple;
	bh=oxaphqpgEx9AmGOodXCHMkOcJSPdgXWVzjz6l3l9tcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBusICvFKsy5iRfTkT7Kik0rATC6QZ3EHqzNcGWm4K04muiQUsNZnqxWq+TMSSetBmaJfjxvXh4xHHr4W5gznBqrtUwJWAKrCvtPqH2SnU9UNEDvkFKzW1jH1KqGXMm20kFZ3RNzYEitTdBvGIl5GTbFn41cH0yqUocteTevs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LIKGE4tF; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21C93FF803;
	Tue,  9 Jul 2024 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720526894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hU+BySU2VB/ceKlWYx7QcuT5snlHgAgUbCdsH9jfQXA=;
	b=LIKGE4tFCBLpGZFuJnG9SZHpxcY2VyUxAmSjRaxuWpyZxLLRb5lzGUGWOPTjACenUNov4N
	OT8mGKNyDt3ozTojD4oDC0944/lYnknVhI+kI6CLBb8vhKM71MrNTyvBbZMLNpZ2VZE8j1
	JsjMWnIu3hSTDIP1TYfzdgrVR4k8ufbW80ScMT+6x3nfsVNmkd/gvJYtkuRbRcHNTDtzZk
	yYwCdgNZcnJ2Ie6322eWFVQwzJ+dzS/64KWSLKMzJPmNFnmaNczg1dOb0c6xAooYIJ7NWm
	YjfgXiQW+HucBfF1NGQMhEmSQI5uygOkqFBjxzkPvKScfzajhDu/3fvc9rXzPw==
Date: Tue, 9 Jul 2024 14:08:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: pse-pd: pd692x0: Fix spelling mistake
 "availables" -> "available"
Message-ID: <20240709140813.684beb28@kmaincent-XPS-13-7390>
In-Reply-To: <20240709105222.168306-1-colin.i.king@gmail.com>
References: <20240709105222.168306-1-colin.i.king@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue,  9 Jul 2024 11:52:22 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a dev_err message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Kory Maincent <Kory.maincent@bootlin.com>

--
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

