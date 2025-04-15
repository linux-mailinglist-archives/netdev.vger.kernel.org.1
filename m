Return-Path: <netdev+bounces-182635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B34A8971C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF23A5F2C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D66274FE5;
	Tue, 15 Apr 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWvdqQhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C019C553;
	Tue, 15 Apr 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744707079; cv=none; b=hJLTu0KpMIk9tvFvnchDRN9UhnupzvGGWjg9BCDFM/Uv88vzDgrgXw3OuS/iheGPU4FTT4Mg1P59e01gmPh9bRnGX0otEkuvmF/JFdQp+pmAt6U8AmePOiQ1dAu33xlu4eA/IQc9ZYT+/HBOg311kuHHqkgK+8wSWGLRzZGxB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744707079; c=relaxed/simple;
	bh=uFoM1OSJ7bH0umyaxki2rqQUr8GppwAMJBfT2dE108A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPMcA7muIlCClqWx94q6PoLBt94R+Y8ceQ/c1dEwbZBVr//6pWRhQ/V1lGa0nHsGMV4TDU4FkQXjLI4zY3K2n1aFcYudHkCvzXpV17yLM9mX+E288PNo/4W3oyRG2BS5MnlQ8YYKol9mYMrNrnjuGCA7sruImMW09DlTzvwwuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWvdqQhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15296C4CEDD;
	Tue, 15 Apr 2025 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744707079;
	bh=uFoM1OSJ7bH0umyaxki2rqQUr8GppwAMJBfT2dE108A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RWvdqQhe8W7dZtLCjCQsoj/YMEj6NR2gL78jVz2Mf3F8AedfX9T8eG3xYJ4dpFgvL
	 mps+vZ0RHEQredlBvcl+TTdxduOs6UBoVv+blQZlmG5tdZMeT7sGgjp8fr91ZVC61a
	 rq0NvA0ukevtQwUNw4ANAMUzku636E36i+pV0jICBFto+aGyWdsAWdIaM5gojolbbb
	 xNx1eYL6OBHzc7jXhIOuAmZ7fG5/M2t8hsxHEK9ctt+3inPaN/iFBhhVj75aqxyvFj
	 KjFE7SFMO4U9zKE7zSLm+S/dL4Hg7952EJBkjuelQaDOfrHksTPQOiu8cV6t46JAyj
	 oKWfIkErYpMPw==
Date: Tue, 15 Apr 2025 16:51:02 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
Message-ID: <20250415165102.44551ada@sal.lan>
In-Reply-To: <20250415164014.575c0892@sal.lan>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
	<871pu1193r.fsf@trenco.lwn.net>
	<Z_zYXAJcTD-c3xTe@black.fi.intel.com>
	<87mscibwm8.fsf@trenco.lwn.net>
	<Z_4EL2bLm5Jva8Mq@smile.fi.intel.com>
	<Z_4E0y07kUdgrGQZ@smile.fi.intel.com>
	<87v7r5sw3a.fsf@intel.com>
	<Z_4WCDkAhfwF6WND@smile.fi.intel.com>
	<Z_4Wjv0hmORIwC_Z@smile.fi.intel.com>
	<20250415164014.575c0892@sal.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Tue, 15 Apr 2025 16:40:34 +0800
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Tue, 15 Apr 2025 11:19:26 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> escreveu:
>=20
> > On Tue, Apr 15, 2025 at 11:17:12AM +0300, Andy Shevchenko wrote: =20
> > > On Tue, Apr 15, 2025 at 10:49:29AM +0300, Jani Nikula wrote:   =20
> > > > On Tue, 15 Apr 2025, Andy Shevchenko <andriy.shevchenko@intel.com> =
wrote:   =20
> > > > > On Tue, Apr 15, 2025 at 10:01:04AM +0300, Andy Shevchenko wrote: =
  =20
> > > > >> On Mon, Apr 14, 2025 at 09:17:51AM -0600, Jonathan Corbet wrote:=
   =20
> > > > >> > Andy Shevchenko <andriy.shevchenko@intel.com> writes:   =20
> > > > >> > > On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wr=
ote:   =20
> > > > >> > >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > > > >> > >>    =20
> > > > >> > >> > This changeset contains the kernel-doc.py script to repla=
ce the verable
> > > > >> > >> > kernel-doc originally written in Perl. It replaces the fi=
rst version and the
> > > > >> > >> > second series I sent on the top of it.   =20
> > > > >> > >>=20
> > > > >> > >> OK, I've applied it, looked at the (minimal) changes in out=
put, and
> > > > >> > >> concluded that it's good - all this stuff is now in docs-ne=
xt.  Many
> > > > >> > >> thanks for doing this!
> > > > >> > >>=20
> > > > >> > >> I'm going to hold off on other documentation patches for a =
day or two
> > > > >> > >> just in case anything turns up.  But it looks awfully good.=
   =20
> > > > >> > >
> > > > >> > > This started well, until it becomes a scripts/lib/kdoc.
> > > > >> > > So, it makes the `make O=3D...` builds dirty *). Please make=
 sure this doesn't leave
> > > > >> > > "disgusting turd" )as said by Linus) in the clean tree.
> > > > >> > >
> > > > >> > > *) it creates that __pycache__ disaster. And no, .gitignore =
IS NOT a solution.   =20
> > > > >> >=20
> > > > >> > If nothing else, "make cleandocs" should clean it up, certainl=
y.
> > > > >> >=20
> > > > >> > We can also tell CPython to not create that directory at all. =
 I'll run
