Return-Path: <netdev+bounces-54385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74877806D98
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A28F1F21304
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB6315AD;
	Wed,  6 Dec 2023 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKRHdMMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB0C3
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:13:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10192a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701861236; x=1702466036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBVUF8HStFhoeBqQa7yskGof2bnIAS9H+Ru2+C87s3c=;
        b=MKRHdMMpuK4+IMxaMFlltWJB/cfkGQRW7AR+o60UBXk9m/45uwEbxAwhzWTOO5Qs8E
         STFDTGMjc3J+Htt6xqLh0ApdPLIhM+XcHMq8qq0eDnMlND5nB52h1bWzrPuH6BHef4Dw
         y6Va2dSjwbkZ1pNjcZNonwg/9L/wnbWm0VJUwhjk9RPW6Vfo0nq4WYtKc1qcSG3+V2Qz
         WO3opGxASUmJLIoCy34gwbWZLsSZ6Tl9sl3MjQUKf64X+oxNIg6gXFoGcMyvyI0ZQaDS
         t21JtLgNViHAb0wsZ4SBYMgdE6D1r8T1iozS36ixzwdKbR0Bs2QiCj3YxEQDI7pTila1
         AfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861236; x=1702466036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBVUF8HStFhoeBqQa7yskGof2bnIAS9H+Ru2+C87s3c=;
        b=PVUx0Zug6NRVA47p3JRn9WC8yu8TDApsL5p+81gpjhqd8Qb+ul3Li+r8vqFUZ47YcV
         Idc/eI14Z1oOU6MX0kswBFZpdotIEv2MbiTHTvWw03sbAzkq54ZuVv/fGYg3XQo+RC3k
         Irbg6xjmhzRtaVPxBJZoQ5KpoewoAKkq2P31+jiMDzQIiBX3R4cgbKH9VFteVXA5HIht
         Bp5ZlBZIMHfMBKdZA4rLnKkHiDjjHz1YCCYG/PIqL5El+r1/WoxyiEkLPoKuY/pKj9+s
         4Jp+xDKDdcM2nruhZTF+oC5ke2fDBKEYa0VhcSvTG4g7DCceZce1gMBoa6n92hHfvJRG
         I6Ow==
X-Gm-Message-State: AOJu0YyEa3zOok6J49OHTXBXk3mSF+Po5SGsbWp7biRrDZkEimpJbPLK
	B7MBdnop14b1Bx+zJjrqO7rd3M+MMV5jnyU3CRo/ZA==
X-Google-Smtp-Source: AGHT+IFbUR4C0Fuxnjl1elkyXCs0mJ8VYp3DnR01pI4e2NVnxxQp/bxilpMPdWHzgVXH/ikNG3ersjRkq6MEyfvEn2g=
X-Received: by 2002:a50:d744:0:b0:54c:384b:e423 with SMTP id
 i4-20020a50d744000000b0054c384be423mr58065edj.5.1701861235875; Wed, 06 Dec
 2023 03:13:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204195252.2004515-1-maze@google.com> <202312060307.EaL1FRwu-lkp@intel.com>
 <CANP3RGf-G1+OnBYrNpc1c_bzL1b-X4gzc=XtXs+5qArztxm1ug@mail.gmail.com> <CANP3RGcCNj1nFT9+Q_c06ox=LidhjBRcH-NWHA_75399fQdVhg@mail.gmail.com>
In-Reply-To: <CANP3RGcCNj1nFT9+Q_c06ox=LidhjBRcH-NWHA_75399fQdVhg@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 6 Dec 2023 03:13:44 -0800
Message-ID: <CANP3RGcgBUAqT1fqX7GRyfCu_snXzaKxzfCtWWiTi_eDNbraeA@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:05=E2=80=AFAM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
>
> On Wed, Dec 6, 2023 at 3:00=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
> >
> > On Tue, Dec 5, 2023 at 11:12=E2=80=AFAM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Maciej,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on net/main]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-enczyko=
wski/net-ipv6-support-reporting-otherwise-unknown-prefix-flags-in-RTM_NEWPR=
EFIX/20231205-035333
> > > base:   net/main
> > > patch link:    https://lore.kernel.org/r/20231204195252.2004515-1-maz=
e%40google.com
> > > patch subject: [PATCH net] net: ipv6: support reporting otherwise unk=
nown prefix flags in RTM_NEWPREFIX
> > > config: arm-rpc_defconfig (https://download.01.org/0day-ci/archive/20=
231206/202312060307.EaL1FRwu-lkp@intel.com/config)
> > > compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20231206/202312060307.EaL1FRwu-lkp@intel.com/reproduce)
> >
> > I followed these steps, and it built just fine...
> >
> > maze@laptop:~/K$ git log -n2 --oneline
> > 57cde6e635d5 (HEAD) net: ipv6: support reporting otherwise unknown
> > prefix flags in RTM_NEWPREFIX
> > 7037d95a047c (net/main) r8152: add vendor/device ID pair for ASUS USB-C=
2500
> >
> > maze@laptop:~/K$ file -sL build_dir/vmlinux
> > build_dir/vmlinux: ELF 32-bit LSB executable, ARM, EABI5 version 1
> > (SYSV), statically linked,
> > BuildID[sha1]=3Dae5a34fc35b264d707b3f16e920282b96c080508, not stripped
>
> ah, the reproduction steps don't actually fetch the .config

the struct *somehow* comes out to be 36 bytes (it was 32 before this patch)

this tentatively looks like it might be triggering a compiler bug?
will dig deeper.

