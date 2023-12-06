Return-Path: <netdev+bounces-54379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4560806D2F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35190B20D42
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691E3067E;
	Wed,  6 Dec 2023 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHDNek1g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A9026A1
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 03:00:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50beed2a46eso2788e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701860419; x=1702465219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMmFaZvS5h7RToi/+q85mvu4ziKR87LzF0o4UNMVquo=;
        b=AHDNek1g84idPvgexKdm6IJ/B+qjJtNDdsLLPSYjWfZxMp91bfzLQvK99vULqFDk2F
         HVZhumke8PP91npqcqDgPht63lmlVstJZZxy+lhA7NVUuCZoHl14g+EC4HzUj4xC2jY/
         8e70nDgcmyJwbYakaXVoX/fLZUa0hUOJ3nGBcaFW4wVrERbambXXVRwyJJGxOnk0QcYG
         8215BdAtX/tNNFaQzltTZ4pMiHGSU5BfBU0oArTQMZnmXxS3byF7KUG5vIV7uMHQZkfY
         Jz/i4E7+gLhe+ywWATepzOSwcInOrKBztCW5OVkZKA9GEv6wohqYsdWcshfMFy2ELWXG
         QRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860419; x=1702465219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMmFaZvS5h7RToi/+q85mvu4ziKR87LzF0o4UNMVquo=;
        b=qbdo/OWkDP6RN/jUC9X5V8cSx/GGjrN7WgMG8v1E4YkatV2ygB9Njm/5Lrzg6iF0gK
         rc97jukI05tGWRqLiVgPFstHbo8A76BAfhmODOTuFEVn/eWsg5auPAkttjpo5dqxUTc6
         uIG2kH4npJ0SBJ2N63xeQvT6A/klPZHKGBpITEpjfaFD+FvIYuzclFI21YbvXMHvSsEu
         Ym5BtZckXYmYE0GvdWhfu1uH0Hc2n/ieNDKqPdD67KM2s8BQHoill7FcbJHazQHMaFXe
         X72tu0WR+MtZob+X86qf1o5aKS9CLMjoeMB7X61LpsEM794dMGHkagoFfcPry9TPT46B
         ZcfA==
X-Gm-Message-State: AOJu0Yyr+9N1R8TsVjatSuzh2t1VxAke39bDO7hVALaCIB5y0THvwsmM
	2I5Vc3dF9faZr0s1g/pVENR8jHS281Vlc958rOrEzcbHkltE+fMEygeBrQ==
X-Google-Smtp-Source: AGHT+IENucUE82TjA2D5ix61H2xEyJajRb/c5mDoL6ZpULdZJYGqBFYgXmv/DlWZBwbBxxWQ7aZ5cKn1yJnS5HkmmNk=
X-Received: by 2002:ac2:549c:0:b0:50b:fcb7:15af with SMTP id
 t28-20020ac2549c000000b0050bfcb715afmr23062lfk.3.1701860418766; Wed, 06 Dec
 2023 03:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204195252.2004515-1-maze@google.com> <202312060307.EaL1FRwu-lkp@intel.com>
In-Reply-To: <202312060307.EaL1FRwu-lkp@intel.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 6 Dec 2023 03:00:00 -0800
Message-ID: <CANP3RGf-G1+OnBYrNpc1c_bzL1b-X4gzc=XtXs+5qArztxm1ug@mail.gmail.com>
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

On Tue, Dec 5, 2023 at 11:12=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Maciej,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-enczykowski=
/net-ipv6-support-reporting-otherwise-unknown-prefix-flags-in-RTM_NEWPREFIX=
/20231205-035333
> base:   net/main
> patch link:    https://lore.kernel.org/r/20231204195252.2004515-1-maze%40=
google.com
> patch subject: [PATCH net] net: ipv6: support reporting otherwise unknown=
 prefix flags in RTM_NEWPREFIX
> config: arm-rpc_defconfig (https://download.01.org/0day-ci/archive/202312=
06/202312060307.EaL1FRwu-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231206/202312060307.EaL1FRwu-lkp@intel.com/reproduce)

I followed these steps, and it built just fine...

maze@laptop:~/K$ git log -n2 --oneline
57cde6e635d5 (HEAD) net: ipv6: support reporting otherwise unknown
prefix flags in RTM_NEWPREFIX
7037d95a047c (net/main) r8152: add vendor/device ID pair for ASUS USB-C2500

maze@laptop:~/K$ file -sL build_dir/vmlinux
build_dir/vmlinux: ELF 32-bit LSB executable, ARM, EABI5 version 1
(SYSV), statically linked,
BuildID[sha1]=3Dae5a34fc35b264d707b3f16e920282b96c080508, not stripped

