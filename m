Return-Path: <netdev+bounces-54382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E443806D51
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA211F21460
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E530FAE;
	Wed,  6 Dec 2023 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xihoDCV9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015C1991
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:05:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso7375a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701860726; x=1702465526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI7xJ7y401r3R3+JWtd6OZlY0bzTqJLiZf98hluMPxA=;
        b=xihoDCV9BxApFy7niGHBEzyMwgyhxb8ydo0yaXehgvhv2VevHHiF7ZzFeULLhv7tmG
         PiWtMNDkm1X4cPm/DexvgMpGmOYzzgzYqRD+jxPxZQv7GAt1aUKjefj4V0XD3LaDpfDz
         WE9j7mrlHBb5CIcgu4Yzq5qVUqynzlMPjGpUSh0OpkbLFqqhtVWyxkxVMmi+kkpFmat+
         02kxRF0SG2IqIjZhvTRXmGrhWXtIJnjY9Ix1yufuCX8aDHi0T6bG1d1fJPECXzbj8Clz
         S5O2DKQeTR/ORZ4119jmb4UQfkGve6Wv0Dm3FG/0AYKGdoy6IkYq/ljXy3kaPc47UdUq
         scmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860726; x=1702465526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI7xJ7y401r3R3+JWtd6OZlY0bzTqJLiZf98hluMPxA=;
        b=sVfiSfkAz0Eo2wzEKcAXkLWyCCkwCXY6rQJPtZejdJODWPJg+M/7FiW5yUtUZPW8tl
         zGf1I90tTfjsVeUThwmTaJb+CVF0EXzRVqNhj7+XUgH4TcH95r/gLg30d76d/o0Y84M7
         GuOlUZyq99Deyb73yxGXhN7DMGKx3JSxyGVN8wdmcuX2zo8mhz7qui2It52c2B0ki7ot
         Xw0aY2qHCAdNqDU+O/5cJuU1Zl6K44t1yJ4LQSKHYeOaoqi9wKLUxuDasQrOGy2l/AV4
         lrqqlL+hF5Xq+/mIrgdSfnLyAAgoRhjVFHPhDr85mTsCe6t70K/kX6snEnkO/QOuCLa6
         ohmQ==
X-Gm-Message-State: AOJu0YzGVHqiFwJp5NWzkz3j/Q3+YfPH4xGenDZ5cLsxAKNnMYBlmFFv
	6JZpR15+CmZ9/FtsE4NAIONPTLRCnxImd1/Y8shgMA==
X-Google-Smtp-Source: AGHT+IHEK7OOCCBuw4JxkPIEWDAPJdo6XOWUxTaabbGTwVCmS5z7NHvWK1MnX190wZHPJ8TgZbeJYtLUiwAtOHnDuHU=
X-Received: by 2002:a50:d744:0:b0:54c:384b:e423 with SMTP id
 i4-20020a50d744000000b0054c384be423mr57457edj.5.1701860725804; Wed, 06 Dec
 2023 03:05:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204195252.2004515-1-maze@google.com> <202312060307.EaL1FRwu-lkp@intel.com>
 <CANP3RGf-G1+OnBYrNpc1c_bzL1b-X4gzc=XtXs+5qArztxm1ug@mail.gmail.com>
In-Reply-To: <CANP3RGf-G1+OnBYrNpc1c_bzL1b-X4gzc=XtXs+5qArztxm1ug@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 6 Dec 2023 03:05:14 -0800
Message-ID: <CANP3RGcCNj1nFT9+Q_c06ox=LidhjBRcH-NWHA_75399fQdVhg@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: support reporting otherwise unknown prefix
 flags in RTM_NEWPREFIX
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shirley Ma <mashirle@us.ibm.com>, David Ahern <dsahern@kernel.org>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:00=E2=80=AFAM Maciej =C5=BBenczykowski <maze@googl=
e.com> wrote:
>
> On Tue, Dec 5, 2023 at 11:12=E2=80=AFAM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Maciej,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-enczykows=
ki/net-ipv6-support-reporting-otherwise-unknown-prefix-flags-in-RTM_NEWPREF=
IX/20231205-035333
> > base:   net/main
> > patch link:    https://lore.kernel.org/r/20231204195252.2004515-1-maze%=
40google.com
> > patch subject: [PATCH net] net: ipv6: support reporting otherwise unkno=
wn prefix flags in RTM_NEWPREFIX
> > config: arm-rpc_defconfig (https://download.01.org/0day-ci/archive/2023=
1206/202312060307.EaL1FRwu-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231206/202312060307.EaL1FRwu-lkp@intel.com/reproduce)
>
> I followed these steps, and it built just fine...
>
> maze@laptop:~/K$ git log -n2 --oneline
> 57cde6e635d5 (HEAD) net: ipv6: support reporting otherwise unknown
> prefix flags in RTM_NEWPREFIX
> 7037d95a047c (net/main) r8152: add vendor/device ID pair for ASUS USB-C25=
00
>
> maze@laptop:~/K$ file -sL build_dir/vmlinux
> build_dir/vmlinux: ELF 32-bit LSB executable, ARM, EABI5 version 1
> (SYSV), statically linked,
> BuildID[sha1]=3Dae5a34fc35b264d707b3f16e920282b96c080508, not stripped

