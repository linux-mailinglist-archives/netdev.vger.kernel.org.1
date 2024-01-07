Return-Path: <netdev+bounces-62219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442D82644F
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 14:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCD11F20FBF
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5C134A6;
	Sun,  7 Jan 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="PPhGuUeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFF134A4
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cce6bb9a74so2325431fa.0
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 05:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1704635484; x=1705240284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSo628uuzkMR1hgsjD+6qxkNpYNVqnJfEw1WaZPhWao=;
        b=PPhGuUeHNUzn63U2zBUyVhTkLOsCKsrxKyXbEDt+Y5yxTZ2zjTY5BQoYZVMqXfco3+
         gCxDHvo4zP7CC2F7knPaCmnDz4ARi/+qO2oN1DABa7IkW4aCT/kNfcQ8XrwlVDT9ZWwz
         mbPdT0m3U6J1zrsFtJSbbmWPO8LHuBvtiETFDyJkbVvB3rxiCQuMAXvHkoyLW6n0aJ/A
         SK3lj+YEBYUHYLDuqZnYADngJs8HN144Jm19DRnTr6lpvisbBClA30EbbPxF2vC+pIkQ
         WuvDU2O37st11wdbpHeSWEt9pw7Lt3zr2KLwt35dRY6/iGEQoXc9P4k5EMq0vgdl2rJX
         hVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704635484; x=1705240284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSo628uuzkMR1hgsjD+6qxkNpYNVqnJfEw1WaZPhWao=;
        b=D+XpDIb7HpwbgBSjQSlgPule/tu2g2Q2dIIzPpql5nw0NUz/3nrJ0ggLevFLa1WelV
         a8YheN5iAMgqtFt6CaDcGX8Z0Hn3pfLnzPR8k9ULHF1UM0/e1MZnrn4wvDwhskibAiMr
         PmrpVAQTw66F/zUSiKf6vaw5hzJ5Cy78tuUP4sKg5ufCS+8ODBBUOU+UPxLYAPn2DDEO
         T6bL1qGyyFRn/u40hVWfUr6Du1jMJMGFSsAjo9KS/GdYVTrZYp0Wq/u7FG3bsO6ko48f
         sWzQPBUn41ojTGYhj4LhEUFvd7VoZ5QneSE/vNmk55TFRMIGHAHViQyvw5/7ymgVOJb6
         C+TQ==
X-Gm-Message-State: AOJu0YzeFZksnHsz5SB9XR3pbF7+2IKNMJuumX+tSYH6/boG2Tr63Y+C
	6yWcqX/MNZtB3Iw8QaZw6NuWyVp82C/cwzCdYOjHxM9MTvlpKClZ4ESVOhf7Qqc=
X-Google-Smtp-Source: AGHT+IFnyRjZ+L+E0/53mVXlxNdmTBE5IpgxliHeMmAM9DYXwpi1pGTAgTu/DuYFbll4NrNJ++7dZg2v2mHKPJKu7t4=
X-Received: by 2002:a05:6512:3ba1:b0:50e:b2ba:15d with SMTP id
 g33-20020a0565123ba100b0050eb2ba015dmr2062607lfv.1.1704635484018; Sun, 07 Jan
 2024 05:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
 <77fa1435-58e3-4fe1-b860-288ed143e7bc@gmail.com> <1297166c-38c1-4041-8a7f-403477b871cf@lunn.ch>
 <8eb06ee9-d02d-4113-ba1e-e8ee99acc2fd@gmail.com> <2013fa64-06a1-4b61-90dc-c5bd68d8efed@lunn.ch>
 <CAM1KZSn0+k4YKc2qy6DEafkL840ybjaun7FbD4OFwOwNZw_LEg@mail.gmail.com>
 <ZZRct1o21NIKbYX1@shell.armlinux.org.uk> <CAM1KZS=2Drnhx8SKcAbRniGhvy0d85FfKHOgK7MZxNWM7EAEmQ@mail.gmail.com>
 <d6deee54-e5c3-4bdd-8a87-f1afeada8d9b@lunn.ch>
In-Reply-To: <d6deee54-e5c3-4bdd-8a87-f1afeada8d9b@lunn.ch>
From: Ezra Buehler <ezra@easyb.ch>
Date: Sun, 7 Jan 2024 14:51:12 +0100
Message-ID: <CAM1KZS=YFuPJJQvsS28dtnZQycjWE6kptf3h2kFGn1D42kJaVg@mail.gmail.com>
Subject: Re: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Tristram Ha <Tristram.Ha@microchip.com>, Michael Walle <michael@walle.cc>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 4:20=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> Could you hack a copy of readx_poll_timeout() and real_poll_timeout()
> into the driver, and extend it to count how many times it goes around
> the loop. Is the usleep_range() actually sleeping for 10ms because you
> don't have any high resolution clocks, and a 100Hz tick? If so, you
> might want to swap to 1000Hz tick, or NO_HZ, or enable a high
> resolution clock, so that usleep_range() can actually sleep for short
> times.

You are spot on, simply selecting the 1000Hz tick fixes the issue for me.
So, no need to change the code I guess.

Thank you very much for the help and sorry for wasting your time.

Cheers,
Ezra.

