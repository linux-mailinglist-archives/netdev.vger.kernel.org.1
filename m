Return-Path: <netdev+bounces-56604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92180F9A1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EED282072
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7DF64149;
	Tue, 12 Dec 2023 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrn4Jmrw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCACB3
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:45:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1e7971db2aso711184166b.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 13:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702417528; x=1703022328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJCdGKISotv2pJZ+hBcpKEM/45HxdS8m491Gp3+BQ4k=;
        b=jrn4JmrwLj/wAYQmTRabSvSJ5jluhWevaSXS8+Wvx0kjluYQ+VLJJE7oXPaPm+SLXe
         aL3rUiQJHI08+wMMocMdzAu6/vRTu1zfrQOiWUNqsH626nkGmRZiTIjAeM7v2E95xv6q
         w+2aqXe77wi1QFnQvveXOISK6AvSVGFLkPBZta0T/1f5JUkA2iyrlAOmAsP0aKvY/kws
         YBvGsN/vUYs6Qs7j5NRIJcN9lUiwaOsH4yMbtUekdb6rZxCgRHDpIM/8hIcyCebAnLoN
         oxpK1hZAQlvWmEOADv9xyO9q5kl7b98GOhUrcLO9knhBHYhuPl9gSBMgcKg7VSj9ggoT
         USRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702417528; x=1703022328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCdGKISotv2pJZ+hBcpKEM/45HxdS8m491Gp3+BQ4k=;
        b=MGoMdU2k/1jKZHfMUtJO6KItCTDbEGC3WeFn2uxUwAVnJ92ulVUgc20MSZpkuFVZLL
         DLjnyLaFUZpK/tTtQME7SlamOv7HckYCdUQ9zfxfyUKtMzc/i7lizsDByNdF2eFfhadq
         FH5m4Fu7ZvorSlzIGlNOTc/bthIk7BFea6d2oEXrp/shg5kVK/tIq3447lFFFMvi7MdN
         OLZWjOv/kg9Fi931/vmqP5IHOI9Z/WykqdWAw/afx173gcNX9CTY/Euz6U8qO1NYI9BN
         ukKaQFAdZ/ZBsTgw2SW77WrXw8ap4gHGMP4h/n9wA4LFJ9hrOnyIKQNGZxtTlebihbrO
         5CcQ==
X-Gm-Message-State: AOJu0Yx87vc8uTL8cY/vluw0+cWdWAYsQQxlOvNAko0FHN5SN6hjdTdr
	p+ObTLmIAP00FFCYDAln6jOSKeJeAcCItgiyvX/QBw==
X-Google-Smtp-Source: AGHT+IGf5gzmD+F1vkXOu2tcCBuGrRoRRXqRBUwUV+cVy2Hso3cw8EdmMC/vWvmcYkVNE5dnxlCx+uUI1L46s1J0lTg=
X-Received: by 2002:a17:906:2d2:b0:a1f:821a:11ae with SMTP id
 18-20020a17090602d200b00a1f821a11aemr3419980ejk.20.1702417527636; Tue, 12 Dec
 2023 13:45:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MEYP282MB2697C6AC993637C6E866E492BB8FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2697C6AC993637C6E866E492BB8FA@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Tue, 12 Dec 2023 22:44:51 +0100
Message-ID: <CAMZdPi-ZxN+eGpHERe1XQ2hyu==bnwx2oHcbzVFtgcfS1k6C_w@mail.gmail.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
To: Jinjian Song <SongJinJian@hotmail.com>
Cc: "chandrashekar.devegowda@intel.com" <chandrashekar.devegowda@intel.com>, 
	"chiranjeevi.rapolu@linux.intel.com" <chiranjeevi.rapolu@linux.intel.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"danielwinkler@google.com" <danielwinkler@google.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "haijun.liu@mediatek.com" <haijun.liu@mediatek.com>, 
	"jiri@resnulli.us" <jiri@resnulli.us>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, 
	"kuba@kernel.org" <kuba@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxwwan@intel.com" <linuxwwan@intel.com>, 
	"m.chetan.kumar@linux.intel.com" <m.chetan.kumar@linux.intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "nmarupaka@google.com" <nmarupaka@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"ricardo.martinez@linux.intel.com" <ricardo.martinez@linux.intel.com>, 
	"ryazanov.s.a@gmail.com" <ryazanov.s.a@gmail.com>, "vsankar@lenovo.com" <vsankar@lenovo.com>, 
	Joey Zhao <joey.zhao@fibocom.com>, "Qifeng Liu(Qifeng)" <liuqf@fibocom.com>, 
	"Fuqiang Yan(Felix)" <felix.yan@fibocom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinjian,