>
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312060307.EaL1FRwu=
-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    In file included from include/linux/container_of.h:5,
> > >                     from include/linux/list.h:5,
> > >                     from include/linux/module.h:12,
> > >                     from fs/lockd/svc.c:16:
> > > >> include/linux/build_bug.h:78:41: error: static assertion failed: "=
sizeof(struct prefix_info) =3D=3D 32"
> > >       78 | #define __static_assert(expr, msg, ...) _Static_assert(exp=
r, msg)
> > >          |                                         ^~~~~~~~~~~~~~
> > >    include/linux/build_bug.h:77:34: note: in expansion of macro '__st=
atic_assert'
> > >       77 | #define static_assert(expr, ...) __static_assert(expr, ##_=
_VA_ARGS__, #expr)
> > >          |                                  ^~~~~~~~~~~~~~~
> > >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_a=
ssert'
> > >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> > >          | ^~~~~~~~~~~~~
> > > --
> > >    In file included from lib/vsprintf.c:21:
> > > >> include/linux/build_bug.h:78:41: error: static assertion failed: "=
sizeof(struct prefix_info) =3D=3D 32"
> > >       78 | #define __static_assert(expr, msg, ...) _Static_assert(exp=
r, msg)
> > >          |                                         ^~~~~~~~~~~~~~
> > >    include/linux/build_bug.h:77:34: note: in expansion of macro '__st=
atic_assert'
> > >       77 | #define static_assert(expr, ...) __static_assert(expr, ##_=
_VA_ARGS__, #expr)
> > >          |                                  ^~~~~~~~~~~~~~~
> > >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_a=
ssert'
> > >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> > >          | ^~~~~~~~~~~~~
> > >    lib/vsprintf.c: In function 'va_format':
> > >    lib/vsprintf.c:1683:9: warning: function 'va_format' might be a ca=
ndidate for 'gnu_printf' format attribute [-Wsuggest-attribute=3Dformat]
> > >     1683 |         buf +=3D vsnprintf(buf, end > buf ? end - buf : 0,=
 va_fmt->fmt, va);
> > >          |         ^~~
> > > --
> > >    In file included from include/linux/container_of.h:5,
> > >                     from include/linux/list.h:5,
> > >                     from include/linux/module.h:12,
> > >                     from net/ipv4/route.c:63:
> > > >> include/linux/build_bug.h:78:41: error: static assertion failed: "=
sizeof(struct prefix_info) =3D=3D 32"
> > >       78 | #define __static_assert(expr, msg, ...) _Static_assert(exp=
r, msg)
> > >          |                                         ^~~~~~~~~~~~~~
> > >    include/linux/build_bug.h:77:34: note: in expansion of macro '__st=
atic_assert'
> > >       77 | #define static_assert(expr, ...) __static_assert(expr, ##_=
_VA_ARGS__, #expr)
> > >          |                                  ^~~~~~~~~~~~~~~
> > >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_a=
ssert'
> > >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> > >          | ^~~~~~~~~~~~~
> > >    net/ipv4/route.c: In function 'ip_rt_send_redirect':
> > >    net/ipv4/route.c:880:13: warning: variable 'log_martians' set but =
not used [-Wunused-but-set-variable]
> > >      880 |         int log_martians;
> > >          |             ^~~~~~~~~~~~
> > > --
> > >    In file included from include/linux/container_of.h:5,
> > >                     from include/linux/list.h:5,
> > >                     from include/linux/timer.h:5,
> > >                     from include/linux/workqueue.h:9,
> > >                     from include/linux/bpf.h:10,
> > >                     from net/ipv6/ip6_fib.c:18:
> > > >> include/linux/build_bug.h:78:41: error: static assertion failed: "=
sizeof(struct prefix_info) =3D=3D 32"
> > >       78 | #define __static_assert(expr, msg, ...) _Static_assert(exp=
r, msg)
> > >          |                                         ^~~~~~~~~~~~~~
> > >    include/linux/build_bug.h:77:34: note: in expansion of macro '__st=
atic_assert'
> > >       77 | #define static_assert(expr, ...) __static_assert(expr, ##_=
_VA_ARGS__, #expr)
> > >          |                                  ^~~~~~~~~~~~~~~
> > >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_a=
ssert'
> > >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> > >          | ^~~~~~~~~~~~~
> > >    net/ipv6/ip6_fib.c: In function 'fib6_add':
> > >    net/ipv6/ip6_fib.c:1384:32: warning: variable 'pn' set but not use=
d [-Wunused-but-set-variable]
> > >     1384 |         struct fib6_node *fn, *pn =3D NULL;
> > >          |                                ^~
> > >
> > >
> > > vim +78 include/linux/build_bug.h
> > >
> > > bc6245e5efd70c Ian Abbott       2017-07-10  60
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - ch=
eck integer constant expression at build time
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is=
 a wrapper for the C11 _Static_assert, with a
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic=
 to make the message optional (defaulting to the
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of=
 the tested expression).
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_=
BUG_ON(), static_assert() can be used at global
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but require=
s the expression to be an integer constant
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., =
it is not enough that __builtin_constant_p() is
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUI=
LD_BUG_ON() fails the build if the condition is
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static=
_assert() fails the build if the expression is
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert=
(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_asse=
rt(expr, msg, ...) _Static_assert(expr, msg)
> > > 6bab69c65013be Rasmus Villemoes 2019-03-07  79
> > > 07a368b3f55a79 Maxim Levitsky   2022-10-25  80
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wikiMaciej =C5=BBenczykowski, Kern=
el Networking Developer @ GoogleMaciej =C5=BBenczykowski, Kernel Networking=
 Developer @ GoogleMaciej =C5=BBenczykowski, Kernel Networking Developer @ =
Google

