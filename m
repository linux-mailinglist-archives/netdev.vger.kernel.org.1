Return-Path: <netdev+bounces-30461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE667877C5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F3C1C20E68
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE69156FF;
	Thu, 24 Aug 2023 18:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BCFCA76
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:26:44 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A968F1BFF
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:26:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so296507a12.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692901592; x=1693506392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maS5oo/we/VrblVgVI2LM8LVLsMbcJaAjdtp1SJImWI=;
        b=FfAFUmjb0rzlKlJ2WITLbF0t2TU9QTLbY3g1zb3IaED/q6pRW+tlyjrSrX9l6qe9Rr
         hlScAdC448ClQMhrw0aSpejVrutKRtHdpElQPrVbuUyAXj0+QjwJ/XIAP8sCQOlFdSxS
         BbB2JBV9Vh0UVmXPEEY0pOE+u5LDwPV8BWXsdyk3Z5Tsr6JR+RAM24WTNlhZByJKn6WV
         w7PbOq+S0YEDTKgTFCu182CQQPrKD7iTI7ntqKOXxg21PoqwOoUcj+az8AlVae2DBZNL
         16qlE6FR+OcoEQtDIi4YEw441eD98SR7UboZLs1SRSWbGw+3Xr5W8EXnhCj5LiktXgux
         iSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901592; x=1693506392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=maS5oo/we/VrblVgVI2LM8LVLsMbcJaAjdtp1SJImWI=;
        b=e/n/DwMAzS+Ptro0O18ZA/guHpIpvfKUMhBOeCuLOejNgonOeV0WimTINjR23WABpG
         etC2LnzsWscaj9Dz4DzUZNOpR8JElDCL2OvBC764RsiBjyBGoP0bXzXprsXinIxMrntf
         fzUZXr2UlJ9bbsHCe68SQtdVlLotaQU2yvYnDncCHGAot8KNKyrpyC8rIOc7iQmOMK+n
         +9WDAvMW/ElmcM7WHpvayEv/KdBmy/IVbr6HOmIfJxDNm+NHoXs4si3JMlQZ7Yg0pcqe
         i/iE0xhnl5yuGoNj830vruwJ3Ky4Xu4gXyF4E+bndn9TzhsfbvTJdiyAukMmG1oMnif6
         0/9A==
X-Gm-Message-State: AOJu0Ywox7eOUofZEkD640f/2C+PZ0M3b5AwFwCbSAaRoaApx3lDMDIH
	iteuvCBubL5HPgJDkuDJizhRYrFPq2D4Ou/FoCQ=
X-Google-Smtp-Source: AGHT+IFxj+I+G5mQThT2VokwD5Q6uL9Ui5fBn7vAGGzRH0sCR7U3TNu9aRcU81QlvNF2ea9DFlgXWroWcdgvd+G4TAY=
X-Received: by 2002:aa7:d59a:0:b0:525:6d9b:15c6 with SMTP id
 r26-20020aa7d59a000000b005256d9b15c6mr6447434edq.39.1692901591845; Thu, 24
 Aug 2023 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFZh4h9wHtTGFag-JDtjqFEmqnMoW4cTOr_CF3GQwKLb5jigrQ@mail.gmail.com>
 <4860127.31r3eYUQgx@n95hx1g2> <CAFZh4h-6yWvpvzJyv06zy8MbtMmXG==V0h2vU=uUN8iMMcb=ig@mail.gmail.com>
In-Reply-To: <CAFZh4h-6yWvpvzJyv06zy8MbtMmXG==V0h2vU=uUN8iMMcb=ig@mail.gmail.com>
From: Brian Hutchinson <b.hutchman@gmail.com>
Date: Thu, 24 Aug 2023 14:26:20 -0400
Message-ID: <CAFZh4h-0PBrFh1pDr6Jfg95rF6wUt1o=k=-EgG+8MxN7pnyiAw@mail.gmail.com>
Subject: Re: Microchip net DSA with ptp4l getting tx_timeout failed msg using
 6.3.12 kernel and KSZ9567 switch
