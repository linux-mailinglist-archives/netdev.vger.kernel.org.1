Return-Path: <netdev+bounces-39595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 270057BFFE4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0630281DB4
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276F29412;
	Tue, 10 Oct 2023 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="F87M5tuN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C328F4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:02:10 +0000 (UTC)
Received: from sonic315-54.consmr.mail.gq1.yahoo.com (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989CA4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696950124; bh=x7u4NNO7suZaaNj2A06gh1ZFJ/JQjyA4GUzycOX26hM=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=F87M5tuNbbD8k/150DgnR2Petodv94dptkA8InE5lRr0+TApHxAITkCEfzjGIVK90xtoae7TiIebNUG6LKwcRBYDhAPvjwpDiFkwjkil5XCKb+sliv7MevxIuDQ9pcDZD8pT53ebRyrOYd3e+OvJ3z5CTpEoD+fbCgzfLua+h+Je0bEbbXn5PJ0igZS4GvsEi/LJ43WD6nu7dLi7ARVvUPYjONiWXt5Dwavq3nfAkKNAsJNWeyFIq/IJsmyE9Lzg5cKzv1Pp30WcRmFjud0d5rhqPnOMv6tR5QYAJ9s14T4s+ciaMEtSFMwxPcGQd8AJeLfNj74pbyPsCK79K67etA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1696950124; bh=AyL69oCt04yxdTI2MDrAToLsAlKvWMSzZ+jN1Pqb45V=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=Hl4JZAPCjvFurV/HxklzmDoAFZGJKp7ufDa2ZJQ3YuNKayl1l4mvfRVO8uK1kmgedF48I6u1iVNFt9Unsc6PakRA5RnOgyU0+bK6pTjEKR2/oS7ZFlhgDd6E5bgl2fnrluQMxaPooP50MjgdWis0FrgZGyx1RqjJA4D0tV9baoQL7rL7veWWO3HPAW0TLZtonoty24e6cYIyp600XPg/z6ikba+zrdS/QDDe8nBssq+Z7R3v7j7sqCGALPpqsJa/Yp0MNOVa7X4OhuOrd6Yuh0VvRozMBB6FXOr8ymBj5rM3GB2TTi6XGofAcy57o+BttpMTPZzt9+Fkzv9SpwWmTA==
X-YMail-OSG: SZ4RVZAVM1mAwcDcbmp1NjQuVa20kWw4AhCqp25b1g9Z1c9vtPCCveBdv3fFDU4
 _5eQHUvigD6k8PLNPU0r_KcWsce9gkZdpSczCC3Ie.y9DNvw1pg_58XkOxdX4jc9UdJhTnVxXPQA
 yb2qHy92ekPJ.bjt7oCzT1Sq7XYFC6QXh87wIQM6LdzF3hwitDSN3AYbXrnnPJlPkw_2vLLCvEe6
 nZtoKVLbWPmdYCCECOo3nIrBNU2PX7LhxJh3enOMoF0q3sPfrz.k.Y0PXG0ycJJfmoyjyY5h0mbb
 lDyL.NEdPJN_cshZ_n2LKE_JcZe1j03NVcOaFkOnyqb.gP291DpfXnVCcIq1uyZb9oLzGeJssO9I
 5eBjwXLYRhq7h.natXf_djuuZDTWH3cRKK._hWq7lqsIizGutW7Dnr1K67_wcR5L4zqSgLwSpZox
 lSk9CmX6bF09c_dQ.gxs3Xd51vOFkfapq8AeaF7Q5TNqTgvJM7NH_9p5m06QItjL27SrXynYypCI
 cuhdi2yNw6i0UBJw9VY2KZtDbe56Q1a3ZROQjXa.reqNpKj4oiaAjnkyNjustCbffbqtOvFswCqh
 RQnC3OJX7OqieiTevkxlFeHUrzM7QG25yurzHRlLvUaT.4Eea5vhZHZhOk4RVw2O0miOJHul5uhP
 m3OF4a4fMzy7Hnu5s.N07pBHSuuTUgwqxrK99TgSvndVMartiM0TjxrEFV_HpfEmmsHCFHRpygX3
 Ja7SomUKCGhAt4VuUHXJCus8BzTnKOsTrGDdUg9ROaS7gnuGMLFTF14Rg.IuqvV4OedJwz42jtyK
 xAv7x8Wo20d_qkqxrrM2wh8P3fB4H6nZtaA3ywPagOTvtyz5uGsuW5lbCRUsOvGfJgNzxauockw1
 uwtkSNzvwteMg95xJNllO6FxWNyIh_BPaYOLiZ8FdfFT09DEpjPMEEy1KAMi8U.rBffKQ9.ph.WY
 znDuYtTzg0FFdoQzU75QPDVdQUhExobtrt2mHZmPJalYnlx69zWjHX6NNKfShdvqhZzGJAv1GHNS
 pw76cOhrpuwCCZ4ck5CuQVEtv.24cROoBceaNGlS12ZHB.d3NuSKOcKAFk6vH4tx8vPj5cP9rkdu
 WJ58dU64cx5hdHUkqp60olPZac0.pw5hDvZ6Y3JMTUolziXrx9GbwvMydWZ0q4dWmYrdW__ZrHsv
 008M03slBqdaHnLQ9Nb7ygsC4h6KfN2PPmfrnfUfRKntxBKup6FCynBGAUQnOJGlppUSPExE7EHg
 kEEmgTCkm6lS1a2hVvypo6w42pg.K5F.OCozHfErcHl1njJ9PCq6FlANKFoKMxZwVT5CcTfDB_C5
 XPYuvHfB_aU6_yCNzJp.RkCjZTKOmaQOY8XGg3wSRuVC_9QqpDFoZUjjm03QR2mzcUn4kY8c1qWu
 m.Hk.mXJ2TAwbCCKBFXRKo.PQMqhYIggWyfx5e08p5I8Xxf.kUGIlMcLTjYOF68gcAqkJcrqDqyH
 ipl_.3Y8acLP85Glq3k9Llzy9lRrCsSeclYyCvyrBTomH6mi7VbEbERfz7zm6ROJem3tMZia3wAc
 jhXGRZm3Lco9Kb2HBzcM4QQJrNoHXkGydHIZFTZXfoIKiq7cEHm9OvcJt8scfpwBV7jRVdWzdkW1
 ZqMYStt2Cj.vufXZs2FCMqPoF5WR6QbXJ67qZvQQh0bG8K85AtfcusI3FbJOGC8sWuhUwYKJ7jgX
 _n1YxE7tZpKqSzGxv4iOYKAP9q_G5EAK31hCIhMgmUc3.mW8OUHiAjLt0fzYe8ybh70JTvGLsJP7
 HwARGKcd9eGmJ30wpA6H3EaZc5Lybp.0Iuo23x24Fe0T5YoWz2w3_Dx2JUddC_QmVPU4tAEABF_p
 .Q2OvdNPvEfKgriOc8cQ3NoKBb90uzwgIH5WiAzY.ba3mghT.E_musueSZajgy84dezcOuVTnXNN
 H5zb4CoAEQnx1eEPHsUNx3aR5iJYDZDW6LlhAEG40LbLEXoXmuDRxjb0Va20Pt4XEKQ4K3PimI_h
 TlqFvIJ6H5xTORruo98fS2UH30utC0vbPEY8EyPCtFBfPYruvPEI4lINrvmP7.TF4qS2Dc6IlxUJ
 1Qx1rNtoILwTgZYN4TySjzfKxX6.SoudFlf0W5xgSms2X_FtSOL3NJzX5Z_0JznY4y_NZIjJzG2t
 .rZW0mRzks0X0QbPdx7LDQyRMOlo3uB_k6as9PI3SyBKXotCFpNcxynh5_8VCEjkq_qlBTlb5Kpb
 s0LjqbmMZZUB.D4HA
X-Sonic-MF: <chaosesqueteam@yahoo.com>
X-Sonic-ID: c439def9-29da-4f28-b58c-a672f8f5bf76
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Tue, 10 Oct 2023 15:02:04 +0000
Date: Tue, 10 Oct 2023 15:01:53 +0000 (UTC)
From: "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
To: Bruce Perens <bruce@perens.com>
Cc: Linux Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, 
	"misc@openbsd.org" <misc@openbsd.org>, 
	"tech@openbsd.org" <tech@openbsd.org>, 
	Richard Stallman <rms@gnu.org>, "esr@thyrsus.com" <esr@thyrsus.com>, 
	"David S. Miller" <davem@davemloft.net>, 
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
Message-ID: <641990627.3964368.1696950113530@mail.yahoo.com>
In-Reply-To: <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com> <875007189.3298572.1696619900247@mail.yahoo.com> <ZSEdS8a5imvsAE8F@debian.me> <457035954.3503192.1696688953071@mail.yahoo.com> <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bruce Perens; Thank's for responding. I mean that. No one else ever does :(

*Message Main Body:
Where am I supposed to send it? Every opensource forum I go to is basically=
 shut down now: even slashdot (they don't even allow new registrations). No=
 one seems to use C anymore: even though it's not /that/ much harder than a=
ny of the new programming languages: you just got to say where you want to =
store your data. Everyone is afraid of that now for some reason.=20

I've found C to be very similar to PERL, and QuakeC, it's just easy to use =
as one or the other. And C is alot faster. I don't know why people trash it=
.

So I send it to the few C programs I know still are kicking. I really don't=
 have any other solution for communication: everywhere else is a complete g=
host town. Things changed alot in these last 10 years. I remeber when all o=
ne had to do was post in any random article on slashdot, in the comments se=
ction, and one would have like 12 people the next day interested in the ope=
nsource project.

Now everything's shuttered, silo'd, and dead :(
And I don't want to attempt to communicate on ... X? a walled garden and a =
firehose put together.

*Message Addendum:
---
*Long story short;
*We want the unreal map file types.
*sf.net/p/chaosesqueanthology
/tickets/2/
*.t3d and .unr file formats


t3d format is nice; but requires more math grinding.
.unr format is ... less nice... but requires less math (ie format more comp=
lex; but less processing is required)



On Sunday, October 8, 2023 at 08:25:38 PM EDT, Bruce Perens <bruce@perens.c=
om> wrote:=20





Mikey,

This is why nobody wants to help you.


On Sat, Oct 7, 2023 at 7:29=E2=80=AFAM chaosesqueteam@yahoo.com <chaosesque=
team@yahoo.com> wrote:
> Bagas;=20
> There is no other place that C projects are talked about. In the past I c=
ould get help and contributors just asking; now you are all silo'd in your =
own little worlds and seethe with extreme anger or some castrated-drug-stup=
or in "irony" and smugness against anyone that asks for some contributors. =
Every single place bans anyone that asks for contributors to free-software =
projects.
>=20
> You feel you are superior because you "did code" 10 years ago and "suppor=
t trans rights".
> When asked to even allow a message to be seen that asks for contributors,=
 in this case a file format, to a fellow C project: you seethe or pretend y=
ou are superior.
> As if I didn't know where I was sending the message?=C2=A0
> I sent it to: RMS, ESR, Bruce Perens, redhat, OpenBSD, NetBSD, and Line-U=
nix. All C projects. Just like this engine.
> I'm just asking for contributors. Not promoting "outrecehery" (some femin=
ist BS), Not "master vs main", not "noo can't call things whitelist/blackli=
st", and not Codes Of Conducts for free contributors. I'm just asking for C=
 programming help for 3d file formats I'd like to add to this free-software=
 project.
>=20
> sourceforge.net/p/chaosesqueanthology/tickets/2/=C2=A0
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Saturday, October 7, 2023 at 04:56:51 AM EDT, Bagas Sanjaya <bagasdotm=
e@gmail.com> wrote:=20
>=20
>=20
>=20
>=20
>=20
> On Fri, Oct 06, 2023 at 07:18:20PM +0000, chaosesqueteam@yahoo.com wrote:
>> Dear RMS;
>>=20
>> I've read that you are both a lisp and C developer. I cannot get any con=
tributors for the longstanding C 3d engine I work on as part of my fully-fr=
ee-software (including media) 3d game/architecture project. I've been worki=
ng on it alone for 10 years but now have branched into supporting more 3d f=
ile types and can't do that alone.
>>=20
>> I've gone to "opensource" forums and gotten banned every single time for=
 asking for help. Every single time. The message gets deleted. This is extr=
emely difficult: it's not like 20 years ago when communication was free. Ob=
vs the "opensource" community is no longer interested in any collaboration =
or development.
>>=20
>> The reason I wanted to find more contributors, is that I recently (last =
2 years) programmed more file format support myself (wolfenstine:enemyterri=
tory bsp support) and extended and fixed support for existing formats (obj =
file support for use as maps, and support for minetest and minecraft object=
 exports as maps directly into the game, and BZFlag exported obj as maps (t=
hese didn't work at all before: now they do (bzflag and the engine previous=
ly had different opinions on what an obj file was mathmatically))). That op=
ened up 600 3d maps with the bsp work, and then 1000s of obj files with the=
 obj_to_mc work. So I felt I was on a roll. Sketchfab was "opened up" and l=
ots of free-software-licensed terrain and such were easily used from there.=
 It was nice. I wanted to keep going.
>>=20
>> I thought it might be possible to get unreal 97 and unreal tournament 99=
 3d map formats working: as there are tons of maps there and I used to make=
 little 3d worlds using that format. The two main formats here are .t3d ; a=
n ascii format (like obj) but which requires CSG math, and .unr : a binary =
format which pre-compiles the csg math down to vertex and face info; but is=
 more complex a format.
>>=20
>> I found free software projects in C++ that tackle each (my project is in=
 C): that could be used to learn the math. The t3d one even does the csg wo=
rk. I just need to plead to you: please: I need contributors now. I did eve=
rything I could in these last 10 years under free-software licenses: made l=
ots of maps, made tons of 3d models, made textures, game code (QuakeC), eng=
ine code (C). I extended the engine to beable to address up to 4 million en=
tities, I programmed procedural map generation routines that allow creating=
 cities out of nothing. I modeled tons of buildings, with both interiors, a=
nd level-of-detail models; so you can explore cities and not just go on the=
 ourside of buildings. I modeled vehicles, added vehicles, programmed vehic=
les. I added 200 wps, and building code so players can do whatever they wan=
t in this 3d platform: from architecture, city building, town building, to =
fighting eachother, or racing cars, helicopters, to putting out fires. I've=
 made music for it. All free software licensed.
>>=20
>> I just cannot get contributors. Every single place I post a plea for hel=
p the thing is banned and deleted.
>> The only thing I've gotten is people trying to take down the project bec=
ause they're mad I dared asked for file format help or for another programm=
er to join.
>> Can you and the free software people help?
>>=20
>> I've asked "opensource" they sad "banned" and "scram"
>> So I turn to you. It's in C. Your language.
>> Please.
>> I beg of you.
>>=20
>> I can't do these file formats alone.
>>=20
>> ----------
>> Here's a ticket of the issue: sourceforge.net/p/chaosesqueanthology/tick=
ets/2/=C2=A0=C2=A0 ( #2 Please help with .t3d and .unr loading (3d world fi=
le types) )
>> Here's a git of the source code: sourceforge.net/p/chaosesqueanthology/c=
ode-t3d_attempt_engine/ci/master/tree/
>> And here is a tarball of the source code: sourceforge.net/p/chaosesquean=
thology/discussion/general/thread/72c4ff80c1/f23d/attachment/darkplaces_wor=
kingon_sep_06_2023_aug19cde_SOURCEONLY.tar.gz
>>=20
>> I started in model_brush.c , added in a new file handler: void
>> T3d_Attempt_Which_will_Mod_OBJ_Load(dp_model_t mod, void buffer,
>> void *bufferend)
>> and got it printing the vertex info of the t3d stuff.
>>=20
>> I found 2 free software projects that handle (in C++) the two file forma=
ts, and I asked them for help but no response: (.t3d) T3d2Map(C++): github.=
com/mildred/t3d2map (.unr) UShock(C++): sourceforge.net/projects/ushock/
>>=20
>> So I just need help here.
>> I cannot do this part of the engine coding alone.
>> I know I did other formats: but it was alot of hacking and they weren't =
too different.
>> But here: it would take me years since I'm a hacker (at best) and not a =
professional file programmer.
>>=20
>> Please help. Is there anywhere I can ask? Everywhere seems shutdown, fil=
terd, and blocked, and very very unfriendly to any C dev requests.
>> Hope you get well soon.
>>=20
>>=20
>=20
> Seems like you have a userspace application issue. This ML (LKML) is for
> Linux kernel development, not userspace. But if you want to contribute to
> the kernel, you can apply for Outreachy program (see [1] for the announce=
ment).
>=20
> Bye!
>=20
>=20
> [1]:=20
> https://lore.kernel.org/outreachy/alpine.DEB.2.22.394.2310020741050.3166@=
hadrien/
>=20
> --=20
> An old man doll... just what I always wanted! - Clara
>=20
>=20


--=20
Bruce Perens K6BP


