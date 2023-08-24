Return-Path: <netdev+bounces-30475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B40787858
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA2628150F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D156E5;
	Thu, 24 Aug 2023 19:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A134A1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 19:03:46 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1C1BCE
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 12:03:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-529fb2c6583so312016a12.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 12:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692903824; x=1693508624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxy8HnFm13LKSZ1poZr4yDCGAQLEpEndncrAKioiNXI=;
        b=R6ecjdKGfksVmOgrliTsaGdBx1OuQzD4oIPqobm1OxB+Yvx9MS6EUqTEo5UX/en8gL
         HGMnv6zxUfJFXMx5ZyA8FVT8xO5cv2N5SZVOCrx0XJbPqmjjIN4vBdsns6hTUfuHU7+m
         CTRmL5vofMBCcyIhT9jlHSwNgBJ9eCjfLEA/uV7KtlKf7DfpGopMAvxMLXR/PBdlZLjD
         TfvNwB2KKxjPdgx1eSc2AIO+WW+mf7gpoaFub2M2X9nFvdk4HU6X4FWIch2xOl1u5w71
         f3IDIce0upCSFH1k+mRDdSVnLVYbg5PAHLyK41zELzCG1T2m/Adu7eZZPp5Xogxtrgz3
         rWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903824; x=1693508624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxy8HnFm13LKSZ1poZr4yDCGAQLEpEndncrAKioiNXI=;
        b=Z949p1RQba1jv2CfqCDVMKx1RXWuLKln2UbeCS5ZjupSCTOfv+5B0M+KAWI497ClUx
         jwO/OzEhmTbqpkQbfH18uML6CfH0gFSGJm6JdaAKV40/8JadBi7AFT+1ferUHu2pMgoW
         erlJ4d7lJIRmyvqR1soLTbSdIr9pzAAdtfXlUtizzQ0DnZxIOSf2yrsH7zZLS2ueK6KR
         JnygiHP9JG6LC6eJR4BEWzY1J+FBEKPWT1avjcc8qM+9bwgbJMLTg538vjSsbKWRxWU6
         IBZA3YESETWUclp5DPr9iN+oYduOV/DNvv33PCOisB08PjPoxtCwSoeTyBeU7sgrDdEM
         /BSg==
X-Gm-Message-State: AOJu0Yx1eIBGGoxNqRaB4XAvlclIewGsWrJgWhy1MIkHGzt4+oK5WYA/
	89V/tEi/a6d1pT/7Tvvgr38FLjWS149N68IjdpXq3d8fhGg=
X-Google-Smtp-Source: AGHT+IEt1SvkeAAP6tmlrQifHvqg4nhvhxrvsOPwFgApGJ8UMb/wGBeWtwHi6mFTtCzqkiI9VpUUpDDKAKV4xswMirI=
X-Received: by 2002:a50:ed92:0:b0:522:2ce0:d80a with SMTP id
 h18-20020a50ed92000000b005222ce0d80amr11236852edr.35.1692903823604; Thu, 24
 Aug 2023 12:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com>
 <4860127.31r3eYUQgx@n95hx1g2> <CAFZh4h-6yWvpvzJyv06zy8MbtMmXG==V0h2vU=uUN8iMMcb=ig@mail.gmail.com>
 <CAFZh4h-0PBrFh1pDr6Jfg95rF6wUt1o=k=-EgG+8MxN7pnyiAw@mail.gmail.com>
In-Reply-To: <CAFZh4h-0PBrFh1pDr6Jfg95rF6wUt1o=k=-EgG+8MxN7pnyiAw@mail.gmail.com>
From: Brian Hutchinson <b.hutchman@gmail.com>
Date: Thu, 24 Aug 2023 15:03:32 -0400
Message-ID: <CAFZh4h_ueji_KucLdPx9PtTQP1g29PbcjNDFGzLBJYpYK8Rt3w@mail.gmail.com>
Subject: Re: Microchip net DSA with ptp4l getting tx_timeout failed msg using
 6.3.12 kernel and KSZ9567 switch
To: Christian Eggers <ceggers@arri.de>
Cc: netdev@vger.kernel.org, Vladimir Oltean <OlteanV@gmail.com>, arun.ramadoss@microchip.com, 
	rakesh.sankaranarayanan@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update.  Top posting because I think this is my issue.

I dug further into my problem.  I'm using E2E and it looks like the
mainlined Microchip KSZ DSA PTP code is only supporting P2P.

