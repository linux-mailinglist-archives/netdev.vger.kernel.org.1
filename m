Return-Path: <netdev+bounces-30095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99D785F5C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0E128132C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DD51F92D;
	Wed, 23 Aug 2023 18:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECF1ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:13:02 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750DE50
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:13:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so8551795e87.0
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692814379; x=1693419179;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loOnP/ub4wdF7GWbqfvzj/QdWmAJtJIsX/aQYQg2WjY=;
        b=PGzwdunq5BVyqLa6jZXnYY2ktJmZPBuJmPb15tPINPaAaYiqwQoTypwaXYPcebOH6I
         ikUYpF5SPKtlbkROXdRfz9e5oOfIPMn1NtKwko/t/vNHqd2RCNbFFUI2WQOoN9ziZ2R0
         zzlpY/cv2GCPcf8SNpWD61htROcatq/tDJ+qyjJmQId02bcl6HtlgIe+8NQt3xZaldpe
         gGZ0kdxWQAYnwPLBG/H+q9whIKohz381OdVXmpjmpesNeE58mFTos3rLyaiYSzRRfH6U
         nBB8NZ/93xfIOdTQ31MY0TfzW6zBTxApbcxB9yy7m8fVSyUqA92cd1giP1MW85SxL9xx
         zlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692814379; x=1693419179;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loOnP/ub4wdF7GWbqfvzj/QdWmAJtJIsX/aQYQg2WjY=;
        b=Q3n5qR3QUe9cAZp5SyevJ6QCG3s1SGpg+nqYcHuuvqxqW7ERpGOwCms+0qdHSijxEm
         tgsz5cs7p0he/oWlk5VLQV4Ie5vs4YUJq096bHvaszxWUprGc7J8rCoiYy1PMhRpv0JZ
         8l9xL2JxctGQYQzi8nk99dLQrl8MJPYmvJmPXXrD6N6rctuZ4gXNWFOKWKRphJg42YgU
         K00PIEZg/CG0/Oao9BSr1aj6m9qtAE21LoU5vJoV6reZOnYEEvApxTF6DxSrVo4y8e/H
         XHILohoEEi3xuw4zsTEMcxI2krOHK3KaUp7Ks1t8MYocnIY3eR7jnZOg6k7Ax1hLDlKe
         IMCg==
X-Gm-Message-State: AOJu0Yyyu7++RQNhMgI+1SIQ156iWjYMUNizMQp8htEInrrkQ9uz8tp8
	mxEsYefebzzlTBuVCNnxhBHQ0YJEkKof6ZrFH/B5CtEf10Q=
X-Google-Smtp-Source: AGHT+IEtc1CxGEu6ndr5kxQ3EPKPLfvxOfHbI+zPMoBL9QgfUEPJEH716EMD2lkH9MZP2RUG1CytofFGWZSLi3d86VY=
X-Received: by 2002:a19:5f54:0:b0:4ff:87f2:2236 with SMTP id
 a20-20020a195f54000000b004ff87f22236mr7697349lfj.37.1692814378520; Wed, 23
 Aug 2023 11:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com>
 <4860127.31r3eYUQgx@n95hx1g2>
In-Reply-To: <4860127.31r3eYUQgx@n95hx1g2>
From: Brian Hutchinson <b.hutchman@gmail.com>
Date: Wed, 23 Aug 2023 14:12:47 -0400
Message-ID: <CAFZh4h-w6u9gSGK2M2v_CDX+KBkZKdqTWz4E2BuPjkHFKbKzRw@mail.gmail.com>
Subject: Re: Microchip net DSA with ptp4l getting tx_timeout failed msg using
 6.3.12 kernel and KSZ9567 switch
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christian,

On Wed, Aug 23, 2023 at 4:22=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Brian,
>
> I just return from my holidays...

Hope you had a good one ... I need one too!

>
> Am Dienstag, 22. August 2023, 23:49:33 CEST schrieben Sie:
> > Getting this tx_timestamp_timeout error over and over when I try to run=
 ptp4l:
> >
> > ptp4l[1366.143]: selected best master clock 001747.fffe.70151b
> > ptp4l[1366.143]: updating UTC offset to 37
> > ptp4l[1366.143]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> > ptp4l[1366.860]: port 1: delay timeout
> > ptp4l[1376.871]: timed out while polling for tx timestamp
> > ptp4l[1376.871]: increasing tx_timestamp_timeout may correct this
> > issue, but it is likely caused by a driver bug
> > ptp4l[1376.871]: port 1: send delay request failed
> >
> > I was using 5.10.69 with Christians patches before they were mainlined
> > and had everything working with the help of Christian, Vladimir and
> > others.
> >
> > Now I need to update kernel so tried 6.3.12 which contains Christians
> > upstream patches and I also back ported v8 of the upstreamed patches
> > to 6.1.38 and I'm getting the same results with that kernel too.
> >
>
> I am also in the process of upgrading to 6.1.38 (but not really tested).
> I cherry-picked all necessary patches from the latest master (see attache=
d
> archive). Maybe you would like to compare this with your patch series.

Excellent, I will check it out!  Yeah, we needed to be on a LTS kernel
so that's why I'm focusing on 6.1.38 as it's the latest in the
yocto/oe universe.

