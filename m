Return-Path: <netdev+bounces-39387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011267BEF49
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93086281A8D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 23:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426E47369;
	Mon,  9 Oct 2023 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TOjeJUTA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F447354
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 23:43:14 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC9CA6
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 16:43:12 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dd2e65ed59so2503509fac.1
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696894992; x=1697499792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xrc2DNtzr7WUli92ysWJKPQNNroXkQpQ9YdmsD4PBYM=;
        b=TOjeJUTANSegbrVtzmSg2Wu8EDeYcqU+Zl9uw2UJd64egfQjMDoaO7WgDSQN90ifLI
         QnIs0tgXev4XAVNs856qdlyEsHmBTbFxzXgRIjcCzQLWS0L8u2L2BSRZJxImT4EVb1Qr
         CJGwrB1DYOolUDNw7bkYWIBDf1BcR0rtt7BSpbVBurmsHuiA0IQNmSIS8htjZ/SMCEV3
         w5EeqJl2xP2FtYKhI9C4pQZ5o0Exo5j/R1NMLWrtxSkZPk92I6+S8qtC9D9QmGz6w9wn
         NJb92eAjXQP1f2bjPfz8L69x6nWjWb+dRX7EGvJgQEDM3OSN3vnFqxi8+WxRkMY6zi2r
         Zhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696894992; x=1697499792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xrc2DNtzr7WUli92ysWJKPQNNroXkQpQ9YdmsD4PBYM=;
        b=NcYuhSFZTdMFEqWunRSqVsscxG8PE3PjcSH54b0MylpsI5j7Pg4pD8na0+R2tH6WKx
         6xWqcvKLpy7+4C0fp0nOgyoym+QQvU73MWz2GoBkOTnjNOQUhAwwsus44o7auU32xbG3
         gb2UlT1bR/vRwypTpIqIfuUD1pYtwkzsx+spYL+KOokRS6LosYeyWqMO1CENe4FIhO2A
         CgDF3Ik63C5Wc/ipWxNxp9GnyCzywUVkonEVB/GEezoClz3rD66OYlhXnmuUtTuAppce
         4nGraHf7C8yLrvBOCmfJz+v644bktz1Bmp8jj+cq3mly8r/D8WokjKLdRuBKAMsfuRve
         nfsQ==
X-Gm-Message-State: AOJu0Yw8mxdenE4sKl42cGC9rQO4Tcp/bFg9cmjT9OQWJwZJKE3NOXD2
	7bfI5cdbHKA8M/dqllhULUvNxg==
X-Google-Smtp-Source: AGHT+IGZjdcGJcPM2ssfu4CXuU8dn+LKhcOJHfZVLV2qybq3DQf2t3fKYJxXoMRNZB4O6SQYYHOjyw==
X-Received: by 2002:a05:6870:fbac:b0:1d0:d357:c526 with SMTP id kv44-20020a056870fbac00b001d0d357c526mr16407549oab.11.1696894991815;
        Mon, 09 Oct 2023 16:43:11 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b0068bbe3073b6sm6912590pfh.181.2023.10.09.16.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:43:10 -0700 (PDT)
Date: Mon, 9 Oct 2023 16:43:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rodolfo Zitellini <rwz@xhero.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
 linux-wpan@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Doug Brown <doug@schmorgal.com>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/10] appletalk: remove localtalk and ppp support
Message-ID: <20231009164303.0fe2f556@hermes.local>
In-Reply-To: <790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
References: <20231009141908.1767241-1-arnd@kernel.org>
	<790BA488-B6F6-41ED-96EF-2089EF1C043B@xhero.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 18:49:43 +0200
Rodolfo Zitellini <rwz@xhero.org> wrote:

> Hi!
> I=E2=80=99ve been working on a new LocalTalk interface driver for the las=
t couple months, do you think it would be possible to at least postpone the=
 removal of LT a bit?
>=20
> It is a driver for an open source device called TashTalk (https://github.=
com/lampmerchant/tashtalk), which runs on a PIC micro that does all the LT =
interfacing, and communicates back via serial to the host system. My driver=
 is relatively simple and works very well with netatalk 2.2 (which is still=
 maintained and still has support for AppleTalk). The driver is basically c=
omplete and trsted and I was preparing to submit a patch.
>=20
> Still having LocalTalk in my view has many advantages for us enthusiasts =
that still want to bridge old machines to the current world without modific=
ations, for example for printing on modern printers, netbooting, sharing fi=
les and even tcp/ip. All this basically works out of the box via the driver=
, Linux and available userspace tools (netatalk, macipgw).
>=20
> The old ISA cards supported by COPS were basically unobtanium even 20 yea=
rs ago, but the solution of using a PIC and a serial port is very robust an=
d much more furure-proof. We also already have a device that can interface =
a modern machine directly via USB to LocalTalk.
>=20
> The development of the TashTalk has been also extensively discussed on th=
r 68KMLA forum (https://68kmla.org/bb/index.php?threads/modtashtalk-lt0-dri=
ver-for-linux.45031/)
>=20
> I hope the decision to remove LocalTalk can be reconsidered at least for =
the time being so there is a chance to submit a new, modern device making u=
se of this stack.
>=20
> Many Thanks,
> Rodolfo Zitellini

Does it really need it to be a kernel protocol stack?
What about doing it in userspace or with BPF?

