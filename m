Return-Path: <netdev+bounces-61008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC2822267
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25E7B20D34
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831316401;
	Tue,  2 Jan 2024 20:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="tpPwRgS5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758616402
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-554fb402e90so2157107a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1704225928; x=1704830728; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Nhz6RlobMyXm2p8HC/XiQYrJXlcpJ9PEXDYL16glxE=;
        b=tpPwRgS5tlYtG2odFQbC2deGdgIn9J5PPcpHL9x8p+DCDnFoh05LP8NnOZPALdUI26
         jvOcxaSBqLRvwCydc9qve+CaVCyKYv0JaFTf3fqySyc9S+9o6DeeO/M8yf7/xr8LFVAY
         7cHOuqUjnjpwKZg2+7AWkKep6OfXzpRrSUdlY8IMr+hDFBoEXvzx+6t4w+uXH2rGWTnc
         Hg8OgnF8H1+zGKOIBhZLQiIroRIiHqJo64kGdfmYjJ2IPQMd2FVUG7CtyNGVTlNRNbDX
         yyA8iKz6xxq64RtBseZ7xNad767HDZh7xpWhJGidz4MHFYMI5NDmf1HGg3B9oo/Myqkk
         XS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225928; x=1704830728;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Nhz6RlobMyXm2p8HC/XiQYrJXlcpJ9PEXDYL16glxE=;
        b=nC0tQBCrJb2/jcqdJGrjfyeN6iTHLel9hiwlzTiYQQiN/VgrQnYQ1RTlHRxTzdSDRF
         n7B99wV/hEFTuTftO0lkPY7aynBt1oqTD8s5VT+eZnQmnd0TRY4GjC5eLi96d8AIfPPq
         bFYnNaJMzqYZhw8lajn/vmhl20JtBdv1aU7aPi8C9wNQzvcxoR2G6qzYH4WMc47p6COe
         zQAtK9BSeqXEnmUD1AYsTixSOtJ6DFwdqHCpCn7PE5kB04JOX/Nt/01jyYbX/jfM32fR
         bqO21zlkNJQAS59zK+FlQZQJQg83RWGx0laTP0CFlnzpJzldqOiLmKWB8j/KcpASvk6O
         CFpQ==
X-Gm-Message-State: AOJu0YzRDuKIglOUMD8Z2/g9EOY15gjANpciGmPPqUkV4moQUXs4Bjsr
	LZyk0tWdlUFgTVNhuyVmsMKcWN0wTe6TFb9qVUjJ8NhTUHjX3w==
X-Google-Smtp-Source: AGHT+IH4XLs2TbiIQg//LUDPjx9eNvlPaPuQ5cO/M2sLJ71ZNuZ0haSRXE9Pu4FLk34sgcx5DFE+Eg==
X-Received: by 2002:a50:d74f:0:b0:553:2037:92e2 with SMTP id i15-20020a50d74f000000b00553203792e2mr20973359edj.0.1704225928453;
        Tue, 02 Jan 2024 12:05:28 -0800 (PST)
Received: from smtpclient.apple ([2a02:aa13:127d:8700:d168:a5e4:b9a7:12ee])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056402530600b0054db440489fsm16019951edb.60.2024.01.02.12.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 12:05:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ezra Buehler <ezra@easyb.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Date: Tue, 2 Jan 2024 21:05:17 +0100
Message-Id: <720C5B4D-6C26-48AC-97D0-9D3729E72DB3@easyb.ch>
References: <7e0d6081-f777-4f40-b0be-a12171f772f4@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
In-Reply-To: <7e0d6081-f777-4f40-b0be-a12171f772f4@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (20D67)

> On 2 Jan 2024, at 20:49, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
>> By skimming over some datasheets for similar SMSC/Microchip PHYs, I
>> could not find any evidence that they support Clause 45 scanning
>> (other than not responding).
>=20
> Do you find any reference to Clause 22 scanning being supported in the
> datasheets?

E.g. the one for the LAN8720A actually states:

This interface supports registers 0 through 6 as required by Clause 22 of th=
e 802.3 standard, as well as =E2=80=9Cvendor- specific=E2=80=9D registers 16=
 to 31 allowed by the specification. Non-supported registers (such as 7 to 1=
5) will be read as hexadecimal =E2=80=9CFFFF=E2=80=9D.=20

> I'm with Russell here, we should understand why its so slow. And by
> fixing that, you might find access in general gets better.

I agree. I will dig deeper.

Cheers,
Ezra.=