>
> > [...]
> >
> > I tried increasing tx_timestamp and it doesn't appear to matter. I
> > feel like I had this problem before when first starting to work with
> > 5.10.69 but can't remember if another patch resolved it. With 5.10.69
> > I've got quite a few more patches than just the 13 that were mainlined
> > in 6.3. Looking through old emails I want to say it might have been
> > resolved with net-dsa-ksz9477-avoid-PTP-races-with-the-data-path-l.patc=
h
> > that Vladimir gave me but looking at the code it doesn't appear
> > mainline has that one.
>
> How is the IRQ line of you switch attached? I remember there was a proble=
m
> with the IRQ type (edge vs. level), but I think this has already been
> applied to 6.1.38 (via -stable).

So that's one of the first things I thought of which is why I provided
cat of /proc/interrupts.

I also do have a /dev/ptp1 (/dev/ptp0 is imx8mm)

My device tree node is the same as before:

         i2c_ksz9567: ksz9567@5f {
               compatible =3D "microchip,ksz9567";
               reg =3D <0x5f>;
               phy-mode =3D "rgmii-id";
               status =3D "okay";
               interrupt-parent =3D <&gpio1>;
               interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;

               ports {
                       #address-cells =3D <1>;
                       #size-cells =3D <0>;
                       port@0 {
                               reg =3D <0>;
                               label =3D "lan1";
                       };
                       port@1 {
                               reg =3D <1>;
                               label =3D "lan2";
                       };
                       port@6 {
                               reg =3D <6>;
                               label =3D "cpu";
                               ethernet =3D <&fec1>;
                               phy-mode =3D "rgmii-id";
                               fixed-link {
                                       speed =3D <100>;
                                       full-duplex;
                               };
                       };
               };
       };

And I have same pinmux setup as before.  I double checked all of that.

I noticed new kernel /proc/interrupts now has a bunch of ksz lines in
addition to "gpio-mxc  10 Level" which is IRQ from the ksz switch.

Here is what the old 5.10.69 /proc/interrupts looked like:

cat /proc/interrupts
          CPU0       CPU1       CPU2       CPU3
11:      46141        127        127        124     GICv3  30 Level
 arch_timer
14:       5260          0          0          0     GICv3  79 Level
 timer@306a0000
15:          0          0          0          0     GICv3  23 Level     arm=
-pmu
20:          0          0          0          0     GICv3 127 Level     sai
21:          0          0          0          0     GICv3  82 Level     sai
32:          0          0          0          0     GICv3 110 Level
 30280000.watchdog
33:          0          0          0          0     GICv3 135 Level     sdm=
a
34:          0          0          0          0     GICv3  66 Level     sdm=
a
35:          0          0          0          0     GICv3  52 Level
 caam-snvs
36:          0          0          0          0     GICv3  51 Level
 rtc alarm
37:          0          0          0          0     GICv3  36 Level
 30370000.snvs:snvs-powerkey
39:          0          0          0          0     GICv3  64 Level
 30830000.spi
40:       1412          0          0          0     GICv3  59 Level
 30890000.serial
42:      55291          0          0          0     GICv3  67 Level
 30a20000.i2c
43:          0          0          0          0     GICv3  68 Level
 30a30000.i2c
44:          0          0          0          0     GICv3  69 Level
 30a40000.i2c
45:          0          0          0          0     GICv3  70 Level
 30a50000.i2c
47:          0          0          0          0     GICv3  55 Level     mmc=
1
48:       3003          0          0          0     GICv3  56 Level     mmc=
2
49:       2565          0          0          0     GICv3 139 Level
 30bb0000.spi
50:          0          0          0          0     GICv3  34 Level     sdm=
a
51:          0          0          0          0     GICv3 150 Level
 30be0000.ethernet
52:          0          0          0          0     GICv3 151 Level
 30be0000.ethernet
53:       1417          0          0          0     GICv3 152 Level
 30be0000.ethernet
54:          0          0          0          0     GICv3 153 Level
 30be0000.ethernet
56:          0          0          0          0     GICv3 130 Level
 imx8_ddr_perf_pmu
60:          0          0          0          0  gpio-mxc   3 Level
 bd718xx-irq
67:         23          0          0          0  gpio-mxc  10 Level     0-0=
05f
72:          0          0          0          0  gpio-mxc  15 Edge
 30b50000.mmc cd
217:          0          0          0          0  bd718xx-irq   5 Edge
     gpio_keys
IPI0:        29         14         13         13       Rescheduling interru=
pts
IPI1:         0         41         41         41       Function call interr=
upts
IPI2:         0          0          0          0       CPU stop interrupts
IPI3:         0          0          0          0       CPU stop (for
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast
interrupts
IPI5:      7959          0          0          0       IRQ work interrupts
IPI6:         0          0          0          0       CPU wake-up interrup=
ts
Err:          0

I'll check out your 6.1.38 changes compared to what I did.

Thanks,

Brian

>
> Get all the latest information from www.arri.com, Facebook, Twitter, Inst=
agram, LinkedIn and YouTube.
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Lars Weyer; Steph=
an Schenk; Walter Trauninger
>
>