>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312060307.EaL1FRwu-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/module.h:12,
>                     from fs/lockd/svc.c:16:
> >> include/linux/build_bug.h:78:41: error: static assertion failed: "size=
of(struct prefix_info) =3D=3D 32"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, m=
sg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static=
_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_=
ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    include/net/addrconf.h:58:1: note: in expansion of macro 'static_asser=
t'
>       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
>          | ^~~~~~~~~~~~~
> --
>    In file included from lib/vsprintf.c:21:
> >> include/linux/build_bug.h:78:41: error: static assertion failed: "size=
of(struct prefix_info) =3D=3D 32"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, m=
sg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static=
_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_=
ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    include/net/addrconf.h:58:1: note: in expansion of macro 'static_asser=
t'
>       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
>          | ^~~~~~~~~~~~~
>    lib/vsprintf.c: In function 'va_format':
>    lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candid=
ate for 'gnu_printf' format attribute [-Wsuggest-attribute=3Dformat]
>     1683 |         buf +=3D vsnprintf(buf, end > buf ? end - buf : 0, va_=
fmt->fmt, va);
>          |         ^~~
> --
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/module.h:12,
>                     from net/ipv4/route.c:63:
> >> include/linux/build_bug.h:78:41: error: static assertion failed: "size=
of(struct prefix_info) =3D=3D 32"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, m=
sg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static=
_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_=
ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    include/net/addrconf.h:58:1: note: in expansion of macro 'static_asser=
t'
>       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
>          | ^~~~~~~~~~~~~
>    net/ipv4/route.c: In function 'ip_rt_send_redirect':
>    net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not =
used [-Wunused-but-set-variable]
>      880 |         int log_martians;
>          |             ^~~~~~~~~~~~
> --
>    In file included from include/linux/container_of.h:5,
>                     from include/linux/list.h:5,
>                     from include/linux/timer.h:5,
>                     from include/linux/workqueue.h:9,
>                     from include/linux/bpf.h:10,
>                     from net/ipv6/ip6_fib.c:18:
> >> include/linux/build_bug.h:78:41: error: static assertion failed: "size=
of(struct prefix_info) =3D=3D 32"
>       78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, m=
sg)
>          |                                         ^~~~~~~~~~~~~~
>    include/linux/build_bug.h:77:34: note: in expansion of macro '__static=
_assert'
>       77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_=
ARGS__, #expr)
>          |                                  ^~~~~~~~~~~~~~~
>    include/net/addrconf.h:58:1: note: in expansion of macro 'static_asser=
t'
>       58 | static_assert(sizeof(struct prefix_info) =3D=3D 32);
>          | ^~~~~~~~~~~~~
>    net/ipv6/ip6_fib.c: In function 'fib6_add':
>    net/ipv6/ip6_fib.c:1384:32: warning: variable 'pn' set but not used [-=
Wunused-but-set-variable]
>     1384 |         struct fib6_node *fn, *pn =3D NULL;
>          |                                ^~
>
>
> vim +78 include/linux/build_bug.h
>
> bc6245e5efd70c Ian Abbott       2017-07-10  60
> 6bab69c65013be Rasmus Villemoes 2019-03-07  61  /**
> 6bab69c65013be Rasmus Villemoes 2019-03-07  62   * static_assert - check =
integer constant expression at build time
> 6bab69c65013be Rasmus Villemoes 2019-03-07  63   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  64   * static_assert() is a w=
rapper for the C11 _Static_assert, with a
> 6bab69c65013be Rasmus Villemoes 2019-03-07  65   * little macro magic to =
make the message optional (defaulting to the
> 6bab69c65013be Rasmus Villemoes 2019-03-07  66   * stringification of the=
 tested expression).
> 6bab69c65013be Rasmus Villemoes 2019-03-07  67   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  68   * Contrary to BUILD_BUG_=
ON(), static_assert() can be used at global
> 6bab69c65013be Rasmus Villemoes 2019-03-07  69   * scope, but requires th=
e expression to be an integer constant
> 6bab69c65013be Rasmus Villemoes 2019-03-07  70   * expression (i.e., it i=
s not enough that __builtin_constant_p() is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  71   * true for expr).
> 6bab69c65013be Rasmus Villemoes 2019-03-07  72   *
> 6bab69c65013be Rasmus Villemoes 2019-03-07  73   * Also note that BUILD_B=
UG_ON() fails the build if the condition is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  74   * true, while static_ass=
ert() fails the build if the expression is
> 6bab69c65013be Rasmus Villemoes 2019-03-07  75   * false.
> 6bab69c65013be Rasmus Villemoes 2019-03-07  76   */
> 6bab69c65013be Rasmus Villemoes 2019-03-07  77  #define static_assert(exp=
r, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> 6bab69c65013be Rasmus Villemoes 2019-03-07 @78  #define __static_assert(e=
xpr, msg, ...) _Static_assert(expr, msg)
> 6bab69c65013be Rasmus Villemoes 2019-03-07  79
> 07a368b3f55a79 Maxim Levitsky   2022-10-25  80
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wikiMaciej =C5=BBenczykowski, Kernel N=
etworking Developer @ Google