> > > > >> > some tests to see what the effect is on the documentation buil=
d times;
> > > > >> > I'm guessing it will not be huge...   =20
> > > > >>=20
> > > > >> I do not build documentation at all, it's just a regular code bu=
ild that leaves
> > > > >> tree dirty.
> > > > >>=20
> > > > >> $ python3 --version
> > > > >> Python 3.13.2
> > > > >>=20
> > > > >> It's standard Debian testing distribution, no customisation in t=
he code.
> > > > >>=20
> > > > >> To reproduce.
> > > > >> 1) I have just done a new build to reduce the churn, so, running=
 make again does nothing;
> > > > >> 2) The following snippet in shell shows the issue
> > > > >>=20
> > > > >> $ git clean -xdf
> > > > >> $ git status --ignored
> > > > >> On branch ...
> > > > >> nothing to commit, working tree clean
> > > > >>=20
> > > > >> $ make LLVM=3D-19 O=3D.../out W=3D1 C=3D1 CF=3D-D__CHECK_ENDIAN_=
_ -j64
> > > > >> make[1]: Entering directory '...'
> > > > >>   GEN     Makefile
> > > > >>   DESCEND objtool
> > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > >>   INSTALL libsubcmd_headers
> > > > >> .pylintrc: warning: ignored by one of the .gitignore files
> > > > >> Kernel: arch/x86/boot/bzImage is ready  (#23)
> > > > >> make[1]: Leaving directory '...'
> > > > >>=20
> > > > >> $ touch drivers/gpio/gpiolib-acpi.c
> > > > >>=20
> > > > >> $ make LLVM=3D-19 O=3D.../out W=3D1 C=3D1 CF=3D-D__CHECK_ENDIAN_=
_ -j64
> > > > >> make[1]: Entering directory '...'
> > > > >>   GEN     Makefile
> > > > >>   DESCEND objtool
> > > > >>   CALL    .../scripts/checksyscalls.sh
> > > > >>   INSTALL libsubcmd_headers
> > > > >> ...
> > > > >>   OBJCOPY arch/x86/boot/setup.bin
> > > > >>   BUILD   arch/x86/boot/bzImage
> > > > >> Kernel: arch/x86/boot/bzImage is ready  (#24)
> > > > >> make[1]: Leaving directory '...'
> > > > >>=20
> > > > >> $ git status --ignored
> > > > >> On branch ...
> > > > >> Untracked files:
> > > > >>   (use "git add <file>..." to include in what will be committed)
> > > > >> 	scripts/lib/kdoc/__pycache__/
> > > > >>=20
> > > > >> nothing added to commit but untracked files present (use "git ad=
d" to track)   =20
> > > > >
> > > > > FWIW, I repeated this with removing the O=3D.../out folder comple=
tely, so it's
> > > > > fully clean build. Still the same issue.
> > > > >
> > > > > And it appears at the very beginning of the build. You don't need=
 to wait to
> > > > > have the kernel to be built actually.   =20
> > > >=20
> > > > kernel-doc gets run on source files for W=3D1 builds. See Makefile.=
build.   =20
> > >=20
> > > Thanks for the clarification, so we know that it runs and we know tha=
t it has
> > > an issue.   =20
> >=20
> > Ideal solution what would I expect is that the cache folder should resp=
ect
> > the given O=3D... argument, or disabled at all (but I don't think the l=
atter
> > is what we want as it may slow down the build). =20
>=20
> From:
> 	https://github.com/python/cpython/commit/b193fa996a746111252156f11fb14c1=
2fd6267e6
> and:
> 	https://peps.python.org/pep-3147/
>=20
> It sounds that Python 3.8 and above have a way to specify the cache
> location, via PYTHONPYCACHEPREFIX env var, and via "-X pycache_prefix=3Dp=
ath".
>=20
> As the current minimal Python version is 3.9, we can safely use it.
>=20
> So, maybe this would work:
>=20
> 	make O=3D"../out" PYTHONPYCACHEPREFIX=3D"../out"
>=20
> or a variant of it:
>=20
> 	PYTHONPYCACHEPREFIX=3D"../out" make O=3D"../out"=20
>=20
> If this works, we can adjust the building system to fill PYTHONPYCACHEPRE=
FIX
> env var when O=3D is used.

That's interesting... Sphinx is already called with PYTHONDONTWRITEBYTECODE.
=46rom Documentation/Makefile:

	quiet_cmd_sphinx =3D SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
	      cmd_sphinx =3D $(MAKE) BUILDDIR=3D$(abspath $(BUILDDIR)) $(build)=3D=
Documentation/userspace-api/media $2 && \
	        PYTHONDONTWRITEBYTECODE=3D1 \
	...

It seems that the issue happens only when W=3D1 is used and kernel-doc
is called outside Sphinx.

Anyway, IMHO, the best would be to change the above to:

	PYTHONPYCACHEPREFIX=3D$(abspath $(BUILDDIR))

And do the same for the other places where kernel-doc is called:

	include/drm/Makefile:           $(srctree)/scripts/kernel-doc -none $(if $=
(CONFIG_WERROR)$(CONFIG_DRM_WERROR),-Werror) $<; \
	scripts/Makefile.build:  cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -n=
one $(KDOCFLAGS) \
	scripts/find-unused-docs.sh:    str=3D$(scripts/kernel-doc -export "$file"=
 2>/dev/null)

Comments?

Regards,
Mauro

