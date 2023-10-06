Return-Path: <netdev+bounces-38662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6DC7BBFAB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C11C208DE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5863C699;
	Fri,  6 Oct 2023 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G9NT8eFU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92E30FA0
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 19:18:24 +0000 (UTC)
Received: from sonic309-21.consmr.mail.gq1.yahoo.com (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FDDAD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696619902; bh=Ob0biPqPrPerePq0s6Aqe/bRfH8xf0iy2HdSuAchSzk=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=G9NT8eFUw6W9/2cwHWakSiLlsbGvRoTKEpNpchhte/EUIqkEDYK5F9oPwq/MzPpyZ56JhZhNSxoPfuTNL+iYiuGRZjc3w8tTtHG8ugCvjkXh7xeqa0fnh1s83aw2IqsfKggEuVf6V/P8nVARKXylDzZcG3FXE9lILOaf2ZyqO3SqY7af4dnK80MQiNw7EUJbUZHQNlLMEa/l0CHz70uPjooO7+YFyLly/o0kRMwavEWaAi+Xdr/1ydvU18IIFdvZIw2sknDlHQ2B9TfURLH9yvWCuMN5anxOZsNLfCY/+2lSZikPiGuoXuKiBioXAsTv6vkzfsF7Sq/XeDxlP+WIGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696619902; bh=NSbysMtyDyzPaCAOieYJ6eU2xMCW1J3RTPBkU+vYbf0=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=ZsrQlJtrhzIqHEtGTLL89qqFoUWFhFIv95RMnilasiyOnV8bIz+WSRFRKhus3D+GwHkGontbSLJ59OM0MF4rl9fHnR4mW7Wz/ojRuAgKPFIGNCDjl89PPV8W9Y3zTRPXb9wFRPeLrdyJ2egfqLoVSlrBqK+lOBngMUhz7LPoU5hSLp36ugH/3w04YuCoHNjXTu94Ng4IsGbGv+cidSfsK90qMEavd7y97enEOOhYC1RlbJ/gfellMCIQOrIjGvKllrx441/PFx3MSPVHVRJJDjsBdI5z7vw3+66t7EI7/aOht/i3M5y3DIVteabLwplAW3+ywxXfWEKR7TFRMqEREA==
X-YMail-OSG: lMiXexQVM1n1V6qHstR27G5MHRvN3GnL2BAFN6Tn6rBl0J77eAosrhiZEvtle8Z
 fFOACUXvZeDsdemiYZGM1UAqz.lDmcCE0xVOkVfm1mJeK6b2vLMU2.aV3uDjGx1CH3o.7FsicTu0
 UziQIZMsS9tKaX5hU70iSzAo_o3wCdkbIGgcuG__md8kSyhWOKGJuGjQqy5Vkh9kgUApW4W5An3O
 N5xzhPU6d6iMwWNC942FAy2jW.Z7zRuG1Dwisum73NnmhUOeP.J666Lvw33yDfrbq9b85OAfowuB
 Xv1MpQRAAiUq.TUhWSBm8IlbNICAlRgOeqxa6_JPRRvK7ynRXIm3uMBQiS4XPyNIwBPC5cwaGk6z
 l9m6LRqXxgU3L57.JInVCOLH4NKWUkBvIpS0qXw6xAAySUI.JvEPoXyBixr1AG.4a9fFff1mgsL2
 MDA1RBzgarrDOjw9ZfTfCCFIECgi2eBN6OLPsd9uA2nk3Pe7L2WmdifqE5aEixZLUbToJlUShd7P
 0HKLDo7p0V25uETxDQCZHJjZBQwKDHcgLIzOvIwzCnWJiL1G7oNJ3T2KmMoC486nmcrc4c4ZzluF
 sr7oStMOa0CYFT2ul0Vxxvv6HRVEZzp_9.mMOWsajJLeOfuyFtDii0CJmZhN7677q.htd.nsw4sR
 Vo2em25Ea9kiAF.RlkO72neM8.JFAUmD5MM6maQGZOQcd5QLnM4unsyrQKVogGcf6QizqInOCcCX
 y0xuCxwWETBqD...IghxJg5A_Nz6hL_wT85nMVISHxWZ6mcnB9pbxBhogemPrqZUbP3iebVHvefF
 ioWpuxxEwfmNsOlSWPWkacY9JkgefuqOovMTZfiod2i6HkQhgNFLhBoVwfQrtFTHg12KMnnNRQip
 fK4NAdW7L..iIX6ELKsgxXAUTGzxRI8lcS8o1Z_9ZZpKadvTNmXhzs9NQ3Kij0cRNDnEXMDxN93D
 g0b2x8QVbPNakkm5614eepOjA_4PTxE12JvzzunXQWipP3PPCKyVg2.uafV.8EtbimeiBRphFzmG
 pPDCkwWkqzLzojLA5qyGpmb2LYqzkROn.xHpziXTNL1GzMiCmhaIb2eHjzGIPveCvpzd687rC_2q
 jw187ub9zbllyp9fCl2wsweMjHhqbYDmK0ggwtaVTRz5fDWrXGZwf1ej71EmC0zql2jkz8rkB0eY
 ek9ORshEj4rA4jFNs.nomAxmsrVexBw3Sjdw5lWlcr7Y5Q3_l6iwZ_9a5PTUi5L8FVT4oU.MS2id
 B6ubLHB8aC99wRfHVLv4_tCA7xiqdGRqXAOXUS89E1nGxnA3lvrGl4Rqonz1YJFZ5MUpIVMMj9wc
 d2cLpkbRvhsuy5ca2Zubkri9WGnOwgp.UgXiP5Ck4Rr9NLFBnilffBDNXeTtDP7SJM81697WZblF
 .WWpAQfQJ4TnBHl9VrgyYcbPBWZHg_VUzXV5H1TtwcXpiwc22m.5L4Pn83p27Y5bWVpKaPcClSEz
 RArKYVzjyaO6aWrAqVA0UA6PLU.35CZLKNrhSQvbIp3iJ.Fvs_N54au3m_uDRaqwMXZL9WjSnXhf
 FvuSTyPoG200uk4mvGdthGhKJzsksV4Um23A8ESGmtGlIjNC_DXywv5lTesYTK2n0qFKfOZ_pazY
 gpB174sm7lrMufx1go2B0OBU4XPC_vcmrwJgdsLBe9ixy0I4Lt8KAYZy7bdA_n7BTAH1gx.e7qsY
 M.zNxIxb.QiFZ4u_6kmEQvl01m9wWzI9ZtUw9gdETVGKCF7PIP.qMcGeC6d_9iEGoHTB1LjLgoP4
 TqQvraCwnKNxzawyVPE8YSTCFjJJ88gRJs913zO4xeZ4shFGPUqzrewgGyP5j4hPlLtivThAVnt8
 QtMMhuYPINYXZGTGBguhDqnHdf6bJlCUE1DaRQKJwaPCshNhgCdEypC6FNeLyDJMxNP15HJJcM9s
 5RmE1YdLuKatlTxYhSrZp4dchPQc56q06D4JHaGyPGDmczr_rQTjwq4gOp5.DkXXRbUgRK.DlgAS
 yHT3ACh0R0o7eOXeuaRQ4VPNJC3gNonzqbmpWEUOzyUPCRxbsJFjv4iu0rih9dkHSh_wi7G_yIy9
 HS6Y.OKwLHwzY7KoNQVJvVHHkpSIZLYqutYS0Krv70WUaXB_Z_Tt9tRs3qkFJru.MMSQRE6fe.gm
 7MXKFfQLxXK5pU01UxdUn6LqcjHQlvrkbndln2mDyJpwm_pd0fKqmOxTT9IZyTXR_N189bVOupNO
 iz4lXnnQxeoVOmBeQP9V83F5SpA--
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 0f66513e-2fbc-401c-8125-b1fd68ca7d79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 6 Oct 2023 19:18:22 +0000
Date: Fri, 6 Oct 2023 19:18:20 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <875007189.3298572.1696619900247@mail.yahoo.com>
Subject: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear RMS;

I've read that you are both a lisp and C developer. I cannot get any contri=
butors for the longstanding C 3d engine I work on as part of my fully-free-=
software (including media) 3d game/architecture project. I've been working =
on it alone for 10 years but now have branched into supporting more 3d file=
 types and can't do that alone.

I've gone to "opensource" forums and gotten banned every single time for as=
king for help. Every single time. The message gets deleted. This is extreme=
ly difficult: it's not like 20 years ago when communication was free. Obvs =
the "opensource" community is no longer interested in any collaboration or =
development.

The reason I wanted to find more contributors, is that I recently (last 2 y=
ears) programmed more file format support myself (wolfenstine:enemyterritor=
y bsp support) and extended and fixed support for existing formats (obj fil=
e support for use as maps, and support for minetest and minecraft object ex=
ports as maps directly into the game, and BZFlag exported obj as maps (thes=
e didn't work at all before: now they do (bzflag and the engine previously =
had different opinions on what an obj file was mathmatically))). That opene=
d up 600 3d maps with the bsp work, and then 1000s of obj files with the ob=
j_to_mc work. So I felt I was on a roll. Sketchfab was "opened up" and lots=
 of free-software-licensed terrain and such were easily used from there. It=
 was nice. I wanted to keep going.

