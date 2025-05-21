Return-Path: <netdev+bounces-192429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63297ABFDEE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05313B27FE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1423507D;
	Wed, 21 May 2025 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN2nen8j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB533DB
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859500; cv=none; b=ppx4iWvCbO0OAMdPJFIE1U5aKG1/FnswTALKmO7QK9yPr7yOAlThPQGrabNigBbAKFxVCNZs0o4lUtd4J4NZLQl8H5MNkEPGJGwp8LygA7MEcOk1AjtMoAJxa7rFKLIvxe/LUjF8nJ5sSW4y7MNjBaSboGUL8xvYmobc6WusnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859500; c=relaxed/simple;
	bh=aoJ6JtuIJ48U4peEoKeXi1FsLhoWZjlIebKenlAESeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYRSUKU/9WqgzZhb537Jwla5Wy55ylgxCEX+iJ5idzCe8Rg9r+V3qRtxDK08Swz5HDciWoafphJUEOM/wLT7tPLQiwXOG6Vi5c8jaNNerqNqUx09D0WY2ro8kvUW7UpyWSusPWcsiy0L9H1bMGwMnIQf1KOosWs8101CCPhucxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN2nen8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E9CC4CEE4;
	Wed, 21 May 2025 20:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859499;
	bh=aoJ6JtuIJ48U4peEoKeXi1FsLhoWZjlIebKenlAESeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jN2nen8jgb2PI4R46yYXOZeOeBho2VZQjs7u5Xp150eUQNyF/JKLxySabQY3fcXUG
	 A+0Nmw3ADAenVClKTMESZkLXBseadjsuFdYvyFuX136OMN/aCneWC+YhNF++YZmQ0M
	 JNJYRselA+EN4y7pdCqFtaMWms7M7oVkSKiLc0dg2dKt6oYcCvNdaqH9Sp0slR3Y/6
	 Tyuz4rdvJWNziOczcok8MUxTRltO+n9qcIE6iK1PUeANHfzsnwE4ATx1dMqUXsZ4Mi
	 85lkQmfQrJ87F60SUpx4hg/FmS7GtZE1YoTzFnzBRx7eLG4bGRWMubCmy9cGdStE+Z
	 o6qGJN5o2Fl0Q==
Date: Wed, 21 May 2025 13:31:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jstancek@redhat.com
Subject: Re: [PATCH net-next v2 10/12] tools: ynl: enable codegen for TC
Message-ID: <20250521133138.0c164028@kernel.org>
In-Reply-To: <20250520193625.6d6bc18b@kmaincent-XPS-13-7390>
References: <20250520161916.413298-1-kuba@kernel.org>
	<20250520161916.413298-11-kuba@kernel.org>
	<20250520183416.5b720968@kmaincent-XPS-13-7390>
	<20250520095005.1bdd64c7@kernel.org>
	<20250520193625.6d6bc18b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 19:36:25 +0200 Kory Maincent wrote:
> > > Now got this build error:
> > >=20
> > > -e 	GEN tc-user.c
> > > -e 	GEN tc-user.h
> > > -e 	GEN_RST tc.rst
> > > -e 	CC tc-user.o
> > > In file included from <command-line>:
> > > ./../../../../include/uapi//linux/pkt_cls.h:250:9: error: expected
> > > specifier-qualifier-list before =E2=80=98__struct_group=E2=80=99 250 |
> > > __struct_group(tc_u32_sel_hdr, hdr, /* no attrs */, |         ^~~~~~~=
~~~~~~~
> > > tc-user.c: In function =E2=80=98tc_u32_attrs_parse=E2=80=99:
> > > tc-user.c:9086:33: warning: comparison is always false due to limited=
 range
> > > of data type [-Wtype-limits] 9086 |                         if (len <
> > > sizeof(struct tc_u32_sel)) |                                 ^
> > > make[1]: *** [Makefile:52: tc-user.o] Error 1   =20
> >=20
> > Odd, are you sure you have the latest headers for Ubuntu 22.04? =20
>=20
> Indeed I wasn't but after an update I still got the same error.
> More precisely I am on Ubuntu 22.04.5 LTS. linux-headers-5.15.0-140

I tried to fix this but stddef includes compiler_types.h, which is=20
a non-uAPI header, apparently this gets stripped during header
installation, but there is no guard around it, so our current hack
of including the header directly doesn't work.

__struct_group() was added in v5.16, and v5.15 stable tree pulled=20
it in for v5.15.142, 1.5 years ago. But latest Ubuntu 22.04 package=20
with user space headers is linux-libc-dev_5.15.0-25.25_amd64.deb (note
that linux-headers is for kernel headers, eg to built a OOT module),
which AFAICT is 3 years old.

All in all your kernel headers are pretty old. I will try to fix this
separately, but let's not hold up this series :( You can update that
one header in your /usr/include/linux and everything else should work.

