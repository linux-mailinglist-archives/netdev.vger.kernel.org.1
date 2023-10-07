Return-Path: <netdev+bounces-38791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E17BC850
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C6281B50
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423828DD1;
	Sat,  7 Oct 2023 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tgi5SzJh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A8E18C32
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 14:29:20 +0000 (UTC)
Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8528BA
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696688957; bh=+P1IDZ4ma41oXZNPeTKa95bweKp04ngjZe6JHMBCpUM=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=Tgi5SzJhdoGGP7YQ+7Zx91pwqTq6kchiZQu7xoPPHI/pWotgm3wZIhI6Yg49FMkpSipdnV78cwHl8frHHhP01VS+ivWmmyVwwgh2Gyw/3rndqM27R9D/mvfq24pK8MO6XVOYQ8Ves//cnlFU2twyvftDujyxKY3GMfldu68tOUOhI7nOmoHieLt0iNCwQ8gUXrkUU+e0wspkW/RH3pKmHcjl3qn153D3ymwrS0YTtP5txW7txIR/TgwsPe9tVPYmvbZqw0QCtiW+9xRXXL0Jp4f30w09AU2thwrvsJg0iEq7vFQcpsUC2HORNUPdUT7p2dD6P3uKzqTldj6Hg18VSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696688957; bh=31eIGsJU8N3LjazUGd6GuM9fFHoyXQq7l/rO5vNztBu=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=CaQDDkcZ52eatH99DQFq+OV0T68D8mTk2ZbnI1EnhY+aYFcAj/BxowY7QWama3jR5uu+/GxivEE5DIoF++q2qHovjC0iikqjKZVKOsftW8EgcB8MaWSMydeJ/qdwvk+obgUW6c28X4P5PfL4qmD5J5aW7ng+rqQ0hgHHT0ukmZoxOcvuoIpfHj1lNXuDMECWPjlXsfM7V8aNf05gFGfP2XCRlvxU+qtEdDmEy1gidzFmhbfj86a2ODsOyBWZxR1goOKqmGUn6g6R4s41i5GuHor6zpTFJ2wGw560StMyOtdG1EZAdAMSUMnXsjcMTMGVazmFXFwNKE7abaOZ6+FJCg==
X-YMail-OSG: 0Z5GR88VM1nYlKeuPL9_sy6T9SJUdQCriqUR1CCcOtcjKEJAj8ppA2jwt5Xi9AM
 bnKsc__Sf9dL1a6BwkDh4yI1jsNv8s.G9J76L_aOO7m0ZZ9AgPWjjzekC_bpeM76XatAxkgg1hNN
 bUcMTNAtDR980yV1UzosPU7ASmVHGcNoODw2cvdol0.MZDs7tjbD7OyiAg3OxdykPElvP4z2.2Ur
 VarCW5c7XFxfEALvgJ_MwmFrpjSLjkG_gFUKHjqVuKnjWBuSCW6PkcGHph1DlCfeFp9pGXN7Xg0B
 W2Eql2l76yUiEh14kYPycfSmgskDUPhDBCfwiK.ixUw8nLCx4xkbrg0PDNSr6gq4l0d_3WwE.uda
 0aTIxO2ZQu2XdovyhCUDUFR090tGklRlcLcQl3f431v5lgbvud0AvEXowwy2LLhK6NJh67wFSv8n
 RgB3hzWrHBty7d5s9Yb4VRSZ_t1hacseHAGbGOqLdf3bg4t_3EAiT4DzETShLl2Jxt7NIn.gmA_J
 IOshTlnxdCoY0nFvD6ILrSvzQkiZ2LijLk2x3vL6e0zzXdchiIXKqpZCCR7XlSi_porz.xcKe5UH
 n2fbfzD4LmxMgcBr2LXk4W1qzdUtXSfDvodn1t.rd6ocnDnNeDfb2zaN9K75QgbsYKE4E8y8SqM1
 M1rXbvnX18pqZqv6B41974ToApqn4GmZdQvDlDleMoiBz15moIVdAlKPMoIIEElKkq8tVVpW5SFN
 wqVRnXHvHgfJufBUdAhVvoJkN2ELdgN8zqi9diWpbbhkGUVBOjKVheGM2aQNivcpDfaYWC1DU1bX
 7aNxf7qeQuZouaueLIisPPUhuKm8Q.Z4RDt5wFanQSiZI3SQrFFxP1QaMr5JSaliFjXwI0kLw_oh
 8PAUhoIsKcIOPXM5ZqZPZILPd.9WXKxlUUka032TgpXTrgP2T2ceE4NamEals6ZvlwU1Cc2hkUtK
 VscZYi.e84B4vBOoPl3GzuQ69h8Ntu5qzjTQzkMedHdynpb77yqRqLZ6Uu0muFq8yGI0MQMARefK
 g27K_6Gz.2OaJmSFKZx2O2jFu8Jd19UnnEv1Z5zBe67IULJZQBBCJ7g3laLDd9KQ2vFx9Myg6_TW
 0imV7qveLhshUFFr3G59FbOcDd9mDcjBmHauz7qI7RDCBCFqvjYocxW5OcB1fCrAo3B6yVuu4Q3U
 Bapu2ExUeMfdfaWJ5ZNGwMJiyvI2zxUEyKXYB8r6WqsQHCIy442OqBjdBEtGg_l0c8L2FpLKMUJB
 kO6pBR.OG9nImZ5kTSxBIG8ewnTxcincNbYuTBAP4B4lGluXLkDlQc0zLqAU6oMlVMxOm.b.18Mg
 LQiXm5_D4PsVKPYi11JPOOWohrWGaYcwmKyG3RkLP.xT6SKdoaFpWwqahukAwAkiDDyPRi.acQMt
 OQ8iRDyFDJ4xVlQ7VT1HanT1S7Le4Jv3g3l5e.xHJHgZBrW_wDIORSSOLkEqVHomRG.jaFLcJvhE
 maE9PkRx1L2mkSuzTMcVEfXqtiTpN8VZ9l.2sr9XtXiNUWcsJx9_xAJRqkaP5Cbb3.x93U_e_K0G
 q4Bz34OwI_Ygv9v_A227LtUWA_EIf.TOGmQpuL0fklwyfqwbqEbRUGx7FMDoAlFxVY7BEvmZkYMl
 Dvr1UZJPwKrw1ogGS5em1Ld.330gwwrgocSbQwXTxs9HsnCaU2XlFZ7LiWJBc2Zfr9wEN7rZKYbz
 l1H94Zk2bUiKOCSynN51Be4CL1TbhEHapg7av0YRKxAml5RfU7qe0T7xKlQqmuRvfSJ3zoqv13Og
 2VNAVrgLiXQajnFMQPSYDMcQijd9zQIWfKOXuJpXPPao74yAMedQLI.0K5.YD57sY_H68K1spomm
 va29o0P6W4f7PrVVIZrbGMxJGI.1Sy6fet45YPE2XbQeBqhF49E68BK9t9_jxYZ34Ux9t8b1mv0o
 Tl_O1NPXHOvgyq7_tvn8Z8j0CHbuFzC_Q2ExfScPY7BQSdWUt6yfrkXtChr1mXZx_LBd.YZw.q8h
 CQ7.I.GRz9q7jSa6MchnYIwcFR7pX142ajJO.SS7xKeaG_xK9vB630DHs_Q2xEGJtoKt8zgdk_iI
 XmnKU_1B.vVC9dzvMXmbgLEsewOHYsJopfNlMRejL0HtaC0OGIsln7R6gEMHReWFXw.9TcUNl3uD
 _5zfVJhN87ncHdwzndr5atsBUxjY5JmMeCRf_zFDNRzfV_ZWimhPba9lt7lYDZZKGxjm46jLoGsY
 IlTYBhUj0fUHqA2OZ9IH73dYiRg--
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: 8948da1d-23f5-4a40-a290-f79c22adcd72
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 7 Oct 2023 14:29:17 +0000
Date: Sat, 7 Oct 2023 14:29:13 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Linux Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	Richard Stallman <rms@gnu.org>, 
	"bruce@perens.com" <bruce@perens.com>, 
	"esr@thyrsus.com" <esr@thyrsus.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, 
	Julia Lawall <julia.lawall@inria.fr>, 
	Aditya Pakki <pakki001@umn.edu>, 
	Anna Schumaker <anna.schumaker@netapp.com>, 
	"ansgar@debian.org" <ansgar@debian.org>, 
	"blukashev@sempervictus.com" <blukashev@sempervictus.com>, 
	Chuck Lever <chuck.lever@oracle.com>, 
	Dave Wysochanski <dwysocha@redhat.com>, 
	"editor@lwn.net" <editor@lwn.net>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"J. Bruce Fields" <bfields@fieldses.org>, 
	Leon Romanovsky <leon@kernel.org>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, 
	"moglen@columbia.edu" <moglen@columbia.edu>, 
	"skraw.ml@ithnet.com" <skraw.ml@ithnet.com>, 
	"tcallawa@redhat.com" <tcallawa@redhat.com>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, 
	"torvalds@osdl.org" <torvalds@osdl.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>