I thought it might be possible to get unreal 97 and unreal tournament 99 3d=
 map formats working: as there are tons of maps there and I used to make li=
ttle 3d worlds using that format. The two main formats here are .t3d ; an a=
scii format (like obj) but which requires CSG math, and .unr : a binary for=
mat which pre-compiles the csg math down to vertex and face info; but is mo=
re complex a format.

I found free software projects in C++ that tackle each (my project is in C)=
: that could be used to learn the math. The t3d one even does the csg work.=
 I just need to plead to you: please: I need contributors now. I did everyt=
hing I could in these last 10 years under free-software licenses: made lots=
 of maps, made tons of 3d models, made textures, game code (QuakeC), engine=
 code (C). I extended the engine to beable to address up to 4 million entit=
ies, I programmed procedural map generation routines that allow creating ci=
ties out of nothing. I modeled tons of buildings, with both interiors, and =
level-of-detail models; so you can explore cities and not just go on the ou=
rside of buildings. I modeled vehicles, added vehicles, programmed vehicles=
. I added 200 wps, and building code so players can do whatever they want i=
n this 3d platform: from architecture, city building, town building, to fig=
hting eachother, or racing cars, helicopters, to putting out fires. I've ma=
de music for it. All free software licensed.

I just cannot get contributors. Every single place I post a plea for help t=
he thing is banned and deleted.
The only thing I've gotten is people trying to take down the project becaus=
e they're mad I dared asked for file format help or for another programmer =
to join.
Can you and the free software people help?

