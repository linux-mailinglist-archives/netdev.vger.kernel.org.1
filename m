Return-Path: <netdev+bounces-62162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87375825F7E
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 13:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DF4282DB2
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 12:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5595C7475;
	Sat,  6 Jan 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="lI+DCxnt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399987460
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eafc5b39eso88801e87.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1704544873; x=1705149673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LKyU4sMRsN2Mz2SouvrXP62Yh6z2LtEYbZQG+005M4=;
        b=lI+DCxntBTW2ScklRB5xJdTGAs448T+RT7Rp01LmjNTO26N7XqRtkVfoD7m/Jq/kBl
         PLLTcp86MsyY6JPMrdJuo0nXfmjp0Fd/+rs/+kEaTEWSiFLoE9N1Hyu+CST5WCEpFnVT
         F9AtxXwISMdy7yTqpdICDE03uyVgjp48YdN6zeeE0wxmx0/bnP9Gk9qenLRR5rOLG5e0
         D5VGW8wZklru9t88mvcAIN2XRWyqkTBwAhJDad7fZfVgfKYpZtzhBXxKByzQSpQuqJZK
         Ke1kXcp0l0yLi/jSww1tabkgMBJ0DnAlvOkCMyqxnrudp9Qn5YqQ2RUcnPD8EBSjGLot
         CTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704544873; x=1705149673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LKyU4sMRsN2Mz2SouvrXP62Yh6z2LtEYbZQG+005M4=;
        b=MGxUpbKvx6Sxbqv79QnVObgfUH3kbd+23mkUoZzMLZGVqwmzbnBSI2yqr6aZ4vCjpi
         3qCuKc3iyBCHm2XAQp/zeLaZrVd0KClP2qDv9exwd2jQhnnDoG1T8rjMPl50mM6kDU1p
         d0xMxM3gZ7B2SdlWUvFUguE26jnrJ//gOqqKA3aDJbKT35yFoa4K9FqmPvGbX9KsK9YD
         1DYfGsYwVvYBIb89Rt394rlwtgQIUxGiIVHotJbNlrEyl84ObTtWQeX6D6ZgW1cV/9MO
         IXkSJV88tTPcHiXmVe07llCajI8+1D4uL04jnT0th5miwqUqmZoC4nP/a8d0KdVP2e9T
         5YWw==
X-Gm-Message-State: AOJu0YzuI8lM9mQ9YKVRZtxuhitY5GspVe1pdiZCEP5gryb8fNIpvEgN
	JFybQoC9wFdorlDRNgn03GM4mKvhSxg0Dtg3tDcl9QvTU8OdnrY0Li7+5qY8jyY=
X-Google-Smtp-Source: AGHT+IF1LgYWoMqtkgOIQdJp1Rficg1tsMi8hpXCufrZfg6nG+0FcbDIr7YLKyDnamKDCY+1lhinphL8zw15duD9wag=
X-Received: by 2002:a05:6512:1318:b0:50e:7fb1:6456 with SMTP id
 x24-20020a056512131800b0050e7fb16456mr922742lfu.4.1704544872698; Sat, 06 Jan
 2024 04:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com> <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com> <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
 <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com> <ZZRct1o21NIKbYX1@shell.armlinux.org.uk>
In-Reply-To: <ZZRct1o21NIKbYX1@shell.armlinux.org.uk>
From: Ezra Buehler <ezra@easyb.ch>
Date: Sat, 6 Jan 2024 13:41:01 +0100
Message-ID: <CAM1KZS=2Drnhx8SKcAbRniGhvy0d85FfKHOgK7MZxNWM7EAEmQ@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:58=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Any ideas why the scan is taking so long?
>
> For each PHY address (of which there are 32) we scan each MMD between
> 1 and 31 inclusive. We attempt to read the devices-in-package
> registers. That means 32 * 32 * 2 calls to the mdiobus_c45_read(),
> which is 2048 calls. Each is two MDIO transactions on the bus, so
> that's 4096. Each is 64 bits long including preamble, and at 2.5MHz
> (the "old" maximum) it should take about 100ms to scan the each
> MMD on each PHY address to determine whether a device is present.
>
> I'm guessing the MDIO driver you are using is probably using a software
> timeout which is extending the latency of each bus frame considerably.
> Maybe that is where one should be looking if the timing is not
> acceptable?

When profiling with ftrace, I see that executing macb_mdio_read_c45()
takes about 20ms. The function calls macb_mdio_wait_for_idle() 3 times,
where the latter 2 invocations take about 10ms each. The
macb_mdio_wait_for_idle() function invokes the read_poll_timeout() macro
with a timeout of 1 second, which we obviously do not hit.

To me it looks like we are simply waiting for the hardware to perform
the transaction, i.e. write out the address and read the register (which
is read as 0xFFFF).

I've checked the MDIO clock, it is at 2MHz.

So, any suggestions for what to look into next?

