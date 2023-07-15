Return-Path: <netdev+bounces-18039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B0F7545B1
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E4D1C21684
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 00:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779C7E8;
	Sat, 15 Jul 2023 00:47:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B340628
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 00:47:56 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6690011C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:47:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6831e80080dso1774062b3a.0
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689382073; x=1691974073;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edKU6aO6Z0ch0HVD3T2f7ZKe2+eOX4XfIz2m0mOYlDs=;
        b=MaKqwklNof5vUnea/5Fg4GS5iwAkQ+zJi7ALmA692dNEPLeRXlxZxN8hgH9RKzScaQ
         tUzOzF0rZ9B1Y/fQS+BbYZrqEZTZ2r7SME467jX9gDgNX4N9DSKZ4zOsLHzKU23wdWXz
         15fnnW9QroW7jG1Kjcwun2bzV2l/0+ehyW2SLIYuiNbN5bMGdt15hcPJUqtFI0kutZzG
         QAK8bC0a8VPEGWhWNlKQ4H5tJ0RfKsw4rc7wub+4z6BWecQ3vdiRU7zzphlAfkiPgkwY
         D9tgyrMFbR+0DL3OBeP0dP6v4XBgdO7J3/EhgkdNLsRmFyykZn/K+jzMV8Rf07Cm5ZiJ
         +6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689382073; x=1691974073;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edKU6aO6Z0ch0HVD3T2f7ZKe2+eOX4XfIz2m0mOYlDs=;
        b=LnHvlmtNWpuiGJu70L0gIz1PCtd9cc+S/GVsDWxJ6/edfE2zO3UAQwC7cTKR3eOz9p
         Iw0ClxepN0nSYH1qwe/9NuHz81lnczUXPkTuy9oqFrk0pgBIjVM0brXVKHyimW5M64Dv
         eBLqWO8n5M5qh2Lj7ujeWu/45uuIATz+D1NCxfmIe++Muih5w0PeLQ1KOMWqvsXFyqEg
         qbAoYiVAPEVOazX3HvKKn1JcUDYsjDpUHk8Nstl0ZhJhN66xOWtKpyL62GSmFWHVoRkO
         jMby4Yn2t9Yj5pmeH2RYNB0Yy3SNtVWMXEskCs/KNkJq6NWB4yd2jTNAPs2hhwklQrb1
         VKMw==
X-Gm-Message-State: ABy/qLZogzpNNw0WUFrJ6+mUvCpJ9AulVOaeF8vOj4nU0c6b+t7DcXfW
	papXi8oiITdVM6M5Nw67pKqXtDv62GWYnQ==
X-Google-Smtp-Source: APBJJlHlbvtQRvpn0jHHAxr/o6ZmvW+wONx/ZAHXLlt3I9VweeqkyiqvWLUVDel74xG5HMgcWa1Asw==
X-Received: by 2002:a17:903:1109:b0:1b3:d6c8:7008 with SMTP id n9-20020a170903110900b001b3d6c87008mr5403141plh.57.1689382073443;
        Fri, 14 Jul 2023 17:47:53 -0700 (PDT)
Received: from smtpclient.apple (2603-8000-7f00-5ab0-89df-d7bc-9f80-76c5.res6.spectrum.com. [2603:8000:7f00:5ab0:89df:d7bc:9f80:76c5])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709027c9500b001b8a3729c23sm8335274pll.17.2023.07.14.17.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 17:47:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: SIMON BABY <simonkbaby@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Query on acpi support for dsa driver
Date: Fri, 14 Jul 2023 17:47:42 -0700
Message-Id: <6FD3BB1E-153F-423D-A134-BFB18F4969D9@gmail.com>
References: <af5a6be0-40e5-4c05-ac25-45b0e913d8aa@lunn.ch>
Cc: netdev@vger.kernel.org
In-Reply-To: <af5a6be0-40e5-4c05-ac25-45b0e913d8aa@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (20F75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thank you Andrew for your inputs .=20
Do I need ACPI tables ( similar to DT ) and changes in the device driver cod=
e for invoking the correct probe function ?

Regards
Simon

Sent from my iPhone

> On Jul 14, 2023, at 4:01 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> =EF=BB=BFOn Fri, Jul 14, 2023 at 12:38:24PM -0700, SIMON BABY wrote:
>> Hello Team ,
>=20
>> I am new to this group . I have a query on adding a switch device (
>> microchip EVB-KSZ9897) to my Intel based x86 board which uses ACPI
>> instead of device tree. The Intel x86 is running Linux Ubuntu 5.15
>> kernel .
>=20
>> Do I need any changes in the drive code to get the acpi table and
>> invoke the functions ? When I looked the code
>> drivers/net/dsa/microchip/ksz9477_i2c.c it has support only for DSA.
>=20
>> Please provide your inputs .
>=20
> ACPI is generally not used for networking. Nobody who cares enough
> about ACPI has taken the time to understand the DT concepts, find the
> equivalent in ACPI, write a proposal to extend the ACPI standard, get
> it accepted in, and then done the implementation work.
>=20
> What some people have tried in the past is just accept DT is the way
> describe this sort of hardware, and stuff all the DT properties into
> ACPI tables. But they often do it wrongly, including all the DT
> legacy, deprecated properties etc.
>=20
> The mv88e6xxx driver can be instantiated via a platform driver. I have
> a couple of x86 targets with drivers placed in drivers/platform/x86
> which instantiate mv88e6xxx instances. For simple setups, using just
> the internal PHYs that is sufficient.
>=20
> Take a look at drivers/platform/x86/asus-tf103c-dock.c and how it uses
> i2c_new_client_device() to instantiate i2c devices. And
> mv88e6xxx_probe() and its use of pdata.
>=20
>    Andrew