I've asked "opensource" they sad "banned" and "scram"
So I turn to you. It's in C. Your language.
Please.
I beg of you.

I can't do these file formats alone.

----------
Here's a ticket of the issue: sourceforge.net/p/chaosesqueanthology/tickets=
/2/=C2=A0=C2=A0 ( #2 Please help with .t3d and .unr loading (3d world file =
types) )
Here's a git of the source code: sourceforge.net/p/chaosesqueanthology/code=
-t3d_attempt_engine/ci/master/tree/
And here is a tarball of the source code: sourceforge.net/p/chaosesqueantho=
logy/discussion/general/thread/72c4ff80c1/f23d/attachment/darkplaces_workin=
gon_sep_06_2023_aug19cde_SOURCEONLY.tar.gz

I started in model_brush.c , added in a new file handler: void
T3d_Attempt_Which_will_Mod_OBJ_Load(dp_model_t mod, void buffer,
void *bufferend)
and got it printing the vertex info of the t3d stuff.

I found 2 free software projects that handle (in C++) the two file formats,=
 and I asked them for help but no response: (.t3d) T3d2Map(C++): github.com=
/mildred/t3d2map (.unr) UShock(C++): sourceforge.net/projects/ushock/

So I just need help here.
I cannot do this part of the engine coding alone.
I know I did other formats: but it was alot of hacking and they weren't too=
 different.
But here: it would take me years since I'm a hacker (at best) and not a pro=
fessional file programmer.

Please help. Is there anywhere I can ask? Everywhere seems shutdown, filter=
d, and blocked, and very very unfriendly to any C dev requests.
Hope you get well soon.



