Return-Path: <netdev+bounces-38789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB27BC849
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC891C20935
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C4286BE;
	Sat,  7 Oct 2023 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z3HN8LcV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30C125DC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:11:54 +0000 (UTC)
Received: from sonic308-54.consmr.mail.gq1.yahoo.com (sonic308-54.consmr.mail.gq1.yahoo.com [98.137.68.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994CBC
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 07:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696687912; bh=Ue2gXrJSqq2PANQshqLf9rtSYgbFsNy7/Wmg1/ARSyE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Z3HN8LcV243UVjlZ70POSip5guqCifvYzIrq9g3HHhPWW5feY06og3ilQRCEBj+9UGL+Ukd+iNRQkyCvCOVp3ERcoQdkfA3TQF9RsHx/HxqgiiCeSiE6E6TWCXF90TMNlR6kjq1PVuywX8JXDvSGqYFbswbyBnd0g6JF+xuzT/z9mqJELtfcxq3rvvWs0Vure4dgZdLKJ2Sri9uCk5sHT2n6HVrJE39Et2xvLpfVTS/6EzY3iMzJR216C50Q3Vl7WHft/ft4yoBVCzdsCXcC83iBLFhxyuwQ9X+53a8q7pwSmMyCeehmGW3ncVrNoIvhTlde2xUPihwX6FdWzT5UHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696687912; bh=5Fl3ORLB4917FMIFP3PAiOGzI5YPIUe0ynivjiDzrqE=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=KDCs7Z4lxUbReGa8+v3aX2reQMWupMsMn5J/BZ8+boEKMAh8s/WYj8dodND6trSA8y1/M0on+3jL2pxX4dNfC3kV7Gpt6YfIiZ4wvDVSr0+DrXM91XYwOy5uRKTliNvjp5oDMZRTWQfJubtZyqmqqGp+aEfyaFu6tkE8SHUf4MERHvNiQniturAzmkRi+qjav08MPnzYxMZChN+bIDvkFQboNC1C/GQRZ2vTTCILrx98C5998GgqnHG05YxHduJVusb05CK/KFLUon3Nk65AMI5SBn1f7RzkYkKIuF3AhLblAjceeGdcznnO6O+y9N+ieYkkL2MrBxZHbQqqVttZuw==
X-YMail-OSG: QkAHM_8VM1n6jIVgcAagfSijSO1.zHBKp2i0UBkGJhdjZxdlEJMOMvZq6gELVgT
 tP9VIL_cHHGvUIo1F1ZxzWZQqlk_KGCJYqd7.SbcmEcDqgEef8YPTfJcqwoka.lX5T9NMd82g50l
 b3TwaqYHbBxD6kHeuf0PY.yHljaVaRMdEhmUSL6WDH_ShKZCAmZgv1tbA2o245PHY9YTT8Sbk_uv
 ecEa40eiRc3K4G8RlXncOzjcGm6yHnSI8E9Sl4HofhCMsoO1n5DiC6Oh_XAWv46jTKm0Q_Nn83zg
 saEDddTywkYyW7IShuFjHYIgsi10a4CfXFgT.g._sbwmweebJWxWLAqW50j3IKODKnq8oU_r5O7h
 rBim6pGbo_1WMm1zXVuBqvAm0iUmZTlFzoH4fDUxWXBpjUCuu84PRWnxGYcB.PviSrZeOle5k9iY
 pBiCThRwyXaEeWITuXH7Lu76V1yv4yiNJSH06QJRkEaGK8CIXlNY30paImCJM6Gf.0HnwocfXkna
 4x_.LCbEtjelWfFNLwLvIEnAGmTNQXtU7OZkZ.r.rmVhWFSo2hBljgllQ6K4.2hKdFdZwIQxvNVe
 tKly2X4vDwV6PAeNlUd0nvbyaTx7KAjhblMPxpQJy_cCYGXa0aW1_vpe_0z5tm8jd7Zm.z_.smlD
 OfPvLR_cyxwYDYTZxVg1qsKt2g.QwSQHAcDm0WVIU4vNYWsPxwpmEtaN84BYdyGn_xHEWBft_yf3
 iIbfOKKIPN.m2RgBucFB7U8MBCPV9FdDaCXKjxTXM8Hk7xt2P82PjHisrvxsEzY8Cfy4WFrFP7Wn
 diyyIjWstFyD.EwbeoTd7WzO6GnhJyfWjliW3G0GoqhnrYYQaCK9JNxGLHKEbEjt1d7XSEJY2TEe
 sAfSBTb13hMz0fkwMnuxASazHhoZjYyN_VDQvUx5Hlsz547Fz9TI_w2A1nu3L3908M0GoTbJi1ZC
 Rz6uPjWz6IhWoQeK2YZr4oDTmvZLN1yuovp6F3Wto7rUmXRh66FqPy5EvH5XeR3_ZBp322SD5GJz
 rTv8hJXiwhfR3Kv5iWhBEFGstdZqqmktvSQrcoKYg0nR4j42maNBdfHS8EgiuzFGPVuqou123f4E
 MXegwbm4Q1ttKtYbTvl8W5xKUSMc74CMgBXLbIn.21lnbLTsLE2cj9gUbu6Hx8YDEufewS554Tj3
 HNF_0xsr3G_BPVF1ElktLg7aA6MqaUblN9MnBABW2BMN3Tm3FQT6c.5jk8y76QHS.0in9aP_VU8y
 Jo4YMafDTxN5BcqqqFDH2KmJ_g2Ai1VL4QVnXxSbhxbqg_4lA3KqUeNrsYRkStPU375xFFzgmFMc
 pOnjR0wnVfceyV.c_HbJrsqZs03vddJNv.v.JIHW6AtCFRBk9WNLAPa91oUg2YZ6dzO535zKx2Yy
 EZVPsmUWi42l4N_UPDF0YQfNl_uxJcXg1kUl5VteeavaMLdKvJ2Lzg2XyP7YL4NVoJOW2a_9aIZE
 N1R_oGfshfj4R6oq1jJGAzt8JQ._Cje4ijOVvjH5sKFuf8uMcRYBdmnaHwoDQg6PTft5QwqfksLr
 .u_rBWL.8cVimckP_ZvcLgk7US6VF60x3D.tdYU5xWYWxdzQsrBingrYhztC2ngunVXaKw7GuEkk
 eNiEvDaOn6E6LQDnTB.DGLHvuXdcFci_2ow9cIhDZecmqpyW8fmPD0fgD5v5eSaaRpWF8eJcHJDu
 3ipntS6GhUijfI8ftpJzqVGvYOeD820YkwRMNcngJ9rG25aNDMbNIoZSKAm7aLz20LBrme2a0y4Y
 Dg0NeB6X6FwGaISgbsMlAeBz1uD3tNmSz_Ti.Cck9V0lrMzcobkLgzJpObN9HOrLYtV06qyGOgCV
 gXqG1nuUD3pEJ.OmUAeoPZx3enRcYS3cLTjyvq_T5DesUvICRW3liKgcAkCVfG.2hW6Ml9r3fov_
 R3lMtO67gjBwUgrEDUo6WmJO19rZC3FLEamdSaCD6jD1SVsowE.mGCD1U90YgzUw1qJ5JtD8cHPi
 p8yJ2TyT0VHJl4a2Tuvvt5ih8EI8MhJV2KB0dzttFuShwJIyfJGMewcSB9xCo5uQA8qODAuMowTb
 aUg8ekaeV8TQNVFbrPKpwYii0VU6U7pWa.eF0_Ucj0_O8rEjF3VU3b5zhccI_BSZN6uqWrc.9pKr
 M.QqgwnhFlatrltPtAtWZt4fljbp_4GTwpVvryF4DsmZ9EkjWcaodBLVjTFZhZRiy_tnIVS40ok6
 8oRI2azJ0rK_Zn2xDeH3Dg03GAuLL1s5vXbSZ1HZZ
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 7d8c560e-4094-45fb-8448-75b37fb1f4e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 7 Oct 2023 14:11:52 +0000
Date: Sat, 7 Oct 2023 14:11:47 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Linux Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Julia Lawall <julia.lawall@inria.fr>
Message-ID: <645495259.3051218.1696687907082@mail.yahoo.com>
In-Reply-To: <ZSEdS8a5imvsAE8F@debian.me>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com> <875007189.3298572.1696619900247@mail.yahoo.com> <ZSEdS8a5imvsAE8F@debian.me>
Subject: Re: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

LINYX(R) is a C project, one of the few left.
This is the right mailing list.






On Saturday, October 7, 2023 at 04:56:51 AM EDT, Bagas Sanjaya <bagasdotme@=
gmail.com> wrote:=20





On Fri, Oct 06, 2023 at 07:18:20PM +0000, chaosesqueteam@yahoo.com wrote:
> Dear RMS;
>=20
> I've read that you are both a lisp and C developer. I cannot get any cont=
ributors for the longstanding C 3d engine I work on as part of my fully-fre=
e-software (including media) 3d game/architecture project. I've been workin=
g on it alone for 10 years but now have branched into supporting more 3d fi=
le types and can't do that alone.
>=20
> I've gone to "opensource" forums and gotten banned every single time for =
asking for help. Every single time. The message gets deleted. This is extre=
mely difficult: it's not like 20 years ago when communication was free. Obv=
s the "opensource" community is no longer interested in any collaboration o=
r development.
>=20
> The reason I wanted to find more contributors, is that I recently (last 2=
 years) programmed more file format support myself (wolfenstine:enemyterrit=
ory bsp support) and extended and fixed support for existing formats (obj f=
ile support for use as maps, and support for minetest and minecraft object =
exports as maps directly into the game, and BZFlag exported obj as maps (th=
ese didn't work at all before: now they do (bzflag and the engine previousl=
y had different opinions on what an obj file was mathmatically))). That ope=
ned up 600 3d maps with the bsp work, and then 1000s of obj files with the =
obj_to_mc work. So I felt I was on a roll. Sketchfab was "opened up" and lo=
ts of free-software-licensed terrain and such were easily used from there. =
It was nice. I wanted to keep going.
>=20
> I thought it might be possible to get unreal 97 and unreal tournament 99 =
3d map formats working: as there are tons of maps there and I used to make =
little 3d worlds using that format. The two main formats here are .t3d ; an=
 ascii format (like obj) but which requires CSG math, and .unr : a binary f=
ormat which pre-compiles the csg math down to vertex and face info; but is =
more complex a format.
>=20
> I found free software projects in C++ that tackle each (my project is in =
C): that could be used to learn the math. The t3d one even does the csg wor=
k. I just need to plead to you: please: I need contributors now. I did ever=
ything I could in these last 10 years under free-software licenses: made lo=
ts of maps, made tons of 3d models, made textures, game code (QuakeC), engi=
ne code (C). I extended the engine to beable to address up to 4 million ent=
ities, I programmed procedural map generation routines that allow creating =
cities out of nothing. I modeled tons of buildings, with both interiors, an=
d level-of-detail models; so you can explore cities and not just go on the =
ourside of buildings. I modeled vehicles, added vehicles, programmed vehicl=
es. I added 200 wps, and building code so players can do whatever they want=
 in this 3d platform: from architecture, city building, town building, to f=
ighting eachother, or racing cars, helicopters, to putting out fires. I've =
made music for it. All free software licensed.
>=20
> I just cannot get contributors. Every single place I post a plea for help=
 the thing is banned and deleted.
> The only thing I've gotten is people trying to take down the project beca=
use they're mad I dared asked for file format help or for another programme=
r to join.
> Can you and the free software people help?
>=20
> I've asked "opensource" they sad "banned" and "scram"
> So I turn to you. It's in C. Your language.
> Please.
> I beg of you.
>=20
> I can't do these file formats alone.
>=20
> ----------
> Here's a ticket of the issue: sourceforge.net/p/chaosesqueanthology/ticke=
ts/2/=C2=A0=C2=A0 ( #2 Please help with .t3d and .unr loading (3d world fil=
e types) )
> Here's a git of the source code: sourceforge.net/p/chaosesqueanthology/co=
de-t3d_attempt_engine/ci/master/tree/
> And here is a tarball of the source code: sourceforge.net/p/chaosesqueant=
hology/discussion/general/thread/72c4ff80c1/f23d/attachment/darkplaces_work=
ingon_sep_06_2023_aug19cde_SOURCEONLY.tar.gz
>=20
> I started in model_brush.c , added in a new file handler: void
> T3d_Attempt_Which_will_Mod_OBJ_Load(dp_model_t mod, void buffer,
> void *bufferend)
> and got it printing the vertex info of the t3d stuff.
>=20
> I found 2 free software projects that handle (in C++) the two file format=
s, and I asked them for help but no response: (.t3d) T3d2Map(C++): github.c=
om/mildred/t3d2map (.unr) UShock(C++): sourceforge.net/projects/ushock/
>=20
> So I just need help here.
> I cannot do this part of the engine coding alone.
> I know I did other formats: but it was alot of hacking and they weren't t=
oo different.
> But here: it would take me years since I'm a hacker (at best) and not a p=
rofessional file programmer.
>=20
> Please help. Is there anywhere I can ask? Everywhere seems shutdown, filt=
erd, and blocked, and very very unfriendly to any C dev requests.
> Hope you get well soon.
>=20
>=20

Seems like you have a userspace application issue. This ML (LKML) is for
Linux kernel development, not userspace. But if you want to contribute to
the kernel, you can apply for Outreachy program (see [1] for the announceme=
nt).

Bye!


[1]:=20
https://lore.kernel.org/outreachy/alpine.DEB.2.22.394.2310020741050.3166@ha=
drien/

--=20
An old man doll... just what I always wanted! - Clara


