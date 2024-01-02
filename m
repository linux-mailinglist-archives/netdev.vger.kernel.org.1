Return-Path: <netdev+bounces-60880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA947821C40
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73B1B20D6D
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00831F9E0;
	Tue,  2 Jan 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="QknIk8hT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879CF9CC
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e72e3d435so6845912e87.2
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 05:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1704200966; x=1704805766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmdjPvQYlxgRjMXDO0zIJCQ7Mz6/gzcusoHkQD7VboI=;
        b=QknIk8hTINGO3EdbLxxThFlWfKHLcn0Ch2ZSo19WEAnjiv5o5Io3bD3/O1S76RDBF/
         nBJx/WLCK5yI55fYpIC+Ceri/Pu3LeosjcT5rI/eHD6k3stSAtfwHVBnznuoTSDI99e5
         rMCQecpnyTpQ6FQrAHrOR50Vy0jChk36VG1bndDeBAierXHMPAAQe5Lsc3W4KrqEB8tS
         SemX3JoJIpwJ5ko+VzrsnVPcNouTbWkDCxAjVNp5DnRoDzBxbRPJDXtdCQTyI3nedoAt
         jk2cjRUuDU5y0pGqN9JIO61lOUc3Iw+WVAdMHnzEj9IBht2XqqFCGYfBS3YvdwmSMaYX
         H3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704200966; x=1704805766;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmdjPvQYlxgRjMXDO0zIJCQ7Mz6/gzcusoHkQD7VboI=;
        b=owIZElh7NvtloOCehur3V9mO3YiTvRFlYkupvbxK5c10MjQsh0HFPrCySrDnM8MoLL
         71LsBFZGjrxbc2DXV6Sqw6oj/dm7D4S4/DoN4Fa9v49e0vnEL4AJU/WXtj8VNBN94RGu
         eQ6q3C8VLryvJPtKUWX9iwlH01iinWEV/fPszsHOm8MdALJDR9uBUZScjaXcb9hDybQF
         9cu4BrCO8L83n1T/adx5GKMfMbtnYnnyTFKHCvmJSfm93B8/JW8f8ihdurUobnUT5hsF
         g3A9kiAxvcUzCBCfQRtpCa1DG9XpEEvCOOQ/vJWc1yCo1lR9/kZPeJ+53Ha9kr5t0nJr
         ntlg==
X-Gm-Message-State: AOJu0YzV42SJSVX+xDANvVJKm2TEB695W0rMtB6l/qnx3H/4A/9Ri0km
	3cD8dk++h3FlHsDiBJx4zFg1vOiTtUc7tQ==
X-Google-Smtp-Source: AGHT+IHq0oQwmywpS2rHoDI9JcvqWATtdhgao9sF2qx5m6UyJkAYWH7Ci8rC8teBF56CpgSQfOWFng==
X-Received: by 2002:a19:8c49:0:b0:50e:3899:d465 with SMTP id i9-20020a198c49000000b0050e3899d465mr4965230lfj.109.1704200965868;
        Tue, 02 Jan 2024 05:09:25 -0800 (PST)
Received: from wkz-x13 (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id w21-20020ac24435000000b0050e78fb41acsm2739923lfl.73.2024.01.02.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:09:25 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>, davem@davemloft.net,
 kuba@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: phy: marvell10g: Support firmware
 loading on 88X3310
In-Reply-To: <ZZPhiuyvEepIcbKm@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-2-tobias@waldekranz.com>
 <20231219102200.2d07ff2f@dellmb> <87sf3y7b1u.fsf@waldekranz.com>
 <ZZPhiuyvEepIcbKm@shell.armlinux.org.uk>
Date: Tue, 02 Jan 2024 14:09:24 +0100
Message-ID: <87mstn7ugr.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On tis, jan 02, 2024 at 10:12, "Russell King (Oracle)" <linux@armlinux.org.=
uk> wrote:
> On Tue, Dec 19, 2023 at 11:15:41AM +0100, Tobias Waldekranz wrote:
>> On tis, dec 19, 2023 at 10:22, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>> > On Thu, 14 Dec 2023 21:14:39 +0100
>> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >
>> >> +MODULE_FIRMWARE("mrvl/x3310fw.hdr");
>> >
>> > And do you have permission to publish this firmware into linux-firmwar=
e?
>>=20
>> No, I do not.
>>=20
>> > Because when we tried this with Marvell, their lawyer guy said we can't
>> > do that...
>>=20
>> I don't even have good enough access to ask the question, much less get
>> rejected by Marvell :) I just used that path so that it would line up
>> with linux-firmware if Marvell was to publish it in the future.
>>=20
>> Should MODULE_FIRMWARE be avoided for things that are not in
>> linux-firmware?
>
> Without the firmware being published, what use is having this code in
> mainline kernels?

Personally, I primarily want this merged so that future contributions to
the driver are easier to develop, since I'll be able test them on top of
a clean net-next base.

More broadly, I suppose it will help others who are looking to support
similar boards to run the latest kernel, without the need to juggle
external patches which are likely to break as the driver evolves.

Having a single, canonical, implementation of firmware loading, instead
of multiple slightly-broken-in-different-ways ones floating around, also
seems like a net positive.