On Mon, 11 Dec 2023 at 03:06, Jinjian Song <SongJinJian@hotmail.com> wrote:
>
> > > > Mon, Sep 18, 2023 at 08:56:26AM CEST, SongJinJian@hotmail.com wrote=
:
> > > >Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> > > >>>Adds support for t7xx wwan device firmware flashing & coredump
> > > >>>collection using devlink.
> > > >
> > > >>I don't believe that use of devlink is correct here. It seems like =
a misfit. IIUC, what you need is to communicate with the modem. Basically a=
 communication channel to modem. The other wwan drivers implement these cha=
nnels in _ctrl.c files, using multiple protocols. Why can't you do somethin=
g similar and let devlink out of this please?
> > > >
> > > >>Until you put in arguments why you really need devlink and why is i=
t a good fit, I'm against this. Please don't send any other versions of thi=
s patchset that use devlink.
> > > >
> > > > Yes, t7xx driver need communicate with modem with a communication c=
hannel to modem.
> > > > I took a look at the _ctrl.c files under wwan directory, it seemed =
the implementation can be well integrated with QualCommon's modem, if we do=
 like this, I think we need modem firmware change, maybe not be suitable fo=
r current MTK modem directly.
> > > > Except for Qualcomm modem driver, there is also an Intel wwan
> > > > driver 'iosm' and it use devlink to implement firmware
> > > > flash(https://www.kernel.org/doc/html/latest/networking/devlink/io
> > > > sm.html), Intel and MTK design and use devlink to do this work on
> > >
> > > If that exists, I made a mistake as a gatekeeper. That usage looks
> > > wrong.
> > >
> > > > 'mtk_t7xx' driver and I continue to do this work.
> > > >
> > > > I think devlink framework can support this scene and if we use devl=
ink we don't need to develop other flash tools or other user space applicat=
ions, use upstream devlink commands directly.
> > >
> > > Please don't.
>
> > So this is clear that devlink should not be used for this wwan
> firmware upgrade, if you still want to abstract the fastboot protocol par=
t, maybe the easier would be to move on the generic firmware framework, and=
 especially the firmware upload API which seems to be a good fit here? http=
s://docs.kernel.org/driver-api/firmware/fw_upload.html#firmware-upload-api
>
> 1.This API seemed fit here, but I haven't find the refer to use the API, =
codes in /lib/test_firmware.c shown some intruduce, I think if I'm consider=
 how to implement ops.prepare(what to verify, it seemed modem will do that)=
 and ops.poll_complete? And it seemed request_firmware API also can recieve=
 the data from use space, is it a way to use sysfs to trigger request firmw=
are to kernel?
>
> In addition to this, I may have to create sysfs interface to pass the fir=
mware partition parameter.And find a nother way to export the coredump port=
 to user space.
>
> 2.How about we add a new WWAN port type, abstract fastboot and dump chann=
el, like WWAN_PORT_XXX, then use this port with WWAN framework to handle fi=
rmware ops and dump ops.
>
> Hope to get your advice, thanks very much.
>
> I want to implement it use the way of title 2, create a new WWAN port typ=
e used for the channel with modem.

I understand that the firmware update may not be as simple as
submitting a single blob, and so firmware-upload-api may not be easy
to use as is. But can you elaborate a bit on 'abstracting fastboot',
not sure why it is necessary to add another abstraction level when
fastboot is already supported by open source tools/libraries.

Regards,
Loic

