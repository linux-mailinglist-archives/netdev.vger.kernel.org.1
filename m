Return-Path: <netdev+bounces-31287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB278C85D
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB611C20A1D
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A795E17AB1;
	Tue, 29 Aug 2023 15:13:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98513156CC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 15:13:01 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1FEBD
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:13:00 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so2579506fac.3
        for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693321979; x=1693926779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylPNlFhBdiOQiDVAnWeqfH/kGdZp1MWEZ59Dr+ruGeM=;
        b=Br818mPDCYYsDGaLxZfFkTrxjP5KG8mMmRFv8jwF16pAddOc/VT/lggMd4n6ojmFFk
         iRvvdulsTaZn1n8EmUhbB4qkSVr35dNQCEP0BGd+XGzy9hax3z+uBBTLymGHfAGCeFrb
         aWrTBH7nIfub54nETfb45/1676AnXAtXyqtQlK3LZene/N1DuCrYzpkCITmy4IckGpBh
         h9UdfitRudetXdxhtmD3GL4EoNP77P8kjBt+eNug6V5QZlU3PdTlr9lMMEk/sIXeszsK
         UlETbJBH5NHS9kxaQqpKKYX2mGxGWVBLYaoiHNkgp8rGQnM29LZBiiRqtJOZRdhMBHqx
         QSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693321979; x=1693926779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylPNlFhBdiOQiDVAnWeqfH/kGdZp1MWEZ59Dr+ruGeM=;
        b=ZECyMt4hih3nS0/sVj9m4HiCOt57YTNXRfMVgkti3SDl5cV/wzZNnVenpE2p/8IZGU
         GEKbX+aprR2YHqdAXlpN96oCCz7niYtpc8a+wEOA2dAJM0p/nEUdjGJnK0zqE1yY9qRd
         krYYBPpbUCMkml/wOwhK7bP2lAHhGoc1raBI9pgFWWEAUsqoh83DwhnKOH1qfIIRk+w8
         OImC3yMjO4x3mZLuwrfNqW4nUhysX051gh0cYOIvRr4XCJ/gWZXJeCKmjaqeKGrzt6si
         UxZ2iHtuMb14FLu0z4rfrghmqY3xPJAKZ6QmKZ9W/zswpJ9Ln/mvnvQQ986o9+1A/9X3
         1RPA==
X-Gm-Message-State: AOJu0Yw3sy23wSRAOJCvu2/dlrAupwqdw0gkXvalc45PQuhz6aIbdry3
	DOy1Z61pyR4VVFDZIztc4bSv0dC08OU7OUZPvojlidw+OgNSiwT/
X-Google-Smtp-Source: AGHT+IEdB5nEaA3Jvmzd2B9yzOZ7lIgz032uk1g2sY/cLr94+asDQ7MemfwYwb27YECsRWTQQ9rjWE8+VTGpVJCvR18=
X-Received: by 2002:a05:6870:428a:b0:19f:6fae:d5fc with SMTP id
 y10-20020a056870428a00b0019f6faed5fcmr14770938oah.33.1693321978947; Tue, 29
 Aug 2023 08:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>
Date: Tue, 29 Aug 2023 17:12:48 +0200
Message-ID: <CAC8rN+AQUKH1pUHe=bZh+bw-Wxznx+Lvom9iTruGQktGb=FFyw@mail.gmail.com>
Subject: [RFC] RJ45 to SFP auto-sensing and switching in mux-ed single-mac
 devices (XOR RJ/SFP)
To: netdev@vger.kernel.org
Cc: simonebortolin@hack-gpon.org, nanomad@hack-gpon.org, 
	Federico Cappon <dududede371@gmail.com>, daniel@makrotopia.org, lorenzo@kernel.org, 
	ftp21@ftp21.eu, pierto88@hack-gpon.org, hitech95@hack-gpon.org, 
	davem@davemloft.net, andrew@lunn.ch, edumazet@google.com, 
	hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com, 
	linux@armlinux.org.uk, nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I and some folks in CC are working to properly port all the
 functions of a Zyxel ex5601-t0 to OpenWrt.

The manufacturer decided to use a single SerDes connected
 to both an SPF cage and an RJ45 phy. A simple GPIO is
 used to control a 2 Channel 2:1 MUX to switch the two SGMII pairs
 between the RJ45 and the SFP.

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90   =E2=94=
=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82   =E2=94=82         =E2=
=94=82
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=9C=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4 SFP     =E2=94=82
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82   =E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82
  =E2=94=82 MAC =E2=94=9C=E2=94=80=E2=94=80=E2=94=A4 MUX  =E2=94=82   =E2=
=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=90
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82   =E2=94=82         =E2=
=94=82
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82   =E2=94=82 RJ45    =E2=
=94=82
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=9C=E2=94=80=E2=94=80=E2=94=
=80=E2=94=A4 2.5G PHY=E2=94=82
  =E2=94=82     =E2=94=82  =E2=94=82      =E2=94=82   =E2=94=82         =E2=
=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=96=B2=E2=94=80=E2=94=80=E2=94=98   =E2=94=
=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
               =E2=94=82
  MUX-GPIO =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

Other vendors may implement this differently (e.g. Keenetic
 KN-1011 has a similar setup, although the PHY is doing all the work),
 but this seems a common enough approach to produce cheap CPEs
 with multiple interface types for fiber internet.

In this particular case, Zyxel implemented a user-land script[1] that is
 continuously polling GPIO 57 (Moddef0) of the SFP cage.

Once an SFP module is detected the process continues as follows:
- An MDIO command disables the RJ45 PHY
- A GPIO write to GPIO 10 that switches the MUX to the SFP interface
- The MAC is then re-configured by writing directly to the SoC registers
 using a mix of lookup tables and heuristics/try-catch.

This allows Zyxel to configure the MAC with the supposedly correct SFP
 interface speed, bypassing any well-established interface speed
 auto-detection and negotiation logic.

Zyxel also configures the GMAC at boot with a fixed speed of 2500M
 forcing the link status to be always up irrespective of the real
 physical interface status.

On SFP disconnect the process is simply applied in reverse.

We are looking for guidance on how to design changes that could achieve
 the following goals and could be accepted upstream in the future:

 - SFP and RJ45 speed auto-sensing and auto-negotiation working
 - Automatic SFP/RJ45 switching
 - Failsafe logic in case both media are connected.
 - Reduce overall potential power consumption and rate-adaption by not
   having the GMAC always switched to 2500M mode without reason.
 - (optional) default configurable logic for both failsafe and idle status

References:
[1]: https://github.com/pameruoso/zyxel-ex5601t0/blob/V5.70(ACDZ.0)C0/targe=
t/linux/mediatek/ex5601t0/base-files/bin/sfp_wan.sh