The 5.10.69 kernel that I was first able to get working with
Christian's early pre-mainlined patches had:
0016-net-dsa-microchip-ksz9477-add-E2E-support.patch

... which gets into the "sticky" bits of why these patches weren't
accepted in the first place due to some Microchip specific
implementation if I recall correctly.

Regards,

Brian


On Thu, Aug 24, 2023 at 2:26=E2=80=AFPM Brian Hutchinson <b.hutchman@gmail.=
com> wrote:
>
> Hi Christian,
>
>
> On Wed, Aug 23, 2023 at 9:29=E2=80=AFAM Brian Hutchinson <b.hutchman@gmai=
l.com> wrote:
> >
> >
> >
> > On Wed, Aug 23, 2023 at 4:22=E2=80=AFAM Christian Eggers <ceggers@arri.=
de> wrote:
> >>
> >> Hi Brian,
> >>
> >> I just return from my holidays...
> >
> >
> > Hope you had a good one ... I need one too!
> >
> >>
> >>
> >> Am Dienstag, 22. August 2023, 23:49:33 CEST schrieben Sie:
> >> > Getting this tx_timestamp_timeout error over and over when I try to =
run ptp4l:
> >> >
> >> > ptp4l[1366.143]: selected best master clock 001747.fffe.70151b
> >> > ptp4l[1366.143]: updating UTC offset to 37
> >> > ptp4l[1366.143]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
> >> > ptp4l[1366.860]: port 1: delay timeout
> >> > ptp4l[1376.871]: timed out while polling for tx timestamp
> >> > ptp4l[1376.871]: increasing tx_timestamp_timeout may correct this
> >> > issue, but it is likely caused by a driver bug
> >> > ptp4l[1376.871]: port 1: send delay request failed
> >> >
> >> > I was using 5.10.69 with Christians patches before they were mainlin=
ed
> >> > and had everything working with the help of Christian, Vladimir and
> >> > others.
> >> >
> >> > Now I need to update kernel so tried 6.3.12 which contains Christian=
s
> >> > upstream patches and I also back ported v8 of the upstreamed patches
> >> > to 6.1.38 and I'm getting the same results with that kernel too.
> >> >
> >>
> >> I am also in the process of upgrading to 6.1.38 (but not really tested=
).
> >> I cherry-picked all necessary patches from the latest master (see atta=
ched
> >> archive). Maybe you would like to compare this with your patch series.
> >
> >
> > Excellent, I will check it out!  Yeah, we needed to be on a LTS kernel =
so that's why I'm focusing on 6.1.38 as it's the latest in the yocto/oe uni=
verse.
>
> So I checked all of your patches for 6.1.38 vs the ones I had.  I had
> all except 0002 and 0003.  I didn't have all of 0001 but I got a build
> error on diff_by_scaled_ppm and back ported that function from 6.3.12
> to make things build.
>
> I applied the missing patches I got from you and rebuilt everything
> and still have the same result with tx_timestamp_timeout.  Which
> didn't surprise me as I mentioned before I tried 6.3.12 mainline and
> get same result there too.
>
> Regards,
>
> Brian
>
> >
> >>
> >>
> >> > [...]
> >> >
> >> > I tried increasing tx_timestamp and it doesn't appear to matter. I
> >> > feel like I had this problem before when first starting to work with
> >> > 5.10.69 but can't remember if another patch resolved it. With 5.10.6=
9
> >> > I've got quite a few more patches than just the 13 that were mainlin=
ed
> >> > in 6.3. Looking through old emails I want to say it might have been
> >> > resolved with net-dsa-ksz9477-avoid-PTP-races-with-the-data-path-l.p=
atch
> >> > that Vladimir gave me but looking at the code it doesn't appear
> >> > mainline has that one.
> >>
> >> How is the IRQ line of you switch attached? I remember there was a pro=
blem
> >> with the IRQ type (edge vs. level), but I think this has already been
> >> applied to 6.1.38 (via -stable).
> >
> >
> > So that's one of the first things I thought of which is why I provided =
cat of /proc/interrupts.
> >
> > I also do have a /dev/ptp1 (/dev/ptp0 is imx8mm)
> >
> > My device tree node is the same as before:
> >
> >          i2c_ksz9567: ksz9567@5f {
> >                compatible =3D "microchip,ksz9567";
> >                reg =3D <0x5f>;
> >                phy-mode =3D "rgmii-id";
> >                status =3D "okay";
> >                interrupt-parent =3D <&gpio1>;
> >                interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
> >
> >                ports {
> >                        #address-cells =3D <1>;
> >                        #size-cells =3D <0>;
> >                        port@0 {
> >                                reg =3D <0>;
> >                                label =3D "lan1";
> >                        };
> >                        port@1 {
> >                                reg =3D <1>;
> >                                label =3D "lan2";
> >                        };
> >                        port@6 {
> >                                reg =3D <6>;
> >                                label =3D "cpu";
> >                                ethernet =3D <&fec1>;
> >                                phy-mode =3D "rgmii-id";
> >                                fixed-link {
> >                                        speed =3D <100>;
> >                                        full-duplex;
> >                                };
> >                        };
> >                };
> >        };
> >
> > And I have same pinmux setup as before.  I double checked all of that.
> >
> > I noticed new kernel /proc/interrupts now has a bunch of ksz lines in a=
ddition to "gpio-mxc  10 Level" which is IRQ from the ksz switch.
> >
> > Here is what the old 5.10.69 /proc/interrupts looked like:
> >
> > cat /proc/interrupts
> >           CPU0       CPU1       CPU2       CPU3
> > 11:      46141        127        127        124     GICv3  30 Level    =
 arch_timer
