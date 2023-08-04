Return-Path: <netdev+bounces-24504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9330C770664
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44241C20CBC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BC1AA60;
	Fri,  4 Aug 2023 16:54:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38F198BA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:54:43 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42A746B1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:54:41 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-447a3d97d77so1018938137.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691168081; x=1691772881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54IgYWW4ZMPvtaxEboRz9NGB20nt0nl5l0+8sVW/viE=;
        b=RkYhRqCBnlpbJc3F1PcsJLhqGkhfrA75zJTFAgKcANVQv1aOAvoBh3BgwCIGCDbgxi
         jXt5qs6zRhUu+PP8A7R0OvESoKJROFJb9vH5aHiNTmMJqUYbSMT/MAgrqDrkvghaT2Vs
         WoaQA8OY/8l/hqeNs7B4G+huqW8n26EI/b3TjRqUWPHjvjPyyBxQei+f6voYCQHk9wpP
         zRuoM+JszZ4m5WXvs38VretjXIV9lBiSJ7Ai54XvxMbO0u44hlF/Gk+U86FZ4gZZmpRe
         3LAc6221tSH07bq+P2GleS79z1WQ4ASFQAJ6LzU+UA8e6Q22Gs73JsenMl5/qLSzJbIz
         qtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168081; x=1691772881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54IgYWW4ZMPvtaxEboRz9NGB20nt0nl5l0+8sVW/viE=;
        b=TS3EIxqgX9xE227eaXmaazf9/F9NgWumNodEhi0dGaBc1pbdu8Z/7feHf2NPJk9ho+
         jdOOcc33aZ/BZgMV7CWHJb56eHN1+t5aIsLzOD+X2r3gD2wRRiLamxwCAvC0lDVJlf5N
         KBQ6UdQYqOGQRbKj+2/96GaPkQWRYrwWZVxtk4YR9mzBSTt/6CHNQtP2VchZx49G2owd
         t+/FkDntbApYAI0xY2l74gTDxIjVPV9TXTsP398vcDiIrIGrBw+CcGL9BX5jJ/wArNOX
         +fe7y22aFPtCFU/wipjrCfaYUAKH5IQuypDpfHax1SAzKoyp8Rj2c+ZZmy4Q0jKpsC8J
         Anig==
X-Gm-Message-State: AOJu0Yzk9XHQC9dhbMqxuvrtY/EQIX/KDRbiCe+8PYRbEfBUpUjYwYcn
	vEM4uysueWDWUH/1gh8CIQyeIGD6NQmp/HRuiD4o309uekliBp17
X-Google-Smtp-Source: AGHT+IHKs1OgapRWNM/ErWvi+4Hrbz+MQG8ZgaBq+vxKTIFeKiht3rQXF6DXqsfPORXrYYOopdR8+sG6KMVuWIJ9N6A=
X-Received: by 2002:a67:fb99:0:b0:447:8d49:bfe9 with SMTP id
 n25-20020a67fb99000000b004478d49bfe9mr1753068vsr.24.1691168080821; Fri, 04
 Aug 2023 09:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:54:40 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com> <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
Date: Fri, 4 Aug 2023 12:54:40 -0400
Message-ID: <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-04, Nick Bowler <nbowler@draconx.ca> wrote:
> On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
>> On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> =
wrote:
>>>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>>>   Author: Robert Hancock <robert.hancock@calian.com>
>>>   Date:   Thu Jan 27 10:37:36 2022 -0600
>>>
>>>       arm64: dts: zynqmp: Added GEM reset definitions
>>>
>>> Reverting this fixes the problem on 5.18.  Reverting this fixes the
>>> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
>>> these versions, with this change reverted, the network device appears
>>> without delay.
>>
>> With the above change, the kernel is going to be waiting for the reset
>> driver which either didn't exist or wasn't enabled in your config
>> (maybe kconfig needs to be tweaked to enable it automatically).
>
> The dts defines a reset-controller node with
>
>   compatible =3D "xlnx,zynqmp-reset"
>
> As far as I can see, this is supposed to be handled by the code in
> drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
> and I have that set to "y", and it appears to be getting compiled in (tha=
t
> is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

Oh, I get it, to include this driver I need to also enable:

  CONFIG_RESET_CONTROLLER=3Dy

Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it?
I guess the reset-zynqmp.o file that was in my build directory must
have been leftover garbage from a long time ago.

However, even with this option enabled, 6.5-rc4 remains broken (no
change in behaviour wrt. the network device).  I will bisect this
now.

Cheers,
  Nick