To: Christian Eggers <ceggers@arri.de>
Cc: netdev@vger.kernel.org, Vladimir Oltean <OlteanV@gmail.com>, arun.ramadoss@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Christian,


On Wed, Aug 23, 2023 at 9:29=E2=80=AFAM Brian Hutchinson <b.hutchman@gmail.=
com> wrote:
>
>
>
> On Wed, Aug 23, 2023 at 4:22=E2=80=AFAM Christian Eggers <ceggers@arri.de=
> wrote:
>>
>> Hi Brian,
>>
>> I just return from my holidays...
>
>
> Hope you had a good one ... I need one too!
>
>>
>>
>> Am Dienstag, 22. August 2023, 23:49:33 CEST schrieben Sie:
>> > Getting this tx_timestamp_timeout error over and over when I try to ru=
n ptp4l:
>> >
>> > ptp4l[1366.143]: selected best master clock 001747.fffe.70151b
>> > ptp4l[1366.143]: updating UTC offset to 37
>> > ptp4l[1366.143]: port 1: LISTENING to UNCALIBRATED on RS_SLAVE
>> > ptp4l[1366.860]: port 1: delay timeout
>> > ptp4l[1376.871]: timed out while polling for tx timestamp
>> > ptp4l[1376.871]: increasing tx_timestamp_timeout may correct this
>> > issue, but it is likely caused by a driver bug
>> > ptp4l[1376.871]: port 1: send delay request failed
>> >
>> > I was using 5.10.69 with Christians patches before they were mainlined
>> > and had everything working with the help of Christian, Vladimir and
>> > others.
>> >
>> > Now I need to update kernel so tried 6.3.12 which contains Christians
>> > upstream patches and I also back ported v8 of the upstreamed patches
>> > to 6.1.38 and I'm getting the same results with that kernel too.
>> >
>>
>> I am also in the process of upgrading to 6.1.38 (but not really tested).
>> I cherry-picked all necessary patches from the latest master (see attach=
ed
>> archive). Maybe you would like to compare this with your patch series.
>
>
> Excellent, I will check it out!  Yeah, we needed to be on a LTS kernel so=
 that's why I'm focusing on 6.1.38 as it's the latest in the yocto/oe unive=
rse.

So I checked all of your patches for 6.1.38 vs the ones I had.  I had
all except 0002 and 0003.  I didn't have all of 0001 but I got a build
error on diff_by_scaled_ppm and back ported that function from 6.3.12
to make things build.

I applied the missing patches I got from you and rebuilt everything
and still have the same result with tx_timestamp_timeout.  Which
didn't surprise me as I mentioned before I tried 6.3.12 mainline and
get same result there too.

Regards,

Brian