> > 14:       5260          0          0          0     GICv3  79 Level    =
 timer@306a0000
> > 15:          0          0          0          0     GICv3  23 Level    =
 arm-pmu
> > 20:          0          0          0          0     GICv3 127 Level    =
 sai
> > 21:          0          0          0          0     GICv3  82 Level    =
 sai
> > 32:          0          0          0          0     GICv3 110 Level    =
 30280000.watchdog
> > 33:          0          0          0          0     GICv3 135 Level    =
 sdma
> > 34:          0          0          0          0     GICv3  66 Level    =
 sdma
> > 35:          0          0          0          0     GICv3  52 Level    =
 caam-snvs
> > 36:          0          0          0          0     GICv3  51 Level    =
 rtc alarm
> > 37:          0          0          0          0     GICv3  36 Level    =
 30370000.snvs:snvs-powerkey
> > 39:          0          0          0          0     GICv3  64 Level    =
 30830000.spi
> > 40:       1412          0          0          0     GICv3  59 Level    =
 30890000.serial
> > 42:      55291          0          0          0     GICv3  67 Level    =
 30a20000.i2c
> > 43:          0          0          0          0     GICv3  68 Level    =
 30a30000.i2c
> > 44:          0          0          0          0     GICv3  69 Level    =
 30a40000.i2c
> > 45:          0          0          0          0     GICv3  70 Level    =
 30a50000.i2c
> > 47:          0          0          0          0     GICv3  55 Level    =
 mmc1
> > 48:       3003          0          0          0     GICv3  56 Level    =
 mmc2
> > 49:       2565          0          0          0     GICv3 139 Level    =
 30bb0000.spi
> > 50:          0          0          0          0     GICv3  34 Level    =
 sdma
> > 51:          0          0          0          0     GICv3 150 Level    =
 30be0000.ethernet
> > 52:          0          0          0          0     GICv3 151 Level    =
 30be0000.ethernet
> > 53:       1417          0          0          0     GICv3 152 Level    =
 30be0000.ethernet
> > 54:          0          0          0          0     GICv3 153 Level    =
 30be0000.ethernet
> > 56:          0          0          0          0     GICv3 130 Level    =
 imx8_ddr_perf_pmu
> > 60:          0          0          0          0  gpio-mxc   3 Level    =
 bd718xx-irq
> > 67:         23          0          0          0  gpio-mxc  10 Level    =
 0-005f
> > 72:          0          0          0          0  gpio-mxc  15 Edge     =
 30b50000.mmc cd
> > 217:          0          0          0          0  bd718xx-irq   5 Edge =
     gpio_keys
> > IPI0:        29         14         13         13       Rescheduling int=
errupts
> > IPI1:         0         41         41         41       Function call in=
terrupts
> > IPI2:         0          0          0          0       CPU stop interru=
pts
> > IPI3:         0          0          0          0       CPU stop (for cr=
ash dump) interrupts
> > IPI4:         0          0          0          0       Timer broadcast =
interrupts
> > IPI5:      7959          0          0          0       IRQ work interru=
pts
> > IPI6:         0          0          0          0       CPU wake-up inte=
rrupts
> > Err:          0
> >
> > I'll check out your 6.1.38 changes compared to what I did.
> >
> > Thanks,
> >
> > Brian
> >
> >>
> >>

