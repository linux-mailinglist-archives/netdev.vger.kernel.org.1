Return-Path: <netdev+bounces-60967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11D8220C3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 19:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C692F1F22FD0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8943156CB;
	Tue,  2 Jan 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="FDPLw42C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BD715AC8
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7a0d07a0so992867e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 10:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1704218923; x=1704823723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjyTo7ZfJa9aoxWUXxRn7Fnh2er81zmcmrMeY63vBkA=;
        b=FDPLw42CQ2HWxh/o62nGmvjRiFBOCv+sXD4F0UPB6D0ejGKC7+ypvppMvE57r8zqBn
         tqyNP5a4EBIY0u2gjZFlpyBbMC/dkuY+xigxcsFO3XmIwHGTx7aj4YnzWnSBlvR2E80W
         EbwvTPY/CaEL8PKkLr5tWPK0UoKuJSu5GyJHQx++sSCspRHq20GG/YJTyzYYzh+5RS41
         hZ5lH/JDMhojlIONK9vyD2VfALBkiA2He8nKp5cCTrc2qHQHHfKxlsMdMCbodPQ8Zgke
         xSE0qE4LfP4sQcX6sYu4QY9jYyw0J6IfAbajiJfy5zkmRmxgwDJccQrt2phQsyWd5y7h
         fraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218923; x=1704823723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjyTo7ZfJa9aoxWUXxRn7Fnh2er81zmcmrMeY63vBkA=;
        b=IQQRbOSgyXYT4zHekwTDEFcO1MmiLIq0cls6+OU+vVY+n7bY7fGeprMhXDWvQhYnaO
         1qmP/Cl1jJuKGEd9PO9YQv5pgHI+a7YfiHXJgRfrwXhL5ehPjTSJ5j+rU0xytoROAWPb
         JSkiNzw3nFYVJf8LSSLKCia0SCGRw4AxN4d9aZMX9HEEgdvbEGPTOp/PdHZ3k3miNB+m
         nohBXNRDwIj0ZXl0EZLOqU+OcESlLwmQ9xCyvu9uWx1vqjv6XrZ8KQoGp2MHrxzG3bk+
         HMFuYAM8tuzbUqK9OXGQZTMavfWSMqg7blpIuVfsmxUeHdQPEWX4z9BP00F83I9RW4/t
         JvTA==
X-Gm-Message-State: AOJu0YzSnwDuie7VyGRlZ6BC5Mco+fM3Mzdm2Pr3JIDykR8+SrlhkGB+
	LIyQARwfl/y3TyHYQtp0uKKZYsbAvAvCq1b6910MsdCtKjePzw==
X-Google-Smtp-Source: AGHT+IF0Spe8KxX+/+nCl2sMQOTdf02xj1GE685oCvU52hctOtNqz0lFVgWcrDcfUW5WhDkBFGMxagTxNHV+MzEihfg=
X-Received: by 2002:a05:6512:3ba4:b0:50e:84f9:22e1 with SMTP id
 g36-20020a0565123ba400b0050e84f922e1mr10974799lfv.4.1704218923454; Tue, 02
 Jan 2024 10:08:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com> <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com> <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
In-Reply-To: <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 2 Jan 2024 19:08:32 +0100
Message-ID: <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Jan 2, 2024 at 4:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> I do however disagree with this statement in the original patch:
>
> > AFAICT all SMSC/Microchip PHYs are Clause 22 devices.

Excuse my ignorance, I am by no means an expert here. I guess what I
wanted to say was:

By skimming over some datasheets for similar SMSC/Microchip PHYs, I
could not find any evidence that they support Clause 45 scanning
(other than not responding).

> drivers/net/phy/smsc.c has a number of phy_write_mmd()/phy_read_mmd()
> in it. But that device has a different OUI.

I guess I am confused here, AFAICT all PHYs in smsc.c have the same OUI
(phy_id >> 10).

> However, the commit message says:
>
> > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > least with our setup) considerably slow down kernel startup and
> > ultimately result in a board reset.
>
> So we need to clarify the real issue here. Does the C45 scan work
> correctly, but the board watchdog timer is too short and fires? We
> should not be extended this workaround when its a bad watchdog
> configuration issue...

Changing the watchdog configuration is not an option here. We are
talking about a slowdown of several seconds here, that is not acceptable
on its own.

Cheers,
Ezra.

On Tue, Jan 2, 2024 at 4:50=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Excluding all PHY's from a vendor for me is a quite big hammer.
>
> Maybe it serves them right for getting this wrong?
>
> Micrel is now part of Microchip, so in effect, this is the same broken
> IP just with a different name and OUI. We have not seen any other
> vendor get this wrong.
>
> I do however disagree with this statement in the original patch:
>
> > AFAICT all SMSC/Microchip PHYs are Clause 22 devices.
>
> drivers/net/phy/smsc.c has a number of phy_write_mmd()/phy_read_mmd()
> in it. But that device has a different OUI.
>
> > I think we should make this more granular.
> > And mdio-bus.c including micrel_phy.h also isn't too nice.
> > Maybe we should move all OUI definitions in drivers to a
> > core header. Because the OUI seems to be all we need from
> > these headers.
>
> That does seem a big change to make for 'one' broken PHY IP.
>
> However, the commit message says:
>
> > Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
> > least with our setup) considerably slow down kernel startup and
> > ultimately result in a board reset.
>
> So we need to clarify the real issue here. Does the C45 scan work
> correctly, but the board watchdog timer is too short and fires? We
> should not be extended this workaround when its a bad watchdog
> configuration issue...
>
>        Andrew

