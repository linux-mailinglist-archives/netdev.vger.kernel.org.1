Return-Path: <netdev+bounces-53243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF26801BE9
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 10:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA9F1C208D8
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 09:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116DE14013;
	Sat,  2 Dec 2023 09:55:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19D134
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 01:55:22 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33331e98711so1165780f8f.1
        for <netdev@vger.kernel.org>; Sat, 02 Dec 2023 01:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701510921; x=1702115721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P250h/bKlvXlZjOSynNCwWP3G767EkohggePlElSbr0=;
        b=ESkYd4KgZWAlb74GflhubUevBlJGZUMGUJ6XtHNriBlcl22oLu2ynvbVEHirHpBEey
         DcUa+ns7seuz/+hBkcP1/nfI2YXOqB8588di9EAjYAFwv4g9jHvKw5yRmVjgWtVUCxyE
         sr4TdEhdMhjNIobS6e3y3fh0lw/FmX7WYy4Z5Caye5nK9MNOIBcpmc9QPkOFmFTez/s7
         8dUno0STyy62epTz2hjIrNjsZNFY8W81EAomR8SfXCHjyVfY0zxBx3Jlmw9GksjMdqtC
         ujBQEieVr4E6oPBpyLN2kDZQ9OsEupLEjbbKu1Y0SjX2eq3DoO/8rhYYxuLVTg4VJfTl
         x2+g==
X-Gm-Message-State: AOJu0Yz6JUgucheerqpoOuH6ZOPsx36B8V9S4skjBxZjbMO6aBU6ar9g
	4iB9buvG/Ig/Yog5JFc19E1g/yukebYuQg==
X-Google-Smtp-Source: AGHT+IHlJpX7lHPqAJWc/CgtHYsO1kAjJpvE5xGLnFXABj0yvlBjUdMUVlEmpp+BlT0AnrrxtN33tw==
X-Received: by 2002:a5d:658c:0:b0:333:3cf1:baa3 with SMTP id q12-20020a5d658c000000b003333cf1baa3mr191313wru.39.1701510920479;
        Sat, 02 Dec 2023 01:55:20 -0800 (PST)
Received: from [10.148.82.213] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d4e85000000b0033333bee379sm3048875wru.107.2023.12.02.01.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 01:55:20 -0800 (PST)
Message-ID: <71fd7ea47ca01f85c995c481a19aba15142e1341.camel@inf.elte.hu>
Subject: Re: BUG: igc: Unable to select 100 Mbps speed mode
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev
	 <netdev@vger.kernel.org>
Cc: "anthony.l.nguyen" <anthony.l.nguyen@intel.com>, Jesse Brandeburg
	 <jesse.brandeburg@intel.com>, "Neftin, Sasha" <sasha.neftin@intel.com>
Date: Sat, 02 Dec 2023 10:55:19 +0100
In-Reply-To: <87zfytv6e2.fsf@intel.com>
References: <c40ebbf9c285b87fc64d6f10d2cdc8e07d29b8c6.camel@inf.elte.hu>
	 <87zfytv6e2.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vinicius,

On Fri, 2023-12-01 at 15:40 -0800, Vinicius Costa Gomes wrote:
> Hi,
>=20
> Ferenc Fejes <fejes@inf.elte.hu> writes:
>=20
> > Hi!
> >=20
> > I upgraded from Ubuntu 23.04 to 23.10, the default Linux version
> > changed from 6.2 to 6.5.
> >=20
> > We immediately noticed that we cannot set 100 Mbps mode on i225
> > with
> > the new kernel.
> >=20
> > E.g.:
> > sudo ethtool -s enp4s0 speed 100 duplex full
> > dmesg:
> > [=C2=A0=C2=A0 60.304330] igc 0000:03:00.0 enp3s0: NIC Link is Down
> > [=C2=A0=C2=A0 62.582764] igc 0000:03:00.0 enp3s0: NIC Link is Up 2500 M=
bps
> > Full
> > Duplex, Flow Control: RX/TX
> >=20
>=20
> I wonder if this patch fixes it, and it is still not available in
> your
> distro:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3De7684d29efdf37304c62bb337ea55b3428ca118e

Will take a look, thanks. I'm not familiar Ubuntu's versioning and
custom patches, nor their backport policy.

However their "mantic" tree (6.5) looks like this:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/mantic/t=
ree/drivers/net/ethernet/intel/igc/igc_ethtool.c#n1804

So the patch above not applied there.

>=20
> > I just switched back to 6.2 and with that it works correctly.
> >=20
> > Sorry if this has already been addressed, after a quick search in
> > the
> > lore I cannot find anything related.
> >=20
>=20
> I think it was discussed here:
>=20
> https://lore.kernel.org/all/20230922163804.7DDBA2440449@us122.sjc.aristan=
etworks.com/

Thank you, look like I missed it. Sorry for the noise!

>=20
> > Best,
> > Ferenc
> >=20
>=20
>=20
> Cheers,

Best,
Ferenc