>
>>
>>
>> > [...]
>> >
>> > I tried increasing tx_timestamp and it doesn't appear to matter. I
>> > feel like I had this problem before when first starting to work with
>> > 5.10.69 but can't remember if another patch resolved it. With 5.10.69
>> > I've got quite a few more patches than just the 13 that were mainlined
>> > in 6.3. Looking through old emails I want to say it might have been
>> > resolved with net-dsa-ksz9477-avoid-PTP-races-with-the-data-path-l.pat=
ch
>> > that Vladimir gave me but looking at the code it doesn't appear
>> > mainline has that one.
>>
>> How is the IRQ line of you switch attached? I remember there was a probl=
em
>> with the IRQ type (edge vs. level), but I think this has already been
>> applied to 6.1.38 (via -stable).
>
>
> So that's one of the first things I thought of which is why I provided ca=
t of /proc/interrupts.
>
> I also do have a /dev/ptp1 (/dev/ptp0 is imx8mm)
>
> My device tree node is the same as before:
>
>          i2c_ksz9567: ksz9567@5f {
>                compatible =3D "microchip,ksz9567";
>                reg =3D <0x5f>;
>                phy-mode =3D "rgmii-id";
>                status =3D "okay";
>                interrupt-parent =3D <&gpio1>;
>                interrupts =3D <10 IRQ_TYPE_LEVEL_LOW>;
>
>                ports {
>                        #address-cells =3D <1>;
>                        #size-cells =3D <0>;
>                        port@0 {
>                                reg =3D <0>;
>                                label =3D "lan1";
>                        };
>                        port@1 {
>                                reg =3D <1>;
>                                label =3D "lan2";
>                        };
>                        port@6 {
>                                reg =3D <6>;
>                                label =3D "cpu";
>                                ethernet =3D <&fec1>;
>                                phy-mode =3D "rgmii-id";
>                                fixed-link {
>                                        speed =3D <100>;
>                                        full-duplex;
>                                };
>                        };
>                };
>        };
>
> And I have same pinmux setup as before.  I double checked all of that.
>
> I noticed new kernel /proc/interrupts now has a bunch of ksz lines in add=
ition to "gpio-mxc  10 Level" which is IRQ from the ksz switch.
>
> Here is what the old 5.10.69 /proc/interrupts looked like:
>
> cat /proc/interrupts
>           CPU0       CPU1       CPU2       CPU3
> 11:      46141        127        127        124     GICv3  30 Level     a=
rch_timer
> 14:       5260          0          0          0     GICv3  79 Level     t=
imer@306a0000
> 15:          0          0          0          0     GICv3  23 Level     a=
rm-pmu
> 20:          0          0          0          0     GICv3 127 Level     s=
ai
> 21:          0          0          0          0     GICv3  82 Level     s=
ai
> 32:          0          0          0          0     GICv3 110 Level     3=
0280000.watchdog
> 33:          0          0          0          0     GICv3 135 Level     s=
dma
> 34:          0          0          0          0     GICv3  66 Level     s=
dma
> 35:          0          0          0          0     GICv3  52 Level     c=
aam-snvs
> 36:          0          0          0          0     GICv3  51 Level     r=
tc alarm
> 37:          0          0          0          0     GICv3  36 Level     3=
0370000.snvs:snvs-powerkey
> 39:          0          0          0          0     GICv3  64 Level     3=
0830000.spi
> 40:       1412          0          0          0     GICv3  59 Level     3=
0890000.serial
> 42:      55291          0          0          0     GICv3  67 Level     3=
0a20000.i2c
> 43:          0          0          0          0     GICv3  68 Level     3=
0a30000.i2c
> 44:          0          0          0          0     GICv3  69 Level     3=
0a40000.i2c
> 45:          0          0          0          0     GICv3  70 Level     3=
0a50000.i2c
> 47:          0          0          0          0     GICv3  55 Level     m=
mc1
> 48:       3003          0          0          0     GICv3  56 Level     m=
mc2
> 49:       2565          0          0          0     GICv3 139 Level     3=
0bb0000.spi
> 50:          0          0          0          0     GICv3  34 Level     s=
dma
> 51:          0          0          0          0     GICv3 150 Level     3=
0be0000.ethernet
> 52:          0          0          0          0     GICv3 151 Level     3=
0be0000.ethernet
> 53:       1417          0          0          0     GICv3 152 Level     3=
0be0000.ethernet
> 54:          0          0          0          0     GICv3 153 Level     3=
0be0000.ethernet
> 56:          0          0          0          0     GICv3 130 Level     i=
mx8_ddr_perf_pmu
> 60:          0          0          0          0  gpio-mxc   3 Level     b=
d718xx-irq
> 67:         23          0          0          0  gpio-mxc  10 Level     0=
-005f
> 72:          0          0          0          0  gpio-mxc  15 Edge      3=
0b50000.mmc cd
> 217:          0          0          0          0  bd718xx-irq   5 Edge   =
   gpio_keys
> IPI0:        29         14         13         13       Rescheduling inter=
rupts
> IPI1:         0         41         41         41       Function call inte=
rrupts
> IPI2:         0          0          0          0       CPU stop interrupt=
s
> IPI3:         0          0          0          0       CPU stop (for cras=
h dump) interrupts
> IPI4:         0          0          0          0       Timer broadcast in=
terrupts
> IPI5:      7959          0          0          0       IRQ work interrupt=
s
> IPI6:         0          0          0          0       CPU wake-up interr=
upts
> Err:          0
>
> I'll check out your 6.1.38 changes compared to what I did.
>
> Thanks,
>
> Brian
>
>>
>>

