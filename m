Return-Path: <netdev+bounces-42891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF2C7D0887
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF6BB21415
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDEB652;
	Fri, 20 Oct 2023 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19061CA57;
	Fri, 20 Oct 2023 06:33:47 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65432A3;
	Thu, 19 Oct 2023 23:33:44 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-323ef9a8b59so302642f8f.3;
        Thu, 19 Oct 2023 23:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783623; x=1698388423;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zt/QV+A+m2+lk94Yp3iCuYUpdAhjPGwWV2MUu0sAeuA=;
        b=izz3oxuU/WYAaJxccT8XGUnMYQu58EchudB3bnn6zuCNEw9LsPaHLJ2qNF26ShR356
         KWcGM2/l7qV++/NZwdNjGOs3n2wpNIWTBTPeCE+LmfmFXJWwLxlY7fCoJmIED2lWtKr+
         52PRMsYbDmRx1MOr25CZ30TDIxRUWj0xBjA+09Kd9rt6VGutDNR4EktYo+Qz2ByAQIQv
         Y6y+ilUUW/7E0BO/mCHMLbgIPbiT+zPAdkPh2Jwqsg70Ol54LhnXX7A5Di68uN4xV6XO
         0BlfoBRk26PiS65vok8+lll0DxXknhMT75MueTyHraYbj2mKR/BptU4Td27iJ08QBaZ1
         I0Ng==
X-Gm-Message-State: AOJu0Yy5wdZN3NZYAuRrIRbV1k/pIUdv22OTTjPsXikMdHt18x44qB84
	6JmGLL/i6wKP655vOR6Aa4Y=
X-Google-Smtp-Source: AGHT+IGNqsKl6kpfdFm9jTKgDdguNeqQvXM2QnVGaLh+PmnV+mhNX9rAdayn5snLfEmZeuWgX0Mdwg==
X-Received: by 2002:adf:fe87:0:b0:32d:ccef:ec1c with SMTP id l7-20020adffe87000000b0032dccefec1cmr667901wrr.43.1697783622401;
        Thu, 19 Oct 2023 23:33:42 -0700 (PDT)
Received: from [10.148.84.122] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003196b1bb528sm965527wru.64.2023.10.19.23.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:33:41 -0700 (PDT)
Message-ID: <47d463bce1ef62ecb34b666f21d7dd0d7439ac23.camel@inf.elte.hu>
Subject: Re: r8152: error when loading the module
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Hayes Wang <hayeswang@realtek.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
	 <linux-usb@vger.kernel.org>
Date: Fri, 20 Oct 2023 08:33:41 +0200
In-Reply-To: <a05475db018e4e5ea8d24a62e6aab4e4@realtek.com>
References: <aff833bb8b202f12feed5b2682f1361f13e37581.camel@inf.elte.hu>
	 <20231019174514.384ccca8@kernel.org>
	 <a05475db018e4e5ea8d24a62e6aab4e4@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-20 at 05:59 +0000, Hayes Wang wrote:
> [...]
> > > On my machine r8152 module loading takes about one minute.
> > >=20
> > > Its a Debian Sid:
> > > uname -a
> > > Linux pc 6.5.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.5.6-1
> > > (2023-10-07) x86_64 GNU/Linux
> >=20
> > Did this device work fine with older kernels or this is the only
> > one
> > you tried? The code doesn't seem to have changed all that much
> > since
> > RTL8156B support was added.

Thanks for pointing this out. Indeed, its probably not the kernel as I
suggested before, see below.

> >=20
> > > dmesg:
> > >=20
> > >=20
> > > [=C2=A0 899.522306] usbcore: registered new device driver r8152-
> > > cfgselector
> > > [=C2=A0 899.601295] r8152-cfgselector 2-1.3: reset SuperSpeed USB
> > > device number 4 using xhci_hcd
> > > [=C2=A0 927.789526] r8152 2-1.3:1.0: firmware: direct-loading firmwar=
e
> > > rtl_nic/rtl8156b-2.fw
> > > [=C2=A0 942.033905] r8152 2-1.3:1.0: load rtl8156b-2 v2 04/27/23
> > > successfully
>=20
> Someone reports there is an error message when loading rtl8156b-2 v2
> 04/27/23.
> 	r8152 6-1:1.0: ram code speedup mode fail
> I don't find the same message for you.

That line was also in dmesg for sure, I just failed to copy-paste every
related bits.

> However, I check the firmware and find some wrong content.
> Could you remove /lib/firmware/rtl_nic/rtl8156b-2.fw and unplug the
> device.
> Then, plug the device and check it again.

Yes, I'll do that, but strangely enough the error has disappeared since
then. I played with the setup yesterday a little more. The NIC is
actually built into my monitor, which is always powered on - so
regardless if my laptop connected or not, the NIC is probably on. I
rebooted to Windows, and then rebooted to Linux, and magically the bug
just disappeared.

Is this possible/makes sense to you?

>=20
> > > [=C2=A0 956.269444] ------------[ cut here ]------------
> > > [=C2=A0 956.269447] WARNING: CPU: 7 PID: 211 at
> > > drivers/net/usb/r8152.c:7668 r8156b_hw_phy_cfg+0x1417/0x1430
> > > [r8152]
> > > [=C2=A0 956.269458] Modules linked in: r8152(+) hid_logitech_hidpp
> > > uhid ccm
>=20
>=20
> Best Regards,
> Hayes
>=20
>=20

Best,
Ferenc

