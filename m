Return-Path: <netdev+bounces-24492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A77705DB
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F8C2827D1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FBE198B1;
	Fri,  4 Aug 2023 16:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE218054
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:24:05 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EAC49D4
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:24:04 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-447a3d97d77so1003713137.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691166243; x=1691771043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmkPH1Bvr/jHuXA813MIlzTOyB5g7yoVu7rMhg38M04=;
        b=XnI4Z6pkgjcmwtZpv8x6FMkee1/nibtf7Ma/Bxz1Z3xMUHTxRp7FGYhpBQudDChZXX
         qP+kzEQ9lw5o8Yj/sUnF7h5Wb82rIzuxXhfPad0xDXifitsP4yRPzL270zEf5zVZgfwt
         1eDuI5+7HvHW1qWSAfkz8yQWcQsDdT1mIIsPfclZx654XRFuZg0xSCLKm1ql0koFaDYw
         L2Ju/zD2mZEl2v6c+79OyU/DnpOvN7hlw5K3aPENfkdXLdQ0/pAGpggRTiq/CaaxFRwM
         1s7QOW8h3djqEk9l6jc4o9QJbDcDP2wJwwkmJGxa2+vbtpxfNzoXRrJQNdIuP/AfpcSM
         mx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166243; x=1691771043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmkPH1Bvr/jHuXA813MIlzTOyB5g7yoVu7rMhg38M04=;
        b=Vqtkii0M/wpYP7OSQJLmGiWuwhPDu2j9h6pnPZwqEoOxlxTy17GSg1RoATSE6lIN7U
         Msm/9G1MX9tUibv3Al1VDVr157kGNQTpmi28QO2Wz7E6LicuHVDXPTmny1jXMQYtChTW
         CTczPI2b77KaygOEP9mI55YSzEGTx9AjrBds1huE3XrAFloPYxKyW5Fr4cVPjSIBeDb1
         qhrcOv/0sWt//e19Tv0BmiI04fUpuFYhqZMFId4bNBP8okND62CEa5gjRgogEXtvKzta
         c7+kqptGcKJvwdvnp8zBW/h4zJfPyIJGfyb1rkkL8aAMbqo3RrY1YphSoYivi/gWGTuU
         VEtg==
X-Gm-Message-State: AOJu0YyRtfeZzaj+I+K0xjzmQuIWk4x1rI9TsJwQkRDuaBx8xbll2ttc
	4YfILwWrg0RvR3RFDLYhoznhuMKqY9nQ/v29gG7/11ovAIZH8Dt+
X-Google-Smtp-Source: AGHT+IGI+M2wXRRcEDRe0zlkG6F9e0Pa2pCE+U3TAl/AgeY1J+EybttwtFgXosRog6vBFBA4Gmufj5GHXTGOx1DCYnc=
X-Received: by 2002:a67:cd0a:0:b0:447:c1fd:4846 with SMTP id
 u10-20020a67cd0a000000b00447c1fd4846mr1835625vsl.22.1691166243247; Fri, 04
 Aug 2023 09:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:24:02 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 12:24:02 -0400
Message-ID: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> w=
rote:
>>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>>   Author: Robert Hancock <robert.hancock@calian.com>
>>   Date:   Thu Jan 27 10:37:36 2022 -0600
>>
>>       arm64: dts: zynqmp: Added GEM reset definitions
>>
>> Reverting this fixes the problem on 5.18.  Reverting this fixes the
>> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
>> these versions, with this change reverted, the network device appears
>> without delay.
>
> With the above change, the kernel is going to be waiting for the reset
> driver which either didn't exist or wasn't enabled in your config
> (maybe kconfig needs to be tweaked to enable it automatically).

The dts defines a reset-controller node with

  compatible =3D "xlnx,zynqmp-reset"

As far as I can see, this is supposed to be handled by the code in
drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
and I have that set to "y", and it appears to be getting compiled in (that
is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

However, unlike with the other firmware devices, I do not see this driver
under /sys/bus/platform/drivers, and there is no "driver" symlink under
/sys/bus/platform/devices/firmware:zynqmp-firmware:reset-controller

Is there some other config option that I need?  Is the reset driver just
completely not working?

>> Unfortunately, it seems this is not sufficient to correct the problem on
>> 6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
>> a new, different problem?
>
> Probably. You might check what changed with fw_devlink in that period.
> (Offhand, I don't recall many changes)
>
>> I guess I can kick off another bisection to find out when this revert
>> stops fixing things...
>
> That always helps.

I'll do that.

Thanks,
  Nick