ah, the reproduction steps don't actually fetch the .config

> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312060307.EaL1FRwu-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from include/linux/container_of.h:5,
> >                     from include/linux/list.h:5,
> >                     from include/linux/module.h:12,
> >                     from fs/lockd/svc.c:16:
> > >> include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct prefix_info) =3D=3D 32"
> >       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr,=
 msg)
> >          |                                         ^~~~~~~~~~~~~~
> >    include/linux/build_bug.h:77:34: note: in expansion of macro '__stat=
ic_assert'
> >       77 | #define static_assert(expr, ...) __static_assert(expr, ##__V=
A_ARGS__, #expr)
> >          |                                  ^~~~~~~~~~~~~~~
> >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_ass=
ert'
> >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> >          | ^~~~~~~~~~~~~
> > --
> >    In file included from lib/vsprintf.c:21:
> > >> include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct prefix_info) =3D=3D 32"
> >       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr,=
 msg)
> >          |                                         ^~~~~~~~~~~~~~
> >    include/linux/build_bug.h:77:34: note: in expansion of macro '__stat=
ic_assert'
> >       77 | #define static_assert(expr, ...) __static_assert(expr, ##__V=
A_ARGS__, #expr)
> >          |                                  ^~~~~~~~~~~~~~~
> >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_ass=
ert'
> >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> >          | ^~~~~~~~~~~~~
> >    lib/vsprintf.c: In function 'va_format':
> >    lib/vsprintf.c:1683:9: warning: function 'va_format' might be a cand=
idate for 'gnu_printf' format attribute [-Wsuggest-attribute=3Dformat]
> >     1683 |         buf +=3D vsnprintf(buf, end > buf ? end - buf : 0, v=
a_fmt->fmt, va);
> >          |         ^~~
> > --
> >    In file included from include/linux/container_of.h:5,
> >                     from include/linux/list.h:5,
> >                     from include/linux/module.h:12,
> >                     from net/ipv4/route.c:63:
> > >> include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct prefix_info) =3D=3D 32"
> >       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr,=
 msg)
> >          |                                         ^~~~~~~~~~~~~~
> >    include/linux/build_bug.h:77:34: note: in expansion of macro '__stat=
ic_assert'
> >       77 | #define static_assert(expr, ...) __static_assert(expr, ##__V=
A_ARGS__, #expr)
> >          |                                  ^~~~~~~~~~~~~~~
> >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_ass=
ert'
> >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> >          | ^~~~~~~~~~~~~
> >    net/ipv4/route.c: In function 'ip_rt_send_redirect':
> >    net/ipv4/route.c:880:13: warning: variable 'log_martians' set but no=
t used [-Wunused-but-set-variable]
> >      880 |         int log_martians;
> >          |             ^~~~~~~~~~~~
> > --
> >    In file included from include/linux/container_of.h:5,
> >                     from include/linux/list.h:5,
> >                     from include/linux/timer.h:5,
> >                     from include/linux/workqueue.h:9,
> >                     from include/linux/bpf.h:10,
> >                     from net/ipv6/ip6_fib.c:18:
> > >> include/linux/build_bug.h:78:41: error: static assertion failed: "si=
zeof(struct prefix_info) =3D=3D 32"
> >       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr,=
 msg)
> >          |                                         ^~~~~~~~~~~~~~
> >    include/linux/build_bug.h:77:34: note: in expansion of macro '__stat=
ic_assert'
> >       77 | #define static_assert(expr, ...) __static_assert(expr, ##__V=
A_ARGS__, #expr)
> >          |                                  ^~~~~~~~~~~~~~~
> >    include/net/addrconf.h:58:1: note: in expansion of macro 'static_ass=
ert'
> >       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
> >          | ^~~~~~~~~~~~~
> >    net/ipv6/ip6_fib.c: In function 'fib6_add':
> >    net/ipv6/ip6_fib.c:1384:32: warning: variable 'pn' set but not used =
[-Wunused-but-set-variable]
> >     1384 |         struct fib6_node *fn, *pn =3D NULL;
> >          |                                ^~
> >
> >
> > vim +78 include/linux/build_bug.h
> >
> > bc6245e5efd70c Ian Abbott       2017-07-10  60
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - chec=
k integer constant expression at build time
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a=
 wrapper for the C11 _Static_assert, with a
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic t=
o make the message optional (defaulting to the
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of t=
he tested expression).
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BU=
G_ON(), static_assert() can be used at global
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires =
the expression to be an integer constant
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it=
 is not enough that __builtin_constant_p() is
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD=
_BUG_ON() fails the build if the condition is
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_a=
ssert() fails the build if the expression is
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(e=
xpr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> > 6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert=
(expr, msg, ...) _Static_assert(expr, msg)
> > 6bab69c65013be Rasmus Villemoes 2019-03-07  79
> > 07a368b3f55a79 Maxim Levitsky   2022-10-25  80
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wikiMaciej =C5=BBenczykowski, Kernel=
 Networking Developer @ GoogleMaciej =C5=BBenczykowski, Kernel Networking D=
eveloper @ Google