Message-ID: <457035954.3503192.1696688953071@mail.yahoo.com>
In-Reply-To: <ZSEdS8a5imvsAE8F@debian.me>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com> <875007189.3298572.1696619900247@mail.yahoo.com> <ZSEdS8a5imvsAE8F@debian.me>
Subject: Re: I can't get contributors for my C project. Can you help?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3503191_701362306.1696688953071"
X-Mailer: WebService/1.1.21797 YMailNorrin
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

------=_Part_3503191_701362306.1696688953071
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Bagas;=20
There is no other place that C projects are talked about. In the past I cou=
ld get help and contributors just asking; now you are all silo'd in your ow=
n little worlds and seethe with extreme anger or some castrated-drug-stupor=
 in "irony" and smugness against anyone that asks for some contributors. Ev=
ery single place bans anyone that asks for contributors to free-software pr=
ojects.

You feel you are superior because you "did code" 10 years ago and "support =
trans rights".
When asked to even allow a message to be seen that asks for contributors, i=
n this case a file format, to a fellow C project: you seethe or pretend you=
 are superior.
As if I didn't know where I was sending the message?=C2=A0
I sent it to: RMS, ESR, Bruce Perens, redhat, OpenBSD, NetBSD, and Line-Uni=
x. All C projects. Just like this engine.
I'm just asking for contributors. Not promoting "outrecehery" (some feminis=
t BS), Not "master vs main", not "noo can't call things whitelist/blacklist=
", and not Codes Of Conducts for free contributors. I'm just asking for C p=
rogramming help for 3d file formats I'd like to add to this free-software p=
roject.

sourceforge.net/p/chaosesqueanthology/tickets/2/=C2=A0







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


------=_Part_3503191_701362306.1696688953071
Content-Type: application/pgp-signature
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"
Content-ID: <75a73327-3009-68fc-f516-fd27639e5eb6@yahoo.com>

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaUhVRUFCWUtBQjBXSVFTU1lRNkN5N295
Rk5DSHJVSDJ1WWxKVlZGT293VUNaU0VkUmdBS0NSRDJ1WWxKVlZGTw0KbzlLRkFQOVJDWExSNEtz
WTlWWCtHUGdiR2swU0VkMGZML2M0KzU3ZFhBMExISkRScFFFQW1FUVpZL1JpK3dzTQ0Kdy9XNWs1
MjB2aHFrNUhHdzgyTmpQT3pzZU81T2p3RT0NCj02STloDQotLS0tLUVORCBQR1AgU0lHTkFUVVJF
LS0tLS0NCg==

------=_Part_3503191_701362306.1696688953071--

