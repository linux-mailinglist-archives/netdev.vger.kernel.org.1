Return-Path: <netdev+bounces-60724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C258214F3
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1BB1F2156A
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4621FCA59;
	Mon,  1 Jan 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sHQxvYRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7174C8F9
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bc09844f29so735850b6e.0
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704132884; x=1704737684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RbKb+Ssey02t/EjSEFx36sx2rnp4+NFSDQiVDQTJ2g=;
        b=sHQxvYRDfUWt2PQTe1Ex3obVPKvfT3N7G6cFZNgR/JpeF+aYtCNe4kJuyya8LbtlaV
         pgTwiCDQkmRrqlp4wqIH1wYc79EGWz/v/w2am5bgtPw+0dF+dNw2dp+pJ7uAvxCo/YKM
         opUGcPkwpY1pBmr79au0b9GdqeStDOKJIqe+vN/DC9OhrCgqMYfAw60kOub+WGzIC2nh
         xBIpKGWpcJezGypuLv2uAzAsLcI76C3t0iMeA3IJEOzBlUjJf6fDNmAXa61Jc7yZDg8h
         F3POfoyf3/8GWQYBRU57rObfkOl0+B7+GW6p6ubMwR5QMuzqfV5Xc89fmNVhgincNCLb
         2UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704132884; x=1704737684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RbKb+Ssey02t/EjSEFx36sx2rnp4+NFSDQiVDQTJ2g=;
        b=tgv+n3g1lWaUHUm8bomY+38f70Hi7xSDjanRsxPmH5vRE5apBs4r7P5TiTWyE8bAR6
         j/LtI3x2dDs1j6ca2I2rOngUwoAQsdeD1YHI9PcuZrIzO28VYiEv68CbsM7v46TRtIT1
         pEVPDx5WRZ2+JbxQ/9D6M/0zz0EZ5Enikqeq/frTyIKjFzb62TrCas+yb1o8CM91IgMK
         3U73UW6WKkNZKLCwqowAa+d0Jw9F3bOr3KbeJNWKf8p5FZAgDHEusSUAc44e+FyqetG7
         X1vwgYhG8YFITFabULQHQoCZqh8dvR1IcydDUmx9fcRB++R+jK8gM3gdLl2KgnB9w8DK
         PPnw==
X-Gm-Message-State: AOJu0Yzoc6h0lK/XJqpnKxpLsyGYsH3cQmMg+8d720icMymYPimoYxpt
	gPfqm2sAw69M4Q2LJL8GH7nL6CefgfeX5g==
X-Google-Smtp-Source: AGHT+IFGe/SVgUx8wqoEmP9kgAuUxnfl6a77Ua3dKecNfiDTHuUXFt0Eo0igJA3P8vcpyL+g3J40hQ==
X-Received: by 2002:a05:6808:23d2:b0:3bb:c394:fd52 with SMTP id bq18-20020a05680823d200b003bbc394fd52mr11468601oib.105.1704132883889;
        Mon, 01 Jan 2024 10:14:43 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b006da19433468sm7706526pff.61.2024.01.01.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:14:43 -0800 (PST)
Date: Mon, 1 Jan 2024 10:14:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Anjali Kulkarni
 <anjali.k.kulkarni@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] netlink: Move an assignment for the variable
 =?UTF-8?B?4oCcc2vigJ0=?= in __netlink_kernel_create()
Message-ID: <20240101101441.2af52a45@hermes.local>
In-Reply-To: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
	<223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec 2023 18:44:13 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 17:36:50 +0100
>=20
> Move one assignment for the variable =E2=80=9Csk=E2=80=9D closer to the p=
lace
> where this pointer is used.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NAK
Useless churn of source code.
If compiler will do this kind of optimization itself.

