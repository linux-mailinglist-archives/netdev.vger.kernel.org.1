Return-Path: <netdev+bounces-25476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF99774383
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D385A1C20E84
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D7D171B0;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C22171BF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03DB83C0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691516124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbnqxuiXQisIH6XjOaSNew/BEqT5g+My50f9mjhVZsE=;
	b=X/kV/5VhKYEXgmOusXPLhgipPpz5He5oMiPdTzXAEW35Db5xedzpoCPI8lEMJ35w0Xc88h
	xOOSop/HK57jIdK6OXrEvOKmXbL3bYGpmL1z4ENEm6hAYagly5in+zSajeHKizZBHmJvRN
	cuB4asgWfkHmi3/joeLET/SRsO7znPk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-MsM9XHR_MKq5kL7WDD3PFw-1; Tue, 08 Aug 2023 10:27:30 -0400
X-MC-Unique: MsM9XHR_MKq5kL7WDD3PFw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63cf6da7d40so64288666d6.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 07:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691504850; x=1692109650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbnqxuiXQisIH6XjOaSNew/BEqT5g+My50f9mjhVZsE=;
        b=P1C0ysFgwuUc5vP8O8EBaF4EVaKZhTzZJGhRtLcbvZl6u3sLb1ICKU19RfU/UPn8z0
         +YWTCR6GDMGt32xZEFTjSHbrAeJjFwzG4u6vq8Ik0OwqQ0S4suIAtblYzvXiaKgRdguD
         fyc9adeTOwW1RRyDq3Aa9oU/yBSy77jUCELsR9FcClgWXkfJq/i53JGLcAHjTG6qnXly
         HAfDuzU6epSgKdWMatrX4qrfvpz/mA3CL3hM8r52sSdK/FB/9kQD/8UmZcRHQcVYv3u6
         BAv2Z0JBzwj8A+tfWwNP7isMtc6eA1MHKidyhe6zZ52+T2tJb01qjSMrfDAtnKdkoVmX
         lmjw==
X-Gm-Message-State: AOJu0YzuFDWhAwWQmjV4LEA3keyvfKJjVGaC/mNTYG9kPgdLeJRz43k5
	TGyrXS0B3ZdDjpBSZh6E/JmphXxmUSBDBwoGYZXobxs2ljj4uEKhlw+M4oJiPPG5ozsKc2oudKA
	t7yLpwb5Sm8KZhBx6
X-Received: by 2002:a0c:e1d4:0:b0:63c:ff08:20f1 with SMTP id v20-20020a0ce1d4000000b0063cff0820f1mr13380066qvl.10.1691504850372;
        Tue, 08 Aug 2023 07:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvKElmz3eZY2ly9zcbNbNf3JHFZdq6y/SHJi6VaPpXTDEO5rg1+t529/wj3RWJcJY8dNswzQ==
X-Received: by 2002:a0c:e1d4:0:b0:63c:ff08:20f1 with SMTP id v20-20020a0ce1d4000000b0063cff0820f1mr13380045qvl.10.1691504850119;
        Tue, 08 Aug 2023 07:27:30 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cf212000000b005dd8b9345b4sm3680637qvk.76.2023.08.08.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:27:29 -0700 (PDT)
Date: Tue, 8 Aug 2023 09:27:27 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios
 property of the PHY
Message-ID: <xklkqdodcho4du26mvds4bxrevvwiaftnu7gu2ukchczd7hgcb@ry3dhjnoprgh>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-6-brgl@bgdev.pl>
 <siqiyihftz3musfjulpcqunhgi7npftumrfwfyh2pqnlx6zeb7@rrpwmkvjshfb>
 <da679b5e-6712-4849-b29c-6aa42022abc4@lunn.ch>
 <ld2j4llgfba6j43gesqxs6wz2baucka5scbj4nef5ehbex2cmt@d4dxsqp2vuoj>
 <CAMRc=MdLky5sUbdFGFc+as906kr-J_XDmKmYtBBCHvETvqtAQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdLky5sUbdFGFc+as906kr-J_XDmKmYtBBCHvETvqtAQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 02:16:50PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 8, 2023 at 12:27 AM Andrew Halaney <ahalaney@redhat.com> wrote:
> >
> > On Mon, Aug 07, 2023 at 11:51:40PM +0200, Andrew Lunn wrote:
> > > > > I have proposed a solution for this problem in 2020 but it never got
> > > > > upstream. Now we have a workaround in place which allows us to hard-code
> > > > > the PHY id in the compatible property, thus skipping the ID scanning).
> > > >
> > > > nitpicky, but I think that already existed at that time :D
> > >
> > > Yes, it has been there are long long time. It is however only in the
> > > last 5 years of so has it been seen as a solution to the chicken egg
> > > problem.
> > >
> > > > >           sgmii_phy: phy@8 {
> > > > > +                 compatible = "ethernet-phy-id0141.0dd4";
> > > > >                   reg = <0x8>;
> > > > >                   device_type = "ethernet-phy";
> > > > > +                 reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> > > > > +                 reset-deassert-us = <70000>;
> > > >
> > > > Doesn't this need reset-assert-us?
> > >
> > > If i remember correctly, there is a default value if DT does not
> > > provide one.
> > >
> >
> > I've been trying to make sure I view devicetree properties as an OS
> > agnostic ABI lately, with that in mind...
> >
> > The dt-binding says this for ethernet-phy:
> >
> >   reset-assert-us:
> >     description:
> >       Delay after the reset was asserted in microseconds. If this
> >       property is missing the delay will be skipped.
> >
> > If the hardware needs a delay I think we should encode it based on that
> > description, else we risk it starting to look like a unit impulse!
> >
> 
> Please note that the mdio-level delay properties are not the same as
> the ones on the PHY levels.
> 
> reset-delay-us - this is the delay BEFORE *DEASSERTING* the reset line
> reset-post-delay-us - this is the delay AFTER *DEASSERTING* the reset line
> 
> On PHY level we have:
> 
> reset-assert-us - AFTER *ASSERTING*
> reset-deassert-us - AFTER *DEASSERTING*
> 
> There never has been any reset-assert delay on that line before. It
> doesn't look like we need a delay BEFORE deasserting the line, do we?
> 

The MDIO reset-delay-us happens "before deassert"/"after assert", so to
make things a proper move here I think it needs a resrt-assert, otherwise
behavior with respect to reset timing is definitely changed from this
patch!

Here's a trimmed version of the reset handling in mdio_bus.c to back
that up:

	/* assert bus level PHY GPIO reset */
	gpiod = devm_gpiod_get_optional(&bus->dev, "reset", GPIOD_OUT_HIGH);
    ...
	} else	if (gpiod) {
		bus->reset_gpiod = gpiod;
		fsleep(bus->reset_delay_us);
		gpiod_set_value_cansleep(gpiod, 0);
		if (bus->reset_post_delay_us > 0)
			fsleep(bus->reset_post_delay_us);
	}

so its assert reset, sleep reset_delay_us, deassert, sleep
reset_post_delay_us for the MDIO case.

Thanks,
Andrew


