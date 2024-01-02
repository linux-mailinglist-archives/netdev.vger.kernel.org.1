Return-Path: <netdev+bounces-60910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD63A821D55
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726E1C22394
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552F107A9;
	Tue,  2 Jan 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="l9xiV2Qw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54B13FFE
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso1604648e87.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 06:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1704204284; x=1704809084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgNoaWMj2FO8WRgrrJl7uLzm5+Q+a+TsOeCFA51u4Hg=;
        b=l9xiV2Qw3IfNU6rdLyqCY1Wil/akI2iWRiK2b+XDnZ9JG2r+l15fLT/ViCZLDG4cE9
         jbcwfVph2iTFd7ByWUxsh5P8eXxS2JMrQeRGzn0FDc5d21eW/V9gAZMrSzpF/KEKjPVc
         0ciFW9pVC/GXwT5+yeh+pdwDn5wh4gyFurTwQKt0JX0ZMysGC0sGu6pxxNjnlws+8pvK
         kSnGebEgGzttp7tEWrNTE0Oyh9bR5GVTGcvNR4MPxcniqeMD3MmmJXs8xAzX46uzSDOB
         vJ5iM4MEASYQJhu9nS2noRpwWbY1AwvtH1o/sUNtWOyqurqHlm8N+54mIDL9kgHzsi0Y
         ToUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204284; x=1704809084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgNoaWMj2FO8WRgrrJl7uLzm5+Q+a+TsOeCFA51u4Hg=;
        b=kQ3wx3cofrEka2hGfI1KqQDJrcLS2J1P7xD+12KuUCmIkFlQ34/QDxLCiNjz+rDNcj
         eEo6y13seS0p7ykHfzLXF+WC06mNYp57rYNEo7lcuqU9u7q+a3MwrRAEKi19NsLvRCD+
         gWpcU2uMH9uxR7WA1UuHLAoHKqTeSYB3QuFoYKvya+YAXqX4Lnxzs4uOUY16W/iro0yy
         fYvxBELuaDWdaxq3Dft+UV23Ijzhe6Zd/6ZHh4uUOXNWLSha1aKNG0R5tD9aa8/iH4Na
         +95cfWZ1jKSy7XQcWIhbO7LV3VZV76KOurwGeXwr68OsMGgcuZv7yILzVlYxGUmFxKQn
         FAjA==
X-Gm-Message-State: AOJu0Yy6sMSe2n6oj6CAmWyahCOMoDMa8J/U+hK+CsAlusk/7SRV6Fq+
	y9e2CFeJURaNS9shGpZXBW8tDc5SOoh2EtQrnZzvmHjzWdbfjA==
X-Google-Smtp-Source: AGHT+IHl0oTGGAamjBjvKyk7E/Jd0pNVROEUZwRfdNPKvUDbSA23pxnoBUCxR2XqneYphchmW49V8ab1pYD8v8eXn7Y=
X-Received: by 2002:a05:6512:108b:b0:50e:7d4f:a32a with SMTP id
 j11-20020a056512108b00b0050e7d4fa32amr12628563lfg.3.1704204283826; Tue, 02
 Jan 2024 06:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com> <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
In-Reply-To: <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 2 Jan 2024 15:04:32 +0100
Message-ID: <CAM1KZSnmB7o=x_p6So8O_1FUg_m8PdjgcLd5HqyhFvfvKPqx7A@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Jan 2, 2024 at 2:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> So it seems we need to extend this with another OUI.

That is actually what I am proposing:
https://lore.kernel.org/netdev/77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.c=
om/T/

Sorry, that the patch did not reach you directly. Unfortunately, I cannot
send patches (yet) through the company's mail server. I am smarter now,
won't happen again.

Cheers,
Ezra.

