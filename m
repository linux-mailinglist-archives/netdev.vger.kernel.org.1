Return-Path: <netdev+bounces-196646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F6AAD5AF8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF623A5FB3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396C7211293;
	Wed, 11 Jun 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpNJ9dBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661DA1F463E;
	Wed, 11 Jun 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656729; cv=none; b=Wl/mgmqIGufuNVFJbk3Ukeh8s6BzQ0A1KoP73MQzw1j8yGM252C9f3KdOW+o45n7HQw5dUsQRMI9TSXmBRf3/Z7O67Gartqz1WTYKdaAYlKzYvb06ErBnYFfQA9W4yJp73YzrHpXJXnyTNRpjniZ1ozVUwozW9azbnbzcfXw8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656729; c=relaxed/simple;
	bh=k5p0v37TDaj8N4j2L9tU2PmwNzNuqV7O6thIM3Zzy4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll4yiYMmkNP1jU70XFPNl/20Zow4QZzyD93aqK99hi+XTDSGrxF+PpZZWwtShFv/tWK4IS66+CA+2ZJrJmR8X+nIlIK/Waa5tM4c+NcwfnNHp+cL4XS+CvkD4NceDw+3VX/oH+xjLK7t+4oa2H2rnrroLpKv9WBsjK+0HczdzwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpNJ9dBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8DC4CEEA;
	Wed, 11 Jun 2025 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656729;
	bh=k5p0v37TDaj8N4j2L9tU2PmwNzNuqV7O6thIM3Zzy4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FpNJ9dBgPB55mqefSsUGH2dpZ/yd7pCLMRi6rRpipo/PBb4Dbv2ze40xkWDOdxFMm
	 3PoGCwLnYqwxDweRYpPGMJdgz2H9jj296bsQPro98ftCBUh+3bsEFZVZ94RmbtlV5K
	 tlYq8nRxFRzs1R5NcdF06rFPZZ+fopzbvPODOARHlHbsd92TIcoNxO5L5jMqfQG3pB
	 rJdR5Wwi8bWqIJtN3Rq6TbUQvR+roia1lRmE5Ga/8o2LiNJkQfhyYH7+N825x655dI
	 ZjPnmYxLNhA/4UUVfrjrcQqjp4uSsFFfIbn8Wb9it6iu285RLXafY4A0a8qiv2b335
	 MLArUN2b5H+4g==
Date: Wed, 11 Jun 2025 17:45:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco
 Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Donald
 Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250611174518.5b24bdad@sal.lan>
In-Reply-To: <aEhSu56ePZ/QPHUW@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<aEhSu56ePZ/QPHUW@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 10 Jun 2025 08:43:55 -0700
Breno Leitao <leitao@debian.org> escreveu:

> Hello Mauro,
>=20
> On Tue, Jun 10, 2025 at 12:46:07PM +0200, Mauro Carvalho Chehab wrote:
> > A better long term solution is to have an extension at
> > Documentation/sphinx that parses *.yaml files for netlink files,
> > which could internally be calling ynl_gen_rst.py. Yet, some care
> > needs to be taken, as yaml extensions are also used inside device
> > tree. =20
>=20
> In fact, This is very similar to what I did initially in v1. And I was
> creating a sphinx extension to handle the generation, have a look here:
>=20
> https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/
>=20
> During the review, we agree to move out of the sphinx extension.
> the reasons are the stubs/templates that needs to be created and you are
> creating here.
>=20
> So, if we decide to come back to sphinx extension, we can leverage that
> code from v1 ?!
>=20
> > -def generate_main_index_rst(output: str) -> None:
> > +def generate_main_index_rst(output: str, index_dir: str, ) -> None: =20
>=20
> You probably don't need the last , before ).
>=20
> Other than that, LGTM.
>=20
> The question is, are we OK with the templates that need to be created
> for netlink specs?!=20
>=20
> Thanks for looking at it,
> --breno

Hi Breno,

I did here a test creating a completely new repository using
sphinx-quickstart, adding yaml to conf.py with:

	source_suffix =3D ['.rst', '.yaml']

There, I imported your v1 patch from:
	https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/

While your extension seems to require some work, as it has issues
processing the current patch, it *is* creating one html file per each
yaml, without needing any template. All it is needed there is to place
an yaml file somewhere under source/ directory:

source/
=E2=94=9C=E2=94=80=E2=94=80 conf.py
=E2=94=9C=E2=94=80=E2=94=80 index.rst
=E2=94=9C=E2=94=80=E2=94=80 specs
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 conntrack.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 devlink.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dpll.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ethtool.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fou.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 handshake.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 index.rst
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lockd.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mptcp_pm.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 netdev.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net_shaper.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nfsd.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nftables.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nl80211.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nlctrl.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_datapath.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_flow.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_vport.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_addr.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_link.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_neigh.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_route.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_rule.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 tcp_metrics.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 tc.yaml
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 team.yaml
=E2=94=9C=E2=94=80=E2=94=80 _static
=E2=94=94=E2=94=80=E2=94=80 _templates

make html produces:

build/
=E2=94=9C=E2=94=80=E2=94=80 doctrees
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 environment.pickle
=E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 index.doctree
=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 specs
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 conntrack.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 devlink.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 dpll.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ethtool.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fou.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 handshake.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 index.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 lockd.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 mptcp_pm.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 netdev.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 net_shaper.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nfsd.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nftables.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nl80211.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nlctrl.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_datapath.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_flow.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_vport.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_addr.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_link.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_neigh.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_route.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_rule.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 tc.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 tcp_metrics.doctree
=E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 team.doctree
=E2=94=94=E2=94=80=E2=94=80 html
    =E2=94=9C=E2=94=80=E2=94=80 genindex.html
    =E2=94=9C=E2=94=80=E2=94=80 index.html
    =E2=94=9C=E2=94=80=E2=94=80 objects.inv
    =E2=94=9C=E2=94=80=E2=94=80 search.html
    =E2=94=9C=E2=94=80=E2=94=80 searchindex.js
    =E2=94=9C=E2=94=80=E2=94=80 _sources
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 index.rst.txt
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 specs
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 conntrack.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 devlink.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 dpll.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ethtool.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 fou.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 handshake.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 index.rst.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 lockd.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 mptcp_pm.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 netdev.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 net_shaper.yaml.t=
xt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nfsd.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nftables.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nl80211.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 nlctrl.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_datapath.yaml=
.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_flow.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ovs_vport.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_addr.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_link.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_neigh.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_route.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 rt_rule.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 tcp_metrics.yaml.=
txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 tc.yaml.txt
    =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 team.yaml.txt
    =E2=94=9C=E2=94=80=E2=94=80 specs
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 conntrack.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 devlink.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 dpll.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ethtool.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 fou.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 handshake.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 index.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 lockd.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mptcp_pm.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 netdev.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 net_shaper.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nfsd.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nftables.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nl80211.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 nlctrl.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_datapath.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_flow.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ovs_vport.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_addr.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_link.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_neigh.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_route.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 rt_rule.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 tc.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 tcp_metrics.html
    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 team.html
    =E2=94=94=E2=94=80=E2=94=80 _static
        =E2=94=9C=E2=94=80=E2=94=80 alabaster.css
        =E2=94=9C=E2=94=80=E2=94=80 basic.css
        =E2=94=9C=E2=94=80=E2=94=80 custom.css
        =E2=94=9C=E2=94=80=E2=94=80 doctools.js
        =E2=94=9C=E2=94=80=E2=94=80 documentation_options.js
        =E2=94=9C=E2=94=80=E2=94=80 file.png
        =E2=94=9C=E2=94=80=E2=94=80 language_data.js
        =E2=94=9C=E2=94=80=E2=94=80 minus.png
        =E2=94=9C=E2=94=80=E2=94=80 plus.png
        =E2=94=9C=E2=94=80=E2=94=80 pygments.css
        =E2=94=9C=E2=94=80=E2=94=80 searchtools.js
        =E2=94=94=E2=94=80=E2=94=80 sphinx_highlight.js

There are several warnings at the build, but that's likely because
you may need to do changes at the Sphinx extension to align with
the current version of ynl_gen_rst.py.=20

Please notice that I found a bug on kerneldoc due to the way
it was splitting lines. The correct way to do it is to use Sphinx
statemachine, e.g.:

	lines =3D statemachine.string2lines(out, self.tab_width,
                                            convert_whitespace=3DTrue)
        result =3D ViewList()

        for line, lineoffset in enum(lines):
            doc =3D str(env.srcdir) + "/" + env.docname + ":" + str(self.li=
neno)
            result.append(line, doc + ": " + filename, lineoffset)

Perhaps some of the errors/warnings there are due to that.

You will likely need to add an index.yaml file to Documentation/netlink=20
(which could be empty), as Sphinx requires an 1:1 mapping between=20
source and output files, but everything can be generated automatically.

The only extra logic you might need at the extension would be to
ignore yaml files under doctree. Even this may not require code
changes, as conf.py has "exclude_patterns" variable that could be
used for such purpose.

The vast majority of the code outside the Kernel tree were
automatically generated by sphinx-quickstart. All changes I
did are under GPL v2.

Regards,
Mauro

---

commit e37c713f3c8236c3e28d392c835c2c94c24c88aa
Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue Jun 10 23:08:05 2025 +0200

Initial version of a test repository generated by sphinx-quickstart

The original script at extensions/netlink_spec.py was written
by Breno Leit=C3=A3o, and comes from:
	https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/

The contents under source/specs came from linux-docs git tree.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei.com>

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 000000000000..8025bc04008c
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,2 @@
+__pycache__
+*~
diff --git a/Makefile b/Makefile
new file mode 100644
index 000000000000..d0c3cbf1020d
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,20 @@
+# Minimal makefile for Sphinx documentation
+#
+
+# You can set these variables from the command line, and also
+# from the environment for the first two.
+SPHINXOPTS    ?=3D
+SPHINXBUILD   ?=3D sphinx-build
+SOURCEDIR     =3D source
+BUILDDIR      =3D build
+
+# Put it first so that "make" without argument is like "make help".
+help:
+	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
+
+.PHONY: help Makefile
+
+# Catch-all target: route all unknown targets to Sphinx using the new
+# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
+%: Makefile
+	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
diff --git a/extensions/netlink_spec.py b/extensions/netlink_spec.py
new file mode 100755
index 000000000000..80756e72ed4f
--- /dev/null
+++ b/extensions/netlink_spec.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- coding: utf-8; mode: python -*-
+
+"""
+    netlink-spec
+    ~~~~~~~~~~~~~~~~~~~
+
+    Implementation of the ``netlink-spec`` ReST-directive.
+
+    :copyright:  Copyright (C) 2023  Breno Leitao <leitao@debian.org>
+    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+
+    The ``netlink-spec`` reST-directive performs extensive parsing
+    specific to the Linux kernel's standard netlink specs, in an
+    effort to avoid needing to heavily mark up the original YAML file.
+
+    This code is split in three big parts:
+        1) RST formatters: Use to convert a string to a RST output
+        2) Parser helpers: Helper functions to parse the YAML data
+        3) NetlinkSpec Directive: The actual directive class
+"""
+
+from typing import Any, Dict, List
+import os.path
+from docutils.parsers.rst import Directive
+from docutils import statemachine
+import yaml
+
+__version__ =3D "1.0"
+SPACE_PER_LEVEL =3D 4
+
+# RST Formatters
+def rst_definition(key: str, value: Any, level: int =3D 0) -> str:
+    """Format a single rst definition"""
+    return headroom(level) + key + "\n" + headroom(level + 1) + str(value)
+
+
+def rst_paragraph(paragraph: str, level: int =3D 0) -> str:
+    """Return a formatted paragraph"""
+    return headroom(level) + paragraph
+
+
+def headroom(level: int) -> str:
+    """Return space to format"""
+    return " " * (level * SPACE_PER_LEVEL)
+
+
+def rst_bullet(item: str, level: int =3D 0) -> str:
+    """Return a formatted a bullet"""
+    return headroom(level) + f" - {item}"
+
+def rst_subsubtitle(title: str) -> str:
+    """Add a sub-sub-title to the document"""
+    return f"{title}\n" + "~" * len(title)
+
+
+def rst_fields(key: str, value: str, level: int =3D 0) -> str:
+    """Return a RST formatted field"""
+    return headroom(level) + f":{key}: {value}"
+
+
+def rst_subtitle(title: str, level: int =3D 0) -> str:
+    """Add a subtitle to the document"""
+    return headroom(level) + f"\n{title}\n" + "-" * len(title)
+
+
+def rst_list_inline(list_: List[str], level: int =3D 0) -> str:
+    """Format a list using inlines"""
+    return headroom(level) + "[" + ", ".join(inline(i) for i in list_) + "=
]"
+
+
+def bold(text: str) -> str:
+    """Format bold text"""
+    return f"**{text}**"
+
+
+def inline(text: str) -> str:
+    """Format inline text"""
+    return f"``{text}``"
+
+
+def sanitize(text: str) -> str:
+    """Remove newlines and multiple spaces"""
+    # This is useful for some fields that are spread in multiple lines
+    return str(text).replace("\n", "").strip()
+
+
+# Parser helpers
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+def parse_mcast_group(mcast_group: List[Dict[str, Any]]) -> str:
+    """Parse 'multicast' group list and return a formatted string"""
+    lines =3D []
+    for group in mcast_group:
+        lines.append(rst_paragraph(group["name"], 1))
+
+    return "\n".join(lines)
+
+
+def parse_do(do_dict: Dict[str, Any], level: int =3D 0) -> str:
+    """Parse 'do' section and return a formatted string"""
+    lines =3D []
+    for key in do_dict.keys():
+        lines.append(rst_bullet(bold(key), level + 1))
+        lines.append(parse_do_attributes(do_dict[key], level + 1) + "\n")
+
+    return "\n".join(lines)
+
+
+def parse_do_attributes(attrs: Dict[str, Any], level: int =3D 0) -> str:
+    """Parse 'attributes' section"""
+    if "attributes" not in attrs:
+        return ""
+    lines =3D [rst_fields("attributes", rst_list_inline(attrs["attributes"=
]), level + 1)]
+
+    return "\n".join(lines)
+
+
+def parse_operations(operations: List[Dict[str, Any]]) -> str:
+    """Parse operations block"""
+    preprocessed =3D ["name", "doc", "title", "do", "dump"]
+    lines =3D []
+
+    for operation in operations:
+        lines.append(rst_subsubtitle(operation["name"]))
+        lines.append(rst_paragraph(operation["doc"]) + "\n")
+        if "do" in operation:
+            lines.append(rst_paragraph(bold("do"), 1))
+            lines.append(parse_do(operation["do"], 1))
+        if "dump" in operation:
+            lines.append(rst_paragraph(bold("dump"), 1))
+            lines.append(parse_do(operation["dump"], 1))
+
+        for key in operation.keys():
+            if key in preprocessed:
+                # Skip the special fields
+                continue
+            lines.append(rst_fields(key, operation[key], 1))
+
+        # New line after fields
+        lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
+    """Parse a list of entries"""
+    lines =3D []
+    for entry in entries:
+        if isinstance(entry, dict):
+            # entries could be a list or a dictionary
+            lines.append(
+                rst_fields(entry.get("name"), sanitize(entry.get("doc")), =
level)
+            )
+        elif isinstance(entry, list):
+            lines.append(rst_list_inline(entry, level))
+        else:
+            lines.append(rst_bullet(inline(sanitize(entry)), level))
+
+    lines.append("\n")
+    return "\n".join(lines)
+
+
+def parse_definitions(defs: Dict[str, Any]) -> str:
+    """Parse definitions section"""
+    preprocessed =3D ["name", "entries", "members"]
+    ignored =3D ["render-max"] # This is not printed
+    lines =3D []
+
+    for definition in defs:
+        lines.append(rst_subsubtitle(definition["name"]))
+        for k in definition.keys():
+            if k in preprocessed + ignored:
+                continue
+            lines.append(rst_fields(k, sanitize(definition[k]), 1))
+
+        # Field list needs to finish with a new line
+        lines.append("\n")
+        if "entries" in definition:
+            lines.append(rst_paragraph(bold("Entries"), 1))
+            lines.append(parse_entries(definition["entries"], 2))
+        if "members" in definition:
+            lines.append(rst_paragraph(bold("members"), 1))
+            lines.append(parse_entries(definition["members"], 2))
+
+    return "\n".join(lines)
+
+
+def parse_attributes_set(entries: List[Dict[str, Any]]) -> str:
+    """Parse attribute from attribute-set"""
+    preprocessed =3D ["name", "type"]
+    ignored =3D ["checks"]
+    lines =3D []
+
+    for entry in entries:
+        lines.append(rst_bullet(bold(entry["name"])))
+        for attr in entry["attributes"]:
+            type_ =3D attr.get("type")
+            attr_line =3D bold(attr["name"])
+            if type_:
+                # Add the attribute type in the same line
+                attr_line +=3D f" ({inline(type_)})"
+
+            lines.append(rst_bullet(attr_line, 2))
+
+            for k in attr.keys():
+                if k in preprocessed + ignored:
+                    continue
+                lines.append(rst_fields(k, sanitize(attr[k]), 3))
+            lines.append("\n")
+
+    return "\n".join(lines)
+
+
+def parse_yaml(obj: Dict[str, Any]) -> str:
+    """Format the whole yaml into a RST string"""
+    lines =3D []
+
+    # This is coming from the RST
+    lines.append(rst_subtitle("Summary"))
+    lines.append(rst_paragraph(obj["doc"], 1))
+
+    # Operations
+    lines.append(rst_subtitle("Operations"))
+    lines.append(parse_operations(obj["operations"]["list"]))
+
+    # Multicast groups
+    if "mcast-groups" in obj:
+        lines.append(rst_subtitle("Multicast groups"))
+        lines.append(parse_mcast_group(obj["mcast-groups"]["list"]))
+
+    # Definitions
+    lines.append(rst_subtitle("Definitions"))
+    lines.append(parse_definitions(obj["definitions"]))
+
+    # Attributes set
+    lines.append(rst_subtitle("Attribute sets"))
+    lines.append(parse_attributes_set(obj["attribute-sets"]))
+
+    return "\n".join(lines)
+
+
+def parse_yaml_file(filename: str, debug: bool =3D False) -> str:
+    """Transform the yaml specified by filename into a rst-formmated strin=
g"""
+    with open(filename, "r") as file:
+        yaml_data =3D yaml.safe_load(file)
+        content =3D parse_yaml(yaml_data)
+
+    if debug:
+        # Save the rst for inspection
+        print(content, file=3Dopen(f"/tmp/{filename.split('/')[-1]}.rst", =
"w"))
+
+    return content
+
+
+# Main Sphinx Extension class
+def setup(app):
+    """Sphinx-build register function for 'netlink-spec' directive"""
+    app.add_directive("netlink-spec", NetlinkSpec)
+    return dict(version=3D__version__, parallel_read_safe=3DTrue, parallel=
_write_safe=3DTrue)
+
+
+class NetlinkSpec(Directive):
+    """NetlinkSpec (``netlink-spec``) directive class"""
+    has_content =3D True
+    # Argument is the filename to process
+    required_arguments =3D 1
+
+    def run(self):
+        srctree =3D os.path.abspath(os.environ["srctree"])
+        yaml_file =3D os.path.join(
+            srctree, "Documentation/netlink/specs", self.arguments[0]
+        )
+        self.state.document.settings.record_dependencies.add(yaml_file)
+
+        try:
+            content =3D parse_yaml_file(yaml_file)
+        except FileNotFoundError as exception:
+            raise self.severe(str(exception))
+
+        self.state_machine.insert_input(statemachine.string2lines(content)=
, yaml_file)
+
+        return []
diff --git a/source/conf.py b/source/conf.py
new file mode 100644
index 000000000000..d68b56368335
--- /dev/null
+++ b/source/conf.py
@@ -0,0 +1,37 @@
+# Configuration file for the Sphinx documentation builder.
+#
+# For the full list of built-in configuration values, see the documentatio=
n:
+# https://www.sphinx-doc.org/en/master/usage/configuration.html
+
+# -- Project information -------------------------------------------------=
----
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-in=
formation
+
+import os
+import sys
+
+project =3D 'gen_html'
+copyright =3D '2025, Mauro Carvalho Chehab'
+author =3D 'Mauro Carvalho Chehab'
+
+# -- General configuration -----------------------------------------------=
----
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-co=
nfiguration
+
+sys.path.insert(0, os.path.abspath("../extensions"))
+
+extensions =3D [
+#    "write_pages",
+    "netlink_spec",
+]
+
+templates_path =3D ['_templates']
+exclude_patterns =3D []
+
+
+# File extensions to process
+source_suffix =3D ['.rst', '.yaml']
+
+# -- Options for HTML output ---------------------------------------------=
----
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-fo=
r-html-output
+
+html_theme =3D 'alabaster'
+html_static_path =3D ['_static']
diff --git a/source/index.rst b/source/index.rst
new file mode 100644
index 000000000000..bbedcf38b48f
--- /dev/null
+++ b/source/index.rst
@@ -0,0 +1,8 @@
+Sphinx extension test
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+.. toctree::
+   :maxdepth: 2
+
+   specs/index
diff --git a/source/specs/conntrack.yaml b/source/specs/conntrack.yaml
new file mode 100644
index 000000000000..840dc4504216
--- /dev/null
+++ b/source/specs/conntrack.yaml
@@ -0,0 +1,643 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: conntrack
+protocol: netlink-raw
+protonum: 12
+
+doc:
+  Netfilter connection tracking subsystem over nfnetlink
+
+definitions:
+  -
+    name: nfgenmsg
+    type: struct
+    members:
+      -
+        name: nfgen-family
+        type: u8
+      -
+        name: version
+        type: u8
+      -
+        name: res-id
+        byte-order: big-endian
+        type: u16
+  -
+    name: nf-ct-tcp-flags-mask
+    type: struct
+    members:
+      -
+        name: flags
+        type: u8
+        enum: nf-ct-tcp-flags
+        enum-as-flags: true
+      -
+        name: mask
+        type: u8
+        enum: nf-ct-tcp-flags
+        enum-as-flags: true
+  -
+    name: nf-ct-tcp-flags
+    type: flags
+    entries:
+      - window-scale
+      - sack-perm
+      - close-init
+      - be-liberal
+      - unacked
+      - maxack
+      - challenge-ack
+      - simultaneous-open
+  -
+    name: nf-ct-tcp-state
+    type: enum
+    entries:
+      - none
+      - syn-sent
+      - syn-recv
+      - established
+      - fin-wait
+      - close-wait
+      - last-ack
+      - time-wait
+      - close
+      - syn-sent2
+      - max
+      - ignore
+      - retrans
+      - unack
+      - timeout-max
+  -
+    name: nf-ct-sctp-state
+    type: enum
+    entries:
+      - none
+      - cloned
+      - cookie-wait
+      - cookie-echoed
+      - established
+      - shutdown-sent
+      - shutdown-received
+      - shutdown-ack-sent
+      - shutdown-heartbeat-sent
+  -
+    name: nf-ct-status
+    type: flags
+    entries:
+      - expected
+      - seen-reply
+      - assured
+      - confirmed
+      - src-nat
+      - dst-nat
+      - seq-adj
+      - src-nat-done
+      - dst-nat-done
+      - dying
+      - fixed-timeout
+      - template
+      - nat-clash
+      - helper
+      - offload
+      - hw-offload
+
+attribute-sets:
+  -
+    name: counter-attrs
+    attributes:
+      -
+        name: packets
+        type: u64
+        byte-order: big-endian
+      -
+        name: bytes
+        type: u64
+        byte-order: big-endian
+      -
+        name: packets-old
+        type: u32
+      -
+        name: bytes-old
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: tuple-proto-attrs
+    attributes:
+      -
+        name: proto-num
+        type: u8
+        doc: l4 protocol number
+      -
+        name: proto-src-port
+        type: u16
+        byte-order: big-endian
+        doc: l4 source port
+      -
+        name: proto-dst-port
+        type: u16
+        byte-order: big-endian
+        doc: l4 source port
+      -
+        name: proto-icmp-id
+        type: u16
+        byte-order: big-endian
+        doc: l4 icmp id
+      -
+        name: proto-icmp-type
+        type: u8
+      -
+        name: proto-icmp-code
+        type: u8
+      -
+        name: proto-icmpv6-id
+        type: u16
+        byte-order: big-endian
+        doc: l4 icmp id
+      -
+        name: proto-icmpv6-type
+        type: u8
+      -
+        name: proto-icmpv6-code
+        type: u8
+  -
+    name: tuple-ip-attrs
+    attributes:
+      -
+        name: ip-v4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+        doc: ipv4 source address
+      -
+        name: ip-v4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+        doc: ipv4 destination address
+      -
+        name: ip-v6-src
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: ipv6 source address
+      -
+        name: ip-v6-dst
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+        doc: ipv6 destination address
+  -
+    name: tuple-attrs
+    attributes:
+    -
+        name: tuple-ip
+        type: nest
+        nested-attributes: tuple-ip-attrs
+        doc: conntrack l3 information
+    -
+        name: tuple-proto
+        type: nest
+        nested-attributes: tuple-proto-attrs
+        doc: conntrack l4 information
+    -
+        name: tuple-zone
+        type: u16
+        byte-order: big-endian
+        doc: conntrack zone id
+  -
+    name: protoinfo-tcp-attrs
+    attributes:
+    -
+        name: tcp-state
+        type: u8
+        enum: nf-ct-tcp-state
+        doc: tcp connection state
+    -
+        name: tcp-wscale-original
+        type: u8
+        doc: window scaling factor in original direction
+    -
+        name: tcp-wscale-reply
+        type: u8
+        doc: window scaling factor in reply direction
+    -
+        name: tcp-flags-original
+        type: binary
+        struct: nf-ct-tcp-flags-mask
+    -
+        name: tcp-flags-reply
+        type: binary
+        struct: nf-ct-tcp-flags-mask
+  -
+    name: protoinfo-dccp-attrs
+    attributes:
+    -
+        name: dccp-state
+        type: u8
+        doc: dccp connection state
+    -
+        name: dccp-role
+        type: u8
+    -
+        name: dccp-handshake-seq
+        type: u64
+        byte-order: big-endian
+    -
+        name: dccp-pad
+        type: pad
+  -
+    name: protoinfo-sctp-attrs
+    attributes:
+    -
+        name: sctp-state
+        type: u8
+        doc: sctp connection state
+        enum: nf-ct-sctp-state
+    -
+        name: vtag-original
+        type: u32
+        byte-order: big-endian
+    -
+        name: vtag-reply
+        type: u32
+        byte-order: big-endian
+  -
+    name: protoinfo-attrs
+    attributes:
+    -
+        name: protoinfo-tcp
+        type: nest
+        nested-attributes: protoinfo-tcp-attrs
+        doc: conntrack tcp state information
+    -
+        name: protoinfo-dccp
+        type: nest
+        nested-attributes: protoinfo-dccp-attrs
+        doc: conntrack dccp state information
+    -
+        name: protoinfo-sctp
+        type: nest
+        nested-attributes: protoinfo-sctp-attrs
+        doc: conntrack sctp state information
+  -
+    name: help-attrs
+    attributes:
+      -
+        name: help-name
+        type: string
+        doc: helper name
+  -
+    name: nat-proto-attrs
+    attributes:
+      -
+        name: nat-port-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: nat-port-max
+        type: u16
+        byte-order: big-endian
+  -
+    name: nat-attrs
+    attributes:
+      -
+        name: nat-v4-minip
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-v4-maxip
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-v6-minip
+        type: binary
+      -
+        name: nat-v6-maxip
+        type: binary
+      -
+        name: nat-proto
+        type: nest
+        nested-attributes: nat-proto-attrs
+  -
+    name: seqadj-attrs
+    attributes:
+      -
+        name: correction-pos
+        type: u32
+        byte-order: big-endian
+      -
+        name: offset-before
+        type: u32
+        byte-order: big-endian
+      -
+        name: offset-after
+        type: u32
+        byte-order: big-endian
+  -
+    name: secctx-attrs
+    attributes:
+      -
+        name: secctx-name
+        type: string
+  -
+    name: synproxy-attrs
+    attributes:
+      -
+        name: isn
+        type: u32
+        byte-order: big-endian
+      -
+        name: its
+        type: u32
+        byte-order: big-endian
+      -
+        name: tsoff
+        type: u32
+        byte-order: big-endian
+  -
+    name: conntrack-attrs
+    attributes:
+      -
+        name: tuple-orig
+        type: nest
+        nested-attributes: tuple-attrs
+        doc: conntrack l3+l4 protocol information, original direction
+      -
+        name: tuple-reply
+        type: nest
+        nested-attributes: tuple-attrs
+        doc: conntrack l3+l4 protocol information, reply direction
+      -
+        name: status
+        type: u32
+        byte-order: big-endian
+        enum: nf-ct-status
+        enum-as-flags: true
+        doc: conntrack flag bits
+      -
+        name: protoinfo
+        type: nest
+        nested-attributes: protoinfo-attrs
+      -
+        name: help
+        type: nest
+        nested-attributes: help-attrs
+      -
+        name: nat-src
+        type: nest
+        nested-attributes: nat-attrs
+      -
+        name: timeout
+        type: u32
+        byte-order: big-endian
+      -
+        name: mark
+        type: u32
+        byte-order: big-endian
+      -
+        name: counters-orig
+        type: nest
+        nested-attributes: counter-attrs
+      -
+        name: counters-reply
+        type: nest
+        nested-attributes: counter-attrs
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+      -
+        name: id
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-dst
+        type: nest
+        nested-attributes: nat-attrs
+      -
+        name: tuple-master
+        type: nest
+        nested-attributes: tuple-attrs
+      -
+        name: seq-adj-orig
+        type: nest
+        nested-attributes: seqadj-attrs
+      -
+        name: seq-adj-reply
+        type: nest
+        nested-attributes: seqadj-attrs
+      -
+        name: secmark
+        type: binary
+        doc: obsolete
+      -
+        name: zone
+        type: u16
+        byte-order: big-endian
+        doc: conntrack zone id
+      -
+        name: secctx
+        type: nest
+        nested-attributes: secctx-attrs
+      -
+        name: timestamp
+        type: u64
+        byte-order: big-endian
+      -
+        name: mark-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: labels
+        type: binary
+      -
+        name: labels mask
+        type: binary
+      -
+        name: synproxy
+        type: nest
+        nested-attributes: synproxy-attrs
+      -
+        name: filter
+        type: nest
+        nested-attributes: tuple-attrs
+      -
+        name: status-mask
+        type: u32
+        byte-order: big-endian
+        enum: nf-ct-status
+        enum-as-flags: true
+        doc: conntrack flag bits to change
+      -
+        name: timestamp-event
+        type: u64
+        byte-order: big-endian
+  -
+    name: conntrack-stats-attrs
+    attributes:
+      -
+        name: searched
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: found
+        type: u32
+        byte-order: big-endian
+      -
+        name: new
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: invalid
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: ignore
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: delete
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: delete-list
+        type: u32
+        byte-order: big-endian
+        doc: obsolete
+      -
+        name: insert
+        type: u32
+        byte-order: big-endian
+      -
+        name: insert-failed
+        type: u32
+        byte-order: big-endian
+      -
+        name: drop
+        type: u32
+        byte-order: big-endian
+      -
+        name: early-drop
+        type: u32
+        byte-order: big-endian
+      -
+        name: error
+        type: u32
+        byte-order: big-endian
+      -
+        name: search-restart
+        type: u32
+        byte-order: big-endian
+      -
+        name: clash-resolve
+        type: u32
+        byte-order: big-endian
+      -
+        name: chain-toolong
+        type: u32
+        byte-order: big-endian
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: get
+      doc: get / dump entries
+      attribute-set: conntrack-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0x101
+          attributes:
+            - tuple-orig
+            - tuple-reply
+            - zone
+        reply:
+          value: 0x100
+          attributes:
+            - tuple-orig
+            - tuple-reply
+            - status
+            - protoinfo
+            - help
+            - nat-src
+            - nat-dst
+            - timeout
+            - mark
+            - counter-orig
+            - counter-reply
+            - use
+            - id
+            - nat-dst
+            - tuple-master
+            - seq-adj-orig
+            - seq-adj-reply
+            - zone
+            - secctx
+            - labels
+            - synproxy
+      dump:
+        request:
+          value: 0x101
+          attributes:
+            - nfgen-family
+            - mark
+            - filter
+            - status
+            - zone
+        reply:
+          value: 0x100
+          attributes:
+            - tuple-orig
+            - tuple-reply
+            - status
+            - protoinfo
+            - help
+            - nat-src
+            - nat-dst
+            - timeout
+            - mark
+            - counter-orig
+            - counter-reply
+            - use
+            - id
+            - nat-dst
+            - tuple-master
+            - seq-adj-orig
+            - seq-adj-reply
+            - zone
+            - secctx
+            - labels
+            - synproxy
+    -
+      name: get-stats
+      doc: dump pcpu conntrack stats
+      attribute-set: conntrack-stats-attrs
+      fixed-header: nfgenmsg
+      dump:
+        request:
+          value: 0x104
+        reply:
+          value: 0x104
+          attributes:
+            - searched
+            - found
+            - insert
+            - insert-failed
+            - drop
+            - early-drop
+            - error
+            - search-restart
+            - clash-resolve
+            - chain-toolong
diff --git a/source/specs/devlink.yaml b/source/specs/devlink.yaml
new file mode 100644
index 000000000000..bd9726269b4f
--- /dev/null
+++ b/source/specs/devlink.yaml
@@ -0,0 +1,2268 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: devlink
+
+protocol: genetlink-legacy
+
+doc: Partial family for Devlink.
+
+definitions:
+  -
+    type: enum
+    name: sb-pool-type
+    entries:
+      -
+        name: ingress
+      -
+        name: egress
+  -
+    type: enum
+    name: port-type
+    entries:
+      -
+        name: notset
+      -
+        name: auto
+      -
+        name: eth
+      -
+        name: ib
+  -
+    type: enum
+    name: port-flavour
+    entries:
+      -
+        name: physical
+      -
+        name: cpu
+      -
+        name: dsa
+      -
+        name: pci_pf
+      -
+        name: pci_vf
+      -
+        name: virtual
+      -
+        name: unused
+      -
+        name: pci_sf
+  -
+    type: enum
+    name: port-fn-state
+    entries:
+      -
+        name: inactive
+      -
+        name: active
+  -
+    type: enum
+    name: port-fn-opstate
+    entries:
+      -
+        name: detached
+      -
+        name: attached
+  -
+    type: enum
+    name: port-fn-attr-cap
+    entries:
+      -
+        name: roce-bit
+      -
+        name: migratable-bit
+      -
+        name: ipsec-crypto-bit
+      -
+        name: ipsec-packet-bit
+  -
+    type: enum
+    name: rate-type
+    entries:
+      -
+        name: leaf
+      -
+        name: node
+  -
+    type: enum
+    name: sb-threshold-type
+    entries:
+      -
+        name: static
+      -
+        name: dynamic
+  -
+    type: enum
+    name: eswitch-mode
+    entries:
+      -
+        name: legacy
+      -
+        name: switchdev
+  -
+    type: enum
+    name: eswitch-inline-mode
+    entries:
+      -
+        name: none
+      -
+        name: link
+      -
+        name: network
+      -
+        name: transport
+  -
+    type: enum
+    name: eswitch-encap-mode
+    entries:
+      -
+        name: none
+      -
+        name: basic
+  -
+    type: enum
+    name: dpipe-header-id
+    entries:
+      -
+        name: ethernet
+      -
+        name: ipv4
+      -
+        name: ipv6
+  -
+    type: enum
+    name: dpipe-match-type
+    entries:
+      -
+        name: field-exact
+  -
+    type: enum
+    name: dpipe-action-type
+    entries:
+      -
+        name: field-modify
+  -
+    type: enum
+    name: dpipe-field-mapping-type
+    entries:
+      -
+        name: none
+      -
+        name: ifindex
+  -
+    type: enum
+    name: resource-unit
+    entries:
+      -
+        name: entry
+  -
+    type: enum
+    name: reload-action
+    entries:
+      -
+        name: driver-reinit
+        value: 1
+      -
+        name: fw-activate
+  -
+    type: enum
+    name: param-cmode
+    entries:
+      -
+        name: runtime
+      -
+        name: driverinit
+      -
+        name: permanent
+  -
+    type: enum
+    name: flash-overwrite
+    entries:
+      -
+        name: settings-bit
+      -
+        name: identifiers-bit
+  -
+    type: enum
+    name: trap-action
+    entries:
+      -
+        name: drop
+      -
+        name: trap
+      -
+        name: mirror
+  -
+    type: enum
+    name: trap-type
+    entries:
+      -
+        name: drop
+      -
+        name: exception
+      -
+        name: control
+
+attribute-sets:
+  -
+    name: devlink
+    name-prefix: devlink-attr-
+    attributes:
+      -
+        name: bus-name
+        type: string
+        value: 1
+      -
+        name: dev-name
+        type: string
+      -
+        name: port-index
+        type: u32
+      -
+        name: port-type
+        type: u16
+        enum: port-type
+      -
+        name: port-desired-type
+        type: u16
+      -
+        name: port-netdev-ifindex
+        type: u32
+      -
+        name: port-netdev-name
+        type: string
+      -
+        name: port-ibdev-name
+        type: string
+      -
+        name: port-split-count
+        type: u32
+      -
+        name: port-split-group
+        type: u32
+      -
+        name: sb-index
+        type: u32
+      -
+        name: sb-size
+        type: u32
+      -
+        name: sb-ingress-pool-count
+        type: u16
+      -
+        name: sb-egress-pool-count
+        type: u16
+      -
+        name: sb-ingress-tc-count
+        type: u16
+      -
+        name: sb-egress-tc-count
+        type: u16
+      -
+        name: sb-pool-index
+        type: u16
+      -
+        name: sb-pool-type
+        type: u8
+        enum: sb-pool-type
+      -
+        name: sb-pool-size
+        type: u32
+      -
+        name: sb-pool-threshold-type
+        type: u8
+        enum: sb-threshold-type
+      -
+        name: sb-threshold
+        type: u32
+      -
+        name: sb-tc-index
+        type: u16
+      -
+        name: sb-occ-cur
+        type: u32
+      -
+        name: sb-occ-max
+        type: u32
+      -
+        name: eswitch-mode
+        type: u16
+        enum: eswitch-mode
+      -
+        name: eswitch-inline-mode
+        type: u8
+        enum: eswitch-inline-mode
+      -
+        name: dpipe-tables
+        type: nest
+        nested-attributes: dl-dpipe-tables
+      -
+        name: dpipe-table
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-table
+      -
+        name: dpipe-table-name
+        type: string
+      -
+        name: dpipe-table-size
+        type: u64
+      -
+        name: dpipe-table-matches
+        type: nest
+        nested-attributes: dl-dpipe-table-matches
+      -
+        name: dpipe-table-actions
+        type: nest
+        nested-attributes: dl-dpipe-table-actions
+      -
+        name: dpipe-table-counters-enabled
+        type: u8
+      -
+        name: dpipe-entries
+        type: nest
+        nested-attributes: dl-dpipe-entries
+      -
+        name: dpipe-entry
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-entry
+      -
+        name: dpipe-entry-index
+        type: u64
+      -
+        name: dpipe-entry-match-values
+        type: nest
+        nested-attributes: dl-dpipe-entry-match-values
+      -
+        name: dpipe-entry-action-values
+        type: nest
+        nested-attributes: dl-dpipe-entry-action-values
+      -
+        name: dpipe-entry-counter
+        type: u64
+      -
+        name: dpipe-match
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-match
+      -
+        name: dpipe-match-value
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-match-value
+      -
+        name: dpipe-match-type
+        type: u32
+        enum: dpipe-match-type
+      -
+        name: dpipe-action
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-action
+      -
+        name: dpipe-action-value
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-action-value
+      -
+        name: dpipe-action-type
+        type: u32
+        enum: dpipe-action-type
+      -
+        name: dpipe-value
+        type: binary
+      -
+        name: dpipe-value-mask
+        type: binary
+      -
+        name: dpipe-value-mapping
+        type: u32
+      -
+        name: dpipe-headers
+        type: nest
+        nested-attributes: dl-dpipe-headers
+      -
+        name: dpipe-header
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-header
+      -
+        name: dpipe-header-name
+        type: string
+      -
+        name: dpipe-header-id
+        type: u32
+        enum: dpipe-header-id
+      -
+        name: dpipe-header-fields
+        type: nest
+        nested-attributes: dl-dpipe-header-fields
+      -
+        name: dpipe-header-global
+        type: u8
+      -
+        name: dpipe-header-index
+        type: u32
+      -
+        name: dpipe-field
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-dpipe-field
+      -
+        name: dpipe-field-name
+        type: string
+      -
+        name: dpipe-field-id
+        type: u32
+      -
+        name: dpipe-field-bitwidth
+        type: u32
+      -
+        name: dpipe-field-mapping-type
+        type: u32
+        enum: dpipe-field-mapping-type
+      -
+        name: pad
+        type: pad
+      -
+        name: eswitch-encap-mode
+        type: u8
+        enum: eswitch-encap-mode
+      -
+        name: resource-list
+        type: nest
+        nested-attributes: dl-resource-list
+      -
+        name: resource
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-resource
+      -
+        name: resource-name
+        type: string
+      -
+        name: resource-id
+        type: u64
+      -
+        name: resource-size
+        type: u64
+      -
+        name: resource-size-new
+        type: u64
+      -
+        name: resource-size-valid
+        type: u8
+      -
+        name: resource-size-min
+        type: u64
+      -
+        name: resource-size-max
+        type: u64
+      -
+        name: resource-size-gran
+        type: u64
+      -
+        name: resource-unit
+        type: u8
+        enum: resource-unit
+      -
+        name: resource-occ
+        type: u64
+      -
+        name: dpipe-table-resource-id
+        type: u64
+      -
+        name: dpipe-table-resource-units
+        type: u64
+      -
+        name: port-flavour
+        type: u16
+        enum: port-flavour
+      -
+        name: port-number
+        type: u32
+      -
+        name: port-split-subport-number
+        type: u32
+      -
+        name: param
+        type: nest
+        nested-attributes: dl-param
+      -
+        name: param-name
+        type: string
+      -
+        name: param-generic
+        type: flag
+      -
+        name: param-type
+        type: u8
+
+      # TODO: fill in the attributes in between
+
+      -
+        name: param-value-cmode
+        type: u8
+        enum: param-cmode
+        value: 87
+      -
+        name: region-name
+        type: string
+      -
+        name: region-size
+        type: u64
+      -
+        name: region-snapshots
+        type: nest
+        nested-attributes: dl-region-snapshots
+      -
+        name: region-snapshot
+        type: nest
+        nested-attributes: dl-region-snapshot
+      -
+        name: region-snapshot-id
+        type: u32
+      -
+        name: region-chunks
+        type: nest
+        nested-attributes: dl-region-chunks
+      -
+        name: region-chunk
+        type: nest
+        nested-attributes: dl-region-chunk
+      -
+        name: region-chunk-data
+        type: binary
+      -
+        name: region-chunk-addr
+        type: u64
+      -
+        name: region-chunk-len
+        type: u64
+      -
+        name: info-driver-name
+        type: string
+      -
+        name: info-serial-number
+        type: string
+      -
+        name: info-version-fixed
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-info-version
+      -
+        name: info-version-running
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-info-version
+      -
+        name: info-version-stored
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-info-version
+      -
+        name: info-version-name
+        type: string
+      -
+        name: info-version-value
+        type: string
+      -
+        name: sb-pool-cell-size
+        type: u32
+      -
+        name: fmsg
+        type: nest
+        nested-attributes: dl-fmsg
+      -
+        name: fmsg-obj-nest-start
+        type: flag
+      -
+        name: fmsg-pair-nest-start
+        type: flag
+      -
+        name: fmsg-arr-nest-start
+        type: flag
+      -
+        name: fmsg-nest-end
+        type: flag
+      -
+        name: fmsg-obj-name
+        type: string
+      -
+        name: fmsg-obj-value-type
+        type: u8
+
+      # TODO: fill in the attributes in between
+
+      -
+        name: health-reporter
+        type: nest
+        value: 114
+        nested-attributes: dl-health-reporter
+      -
+        name: health-reporter-name
+        type: string
+      -
+        name: health-reporter-state
+        type: u8
+      -
+        name: health-reporter-err-count
+        type: u64
+      -
+        name: health-reporter-recover-count
+        type: u64
+      -
+        name: health-reporter-dump-ts
+        type: u64
+      -
+        name: health-reporter-graceful-period
+        type: u64
+      -
+        name: health-reporter-auto-recover
+        type: u8
+      -
+        name: flash-update-file-name
+        type: string
+      -
+        name: flash-update-component
+        type: string
+      -
+        name: flash-update-status-msg
+        type: string
+      -
+        name: flash-update-status-done
+        type: u64
+      -
+        name: flash-update-status-total
+        type: u64
+      -
+        name: port-pci-pf-number
+        type: u16
+      -
+        name: port-pci-vf-number
+        type: u16
+      -
+        name: stats
+        type: nest
+        nested-attributes: dl-attr-stats
+      -
+        name: trap-name
+        type: string
+      -
+        name: trap-action
+        type: u8
+        enum: trap-action
+      -
+        name: trap-type
+        type: u8
+        enum: trap-type
+      -
+        name: trap-generic
+        type: flag
+      -
+        name: trap-metadata
+        type: nest
+        nested-attributes: dl-trap-metadata
+      -
+        name: trap-group-name
+        type: string
+      -
+        name: reload-failed
+        type: u8
+      -
+        name: health-reporter-dump-ts-ns
+        type: u64
+      -
+        name: netns-fd
+        type: u32
+      -
+        name: netns-pid
+        type: u32
+      -
+        name: netns-id
+        type: u32
+      -
+        name: health-reporter-auto-dump
+        type: u8
+      -
+        name: trap-policer-id
+        type: u32
+      -
+        name: trap-policer-rate
+        type: u64
+      -
+        name: trap-policer-burst
+        type: u64
+      -
+        name: port-function
+        type: nest
+        nested-attributes: dl-port-function
+      -
+        name: info-board-serial-number
+        type: string
+      -
+        name: port-lanes
+        type: u32
+      -
+        name: port-splittable
+        type: u8
+      -
+        name: port-external
+        type: u8
+      -
+        name: port-controller-number
+        type: u32
+      -
+        name: flash-update-status-timeout
+        type: u64
+      -
+        name: flash-update-overwrite-mask
+        type: bitfield32
+        enum: flash-overwrite
+        enum-as-flags: True
+      -
+        name: reload-action
+        type: u8
+        enum: reload-action
+      -
+        name: reload-actions-performed
+        type: bitfield32
+        enum: reload-action
+        enum-as-flags: True
+      -
+        name: reload-limits
+        type: bitfield32
+        enum: reload-action
+        enum-as-flags: True
+      -
+        name: dev-stats
+        type: nest
+        nested-attributes: dl-dev-stats
+      -
+        name: reload-stats
+        type: nest
+        nested-attributes: dl-reload-stats
+      -
+        name: reload-stats-entry
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-reload-stats-entry
+      -
+        name: reload-stats-limit
+        type: u8
+      -
+        name: reload-stats-value
+        type: u32
+      -
+        name: remote-reload-stats
+        type: nest
+        nested-attributes: dl-reload-stats
+      -
+        name: reload-action-info
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-reload-act-info
+      -
+        name: reload-action-stats
+        type: nest
+        multi-attr: true
+        nested-attributes: dl-reload-act-stats
+      -
+        name: port-pci-sf-number
+        type: u32
+      -
+        name: rate-type
+        type: u16
+        enum: rate-type
+      -
+        name: rate-tx-share
+        type: u64
+      -
+        name: rate-tx-max
+        type: u64
+      -
+        name: rate-node-name
+        type: string
+      -
+        name: rate-parent-node-name
+        type: string
+      -
+         name: region-max-snapshots
+         type: u32
+      -
+        name: linecard-index
+        type: u32
+      -
+         name: linecard-state
+         type: u8
+      -
+        name: linecard-type
+        type: string
+      -
+        name: linecard-supported-types
+        type: nest
+        nested-attributes: dl-linecard-supported-types
+
+      # TODO: fill in the attributes in between
+
+      -
+        name: selftests
+        type: nest
+        value: 176
+        nested-attributes: dl-selftest-id
+      -
+        name: rate-tx-priority
+        type: u32
+      -
+        name: rate-tx-weight
+        type: u32
+      -
+        name: region-direct
+        type: flag
+
+  -
+    name: dl-dev-stats
+    subset-of: devlink
+    attributes:
+      -
+        name: reload-stats
+      -
+        name: remote-reload-stats
+
+  -
+    name: dl-reload-stats
+    subset-of: devlink
+    attributes:
+      -
+        name: reload-action-info
+
+  -
+    name: dl-reload-act-info
+    subset-of: devlink
+    attributes:
+      -
+        name: reload-action
+      -
+        name: reload-action-stats
+
+  -
+    name: dl-reload-act-stats
+    subset-of: devlink
+    attributes:
+      -
+        name: reload-stats-entry
+
+  -
+    name: dl-reload-stats-entry
+    subset-of: devlink
+    attributes:
+      -
+        name: reload-stats-limit
+      -
+        name: reload-stats-value
+
+  -
+    name: dl-info-version
+    subset-of: devlink
+    attributes:
+      -
+        name: info-version-name
+      -
+        name: info-version-value
+
+  -
+    name: dl-port-function
+    name-prefix: devlink-port-fn-attr-
+    attr-max-name: devlink-port-function-attr-max
+    attributes:
+      -
+        name-prefix: devlink-port-function-attr-
+        name: hw-addr
+        type: binary
+        value: 1
+      -
+        name: state
+        type: u8
+        enum: port-fn-state
+      -
+        name: opstate
+        type: u8
+        enum: port-fn-opstate
+      -
+        name: caps
+        type: bitfield32
+        enum: port-fn-attr-cap
+        enum-as-flags: True
+
+  -
+    name: dl-dpipe-tables
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-table
+
+  -
+    name: dl-dpipe-table
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-table-name
+      -
+        name: dpipe-table-size
+      -
+        name: dpipe-table-name
+      -
+        name: dpipe-table-size
+      -
+        name: dpipe-table-matches
+      -
+        name: dpipe-table-actions
+      -
+        name: dpipe-table-counters-enabled
+      -
+        name: dpipe-table-resource-id
+      -
+        name: dpipe-table-resource-units
+
+  -
+    name: dl-dpipe-table-matches
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-match
+
+  -
+    name: dl-dpipe-table-actions
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-action
+
+  -
+    name: dl-dpipe-entries
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-entry
+
+  -
+    name: dl-dpipe-entry
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-entry-index
+      -
+        name: dpipe-entry-match-values
+      -
+        name: dpipe-entry-action-values
+      -
+        name: dpipe-entry-counter
+
+  -
+    name: dl-dpipe-entry-match-values
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-match-value
+
+  -
+    name: dl-dpipe-entry-action-values
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-action-value
+
+  -
+    name: dl-dpipe-match
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-match-type
+      -
+        name: dpipe-header-id
+      -
+        name: dpipe-header-global
+      -
+        name: dpipe-header-index
+      -
+        name: dpipe-field-id
+
+  -
+    name: dl-dpipe-match-value
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-match
+      -
+        name: dpipe-value
+      -
+        name: dpipe-value-mask
+      -
+        name: dpipe-value-mapping
+
+  -
+    name: dl-dpipe-action
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-action-type
+      -
+        name: dpipe-header-id
+      -
+        name: dpipe-header-global
+      -
+        name: dpipe-header-index
+      -
+        name: dpipe-field-id
+
+  -
+    name: dl-dpipe-action-value
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-action
+      -
+        name: dpipe-value
+      -
+        name: dpipe-value-mask
+      -
+        name: dpipe-value-mapping
+
+  -
+    name: dl-dpipe-headers
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-header
+
+  -
+    name: dl-dpipe-header
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-header-name
+      -
+        name: dpipe-header-id
+      -
+        name: dpipe-header-global
+      -
+        name: dpipe-header-fields
+
+  -
+    name: dl-dpipe-header-fields
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-field
+
+  -
+    name: dl-dpipe-field
+    subset-of: devlink
+    attributes:
+      -
+        name: dpipe-field-name
+      -
+        name: dpipe-field-id
+      -
+        name: dpipe-field-bitwidth
+      -
+        name: dpipe-field-mapping-type
+
+  -
+    name: dl-resource
+    subset-of: devlink
+    attributes:
+      # -
+      # name: resource-list
+      # This is currently unsupported due to circular dependency
+      -
+        name: resource-name
+      -
+        name: resource-id
+      -
+        name: resource-size
+      -
+        name: resource-size-new
+      -
+        name: resource-size-valid
+      -
+        name: resource-size-min
+      -
+        name: resource-size-max
+      -
+        name: resource-size-gran
+      -
+        name: resource-unit
+      -
+        name: resource-occ
+
+  -
+    name: dl-resource-list
+    subset-of: devlink
+    attributes:
+      -
+        name: resource
+
+  -
+    name: dl-param
+    subset-of: devlink
+    attributes:
+      -
+        name: param-name
+      -
+        name: param-generic
+      -
+        name: param-type
+
+      # TODO: fill in the attribute param-value-list
+
+  -
+    name: dl-region-snapshots
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot
+
+  -
+    name: dl-region-snapshot
+    subset-of: devlink
+    attributes:
+      -
+        name: region-snapshot-id
+
+  -
+    name: dl-region-chunks
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk
+
+  -
+    name: dl-region-chunk
+    subset-of: devlink
+    attributes:
+      -
+        name: region-chunk-data
+      -
+        name: region-chunk-addr
+
+  -
+    name: dl-fmsg
+    subset-of: devlink
+    attributes:
+      -
+        name: fmsg-obj-nest-start
+      -
+        name: fmsg-pair-nest-start
+      -
+        name: fmsg-arr-nest-start
+      -
+        name: fmsg-nest-end
+      -
+        name: fmsg-obj-name
+
+  -
+    name: dl-health-reporter
+    subset-of: devlink
+    attributes:
+      -
+        name: health-reporter-name
+      -
+        name: health-reporter-state
+      -
+        name: health-reporter-err-count
+      -
+        name: health-reporter-recover-count
+      -
+        name: health-reporter-graceful-period
+      -
+        name: health-reporter-auto-recover
+      -
+        name: health-reporter-dump-ts
+      -
+        name: health-reporter-dump-ts-ns
+      -
+        name: health-reporter-auto-dump
+
+  -
+    name: dl-attr-stats
+    name-prefix: devlink-attr-
+    attributes:
+      - name: stats-rx-packets
+        type: u64
+        value: 0
+      -
+        name: stats-rx-bytes
+        type: u64
+      -
+        name: stats-rx-dropped
+        type: u64
+
+  -
+    name: dl-trap-metadata
+    name-prefix: devlink-attr-
+    attributes:
+      -
+        name: trap-metadata-type-in-port
+        type: flag
+        value: 0
+      -
+        name: trap-metadata-type-fa-cookie
+        type: flag
+
+  -
+    name: dl-linecard-supported-types
+    subset-of: devlink
+    attributes:
+      -
+        name: linecard-type
+
+  -
+    name: dl-selftest-id
+    name-prefix: devlink-attr-selftest-id-
+    attributes:
+      -
+        name: flash
+        type: flag
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: get
+      doc: Get devlink instances.
+      attribute-set: devlink
+      dont-validate: [ strict, dump ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 1
+          attributes: &dev-id-attrs
+            - bus-name
+            - dev-name
+        reply:  &get-reply
+          value: 3
+          attributes:
+            - bus-name
+            - dev-name
+            - reload-failed
+            - dev-stats
+      dump:
+        reply: *get-reply
+
+    -
+      name: port-get
+      doc: Get devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 5
+          attributes: &port-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+        reply:
+          value: 7
+          attributes: *port-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply:
+          value: 3  # due to a bug, port dump returns DEVLINK_CMD_NEW
+          attributes: *port-id-attrs
+
+    -
+      name: port-set
+      doc: Set devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - port-type
+            - port-function
+
+    -
+      name: port-new
+      doc: Create devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - port-flavour
+            - port-pci-pf-number
+            - port-pci-sf-number
+            - port-controller-number
+        reply:
+          value: 7
+          attributes: *port-id-attrs
+
+    -
+      name: port-del
+      doc: Delete devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes: *port-id-attrs
+
+    -
+      name: port-split
+      doc: Split devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - port-split-count
+
+    -
+      name: port-unsplit
+      doc: Unplit devlink port instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes: *port-id-attrs
+
+    -
+      name: sb-get
+      doc: Get shared buffer instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 11
+          attributes: &sb-id-attrs
+            - bus-name
+            - dev-name
+            - sb-index
+        reply: &sb-get-reply
+          value: 13
+          attributes: *sb-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *sb-get-reply
+
+    -
+      name: sb-pool-get
+      doc: Get shared buffer pool instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 15
+          attributes: &sb-pool-id-attrs
+            - bus-name
+            - dev-name
+            - sb-index
+            - sb-pool-index
+        reply: &sb-pool-get-reply
+          value: 17
+          attributes: *sb-pool-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *sb-pool-get-reply
+
+    -
+      name: sb-pool-set
+      doc: Set shared buffer pool instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - sb-index
+            - sb-pool-index
+            - sb-pool-threshold-type
+            - sb-pool-size
+
+    -
+      name: sb-port-pool-get
+      doc: Get shared buffer port-pool combinations and threshold.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 19
+          attributes: &sb-port-pool-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - sb-index
+            - sb-pool-index
+        reply: &sb-port-pool-get-reply
+          value: 21
+          attributes: *sb-port-pool-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *sb-port-pool-get-reply
+
+    -
+      name: sb-port-pool-set
+      doc: Set shared buffer port-pool combinations and threshold.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - sb-index
+            - sb-pool-index
+            - sb-threshold
+
+    -
+      name: sb-tc-pool-bind-get
+      doc: Get shared buffer port-TC to pool bindings and threshold.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          value: 23
+          attributes: &sb-tc-pool-bind-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - sb-index
+            - sb-pool-type
+            - sb-tc-index
+        reply: &sb-tc-pool-bind-get-reply
+          value: 25
+          attributes: *sb-tc-pool-bind-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *sb-tc-pool-bind-get-reply
+
+    -
+      name: sb-tc-pool-bind-set
+      doc: Set shared buffer port-TC to pool bindings and threshold.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - sb-index
+            - sb-pool-index
+            - sb-pool-type
+            - sb-tc-index
+            - sb-threshold
+
+    -
+      name: sb-occ-snapshot
+      doc: Take occupancy snapshot of shared buffer.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 27
+          attributes:
+            - bus-name
+            - dev-name
+            - sb-index
+
+    -
+      name: sb-occ-max-clear
+      doc: Clear occupancy watermarks of shared buffer.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - sb-index
+
+    -
+      name: eswitch-get
+      doc: Get eswitch attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes: *dev-id-attrs
+        reply:
+          value: 29
+          attributes: &eswitch-attrs
+            - bus-name
+            - dev-name
+            - eswitch-mode
+            - eswitch-inline-mode
+            - eswitch-encap-mode
+
+    -
+      name: eswitch-set
+      doc: Set eswitch attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes: *eswitch-attrs
+
+    -
+      name: dpipe-table-get
+      doc: Get dpipe table attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-table-name
+        reply:
+          value: 31
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-tables
+
+    -
+      name: dpipe-entries-get
+      doc: Get dpipe entries attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-table-name
+        reply:
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-entries
+
+    -
+      name: dpipe-headers-get
+      doc: Get dpipe headers attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+        reply:
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-headers
+
+    -
+      name: dpipe-table-counters-set
+      doc: Set dpipe counter attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - dpipe-table-name
+            - dpipe-table-counters-enabled
+
+    -
+      name: resource-set
+      doc: Set resource attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - resource-id
+            - resource-size
+
+    -
+      name: resource-dump
+      doc: Get resource attributes.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+        reply:
+          value: 36
+          attributes:
+            - bus-name
+            - dev-name
+            - resource-list
+
+    -
+      name: reload
+      doc: Reload devlink.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-dev-lock
+        post: devlink-nl-post-doit-dev-lock
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - reload-action
+            - reload-limits
+            - netns-pid
+            - netns-fd
+            - netns-id
+        reply:
+          attributes:
+            - bus-name
+            - dev-name
+            - reload-actions-performed
+
+    -
+      name: param-get
+      doc: Get param instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes: &param-id-attrs
+            - bus-name
+            - dev-name
+            - param-name
+        reply: &param-get-reply
+          attributes: *param-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *param-get-reply
+
+    -
+      name: param-set
+      doc: Set param instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - param-name
+            - param-type
+            # param-value-data is missing here as the type is variable
+            - param-value-cmode
+
+    -
+      name: region-get
+      doc: Get region instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          value: 42
+          attributes: &region-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - region-name
+        reply: &region-get-reply
+          value: 42
+          attributes: *region-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *region-get-reply
+
+    -
+      name: region-new
+      doc: Create region snapshot.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          value: 44
+          attributes: &region-snapshot-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - region-name
+            - region-snapshot-id
+        reply:
+          value: 44
+          attributes: *region-snapshot-id-attrs
+
+    -
+      name: region-del
+      doc: Delete region snapshot.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes: *region-snapshot-id-attrs
+
+    -
+      name: region-read
+      doc: Read region data.
+      attribute-set: devlink
+      dont-validate: [ dump-strict ]
+      flags: [ admin-perm ]
+      dump:
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - region-name
+            - region-snapshot-id
+            - region-direct
+            - region-chunk-addr
+            - region-chunk-len
+        reply:
+          value: 46
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - region-name
+
+    -
+      name: port-param-get
+      doc: Get port param instances.
+      attribute-set: devlink
+      dont-validate: [ strict, dump-strict ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes: *port-id-attrs
+        reply:
+          attributes: *port-id-attrs
+      dump:
+        reply:
+          attributes: *port-id-attrs
+
+    -
+      name: port-param-set
+      doc: Set port param instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port
+        post: devlink-nl-post-doit
+        request:
+          attributes: *port-id-attrs
+
+    -
+      name: info-get
+      doc: Get device information, like driver name, hardware and firmware=
 versions etc.
+      attribute-set: devlink
+      dont-validate: [ strict, dump ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 51
+          attributes: *dev-id-attrs
+        reply: &info-get-reply
+          value: 51
+          attributes:
+            - bus-name
+            - dev-name
+            - info-driver-name
+            - info-serial-number
+            - info-version-fixed
+            - info-version-running
+            - info-version-stored
+            - info-board-serial-number
+      dump:
+        reply: *info-get-reply
+
+    -
+      name: health-reporter-get
+      doc: Get health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes: &health-reporter-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - health-reporter-name
+        reply: &health-reporter-get-reply
+          attributes: *health-reporter-id-attrs
+      dump:
+        request:
+          attributes: *port-id-attrs
+        reply: *health-reporter-get-reply
+
+    -
+      name: health-reporter-set
+      doc: Set health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
+            - health-reporter-name
+            - health-reporter-graceful-period
+            - health-reporter-auto-recover
+            - health-reporter-auto-dump
+
+    -
+      name: health-reporter-recover
+      doc: Recover health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes: *health-reporter-id-attrs
+
+    -
+      name: health-reporter-diagnose
+      doc: Diagnose health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes: *health-reporter-id-attrs
+
+    -
+      name: health-reporter-dump-get
+      doc: Dump health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ dump-strict ]
+      flags: [ admin-perm ]
+      dump:
+        request:
+          attributes: *health-reporter-id-attrs
+        reply:
+          value: 56
+          attributes:
+            - fmsg
+
+    -
+      name: health-reporter-dump-clear
+      doc: Clear dump of health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          attributes: *health-reporter-id-attrs
+
+    -
+      name: flash-update
+      doc: Flash update devlink instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - flash-update-file-name
+            - flash-update-component
+            - flash-update-overwrite-mask
+
+    -
+      name: trap-get
+      doc: Get trap instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 61
+          attributes: &trap-id-attrs
+            - bus-name
+            - dev-name
+            - trap-name
+        reply: &trap-get-reply
+          value: 63
+          attributes: *trap-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *trap-get-reply
+
+    -
+      name: trap-set
+      doc: Set trap instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - trap-name
+            - trap-action
+
+    -
+      name: trap-group-get
+      doc: Get trap group instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 65
+          attributes: &trap-group-id-attrs
+            - bus-name
+            - dev-name
+            - trap-group-name
+        reply: &trap-group-get-reply
+          value: 67
+          attributes: *trap-group-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *trap-group-get-reply
+
+    -
+      name: trap-group-set
+      doc: Set trap group instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - trap-group-name
+            - trap-action
+            - trap-policer-id
+
+    -
+      name: trap-policer-get
+      doc: Get trap policer instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 69
+          attributes: &trap-policer-id-attrs
+            - bus-name
+            - dev-name
+            - trap-policer-id
+        reply: &trap-policer-get-reply
+          value: 71
+          attributes: *trap-policer-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *trap-policer-get-reply
+
+    -
+      name: trap-policer-set
+      doc: Get trap policer instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - trap-policer-id
+            - trap-policer-rate
+            - trap-policer-burst
+
+    -
+      name: health-reporter-test
+      doc: Test health reporter instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit-port-optional
+        post: devlink-nl-post-doit
+        request:
+          value: 73
+          attributes: *health-reporter-id-attrs
+
+    -
+      name: rate-get
+      doc: Get rate instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 74
+          attributes: &rate-id-attrs
+            - bus-name
+            - dev-name
+            - port-index
+            - rate-node-name
+        reply: &rate-get-reply
+          value: 76
+          attributes: *rate-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *rate-get-reply
+
+    -
+      name: rate-set
+      doc: Set rate instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - rate-node-name
+            - rate-tx-share
+            - rate-tx-max
+            - rate-tx-priority
+            - rate-tx-weight
+            - rate-parent-node-name
+
+    -
+      name: rate-new
+      doc: Create rate instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - rate-node-name
+            - rate-tx-share
+            - rate-tx-max
+            - rate-tx-priority
+            - rate-tx-weight
+            - rate-parent-node-name
+
+    -
+      name: rate-del
+      doc: Delete rate instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - rate-node-name
+
+    -
+      name: linecard-get
+      doc: Get line card instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 78
+          attributes: &linecard-id-attrs
+            - bus-name
+            - dev-name
+            - linecard-index
+        reply: &linecard-get-reply
+          value: 80
+          attributes: *linecard-id-attrs
+      dump:
+        request:
+          attributes: *dev-id-attrs
+        reply: *linecard-get-reply
+
+    -
+      name: linecard-set
+      doc: Set line card instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - linecard-index
+            - linecard-type
+
+    -
+      name: selftests-get
+      doc: Get device selftest instances.
+      attribute-set: devlink
+      dont-validate: [ strict, dump ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          value: 82
+          attributes: *dev-id-attrs
+        reply: &selftests-get-reply
+          value: 82
+          attributes: *dev-id-attrs
+      dump:
+        reply: *selftests-get-reply
+
+    -
+      name: selftests-run
+      doc: Run device selftest instances.
+      attribute-set: devlink
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+      do:
+        pre: devlink-nl-pre-doit
+        post: devlink-nl-post-doit
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - selftests
+
+    -
+      name: notify-filter-set
+      doc: Set notification messages socket filter.
+      attribute-set: devlink
+      do:
+        request:
+          attributes:
+            - bus-name
+            - dev-name
+            - port-index
diff --git a/source/specs/dpll.yaml b/source/specs/dpll.yaml
new file mode 100644
index 000000000000..8feefeae5376
--- /dev/null
+++ b/source/specs/dpll.yaml
@@ -0,0 +1,623 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: dpll
+
+doc: DPLL subsystem.
+
+definitions:
+  -
+    type: enum
+    name: mode
+    doc: |
+      working modes a dpll can support, differentiates if and how dpll sel=
ects
+      one of its inputs to syntonize with it, valid values for DPLL_A_MODE
+      attribute
+    entries:
+      -
+        name: manual
+        doc: input can be only selected by sending a request to dpll
+        value: 1
+      -
+        name: automatic
+        doc: highest prio input pin auto selected by dpll
+    render-max: true
+  -
+    type: enum
+    name: lock-status
+    doc: |
+      provides information of dpll device lock status, valid values for
+      DPLL_A_LOCK_STATUS attribute
+    entries:
+      -
+        name: unlocked
+        doc: |
+          dpll was not yet locked to any valid input (or forced by setting
+          DPLL_A_MODE to DPLL_MODE_DETACHED)
+        value: 1
+      -
+        name: locked
+        doc: |
+          dpll is locked to a valid signal, but no holdover available
+      -
+        name: locked-ho-acq
+        doc: |
+          dpll is locked and holdover acquired
+      -
+        name: holdover
+        doc: |
+          dpll is in holdover state - lost a valid lock or was forced
+          by disconnecting all the pins (latter possible only
+          when dpll lock-state was already DPLL_LOCK_STATUS_LOCKED_HO_ACQ,
+          if dpll lock-state was not DPLL_LOCK_STATUS_LOCKED_HO_ACQ, the
+          dpll's lock-state shall remain DPLL_LOCK_STATUS_UNLOCKED)
+    render-max: true
+  -
+    type: enum
+    name: lock-status-error
+    doc: |
+      if previous status change was done due to a failure, this provides
+      information of dpll device lock status error.
+      Valid values for DPLL_A_LOCK_STATUS_ERROR attribute
+    entries:
+      -
+        name: none
+        doc: |
+          dpll device lock status was changed without any error
+        value: 1
+      -
+        name: undefined
+        doc: |
+          dpll device lock status was changed due to undefined error.
+          Driver fills this value up in case it is not able
+          to obtain suitable exact error type.
+      -
+        name: media-down
+        doc: |
+          dpll device lock status was changed because of associated
+          media got down.
+          This may happen for example if dpll device was previously
+          locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
+      -
+        name: fractional-frequency-offset-too-high
+        doc: |
+          the FFO (Fractional Frequency Offset) between the RX and TX
+          symbol rate on the media got too high.
+          This may happen for example if dpll device was previously
+          locked on an input pin of type PIN_TYPE_SYNCE_ETH_PORT.
+    render-max: true
+  -
+    type: enum
+    name: clock-quality-level
+    doc: |
+      level of quality of a clock device. This mainly applies when
+      the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER.
+      The current list is defined according to the table 11-7 contained
+      in ITU-T G.8264/Y.1364 document. One may extend this list freely
+      by other ITU-T defined clock qualities, or different ones defined
+      by another standardization body (for those, please use
+      different prefix).
+    entries:
+      -
+        name: itu-opt1-prc
+        value: 1
+      -
+        name: itu-opt1-ssu-a
+      -
+        name: itu-opt1-ssu-b
+      -
+        name: itu-opt1-eec1
+      -
+        name: itu-opt1-prtc
+      -
+        name: itu-opt1-eprtc
+      -
+        name: itu-opt1-eeec
+      -
+        name: itu-opt1-eprc
+    render-max: true
+  -
+    type: const
+    name: temp-divider
+    value: 1000
+    doc: |
+      temperature divider allowing userspace to calculate the
+      temperature as float with three digit decimal precision.
+      Value of (DPLL_A_TEMP / DPLL_TEMP_DIVIDER) is integer part of
+      temperature value.
+      Value of (DPLL_A_TEMP % DPLL_TEMP_DIVIDER) is fractional part of
+      temperature value.
+  -
+    type: enum
+    name: type
+    doc: type of dpll, valid values for DPLL_A_TYPE attribute
+    entries:
+      -
+        name: pps
+        doc: dpll produces Pulse-Per-Second signal
+        value: 1
+      -
+        name: eec
+        doc: dpll drives the Ethernet Equipment Clock
+    render-max: true
+  -
+    type: enum
+    name: pin-type
+    doc: |
+      defines possible types of a pin, valid values for DPLL_A_PIN_TYPE
+      attribute
+    entries:
+      -
+        name: mux
+        doc: aggregates another layer of selectable pins
+        value: 1
+      -
+        name: ext
+        doc: external input
+      -
+        name: synce-eth-port
+        doc: ethernet port PHY's recovered clock
+      -
+        name: int-oscillator
+        doc: device internal oscillator
+      -
+        name: gnss
+        doc: GNSS recovered clock
+    render-max: true
+  -
+    type: enum
+    name: pin-direction
+    doc: |
+      defines possible direction of a pin, valid values for
+      DPLL_A_PIN_DIRECTION attribute
+    entries:
+      -
+        name: input
+        doc: pin used as a input of a signal
+        value: 1
+      -
+        name: output
+        doc: pin used to output the signal
+    render-max: true
+  -
+    type: const
+    name: pin-frequency-1-hz
+    value: 1
+  -
+    type: const
+    name: pin-frequency-10-khz
+    value: 10000
+  -
+    type: const
+    name: pin-frequency-77_5-khz
+    value: 77500
+  -
+    type: const
+    name: pin-frequency-10-mhz
+    value: 10000000
+  -
+    type: enum
+    name: pin-state
+    doc: |
+      defines possible states of a pin, valid values for
+      DPLL_A_PIN_STATE attribute
+    entries:
+      -
+        name: connected
+        doc: pin connected, active input of phase locked loop
+        value: 1
+      -
+        name: disconnected
+        doc: pin disconnected, not considered as a valid input
+      -
+        name: selectable
+        doc: pin enabled for automatic input selection
+    render-max: true
+  -
+    type: flags
+    name: pin-capabilities
+    doc: |
+      defines possible capabilities of a pin, valid flags on
+      DPLL_A_PIN_CAPABILITIES attribute
+    entries:
+      -
+        name: direction-can-change
+        doc: pin direction can be changed
+      -
+        name: priority-can-change
+        doc: pin priority can be changed
+      -
+        name: state-can-change
+        doc: pin state can be changed
+  -
+    type: const
+    name: phase-offset-divider
+    value: 1000
+    doc: |
+      phase offset divider allows userspace to calculate a value of
+      measured signal phase difference between a pin and dpll device
+      as a fractional value with three digit decimal precision.
+      Value of (DPLL_A_PHASE_OFFSET / DPLL_PHASE_OFFSET_DIVIDER) is an
+      integer part of a measured phase offset value.
+      Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
+      fractional part of a measured phase offset value.
+
+attribute-sets:
+  -
+    name: dpll
+    enum-name: dpll_a
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: module-name
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: clock-id
+        type: u64
+      -
+        name: mode
+        type: u32
+        enum: mode
+      -
+        name: mode-supported
+        type: u32
+        enum: mode
+        multi-attr: true
+      -
+        name: lock-status
+        type: u32
+        enum: lock-status
+      -
+        name: temp
+        type: s32
+      -
+        name: type
+        type: u32
+        enum: type
+      -
+        name: lock-status-error
+        type: u32
+        enum: lock-status-error
+      -
+        name: clock-quality-level
+        type: u32
+        enum: clock-quality-level
+        multi-attr: true
+        doc: |
+          Level of quality of a clock device. This mainly applies when
+          the dpll lock-status is DPLL_LOCK_STATUS_HOLDOVER. This could
+          be put to message multiple times to indicate possible parallel
+          quality levels (e.g. one specified by ITU option 1 and another
+          one specified by option 2).
+  -
+    name: pin
+    enum-name: dpll_a_pin
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: parent-id
+        type: u32
+      -
+        name: module-name
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: clock-id
+        type: u64
+      -
+        name: board-label
+        type: string
+      -
+        name: panel-label
+        type: string
+      -
+        name: package-label
+        type: string
+      -
+        name: type
+        type: u32
+        enum: pin-type
+      -
+        name: direction
+        type: u32
+        enum: pin-direction
+      -
+        name: frequency
+        type: u64
+      -
+        name: frequency-supported
+        type: nest
+        multi-attr: true
+        nested-attributes: frequency-range
+      -
+        name: frequency-min
+        type: u64
+      -
+        name: frequency-max
+        type: u64
+      -
+        name: prio
+        type: u32
+      -
+        name: state
+        type: u32
+        enum: pin-state
+      -
+        name: capabilities
+        type: u32
+        enum: pin-capabilities
+      -
+        name: parent-device
+        type: nest
+        multi-attr: true
+        nested-attributes: pin-parent-device
+      -
+        name: parent-pin
+        type: nest
+        multi-attr: true
+        nested-attributes: pin-parent-pin
+      -
+        name: phase-adjust-min
+        type: s32
+      -
+        name: phase-adjust-max
+        type: s32
+      -
+        name: phase-adjust
+        type: s32
+      -
+        name: phase-offset
+        type: s64
+      -
+        name: fractional-frequency-offset
+        type: sint
+        doc: |
+          The FFO (Fractional Frequency Offset) between the RX and TX
+          symbol rate on the media associated with the pin:
+          (rx_frequency-tx_frequency)/rx_frequency
+          Value is in PPM (parts per million).
+          This may be implemented for example for pin of type
+          PIN_TYPE_SYNCE_ETH_PORT.
+      -
+        name: esync-frequency
+        type: u64
+        doc: |
+          Frequency of Embedded SYNC signal. If provided, the pin is confi=
gured
+          with a SYNC signal embedded into its base clock frequency.
+      -
+        name: esync-frequency-supported
+        type: nest
+        multi-attr: true
+        nested-attributes: frequency-range
+        doc: |
+          If provided a pin is capable of embedding a SYNC signal (within =
given
+          range) into its base frequency signal.
+      -
+        name: esync-pulse
+        type: u32
+        doc: |
+          A ratio of high to low state of a SYNC signal pulse embedded
+          into base clock frequency. Value is in percents.
+  -
+    name: pin-parent-device
+    subset-of: pin
+    attributes:
+      -
+        name: parent-id
+      -
+        name: direction
+      -
+        name: prio
+      -
+        name: state
+      -
+        name: phase-offset
+  -
+    name: pin-parent-pin
+    subset-of: pin
+    attributes:
+      -
+        name: parent-id
+      -
+        name: state
+  -
+    name: frequency-range
+    subset-of: pin
+    attributes:
+      -
+        name: frequency-min
+      -
+        name: frequency-max
+
+operations:
+  enum-name: dpll_cmd
+  list:
+    -
+      name: device-id-get
+      doc: |
+        Get id of dpll device that matches given attributes
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-lock-doit
+        post: dpll-unlock-doit
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - type
+        reply:
+          attributes:
+            - id
+
+    -
+      name: device-get
+      doc: |
+        Get list of DPLL devices (dump) or attributes of a single dpll dev=
ice
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pre-doit
+        post: dpll-post-doit
+        request:
+          attributes:
+            - id
+        reply: &dev-attrs
+          attributes:
+            - id
+            - module-name
+            - mode
+            - mode-supported
+            - lock-status
+            - lock-status-error
+            - temp
+            - clock-id
+            - type
+
+      dump:
+        reply: *dev-attrs
+
+    -
+      name: device-set
+      doc: Set attributes for a DPLL device
+      attribute-set: dpll
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pre-doit
+        post: dpll-post-doit
+        request:
+          attributes:
+            - id
+    -
+      name: device-create-ntf
+      doc: Notification about device appearing
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: device-delete-ntf
+      doc: Notification about device disappearing
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: device-change-ntf
+      doc: Notification about device configuration being changed
+      notify: device-get
+      mcgrp: monitor
+    -
+      name: pin-id-get
+      doc: |
+        Get id of a pin that matches given attributes
+      attribute-set: pin
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-lock-doit
+        post: dpll-unlock-doit
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - board-label
+            - panel-label
+            - package-label
+            - type
+        reply:
+          attributes:
+            - id
+
+    -
+      name: pin-get
+      doc: |
+        Get list of pins and its attributes.
+
+        - dump request without any attributes given - list all the pins in=
 the
+          system
+        - dump request with target dpll - list all the pins registered with
+          a given dpll device
+        - do request with target dpll and target pin - single pin attribut=
es
+      attribute-set: pin
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pin-pre-doit
+        post: dpll-pin-post-doit
+        request:
+          attributes:
+            - id
+        reply: &pin-attrs
+          attributes:
+            - id
+            - board-label
+            - panel-label
+            - package-label
+            - type
+            - frequency
+            - frequency-supported
+            - capabilities
+            - parent-device
+            - parent-pin
+            - phase-adjust-min
+            - phase-adjust-max
+            - phase-adjust
+            - fractional-frequency-offset
+            - esync-frequency
+            - esync-frequency-supported
+            - esync-pulse
+
+      dump:
+        request:
+          attributes:
+            - id
+        reply: *pin-attrs
+
+    -
+      name: pin-set
+      doc: Set attributes of a target pin
+      attribute-set: pin
+      flags: [ admin-perm ]
+
+      do:
+        pre: dpll-pin-pre-doit
+        post: dpll-pin-post-doit
+        request:
+          attributes:
+            - id
+            - frequency
+            - direction
+            - prio
+            - state
+            - parent-device
+            - parent-pin
+            - phase-adjust
+            - esync-frequency
+    -
+      name: pin-create-ntf
+      doc: Notification about pin appearing
+      notify: pin-get
+      mcgrp: monitor
+    -
+      name: pin-delete-ntf
+      doc: Notification about pin disappearing
+      notify: pin-get
+      mcgrp: monitor
+    -
+      name: pin-change-ntf
+      doc: Notification about pin configuration being changed
+      notify: pin-get
+      mcgrp: monitor
+
+mcast-groups:
+  list:
+    -
+      name: monitor
diff --git a/source/specs/ethtool.yaml b/source/specs/ethtool.yaml
new file mode 100644
index 000000000000..655d8d10fe24
--- /dev/null
+++ b/source/specs/ethtool.yaml
@@ -0,0 +1,2384 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: ethtool
+
+protocol: genetlink-legacy
+
+doc: Partial family for Ethtool Netlink.
+uapi-header: linux/ethtool_netlink_generated.h
+
+definitions:
+  -
+    name: udp-tunnel-type
+    enum-name:
+    type: enum
+    entries: [ vxlan, geneve, vxlan-gpe ]
+    enum-cnt-name: __ethtool-udp-tunnel-type-cnt
+    render-max: true
+  -
+    name: stringset
+    type: enum
+    entries: []
+    header: linux/ethtool.h # skip rendering, no actual definition
+  -
+    name: header-flags
+    type: flags
+    name-prefix: ethtool-flag-
+    doc: common ethtool header flags
+    entries:
+      -
+        name: compact-bitsets
+        doc: use compact bitsets in reply
+      -
+        name: omit-reply
+        doc: provide optional reply for SET or ACT requests
+      -
+        name: stats
+        doc: request statistics, if supported by the driver
+  -
+    name: module-fw-flash-status
+    type: enum
+    doc: plug-in module firmware flashing status
+    header: linux/ethtool.h
+    entries:
+      -
+        name: started
+        doc: The firmware flashing process has started.
+      -
+        name: in_progress
+        doc: The firmware flashing process is in progress.
+      -
+        name: completed
+        doc: The firmware flashing process was completed successfully.
+      -
+        name: error
+        doc: The firmware flashing process was stopped due to an error.
+  -
+    name: c33-pse-ext-state
+    doc: "groups of PSE extended states functions. IEEE 802.3-2022 33.2.4.=
4 Variables"
+    type: enum
+    name-prefix: ethtool-c33-pse-ext-state-
+    header: linux/ethtool.h
+    entries:
+        -
+          name: none
+          doc: none
+        -
+          name: error-condition
+          doc: Group of error_condition states
+        -
+          name: mr-mps-valid
+          doc: Group of mr_mps_valid states
+        -
+          name: mr-pse-enable
+          doc: Group of mr_pse_enable states
+        -
+          name: option-detect-ted
+          doc: Group of option_detect_ted states
+        -
+          name: option-vport-lim
+          doc: Group of option_vport_lim states
+        -
+          name: ovld-detected
+          doc: Group of ovld_detected states
+        -
+          name: power-not-available
+          doc: Group of power_not_available states
+        -
+          name: short-detected
+          doc: Group of short_detected states
+  -
+    name: phy-upstream-type
+    enum-name:
+    type: enum
+    entries: [ mac, phy ]
+  -
+    name: tcp-data-split
+    type: enum
+    entries: [ unknown, disabled, enabled ]
+
+attribute-sets:
+  -
+    name: header
+    attr-cnt-name: __ethtool-a-header-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: dev-index
+        type: u32
+      -
+        name: dev-name
+        type: string
+      -
+        name: flags
+        type: u32
+        enum: header-flags
+      -
+        name: phy-index
+        type: u32
+
+  -
+    name: bitset-bit
+    attr-cnt-name: __ethtool-a-bitset-bit-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: index
+        type: u32
+      -
+        name: name
+        type: string
+      -
+        name: value
+        type: flag
+  -
+    name: bitset-bits
+    attr-cnt-name: __ethtool-a-bitset-bits-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: bit
+        type: nest
+        multi-attr: true
+        nested-attributes: bitset-bit
+  -
+    name: bitset
+    attr-cnt-name: __ethtool-a-bitset-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: nomask
+        type: flag
+      -
+        name: size
+        type: u32
+      -
+        name: bits
+        type: nest
+        nested-attributes: bitset-bits
+      -
+        name: value
+        type: binary
+      -
+        name: mask
+        type: binary
+  -
+    name: string
+    attr-cnt-name: __ethtool-a-string-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: index
+        type: u32
+      -
+        name: value
+        type: string
+  -
+    name: strings
+    attr-cnt-name: __ethtool-a-strings-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: string
+        type: nest
+        multi-attr: true
+        nested-attributes: string
+  -
+    name: stringset
+    attr-cnt-name: __ethtool-a-stringset-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: id
+        type: u32
+      -
+        name: count
+        type: u32
+      -
+        name: strings
+        type: nest
+        multi-attr: true
+        nested-attributes: strings
+  -
+    name: stringsets
+    attr-cnt-name: __ethtool-a-stringsets-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: stringset
+        type: nest
+        multi-attr: true
+        nested-attributes: stringset
+  -
+    name: strset
+    attr-cnt-name: __ethtool-a-strset-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: stringsets
+        type: nest
+        nested-attributes: stringsets
+      -
+        name: counts-only
+        type: flag
+
+  -
+    name: privflags
+    attr-cnt-name: __ethtool-a-privflags-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: flags
+        type: nest
+        nested-attributes: bitset
+
+  -
+    name: rings
+    attr-cnt-name: __ethtool-a-rings-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: rx-max
+        type: u32
+      -
+        name: rx-mini-max
+        type: u32
+      -
+        name: rx-jumbo-max
+        type: u32
+      -
+        name: tx-max
+        type: u32
+      -
+        name: rx
+        type: u32
+      -
+        name: rx-mini
+        type: u32
+      -
+        name: rx-jumbo
+        type: u32
+      -
+        name: tx
+        type: u32
+      -
+        name: rx-buf-len
+        type: u32
+      -
+        name: tcp-data-split
+        type: u8
+        enum: tcp-data-split
+      -
+        name: cqe-size
+        type: u32
+      -
+        name: tx-push
+        type: u8
+      -
+        name: rx-push
+        type: u8
+      -
+        name: tx-push-buf-len
+        type: u32
+      -
+        name: tx-push-buf-len-max
+        type: u32
+      -
+        name: hds-thresh
+        type: u32
+      -
+        name: hds-thresh-max
+        type: u32
+
+  -
+    name: mm-stat
+    attr-cnt-name: __ethtool-a-mm-stat-cnt
+    doc: MAC Merge (802.3)
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pad
+        type: pad
+      -
+        name: reassembly-errors
+        doc: aMACMergeFrameAssErrorCount
+        type: u64
+      -
+        name: smd-errors
+        doc: aMACMergeFrameSmdErrorCount
+        type: u64
+      -
+        name: reassembly-ok
+        doc: aMACMergeFrameAssOkCount
+        type: u64
+      -
+        name: rx-frag-count
+        doc: aMACMergeFragCountRx
+        type: u64
+      -
+        name: tx-frag-count
+        doc: aMACMergeFragCountTx
+        type: u64
+      -
+        name: hold-count
+        doc: aMACMergeHoldCount
+        type: u64
+  -
+    name: mm
+    attr-cnt-name: __ethtool-a-mm-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: pmac-enabled
+        type: u8
+      -
+        name: tx-enabled
+        type: u8
+      -
+        name: tx-active
+        type: u8
+      -
+        name: tx-min-frag-size
+        type: u32
+      -
+        name: rx-min-frag-size
+        type: u32
+      -
+        name: verify-enabled
+        type: u8
+      -
+        name: verify-status
+        type: u8
+      -
+        name: verify-time
+        type: u32
+      -
+        name: max-verify-time
+        type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: mm-stat
+  -
+    name: linkinfo
+    attr-cnt-name: __ethtool-a-linkinfo-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: port
+        type: u8
+      -
+        name: phyaddr
+        type: u8
+      -
+        name: tp-mdix
+        type: u8
+      -
+        name: tp-mdix-ctrl
+        type: u8
+      -
+        name: transceiver
+        type: u8
+  -
+    name: linkmodes
+    attr-cnt-name: __ethtool-a-linkmodes-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: autoneg
+        type: u8
+      -
+        name: ours
+        type: nest
+        nested-attributes: bitset
+      -
+        name: peer
+        type: nest
+        nested-attributes: bitset
+      -
+        name: speed
+        type: u32
+      -
+        name: duplex
+        type: u8
+      -
+        name: master-slave-cfg
+        type: u8
+      -
+        name: master-slave-state
+        type: u8
+      -
+        name: lanes
+        type: u32
+      -
+        name: rate-matching
+        type: u8
+  -
+    name: linkstate
+    attr-cnt-name: __ethtool-a-linkstate-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: link
+        type: u8
+      -
+        name: sqi
+        type: u32
+      -
+        name: sqi-max
+        type: u32
+      -
+        name: ext-state
+        type: u8
+      -
+        name: ext-substate
+        type: u8
+      -
+        name: ext-down-cnt
+        type: u32
+  -
+    name: debug
+    attr-cnt-name: __ethtool-a-debug-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: msgmask
+        type: nest
+        nested-attributes: bitset
+  -
+    name: wol
+    attr-cnt-name: __ethtool-a-wol-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: modes
+        type: nest
+        nested-attributes: bitset
+      -
+        name: sopass
+        type: binary
+  -
+    name: features
+    attr-cnt-name: __ethtool-a-features-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: hw
+        type: nest
+        nested-attributes: bitset
+      -
+        name: wanted
+        type: nest
+        nested-attributes: bitset
+      -
+        name: active
+        type: nest
+        nested-attributes: bitset
+      -
+        name: nochange
+        type: nest
+        nested-attributes: bitset
+  -
+    name: channels
+    attr-cnt-name: __ethtool-a-channels-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: rx-max
+        type: u32
+      -
+        name: tx-max
+        type: u32
+      -
+        name: other-max
+        type: u32
+      -
+        name: combined-max
+        type: u32
+      -
+        name: rx-count
+        type: u32
+      -
+        name: tx-count
+        type: u32
+      -
+        name: other-count
+        type: u32
+      -
+        name: combined-count
+        type: u32
+
+  -
+    name: irq-moderation
+    attr-cnt-name: __ethtool-a-irq-moderation-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: usec
+        type: u32
+      -
+        name: pkts
+        type: u32
+      -
+        name: comps
+        type: u32
+  -
+    name: profile
+    attr-cnt-name: __ethtool-a-profile-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: irq-moderation
+        type: nest
+        multi-attr: true
+        nested-attributes: irq-moderation
+  -
+    name: coalesce
+    attr-cnt-name: __ethtool-a-coalesce-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: rx-usecs
+        type: u32
+      -
+        name: rx-max-frames
+        type: u32
+      -
+        name: rx-usecs-irq
+        type: u32
+      -
+        name: rx-max-frames-irq
+        type: u32
+      -
+        name: tx-usecs
+        type: u32
+      -
+        name: tx-max-frames
+        type: u32
+      -
+        name: tx-usecs-irq
+        type: u32
+      -
+        name: tx-max-frames-irq
+        type: u32
+      -
+        name: stats-block-usecs
+        type: u32
+      -
+        name: use-adaptive-rx
+        type: u8
+      -
+        name: use-adaptive-tx
+        type: u8
+      -
+        name: pkt-rate-low
+        type: u32
+      -
+        name: rx-usecs-low
+        type: u32
+      -
+        name: rx-max-frames-low
+        type: u32
+      -
+        name: tx-usecs-low
+        type: u32
+      -
+        name: tx-max-frames-low
+        type: u32
+      -
+        name: pkt-rate-high
+        type: u32
+      -
+        name: rx-usecs-high
+        type: u32
+      -
+        name: rx-max-frames-high
+        type: u32
+      -
+        name: tx-usecs-high
+        type: u32
+      -
+        name: tx-max-frames-high
+        type: u32
+      -
+        name: rate-sample-interval
+        type: u32
+      -
+        name: use-cqe-mode-tx
+        type: u8
+      -
+        name: use-cqe-mode-rx
+        type: u8
+      -
+        name: tx-aggr-max-bytes
+        type: u32
+      -
+        name: tx-aggr-max-frames
+        type: u32
+      -
+        name: tx-aggr-time-usecs
+        type: u32
+      -
+        name: rx-profile
+        type: nest
+        nested-attributes: profile
+      -
+        name: tx-profile
+        type: nest
+        nested-attributes: profile
+
+  -
+    name: pause-stat
+    attr-cnt-name: __ethtool-a-pause-stat-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pad
+        type: pad
+      -
+        name: tx-frames
+        type: u64
+      -
+        name: rx-frames
+        type: u64
+  -
+    name: pause
+    attr-cnt-name: __ethtool-a-pause-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: autoneg
+        type: u8
+      -
+        name: rx
+        type: u8
+      -
+        name: tx
+        type: u8
+      -
+        name: stats
+        type: nest
+        nested-attributes: pause-stat
+      -
+        name: stats-src
+        type: u32
+  -
+    name: eee
+    attr-cnt-name: __ethtool-a-eee-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: modes-ours
+        type: nest
+        nested-attributes: bitset
+      -
+        name: modes-peer
+        type: nest
+        nested-attributes: bitset
+      -
+        name: active
+        type: u8
+      -
+        name: enabled
+        type: u8
+      -
+        name: tx-lpi-enabled
+        type: u8
+      -
+        name: tx-lpi-timer
+        type: u32
+  -
+    name: ts-stat
+    attr-cnt-name: __ethtool-a-ts-stat-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: tx-pkts
+        type: uint
+      -
+        name: tx-lost
+        type: uint
+      -
+        name: tx-err
+        type: uint
+      -
+        name: tx-onestep-pkts-unconfirmed
+        type: uint
+  -
+    name: ts-hwtstamp-provider
+    attr-cnt-name: __ethtool-a-ts-hwtstamp-provider-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: index
+        type: u32
+      -
+        name: qualifier
+        type: u32
+  -
+    name: tsinfo
+    attr-cnt-name: __ethtool-a-tsinfo-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: timestamping
+        type: nest
+        nested-attributes: bitset
+      -
+        name: tx-types
+        type: nest
+        nested-attributes: bitset
+      -
+        name: rx-filters
+        type: nest
+        nested-attributes: bitset
+      -
+        name: phc-index
+        type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: ts-stat
+      -
+        name: hwtstamp-provider
+        type: nest
+        nested-attributes: ts-hwtstamp-provider
+  -
+    name: cable-result
+    attr-cnt-name: __ethtool-a-cable-result-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pair
+        doc: ETHTOOL_A_CABLE_PAIR
+        type: u8
+      -
+        name: code
+        doc: ETHTOOL_A_CABLE_RESULT_CODE
+        type: u8
+      -
+        name: src
+        doc: ETHTOOL_A_CABLE_INF_SRC
+        type: u32
+  -
+    name: cable-fault-length
+    attr-cnt-name: __ethtool-a-cable-fault-length-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pair
+        type: u8
+      -
+        name: cm
+        type: u32
+      -
+        name: src
+        type: u32
+  -
+    name: cable-nest
+    attr-cnt-name: __ethtool-a-cable-nest-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: result
+        type: nest
+        nested-attributes: cable-result
+      -
+        name: fault-length
+        type: nest
+        nested-attributes: cable-fault-length
+  -
+    name: cable-test
+    attr-cnt-name: __ethtool-a-cable-test-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+  -
+    name: cable-test-ntf
+    attr-cnt-name: __ethtool-a-cable-test-ntf-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: status
+        doc: _STARTED/_COMPLETE
+        type: u8
+      -
+        name: nest
+        type: nest
+        nested-attributes: cable-nest
+  -
+    name: cable-test-tdr-cfg
+    attr-cnt-name: __ethtool-a-cable-test-tdr-cfg-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: first
+        type: u32
+      -
+        name: last
+        type: u32
+      -
+        name: step
+        type: u32
+      -
+        name: pair
+        type: u8
+  -
+    name: cable-test-tdr-ntf
+    attr-cnt-name: __ethtool-a-cable-test-tdr-ntf-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: status
+        type: u8
+      -
+        name: nest
+        type: nest
+        nested-attributes: cable-nest
+  -
+    name: cable-test-tdr
+    attr-cnt-name: __ethtool-a-cable-test-tdr-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: cfg
+        type: nest
+        nested-attributes: cable-test-tdr-cfg
+  -
+    name: tunnel-udp-entry
+    attr-cnt-name: __ethtool-a-tunnel-udp-entry-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: type
+        type: u32
+        enum: udp-tunnel-type
+  -
+    name: tunnel-udp-table
+    attr-cnt-name: __ethtool-a-tunnel-udp-table-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: size
+        type: u32
+      -
+        name: types
+        type: nest
+        nested-attributes: bitset
+      -
+        name: entry
+        type: nest
+        multi-attr: true
+        nested-attributes: tunnel-udp-entry
+  -
+    name: tunnel-udp
+    attr-cnt-name: __ethtool-a-tunnel-udp-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: table
+        type: nest
+        nested-attributes: tunnel-udp-table
+  -
+    name: tunnel-info
+    attr-cnt-name: __ethtool-a-tunnel-info-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: udp-ports
+        type: nest
+        nested-attributes: tunnel-udp
+  -
+    name: fec-stat
+    attr-cnt-name: __ethtool-a-fec-stat-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pad
+        type: pad
+      -
+        name: corrected
+        type: binary
+        sub-type: u64
+      -
+        name: uncorr
+        type: binary
+        sub-type: u64
+      -
+        name: corr-bits
+        type: binary
+        sub-type: u64
+  -
+    name: fec
+    attr-cnt-name: __ethtool-a-fec-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: modes
+        type: nest
+        nested-attributes: bitset
+      -
+        name: auto
+        type: u8
+      -
+        name: active
+        type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: fec-stat
+  -
+    name: module-eeprom
+    attr-cnt-name: __ethtool-a-module-eeprom-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: offset
+        type: u32
+      -
+        name: length
+        type: u32
+      -
+        name: page
+        type: u8
+      -
+        name: bank
+        type: u8
+      -
+        name: i2c-address
+        type: u8
+      -
+        name: data
+        type: binary
+  -
+    name: stats-grp
+    attr-cnt-name: __ethtool-a-stats-grp-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pad
+        type: pad
+      -
+        name: id
+        type: u32
+      -
+        name: ss-id
+        type: u32
+      -
+        name: stat
+        type: u64
+        type-value: [ id ]
+      -
+        name: hist-rx
+        type: nest
+        nested-attributes: stats-grp-hist
+      -
+        name: hist-tx
+        type: nest
+        nested-attributes: stats-grp-hist
+      -
+        name: hist-bkt-low
+        type: u32
+      -
+        name: hist-bkt-hi
+        type: u32
+      -
+        name: hist-val
+        type: u64
+  -
+    name: stats-grp-hist
+    subset-of: stats-grp
+    attributes:
+      -
+        name: hist-bkt-low
+      -
+        name: hist-bkt-hi
+      -
+        name: hist-val
+  -
+    name: stats
+    attr-cnt-name: __ethtool-a-stats-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: pad
+        type: pad
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: groups
+        type: nest
+        nested-attributes: bitset
+      -
+        name: grp
+        type: nest
+        nested-attributes: stats-grp
+      -
+        name: src
+        type: u32
+  -
+    name: phc-vclocks
+    attr-cnt-name: __ethtool-a-phc-vclocks-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: num
+        type: u32
+      -
+        name: index
+        type: binary
+        sub-type: s32
+  -
+    name: module
+    attr-cnt-name: __ethtool-a-module-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: power-mode-policy
+        type: u8
+      -
+        name: power-mode
+        type: u8
+  -
+    name: c33-pse-pw-limit
+    attr-cnt-name: __ethtool-a-c33-pse-pw-limit-cnt
+    attr-max-name: __ethtool-a-c33-pse-pw-limit-max
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: min
+        type: u32
+      -
+        name: max
+        type: u32
+  -
+    name: pse
+    attr-cnt-name: __ethtool-a-pse-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: podl-pse-admin-state
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: podl-pse-admin-control
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: podl-pse-pw-d-status
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-state
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-admin-control
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-d-status
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-class
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-actual-pw
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-ext-state
+        type: u32
+        name-prefix: ethtool-a-
+        enum: c33-pse-ext-state
+      -
+        name: c33-pse-ext-substate
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-avail-pw-limit
+        type: u32
+        name-prefix: ethtool-a-
+      -
+        name: c33-pse-pw-limit-ranges
+        name-prefix: ethtool-a-
+        type: nest
+        multi-attr: true
+        nested-attributes: c33-pse-pw-limit
+  -
+    name: rss
+    attr-cnt-name: __ethtool-a-rss-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: context
+        type: u32
+      -
+        name: hfunc
+        type: u32
+      -
+        name: indir
+        type: binary
+        sub-type: u32
+      -
+        name: hkey
+        type: binary
+      -
+        name: input_xfrm
+        type: u32
+      -
+        name: start-context
+        type: u32
+  -
+    name: plca
+    attr-cnt-name: __ethtool-a-plca-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: version
+        type: u16
+      -
+        name: enabled
+        type: u8
+      -
+        name: status
+        type: u8
+      -
+        name: node-cnt
+        type: u32
+      -
+        name: node-id
+        type: u32
+      -
+        name: to-tmr
+        type: u32
+      -
+        name: burst-cnt
+        type: u32
+      -
+        name: burst-tmr
+        type: u32
+  -
+    name: module-fw-flash
+    attr-cnt-name: __ethtool-a-module-fw-flash-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: file-name
+        type: string
+      -
+        name: password
+        type: u32
+      -
+        name: status
+        type: u32
+        enum: module-fw-flash-status
+      -
+        name: status-msg
+        type: string
+      -
+        name: done
+        type: uint
+      -
+        name: total
+        type: uint
+  -
+    name: phy
+    attr-cnt-name: __ethtool-a-phy-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: index
+        type: u32
+      -
+        name: drvname
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: upstream-type
+        type: u32
+        enum: phy-upstream-type
+      -
+        name: upstream-index
+        type: u32
+      -
+        name: upstream-sfp-name
+        type: string
+      -
+        name: downstream-sfp-name
+        type: string
+  -
+    name: tsconfig
+    attr-cnt-name: __ethtool-a-tsconfig-cnt
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: header
+        type: nest
+        nested-attributes: header
+      -
+        name: hwtstamp-provider
+        type: nest
+        nested-attributes: ts-hwtstamp-provider
+      -
+        name: tx-types
+        type: nest
+        nested-attributes: bitset
+      -
+        name: rx-filters
+        type: nest
+        nested-attributes: bitset
+      -
+        name: hwtstamp-flags
+        type: nest
+        nested-attributes: bitset
+
+operations:
+  enum-model: directional
+  name-prefix: ethtool-msg-
+  list:
+    -
+      name: strset-get
+      doc: Get string set from the kernel.
+
+      attribute-set: strset
+
+      do: &strset-get-op
+        request:
+          attributes:
+            - header
+            - stringsets
+            - counts-only
+        reply:
+          attributes:
+            - header
+            - stringsets
+      dump: *strset-get-op
+    -
+      name: linkinfo-get
+      doc: Get link info.
+
+      attribute-set: linkinfo
+
+      do: &linkinfo-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &linkinfo
+            - header
+            - port
+            - phyaddr
+            - tp-mdix
+            - tp-mdix-ctrl
+            - transceiver
+      dump: *linkinfo-get-op
+    -
+      name: linkinfo-set
+      doc: Set link info.
+
+      attribute-set: linkinfo
+
+      do:
+        request:
+          attributes: *linkinfo
+    -
+      name: linkinfo-ntf
+      doc: Notification for change in link info.
+      notify: linkinfo-get
+    -
+      name: linkmodes-get
+      doc: Get link modes.
+
+      attribute-set: linkmodes
+
+      do: &linkmodes-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &linkmodes
+            - header
+            - autoneg
+            - ours
+            - peer
+            - speed
+            - duplex
+            - master-slave-cfg
+            - master-slave-state
+            - lanes
+            - rate-matching
+      dump: *linkmodes-get-op
+    -
+      name: linkmodes-set
+      doc: Set link modes.
+
+      attribute-set: linkmodes
+
+      do:
+        request:
+          attributes: *linkmodes
+    -
+      name: linkmodes-ntf
+      doc: Notification for change in link modes.
+      notify: linkmodes-get
+    -
+      name: linkstate-get
+      doc: Get link state.
+
+      attribute-set: linkstate
+
+      do: &linkstate-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - link
+            - sqi
+            - sqi-max
+            - ext-state
+            - ext-substate
+            - ext-down-cnt
+      dump: *linkstate-get-op
+    -
+      name: debug-get
+      doc: Get debug message mask.
+
+      attribute-set: debug
+
+      do: &debug-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &debug
+            - header
+            - msgmask
+      dump: *debug-get-op
+    -
+      name: debug-set
+      doc: Set debug message mask.
+
+      attribute-set: debug
+
+      do:
+        request:
+          attributes: *debug
+    -
+      name: debug-ntf
+      doc: Notification for change in debug message mask.
+      notify: debug-get
+    -
+      name: wol-get
+      doc: Get WOL params.
+
+      attribute-set: wol
+
+      do: &wol-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &wol
+            - header
+            - modes
+            - sopass
+      dump: *wol-get-op
+    -
+      name: wol-set
+      doc: Set WOL params.
+
+      attribute-set: wol
+
+      do:
+        request:
+          attributes: *wol
+    -
+      name: wol-ntf
+      doc: Notification for change in WOL params.
+      notify: wol-get
+    -
+      name: features-get
+      doc: Get features.
+
+      attribute-set: features
+
+      do: &feature-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &feature
+            - header
+            # User-changeable features.
+            - hw
+            # User-requested features.
+            - wanted
+            # Currently active features.
+            - active
+            # Unchangeable features.
+            - nochange
+      dump: *feature-get-op
+    -
+      name: features-set
+      doc: Set features.
+
+      attribute-set: features
+
+      do: &feature-set-op
+        request:
+          attributes: *feature
+        reply:
+          attributes: *feature
+    -
+      name: features-ntf
+      doc: Notification for change in features.
+      notify: features-get
+    -
+      name: privflags-get
+      doc: Get device private flags.
+
+      attribute-set: privflags
+
+      do: &privflag-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &privflag
+            - header
+            - flags
+      dump: *privflag-get-op
+    -
+      name: privflags-set
+      doc: Set device private flags.
+
+      attribute-set: privflags
+
+      do:
+        request:
+          attributes: *privflag
+    -
+      name: privflags-ntf
+      doc: Notification for change in device private flags.
+      notify: privflags-get
+
+    -
+      name: rings-get
+      doc: Get ring params.
+
+      attribute-set: rings
+
+      do: &ring-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &ring
+            - header
+            - rx-max
+            - rx-mini-max
+            - rx-jumbo-max
+            - tx-max
+            - rx
+            - rx-mini
+            - rx-jumbo
+            - tx
+            - rx-buf-len
+            - tcp-data-split
+            - cqe-size
+            - tx-push
+            - rx-push
+            - tx-push-buf-len
+            - tx-push-buf-len-max
+            - hds-thresh
+            - hds-thresh-max
+      dump: *ring-get-op
+    -
+      name: rings-set
+      doc: Set ring params.
+
+      attribute-set: rings
+
+      do:
+        request:
+          attributes: *ring
+    -
+      name: rings-ntf
+      doc: Notification for change in ring params.
+      notify: rings-get
+    -
+      name: channels-get
+      doc: Get channel params.
+
+      attribute-set: channels
+
+      do: &channel-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &channel
+            - header
+            - rx-max
+            - tx-max
+            - other-max
+            - combined-max
+            - rx-count
+            - tx-count
+            - other-count
+            - combined-count
+      dump: *channel-get-op
+    -
+      name: channels-set
+      doc: Set channel params.
+
+      attribute-set: channels
+
+      do:
+        request:
+          attributes: *channel
+    -
+      name: channels-ntf
+      doc: Notification for change in channel params.
+      notify: channels-get
+    -
+      name: coalesce-get
+      doc: Get coalesce params.
+
+      attribute-set: coalesce
+
+      do: &coalesce-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &coalesce
+            - header
+            - rx-usecs
+            - rx-max-frames
+            - rx-usecs-irq
+            - rx-max-frames-irq
+            - tx-usecs
+            - tx-max-frames
+            - tx-usecs-irq
+            - tx-max-frames-irq
+            - stats-block-usecs
+            - use-adaptive-rx
+            - use-adaptive-tx
+            - pkt-rate-low
+            - rx-usecs-low
+            - rx-max-frames-low
+            - tx-usecs-low
+            - tx-max-frames-low
+            - pkt-rate-high
+            - rx-usecs-high
+            - rx-max-frames-high
+            - tx-usecs-high
+            - tx-max-frames-high
+            - rate-sample-interval
+            - use-cqe-mode-tx
+            - use-cqe-mode-rx
+            - tx-aggr-max-bytes
+            - tx-aggr-max-frames
+            - tx-aggr-time-usecs
+            - rx-profile
+            - tx-profile
+      dump: *coalesce-get-op
+    -
+      name: coalesce-set
+      doc: Set coalesce params.
+
+      attribute-set: coalesce
+
+      do:
+        request:
+          attributes: *coalesce
+    -
+      name: coalesce-ntf
+      doc: Notification for change in coalesce params.
+      notify: coalesce-get
+    -
+      name: pause-get
+      doc: Get pause params.
+
+      attribute-set: pause
+
+      do: &pause-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &pause
+            - header
+            - autoneg
+            - rx
+            - tx
+            - stats
+            - stats-src
+      dump: *pause-get-op
+    -
+      name: pause-set
+      doc: Set pause params.
+
+      attribute-set: pause
+
+      do:
+        request:
+          attributes: *pause
+    -
+      name: pause-ntf
+      doc: Notification for change in pause params.
+      notify: pause-get
+    -
+      name: eee-get
+      doc: Get eee params.
+
+      attribute-set: eee
+
+      do: &eee-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &eee
+            - header
+            - modes-ours
+            - modes-peer
+            - active
+            - enabled
+            - tx-lpi-enabled
+            - tx-lpi-timer
+      dump: *eee-get-op
+    -
+      name: eee-set
+      doc: Set eee params.
+
+      attribute-set: eee
+
+      do:
+        request:
+          attributes: *eee
+    -
+      name: eee-ntf
+      doc: Notification for change in eee params.
+      notify: eee-get
+    -
+      name: tsinfo-get
+      doc: Get tsinfo params.
+
+      attribute-set: tsinfo
+
+      do: &tsinfo-get-op
+        request:
+          attributes:
+            - header
+            - hwtstamp-provider
+        reply:
+          attributes:
+            - header
+            - timestamping
+            - tx-types
+            - rx-filters
+            - phc-index
+            - stats
+            - hwtstamp-provider
+      dump: *tsinfo-get-op
+    -
+      name: cable-test-act
+      doc: Cable test.
+
+      attribute-set: cable-test
+
+      do:
+        request:
+          attributes:
+            - header
+    -
+      name: cable-test-ntf
+      doc: Cable test notification.
+
+      attribute-set: cable-test-ntf
+
+      event:
+        attributes:
+          - header
+          - status
+    -
+      name: cable-test-tdr-act
+      doc: Cable test TDR.
+
+      attribute-set: cable-test-tdr
+
+      do:
+        request:
+          attributes:
+            - header
+    -
+      name: cable-test-tdr-ntf
+      doc: Cable test TDR notification.
+
+      attribute-set: cable-test-tdr-ntf
+
+      event:
+        attributes:
+          - header
+          - status
+          - nest
+    -
+      name: tunnel-info-get
+      doc: Get tsinfo params.
+
+      attribute-set: tunnel-info
+
+      do: &tunnel-info-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - udp-ports
+      dump: *tunnel-info-get-op
+    -
+      name: fec-get
+      doc: Get FEC params.
+
+      attribute-set: fec
+
+      do: &fec-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &fec
+            - header
+            - modes
+            - auto
+            - active
+            - stats
+      dump: *fec-get-op
+    -
+      name: fec-set
+      doc: Set FEC params.
+
+      attribute-set: fec
+
+      do:
+        request:
+          attributes: *fec
+    -
+      name: fec-ntf
+      doc: Notification for change in FEC params.
+      notify: fec-get
+    -
+      name: module-eeprom-get
+      doc: Get module EEPROM params.
+
+      attribute-set: module-eeprom
+
+      do: &module-eeprom-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - offset
+            - length
+            - page
+            - bank
+            - i2c-address
+            - data
+      dump: *module-eeprom-get-op
+    -
+      name: stats-get
+      doc: Get statistics.
+
+      attribute-set: stats
+
+      do: &stats-get-op
+        request:
+          attributes:
+            - header
+            - groups
+        reply:
+          attributes:
+            - header
+            - groups
+            - grp
+            - src
+      dump: *stats-get-op
+    -
+      name: phc-vclocks-get
+      doc: Get PHC VCLOCKs.
+
+      attribute-set: phc-vclocks
+
+      do: &phc-vclocks-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - num
+      dump: *phc-vclocks-get-op
+    -
+      name: module-get
+      doc: Get module params.
+
+      attribute-set: module
+
+      do: &module-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &module
+            - header
+            - power-mode-policy
+            - power-mode
+      dump: *module-get-op
+    -
+      name: module-set
+      doc: Set module params.
+
+      attribute-set: module
+
+      do:
+        request:
+          attributes: *module
+    -
+      name: module-ntf
+      doc: Notification for change in module params.
+      notify: module-get
+    -
+      name: pse-get
+      doc: Get Power Sourcing Equipment params.
+
+      attribute-set: pse
+
+      do: &pse-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - podl-pse-admin-state
+            - podl-pse-admin-control
+            - podl-pse-pw-d-status
+            - c33-pse-admin-state
+            - c33-pse-admin-control
+            - c33-pse-pw-d-status
+            - c33-pse-pw-class
+            - c33-pse-actual-pw
+            - c33-pse-ext-state
+            - c33-pse-ext-substate
+            - c33-pse-avail-pw-limit
+            - c33-pse-pw-limit-ranges
+      dump: *pse-get-op
+    -
+      name: pse-set
+      doc: Set Power Sourcing Equipment params.
+
+      attribute-set: pse
+
+      do:
+        request:
+          attributes:
+            - header
+            - podl-pse-admin-control
+            - c33-pse-admin-control
+            - c33-pse-avail-pw-limit
+    -
+      name: rss-get
+      doc: Get RSS params.
+
+      attribute-set: rss
+
+      do:
+        request:
+          attributes:
+            - header
+            - context
+        reply: &rss-reply
+          attributes:
+            - header
+            - context
+            - hfunc
+            - indir
+            - hkey
+            - input_xfrm
+      dump:
+        request:
+          attributes:
+            - header
+            - start-context
+        reply: *rss-reply
+    -
+      name: plca-get-cfg
+      doc: Get PLCA params.
+
+      attribute-set: plca
+
+      do: &plca-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &plca
+            - header
+            - version
+            - enabled
+            - status
+            - node-cnt
+            - node-id
+            - to-tmr
+            - burst-cnt
+            - burst-tmr
+      dump: *plca-get-op
+    -
+      name: plca-set-cfg
+      doc: Set PLCA params.
+
+      attribute-set: plca
+
+      do:
+        request:
+          attributes: *plca
+    -
+      name: plca-get-status
+      doc: Get PLCA status params.
+
+      attribute-set: plca
+
+      do: &plca-get-status-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: *plca
+      dump: *plca-get-status-op
+    -
+      name: plca-ntf
+      doc: Notification for change in PLCA params.
+      notify: plca-get-cfg
+    -
+      name: mm-get
+      doc: Get MAC Merge configuration and state
+
+      attribute-set: mm
+
+      do: &mm-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - pmac-enabled
+            - tx-enabled
+            - tx-active
+            - tx-min-frag-size
+            - rx-min-frag-size
+            - verify-enabled
+            - verify-time
+            - max-verify-time
+            - stats
+      dump: *mm-get-op
+    -
+      name: mm-set
+      doc: Set MAC Merge configuration
+
+      attribute-set: mm
+
+      do:
+        request:
+          attributes:
+            - header
+            - verify-enabled
+            - verify-time
+            - tx-enabled
+            - pmac-enabled
+            - tx-min-frag-size
+    -
+      name: mm-ntf
+      doc: Notification for change in MAC Merge configuration.
+      notify: mm-get
+    -
+      name: module-fw-flash-act
+      doc: Flash transceiver module firmware.
+
+      attribute-set: module-fw-flash
+
+      do:
+        request:
+          attributes:
+            - header
+            - file-name
+            - password
+    -
+      name: module-fw-flash-ntf
+      doc: Notification for firmware flashing progress and status.
+
+      attribute-set: module-fw-flash
+
+      event:
+        attributes:
+          - header
+          - status
+          - status-msg
+          - done
+          - total
+    -
+      name: phy-get
+      doc: Get PHY devices attached to an interface
+
+      attribute-set: phy
+
+      do: &phy-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes:
+            - header
+            - index
+            - drvname
+            - name
+            - upstream-type
+            - upstream-index
+            - upstream-sfp-name
+            - downstream-sfp-name
+      dump: *phy-get-op
+    -
+      name: phy-ntf
+      doc: Notification for change in PHY devices.
+      notify: phy-get
+    -
+      name: tsconfig-get
+      doc: Get hwtstamp config.
+
+      attribute-set: tsconfig
+
+      do: &tsconfig-get-op
+        request:
+          attributes:
+            - header
+        reply:
+          attributes: &tsconfig
+            - header
+            - hwtstamp-provider
+            - tx-types
+            - rx-filters
+            - hwtstamp-flags
+      dump: *tsconfig-get-op
+    -
+      name: tsconfig-set
+      doc: Set hwtstamp config.
+
+      attribute-set: tsconfig
+
+      do:
+        request:
+          attributes: *tsconfig
+        reply:
+          attributes: *tsconfig
diff --git a/source/specs/fou.yaml b/source/specs/fou.yaml
new file mode 100644
index 000000000000..0af5ab842c04
--- /dev/null
+++ b/source/specs/fou.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: fou
+
+protocol: genetlink-legacy
+
+doc: |
+  Foo-over-UDP.
+
+c-family-name: fou-genl-name
+c-version-name: fou-genl-version
+max-by-define: true
+kernel-policy: global
+
+definitions:
+  -
+    type: enum
+    name: encap_type
+    name-prefix: fou-encap-
+    enum-name:
+    entries: [ unspec, direct, gue ]
+
+attribute-sets:
+  -
+    name: fou
+    name-prefix: fou-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: port
+        type: u16
+        byte-order: big-endian
+      -
+        name: af
+        type: u8
+      -
+        name: ipproto
+        type: u8
+      -
+        name: type
+        type: u8
+      -
+        name: remcsum_nopartial
+        type: flag
+      -
+        name: local_v4
+        type: u32
+      -
+        name: local_v6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: peer_v4
+        type: u32
+      -
+        name: peer_v6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: peer_port
+        type: u16
+        byte-order: big-endian
+      -
+        name: ifindex
+        type: s32
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+
+    -
+      name: add
+      doc: Add port.
+      attribute-set: fou
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: &all_attrs
+          attributes:
+            - port
+            - ipproto
+            - type
+            - remcsum_nopartial
+            - local_v4
+            - peer_v4
+            - local_v6
+            - peer_v6
+            - peer_port
+            - ifindex
+
+    -
+      name: del
+      doc: Delete port.
+      attribute-set: fou
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: &select_attrs
+          attributes:
+            - af
+            - ifindex
+            - port
+            - peer_port
+            - local_v4
+            - peer_v4
+            - local_v6
+            - peer_v6
+
+    -
+      name: get
+      doc: Get tunnel info.
+      attribute-set: fou
+      dont-validate: [ strict, dump ]
+
+      do:
+        request: *select_attrs
+        reply: *all_attrs
+
+      dump:
+        reply: *all_attrs
diff --git a/source/specs/handshake.yaml b/source/specs/handshake.yaml
new file mode 100644
index 000000000000..b934cc513e3d
--- /dev/null
+++ b/source/specs/handshake.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+#
+# Author: Chuck Lever <chuck.lever@oracle.com>
+#
+# Copyright (c) 2023, Oracle and/or its affiliates.
+#
+
+name: handshake
+
+protocol: genetlink
+
+doc: Netlink protocol to request a transport layer security handshake.
+
+definitions:
+  -
+    type: enum
+    name: handler-class
+    value-start: 0
+    entries: [ none, tlshd, max ]
+  -
+    type: enum
+    name: msg-type
+    value-start: 0
+    entries: [ unspec, clienthello, serverhello ]
+  -
+    type: enum
+    name: auth
+    value-start: 0
+    entries: [ unspec, unauth, psk, x509 ]
+
+attribute-sets:
+  -
+    name: x509
+    attributes:
+      -
+        name: cert
+        type: s32
+      -
+        name: privkey
+        type: s32
+  -
+    name: accept
+    attributes:
+      -
+        name: sockfd
+        type: s32
+      -
+        name: handler-class
+        type: u32
+        enum: handler-class
+      -
+        name: message-type
+        type: u32
+        enum: msg-type
+      -
+        name: timeout
+        type: u32
+      -
+        name: auth-mode
+        type: u32
+        enum: auth
+      -
+        name: peer-identity
+        type: u32
+        multi-attr: true
+      -
+        name: certificate
+        type: nest
+        nested-attributes: x509
+        multi-attr: true
+      -
+        name: peername
+        type: string
+  -
+    name: done
+    attributes:
+      -
+        name: status
+        type: u32
+      -
+        name: sockfd
+        type: s32
+      -
+        name: remote-auth
+        type: u32
+        multi-attr: true
+
+operations:
+  list:
+    -
+      name: ready
+      doc: Notify handlers that a new handshake request is waiting
+      notify: accept
+    -
+      name: accept
+      doc: Handler retrieves next queued handshake request
+      attribute-set: accept
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - handler-class
+        reply:
+          attributes:
+            - sockfd
+            - message-type
+            - timeout
+            - auth-mode
+            - peer-identity
+            - certificate
+            - peername
+    -
+      name: done
+      doc: Handler reports handshake completion
+      attribute-set: done
+      do:
+        request:
+          attributes:
+            - status
+            - sockfd
+            - remote-auth
+
+mcast-groups:
+  list:
+    -
+      name: none
+    -
+      name: tlshd
diff --git a/source/specs/index.rst b/source/specs/index.rst
new file mode 100644
index 000000000000..f317340c97aa
--- /dev/null
+++ b/source/specs/index.rst
@@ -0,0 +1,32 @@
+Netlink Family Specs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+.. toctree::
+   :maxdepth: 2
+
+   conntrack.yaml
+   devlink.yaml
+   dpll.yaml
+   ethtool.yaml
+   fou.yaml
+   handshake.yaml
+   lockd.yaml
+   mptcp_pm.yaml
+   netdev.yaml
+   net_shaper.yaml
+   nfsd.yaml
+   nftables.yaml
+   nl80211.yaml
+   nlctrl.yaml
+   ovs_datapath.yaml
+   ovs_flow.yaml
+   ovs_vport.yaml
+   rt_addr.yaml
+   rt_link.yaml
+   rt_neigh.yaml
+   rt_route.yaml
+   rt_rule.yaml
+   tcp_metrics.yaml
+   tc.yaml
+   team.yaml
diff --git a/source/specs/lockd.yaml b/source/specs/lockd.yaml
new file mode 100644
index 000000000000..bbd4da5fe54b
--- /dev/null
+++ b/source/specs/lockd.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: lockd
+protocol: genetlink
+uapi-header: linux/lockd_netlink.h
+
+doc: lockd configuration over generic netlink
+
+attribute-sets:
+  -
+    name: server
+    attributes:
+      -
+        name: gracetime
+        type: u32
+      -
+        name: tcp-port
+        type: u16
+      -
+        name: udp-port
+        type: u16
+
+operations:
+  list:
+    -
+      name: server-set
+      doc: set the lockd server parameters
+      attribute-set: server
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - gracetime
+            - tcp-port
+            - udp-port
+    -
+      name: server-get
+      doc: get the lockd server parameters
+      attribute-set: server
+      do:
+        reply:
+          attributes:
+            - gracetime
+            - tcp-port
+            - udp-port
diff --git a/source/specs/mptcp_pm.yaml b/source/specs/mptcp_pm.yaml
new file mode 100644
index 000000000000..dfd017780d2f
--- /dev/null
+++ b/source/specs/mptcp_pm.yaml
@@ -0,0 +1,394 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: mptcp_pm
+protocol: genetlink-legacy
+doc: Multipath TCP.
+
+c-family-name: mptcp-pm-name
+c-version-name: mptcp-pm-ver
+max-by-define: true
+kernel-policy: per-op
+cmd-cnt-name: --mptcp-pm-cmd-after-last
+
+definitions:
+  -
+    type: enum
+    name: event-type
+    enum-name: mptcp-event-type
+    name-prefix: mptcp-event-
+    entries:
+     -
+      name: unspec
+      doc: unused event
+     -
+      name: created
+      doc: >-
+        A new MPTCP connection has been created. It is the good time to
+        allocate memory and send ADD_ADDR if needed. Depending on the
+        traffic-patterns it can take a long time until the
+        MPTCP_EVENT_ESTABLISHED is sent.
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
+     -
+      name: established
+      doc: >-
+        A MPTCP connection is established (can start new subflows).
+        Attributes: token, family, saddr4 | saddr6, daddr4 | daddr6, sport,
+        dport, server-side.
+     -
+      name: closed
+      doc: >-
+        A MPTCP connection has stopped.
+        Attribute: token.
+     -
+      name: announced
+      value: 6
+      doc: >-
+        A new address has been announced by the peer.
+        Attributes: token, rem_id, family, daddr4 | daddr6 [, dport].
+     -
+      name: removed
+      doc: >-
+        An address has been lost by the peer.
+        Attributes: token, rem_id.
+     -
+      name: sub-established
+      value: 10
+      doc: >-
+        A new subflow has been established. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4=
 |
+        daddr6, sport, dport, backup, if_idx [, error].
+     -
+      name: sub-closed
+      doc: >-
+        A subflow has been closed. An error (copy of sk_err) could be set =
if an
+        error has been detected for this subflow.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4=
 |
+        daddr6, sport, dport, backup, if_idx [, error].
+     -
+      name: sub-priority
+      value: 13
+      doc: >-
+        The priority of a subflow has changed. 'error' should not be set.
+        Attributes: token, family, loc_id, rem_id, saddr4 | saddr6, daddr4=
 |
+        daddr6, sport, dport, backup, if_idx [, error].
+     -
+      name: listener-created
+      value: 15
+      doc: >-
+        A new PM listener is created.
+        Attributes: family, sport, saddr4 | saddr6.
+     -
+      name: listener-closed
+      doc: >-
+        A PM listener is closed.
+        Attributes: family, sport, saddr4 | saddr6.
+
+attribute-sets:
+  -
+    name: address
+    name-prefix: mptcp-pm-addr-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: family
+        type: u16
+      -
+        name: id
+        type: u8
+      -
+        name: addr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: addr6
+        type: binary
+        checks:
+          exact-len: 16
+      -
+        name: port
+        type: u16
+      -
+        name: flags
+        type: u32
+      -
+        name: if-idx
+        type: s32
+  -
+    name: subflow-attribute
+    name-prefix: mptcp-subflow-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token-rem
+        type: u32
+      -
+        name: token-loc
+        type: u32
+      -
+        name: relwrite-seq
+        type: u32
+      -
+        name: map-seq
+        type: u64
+      -
+        name: map-sfseq
+        type: u32
+      -
+        name: ssn-offset
+        type: u32
+      -
+        name: map-datalen
+        type: u16
+      -
+        name: flags
+        type: u32
+      -
+        name: id-rem
+        type: u8
+      -
+        name: id-loc
+        type: u8
+      -
+        name: pad
+        type: pad
+  -
+    name: endpoint
+    name-prefix: mptcp-pm-endpoint-
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+  -
+    name: attr
+    name-prefix: mptcp-pm-attr-
+    attr-cnt-name: --mptcp-attr-after-last
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: addr
+        type: nest
+        nested-attributes: address
+      -
+        name: rcv-add-addrs
+        type: u32
+      -
+        name: subflows
+        type: u32
+      -
+        name: token
+        type: u32
+      -
+        name: loc-id
+        type: u8
+      -
+        name: addr-remote
+        type: nest
+        nested-attributes: address
+  -
+    name: event-attr
+    enum-name: mptcp-event-attr
+    name-prefix: mptcp-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: token
+        type: u32
+      -
+        name: family
+        type: u16
+      -
+        name: loc-id
+        type: u8
+      -
+        name: rem-id
+        type: u8
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: saddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+      -
+        name: daddr6
+        type: binary
+        checks:
+          min-len: 16
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: backup
+        type: u8
+      -
+        name: error
+        type: u8
+      -
+        name: flags
+        type: u16
+      -
+        name: timeout
+        type: u32
+      -
+        name: if_idx
+        type: u32
+      -
+        name: reset-reason
+        type: u32
+      -
+        name: reset-flags
+        type: u32
+      -
+        name: server-side
+        type: u8
+
+operations:
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: add-addr
+      doc: Add endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &add-addr-attrs
+        request:
+          attributes:
+            - addr
+    -
+      name: del-addr
+      doc: Delete endpoint
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add-addr-attrs
+    -
+      name: get-addr
+      doc: Get endpoint information
+      attribute-set: attr
+      dont-validate: [ strict ]
+      do: &get-addr-attrs
+        request:
+          attributes:
+           - addr
+           - token
+        reply:
+          attributes:
+           - addr
+      dump:
+        reply:
+         attributes:
+           - addr
+    -
+      name: flush-addrs
+      doc: Flush addresses
+      attribute-set: endpoint
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *add-addr-attrs
+    -
+      name: set-limits
+      doc: Set protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp-limits
+        request:
+          attributes:
+            - rcv-add-addrs
+            - subflows
+    -
+      name: get-limits
+      doc: Get protocol limits
+      attribute-set: attr
+      dont-validate: [ strict ]
+      do: &mptcp-get-limits
+        request:
+           attributes:
+            - rcv-add-addrs
+            - subflows
+        reply:
+          attributes:
+            - rcv-add-addrs
+            - subflows
+    -
+      name: set-flags
+      doc: Change endpoint flags
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &mptcp-set-flags
+        request:
+          attributes:
+            - addr
+            - token
+            - addr-remote
+    -
+      name: announce
+      doc: Announce new address
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &announce-add
+        request:
+          attributes:
+            - addr
+            - token
+    -
+      name: remove
+      doc: Announce removal
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do:
+        request:
+         attributes:
+           - token
+           - loc-id
+    -
+      name: subflow-create
+      doc: Create subflow
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: &sf-create
+        request:
+          attributes:
+            - addr
+            - token
+            - addr-remote
+    -
+      name: subflow-destroy
+      doc: Destroy subflow
+      attribute-set: attr
+      dont-validate: [ strict ]
+      flags: [ uns-admin-perm ]
+      do: *sf-create
diff --git a/source/specs/net_shaper.yaml b/source/specs/net_shaper.yaml
new file mode 100644
index 000000000000..8ebad0d02904
--- /dev/null
+++ b/source/specs/net_shaper.yaml
@@ -0,0 +1,362 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+name: net-shaper
+
+doc: |
+  Networking HW rate limiting configuration.
+
+  This API allows configuring HW shapers available on the network
+  devices at different levels (queues, network device) and allows
+  arbitrary manipulation of the scheduling tree of the involved
+  shapers.
+
+  Each @shaper is identified within the given device, by a @handle,
+  comprising both a @scope and an @id.
+
+  Depending on the @scope value, the shapers are attached to specific
+  HW objects (queues, devices) or, for @node scope, represent a
+  scheduling group, that can be placed in an arbitrary location of
+  the scheduling tree.
+
+  Shapers can be created with two different operations: the @set
+  operation, to create and update a single "attached" shaper, and
+  the @group operation, to create and update a scheduling
+  group. Only the @group operation can create @node scope shapers.
+
+  Existing shapers can be deleted/reset via the @delete operation.
+
+  The user can query the running configuration via the @get operation.
+
+  Different devices can provide different feature sets, e.g. with no
+  support for complex scheduling hierarchy, or for some shaping
+  parameters. The user can introspect the HW capabilities via the
+  @cap-get operation.
+
+definitions:
+  -
+    type: enum
+    name: scope
+    doc: Defines the shaper @id interpretation.
+    render-max: true
+    entries:
+      - name: unspec
+        doc: The scope is not specified.
+      -
+        name: netdev
+        doc: The main shaper for the given network device.
+      -
+        name: queue
+        doc: |
+            The shaper is attached to the given device queue,
+            the @id represents the queue number.
+      -
+        name: node
+        doc: |
+             The shaper allows grouping of queues or other
+             node shapers; can be nested in either @netdev
+             shapers or other @node shapers, allowing placement
+             in any location of the scheduling tree, except
+             leaves and root.
+  -
+    type: enum
+    name: metric
+    doc: Different metric supported by the shaper.
+    entries:
+      -
+        name: bps
+        doc: Shaper operates on a bits per second basis.
+      -
+        name: pps
+        doc: Shaper operates on a packets per second basis.
+
+attribute-sets:
+  -
+    name: net-shaper
+    attributes:
+      -
+        name: handle
+        type: nest
+        nested-attributes: handle
+        doc: Unique identifier for the given shaper inside the owning devi=
ce.
+      -
+        name: metric
+        type: u32
+        enum: metric
+        doc: Metric used by the given shaper for bw-min, bw-max and burst.
+      -
+        name: bw-min
+        type: uint
+        doc: Guaranteed bandwidth for the given shaper.
+      -
+        name: bw-max
+        type: uint
+        doc: Maximum bandwidth for the given shaper or 0 when unlimited.
+      -
+        name: burst
+        type: uint
+        doc: |
+          Maximum burst-size for shaping. Should not be interpreted
+          as a quantum.
+      -
+        name: priority
+        type: u32
+        doc: |
+          Scheduling priority for the given shaper. The priority
+          scheduling is applied to sibling shapers.
+      -
+        name: weight
+        type: u32
+        doc: |
+          Relative weight for round robin scheduling of the
+          given shaper.
+          The scheduling is applied to all sibling shapers
+          with the same priority.
+      -
+        name: ifindex
+        type: u32
+        doc: Interface index owning the specified shaper.
+      -
+        name: parent
+        type: nest
+        nested-attributes: handle
+        doc: |
+          Identifier for the parent of the affected shaper.
+          Only needed for @group operation.
+      -
+        name: leaves
+        type: nest
+        multi-attr: true
+        nested-attributes: leaf-info
+        doc: |
+           Describes a set of leaves shapers for a @group operation.
+  -
+    name: handle
+    attributes:
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: Defines the shaper @id interpretation.
+      -
+        name: id
+        type: u32
+        doc: |
+          Numeric identifier of a shaper. The id semantic depends on
+          the scope. For @queue scope it's the queue id and for @node
+          scope it's the node identifier.
+  -
+    name: leaf-info
+    subset-of: net-shaper
+    attributes:
+      -
+        name: handle
+      -
+        name: priority
+      -
+        name: weight
+  -
+    name: caps
+    attributes:
+      -
+        name: ifindex
+        type: u32
+        doc: Interface index queried for shapers capabilities.
+      -
+        name: scope
+        type: u32
+        enum: scope
+        doc: The scope to which the queried capabilities apply.
+      -
+        name: support-metric-bps
+        type: flag
+        doc: The device accepts 'bps' metric for bw-min, bw-max and burst.
+      -
+        name: support-metric-pps
+        type: flag
+        doc: The device accepts 'pps' metric for bw-min, bw-max and burst.
+      -
+        name: support-nesting
+        type: flag
+        doc: |
+          The device supports nesting shaper belonging to this scope
+          below 'node' scoped shapers. Only 'queue' and 'node'
+          scope can have flag 'support-nesting'.
+      -
+        name: support-bw-min
+        type: flag
+        doc: The device supports a minimum guaranteed B/W.
+      -
+        name: support-bw-max
+        type: flag
+        doc: The device supports maximum B/W shaping.
+      -
+        name: support-burst
+        type: flag
+        doc: The device supports a maximum burst size.
+      -
+        name: support-priority
+        type: flag
+        doc: The device supports priority scheduling.
+      -
+        name: support-weight
+        type: flag
+        doc: The device supports weighted round robin scheduling.
+
+operations:
+  list:
+    -
+      name: get
+      doc: |
+        Get information about a shaper for a given device.
+      attribute-set: net-shaper
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes: &ns-binding
+            - ifindex
+            - handle
+        reply:
+          attributes: &ns-attrs
+            - ifindex
+            - parent
+            - handle
+            - metric
+            - bw-min
+            - bw-max
+            - burst
+            - priority
+            - weight
+
+      dump:
+        pre: net-shaper-nl-pre-dumpit
+        post: net-shaper-nl-post-dumpit
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *ns-attrs
+    -
+      name: set
+      doc: |
+        Create or update the specified shaper.
+        The set operation can't be used to create a @node scope shaper,
+        use the @group operation instead.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - handle
+            - metric
+            - bw-min
+            - bw-max
+            - burst
+            - priority
+            - weight
+
+    -
+      name: delete
+      doc: |
+        Clear (remove) the specified shaper. When deleting
+        a @node shaper, reattach all the node's leaves to the
+        deleted node's parent.
+        If, after the removal, the parent shaper has no more
+        leaves and the parent shaper scope is @node, the parent
+        node is deleted, recursively.
+        When deleting a @queue shaper or a @netdev shaper,
+        the shaper disappears from the hierarchy, but the
+        queue/device can still send traffic: it has an implicit
+        node with infinite bandwidth. The queue's implicit node
+        feeds an implicit RR node at the root of the hierarchy.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes: *ns-binding
+
+    -
+      name: group
+      doc: |
+        Create or update a scheduling group, attaching the specified
+        @leaves shapers under the specified node identified by @handle.
+        The @leaves shapers scope must be @queue and the node shaper
+        scope must be either @node or @netdev.
+        When the node shaper has @node scope, if the @handle @id is not
+        specified, a new shaper of such scope is created, otherwise the
+        specified node must already exist.
+        When updating an existing node shaper, the specified @leaves are
+        added to the existing node; such node will also retain any preexis=
ting
+        leave.
+        The @parent handle for a new node shaper defaults to the parent
+        of all the leaves, provided all the leaves share the same parent.
+        Otherwise @parent handle must be specified.
+        The user can optionally provide shaping attributes for the node
+        shaper.
+        The operation is atomic, on failure no change is applied to
+        the device shaping configuration, otherwise the @node shaper
+        full identifier, comprising @binding and @handle, is provided
+        as the reply.
+      attribute-set: net-shaper
+      flags: [ admin-perm ]
+
+      do:
+        pre: net-shaper-nl-pre-doit
+        post: net-shaper-nl-post-doit
+        request:
+          attributes:
+            - ifindex
+            - parent
+            - handle
+            - metric
+            - bw-min
+            - bw-max
+            - burst
+            - priority
+            - weight
+            - leaves
+        reply:
+          attributes: *ns-binding
+
+    -
+      name: cap-get
+      doc: |
+        Get the shaper capabilities supported by the given device
+        for the specified scope.
+      attribute-set: caps
+
+      do:
+        pre: net-shaper-nl-cap-pre-doit
+        post: net-shaper-nl-cap-post-doit
+        request:
+          attributes:
+            - ifindex
+            - scope
+        reply:
+          attributes: &cap-attrs
+            - ifindex
+            - scope
+            - support-metric-bps
+            - support-metric-pps
+            - support-nesting
+            - support-bw-min
+            - support-bw-max
+            - support-burst
+            - support-priority
+            - support-weight
+
+      dump:
+        pre: net-shaper-nl-cap-pre-dumpit
+        post: net-shaper-nl-cap-post-dumpit
+        request:
+          attributes:
+            - ifindex
+        reply:
+          attributes: *cap-attrs
diff --git a/source/specs/netdev.yaml b/source/specs/netdev.yaml
new file mode 100644
index 000000000000..f5e0750ab71d
--- /dev/null
+++ b/source/specs/netdev.yaml
@@ -0,0 +1,756 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: netdev
+
+doc:
+  netdev configuration over generic netlink.
+
+definitions:
+  -
+    type: flags
+    name: xdp-act
+    render-max: true
+    entries:
+      -
+        name: basic
+        doc:
+          XDP features set supported by all drivers
+          (XDP_ABORTED, XDP_DROP, XDP_PASS, XDP_TX)
+      -
+        name: redirect
+        doc:
+          The netdev supports XDP_REDIRECT
+      -
+        name: ndo-xmit
+        doc:
+          This feature informs if netdev implements ndo_xdp_xmit callback.
+      -
+        name: xsk-zerocopy
+        doc:
+          This feature informs if netdev supports AF_XDP in zero copy mode.
+      -
+        name: hw-offload
+        doc:
+         This feature informs if netdev supports XDP hw offloading.
+      -
+        name: rx-sg
+        doc:
+          This feature informs if netdev implements non-linear XDP buffer
+          support in the driver napi callback.
+      -
+        name: ndo-xmit-sg
+        doc:
+          This feature informs if netdev implements non-linear XDP buffer
+          support in ndo_xdp_xmit callback.
+  -
+    type: flags
+    name: xdp-rx-metadata
+    entries:
+      -
+        name: timestamp
+        doc:
+          Device is capable of exposing receive HW timestamp via bpf_xdp_m=
etadata_rx_timestamp().
+      -
+        name: hash
+        doc:
+          Device is capable of exposing receive packet hash via bpf_xdp_me=
tadata_rx_hash().
+      -
+        name: vlan-tag
+        doc:
+          Device is capable of exposing receive packet VLAN tag via bpf_xd=
p_metadata_rx_vlan_tag().
+  -
+    type: flags
+    name: xsk-flags
+    entries:
+      -
+        name: tx-timestamp
+        doc:
+          HW timestamping egress packets is supported by the driver.
+      -
+        name: tx-checksum
+        doc:
+          L3 checksum HW offload is supported by the driver.
+      -
+        name: tx-launch-time-fifo
+        doc:
+          Launch time HW offload is supported by the driver.
+  -
+    name: queue-type
+    type: enum
+    entries: [ rx, tx ]
+  -
+    name: qstats-scope
+    type: flags
+    entries: [ queue ]
+
+attribute-sets:
+  -
+    name: dev
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex
+        type: u32
+        checks:
+          min: 1
+      -
+        name: pad
+        type: pad
+      -
+        name: xdp-features
+        doc: Bitmask of enabled xdp-features.
+        type: u64
+        enum: xdp-act
+      -
+        name: xdp-zc-max-segs
+        doc: max fragment count supported by ZC driver
+        type: u32
+        checks:
+          min: 1
+      -
+        name: xdp-rx-metadata-features
+        doc: Bitmask of supported XDP receive metadata features.
+             See Documentation/networking/xdp-rx-metadata.rst for more det=
ails.
+        type: u64
+        enum: xdp-rx-metadata
+      -
+        name: xsk-features
+        doc: Bitmask of enabled AF_XDP features.
+        type: u64
+        enum: xsk-flags
+  -
+    name: io-uring-provider-info
+    attributes: []
+  -
+    name: page-pool
+    attributes:
+      -
+        name: id
+        doc: Unique ID of a Page Pool instance.
+        type: uint
+        checks:
+          min: 1
+          max: u32-max
+      -
+        name: ifindex
+        doc: |
+          ifindex of the netdev to which the pool belongs.
+          May be reported as 0 if the page pool was allocated for a netdev
+          which got destroyed already (page pools may outlast their netdevs
+          because they wait for all memory to be returned).
+        type: u32
+        checks:
+          min: 1
+          max: s32-max
+      -
+        name: napi-id
+        doc: Id of NAPI using this Page Pool instance.
+        type: uint
+        checks:
+          min: 1
+          max: u32-max
+      -
+        name: inflight
+        type: uint
+        doc: |
+          Number of outstanding references to this page pool (allocated
+          but yet to be freed pages). Allocated pages may be held in
+          socket receive queues, driver receive ring, page pool recycling
+          ring, the page pool cache, etc.
+      -
+        name: inflight-mem
+        type: uint
+        doc: |
+          Amount of memory held by inflight pages.
+      -
+        name: detach-time
+        type: uint
+        doc: |
+          Seconds in CLOCK_BOOTTIME of when Page Pool was detached by
+          the driver. Once detached Page Pool can no longer be used to
+          allocate memory.
+          Page Pools wait for all the memory allocated from them to be fre=
ed
+          before truly disappearing. "Detached" Page Pools cannot be
+          "re-attached", they are just waiting to disappear.
+          Attribute is absent if Page Pool has not been detached, and
+          can still be used to allocate new memory.
+      -
+        name: dmabuf
+        doc: ID of the dmabuf this page-pool is attached to.
+        type: u32
+      -
+        name: io-uring
+        doc: io-uring memory provider information.
+        type: nest
+        nested-attributes: io-uring-provider-info
+  -
+    name: page-pool-info
+    subset-of: page-pool
+    attributes:
+      -
+        name: id
+      -
+        name: ifindex
+  -
+    name: page-pool-stats
+    doc: |
+      Page pool statistics, see docs for struct page_pool_stats
+      for information about individual statistics.
+    attributes:
+      -
+        name: info
+        doc: Page pool identifying information.
+        type: nest
+        nested-attributes: page-pool-info
+      -
+        name: alloc-fast
+        type: uint
+        value: 8 # reserve some attr ids in case we need more metadata lat=
er
+      -
+        name: alloc-slow
+        type: uint
+      -
+        name: alloc-slow-high-order
+        type: uint
+      -
+        name: alloc-empty
+        type: uint
+      -
+        name: alloc-refill
+        type: uint
+      -
+        name: alloc-waive
+        type: uint
+      -
+        name: recycle-cached
+        type: uint
+      -
+        name: recycle-cache-full
+        type: uint
+      -
+        name: recycle-ring
+        type: uint
+      -
+        name: recycle-ring-full
+        type: uint
+      -
+        name: recycle-released-refcnt
+        type: uint
+
+  -
+    name: napi
+    attributes:
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which NAPI instance belongs.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: id
+        doc: ID of the NAPI instance.
+        type: u32
+      -
+        name: irq
+        doc: The associated interrupt vector number for the napi
+        type: u32
+      -
+        name: pid
+        doc: PID of the napi thread, if NAPI is configured to operate in
+             threaded mode. If NAPI is not in threaded mode (i.e. uses nor=
mal
+             softirq context), the attribute will be absent.
+        type: u32
+      -
+        name: defer-hard-irqs
+        doc: The number of consecutive empty polls before IRQ deferral ends
+             and hardware IRQs are re-enabled.
+        type: u32
+        checks:
+          max: s32-max
+      -
+        name: gro-flush-timeout
+        doc: The timeout, in nanoseconds, of when to trigger the NAPI watc=
hdog
+             timer which schedules NAPI processing. Additionally, a non-ze=
ro
+             value will also prevent GRO from flushing recent super-frames=
 at
+             the end of a NAPI cycle. This may add receive latency in exch=
ange
+             for reducing the number of frames processed by the network st=
ack.
+        type: uint
+      -
+        name: irq-suspend-timeout
+        doc: The timeout, in nanoseconds, of how long to suspend irq
+             processing, if event polling finds events
+        type: uint
+  -
+    name: xsk-info
+    attributes: []
+  -
+    name: queue
+    attributes:
+      -
+        name: id
+        doc: Queue index; most queue types are indexed like a C array, with
+             indexes starting at 0 and ending at queue count - 1. Queue in=
dexes
+             are scoped to an interface and queue type.
+        type: u32
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which the queue belongs.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: type
+        doc: Queue type as rx, tx. Each queue type defines a separate ID s=
pace.
+             XDP TX queues allocated in the kernel are not linked to NAPIs=
 and
+             thus not listed. AF_XDP queues will have more information set=
 in
+             the xsk attribute.
+        type: u32
+        enum: queue-type
+      -
+        name: napi-id
+        doc: ID of the NAPI instance which services this queue.
+        type: u32
+      -
+        name: dmabuf
+        doc: ID of the dmabuf attached to this queue, if any.
+        type: u32
+      -
+        name: io-uring
+        doc: io_uring memory provider information.
+        type: nest
+        nested-attributes: io-uring-provider-info
+      -
+        name: xsk
+        doc: XSK information for this queue, if any.
+        type: nest
+        nested-attributes: xsk-info
+  -
+    name: qstats
+    doc: |
+      Get device statistics, scoped to a device or a queue.
+      These statistics extend (and partially duplicate) statistics availab=
le
+      in struct rtnl_link_stats64.
+      Value of the `scope` attribute determines how statistics are
+      aggregated. When aggregated for the entire device the statistics
+      represent the total number of events since last explicit reset of
+      the device (i.e. not a reconfiguration like changing queue count).
+      When reported per-queue, however, the statistics may not add
+      up to the total number of events, will only be reported for currently
+      active objects, and will likely report the number of events since la=
st
+      reconfiguration.
+    attributes:
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which stats belong.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queue-type
+        doc: Queue type as rx, tx, for queue-id.
+        type: u32
+        enum: queue-type
+      -
+        name: queue-id
+        doc: Queue ID, if stats are scoped to a single queue instance.
+        type: u32
+      -
+        name: scope
+        doc: |
+          What object type should be used to iterate over the stats.
+        type: uint
+        enum: qstats-scope
+      -
+        name: rx-packets
+        doc: |
+          Number of wire packets successfully received and passed to the s=
tack.
+          For drivers supporting XDP, XDP is considered the first layer
+          of the stack, so packets consumed by XDP are still counted here.
+        type: uint
+        value: 8 # reserve some attr ids in case we need more metadata lat=
er
+      -
+        name: rx-bytes
+        doc: Successfully received bytes, see `rx-packets`.
+        type: uint
+      -
+        name: tx-packets
+        doc: |
+          Number of wire packets successfully sent. Packet is considered t=
o be
+          successfully sent once it is in device memory (usually this means
+          the device has issued a DMA completion for the packet).
+        type: uint
+      -
+        name: tx-bytes
+        doc: Successfully sent bytes, see `tx-packets`.
+        type: uint
+      -
+        name: rx-alloc-fail
+        doc: |
+          Number of times skb or buffer allocation failed on the Rx datapa=
th.
+          Allocation failure may, or may not result in a packet drop, depe=
nding
+          on driver implementation and whether system recovers quickly.
+        type: uint
+      -
+        name: rx-hw-drops
+        doc: |
+          Number of all packets which entered the device, but never left i=
t,
+          including but not limited to: packets dropped due to lack of buf=
fer
+          space, processing errors, explicit or implicit policies and pack=
et
+          filters.
+        type: uint
+      -
+        name: rx-hw-drop-overruns
+        doc: |
+          Number of packets dropped due to transient lack of resources, su=
ch as
+          buffer space, host descriptors etc.
+        type: uint
+      -
+        name: rx-csum-complete
+        doc: Number of packets that were marked as CHECKSUM_COMPLETE.
+        type: uint
+      -
+        name: rx-csum-unnecessary
+        doc: Number of packets that were marked as CHECKSUM_UNNECESSARY.
+        type: uint
+      -
+        name: rx-csum-none
+        doc: Number of packets that were not checksummed by device.
+        type: uint
+      -
+        name: rx-csum-bad
+        doc: |
+          Number of packets with bad checksum. The packets are not discard=
ed,
+          but still delivered to the stack.
+        type: uint
+      -
+        name: rx-hw-gro-packets
+        doc: |
+          Number of packets that were coalesced from smaller packets by th=
e device.
+          Counts only packets coalesced with the HW-GRO netdevice feature,
+          LRO-coalesced packets are not counted.
+        type: uint
+      -
+        name: rx-hw-gro-bytes
+        doc: See `rx-hw-gro-packets`.
+        type: uint
+      -
+        name: rx-hw-gro-wire-packets
+        doc: |
+          Number of packets that were coalesced to bigger packetss with th=
e HW-GRO
+          netdevice feature. LRO-coalesced packets are not counted.
+        type: uint
+      -
+        name: rx-hw-gro-wire-bytes
+        doc: See `rx-hw-gro-wire-packets`.
+        type: uint
+      -
+        name: rx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the received
+          packets bitrate exceeding the device rate limit.
+        type: uint
+      -
+        name: tx-hw-drops
+        doc: |
+          Number of packets that arrived at the device but never left it,
+          encompassing packets dropped for reasons such as processing erro=
rs, as
+          well as those affected by explicitly defined policies and packet
+          filtering criteria.
+        type: uint
+      -
+        name: tx-hw-drop-errors
+        doc: Number of packets dropped because they were invalid or malfor=
med.
+        type: uint
+      -
+        name: tx-csum-none
+        doc: |
+          Number of packets that did not require the device to calculate t=
he
+          checksum.
+        type: uint
+      -
+        name: tx-needs-csum
+        doc: |
+          Number of packets that required the device to calculate the chec=
ksum.
+          This counter includes the number of GSO wire packets for which d=
evice
+          calculated the L4 checksum.
+        type: uint
+      -
+        name: tx-hw-gso-packets
+        doc: |
+          Number of packets that necessitated segmentation into smaller pa=
ckets
+          by the device.
+        type: uint
+      -
+        name: tx-hw-gso-bytes
+        doc: See `tx-hw-gso-packets`.
+        type: uint
+      -
+        name: tx-hw-gso-wire-packets
+        doc: |
+          Number of wire-sized packets generated by processing
+          `tx-hw-gso-packets`
+        type: uint
+      -
+        name: tx-hw-gso-wire-bytes
+        doc: See `tx-hw-gso-wire-packets`.
+        type: uint
+      -
+        name: tx-hw-drop-ratelimits
+        doc: |
+          Number of the packets dropped by the device due to the transmit
+          packets bitrate exceeding the device rate limit.
+        type: uint
+      -
+        name: tx-stop
+        doc: |
+          Number of times driver paused accepting new tx packets
+          from the stack to this queue, because the queue was full.
+          Note that if BQL is supported and enabled on the device
+          the networking stack will avoid queuing a lot of data at once.
+        type: uint
+      -
+        name: tx-wake
+        doc: |
+          Number of times driver re-started accepting send
+          requests to this queue from the stack.
+        type: uint
+  -
+    name: queue-id
+    subset-of: queue
+    attributes:
+      -
+        name: id
+      -
+        name: type
+  -
+    name: dmabuf
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to bind the dmabuf to.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queues
+        doc: receive queues to bind the dmabuf to.
+        type: nest
+        nested-attributes: queue-id
+        multi-attr: true
+      -
+        name: fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
+      -
+        name: id
+        doc: id of the dmabuf binding
+        type: u32
+        checks:
+          min: 1
+
+operations:
+  list:
+    -
+      name: dev-get
+      doc: Get / dump information about a netdev.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply: &dev-all
+          attributes:
+            - ifindex
+            - xdp-features
+            - xdp-zc-max-segs
+            - xdp-rx-metadata-features
+            - xsk-features
+      dump:
+        reply: *dev-all
+    -
+      name: dev-add-ntf
+      doc: Notification about device appearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-del-ntf
+      doc: Notification about device disappearing.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: dev-change-ntf
+      doc: Notification about device configuration being changed.
+      notify: dev-get
+      mcgrp: mgmt
+    -
+      name: page-pool-get
+      doc: |
+        Get / dump information about Page Pools.
+        (Only Page Pools associated with a net_device can be listed.)
+      attribute-set: page-pool
+      do:
+        request:
+          attributes:
+            - id
+        reply: &pp-reply
+          attributes:
+            - id
+            - ifindex
+            - napi-id
+            - inflight
+            - inflight-mem
+            - detach-time
+            - dmabuf
+            - io-uring
+      dump:
+        reply: *pp-reply
+      config-cond: page-pool
+    -
+      name: page-pool-add-ntf
+      doc: Notification about page pool appearing.
+      notify: page-pool-get
+      mcgrp: page-pool
+      config-cond: page-pool
+    -
+      name: page-pool-del-ntf
+      doc: Notification about page pool disappearing.
+      notify: page-pool-get
+      mcgrp: page-pool
+      config-cond: page-pool
+    -
+      name: page-pool-change-ntf
+      doc: Notification about page pool configuration being changed.
+      notify: page-pool-get
+      mcgrp: page-pool
+      config-cond: page-pool
+    -
+      name: page-pool-stats-get
+      doc: Get page pool statistics.
+      attribute-set: page-pool-stats
+      do:
+        request:
+          attributes:
+            - info
+        reply: &pp-stats-reply
+          attributes:
+            - info
+            - alloc-fast
+            - alloc-slow
+            - alloc-slow-high-order
+            - alloc-empty
+            - alloc-refill
+            - alloc-waive
+            - recycle-cached
+            - recycle-cache-full
+            - recycle-ring
+            - recycle-ring-full
+            - recycle-released-refcnt
+      dump:
+        reply: *pp-stats-reply
+      config-cond: page-pool-stats
+    -
+      name: queue-get
+      doc: Get queue information from the kernel.
+           Only configured queues will be reported (as opposed to all avai=
lable
+           hardware queues).
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - id
+        reply: &queue-get-op
+          attributes:
+            - id
+            - type
+            - napi-id
+            - ifindex
+            - dmabuf
+            - io-uring
+            - xsk
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *queue-get-op
+    -
+      name: napi-get
+      doc: Get information about NAPI instances configured on the system.
+      attribute-set: napi
+      do:
+        request:
+          attributes:
+            - id
+        reply: &napi-get-op
+          attributes:
+            - id
+            - ifindex
+            - irq
+            - pid
+            - defer-hard-irqs
+            - gro-flush-timeout
+            - irq-suspend-timeout
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *napi-get-op
+    -
+      name: qstats-get
+      doc: |
+        Get / dump fine grained statistics. Which statistics are reported
+        depends on the device and the driver, and whether the driver stores
+        software counters per-queue.
+      attribute-set: qstats
+      dump:
+        request:
+          attributes:
+            - ifindex
+            - scope
+        reply:
+          attributes:
+            - ifindex
+            - queue-type
+            - queue-id
+            - rx-packets
+            - rx-bytes
+            - tx-packets
+            - tx-bytes
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: dmabuf
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - fd
+            - queues
+        reply:
+          attributes:
+            - id
+    -
+      name: napi-set
+      doc: Set configurable NAPI instance settings.
+      attribute-set: napi
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - id
+            - defer-hard-irqs
+            - gro-flush-timeout
+            - irq-suspend-timeout
+
+kernel-family:
+  headers: [ "net/netdev_netlink.h"]
+  sock-priv: struct netdev_nl_sock
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
+    -
+      name: page-pool
diff --git a/source/specs/nfsd.yaml b/source/specs/nfsd.yaml
new file mode 100644
index 000000000000..c87658114852
--- /dev/null
+++ b/source/specs/nfsd.yaml
@@ -0,0 +1,224 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: nfsd
+protocol: genetlink
+uapi-header: linux/nfsd_netlink.h
+
+doc: NFSD configuration over generic netlink.
+
+attribute-sets:
+  -
+    name: rpc-status
+    attributes:
+      -
+        name: xid
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: prog
+        type: u32
+      -
+        name: version
+        type: u8
+      -
+        name: proc
+        type: u32
+      -
+        name: service_time
+        type: s64
+      -
+        name: pad
+        type: pad
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: daddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: compound-ops
+        type: u32
+        multi-attr: true
+  -
+    name: server
+    attributes:
+      -
+        name: threads
+        type: u32
+        multi-attr: true
+      -
+        name: gracetime
+        type: u32
+      -
+        name: leasetime
+        type: u32
+      -
+        name: scope
+        type: string
+  -
+    name: version
+    attributes:
+      -
+        name: major
+        type: u32
+      -
+        name: minor
+        type: u32
+      -
+        name: enabled
+        type: flag
+  -
+    name: server-proto
+    attributes:
+      -
+        name: version
+        type: nest
+        nested-attributes: version
+        multi-attr: true
+  -
+    name: sock
+    attributes:
+      -
+        name: addr
+        type: binary
+      -
+        name: transport-name
+        type: string
+  -
+    name: server-sock
+    attributes:
+      -
+        name: addr
+        type: nest
+        nested-attributes: sock
+        multi-attr: true
+  -
+    name: pool-mode
+    attributes:
+      -
+        name: mode
+        type: string
+      -
+        name: npools
+        type: u32
+
+operations:
+  list:
+    -
+      name: rpc-status-get
+      doc: dump pending nfsd rpc
+      attribute-set: rpc-status
+      dump:
+        reply:
+          attributes:
+            - xid
+            - flags
+            - prog
+            - version
+            - proc
+            - service_time
+            - saddr4
+            - daddr4
+            - saddr6
+            - daddr6
+            - sport
+            - dport
+            - compound-ops
+    -
+      name: threads-set
+      doc: set the number of running threads
+      attribute-set: server
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - threads
+            - gracetime
+            - leasetime
+            - scope
+    -
+      name: threads-get
+      doc: get the number of running threads
+      attribute-set: server
+      do:
+        reply:
+          attributes:
+            - threads
+            - gracetime
+            - leasetime
+            - scope
+    -
+      name: version-set
+      doc: set nfs enabled versions
+      attribute-set: server-proto
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - version
+    -
+      name: version-get
+      doc: get nfs enabled versions
+      attribute-set: server-proto
+      do:
+        reply:
+          attributes:
+            - version
+    -
+      name: listener-set
+      doc: set nfs running sockets
+      attribute-set: server-sock
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - addr
+    -
+      name: listener-get
+      doc: get nfs running listeners
+      attribute-set: server-sock
+      do:
+        reply:
+          attributes:
+            - addr
+    -
+      name: pool-mode-set
+      doc: set the current server pool-mode
+      attribute-set: pool-mode
+      flags: [ admin-perm ]
+      do:
+        request:
+          attributes:
+            - mode
+    -
+      name: pool-mode-get
+      doc: get info about server pool-mode
+      attribute-set: pool-mode
+      do:
+        reply:
+          attributes:
+            - mode
+            - npools
diff --git a/source/specs/nftables.yaml b/source/specs/nftables.yaml
new file mode 100644
index 000000000000..bd938bd01b6b
--- /dev/null
+++ b/source/specs/nftables.yaml
@@ -0,0 +1,1526 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: nftables
+protocol: netlink-raw
+protonum: 12
+
+doc:
+  Netfilter nftables configuration over netlink.
+
+definitions:
+  -
+    name: nfgenmsg
+    type: struct
+    members:
+      -
+        name: nfgen-family
+        type: u8
+      -
+        name: version
+        type: u8
+      -
+        name: res-id
+        byte-order: big-endian
+        type: u16
+  -
+    name: meta-keys
+    type: enum
+    entries:
+      - len
+      - protocol
+      - priority
+      - mark
+      - iif
+      - oif
+      - iifname
+      - oifname
+      - iftype
+      - oiftype
+      - skuid
+      - skgid
+      - nftrace
+      - rtclassid
+      - secmark
+      - nfproto
+      - l4-proto
+      - bri-iifname
+      - bri-oifname
+      - pkttype
+      - cpu
+      - iifgroup
+      - oifgroup
+      - cgroup
+      - prandom
+      - secpath
+      - iifkind
+      - oifkind
+      - bri-iifpvid
+      - bri-iifvproto
+      - time-ns
+      - time-day
+      - time-hour
+      - sdif
+      - sdifname
+      - bri-broute
+  -
+    name: bitwise-ops
+    type: enum
+    entries:
+      - bool
+      - lshift
+      - rshift
+  -
+    name: cmp-ops
+    type: enum
+    entries:
+      - eq
+      - neq
+      - lt
+      - lte
+      - gt
+      - gte
+  -
+    name: object-type
+    type: enum
+    entries:
+      - unspec
+      - counter
+      - quota
+      - ct-helper
+      - limit
+      - connlimit
+      - tunnel
+      - ct-timeout
+      - secmark
+      - ct-expect
+      - synproxy
+  -
+    name: nat-range-flags
+    type: flags
+    entries:
+      - map-ips
+      - proto-specified
+      - proto-random
+      - persistent
+      - proto-random-fully
+      - proto-offset
+      - netmap
+  -
+    name: table-flags
+    type: flags
+    entries:
+      - dormant
+      - owner
+      - persist
+  -
+    name: chain-flags
+    type: flags
+    entries:
+      - base
+      - hw-offload
+      - binding
+  -
+    name: set-flags
+    type: flags
+    entries:
+      - anonymous
+      - constant
+      - interval
+      - map
+      - timeout
+      - eval
+      - object
+      - concat
+      - expr
+  -
+    name: lookup-flags
+    type: flags
+    entries:
+      - invert
+  -
+    name: ct-keys
+    type: enum
+    entries:
+      - state
+      - direction
+      - status
+      - mark
+      - secmark
+      - expiration
+      - helper
+      - l3protocol
+      - src
+      - dst
+      - protocol
+      - proto-src
+      - proto-dst
+      - labels
+      - pkts
+      - bytes
+      - avgpkt
+      - zone
+      - eventmask
+      - src-ip
+      - dst-ip
+      - src-ip6
+      - dst-ip6
+      - ct-id
+  -
+    name: ct-direction
+    type: enum
+    entries:
+      - original
+      - reply
+  -
+    name: quota-flags
+    type: flags
+    entries:
+      - invert
+      - depleted
+  -
+    name: verdict-code
+    type: enum
+    entries:
+      - name: continue
+        value: 0xffffffff
+      - name: break
+        value: 0xfffffffe
+      - name: jump
+        value: 0xfffffffd
+      - name: goto
+        value: 0xfffffffc
+      - name: return
+        value: 0xfffffffb
+      - name: drop
+        value: 0
+      - name: accept
+        value: 1
+      - name: stolen
+        value: 2
+      - name: queue
+        value: 3
+      - name: repeat
+        value: 4
+  -
+    name: fib-result
+    type: enum
+    entries:
+      - oif
+      - oifname
+      - addrtype
+  -
+    name: fib-flags
+    type: flags
+    entries:
+      - saddr
+      - daddr
+      - mark
+      - iif
+      - oif
+      - present
+  -
+    name: reject-types
+    type: enum
+    entries:
+      - icmp-unreach
+      - tcp-rst
+      - icmpx-unreach
+
+attribute-sets:
+  -
+    name: empty-attrs
+    attributes:
+      -
+        name: name
+        type: string
+  -
+    name: batch-attrs
+    attributes:
+      -
+        name: genid
+        type: u32
+        byte-order: big-endian
+  -
+    name: table-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: name of the table
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        doc: bitmask of flags
+        enum: table-flags
+        enum-as-flags: true
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of chains in this table
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the table
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: chain-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the chain
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the chain
+      -
+        name: name
+        type: string
+        doc: name of the chain
+      -
+        name: hook
+        type: nest
+        nested-attributes: nft-hook-attrs
+        doc: hook specification for basechains
+      -
+        name: policy
+        type: u32
+        byte-order: big-endian
+        doc: numeric policy of the chain
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of references to this chain
+      -
+        name: type
+        type: string
+        doc: type name of the chain
+      -
+        name: counters
+        type: nest
+        nested-attributes: nft-counter-attrs
+        doc: counter specification of the chain
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        doc: chain flags
+        enum: chain-flags
+        enum-as-flags: true
+      -
+        name: id
+        type: u32
+        byte-order: big-endian
+        doc: uniquely identifies a chain in a transaction
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        byte-order: big-endian
+      -
+        name: packets
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+  -
+    name: nft-hook-attrs
+    attributes:
+      -
+        name: num
+        type: u32
+        byte-order: big-endian
+      -
+        name: priority
+        type: s32
+        byte-order: big-endian
+      -
+        name: dev
+        type: string
+        doc: net device name
+      -
+        name: devs
+        type: nest
+        nested-attributes: hook-dev-attrs
+        doc: list of net devices
+  -
+    name: hook-dev-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        multi-attr: true
+  -
+    name: nft-counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+      -
+        name: packets
+        type: u64
+  -
+    name: rule-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the rule
+      -
+        name: chain
+        type: string
+        doc: name of the chain containing the rule
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the rule
+      -
+        name: expressions
+        type: nest
+        nested-attributes: expr-list-attrs
+        doc: list of expressions
+      -
+        name: compat
+        type: nest
+        nested-attributes: rule-compat-attrs
+        doc: compatibility specifications of the rule
+      -
+        name: position
+        type: u64
+        byte-order: big-endian
+        doc: numeric handle of the previous rule
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: id
+        type: u32
+        doc: uniquely identifies a rule in a transaction
+      -
+        name: position-id
+        type: u32
+        doc: transaction unique identifier of the previous rule
+      -
+        name: chain-id
+        type: u32
+        doc: add the rule to chain by ID, alternative to chain name
+  -
+    name: expr-list-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: expr-attrs
+        multi-attr: true
+  -
+    name: expr-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: name of the expression type
+      -
+        name: data
+        type: sub-message
+        sub-message: expr-ops
+        selector: name
+        doc: type specific data
+  -
+    name: rule-compat-attrs
+    attributes:
+      -
+        name: proto
+        type: binary
+        doc: numeric value of the handled protocol
+      -
+        name: flags
+        type: binary
+        doc: bitmask of flags
+  -
+    name: set-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: table name
+      -
+        name: name
+        type: string
+        doc: set name
+      -
+        name: flags
+        type: u32
+        enum: set-flags
+        byte-order: big-endian
+        doc: bitmask of enum nft_set_flags
+      -
+        name: key-type
+        type: u32
+        byte-order: big-endian
+        doc: key data type, informational purpose only
+      -
+        name: key-len
+        type: u32
+        byte-order: big-endian
+        doc: key data length
+      -
+        name: data-type
+        type: u32
+        byte-order: big-endian
+        doc: mapping data type
+      -
+        name: data-len
+        type: u32
+        byte-order: big-endian
+        doc: mapping data length
+      -
+        name: policy
+        type: u32
+        byte-order: big-endian
+        doc: selection policy
+      -
+        name: desc
+        type: nest
+        nested-attributes: set-desc-attrs
+        doc: set description
+      -
+        name: id
+        type: u32
+        doc: uniquely identifies a set in a transaction
+      -
+        name: timeout
+        type: u64
+        doc: default timeout value
+      -
+        name: gc-interval
+        type: u32
+        doc: garbage collection interval
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: pad
+        type: pad
+      -
+        name: obj-type
+        type: u32
+        byte-order: big-endian
+        doc: stateful object type
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: set handle
+      -
+        name: expr
+        type: nest
+        nested-attributes: expr-attrs
+        doc: set expression
+        multi-attr: true
+      -
+        name: expressions
+        type: nest
+        nested-attributes: set-list-attrs
+        doc: list of expressions
+  -
+    name: set-desc-attrs
+    attributes:
+      -
+        name: size
+        type: u32
+        byte-order: big-endian
+        doc: number of elements in set
+      -
+        name: concat
+        type: nest
+        nested-attributes: set-desc-concat-attrs
+        doc: description of field concatenation
+        multi-attr: true
+  -
+    name: set-desc-concat-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: set-field-attrs
+  -
+    name: set-field-attrs
+    attributes:
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+  -
+    name: set-list-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: expr-attrs
+        multi-attr: true
+  -
+    name: setelem-attrs
+    attributes:
+      -
+        name: key
+        type: nest
+        nested-attributes: data-attrs
+        doc: key value
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+        doc: data value of mapping
+      -
+        name: flags
+        type: binary
+        doc: bitmask of nft_set_elem_flags
+      -
+        name: timeout
+        type: u64
+        doc: timeout value
+      -
+        name: expiration
+        type: u64
+        doc: expiration time
+      -
+        name: userdata
+        type: binary
+        doc: user data
+      -
+        name: expr
+        type: nest
+        nested-attributes: expr-attrs
+        doc: expression
+      -
+        name: objref
+        type: string
+        doc: stateful object reference
+      -
+        name: key-end
+        type: nest
+        nested-attributes: data-attrs
+        doc: closing key value
+      -
+        name: expressions
+        type: nest
+        nested-attributes: expr-list-attrs
+        doc: list of expressions
+  -
+    name: setelem-list-elem-attrs
+    attributes:
+      -
+        name: elem
+        type: nest
+        nested-attributes: setelem-attrs
+        multi-attr: true
+  -
+    name: setelem-list-attrs
+    attributes:
+      -
+        name: table
+        type: string
+      -
+        name: set
+        type: string
+      -
+        name: elements
+        type: nest
+        nested-attributes: setelem-list-elem-attrs
+      -
+        name: set-id
+        type: u32
+  -
+    name: gen-attrs
+    attributes:
+      -
+        name: id
+        type: u32
+        byte-order: big-endian
+        doc: ruleset generation id
+      -
+        name: proc-pid
+        type: u32
+        byte-order: big-endian
+      -
+        name: proc-name
+        type: string
+  -
+    name: obj-attrs
+    attributes:
+      -
+        name: table
+        type: string
+        doc: name of the table containing the expression
+      -
+        name: name
+        type: string
+        doc: name of this expression type
+      -
+        name: type
+        type: u32
+        enum: object-type
+        byte-order: big-endian
+        doc: stateful object type
+      -
+        name: data
+        type: sub-message
+        sub-message: obj-data
+        selector: type
+        doc: stateful object data
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+        doc: number of references to this expression
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+        doc: object handle
+      -
+        name: pad
+        type: pad
+      -
+        name: userdata
+        type: binary
+        doc: user data
+  -
+    name: quota-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: quota-flags
+      -
+        name: pad
+        type: pad
+      -
+        name: consumed
+        type: u64
+        byte-order: big-endian
+  -
+    name: flowtable-attrs
+    attributes:
+      -
+        name: table
+        type: string
+      -
+        name: name
+        type: string
+      -
+        name: hook
+        type: nest
+        nested-attributes: flowtable-hook-attrs
+      -
+        name: use
+        type: u32
+        byte-order: big-endian
+      -
+        name: handle
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+  -
+    name: flowtable-hook-attrs
+    attributes:
+      -
+        name: num
+        type: u32
+        byte-order: big-endian
+      -
+        name: priority
+        type: u32
+        byte-order: big-endian
+      -
+        name: devs
+        type: nest
+        nested-attributes: hook-dev-attrs
+  -
+    name: expr-bitwise-attrs
+    attributes:
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+      -
+        name: mask
+        type: nest
+        nested-attributes: data-attrs
+      -
+        name: xor
+        type: nest
+        nested-attributes: data-attrs
+      -
+        name: op
+        type: u32
+        byte-order: big-endian
+        enum: bitwise-ops
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+  -
+    name: expr-cmp-attrs
+    attributes:
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: op
+        type: u32
+        byte-order: big-endian
+        enum: cmp-ops
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+  -
+    name: data-attrs
+    attributes:
+      -
+        name: value
+        type: binary
+        # sub-type: u8
+      -
+        name: verdict
+        type: nest
+        nested-attributes: verdict-attrs
+  -
+    name: verdict-attrs
+    attributes:
+      -
+        name: code
+        type: u32
+        byte-order: big-endian
+        enum: verdict-code
+      -
+        name: chain
+        type: string
+      -
+        name: chain-id
+        type: u32
+  -
+    name: expr-counter-attrs
+    attributes:
+      -
+        name: bytes
+        type: u64
+        doc: Number of bytes
+      -
+        name: packets
+        type: u64
+        doc: Number of packets
+      -
+        name: pad
+        type: pad
+  -
+    name: expr-fib-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: result
+        type: u32
+        byte-order: big-endian
+        enum: fib-result
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: fib-flags
+  -
+    name: expr-ct-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: key
+        type: u32
+        byte-order: big-endian
+        enum: ct-keys
+      -
+        name: direction
+        type: u8
+        enum: ct-direction
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-flow-offload-attrs
+    attributes:
+      -
+        name: name
+        type: string
+        doc: Flow offload table name
+  -
+    name: expr-immediate-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: data
+        type: nest
+        nested-attributes: data-attrs
+  -
+    name: expr-lookup-attrs
+    attributes:
+      -
+        name: set
+        type: string
+        doc: Name of set to use
+      -
+        name: set id
+        type: u32
+        byte-order: big-endian
+        doc: ID of set to use
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: lookup-flags
+  -
+    name: expr-meta-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: key
+        type: u32
+        byte-order: big-endian
+        enum: meta-keys
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-nat-attrs
+    attributes:
+      -
+        name: type
+        type: u32
+        byte-order: big-endian
+      -
+        name: family
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-proto-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-proto-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        byte-order: big-endian
+        enum: nat-range-flags
+        enum-as-flags: true
+  -
+    name: expr-payload-attrs
+    attributes:
+      -
+        name: dreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: base
+        type: u32
+        byte-order: big-endian
+      -
+        name: offset
+        type: u32
+        byte-order: big-endian
+      -
+        name: len
+        type: u32
+        byte-order: big-endian
+      -
+        name: sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-type
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-offset
+        type: u32
+        byte-order: big-endian
+      -
+        name: csum-flags
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-reject-attrs
+    attributes:
+      -
+        name: type
+        type: u32
+        byte-order: big-endian
+        enum: reject-types
+      -
+        name: icmp-code
+        type: u8
+  -
+    name: expr-target-attrs
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: rev
+        type: u32
+        byte-order: big-endian
+      -
+        name: info
+        type: binary
+  -
+    name: expr-tproxy-attrs
+    attributes:
+      -
+        name: family
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-addr
+        type: u32
+        byte-order: big-endian
+      -
+        name: reg-port
+        type: u32
+        byte-order: big-endian
+  -
+    name: expr-objref-attrs
+    attributes:
+      -
+        name: imm-type
+        type: u32
+        byte-order: big-endian
+      -
+        name: imm-name
+        type: string
+        doc: object name
+      -
+        name: set-sreg
+        type: u32
+        byte-order: big-endian
+      -
+        name: set-name
+        type: string
+        doc: name of object map
+      -
+        name: set-id
+        type: u32
+        byte-order: big-endian
+        doc: id of object map
+
+sub-messages:
+  -
+    name: expr-ops
+    formats:
+      -
+        value: bitwise
+        attribute-set: expr-bitwise-attrs
+      -
+        value: cmp
+        attribute-set: expr-cmp-attrs
+      -
+        value: counter
+        attribute-set: expr-counter-attrs
+      -
+        value: ct
+        attribute-set: expr-ct-attrs
+      -
+        value: fib
+        attribute-set: expr-fib-attrs
+      -
+        value: flow_offload
+        attribute-set: expr-flow-offload-attrs
+      -
+        value: immediate
+        attribute-set: expr-immediate-attrs
+      -
+        value: lookup
+        attribute-set: expr-lookup-attrs
+      -
+        value: meta
+        attribute-set: expr-meta-attrs
+      -
+        value: nat
+        attribute-set: expr-nat-attrs
+      -
+        value: objref
+        attribute-set: expr-objref-attrs
+      -
+        value: payload
+        attribute-set: expr-payload-attrs
+      -
+        value: quota
+        attribute-set: quota-attrs
+      -
+        value: reject
+        attribute-set: expr-reject-attrs
+      -
+        value: target
+        attribute-set: expr-target-attrs
+      -
+        value: tproxy
+        attribute-set: expr-tproxy-attrs
+  -
+    name: obj-data
+    formats:
+      -
+        value: counter
+        attribute-set: counter-attrs
+      -
+        value: quota
+        attribute-set: quota-attrs
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: batch-begin
+      doc: Start a batch of operations
+      attribute-set: batch-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0x10
+          attributes:
+            - genid
+        reply:
+          value: 0x10
+          attributes:
+            - genid
+    -
+      name: batch-end
+      doc: Finish a batch of operations
+      attribute-set: batch-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0x11
+          attributes:
+            - genid
+    -
+      name: newtable
+      doc: Create a new table.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa00
+          attributes:
+            - name
+    -
+      name: gettable
+      doc: Get / dump tables.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa01
+          attributes:
+            - name
+        reply:
+          value: 0xa00
+          attributes:
+            - name
+    -
+      name: deltable
+      doc: Delete an existing table.
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa02
+          attributes:
+            - name
+    -
+      name: destroytable
+      doc: Delete an existing table with destroy semantics (ignoring ENOEN=
T errors).
+      attribute-set: table-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1a
+          attributes:
+            - name
+    -
+      name: newchain
+      doc: Create a new chain.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa03
+          attributes:
+            - name
+    -
+      name: getchain
+      doc: Get / dump chains.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa04
+          attributes:
+            - name
+        reply:
+          value: 0xa03
+          attributes:
+            - name
+    -
+      name: delchain
+      doc: Delete an existing chain.
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa05
+          attributes:
+            - name
+    -
+      name: destroychain
+      doc: Delete an existing chain with destroy semantics (ignoring ENOEN=
T errors).
+      attribute-set: chain-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1b
+          attributes:
+            - name
+    -
+      name: newrule
+      doc: Create a new rule.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa06
+          attributes:
+            - name
+    -
+      name: getrule
+      doc: Get / dump rules.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa07
+          attributes:
+            - name
+        reply:
+          value: 0xa06
+          attributes:
+            - name
+    -
+      name: getrule-reset
+      doc: Get / dump rules and reset stateful expressions.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa19
+          attributes:
+            - name
+        reply:
+          value: 0xa06
+          attributes:
+            - name
+    -
+      name: delrule
+      doc: Delete an existing rule.
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa08
+          attributes:
+            - name
+    -
+      name: destroyrule
+      doc: Delete an existing rule with destroy semantics (ignoring ENOENT=
 errors).
+      attribute-set: rule-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1c
+          attributes:
+            - name
+    -
+      name: newset
+      doc: Create a new set.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa09
+          attributes:
+            - name
+    -
+      name: getset
+      doc: Get / dump sets.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0a
+          attributes:
+            - name
+        reply:
+          value: 0xa09
+          attributes:
+            - name
+    -
+      name: delset
+      doc: Delete an existing set.
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0b
+          attributes:
+            - name
+    -
+      name: destroyset
+      doc: Delete an existing set with destroy semantics (ignoring ENOENT =
errors).
+      attribute-set: set-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1d
+          attributes:
+            - name
+    -
+      name: newsetelem
+      doc: Create a new set element.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0c
+          attributes:
+            - name
+    -
+      name: getsetelem
+      doc: Get / dump set elements.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0d
+          attributes:
+            - name
+        reply:
+          value: 0xa0c
+          attributes:
+            - name
+    -
+      name: getsetelem-reset
+      doc: Get / dump set elements and reset stateful expressions.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa21
+          attributes:
+            - name
+        reply:
+          value: 0xa0c
+          attributes:
+            - name
+    -
+      name: delsetelem
+      doc: Delete an existing set element.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa0e
+          attributes:
+            - name
+    -
+      name: destroysetelem
+      doc: Delete an existing set element with destroy semantics.
+      attribute-set: setelem-list-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1e
+          attributes:
+            - name
+    -
+      name: getgen
+      doc: Get / dump rule-set generation.
+      attribute-set: gen-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa10
+          attributes:
+            - name
+        reply:
+          value: 0xa0f
+          attributes:
+            - name
+    -
+      name: newobj
+      doc: Create a new stateful object.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa12
+          attributes:
+            - name
+    -
+      name: getobj
+      doc: Get / dump stateful objects.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa13
+          attributes:
+            - name
+        reply:
+          value: 0xa12
+          attributes:
+            - name
+    -
+      name: delobj
+      doc: Delete an existing stateful object.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa14
+          attributes:
+            - name
+    -
+      name: destroyobj
+      doc: Delete an existing stateful object with destroy semantics.
+      attribute-set: obj-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa1f
+          attributes:
+            - name
+    -
+      name: newflowtable
+      doc: Create a new flow table.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa16
+          attributes:
+            - name
+    -
+      name: getflowtable
+      doc: Get / dump flow tables.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa17
+          attributes:
+            - name
+        reply:
+          value: 0xa16
+          attributes:
+            - name
+    -
+      name: delflowtable
+      doc: Delete an existing flow table.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa18
+          attributes:
+            - name
+    -
+      name: destroyflowtable
+      doc: Delete an existing flow table with destroy semantics.
+      attribute-set: flowtable-attrs
+      fixed-header: nfgenmsg
+      do:
+        request:
+          value: 0xa20
+          attributes:
+            - name
+
+mcast-groups:
+  list:
+    -
+      name: mgmt
diff --git a/source/specs/nl80211.yaml b/source/specs/nl80211.yaml
new file mode 100644
index 000000000000..1ec49c3562cd
--- /dev/null
+++ b/source/specs/nl80211.yaml
@@ -0,0 +1,2000 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: nl80211
+protocol: genetlink-legacy
+
+doc:
+  Netlink API for 802.11 wireless devices
+
+definitions:
+  -
+    name: commands
+    type: enum
+    entries:
+      - unspec
+      - get-wiphy
+      - set-wiphy
+      - new-wiphy
+      - del-wiphy
+      - get-interface
+      - set-interface
+      - new-interface
+      - del-interface
+      - get-key
+      - set-key
+      - new-key
+      - del-key
+      - get-beacon
+      - set-beacon
+      - new-beacon
+      - del-beacon
+      - get-station
+      - set-station
+      - new-station
+      - del-station
+      - get-mpath
+      - set-mpath
+      - new-mpath
+      - del-mpath
+      - set-bss
+      - set-reg
+      - req-set-reg
+      - get-mesh-config
+      - set-mesh-config
+      - set-mgmt-extra-ie
+      - get-reg
+      - get-scan
+      - trigger-scan
+      - new-scan-results
+      - scan-aborted
+      - reg-change
+      - authenticate
+      - associate
+      - deauthenticate
+      - disassociate
+      - michael-mic-failure
+      - reg-beacon-hint
+      - join-ibss
+      - leave-ibss
+      - testmode
+      - connect
+      - roam
+      - disconnect
+      - set-wiphy-netns
+      - get-survey
+      - new-survey-results
+      - set-pmksa
+      - del-pmksa
+      - flush-pmksa
+      - remain-on-channel
+      - cancel-remain-on-channel
+      - set-tx-bitrate-mask
+      - register-action
+      - action
+      - action-tx-status
+      - set-power-save
+      - get-power-save
+      - set-cqm
+      - notify-cqm
+      - set-channel
+      - set-wds-peer
+      - frame-wait-cancel
+      - join-mesh
+      - leave-mesh
+      - unprot-deauthenticate
+      - unprot-disassociate
+      - new-peer-candidate
+      - get-wowlan
+      - set-wowlan
+      - start-sched-scan
+      - stop-sched-scan
+      - sched-scan-results
+      - sched-scan-stopped
+      - set-rekey-offload
+      - pmksa-candidate
+      - tdls-oper
+      - tdls-mgmt
+      - unexpected-frame
+      - probe-client
+      - register-beacons
+      - unexpected-4-addr-frame
+      - set-noack-map
+      - ch-switch-notify
+      - start-p2p-device
+      - stop-p2p-device
+      - conn-failed
+      - set-mcast-rate
+      - set-mac-acl
+      - radar-detect
+      - get-protocol-features
+      - update-ft-ies
+      - ft-event
+      - crit-protocol-start
+      - crit-protocol-stop
+      - get-coalesce
+      - set-coalesce
+      - channel-switch
+      - vendor
+      - set-qos-map
+      - add-tx-ts
+      - del-tx-ts
+      - get-mpp
+      - join-ocb
+      - leave-ocb
+      - ch-switch-started-notify
+      - tdls-channel-switch
+      - tdls-cancel-channel-switch
+      - wiphy-reg-change
+      - abort-scan
+      - start-nan
+      - stop-nan
+      - add-nan-function
+      - del-nan-function
+      - change-nan-config
+      - nan-match
+      - set-multicast-to-unicast
+      - update-connect-params
+      - set-pmk
+      - del-pmk
+      - port-authorized
+      - reload-regdb
+      - external-auth
+      - sta-opmode-changed
+      - control-port-frame
+      - get-ftm-responder-stats
+      - peer-measurement-start
+      - peer-measurement-result
+      - peer-measurement-complete
+      - notify-radar
+      - update-owe-info
+      - probe-mesh-link
+      - set-tid-config
+      - unprot-beacon
+      - control-port-frame-tx-status
+      - set-sar-specs
+      - obss-color-collision
+      - color-change-request
+      - color-change-started
+      - color-change-aborted
+      - color-change-completed
+      - set-fils-aad
+      - assoc-comeback
+      - add-link
+      - remove-link
+      - add-link-sta
+      - modify-link-sta
+      - remove-link-sta
+      - set-hw-timestamp
+      - links-removed
+      - set-tid-to-link-mapping
+  -
+    name: feature-flags
+    type: flags
+    entries:
+      - sk-tx-status
+      - ht-ibss
+      - inactivity-timer
+      - cell-base-reg-hints
+      - p2p-device-needs-channel
+      - sae
+      - low-priority-scan
+      - scan-flush
+      - ap-scan
+      - vif-txpower
+      - need-obss-scan
+      - p2p-go-ctwin
+      - p2p-go-oppps
+      - reserved
+      - advertise-chan-limits
+      - full-ap-client-state
+      - userspace-mpm
+      - active-monitor
+      - ap-mode-chan-width-change
+      - ds-param-set-ie-in-probes
+      - wfa-tpc-ie-in-probes
+      - quiet
+      - tx-power-insertion
+      - ackto-estimation
+      - static-smps
+      - dynamic-smps
+      - supports-wmm-admission
+      - mac-on-create
+      - tdls-channel-switch
+      - scan-random-mac-addr
+      - sched-scan-random-mac-addr
+      - no-random-mac-addr
+  -
+    name: ieee80211-mcs-info
+    type: struct
+    members:
+      -
+        name: rx-mask
+        type: binary
+        len: 10
+      -
+        name: rx-highest
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-params
+        type: u8
+      -
+        name: reserved
+        type: binary
+        len: 3
+  -
+    name: ieee80211-vht-mcs-info
+    type: struct
+    members:
+      -
+        name: rx-mcs-map
+        type: u16
+        byte-order: little-endian
+      -
+        name: rx-highest
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-mcs-map
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-highest
+        type: u16
+        byte-order: little-endian
+  -
+    name: ieee80211-ht-cap
+    type: struct
+    members:
+      -
+        name: cap-info
+        type: u16
+        byte-order: little-endian
+      -
+        name: ampdu-params-info
+        type: u8
+      -
+        name: mcs
+        type: binary
+        struct: ieee80211-mcs-info
+      -
+        name: extended-ht-cap-info
+        type: u16
+        byte-order: little-endian
+      -
+        name: tx-bf-cap-info
+        type: u32
+        byte-order: little-endian
+      -
+        name: antenna-selection-info
+        type: u8
+  -
+    name: channel-type
+    type: enum
+    entries:
+      - no-ht
+      - ht20
+      - ht40minus
+      - ht40plus
+  -
+    name: sta-flag-update
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+      -
+        name: set
+        type: u32
+  -
+    name: protocol-features
+    type: flags
+    entries:
+      - split-wiphy-dump
+
+attribute-sets:
+  -
+    name: nl80211-attrs
+    name-prefix: nl80211-attr-
+    enum-name: nl80211-attrs
+    attr-max-name: num-nl80211-attr
+    attributes:
+      -
+        name: wiphy
+        type: u32
+      -
+        name: wiphy-name
+        type: string
+      -
+        name: ifindex
+        type: u32
+      -
+        name: ifname
+        type: string
+      -
+        name: iftype
+        type: u32
+      -
+        name: mac
+        type: binary
+        display-hint: mac
+      -
+        name: key-data
+        type: binary
+      -
+        name: key-idx
+        type: u8
+      -
+        name: key-cipher
+        type: u32
+      -
+        name: key-seq
+        type: binary
+      -
+        name: key-default
+        type: flag
+      -
+        name: beacon-interval
+        type: u32
+      -
+        name: dtim-period
+        type: u32
+      -
+        name: beacon-head
+        type: binary
+      -
+        name: beacon-tail
+        type: binary
+      -
+        name: sta-aid
+        type: u16
+      -
+        name: sta-flags
+        type: binary # TODO: nest
+      -
+        name: sta-listen-interval
+        type: u16
+      -
+        name: sta-supported-rates
+        type: binary
+      -
+        name: sta-vlan
+        type: u32
+      -
+        name: sta-info
+        type: binary # TODO: nest
+      -
+        name: wiphy-bands
+        type: nest
+        nested-attributes: wiphy-bands
+      -
+        name: mntr-flags
+        type: binary # TODO: nest
+      -
+        name: mesh-id
+        type: binary
+      -
+        name: sta-plink-action
+        type: u8
+      -
+        name: mpath-next-hop
+        type: binary
+        display-hint: mac
+      -
+        name: mpath-info
+        type: binary # TODO: nest
+      -
+        name: bss-cts-prot
+        type: u8
+      -
+        name: bss-short-preamble
+        type: u8
+      -
+        name: bss-short-slot-time
+        type: u8
+      -
+        name: ht-capability
+        type: binary
+      -
+        name: supported-iftypes
+        type: nest
+        nested-attributes: supported-iftypes
+      -
+        name: reg-alpha2
+        type: binary
+      -
+        name: reg-rules
+        type: binary # TODO: nest
+      -
+        name: mesh-config
+        type: binary # TODO: nest
+      -
+        name: bss-basic-rates
+        type: binary
+      -
+        name: wiphy-txq-params
+        type: binary # TODO: nest
+      -
+        name: wiphy-freq
+        type: u32
+      -
+        name: wiphy-channel-type
+        type: u32
+        enum: channel-type
+      -
+        name: key-default-mgmt
+        type: flag
+      -
+        name: mgmt-subtype
+        type: u8
+      -
+        name: ie
+        type: binary
+      -
+        name: max-num-scan-ssids
+        type: u8
+      -
+        name: scan-frequencies
+        type: binary # TODO: nest
+      -
+        name: scan-ssids
+        type: binary # TODO: nest
+      -
+        name: generation
+        type: u32
+      -
+        name: bss
+        type: binary # TODO: nest
+      -
+        name: reg-initiator
+        type: u8
+      -
+        name: reg-type
+        type: u8
+      -
+        name: supported-commands
+        type: indexed-array
+        sub-type: u32
+        enum: commands
+      -
+        name: frame
+        type: binary
+      -
+        name: ssid
+        type: binary
+      -
+        name: auth-type
+        type: u32
+      -
+        name: reason-code
+        type: u16
+      -
+        name: key-type
+        type: u32
+      -
+        name: max-scan-ie-len
+        type: u16
+      -
+        name: cipher-suites
+        type: binary
+        sub-type: u32
+        display-hint: hex
+      -
+        name: freq-before
+        type: binary # TODO: nest
+      -
+        name: freq-after
+        type: binary # TODO: nest
+      -
+        name: freq-fixed
+        type: flag
+      -
+        name: wiphy-retry-short
+        type: u8
+      -
+        name: wiphy-retry-long
+        type: u8
+      -
+        name: wiphy-frag-threshold
+        type: u32
+      -
+        name: wiphy-rts-threshold
+        type: u32
+      -
+        name: timed-out
+        type: flag
+      -
+        name: use-mfp
+        type: u32
+      -
+        name: sta-flags2
+        type: binary
+        struct: sta-flag-update
+      -
+        name: control-port
+        type: flag
+      -
+        name: testdata
+        type: binary
+      -
+        name: privacy
+        type: flag
+      -
+        name: disconnected-by-ap
+        type: flag
+      -
+        name: status-code
+        type: u16
+      -
+        name: cipher-suites-pairwise
+        type: binary
+      -
+        name: cipher-suite-group
+        type: u32
+      -
+        name: wpa-versions
+        type: u32
+      -
+        name: akm-suites
+        type: binary
+      -
+        name: req-ie
+        type: binary
+      -
+        name: resp-ie
+        type: binary
+      -
+        name: prev-bssid
+        type: binary
+      -
+        name: key
+        type: binary # TODO: nest
+      -
+        name: keys
+        type: binary # TODO: nest
+      -
+        name: pid
+        type: u32
+      -
+        name: 4addr
+        type: u8
+      -
+        name: survey-info
+        type: binary # TODO: nest
+      -
+        name: pmkid
+        type: binary
+      -
+        name: max-num-pmkids
+        type: u8
+      -
+        name: duration
+        type: u32
+      -
+        name: cookie
+        type: u64
+      -
+        name: wiphy-coverage-class
+        type: u8
+      -
+        name: tx-rates
+        type: binary # TODO: nest
+      -
+        name: frame-match
+        type: binary
+      -
+        name: ack
+        type: flag
+      -
+        name: ps-state
+        type: u32
+      -
+        name: cqm
+        type: binary # TODO: nest
+      -
+        name: local-state-change
+        type: flag
+      -
+        name: ap-isolate
+        type: u8
+      -
+        name: wiphy-tx-power-setting
+        type: u32
+      -
+        name: wiphy-tx-power-level
+        type: u32
+      -
+        name: tx-frame-types
+        type: nest
+        nested-attributes: iftype-attrs
+      -
+        name: rx-frame-types
+        type: nest
+        nested-attributes: iftype-attrs
+      -
+        name: frame-type
+        type: u16
+      -
+        name: control-port-ethertype
+        type: flag
+      -
+        name: control-port-no-encrypt
+        type: flag
+      -
+        name: support-ibss-rsn
+        type: flag
+      -
+        name: wiphy-antenna-tx
+        type: u32
+      -
+        name: wiphy-antenna-rx
+        type: u32
+      -
+        name: mcast-rate
+        type: u32
+      -
+        name: offchannel-tx-ok
+        type: flag
+      -
+        name: bss-ht-opmode
+        type: u16
+      -
+        name: key-default-types
+        type: binary # TODO: nest
+      -
+        name: max-remain-on-channel-duration
+        type: u32
+      -
+        name: mesh-setup
+        type: binary # TODO: nest
+      -
+        name: wiphy-antenna-avail-tx
+        type: u32
+      -
+        name: wiphy-antenna-avail-rx
+        type: u32
+      -
+        name: support-mesh-auth
+        type: flag
+      -
+        name: sta-plink-state
+        type: u8
+      -
+        name: wowlan-triggers
+        type: binary # TODO: nest
+      -
+        name: wowlan-triggers-supported
+        type: nest
+        nested-attributes: wowlan-triggers-attrs
+      -
+        name: sched-scan-interval
+        type: u32
+      -
+        name: interface-combinations
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: if-combination-attributes
+      -
+        name: software-iftypes
+        type: nest
+        nested-attributes: supported-iftypes
+      -
+        name: rekey-data
+        type: binary # TODO: nest
+      -
+        name: max-num-sched-scan-ssids
+        type: u8
+      -
+        name: max-sched-scan-ie-len
+        type: u16
+      -
+        name: scan-supp-rates
+        type: binary # TODO: nest
+      -
+        name: hidden-ssid
+        type: u32
+      -
+        name: ie-probe-resp
+        type: binary
+      -
+        name: ie-assoc-resp
+        type: binary
+      -
+        name: sta-wme
+        type: binary # TODO: nest
+      -
+        name: support-ap-uapsd
+        type: flag
+      -
+        name: roam-support
+        type: flag
+      -
+        name: sched-scan-match
+        type: binary # TODO: nest
+      -
+        name: max-match-sets
+        type: u8
+      -
+        name: pmksa-candidate
+        type: binary # TODO: nest
+      -
+        name: tx-no-cck-rate
+        type: flag
+      -
+        name: tdls-action
+        type: u8
+      -
+        name: tdls-dialog-token
+        type: u8
+      -
+        name: tdls-operation
+        type: u8
+      -
+        name: tdls-support
+        type: flag
+      -
+        name: tdls-external-setup
+        type: flag
+      -
+        name: device-ap-sme
+        type: u32
+      -
+        name: dont-wait-for-ack
+        type: flag
+      -
+        name: feature-flags
+        type: u32
+        enum: feature-flags
+        enum-as-flags: True
+      -
+        name: probe-resp-offload
+        type: u32
+      -
+        name: probe-resp
+        type: binary
+      -
+        name: dfs-region
+        type: u8
+      -
+        name: disable-ht
+        type: flag
+      -
+        name: ht-capability-mask
+        type: binary
+        struct: ieee80211-ht-cap
+      -
+        name: noack-map
+        type: u16
+      -
+        name: inactivity-timeout
+        type: u16
+      -
+        name: rx-signal-dbm
+        type: u32
+      -
+        name: bg-scan-period
+        type: u16
+      -
+        name: wdev
+        type: u64
+      -
+        name: user-reg-hint-type
+        type: u32
+      -
+        name: conn-failed-reason
+        type: u32
+      -
+        name: auth-data
+        type: binary
+      -
+        name: vht-capability
+        type: binary
+      -
+        name: scan-flags
+        type: u32
+      -
+        name: channel-width
+        type: u32
+      -
+        name: center-freq1
+        type: u32
+      -
+        name: center-freq2
+        type: u32
+      -
+        name: p2p-ctwindow
+        type: u8
+      -
+        name: p2p-oppps
+        type: u8
+      -
+        name: local-mesh-power-mode
+        type: u32
+      -
+        name: acl-policy
+        type: u32
+      -
+        name: mac-addrs
+        type: binary # TODO: nest
+      -
+        name: mac-acl-max
+        type: u32
+      -
+        name: radar-event
+        type: u32
+      -
+        name: ext-capa
+        type: binary
+      -
+        name: ext-capa-mask
+        type: binary
+      -
+        name: sta-capability
+        type: u16
+      -
+        name: sta-ext-capability
+        type: binary
+      -
+        name: protocol-features
+        type: u32
+        enum: protocol-features
+      -
+        name: split-wiphy-dump
+        type: flag
+      -
+        name: disable-vht
+        type: flag
+      -
+        name: vht-capability-mask
+        type: binary
+      -
+        name: mdid
+        type: u16
+      -
+        name: ie-ric
+        type: binary
+      -
+        name: crit-prot-id
+        type: u16
+      -
+        name: max-crit-prot-duration
+        type: u16
+      -
+        name: peer-aid
+        type: u16
+      -
+        name: coalesce-rule
+        type: binary # TODO: nest
+      -
+        name: ch-switch-count
+        type: u32
+      -
+        name: ch-switch-block-tx
+        type: flag
+      -
+        name: csa-ies
+        type: binary # TODO: nest
+      -
+        name: cntdwn-offs-beacon
+        type: binary
+      -
+        name: cntdwn-offs-presp
+        type: binary
+      -
+        name: rxmgmt-flags
+        type: binary
+      -
+        name: sta-supported-channels
+        type: binary
+      -
+        name: sta-supported-oper-classes
+        type: binary
+      -
+        name: handle-dfs
+        type: flag
+      -
+        name: support-5-mhz
+        type: flag
+      -
+        name: support-10-mhz
+        type: flag
+      -
+        name: opmode-notif
+        type: u8
+      -
+        name: vendor-id
+        type: u32
+      -
+        name: vendor-subcmd
+        type: u32
+      -
+        name: vendor-data
+        type: binary
+      -
+        name: vendor-events
+        type: binary
+      -
+        name: qos-map
+        type: binary
+      -
+        name: mac-hint
+        type: binary
+        display-hint: mac
+      -
+        name: wiphy-freq-hint
+        type: u32
+      -
+        name: max-ap-assoc-sta
+        type: u32
+      -
+        name: tdls-peer-capability
+        type: u32
+      -
+        name: socket-owner
+        type: flag
+      -
+        name: csa-c-offsets-tx
+        type: binary
+      -
+        name: max-csa-counters
+        type: u8
+      -
+        name: tdls-initiator
+        type: flag
+      -
+        name: use-rrm
+        type: flag
+      -
+        name: wiphy-dyn-ack
+        type: flag
+      -
+        name: tsid
+        type: u8
+      -
+        name: user-prio
+        type: u8
+      -
+        name: admitted-time
+        type: u16
+      -
+        name: smps-mode
+        type: u8
+      -
+        name: oper-class
+        type: u8
+      -
+        name: mac-mask
+        type: binary
+        display-hint: mac
+      -
+        name: wiphy-self-managed-reg
+        type: flag
+      -
+        name: ext-features
+        type: binary
+      -
+        name: survey-radio-stats
+        type: binary
+      -
+        name: netns-fd
+        type: u32
+      -
+        name: sched-scan-delay
+        type: u32
+      -
+        name: reg-indoor
+        type: flag
+      -
+        name: max-num-sched-scan-plans
+        type: u32
+      -
+        name: max-scan-plan-interval
+        type: u32
+      -
+        name: max-scan-plan-iterations
+        type: u32
+      -
+        name: sched-scan-plans
+        type: binary # TODO: nest
+      -
+        name: pbss
+        type: flag
+      -
+        name: bss-select
+        type: binary # TODO: nest
+      -
+        name: sta-support-p2p-ps
+        type: u8
+      -
+        name: pad
+        type: binary
+      -
+        name: iftype-ext-capa
+        type: binary # TODO: nest
+      -
+        name: mu-mimo-group-data
+        type: binary
+      -
+        name: mu-mimo-follow-mac-addr
+        type: binary
+        display-hint: mac
+      -
+        name: scan-start-time-tsf
+        type: u64
+      -
+        name: scan-start-time-tsf-bssid
+        type: binary
+      -
+        name: measurement-duration
+        type: u16
+      -
+        name: measurement-duration-mandatory
+        type: flag
+      -
+        name: mesh-peer-aid
+        type: u16
+      -
+        name: nan-master-pref
+        type: u8
+      -
+        name: bands
+        type: u32
+      -
+        name: nan-func
+        type: binary # TODO: nest
+      -
+        name: nan-match
+        type: binary # TODO: nest
+      -
+        name: fils-kek
+        type: binary
+      -
+        name: fils-nonces
+        type: binary
+      -
+        name: multicast-to-unicast-enabled
+        type: flag
+      -
+        name: bssid
+        type: binary
+        display-hint: mac
+      -
+        name: sched-scan-relative-rssi
+        type: s8
+      -
+        name: sched-scan-rssi-adjust
+        type: binary
+      -
+        name: timeout-reason
+        type: u32
+      -
+        name: fils-erp-username
+        type: binary
+      -
+        name: fils-erp-realm
+        type: binary
+      -
+        name: fils-erp-next-seq-num
+        type: u16
+      -
+        name: fils-erp-rrk
+        type: binary
+      -
+        name: fils-cache-id
+        type: binary
+      -
+        name: pmk
+        type: binary
+      -
+        name: sched-scan-multi
+        type: flag
+      -
+        name: sched-scan-max-reqs
+        type: u32
+      -
+        name: want-1x-4way-hs
+        type: flag
+      -
+        name: pmkr0-name
+        type: binary
+      -
+        name: port-authorized
+        type: binary
+      -
+        name: external-auth-action
+        type: u32
+      -
+        name: external-auth-support
+        type: flag
+      -
+        name: nss
+        type: u8
+      -
+        name: ack-signal
+        type: s32
+      -
+        name: control-port-over-nl80211
+        type: flag
+      -
+        name: txq-stats
+        type: nest
+        nested-attributes: txq-stats-attrs
+      -
+        name: txq-limit
+        type: u32
+      -
+        name: txq-memory-limit
+        type: u32
+      -
+        name: txq-quantum
+        type: u32
+      -
+        name: he-capability
+        type: binary
+      -
+        name: ftm-responder
+        type: binary # TODO: nest
+      -
+        name: ftm-responder-stats
+        type: binary # TODO: nest
+      -
+        name: timeout
+        type: u32
+      -
+        name: peer-measurements
+        type: binary # TODO: nest
+      -
+        name: airtime-weight
+        type: u16
+      -
+        name: sta-tx-power-setting
+        type: u8
+      -
+        name: sta-tx-power
+        type: s16
+      -
+        name: sae-password
+        type: binary
+      -
+        name: twt-responder
+        type: flag
+      -
+        name: he-obss-pd
+        type: binary # TODO: nest
+      -
+        name: wiphy-edmg-channels
+        type: u8
+      -
+        name: wiphy-edmg-bw-config
+        type: u8
+      -
+        name: vlan-id
+        type: u16
+      -
+        name: he-bss-color
+        type: binary # TODO: nest
+      -
+        name: iftype-akm-suites
+        type: binary # TODO: nest
+      -
+        name: tid-config
+        type: binary # TODO: nest
+      -
+        name: control-port-no-preauth
+        type: flag
+      -
+        name: pmk-lifetime
+        type: u32
+      -
+        name: pmk-reauth-threshold
+        type: u8
+      -
+        name: receive-multicast
+        type: flag
+      -
+        name: wiphy-freq-offset
+        type: u32
+      -
+        name: center-freq1-offset
+        type: u32
+      -
+        name: scan-freq-khz
+        type: binary # TODO: nest
+      -
+        name: he-6ghz-capability
+        type: binary
+      -
+        name: fils-discovery
+        type: binary # TOOD: nest
+      -
+        name: unsol-bcast-probe-resp
+        type: binary # TOOD: nest
+      -
+        name: s1g-capability
+        type: binary
+      -
+        name: s1g-capability-mask
+        type: binary
+      -
+        name: sae-pwe
+        type: u8
+      -
+        name: reconnect-requested
+        type: binary
+      -
+        name: sar-spec
+        type: nest
+        nested-attributes: sar-attributes
+      -
+        name: disable-he
+        type: flag
+      -
+        name: obss-color-bitmap
+        type: u64
+      -
+        name: color-change-count
+        type: u8
+      -
+        name: color-change-color
+        type: u8
+      -
+        name: color-change-elems
+        type: binary # TODO: nest
+      -
+        name: mbssid-config
+        type: binary # TODO: nest
+      -
+        name: mbssid-elems
+        type: binary # TODO: nest
+      -
+        name: radar-background
+        type: flag
+      -
+        name: ap-settings-flags
+        type: u32
+      -
+        name: eht-capability
+        type: binary
+      -
+        name: disable-eht
+        type: flag
+      -
+        name: mlo-links
+        type: binary # TODO: nest
+      -
+        name: mlo-link-id
+        type: u8
+      -
+        name: mld-addr
+        type: binary
+        display-hint: mac
+      -
+        name: mlo-support
+        type: flag
+      -
+        name: max-num-akm-suites
+        type: binary
+      -
+        name: eml-capability
+        type: u16
+      -
+        name: mld-capa-and-ops
+        type: u16
+      -
+        name: tx-hw-timestamp
+        type: u64
+      -
+        name: rx-hw-timestamp
+        type: u64
+      -
+        name: td-bitmap
+        type: binary
+      -
+        name: punct-bitmap
+        type: u32
+      -
+        name: max-hw-timestamp-peers
+        type: u16
+      -
+        name: hw-timestamp-enabled
+        type: flag
+      -
+        name: ema-rnr-elems
+        type: binary # TODO: nest
+      -
+        name: mlo-link-disabled
+        type: flag
+      -
+        name: bss-dump-include-use-data
+        type: flag
+      -
+        name: mlo-ttlm-dlink
+        type: u16
+      -
+        name: mlo-ttlm-ulink
+        type: u16
+      -
+        name: assoc-spp-amsdu
+        type: flag
+      -
+        name: wiphy-radios
+        type: binary # TODO: nest
+      -
+        name: wiphy-interface-combinations
+        type: binary # TODO: nest
+      -
+        name: vif-radio-mask
+        type: u32
+  -
+    name: frame-type-attrs
+    subset-of: nl80211-attrs
+    attributes:
+      -
+        name: frame-type
+  -
+    name: wiphy-bands
+    name-prefix: nl80211-band-
+    attr-max-name: num-nl80211-bands
+    attributes:
+      -
+        name: 2ghz
+        doc: 2.4 GHz ISM band
+        value: 0
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 5ghz
+        doc: around 5 GHz band (4.9 - 5.7 GHz)
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 60ghz
+        doc: around 60 GHz band (58.32 - 69.12 GHz)
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: 6ghz
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: s1ghz
+        type: nest
+        nested-attributes: band-attrs
+      -
+        name: lc
+        type: nest
+        nested-attributes: band-attrs
+  -
+    name: band-attrs
+    enum-name: nl80211-band-attr
+    name-prefix: nl80211-band-attr-
+    attributes:
+      -
+        name: freqs
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: frequency-attrs
+      -
+        name: rates
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: bitrate-attrs
+      -
+        name: ht-mcs-set
+        type: binary
+        struct: ieee80211-mcs-info
+      -
+        name: ht-capa
+        type: u16
+      -
+        name: ht-ampdu-factor
+        type: u8
+      -
+        name: ht-ampdu-density
+        type: u8
+      -
+        name: vht-mcs-set
+        type: binary
+        struct: ieee80211-vht-mcs-info
+      -
+        name: vht-capa
+        type: u32
+      -
+        name: iftype-data
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: iftype-data-attrs
+      -
+        name: edmg-channels
+        type: binary
+      -
+        name: edmg-bw-config
+        type: binary
+      -
+        name: s1g-mcs-nss-set
+        type: binary
+      -
+        name: s1g-capa
+        type: binary
+  -
+    name: bitrate-attrs
+    name-prefix: nl80211-bitrate-attr-
+    attributes:
+      -
+        name: rate
+        type: u32
+      -
+        name: 2ghz-shortpreamble
+        type: flag
+  -
+    name: frequency-attrs
+    name-prefix: nl80211-frequency-attr-
+    attributes:
+      -
+        name: freq
+        type: u32
+      -
+        name: disabled
+        type: flag
+      -
+        name: no-ir
+        type: flag
+      -
+        name: no-ibss
+        name-prefix: __nl80211-frequency-attr-
+        type: flag
+      -
+        name: radar
+        type: flag
+      -
+        name: max-tx-power
+        type: u32
+      -
+        name: dfs-state
+        type: u32
+      -
+        name: dfs-time
+        type: binary
+      -
+        name: no-ht40-minus
+        type: binary
+      -
+        name: no-ht40-plus
+        type: binary
+      -
+        name: no-80mhz
+        type: binary
+      -
+        name: no-160mhz
+        type: binary
+      -
+        name: dfs-cac-time
+        type: binary
+      -
+        name: indoor-only
+        type: binary
+      -
+        name: ir-concurrent
+        type: binary
+      -
+        name: no-20mhz
+        type: binary
+      -
+        name: no-10mhz
+        type: binary
+      -
+        name: wmm
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: wmm-attrs
+      -
+        name: no-he
+        type: binary
+      -
+        name: offset
+        type: u32
+      -
+        name: 1mhz
+        type: binary
+      -
+        name: 2mhz
+        type: binary
+      -
+        name: 4mhz
+        type: binary
+      -
+        name: 8mhz
+        type: binary
+      -
+        name: 16mhz
+        type: binary
+      -
+        name: no-320mhz
+        type: binary
+      -
+        name: no-eht
+        type: binary
+      -
+        name: psd
+        type: binary
+      -
+        name: dfs-concurrent
+        type: binary
+      -
+        name: no-6ghz-vlp-client
+        type: binary
+      -
+        name: no-6ghz-afc-client
+        type: binary
+      -
+        name: can-monitor
+        type: binary
+      -
+        name: allow-6ghz-vlp-ap
+        type: binary
+  -
+    name: if-combination-attributes
+    enum-name: nl80211-if-combination-attrs
+    name-prefix: nl80211-iface-comb-
+    attr-max-name: max-nl80211-iface-comb
+    attributes:
+      -
+        name: limits
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: iface-limit-attributes
+      -
+        name: maxnum
+        type: u32
+      -
+        name: sta-ap-bi-match
+        type: flag
+      -
+        name: num-channels
+        type: u32
+      -
+        name: radar-detect-widths
+        type: u32
+      -
+        name: radar-detect-regions
+        type: u32
+      -
+        name: bi-min-gcd
+        type: u32
+  -
+    name: iface-limit-attributes
+    enum-name: nl80211-iface-limit-attrs
+    name-prefix: nl80211-iface-limit-
+    attr-max-name: max-nl80211-iface-limit
+    attributes:
+      -
+        name: max
+        type: u32
+      -
+        name: types
+        type: nest
+        nested-attributes: supported-iftypes
+  -
+    name: iftype-data-attrs
+    name-prefix: nl80211-band-iftype-attr-
+    attributes:
+      -
+        name: iftypes
+        type: binary
+      -
+        name: he-cap-mac
+        type: binary
+      -
+        name: he-cap-phy
+        type: binary
+      -
+        name: he-cap-mcs-set
+        type: binary
+      -
+        name: he-cap-ppe
+        type: binary
+      -
+        name: he-6ghz-capa
+        type: binary
+      -
+        name: vendor-elems
+        type: binary
+      -
+        name: eht-cap-mac
+        type: binary
+      -
+        name: eht-cap-phy
+        type: binary
+      -
+        name: eht-cap-mcs-set
+        type: binary
+      -
+        name: eht-cap-ppe
+        type: binary
+  -
+    name: iftype-attrs
+    enum-name: nl80211-iftype
+    name-prefix: nl80211-iftype-
+    attributes:
+      -
+        name: unspecified
+        type: nest
+        value: 0
+        nested-attributes: frame-type-attrs
+      -
+        name: adhoc
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: station
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ap
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ap-vlan
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: wds
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: monitor
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: mesh-point
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-client
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-go
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: p2p-device
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: ocb
+        type: nest
+        nested-attributes: frame-type-attrs
+      -
+        name: nan
+        type: nest
+        nested-attributes: frame-type-attrs
+  -
+    name: sar-attributes
+    enum-name: nl80211-sar-attrs
+    name-prefix: nl80211-sar-attr-
+    attributes:
+      -
+        name: type
+        type: u32
+      -
+        name: specs
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: sar-specs
+  -
+    name: sar-specs
+    enum-name: nl80211-sar-specs-attrs
+    name-prefix: nl80211-sar-attr-specs-
+    attributes:
+      -
+        name: power
+        type: s32
+      -
+        name: range-index
+        type: u32
+      -
+        name: start-freq
+        type: u32
+      -
+        name: end-freq
+        type: u32
+  -
+    name: supported-iftypes
+    enum-name: nl80211-iftype
+    name-prefix: nl80211-iftype-
+    attributes:
+      -
+        name: adhoc
+        type: flag
+      -
+        name: station
+        type: flag
+      -
+        name: ap
+        type: flag
+      -
+        name: ap-vlan
+        type: flag
+      -
+        name: wds
+        type: flag
+      -
+        name: monitor
+        type: flag
+      -
+        name: mesh-point
+        type: flag
+      -
+        name: p2p-client
+        type: flag
+      -
+        name: p2p-go
+        type: flag
+      -
+        name: p2p-device
+        type: flag
+      -
+        name: ocb
+        type: flag
+      -
+        name: nan
+        type: flag
+  -
+    name: txq-stats-attrs
+    name-prefix: nl80211-txq-stats-
+    attributes:
+      -
+        name: backlog-bytes
+        type: u32
+      -
+        name: backlog-packets
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: drops
+        type: u32
+      -
+        name: ecn-marks
+        type: u32
+      -
+        name: overlimit
+        type: u32
+      -
+        name: overmemory
+        type: u32
+      -
+        name: collisions
+        type: u32
+      -
+        name: tx-bytes
+        type: u32
+      -
+        name: tx-packets
+        type: u32
+      -
+        name: max-flows
+        type: u32
+  -
+    name: wmm-attrs
+    enum-name: nl80211-wmm-rule
+    name-prefix: nl80211-wmmr-
+    attributes:
+      -
+        name: cw-min
+        type: u16
+      -
+        name: cw-max
+        type: u16
+      -
+        name: aifsn
+        type: u8
+      -
+        name: txop
+        type: u16
+  -
+    name: wowlan-triggers-attrs
+    enum-name: nl80211-wowlan-triggers
+    name-prefix: nl80211-wowlan-trig-
+    attr-max-name: max-nl80211-wowlan-trig
+    attributes:
+      -
+        name: any
+        type: flag
+      -
+        name: disconnect
+        type: flag
+      -
+        name: magic-pkt
+        type: flag
+      -
+        name: pkt-pattern
+        type: flag
+      -
+        name: gtk-rekey-supported
+        type: flag
+      -
+        name: gtk-rekey-failure
+        type: flag
+      -
+        name: eap-ident-request
+        type: flag
+      -
+        name: 4way-handshake
+        type: flag
+      -
+        name: rfkill-release
+        type: flag
+      -
+        name: wakeup-pkt-80211
+        type: flag
+      -
+        name: wakeup-pkt-80211-len
+        type: flag
+      -
+        name: wakeup-pkt-8023
+        type: flag
+      -
+        name: wakeup-pkt-8023-len
+        type: flag
+      -
+        name: tcp-connection
+        type: flag
+      -
+        name: wakeup-tcp-match
+        type: flag
+      -
+        name: wakeup-tcp-connlost
+        type: flag
+      -
+        name: wakeup-tcp-nomoretokens
+        type: flag
+      -
+        name: net-detect
+        type: flag
+      -
+        name: net-detect-results
+        type: flag
+      -
+        name: unprotected-deauth-disassoc
+        type: flag
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: get-wiphy
+      doc: |
+        Get information about a wiphy or dump a list of all wiphys. Reques=
ts to dump get-wiphy
+        should unconditionally include the split-wiphy-dump flag in the re=
quest.
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 1
+          attributes:
+            - wiphy
+            - wdev
+            - ifindex
+        reply:
+          value: 3
+          attributes: &wiphy-reply-attrs
+            - bands
+            - cipher-suites
+            - control-port-ethertype
+            - ext-capa
+            - ext-capa-mask
+            - ext-features
+            - feature-flags
+            - generation
+            - ht-capability-mask
+            - interface-combinations
+            - mac
+            - max-csa-counters
+            - max-match-sets
+            - max-num-akm-suites
+            - max-num-pmkids
+            - max-num-scan-ssids
+            - max-num-sched-scan-plans
+            - max-num-sched-scan-ssids
+            - max-remain-on-channel-duration
+            - max-scan-ie-len
+            - max-scan-plan-interval
+            - max-scan-plan-iterations
+            - max-sched-scan-ie-len
+            - offchannel-tx-ok
+            - rx-frame-types
+            - sar-spec
+            - sched-scan-max-reqs
+            - software-iftypes
+            - support-ap-uapsd
+            - supported-commands
+            - supported-iftypes
+            - tdls-external-setup
+            - tdls-support
+            - tx-frame-types
+            - txq-limit
+            - txq-memory-limit
+            - txq-quantum
+            - txq-stats
+            - vht-capability-mask
+            - wiphy
+            - wiphy-antenna-avail-rx
+            - wiphy-antenna-avail-tx
+            - wiphy-antenna-rx
+            - wiphy-antenna-tx
+            - wiphy-bands
+            - wiphy-coverage-class
+            - wiphy-frag-threshold
+            - wiphy-name
+            - wiphy-retry-long
+            - wiphy-retry-short
+            - wiphy-rts-threshold
+            - wowlan-triggers-supported
+      dump:
+        request:
+          attributes:
+            - wiphy
+            - wdev
+            - ifindex
+            - split-wiphy-dump
+        reply:
+          attributes: *wiphy-reply-attrs
+    -
+      name: get-interface
+      doc: Get information about an interface or dump a list of all interf=
aces
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 5
+          attributes:
+            - ifname
+        reply:
+          value: 7
+          attributes: &interface-reply-attrs
+            - ifname
+            - iftype
+            - ifindex
+            - wiphy
+            - wdev
+            - mac
+            - generation
+            - txq-stats
+            - 4addr
+      dump:
+        request:
+          attributes:
+            - ifname
+        reply:
+          attributes: *interface-reply-attrs
+    -
+      name: get-protocol-features
+      doc: Get information about supported protocol features
+      attribute-set: nl80211-attrs
+      do:
+        request:
+          value: 95
+          attributes:
+            - protocol-features
+        reply:
+          value: 95
+          attributes:
+            - protocol-features
+
+mcast-groups:
+  list:
+    -
+      name: config
+    -
+      name: scan
+    -
+      name: regulatory
+    -
+      name: mlme
+    -
+      name: vendor
+    -
+      name: nan
+    -
+      name: testmode
diff --git a/source/specs/nlctrl.yaml b/source/specs/nlctrl.yaml
new file mode 100644
index 000000000000..a36535350bdb
--- /dev/null
+++ b/source/specs/nlctrl.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: nlctrl
+protocol: genetlink-legacy
+uapi-header: linux/genetlink.h
+
+doc: |
+  genetlink meta-family that exposes information about all genetlink
+  families registered in the kernel (including itself).
+
+definitions:
+  -
+    name: op-flags
+    type: flags
+    enum-name:
+    entries:
+      - admin-perm
+      - cmd-cap-do
+      - cmd-cap-dump
+      - cmd-cap-haspol
+      - uns-admin-perm
+  -
+    name: attr-type
+    enum-name: netlink-attribute-type
+    type: enum
+    entries:
+      - invalid
+      - flag
+      - u8
+      - u16
+      - u32
+      - u64
+      - s8
+      - s16
+      - s32
+      - s64
+      - binary
+      - string
+      - nul-string
+      - nested
+      - nested-array
+      - bitfield32
+      - sint
+      - uint
+
+attribute-sets:
+  -
+    name: ctrl-attrs
+    name-prefix: ctrl-attr-
+    attributes:
+      -
+        name: family-id
+        type: u16
+      -
+        name: family-name
+        type: string
+      -
+        name: version
+        type: u32
+      -
+        name: hdrsize
+        type: u32
+      -
+        name: maxattr
+        type: u32
+      -
+        name: ops
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: op-attrs
+      -
+        name: mcast-groups
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: mcast-group-attrs
+      -
+        name: policy
+        type: nest-type-value
+        type-value: [ policy-id, attr-id ]
+        nested-attributes: policy-attrs
+      -
+        name: op-policy
+        type: nest-type-value
+        type-value: [ op-id ]
+        nested-attributes: op-policy-attrs
+      -
+        name: op
+        type: u32
+  -
+    name: mcast-group-attrs
+    name-prefix: ctrl-attr-mcast-grp-
+    enum-name:
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: id
+        type: u32
+  -
+    name: op-attrs
+    name-prefix: ctrl-attr-op-
+    enum-name:
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: flags
+        type: u32
+        enum: op-flags
+        enum-as-flags: true
+  -
+    name: policy-attrs
+    name-prefix: nl-policy-type-attr-
+    enum-name:
+    attributes:
+      -
+        name: type
+        type: u32
+        enum: attr-type
+      -
+        name: min-value-s
+        type: s64
+      -
+        name: max-value-s
+        type: s64
+      -
+        name: min-value-u
+        type: u64
+      -
+        name: max-value-u
+        type: u64
+      -
+        name: min-length
+        type: u32
+      -
+        name: max-length
+        type: u32
+      -
+        name: policy-idx
+        type: u32
+      -
+        name: policy-maxtype
+        type: u32
+      -
+        name: bitfield32-mask
+        type: u32
+      -
+        name: mask
+        type: u64
+      -
+        name: pad
+        type: pad
+  -
+    name: op-policy-attrs
+    name-prefix: ctrl-attr-policy-
+    enum-name:
+    attributes:
+      -
+        name: do
+        type: u32
+      -
+        name: dump
+        type: u32
+
+operations:
+  enum-model: directional
+  name-prefix: ctrl-cmd-
+  list:
+    -
+      name: getfamily
+      doc: Get / dump genetlink families
+      attribute-set: ctrl-attrs
+      do:
+        request:
+          value: 3
+          attributes:
+            - family-name
+        reply: &all-attrs
+          value: 1
+          attributes:
+            - family-id
+            - family-name
+            - hdrsize
+            - maxattr
+            - mcast-groups
+            - ops
+            - version
+      dump:
+        reply: *all-attrs
+    -
+      name: getpolicy
+      doc: Get / dump genetlink policies
+      attribute-set: ctrl-attrs
+      dump:
+        request:
+          value: 10
+          attributes:
+            - family-name
+            - family-id
+            - op
+        reply:
+          value: 10
+          attributes:
+            - family-id
+            - op-policy
+            - policy
diff --git a/source/specs/ovs_datapath.yaml b/source/specs/ovs_datapath.yaml
new file mode 100644
index 000000000000..edc8c95ca6f5
--- /dev/null
+++ b/source/specs/ovs_datapath.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: ovs_datapath
+version: 2
+protocol: genetlink-legacy
+uapi-header: linux/openvswitch.h
+
+doc:
+  OVS datapath configuration over generic netlink.
+
+definitions:
+  -
+    name: ovs-header
+    type: struct
+    members:
+      -
+        name: dp-ifindex
+        type: u32
+  -
+    name: user-features
+    type: flags
+    name-prefix: ovs-dp-f-
+    enum-name:
+    entries:
+      -
+        name: unaligned
+        doc: Allow last Netlink attribute to be unaligned
+      -
+        name: vport-pids
+        doc: Allow datapath to associate multiple Netlink PIDs to each vpo=
rt
+      -
+        name: tc-recirc-sharing
+        doc: Allow tc offload recirc sharing
+      -
+        name: dispatch-upcall-per-cpu
+        doc: Allow per-cpu dispatch of upcalls
+  -
+    name: datapath-stats
+    enum-name: ovs-dp-stats
+    type: struct
+    members:
+      -
+        name: n-hit
+        type: u64
+      -
+        name: n-missed
+        type: u64
+      -
+        name: n-lost
+        type: u64
+      -
+        name: n-flows
+        type: u64
+  -
+    name: megaflow-stats
+    enum-name: ovs-dp-megaflow-stats
+    type: struct
+    members:
+      -
+        name: n-mask-hit
+        type: u64
+      -
+        name: n-masks
+        type: u32
+      -
+        name: padding
+        type: u32
+      -
+        name: n-cache-hit
+        type: u64
+      -
+        name: pad1
+        type: u64
+
+attribute-sets:
+  -
+    name: datapath
+    name-prefix: ovs-dp-attr-
+    enum-name: ovs-datapath-attrs
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: upcall-pid
+        doc: upcall pid
+        type: u32
+      -
+        name: stats
+        type: binary
+        struct: datapath-stats
+      -
+        name: megaflow-stats
+        type: binary
+        struct: megaflow-stats
+      -
+        name: user-features
+        type: u32
+        enum: user-features
+        enum-as-flags: true
+      -
+        name: pad
+        type: unused
+      -
+        name: masks-cache-size
+        type: u32
+      -
+        name: per-cpu-pids
+        type: binary
+        sub-type: u32
+      -
+        name: ifindex
+        type: u32
+
+operations:
+  fixed-header: ovs-header
+  name-prefix: ovs-dp-cmd-
+  list:
+    -
+      name: get
+      doc: Get / dump OVS data path configuration and state
+      value: 3
+      attribute-set: datapath
+      do: &dp-get-op
+        request:
+          attributes:
+            - name
+        reply:
+          attributes:
+            - name
+            - upcall-pid
+            - stats
+            - megaflow-stats
+            - user-features
+            - masks-cache-size
+            - per-cpu-pids
+      dump: *dp-get-op
+    -
+      name: new
+      doc: Create new OVS data path
+      value: 1
+      attribute-set: datapath
+      do:
+        request:
+          attributes:
+            - name
+            - upcall-pid
+            - user-features
+    -
+      name: del
+      doc: Delete existing OVS data path
+      value: 2
+      attribute-set: datapath
+      do:
+        request:
+          attributes:
+            - name
+
+mcast-groups:
+  list:
+    -
+      name: ovs_datapath
diff --git a/source/specs/ovs_flow.yaml b/source/specs/ovs_flow.yaml
new file mode 100644
index 000000000000..46f5d1cd8a5f
--- /dev/null
+++ b/source/specs/ovs_flow.yaml
@@ -0,0 +1,998 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: ovs_flow
+version: 1
+protocol: genetlink-legacy
+uapi-header: linux/openvswitch.h
+
+doc:
+  OVS flow configuration over generic netlink.
+
+definitions:
+  -
+    name: ovs-header
+    type: struct
+    doc: |
+      Header for OVS Generic Netlink messages.
+    members:
+      -
+        name: dp-ifindex
+        type: u32
+        doc: |
+          ifindex of local port for datapath (0 to make a request not spec=
ific
+          to a datapath).
+  -
+    name: ovs-flow-stats
+    type: struct
+    members:
+      -
+        name: n-packets
+        type: u64
+        doc: Number of matched packets.
+      -
+        name: n-bytes
+        type: u64
+        doc: Number of matched bytes.
+  -
+    name: ovs-key-ethernet
+    type: struct
+    members:
+      -
+        name: eth-src
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: eth-dst
+        type: binary
+        len: 6
+        display-hint: mac
+  -
+    name: ovs-key-mpls
+    type: struct
+    members:
+      -
+        name: mpls-lse
+        type: u32
+        byte-order: big-endian
+  -
+    name: ovs-key-ipv4
+    type: struct
+    members:
+      -
+        name: ipv4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: ipv4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: ipv4-proto
+        type: u8
+      -
+        name: ipv4-tos
+        type: u8
+      -
+        name: ipv4-ttl
+        type: u8
+      -
+        name: ipv4-frag
+        type: u8
+        enum: ovs-frag-type
+  -
+    name: ovs-key-ipv6
+    type: struct
+    members:
+      -
+        name: ipv6-src
+        type: binary
+        len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: ipv6-dst
+        type: binary
+        len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: ipv6-label
+        type: u32
+        byte-order: big-endian
+      -
+        name: ipv6-proto
+        type: u8
+      -
+        name: ipv6-tclass
+        type: u8
+      -
+        name: ipv6-hlimit
+        type: u8
+      -
+        name: ipv6-frag
+        type: u8
+  -
+    name: ovs-key-ipv6-exthdrs
+    type: struct
+    members:
+      -
+        name: hdrs
+        type: u16
+  -
+    name: ovs-frag-type
+    name-prefix: ovs-frag-type-
+    enum-name: ovs-frag-type
+    type: enum
+    entries:
+      -
+        name: none
+        doc: Packet is not a fragment.
+      -
+        name: first
+        doc: Packet is a fragment with offset 0.
+      -
+        name: later
+        doc: Packet is a fragment with nonzero offset.
+      -
+        name: any
+        value: 255
+  -
+    name: ovs-key-tcp
+    type: struct
+    members:
+      -
+        name: tcp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: tcp-dst
+        type: u16
+        byte-order: big-endian
+  -
+    name: ovs-key-udp
+    type: struct
+    members:
+      -
+        name: udp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: udp-dst
+        type: u16
+        byte-order: big-endian
+  -
+    name: ovs-key-sctp
+    type: struct
+    members:
+      -
+        name: sctp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: sctp-dst
+        type: u16
+        byte-order: big-endian
+  -
+    name: ovs-key-icmp
+    type: struct
+    members:
+      -
+        name: icmp-type
+        type: u8
+      -
+        name: icmp-code
+        type: u8
+  -
+    name: ovs-key-arp
+    type: struct
+    members:
+      -
+        name: arp-sip
+        type: u32
+        byte-order: big-endian
+      -
+        name: arp-tip
+        type: u32
+        byte-order: big-endian
+      -
+        name: arp-op
+        type: u16
+        byte-order: big-endian
+      -
+        name: arp-sha
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: arp-tha
+        type: binary
+        len: 6
+        display-hint: mac
+  -
+    name: ovs-key-nd
+    type: struct
+    members:
+      -
+        name: nd_target
+        type: binary
+        len: 16
+        byte-order: big-endian
+      -
+        name: nd-sll
+        type: binary
+        len: 6
+        display-hint: mac
+      -
+        name: nd-tll
+        type: binary
+        len: 6
+        display-hint: mac
+  -
+    name: ovs-key-ct-tuple-ipv4
+    type: struct
+    members:
+      -
+        name: ipv4-src
+        type: u32
+        byte-order: big-endian
+      -
+        name: ipv4-dst
+        type: u32
+        byte-order: big-endian
+      -
+        name: src-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: dst-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: ipv4-proto
+        type: u8
+  -
+    name: ovs-action-push-vlan
+    type: struct
+    members:
+      -
+        name: vlan_tpid
+        type: u16
+        byte-order: big-endian
+        doc: Tag protocol identifier (TPID) to push.
+      -
+        name: vlan_tci
+        type: u16
+        byte-order: big-endian
+        doc: Tag control identifier (TCI) to push.
+  -
+    name: ovs-ufid-flags
+    name-prefix: ovs-ufid-f-
+    enum-name:
+    type: flags
+    entries:
+      - omit-key
+      - omit-mask
+      - omit-actions
+  -
+    name: ovs-action-hash
+    type: struct
+    members:
+      -
+        name: hash-alg
+        type: u32
+        doc: Algorithm used to compute hash prior to recirculation.
+      -
+        name: hash-basis
+        type: u32
+        doc: Basis used for computing hash.
+  -
+    name: ovs-hash-alg
+    enum-name: ovs-hash-alg
+    type: enum
+    doc: |
+      Data path hash algorithm for computing Datapath hash. The algorithm =
type only specifies
+      the fields in a flow will be used as part of the hash. Each datapath=
 is free to use its
+      own hash algorithm. The hash value will be opaque to the user space =
daemon.
+    entries:
+      - ovs-hash-alg-l4
+
+  -
+    name: ovs-action-push-mpls
+    type: struct
+    members:
+      -
+        name: mpls-lse
+        type: u32
+        byte-order: big-endian
+        doc: |
+          MPLS label stack entry to push
+      -
+        name: mpls-ethertype
+        type: u32
+        byte-order: big-endian
+        doc: |
+          Ethertype to set in the encapsulating ethernet frame.  The only =
values
+          ethertype should ever be given are ETH_P_MPLS_UC and ETH_P_MPLS_=
MC,
+          indicating MPLS unicast or multicast. Other are rejected.
+  -
+    name: ovs-action-add-mpls
+    type: struct
+    members:
+      -
+        name: mpls-lse
+        type: u32
+        byte-order: big-endian
+        doc: |
+          MPLS label stack entry to push
+      -
+        name: mpls-ethertype
+        type: u32
+        byte-order: big-endian
+        doc: |
+          Ethertype to set in the encapsulating ethernet frame.  The only =
values
+          ethertype should ever be given are ETH_P_MPLS_UC and ETH_P_MPLS_=
MC,
+          indicating MPLS unicast or multicast. Other are rejected.
+      -
+        name: tun-flags
+        type: u16
+        doc: |
+          MPLS tunnel attributes.
+  -
+    name: ct-state-flags
+    enum-name:
+    type: flags
+    name-prefix: ovs-cs-f-
+    entries:
+      -
+        name: new
+        doc: Beginning of a new connection.
+      -
+        name: established
+        doc: Part of an existing connenction
+      -
+        name: related
+        doc: Related to an existing connection.
+      -
+        name: reply-dir
+        doc: Flow is in the reply direction.
+      -
+        name: invalid
+        doc: Could not track the connection.
+      -
+        name: tracked
+        doc: Conntrack has occurred.
+      -
+        name: src-nat
+        doc: Packet's source address/port was mangled by NAT.
+      -
+        name: dst-nat
+        doc: Packet's destination address/port was mangled by NAT.
+
+attribute-sets:
+  -
+    name: flow-attrs
+    enum-name: ovs-flow-attr
+    name-prefix: ovs-flow-attr-
+    attributes:
+      -
+        name: key
+        type: nest
+        nested-attributes: key-attrs
+        doc: |
+          Nested attributes specifying the flow key. Always present in
+          notifications. Required for all requests (except dumps).
+      -
+        name: actions
+        type: nest
+        nested-attributes: action-attrs
+        doc: |
+          Nested attributes specifying the actions to take for packets that
+          match the key. Always present in notifications. Required for
+          OVS_FLOW_CMD_NEW requests, optional for OVS_FLOW_CMD_SET request=
s.  An
+          OVS_FLOW_CMD_SET without OVS_FLOW_ATTR_ACTIONS will not modify t=
he
+          actions.  To clear the actions, an OVS_FLOW_ATTR_ACTIONS without=
 any
+          nested attributes must be given.
+      -
+        name: stats
+        type: binary
+        struct: ovs-flow-stats
+        doc: |
+          Statistics for this flow. Present in notifications if the stats =
would
+          be nonzero. Ignored in requests.
+      -
+        name: tcp-flags
+        type: u8
+        doc: |
+          An 8-bit value giving the ORed value of all of the TCP flags see=
n on
+          packets in this flow. Only present in notifications for TCP flow=
s, and
+          only if it would be nonzero. Ignored in requests.
+      -
+        name: used
+        type: u64
+        doc: |
+          A 64-bit integer giving the time, in milliseconds on the system
+          monotonic clock, at which a packet was last processed for this
+          flow. Only present in notifications if a packet has been process=
ed for
+          this flow. Ignored in requests.
+      -
+        name: clear
+        type: flag
+        doc: |
+          If present in a OVS_FLOW_CMD_SET request, clears the last-used t=
ime,
+          accumulated TCP flags, and statistics for this flow.  Otherwise
+          ignored in requests. Never present in notifications.
+      -
+        name: mask
+        type: nest
+        nested-attributes: key-attrs
+        doc: |
+          Nested attributes specifying the mask bits for wildcarded flow
+          match. Mask bit value '1' specifies exact match with correspondi=
ng
+          flow key bit, while mask bit value '0' specifies a wildcarded
+          match. Omitting attribute is treated as wildcarding all correspo=
nding
+          fields. Optional for all requests. If not present, all flow key =
bits
+          are exact match bits.
+      -
+        name: probe
+        type: binary
+        doc: |
+          Flow operation is a feature probe, error logging should be suppr=
essed.
+      -
+        name: ufid
+        type: binary
+        doc: |
+          A value between 1-16 octets specifying a unique identifier for t=
he
+          flow. Causes the flow to be indexed by this value rather than the
+          value of the OVS_FLOW_ATTR_KEY attribute. Optional for all
+          requests. Present in notifications if the flow was created with =
this
+          attribute.
+        display-hint: uuid
+      -
+        name: ufid-flags
+        type: u32
+        enum: ovs-ufid-flags
+        doc: |
+          A 32-bit value of ORed flags that provide alternative semantics =
for
+          flow installation and retrieval. Optional for all requests.
+      -
+        name: pad
+        type: binary
+
+  -
+    name: key-attrs
+    enum-name: ovs-key-attr
+    name-prefix: ovs-key-attr-
+    attributes:
+      -
+        name: encap
+        type: nest
+        nested-attributes: key-attrs
+      -
+        name: priority
+        type: u32
+      -
+        name: in-port
+        type: u32
+      -
+        name: ethernet
+        type: binary
+        struct: ovs-key-ethernet
+        doc: struct ovs_key_ethernet
+      -
+        name: vlan
+        type: u16
+        byte-order: big-endian
+      -
+        name: ethertype
+        type: u16
+        byte-order: big-endian
+      -
+        name: ipv4
+        type: binary
+        struct: ovs-key-ipv4
+      -
+        name: ipv6
+        type: binary
+        struct: ovs-key-ipv6
+        doc: struct ovs_key_ipv6
+      -
+        name: tcp
+        type: binary
+        struct: ovs-key-tcp
+      -
+        name: udp
+        type: binary
+        struct: ovs-key-udp
+      -
+        name: icmp
+        type: binary
+        struct: ovs-key-icmp
+      -
+        name: icmpv6
+        type: binary
+        struct: ovs-key-icmp
+      -
+        name: arp
+        type: binary
+        struct: ovs-key-arp
+        doc: struct ovs_key_arp
+      -
+        name: nd
+        type: binary
+        struct: ovs-key-nd
+        doc: struct ovs_key_nd
+      -
+        name: skb-mark
+        type: u32
+      -
+        name: tunnel
+        type: nest
+        nested-attributes: tunnel-key-attrs
+      -
+        name: sctp
+        type: binary
+        struct: ovs-key-sctp
+      -
+        name: tcp-flags
+        type: u16
+        byte-order: big-endian
+      -
+        name: dp-hash
+        type: u32
+        doc: Value 0 indicates the hash is not computed by the datapath.
+      -
+        name: recirc-id
+        type: u32
+      -
+        name: mpls
+        type: binary
+        struct: ovs-key-mpls
+      -
+        name: ct-state
+        type: u32
+        enum: ct-state-flags
+        enum-as-flags: true
+      -
+        name: ct-zone
+        type: u16
+        doc: connection tracking zone
+      -
+        name: ct-mark
+        type: u32
+        doc: connection tracking mark
+      -
+        name: ct-labels
+        type: binary
+        display-hint: hex
+        doc: 16-octet connection tracking label
+      -
+        name: ct-orig-tuple-ipv4
+        type: binary
+        struct: ovs-key-ct-tuple-ipv4
+      -
+        name: ct-orig-tuple-ipv6
+        type: binary
+        doc: struct ovs_key_ct_tuple_ipv6
+      -
+        name: nsh
+        type: nest
+        nested-attributes: ovs-nsh-key-attrs
+      -
+        name: packet-type
+        type: u32
+        byte-order: big-endian
+        doc: Should not be sent to the kernel
+      -
+        name: nd-extensions
+        type: binary
+        doc: Should not be sent to the kernel
+      -
+        name: tunnel-info
+        type: binary
+        doc: struct ip_tunnel_info
+      -
+        name: ipv6-exthdrs
+        type: binary
+        struct: ovs-key-ipv6-exthdrs
+        doc: struct ovs_key_ipv6_exthdr
+  -
+    name: action-attrs
+    enum-name: ovs-action-attr
+    name-prefix: ovs-action-attr-
+    attributes:
+      -
+        name: output
+        type: u32
+        doc: ovs port number in datapath
+      -
+        name: userspace
+        type: nest
+        nested-attributes: userspace-attrs
+      -
+        name: set
+        type: nest
+        nested-attributes: key-attrs
+        doc: Replaces the contents of an existing header. The single neste=
d attribute specifies a header to modify and its value.
+      -
+        name: push-vlan
+        type: binary
+        struct: ovs-action-push-vlan
+        doc: Push a new outermost 802.1Q or 802.1ad header onto the packet.
+      -
+        name: pop-vlan
+        type: flag
+        doc: Pop the outermost 802.1Q or 802.1ad header from the packet.
+      -
+        name: sample
+        type: nest
+        nested-attributes: sample-attrs
+        doc: |
+          Probabilistically executes actions, as specified in the nested a=
ttributes.
+      -
+        name: recirc
+        type: u32
+        doc: recirc id
+      -
+        name: hash
+        type: binary
+        struct: ovs-action-hash
+      -
+        name: push-mpls
+        type: binary
+        struct: ovs-action-push-mpls
+        doc: |
+          Push a new MPLS label stack entry onto the top of the packets MP=
LS
+          label stack. Set the ethertype of the encapsulating frame to eit=
her
+          ETH_P_MPLS_UC or ETH_P_MPLS_MC to indicate the new packet conten=
ts.
+      -
+        name: pop-mpls
+        type: u16
+        byte-order: big-endian
+        doc: ethertype
+      -
+        name: set-masked
+        type: nest
+        nested-attributes: key-attrs
+        doc: |
+          Replaces the contents of an existing header. A nested attribute
+          specifies a header to modify, its value, and a mask. For every b=
it set
+          in the mask, the corresponding bit value is copied from the valu=
e to
+          the packet header field, rest of the bits are left unchanged. The
+          non-masked value bits must be passed in as zeroes. Masking is not
+          supported for the OVS_KEY_ATTR_TUNNEL attribute.
+      -
+        name: ct
+        type: nest
+        nested-attributes: ct-attrs
+        doc: |
+          Track the connection. Populate the conntrack-related entries
+          in the flow key.
+      -
+        name: trunc
+        type: u32
+        doc: struct ovs_action_trunc is a u32 max length
+      -
+        name: push-eth
+        type: binary
+        doc: struct ovs_action_push_eth
+      -
+        name: pop-eth
+        type: flag
+      -
+        name: ct-clear
+        type: flag
+      -
+        name: push-nsh
+        type: nest
+        nested-attributes: ovs-nsh-key-attrs
+        doc: |
+          Push NSH header to the packet.
+      -
+        name: pop-nsh
+        type: flag
+        doc: |
+          Pop the outermost NSH header off the packet.
+      -
+        name: meter
+        type: u32
+        doc: |
+          Run packet through a meter, which may drop the packet, or modify=
 the
+          packet (e.g., change the DSCP field)
+      -
+        name: clone
+        type: nest
+        nested-attributes: action-attrs
+        doc: |
+          Make a copy of the packet and execute a list of actions without
+          affecting the original packet and key.
+      -
+        name: check-pkt-len
+        type: nest
+        nested-attributes: check-pkt-len-attrs
+        doc: |
+          Check the packet length and execute a set of actions if greater =
than
+          the specified packet length, else execute another set of actions.
+      -
+        name: add-mpls
+        type: binary
+        struct: ovs-action-add-mpls
+        doc: |
+          Push a new MPLS label stack entry at the start of the packet or =
at the
+          start of the l3 header depending on the value of l3 tunnel flag =
in the
+          tun_flags field of this OVS_ACTION_ATTR_ADD_MPLS argument.
+      -
+        name: dec-ttl
+        type: nest
+        nested-attributes: dec-ttl-attrs
+      -
+        name: psample
+        type: nest
+        nested-attributes: psample-attrs
+        doc: |
+          Sends a packet sample to psample for external observation.
+  -
+    name: tunnel-key-attrs
+    enum-name: ovs-tunnel-key-attr
+    name-prefix: ovs-tunnel-key-attr-
+    attributes:
+      -
+        name: id
+        type: u64
+        byte-order: big-endian
+        value: 0
+      -
+        name: ipv4-src
+        type: u32
+        byte-order: big-endian
+      -
+        name: ipv4-dst
+        type: u32
+        byte-order: big-endian
+      -
+        name: tos
+        type: u8
+      -
+        name: ttl
+        type: u8
+      -
+        name: dont-fragment
+        type: flag
+      -
+        name: csum
+        type: flag
+      -
+        name: oam
+        type: flag
+      -
+        name: geneve-opts
+        type: binary
+        sub-type: u32
+      -
+        name: tp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: tp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: vxlan-opts
+        type: nest
+        nested-attributes: vxlan-ext-attrs
+      -
+        name: ipv6-src
+        type: binary
+        doc: |
+          struct in6_addr source IPv6 address
+      -
+        name: ipv6-dst
+        type: binary
+        doc: |
+          struct in6_addr destination IPv6 address
+      -
+        name: pad
+        type: binary
+      -
+        name: erspan-opts
+        type: binary
+        doc: |
+          struct erspan_metadata
+      -
+        name: ipv4-info-bridge
+        type: flag
+  -
+    name: check-pkt-len-attrs
+    enum-name: ovs-check-pkt-len-attr
+    name-prefix: ovs-check-pkt-len-attr-
+    attributes:
+      -
+        name: pkt-len
+        type: u16
+      -
+        name: actions-if-greater
+        type: nest
+        nested-attributes: action-attrs
+      -
+        name: actions-if-less-equal
+        type: nest
+        nested-attributes: action-attrs
+  -
+    name: sample-attrs
+    enum-name: ovs-sample-attr
+    name-prefix: ovs-sample-attr-
+    attributes:
+      -
+        name: probability
+        type: u32
+      -
+        name: actions
+        type: nest
+        nested-attributes: action-attrs
+  -
+    name: userspace-attrs
+    enum-name: ovs-userspace-attr
+    name-prefix: ovs-userspace-attr-
+    attributes:
+      -
+        name: pid
+        type: u32
+      -
+        name: userdata
+        type: binary
+      -
+        name: egress-tun-port
+        type: u32
+      -
+        name: actions
+        type: flag
+  -
+    name: ovs-nsh-key-attrs
+    enum-name: ovs-nsh-key-attr
+    name-prefix: ovs-nsh-key-attr-
+    attributes:
+      -
+        name: base
+        type: binary
+      -
+        name: md1
+        type: binary
+      -
+        name: md2
+        type: binary
+  -
+    name: ct-attrs
+    enum-name: ovs-ct-attr
+    name-prefix: ovs-ct-attr-
+    attributes:
+      -
+        name: commit
+        type: flag
+      -
+        name: zone
+        type: u16
+      -
+        name: mark
+        type: binary
+      -
+        name: labels
+        type: binary
+      -
+        name: helper
+        type: string
+      -
+        name: nat
+        type: nest
+        nested-attributes: nat-attrs
+      -
+        name: force-commit
+        type: flag
+      -
+        name: eventmask
+        type: u32
+      -
+        name: timeout
+        type: string
+  -
+    name: nat-attrs
+    enum-name: ovs-nat-attr
+    name-prefix: ovs-nat-attr-
+    attributes:
+      -
+        name: src
+        type: flag
+      -
+        name: dst
+        type: flag
+      -
+        name: ip-min
+        type: binary
+      -
+        name: ip-max
+        type: binary
+      -
+        name: proto-min
+        type: u16
+      -
+        name: proto-max
+        type: u16
+      -
+        name: persistent
+        type: flag
+      -
+        name: proto-hash
+        type: flag
+      -
+        name: proto-random
+        type: flag
+  -
+    name: dec-ttl-attrs
+    enum-name: ovs-dec-ttl-attr
+    name-prefix: ovs-dec-ttl-attr-
+    attributes:
+      -
+        name: action
+        type: nest
+        nested-attributes: action-attrs
+  -
+    name: vxlan-ext-attrs
+    enum-name: ovs-vxlan-ext-
+    name-prefix: ovs-vxlan-ext-
+    attributes:
+      -
+        name: gbp
+        type: u32
+  -
+    name: psample-attrs
+    enum-name: ovs-psample-attr
+    name-prefix: ovs-psample-attr-
+    attributes:
+      -
+        name: group
+        type: u32
+      -
+        name: cookie
+        type: binary
+
+operations:
+  name-prefix: ovs-flow-cmd-
+  fixed-header: ovs-header
+  list:
+    -
+      name: get
+      doc: Get / dump OVS flow configuration and state
+      value: 3
+      attribute-set: flow-attrs
+      do: &flow-get-op
+        request:
+          attributes:
+            - key
+            - ufid
+            - ufid-flags
+        reply:
+          attributes:
+            - key
+            - ufid
+            - mask
+            - stats
+            - actions
+      dump: *flow-get-op
+    -
+      name: new
+      doc: Create OVS flow configuration in a data path
+      value: 1
+      attribute-set: flow-attrs
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - mask
+            - actions
+
+mcast-groups:
+  list:
+    -
+      name: ovs_flow
diff --git a/source/specs/ovs_vport.yaml b/source/specs/ovs_vport.yaml
new file mode 100644
index 000000000000..86ba9ac2a521
--- /dev/null
+++ b/source/specs/ovs_vport.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: ovs_vport
+version: 2
+protocol: genetlink-legacy
+uapi-header: linux/openvswitch.h
+
+doc:
+  OVS vport configuration over generic netlink.
+
+definitions:
+  -
+    name: ovs-header
+    type: struct
+    members:
+      -
+        name: dp-ifindex
+        type: u32
+  -
+    name: vport-type
+    type: enum
+    enum-name: ovs-vport-type
+    name-prefix: ovs-vport-type-
+    entries: [ unspec, netdev, internal, gre, vxlan, geneve ]
+  -
+    name: vport-stats
+    type: struct
+    enum-name: ovs-vport-stats
+    members:
+      -
+        name: rx-packets
+        type: u64
+      -
+        name: tx-packets
+        type: u64
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: rx-errors
+        type: u64
+      -
+        name: tx-errors
+        type: u64
+      -
+        name: rx-dropped
+        type: u64
+      -
+        name: tx-dropped
+        type: u64
+
+attribute-sets:
+  -
+    name: vport-options
+    enum-name: ovs-vport-options
+    name-prefix: ovs-tunnel-attr-
+    attributes:
+      -
+        name: dst-port
+        type: u32
+      -
+        name: extension
+        type: u32
+  -
+    name: upcall-stats
+    enum-name: ovs-vport-upcall-attr
+    name-prefix: ovs-vport-upcall-attr-
+    attributes:
+      -
+        name: success
+        type: u64
+        value: 0
+      -
+        name: fail
+        type: u64
+  -
+    name: vport
+    name-prefix: ovs-vport-attr-
+    enum-name: ovs-vport-attr
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: port-no
+        type: u32
+      -
+        name: type
+        type: u32
+        enum: vport-type
+      -
+        name: name
+        type: string
+      -
+        name: options
+        type: nest
+        nested-attributes: vport-options
+      -
+        name: upcall-pid
+        type: binary
+        sub-type: u32
+      -
+        name: stats
+        type: binary
+        struct: vport-stats
+      -
+        name: pad
+        type: unused
+      -
+        name: ifindex
+        type: u32
+      -
+        name: netnsid
+        type: u32
+      -
+        name: upcall-stats
+        type: nest
+        nested-attributes: upcall-stats
+
+operations:
+  name-prefix: ovs-vport-cmd-
+  list:
+    -
+      name: new
+      doc: Create a new OVS vport
+      attribute-set: vport
+      fixed-header: ovs-header
+      do:
+        request:
+          attributes:
+            - name
+            - type
+            - upcall-pid
+            - ifindex
+            - options
+    -
+      name: del
+      doc: Delete existing OVS vport from a data path
+      attribute-set: vport
+      fixed-header: ovs-header
+      do:
+        request:
+          attributes:
+            - port-no
+            - type
+            - name
+    -
+      name: get
+      doc: Get / dump OVS vport configuration and state
+      attribute-set: vport
+      fixed-header: ovs-header
+      do: &vport-get-op
+        request:
+          attributes:
+            - name
+        reply: &dev-all
+          attributes:
+            - port-no
+            - type
+            - name
+            - upcall-pid
+            - stats
+            - ifindex
+            - netnsid
+            - upcall-stats
+      dump: *vport-get-op
+
+mcast-groups:
+  list:
+    -
+      name: ovs_vport
diff --git a/source/specs/rt_addr.yaml b/source/specs/rt_addr.yaml
new file mode 100644
index 000000000000..df6b23f06a22
--- /dev/null
+++ b/source/specs/rt_addr.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: rt-addr
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Address configuration over rtnetlink.
+
+definitions:
+  -
+    name: ifaddrmsg
+    type: struct
+    members:
+      -
+        name: ifa-family
+        type: u8
+      -
+        name: ifa-prefixlen
+        type: u8
+      -
+        name: ifa-flags
+        type: u8
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: ifa-scope
+        type: u8
+      -
+        name: ifa-index
+        type: u32
+  -
+    name: ifa-cacheinfo
+    type: struct
+    members:
+      -
+        name: ifa-prefered
+        type: u32
+      -
+        name: ifa-valid
+        type: u32
+      -
+        name: cstamp
+        type: u32
+      -
+        name: tstamp
+        type: u32
+
+  -
+    name: ifa-flags
+    type: flags
+    entries:
+      -
+        name: secondary
+      -
+        name: nodad
+      -
+        name: optimistic
+      -
+        name: dadfailed
+      -
+        name: homeaddress
+      -
+        name: deprecated
+      -
+        name: tentative
+      -
+        name: permanent
+      -
+        name: managetempaddr
+      -
+        name: noprefixroute
+      -
+        name: mcautojoin
+      -
+        name: stable-privacy
+
+attribute-sets:
+  -
+    name: addr-attrs
+    name-prefix: ifa-
+    attributes:
+      -
+        name: address
+        type: binary
+        display-hint: ipv4
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: label
+        type: string
+      -
+        name: broadcast
+        type: binary
+        display-hint: ipv4
+      -
+        name: anycast
+        type: binary
+      -
+        name: cacheinfo
+        type: binary
+        struct: ifa-cacheinfo
+      -
+        name: multicast
+        type: binary
+      -
+        name: flags
+        type: u32
+        enum: ifa-flags
+        enum-as-flags: true
+      -
+        name: rt-priority
+        type: u32
+      -
+        name: target-netnsid
+        type: binary
+      -
+        name: proto
+        type: u8
+
+
+operations:
+  fixed-header: ifaddrmsg
+  enum-model: directional
+  list:
+    -
+      name: newaddr
+      doc: Add new address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 20
+          attributes: &ifaddr-all
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - address
+            - label
+            - local
+            - cacheinfo
+    -
+      name: deladdr
+      doc: Remove address
+      attribute-set: addr-attrs
+      do:
+        request:
+          value: 21
+          attributes:
+            - ifa-family
+            - ifa-flags
+            - ifa-prefixlen
+            - ifa-scope
+            - ifa-index
+            - address
+            - local
+    -
+      name: getaddr
+      doc: Dump address information.
+      attribute-set: addr-attrs
+      dump:
+        request:
+          value: 22
+          attributes:
+            - ifa-index
+        reply:
+          value: 20
+          attributes: *ifaddr-all
+    -
+      name: getmulticast
+      doc: Get / dump IPv4/IPv6 multicast addresses.
+      attribute-set: addr-attrs
+      fixed-header: ifaddrmsg
+      do:
+        request:
+          value: 58
+          attributes:
+            - ifa-family
+            - ifa-index
+        reply:
+          value: 58
+          attributes: &mcaddr-attrs
+            - multicast
+            - cacheinfo
+      dump:
+        request:
+          value: 58
+          attributes:
+            - ifa-family
+        reply:
+          value: 58
+          attributes: *mcaddr-attrs
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-ifaddr
+      value: 5
+    -
+      name: rtnlgrp-ipv6-ifaddr
+      value: 9
diff --git a/source/specs/rt_link.yaml b/source/specs/rt_link.yaml
new file mode 100644
index 000000000000..31238455f8e9
--- /dev/null
+++ b/source/specs/rt_link.yaml
@@ -0,0 +1,2523 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: rt-link
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Link configuration over rtnetlink.
+
+definitions:
+  -
+    name: ifinfo-flags
+    type: flags
+    entries:
+      -
+        name: up
+      -
+        name: broadcast
+      -
+        name: debug
+      -
+        name: loopback
+      -
+        name: point-to-point
+      -
+        name: no-trailers
+      -
+        name: running
+      -
+        name: no-arp
+      -
+        name: promisc
+      -
+        name: all-multi
+      -
+        name: master
+      -
+        name: slave
+      -
+        name: multicast
+      -
+        name: portsel
+      -
+        name: auto-media
+      -
+        name: dynamic
+      -
+        name: lower-up
+      -
+        name: dormant
+      -
+        name: echo
+  -
+    name: vlan-protocols
+    type: enum
+    entries:
+      -
+        name: 8021q
+        value: 33024
+      -
+        name: 8021ad
+        value: 34984
+  -
+    name: rtgenmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+  -
+    name: ifinfomsg
+    type: struct
+    members:
+      -
+        name: ifi-family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 1
+      -
+        name: ifi-type
+        type: u16
+      -
+        name: ifi-index
+        type: s32
+      -
+        name: ifi-flags
+        type: u32
+        enum: ifinfo-flags
+        enum-as-flags: true
+      -
+        name: ifi-change
+        type: u32
+  -
+    name: ifla-bridge-id
+    type: struct
+    members:
+      -
+        name: prio
+        type: u16
+      -
+        name: addr
+        type: binary
+        len: 6
+        display-hint: mac
+  -
+    name: ifla-cacheinfo
+    type: struct
+    members:
+      -
+        name: max-reasm-len
+        type: u32
+      -
+        name: tstamp
+        type: u32
+      -
+        name: reachable-time
+        type: s32
+      -
+        name: retrans-time
+        type: u32
+  -
+    name: rtnl-link-stats
+    type: struct
+    members:
+      -
+        name: rx-packets
+        type: u32
+      -
+        name: tx-packets
+        type: u32
+      -
+        name: rx-bytes
+        type: u32
+      -
+        name: tx-bytes
+        type: u32
+      -
+        name: rx-errors
+        type: u32
+      -
+        name: tx-errors
+        type: u32
+      -
+        name: rx-dropped
+        type: u32
+      -
+        name: tx-dropped
+        type: u32
+      -
+        name: multicast
+        type: u32
+      -
+        name: collisions
+        type: u32
+      -
+        name: rx-length-errors
+        type: u32
+      -
+        name: rx-over-errors
+        type: u32
+      -
+        name: rx-crc-errors
+        type: u32
+      -
+        name: rx-frame-errors
+        type: u32
+      -
+        name: rx-fifo-errors
+        type: u32
+      -
+        name: rx-missed-errors
+        type: u32
+      -
+        name: tx-aborted-errors
+        type: u32
+      -
+        name: tx-carrier-errors
+        type: u32
+      -
+        name: tx-fifo-errors
+        type: u32
+      -
+        name: tx-heartbeat-errors
+        type: u32
+      -
+        name: tx-window-errors
+        type: u32
+      -
+        name: rx-compressed
+        type: u32
+      -
+        name: tx-compressed
+        type: u32
+      -
+        name: rx-nohandler
+        type: u32
+  -
+    name: rtnl-link-stats64
+    type: struct
+    members:
+      -
+        name: rx-packets
+        type: u64
+      -
+        name: tx-packets
+        type: u64
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: rx-errors
+        type: u64
+      -
+        name: tx-errors
+        type: u64
+      -
+        name: rx-dropped
+        type: u64
+      -
+        name: tx-dropped
+        type: u64
+      -
+        name: multicast
+        type: u64
+      -
+        name: collisions
+        type: u64
+      -
+        name: rx-length-errors
+        type: u64
+      -
+        name: rx-over-errors
+        type: u64
+      -
+        name: rx-crc-errors
+        type: u64
+      -
+        name: rx-frame-errors
+        type: u64
+      -
+        name: rx-fifo-errors
+        type: u64
+      -
+        name: rx-missed-errors
+        type: u64
+      -
+        name: tx-aborted-errors
+        type: u64
+      -
+        name: tx-carrier-errors
+        type: u64
+      -
+        name: tx-fifo-errors
+        type: u64
+      -
+        name: tx-heartbeat-errors
+        type: u64
+      -
+        name: tx-window-errors
+        type: u64
+      -
+        name: rx-compressed
+        type: u64
+      -
+        name: tx-compressed
+        type: u64
+      -
+        name: rx-nohandler
+        type: u64
+      -
+        name: rx-otherhost-dropped
+        type: u64
+  -
+    name: rtnl-link-ifmap
+    type: struct
+    members:
+      -
+        name: mem-start
+        type: u64
+      -
+        name: mem-end
+        type: u64
+      -
+        name: base-addr
+        type: u64
+      -
+        name: irq
+        type: u16
+      -
+        name: dma
+        type: u8
+      -
+        name: port
+        type: u8
+  -
+    name: ipv4-devconf
+    type: struct
+    members:
+      -
+        name: forwarding
+        type: u32
+      -
+        name: mc-forwarding
+        type: u32
+      -
+        name: proxy-arp
+        type: u32
+      -
+        name: accept-redirects
+        type: u32
+      -
+        name: secure-redirects
+        type: u32
+      -
+        name: send-redirects
+        type: u32
+      -
+        name: shared-media
+        type: u32
+      -
+        name: rp-filter
+        type: u32
+      -
+        name: accept-source-route
+        type: u32
+      -
+        name: bootp-relay
+        type: u32
+      -
+        name: log-martians
+        type: u32
+      -
+        name: tag
+        type: u32
+      -
+        name: arpfilter
+        type: u32
+      -
+        name: medium-id
+        type: u32
+      -
+        name: noxfrm
+        type: u32
+      -
+        name: nopolicy
+        type: u32
+      -
+        name: force-igmp-version
+        type: u32
+      -
+        name: arp-announce
+        type: u32
+      -
+        name: arp-ignore
+        type: u32
+      -
+        name: promote-secondaries
+        type: u32
+      -
+        name: arp-accept
+        type: u32
+      -
+        name: arp-notify
+        type: u32
+      -
+        name: accept-local
+        type: u32
+      -
+        name: src-vmark
+        type: u32
+      -
+        name: proxy-arp-pvlan
+        type: u32
+      -
+        name: route-localnet
+        type: u32
+      -
+        name: igmpv2-unsolicited-report-interval
+        type: u32
+      -
+        name: igmpv3-unsolicited-report-interval
+        type: u32
+      -
+        name: ignore-routes-with-linkdown
+        type: u32
+      -
+        name: drop-unicast-in-l2-multicast
+        type: u32
+      -
+        name: drop-gratuitous-arp
+        type: u32
+      -
+        name: bc-forwarding
+        type: u32
+      -
+        name: arp-evict-nocarrier
+        type: u32
+  -
+    name: ipv6-devconf
+    type: struct
+    members:
+      -
+        name: forwarding
+        type: u32
+      -
+        name: hoplimit
+        type: u32
+      -
+        name: mtu6
+        type: u32
+      -
+        name: accept-ra
+        type: u32
+      -
+        name: accept-redirects
+        type: u32
+      -
+        name: autoconf
+        type: u32
+      -
+        name: dad-transmits
+        type: u32
+      -
+        name: rtr-solicits
+        type: u32
+      -
+        name: rtr-solicit-interval
+        type: u32
+      -
+        name: rtr-solicit-delay
+        type: u32
+      -
+        name: use-tempaddr
+        type: u32
+      -
+        name: temp-valid-lft
+        type: u32
+      -
+        name: temp-prefered-lft
+        type: u32
+      -
+        name: regen-max-retry
+        type: u32
+      -
+        name: max-desync-factor
+        type: u32
+      -
+        name: max-addresses
+        type: u32
+      -
+        name: force-mld-version
+        type: u32
+      -
+        name: accept-ra-defrtr
+        type: u32
+      -
+        name: accept-ra-pinfo
+        type: u32
+      -
+        name: accept-ra-rtr-pref
+        type: u32
+      -
+        name: rtr-probe-interval
+        type: u32
+      -
+        name: accept-ra-rt-info-max-plen
+        type: u32
+      -
+        name: proxy-ndp
+        type: u32
+      -
+        name: optimistic-dad
+        type: u32
+      -
+        name: accept-source-route
+        type: u32
+      -
+        name: mc-forwarding
+        type: u32
+      -
+        name: disable-ipv6
+        type: u32
+      -
+        name: accept-dad
+        type: u32
+      -
+        name: force-tllao
+        type: u32
+      -
+        name: ndisc-notify
+        type: u32
+      -
+        name: mldv1-unsolicited-report-interval
+        type: u32
+      -
+        name: mldv2-unsolicited-report-interval
+        type: u32
+      -
+        name: suppress-frag-ndisc
+        type: u32
+      -
+        name: accept-ra-from-local
+        type: u32
+      -
+        name: use-optimistic
+        type: u32
+      -
+        name: accept-ra-mtu
+        type: u32
+      -
+        name: stable-secret
+        type: u32
+      -
+        name: use-oif-addrs-only
+        type: u32
+      -
+        name: accept-ra-min-hop-limit
+        type: u32
+      -
+        name: ignore-routes-with-linkdown
+        type: u32
+      -
+        name: drop-unicast-in-l2-multicast
+        type: u32
+      -
+        name: drop-unsolicited-na
+        type: u32
+      -
+        name: keep-addr-on-down
+        type: u32
+      -
+        name: rtr-solicit-max-interval
+        type: u32
+      -
+        name: seg6-enabled
+        type: u32
+      -
+        name: seg6-require-hmac
+        type: u32
+      -
+        name: enhanced-dad
+        type: u32
+      -
+        name: addr-gen-mode
+        type: u8
+      -
+        name: disable-policy
+        type: u32
+      -
+        name: accept-ra-rt-info-min-plen
+        type: u32
+      -
+        name: ndisc-tclass
+        type: u32
+      -
+        name: rpl-seg-enabled
+        type: u32
+      -
+        name: ra-defrtr-metric
+        type: u32
+      -
+        name: ioam6-enabled
+        type: u32
+      -
+        name: ioam6-id
+        type: u32
+      -
+        name: ioam6-id-wide
+        type: u32
+      -
+        name: ndisc-evict-nocarrier
+        type: u32
+      -
+        name: accept-untracked-na
+        type: u32
+  -
+    name: ifla-icmp6-stats
+    type: struct
+    members:
+      -
+        name: inmsgs
+        type: u64
+      -
+        name: inerrors
+        type: u64
+      -
+        name: outmsgs
+        type: u64
+      -
+        name: outerrors
+        type: u64
+      -
+        name: csumerrors
+        type: u64
+      -
+        name: ratelimithost
+        type: u64
+  -
+    name: ifla-inet6-stats
+    type: struct
+    members:
+      -
+        name: inpkts
+        type: u64
+      -
+        name: inoctets
+        type: u64
+      -
+        name: indelivers
+        type: u64
+      -
+        name: outforwdatagrams
+        type: u64
+      -
+        name: outpkts
+        type: u64
+      -
+        name: outoctets
+        type: u64
+      -
+        name: inhdrerrors
+        type: u64
+      -
+        name: intoobigerrors
+        type: u64
+      -
+        name: innoroutes
+        type: u64
+      -
+        name: inaddrerrors
+        type: u64
+      -
+        name: inunknownprotos
+        type: u64
+      -
+        name: intruncatedpkts
+        type: u64
+      -
+        name: indiscards
+        type: u64
+      -
+        name: outdiscards
+        type: u64
+      -
+        name: outnoroutes
+        type: u64
+      -
+        name: reasmtimeout
+        type: u64
+      -
+        name: reasmreqds
+        type: u64
+      -
+        name: reasmoks
+        type: u64
+      -
+        name: reasmfails
+        type: u64
+      -
+        name: fragoks
+        type: u64
+      -
+        name: fragfails
+        type: u64
+      -
+        name: fragcreates
+        type: u64
+      -
+        name: inmcastpkts
+        type: u64
+      -
+        name: outmcastpkts
+        type: u64
+      -
+        name: inbcastpkts
+        type: u64
+      -
+        name: outbcastpkts
+        type: u64
+      -
+        name: inmcastoctets
+        type: u64
+      -
+        name: outmcastoctets
+        type: u64
+      -
+        name: inbcastoctets
+        type: u64
+      -
+        name: outbcastoctets
+        type: u64
+      -
+        name: csumerrors
+        type: u64
+      -
+        name: noectpkts
+        type: u64
+      -
+        name: ect1-pkts
+        type: u64
+      -
+        name: ect0-pkts
+        type: u64
+      -
+        name: cepkts
+        type: u64
+      -
+        name: reasm-overlaps
+        type: u64
+  - name: br-boolopt-multi
+    type: struct
+    members:
+      -
+        name: optval
+        type: u32
+      -
+        name: optmask
+        type: u32
+  -
+    name: if_stats_msg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+      -
+        name: ifindex
+        type: u32
+      -
+        name: filter-mask
+        type: u32
+  -
+    name: ifla-vlan-flags
+    type: struct
+    members:
+      -
+        name: flags
+        type: u32
+        enum: vlan-flags
+        enum-as-flags: true
+      -
+        name: mask
+        type: u32
+        display-hint: hex
+  -
+    name: vlan-flags
+    type: flags
+    entries:
+      - reorder-hdr
+      - gvrp
+      - loose-binding
+      - mvrp
+      - bridge-binding
+  -
+    name: ifla-vlan-qos-mapping
+    type: struct
+    members:
+      -
+        name: from
+        type: u32
+      -
+        name: to
+        type: u32
+  -
+    name: ifla-geneve-port-range
+    type: struct
+    members:
+      -
+        name: low
+        type: u16
+        byte-order: big-endian
+      -
+        name: high
+        type: u16
+        byte-order: big-endian
+  -
+    name: ifla-vf-mac
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: mac
+        type: binary
+        len: 32
+  -
+    name: ifla-vf-vlan
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: vlan
+        type: u32
+      -
+        name: qos
+        type: u32
+  -
+    name: ifla-vf-tx-rate
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: rate
+        type: u32
+  -
+    name: ifla-vf-spoofchk
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-link-state
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: link-state
+        type: u32
+        enum: ifla-vf-link-state-enum
+  -
+    name: ifla-vf-link-state-enum
+    type: enum
+    entries:
+      - auto
+      - enable
+      - disable
+  -
+    name: ifla-vf-rate
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: min-tx-rate
+        type: u32
+      -
+        name: max-tx-rate
+        type: u32
+  -
+    name: ifla-vf-rss-query-en
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-trust
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: setting
+        type: u32
+  -
+    name: ifla-vf-guid
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: guid
+        type: u64
+  -
+    name: ifla-vf-vlan-info
+    type: struct
+    members:
+      -
+        name: vf
+        type: u32
+      -
+        name: vlan
+        type: u32
+      -
+        name: qos
+        type: u32
+      -
+        name: vlan-proto
+        type: u32
+  -
+    name: rtext-filter
+    type: flags
+    entries:
+      - vf
+      - brvlan
+      - brvlan-compressed
+      - skip-stats
+      - mrp
+      - cfm-config
+      - cfm-status
+      - mst
+  -
+    name: netkit-policy
+    type: enum
+    entries:
+      -
+        name: forward
+        value: 0
+      -
+        name: blackhole
+        value: 2
+  -
+    name: netkit-mode
+    type: enum
+    entries:
+      - name: l2
+      - name: l3
+
+  -
+    name: netkit-scrub
+    type: enum
+    entries:
+      - name: none
+      - name: default
+
+attribute-sets:
+  -
+    name: link-attrs
+    name-prefix: ifla-
+    attributes:
+      -
+        name: address
+        type: binary
+        display-hint: mac
+      -
+        name: broadcast
+        type: binary
+        display-hint: mac
+      -
+        name: ifname
+        type: string
+      -
+        name: mtu
+        type: u32
+      -
+        name: link
+        type: u32
+      -
+        name: qdisc
+        type: string
+      -
+        name: stats
+        type: binary
+        struct: rtnl-link-stats
+      -
+        name: cost
+        type: string
+      -
+        name: priority
+        type: string
+      -
+        name: master
+        type: u32
+      -
+        name: wireless
+        type: string
+      -
+        name: protinfo
+        type: string
+      -
+        name: txqlen
+        type: u32
+      -
+        name: map
+        type: binary
+        struct: rtnl-link-ifmap
+      -
+        name: weight
+        type: u32
+      -
+        name: operstate
+        type: u8
+      -
+        name: linkmode
+        type: u8
+      -
+        name: linkinfo
+        type: nest
+        nested-attributes: linkinfo-attrs
+      -
+        name: net-ns-pid
+        type: u32
+      -
+        name: ifalias
+        type: string
+      -
+        name: num-vf
+        type: u32
+      -
+        name: vfinfo-list
+        type: nest
+        nested-attributes: vfinfo-list-attrs
+      -
+        name: stats64
+        type: binary
+        struct: rtnl-link-stats64
+      -
+        name: vf-ports
+        type: nest
+        nested-attributes: vf-ports-attrs
+      -
+        name: port-self
+        type: nest
+        nested-attributes: port-self-attrs
+      -
+        name: af-spec
+        type: nest
+        nested-attributes: af-spec-attrs
+      -
+        name: group
+        type: u32
+      -
+        name: net-ns-fd
+        type: u32
+      -
+        name: ext-mask
+        type: u32
+        enum: rtext-filter
+        enum-as-flags: true
+      -
+        name: promiscuity
+        type: u32
+      -
+        name: num-tx-queues
+        type: u32
+      -
+        name: num-rx-queues
+        type: u32
+      -
+        name: carrier
+        type: u8
+      -
+        name: phys-port-id
+        type: binary
+      -
+        name: carrier-changes
+        type: u32
+      -
+        name: phys-switch-id
+        type: binary
+      -
+        name: link-netnsid
+        type: s32
+      -
+        name: phys-port-name
+        type: string
+      -
+        name: proto-down
+        type: u8
+      -
+        name: gso-max-segs
+        type: u32
+      -
+        name: gso-max-size
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: xdp
+        type: nest
+        nested-attributes: xdp-attrs
+      -
+        name: event
+        type: u32
+      -
+        name: new-netnsid
+        type: s32
+      -
+        name: target-netnsid
+        type: s32
+      -
+        name: carrier-up-count
+        type: u32
+      -
+        name: carrier-down-count
+        type: u32
+      -
+        name: new-ifindex
+        type: s32
+      -
+        name: min-mtu
+        type: u32
+      -
+        name: max-mtu
+        type: u32
+      -
+        name: prop-list
+        type: nest
+        nested-attributes: link-attrs
+      -
+        name: alt-ifname
+        type: string
+        multi-attr: true
+      -
+        name: perm-address
+        type: binary
+        display-hint: mac
+      -
+        name: proto-down-reason
+        type: string
+      -
+        name: parent-dev-name
+        type: string
+      -
+        name: parent-dev-bus-name
+        type: string
+      -
+        name: gro-max-size
+        type: u32
+      -
+        name: tso-max-size
+        type: u32
+      -
+        name: tso-max-segs
+        type: u32
+      -
+        name: allmulti
+        type: u32
+      -
+        name: devlink-port
+        type: binary
+      -
+        name: gso-ipv4-max-size
+        type: u32
+      -
+        name: gro-ipv4-max-size
+        type: u32
+      -
+        name: dpll-pin
+        type: nest
+        nested-attributes: link-dpll-pin-attrs
+      -
+        name: max-pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon supported by the device (in nsec).
+      -
+        name: netns-immutable
+        type: u8
+  -
+    name: af-spec-attrs
+    attributes:
+      -
+        name: "inet"
+        type: nest
+        value: 2
+        nested-attributes: ifla-attrs
+      -
+        name: "inet6"
+        type: nest
+        value: 10
+        nested-attributes: ifla6-attrs
+      -
+        name: "mctp"
+        type: nest
+        value: 45
+        nested-attributes: mctp-attrs
+  -
+    name: vfinfo-list-attrs
+    attributes:
+      -
+        name: info
+        type: nest
+        nested-attributes: vfinfo-attrs
+        multi-attr: true
+  -
+    name: vfinfo-attrs
+    attributes:
+      -
+        name: mac
+        type: binary
+        struct: ifla-vf-mac
+      -
+        name: vlan
+        type: binary
+        struct: ifla-vf-vlan
+      -
+        name: tx-rate
+        type: binary
+        struct: ifla-vf-tx-rate
+      -
+        name: spoofchk
+        type: binary
+        struct: ifla-vf-spoofchk
+      -
+        name: link-state
+        type: binary
+        struct: ifla-vf-link-state
+      -
+        name: rate
+        type: binary
+        struct: ifla-vf-rate
+      -
+        name: rss-query-en
+        type: binary
+        struct: ifla-vf-rss-query-en
+      -
+        name: stats
+        type: nest
+        nested-attributes: vf-stats-attrs
+      -
+        name: trust
+        type: binary
+        struct: ifla-vf-trust
+      -
+        name: ib-node-guid
+        type: binary
+        struct: ifla-vf-guid
+      -
+        name: ib-port-guid
+        type: binary
+        struct: ifla-vf-guid
+      -
+        name: vlan-list
+        type: nest
+        nested-attributes: vf-vlan-attrs
+      -
+        name: broadcast
+        type: binary
+  -
+    name: vf-stats-attrs
+    attributes:
+      -
+        name: rx-packets
+        type: u64
+        value: 0
+      -
+        name: tx-packets
+        type: u64
+      -
+        name: rx-bytes
+        type: u64
+      -
+        name: tx-bytes
+        type: u64
+      -
+        name: broadcast
+        type: u64
+      -
+        name: multicast
+        type: u64
+      -
+        name: pad
+        type: pad
+      -
+        name: rx-dropped
+        type: u64
+      -
+        name: tx-dropped
+        type: u64
+  -
+    name: vf-vlan-attrs
+    attributes:
+      -
+        name: info
+        type: binary
+        struct: ifla-vf-vlan-info
+        multi-attr: true
+  -
+    name: vf-ports-attrs
+    attributes: []
+  -
+    name: port-self-attrs
+    attributes: []
+  -
+    name: linkinfo-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: data
+        type: sub-message
+        sub-message: linkinfo-data-msg
+        selector: kind
+      -
+        name: xstats
+        type: binary
+      -
+        name: slave-kind
+        type: string
+      -
+        name: slave-data
+        type: sub-message
+        sub-message: linkinfo-member-data-msg
+        selector: slave-kind
+  -
+    name: linkinfo-bond-attrs
+    name-prefix: ifla-bond-
+    attributes:
+      -
+        name: mode
+        type: u8
+      -
+        name: active-slave
+        type: u32
+      -
+        name: miimon
+        type: u32
+      -
+        name: updelay
+        type: u32
+      -
+        name: downdelay
+        type: u32
+      -
+        name: use-carrier
+        type: u8
+      -
+        name: arp-interval
+        type: u32
+      -
+        name: arp-ip-target
+        type: indexed-array
+        sub-type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: arp-validate
+        type: u32
+      -
+        name: arp-all-targets
+        type: u32
+      -
+        name: primary
+        type: u32
+      -
+        name: primary-reselect
+        type: u8
+      -
+        name: fail-over-mac
+        type: u8
+      -
+        name: xmit-hash-policy
+        type: u8
+      -
+        name: resend-igmp
+        type: u32
+      -
+        name: num-peer-notif
+        type: u8
+      -
+        name: all-slaves-active
+        type: u8
+      -
+        name: min-links
+        type: u32
+      -
+        name: lp-interval
+        type: u32
+      -
+        name: packets-per-slave
+        type: u32
+      -
+        name: ad-lacp-rate
+        type: u8
+      -
+        name: ad-select
+        type: u8
+      -
+        name: ad-info
+        type: nest
+        nested-attributes: bond-ad-info-attrs
+      -
+        name: ad-actor-sys-prio
+        type: u16
+      -
+        name: ad-user-port-key
+        type: u16
+      -
+        name: ad-actor-system
+        type: binary
+        display-hint: mac
+      -
+        name: tlb-dynamic-lb
+        type: u8
+      -
+        name: peer-notif-delay
+        type: u32
+      -
+        name: ad-lacp-active
+        type: u8
+      -
+        name: missed-max
+        type: u8
+      -
+        name: ns-ip6-target
+        type: indexed-array
+        sub-type: binary
+        display-hint: ipv6
+      -
+        name: coupled-control
+        type: u8
+  -
+    name: bond-ad-info-attrs
+    name-prefix: ifla-bond-ad-info-
+    attributes:
+      -
+        name: aggregator
+        type: u16
+      -
+        name: num-ports
+        type: u16
+      -
+        name: actor-key
+        type: u16
+      -
+        name: partner-key
+        type: u16
+      -
+        name: partner-mac
+        type: binary
+        display-hint: mac
+  -
+    name: bond-slave-attrs
+    name-prefix: ifla-bond-slave-
+    attributes:
+      -
+        name: state
+        type: u8
+      -
+        name: mii-status
+        type: u8
+      -
+        name: link-failure-count
+        type: u32
+      -
+        name: perm-hwaddr
+        type: binary
+        display-hint: mac
+      -
+        name: queue-id
+        type: u16
+      -
+        name: ad-aggregator-id
+        type: u16
+      -
+        name: ad-actor-oper-port-state
+        type: u8
+      -
+        name: ad-partner-oper-port-state
+        type: u16
+      -
+        name: prio
+        type: u32
+  -
+    name: linkinfo-bridge-attrs
+    name-prefix: ifla-br-
+    attributes:
+      -
+        name: forward-delay
+        type: u32
+      -
+        name: hello-time
+        type: u32
+      -
+        name: max-age
+        type: u32
+      -
+        name: ageing-time
+        type: u32
+      -
+        name: stp-state
+        type: u32
+      -
+        name: priority
+        type: u16
+      -
+        name: vlan-filtering
+        type: u8
+      -
+        name: vlan-protocol
+        type: u16
+      -
+        name: group-fwd-mask
+        type: u16
+      -
+        name: root-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: bridge-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: root-port
+        type: u16
+      -
+        name: root-path-cost
+        type: u32
+      -
+        name: topology-change
+        type: u8
+      -
+        name: topology-change-detected
+        type: u8
+      -
+        name: hello-timer
+        type: u64
+      -
+        name: tcn-timer
+        type: u64
+      -
+        name: topology-change-timer
+        type: u64
+      -
+        name: gc-timer
+        type: u64
+      -
+        name: group-addr
+        type: binary
+        display-hint: mac
+      -
+        name: fdb-flush
+        type: binary
+      -
+        name: mcast-router
+        type: u8
+      -
+        name: mcast-snooping
+        type: u8
+      -
+        name: mcast-query-use-ifaddr
+        type: u8
+      -
+        name: mcast-querier
+        type: u8
+      -
+        name: mcast-hash-elasticity
+        type: u32
+      -
+        name: mcast-hash-max
+        type: u32
+      -
+        name: mcast-last-member-cnt
+        type: u32
+      -
+        name: mcast-startup-query-cnt
+        type: u32
+      -
+        name: mcast-last-member-intvl
+        type: u64
+      -
+        name: mcast-membership-intvl
+        type: u64
+      -
+        name: mcast-querier-intvl
+        type: u64
+      -
+        name: mcast-query-intvl
+        type: u64
+      -
+        name: mcast-query-response-intvl
+        type: u64
+      -
+        name: mcast-startup-query-intvl
+        type: u64
+      -
+        name: nf-call-iptables
+        type: u8
+      -
+        name: nf-call-ip6-tables
+        type: u8
+      -
+        name: nf-call-arptables
+        type: u8
+      -
+        name: vlan-default-pvid
+        type: u16
+      -
+        name: pad
+        type: pad
+      -
+        name: vlan-stats-enabled
+        type: u8
+      -
+        name: mcast-stats-enabled
+        type: u8
+      -
+        name: mcast-igmp-version
+        type: u8
+      -
+        name: mcast-mld-version
+        type: u8
+      -
+        name: vlan-stats-per-port
+        type: u8
+      -
+        name: multi-boolopt
+        type: binary
+        struct: br-boolopt-multi
+      -
+        name: mcast-querier-state
+        type: binary
+      -
+        name: fdb-n-learned
+        type: u32
+      -
+        name: fdb-max-learned
+        type: u32
+  -
+    name: linkinfo-brport-attrs
+    name-prefix: ifla-brport-
+    attributes:
+      -
+        name: state
+        type: u8
+      -
+        name: priority
+        type: u16
+      -
+        name: cost
+        type: u32
+      -
+        name: mode
+        type: flag
+      -
+        name: guard
+        type: flag
+      -
+        name: protect
+        type: flag
+      -
+        name: fast-leave
+        type: flag
+      -
+        name: learning
+        type: flag
+      -
+        name: unicast-flood
+        type: flag
+      -
+        name: proxyarp
+        type: flag
+      -
+        name: learning-sync
+        type: flag
+      -
+        name: proxyarp-wifi
+        type: flag
+      -
+        name: root-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: bridge-id
+        type: binary
+        struct: ifla-bridge-id
+      -
+        name: designated-port
+        type: u16
+      -
+        name: designated-cost
+        type: u16
+      -
+        name: id
+        type: u16
+      -
+        name: "no"
+        type: u16
+      -
+        name: topology-change-ack
+        type: u8
+      -
+        name: config-pending
+        type: u8
+      -
+        name: message-age-timer
+        type: u64
+      -
+        name: forward-delay-timer
+        type: u64
+      -
+        name: hold-timer
+        type: u64
+      -
+        name: flush
+        type: flag
+      -
+        name: multicast-router
+        type: u8
+      -
+        name: pad
+        type: pad
+      -
+        name: mcast-flood
+        type: flag
+      -
+        name: mcast-to-ucast
+        type: flag
+      -
+        name: vlan-tunnel
+        type: flag
+      -
+        name: bcast-flood
+        type: flag
+      -
+        name: group-fwd-mask
+        type: u16
+      -
+        name: neigh-suppress
+        type: flag
+      -
+        name: isolated
+        type: flag
+      -
+        name: backup-port
+        type: u32
+      -
+        name: mrp-ring-open
+        type: flag
+      -
+        name: mrp-in-open
+        type: flag
+      -
+        name: mcast-eht-hosts-limit
+        type: u32
+      -
+        name: mcast-eht-hosts-cnt
+        type: u32
+      -
+        name: locked
+        type: flag
+      -
+        name: mab
+        type: flag
+      -
+        name: mcast-n-groups
+        type: u32
+      -
+        name: mcast-max-groups
+        type: u32
+      -
+        name: neigh-vlan-suppress
+        type: flag
+      -
+        name: backup-nhid
+        type: u32
+  -
+    name: linkinfo-gre-attrs
+    name-prefix: ifla-gre-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: iflags
+        type: u16
+      -
+        name: oflags
+        type: u16
+      -
+        name: ikey
+        type: u32
+      -
+        name: okey
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: pmtudisc
+        type: u8
+      -
+        name: encap-limit
+        type: u32
+      -
+        name: flowinfo
+        type: u32
+      -
+        name: flags
+        type: u32
+      -
+        name: encap-type
+        type: u16
+      -
+        name: encap-flags
+        type: u16
+      -
+        name: encap-sport
+        type: u16
+      -
+        name: encap-dport
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: ignore-df
+        type: u8
+      -
+        name: fwmark
+        type: u32
+      -
+        name: erspan-index
+        type: u32
+      -
+        name: erspan-ver
+        type: u8
+      -
+        name: erspan-dir
+        type: u8
+      -
+        name: erspan-hwid
+        type: u16
+  -
+    name: linkinfo-vti-attrs
+    name-prefix: ifla-vti-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: ikey
+        type: u32
+      -
+        name: okey
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: fwmark
+        type: u32
+  -
+    name: linkinfo-vti6-attrs
+    subset-of: linkinfo-vti-attrs
+    attributes:
+      -
+        name: link
+      -
+        name: ikey
+      -
+        name: okey
+      -
+        name: local
+        display-hint: ipv6
+      -
+        name: remote
+        display-hint: ipv6
+      -
+        name: fwmark
+  -
+    name: linkinfo-geneve-attrs
+    name-prefix: ifla-geneve-
+    attributes:
+      -
+        name: id
+        type: u32
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: port
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: remote6
+        type: binary
+        display-hint: ipv6
+      -
+        name: udp-csum
+        type: u8
+      -
+        name: udp-zero-csum6-tx
+        type: u8
+      -
+        name: udp-zero-csum6-rx
+        type: u8
+      -
+        name: label
+        type: u32
+      -
+        name: ttl-inherit
+        type: u8
+      -
+        name: df
+        type: u8
+      -
+        name: inner-proto-inherit
+        type: flag
+      -
+        name: port-range
+        type: binary
+        struct: ifla-geneve-port-range
+  -
+    name: linkinfo-iptun-attrs
+    name-prefix: ifla-iptun-
+    attributes:
+      -
+        name: link
+        type: u32
+      -
+        name: local
+        type: binary
+        display-hint: ipv4
+      -
+        name: remote
+        type: binary
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: encap-limit
+        type: u8
+      -
+        name: flowinfo
+        type: u32
+      -
+        name: flags
+        type: u16
+      -
+        name: proto
+        type: u8
+      -
+        name: pmtudisc
+        type: u8
+      -
+        name: 6rd-prefix
+        type: binary
+        display-hint: ipv6
+      -
+        name: 6rd-relay-prefix
+        type: binary
+        display-hint: ipv4
+      -
+        name: 6rd-prefixlen
+        type: u16
+      -
+        name: 6rd-relay-prefixlen
+        type: u16
+      -
+        name: encap-type
+        type: u16
+      -
+        name: encap-flags
+        type: u16
+      -
+        name: encap-sport
+        type: u16
+      -
+        name: encap-dport
+        type: u16
+      -
+        name: collect-metadata
+        type: flag
+      -
+        name: fwmark
+        type: u32
+  -
+    name: linkinfo-ip6tnl-attrs
+    subset-of: linkinfo-iptun-attrs
+    attributes:
+      -
+        name: link
+      -
+        name: local
+        display-hint: ipv6
+      -
+        name: remote
+        display-hint: ipv6
+      -
+        name: ttl
+      -
+        name: encap-limit
+      -
+        name: flowinfo
+      -
+        name: flags
+        # ip6tnl unlike ipip and sit has 32b flags
+        type: u32
+      -
+        name: proto
+      -
+        name: encap-type
+      -
+        name: encap-flags
+      -
+        name: encap-sport
+      -
+        name: encap-dport
+      -
+        name: collect-metadata
+      -
+        name: fwmark
+  -
+    name: linkinfo-tun-attrs
+    name-prefix: ifla-tun-
+    attributes:
+      -
+        name: owner
+        type: u32
+      -
+        name: group
+        type: u32
+      -
+        name: type
+        type: u8
+      -
+        name: pi
+        type: u8
+      -
+        name: vnet-hdr
+        type: u8
+      -
+        name: persist
+        type: u8
+      -
+        name: multi-queue
+        type: u8
+      -
+        name: num-queues
+        type: u32
+      -
+        name: num-disabled-queues
+        type: u32
+  -
+    name: linkinfo-vlan-attrs
+    name-prefix: ifla-vlan-
+    attributes:
+      -
+        name: id
+        type: u16
+      -
+        name: flag
+        type: binary
+        struct: ifla-vlan-flags
+      -
+        name: egress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: ingress-qos
+        type: nest
+        nested-attributes: ifla-vlan-qos
+      -
+        name: protocol
+        type: u16
+        enum: vlan-protocols
+        byte-order: big-endian
+  -
+    name: ifla-vlan-qos
+    name-prefix: ifla-vlan-qos
+    attributes:
+      -
+        name: mapping
+        type: binary
+        multi-attr: true
+        struct: ifla-vlan-qos-mapping
+  -
+    name: linkinfo-vrf-attrs
+    name-prefix: ifla-vrf-
+    attributes:
+      -
+        name: table
+        type: u32
+  -
+    name: xdp-attrs
+    attributes:
+      -
+        name: fd
+        type: s32
+      -
+        name: attached
+        type: u8
+      -
+        name: flags
+        type: u32
+      -
+        name: prog-id
+        type: u32
+      -
+        name: drv-prog-id
+        type: u32
+      -
+        name: skb-prog-id
+        type: u32
+      -
+        name: hw-prog-id
+        type: u32
+      -
+        name: expected-fd
+        type: s32
+  -
+    name: ifla-attrs
+    attributes:
+      -
+        name: conf
+        type: binary
+        struct: ipv4-devconf
+  -
+    name: ifla6-attrs
+    attributes:
+      -
+        name: flags
+        type: u32
+      -
+        name: conf
+        type: binary
+        struct: ipv6-devconf
+      -
+        name: stats
+        type: binary
+        struct: ifla-inet6-stats
+      -
+        name: mcast
+        type: binary
+      -
+        name: cacheinfo
+        type: binary
+        struct: ifla-cacheinfo
+      -
+        name: icmp6-stats
+        type: binary
+        struct: ifla-icmp6-stats
+      -
+        name: token
+        type: binary
+      -
+        name: addr-gen-mode
+        type: u8
+      -
+        name: ra-mtu
+        type: u32
+  -
+    name: mctp-attrs
+    attributes:
+      -
+        name: mctp-net
+        type: u32
+      -
+        name: phys-binding
+        type: u8
+  -
+    name: stats-attrs
+    name-prefix: ifla-stats-
+    attributes:
+      -
+        name: link-64
+        type: binary
+        struct: rtnl-link-stats64
+      -
+        name: link-xstats
+        type: binary
+      -
+        name: link-xstats-slave
+        type: binary
+      -
+        name: link-offload-xstats
+        type: nest
+        nested-attributes: link-offload-xstats
+      -
+        name: af-spec
+        type: binary
+  -
+    name: link-offload-xstats
+    attributes:
+      -
+        name: cpu-hit
+        type: binary
+      -
+        name: hw-s-info
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: hw-s-info-one
+      -
+        name: l3-stats
+        type: binary
+  -
+    name: hw-s-info-one
+    attributes:
+      -
+        name: request
+        type: u8
+      -
+        name: used
+        type: u8
+  -
+    name: link-dpll-pin-attrs
+    attributes:
+      -
+        name: id
+        type: u32
+  -
+    name: linkinfo-netkit-attrs
+    name-prefix: ifla-netkit-
+    attributes:
+      -
+        name: peer-info
+        type: binary
+      -
+        name: primary
+        type: u8
+      -
+        name: policy
+        type: u32
+        enum: netkit-policy
+      -
+        name: peer-policy
+        type: u32
+        enum: netkit-policy
+      -
+        name: mode
+        type: u32
+        enum: netkit-mode
+      -
+        name: scrub
+        type: u32
+        enum: netkit-scrub
+      -
+        name: peer-scrub
+        type: u32
+        enum: netkit-scrub
+      -
+        name: headroom
+        type: u16
+      -
+        name: tailroom
+        type: u16
+
+sub-messages:
+  -
+    name: linkinfo-data-msg
+    formats:
+      -
+        value: bond
+        attribute-set: linkinfo-bond-attrs
+      -
+        value: bridge
+        attribute-set: linkinfo-bridge-attrs
+      -
+        value: erspan
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: gre
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: gretap
+        attribute-set: linkinfo-gre-attrs
+      -
+        value: geneve
+        attribute-set: linkinfo-geneve-attrs
+      -
+        value: ipip
+        attribute-set: linkinfo-iptun-attrs
+      -
+        value: ip6tnl
+        attribute-set: linkinfo-ip6tnl-attrs
+      -
+        value: sit
+        attribute-set: linkinfo-iptun-attrs
+      -
+        value: tun
+        attribute-set: linkinfo-tun-attrs
+      -
+        value: vlan
+        attribute-set: linkinfo-vlan-attrs
+      -
+        value: vrf
+        attribute-set: linkinfo-vrf-attrs
+      -
+        value: vti
+        attribute-set: linkinfo-vti-attrs
+      -
+        value: vti6
+        attribute-set: linkinfo-vti6-attrs
+      -
+        value: netkit
+        attribute-set: linkinfo-netkit-attrs
+  -
+    name: linkinfo-member-data-msg
+    formats:
+      -
+        value: bridge
+        attribute-set: linkinfo-brport-attrs
+      -
+        value: bond
+        attribute-set: bond-slave-attrs
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newlink
+      doc: Create a new link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 16
+          attributes: &link-new-attrs
+            - ifi-index
+            - ifname
+            - net-ns-pid
+            - net-ns-fd
+            - target-netnsid
+            - link-netnsid
+            - linkinfo
+            - group
+            - num-tx-queues
+            - num-rx-queues
+            - address
+            - broadcast
+            - mtu
+            - txqlen
+            - operstate
+            - linkmode
+            - group
+            - gso-max-size
+            - gso-max-segs
+            - gro-max-size
+            - gso-ipv4-max-size
+            - gro-ipv4-max-size
+            - af-spec
+    -
+      name: dellink
+      doc: Delete an existing link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 17
+          attributes:
+            - ifi-index
+            - ifname
+    -
+      name: getlink
+      doc: Get / dump information about a link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 18
+          attributes:
+            - ifi-index
+            - ifname
+            - alt-ifname
+            - ext-mask
+            - target-netnsid
+        reply:
+          value: 16
+          attributes: &link-all-attrs
+            - ifi-family
+            - ifi-type
+            - ifi-index
+            - ifi-flags
+            - ifi-change
+            - address
+            - broadcast
+            - ifname
+            - mtu
+            - link
+            - qdisc
+            - stats
+            - cost
+            - priority
+            - master
+            - wireless
+            - protinfo
+            - txqlen
+            - map
+            - weight
+            - operstate
+            - linkmode
+            - linkinfo
+            - net-ns-pid
+            - ifalias
+            - num-vf
+            - vfinfo-list
+            - stats64
+            - vf-ports
+            - port-self
+            - af-spec
+            - group
+            - net-ns-fd
+            - ext-mask
+            - promiscuity
+            - num-tx-queues
+            - num-rx-queues
+            - carrier
+            - phys-port-id
+            - carrier-changes
+            - phys-switch-id
+            - link-netnsid
+            - phys-port-name
+            - proto-down
+            - gso-max-segs
+            - gso-max-size
+            - pad
+            - xdp
+            - event
+            - new-netnsid
+            - if-netnsid
+            - target-netnsid
+            - carrier-up-count
+            - carrier-down-count
+            - new-ifindex
+            - min-mtu
+            - max-mtu
+            - prop-list
+            - alt-ifname
+            - perm-address
+            - proto-down-reason
+            - parent-dev-name
+            - parent-dev-bus-name
+            - gro-max-size
+            - tso-max-size
+            - tso-max-segs
+            - allmulti
+            - devlink-port
+            - gso-ipv4-max-size
+            - gro-ipv4-max-size
+      dump:
+        request:
+          value: 18
+          attributes:
+            - target-netnsid
+            - ext-mask
+            - master
+            - linkinfo
+        reply:
+          value: 16
+          attributes: *link-all-attrs
+    -
+      name: setlink
+      doc: Set information about a link.
+      attribute-set: link-attrs
+      fixed-header: ifinfomsg
+      do:
+        request:
+          value: 19
+          attributes: *link-all-attrs
+    -
+      name: getstats
+      doc: Get / dump link stats.
+      attribute-set: stats-attrs
+      fixed-header: if_stats_msg
+      do:
+        request:
+          value: 94
+          attributes:
+            - ifindex
+        reply:
+          value: 92
+          attributes: &link-stats-attrs
+            - family
+            - ifindex
+            - filter-mask
+            - link-64
+            - link-xstats
+            - link-xstats-slave
+            - link-offload-xstats
+            - af-spec
+      dump:
+        request:
+          value: 94
+        reply:
+          value: 92
+          attributes: *link-stats-attrs
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-link
+      value: 1
+    -
+      name: rtnlgrp-stats
+      value: 36
diff --git a/source/specs/rt_neigh.yaml b/source/specs/rt_neigh.yaml
new file mode 100644
index 000000000000..e670b6dc07be
--- /dev/null
+++ b/source/specs/rt_neigh.yaml
@@ -0,0 +1,442 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: rt-neigh
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  IP neighbour management over rtnetlink.
+
+definitions:
+  -
+    name: ndmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+      -
+        name: ifindex
+        type: s32
+      -
+        name: state
+        type: u16
+        enum: nud-state
+      -
+        name: flags
+        type: u8
+        enum: ntf-flags
+      -
+        name: type
+        type: u8
+        enum: rtm-type
+  -
+    name: ndtmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+  -
+    name: nud-state
+    type: flags
+    entries:
+      - incomplete
+      - reachable
+      - stale
+      - delay
+      - probe
+      - failed
+      - noarp
+      - permanent
+  -
+    name: ntf-flags
+    type: flags
+    entries:
+      - use
+      - self
+      - master
+      - proxy
+      - ext-learned
+      - offloaded
+      - sticky
+      - router
+  -
+    name: ntf-ext-flags
+    type: flags
+    entries:
+      - managed
+      - locked
+  -
+    name: rtm-type
+    type: enum
+    entries:
+      - unspec
+      - unicast
+      - local
+      - broadcast
+      - anycast
+      - multicast
+      - blackhole
+      - unreachable
+      - prohibit
+      - throw
+      - nat
+      - xresolve
+  -
+    name: nda-cacheinfo
+    type: struct
+    members:
+      -
+        name: confirmed
+        type: u32
+      -
+        name: used
+        type: u32
+      -
+        name: updated
+        type: u32
+      -
+        name: refcnt
+        type: u32
+  -
+    name: ndt-config
+    type: struct
+    members:
+      -
+        name: key-len
+        type: u16
+      -
+        name: entry-size
+        type: u16
+      -
+        name: entries
+        type: u32
+      -
+        name: last-flush
+        type: u32
+      -
+        name: last-rand
+        type: u32
+      -
+        name: hash-rnd
+        type: u32
+      -
+        name: hash-mask
+        type: u32
+      -
+        name: hash-chain-gc
+        type: u32
+      -
+        name: proxy-qlen
+        type: u32
+  -
+    name: ndt-stats
+    type: struct
+    members:
+      -
+        name: allocs
+        type: u64
+      -
+        name: destroys
+        type: u64
+      -
+        name: hash-grows
+        type: u64
+      -
+        name: res-failed
+        type: u64
+      -
+        name: lookups
+        type: u64
+      -
+        name: hits
+        type: u64
+      -
+        name: rcv-probes-mcast
+        type: u64
+      -
+        name: rcv-probes-ucast
+        type: u64
+      -
+        name: periodic-gc-runs
+        type: u64
+      -
+        name: forced-gc-runs
+        type: u64
+      -
+        name: table-fulls
+        type: u64
+
+attribute-sets:
+  -
+    name: neighbour-attrs
+    attributes:
+      -
+        name: unspec
+        type: binary
+        value: 0
+      -
+        name: dst
+        type: binary
+        display-hint: ipv4
+      -
+        name: lladr
+        type: binary
+        display-hint: mac
+      -
+        name: cacheinfo
+        type: binary
+        struct: nda-cacheinfo
+      -
+        name: probes
+        type: u32
+      -
+        name: vlan
+        type: u16
+      -
+        name: port
+        type: u16
+      -
+        name: vni
+        type: u32
+      -
+        name: ifindex
+        type: u32
+      -
+        name: master
+        type: u32
+      -
+        name: link-netnsid
+        type: s32
+      -
+        name: src-vni
+        type: u32
+      -
+        name: protocol
+        type: u8
+      -
+        name: nh-id
+        type: u32
+      -
+        name: fdb-ext-attrs
+        type: binary
+      -
+        name: flags-ext
+        type: u32
+        enum: ntf-ext-flags
+      -
+        name: ndm-state-mask
+        type: u16
+      -
+        name: ndm-flags-mask
+        type: u8
+  -
+    name: ndt-attrs
+    attributes:
+      -
+        name: name
+        type: string
+      -
+        name: thresh1
+        type: u32
+      -
+        name: thresh2
+        type: u32
+      -
+        name: thresh3
+        type: u32
+      -
+        name: config
+        type: binary
+        struct: ndt-config
+      -
+        name: parms
+        type: nest
+        nested-attributes: ndtpa-attrs
+      -
+        name: stats
+        type: binary
+        struct: ndt-stats
+      -
+        name: gc-interval
+        type: u64
+      -
+        name: pad
+        type: pad
+  -
+    name: ndtpa-attrs
+    attributes:
+      -
+        name: ifindex
+        type: u32
+      -
+        name: refcnt
+        type: u32
+      -
+        name: reachable-time
+        type: u64
+      -
+        name: base-reachable-time
+        type: u64
+      -
+        name: retrans-time
+        type: u64
+      -
+        name: gc-staletime
+        type: u64
+      -
+        name: delay-probe-time
+        type: u64
+      -
+        name: queue-len
+        type: u32
+      -
+        name: app-probes
+        type: u32
+      -
+        name: ucast-probes
+        type: u32
+      -
+        name: mcast-probes
+        type: u32
+      -
+        name: anycast-delay
+        type: u64
+      -
+        name: proxy-delay
+        type: u64
+      -
+        name: proxy-qlen
+        type: u32
+      -
+        name: locktime
+        type: u64
+      -
+        name: queue-lenbytes
+        type: u32
+      -
+        name: mcast-reprobes
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: interval-probe-time-ms
+        type: u64
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newneigh
+      doc: Add new neighbour entry
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 28
+          attributes: &neighbour-all
+            - dst
+            - lladdr
+            - probes
+            - vlan
+            - port
+            - vni
+            - ifindex
+            - master
+            - protocol
+            - nh-id
+            - flags-ext
+            - fdb-ext-attrs
+    -
+      name: delneigh
+      doc: Remove an existing neighbour entry
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 29
+          attributes:
+            - dst
+            - ifindex
+    -
+      name: delneigh-ntf
+      doc: Notify a neighbour deletion
+      value: 29
+      notify: delneigh
+      fixed-header: ndmsg
+    -
+      name: getneigh
+      doc: Get or dump neighbour entries
+      fixed-header: ndmsg
+      attribute-set: neighbour-attrs
+      do:
+        request:
+          value: 30
+          attributes:
+            - dst
+        reply:
+          value: 28
+          attributes: *neighbour-all
+      dump:
+        request:
+          attributes:
+            - ifindex
+            - master
+        reply:
+          attributes: *neighbour-all
+    -
+      name: newneigh-ntf
+      doc: Notify a neighbour creation
+      value: 28
+      notify: getneigh
+      fixed-header: ndmsg
+    -
+      name: getneightbl
+      doc: Get or dump neighbour tables
+      fixed-header: ndtmsg
+      attribute-set: ndt-attrs
+      dump:
+        request:
+          value: 66
+        reply:
+          value: 64
+          attributes:
+            - name
+            - thresh1
+            - thresh2
+            - thresh3
+            - config
+            - parms
+            - stats
+            - gc-interval
+    -
+      name: setneightbl
+      doc: Set neighbour tables
+      fixed-header: ndtmsg
+      attribute-set: ndt-attrs
+      do:
+        request:
+          value: 67
+          attributes:
+            - name
+            - thresh1
+            - thresh2
+            - thresh3
+            - parms
+            - gc-interval
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-neigh
+      value: 3
diff --git a/source/specs/rt_route.yaml b/source/specs/rt_route.yaml
new file mode 100644
index 000000000000..292469c7d4b9
--- /dev/null
+++ b/source/specs/rt_route.yaml
@@ -0,0 +1,336 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: rt-route
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Route configuration over rtnetlink.
+
+definitions:
+  -
+    name: rtm-type
+    name-prefix: rtn-
+    type: enum
+    entries:
+      - unspec
+      - unicast
+      - local
+      - broadcast
+      - anycast
+      - multicast
+      - blackhole
+      - unreachable
+      - prohibit
+      - throw
+      - nat
+      - xresolve
+  -
+    name: rtmsg
+    type: struct
+    members:
+      -
+        name: rtm-family
+        type: u8
+      -
+        name: rtm-dst-len
+        type: u8
+      -
+        name: rtm-src-len
+        type: u8
+      -
+        name: rtm-tos
+        type: u8
+      -
+        name: rtm-table
+        type: u8
+      -
+        name: rtm-protocol
+        type: u8
+      -
+        name: rtm-scope
+        type: u8
+      -
+        name: rtm-type
+        type: u8
+        enum: rtm-type
+      -
+        name: rtm-flags
+        type: u32
+  -
+    name: rta-cacheinfo
+    type: struct
+    members:
+      -
+        name: rta-clntref
+        type: u32
+      -
+        name: rta-lastuse
+        type: u32
+      -
+        name: rta-expires
+        type: u32
+      -
+        name: rta-error
+        type: u32
+      -
+        name: rta-used
+        type: u32
+
+attribute-sets:
+  -
+    name: route-attrs
+    name-prefix: rta-
+    attributes:
+      -
+        name: dst
+        type: binary
+        display-hint: ipv4
+      -
+        name: src
+        type: binary
+        display-hint: ipv4
+      -
+        name: iif
+        type: u32
+      -
+        name: oif
+        type: u32
+      -
+        name: gateway
+        type: binary
+        display-hint: ipv4
+      -
+        name: priority
+        type: u32
+      -
+        name: prefsrc
+        type: binary
+        display-hint: ipv4
+      -
+        name: metrics
+        type: nest
+        nested-attributes: metrics
+      -
+        name: multipath
+        type: binary
+      -
+        name: protoinfo # not used
+        type: binary
+      -
+        name: flow
+        type: u32
+      -
+        name: cacheinfo
+        type: binary
+        struct: rta-cacheinfo
+      -
+        name: session # not used
+        type: binary
+      -
+        name: mp-algo # not used
+        type: binary
+      -
+        name: table
+        type: u32
+      -
+        name: mark
+        type: u32
+      -
+        name: mfc-stats
+        type: binary
+      -
+        name: via
+        type: binary
+      -
+        name: newdst
+        type: binary
+      -
+        name: pref
+        type: u8
+      -
+        name: encap-type
+        type: u16
+      -
+        name: encap
+        type: binary # tunnel specific nest
+      -
+        name: expires
+        type: u32
+      -
+        name: pad
+        type: binary
+      -
+        name: uid
+        type: u32
+      -
+        name: ttl-propagate
+        type: u8
+      -
+        name: ip-proto
+        type: u8
+      -
+        name: sport
+        type: u16
+      -
+        name: dport
+        type: u16
+      -
+        name: nh-id
+        type: u32
+      -
+        name: flowlabel
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
+  -
+    name: metrics
+    name-prefix: rtax-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: lock
+        type: u32
+      -
+        name: mtu
+        type: u32
+      -
+        name: window
+        type: u32
+      -
+        name: rtt
+        type: u32
+      -
+        name: rttvar
+        type: u32
+      -
+        name: ssthresh
+        type: u32
+      -
+        name: cwnd
+        type: u32
+      -
+        name: advmss
+        type: u32
+      -
+        name: reordering
+        type: u32
+      -
+        name: hoplimit
+        type: u32
+      -
+        name: initcwnd
+        type: u32
+      -
+        name: features
+        type: u32
+      -
+        name: rto-min
+        type: u32
+      -
+        name: initrwnd
+        type: u32
+      -
+        name: quickack
+        type: u32
+      -
+        name: cc-algo
+        type: string
+      -
+        name: fastopen-no-cookie
+        type: u32
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: getroute
+      doc: Dump route information.
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 26
+          attributes:
+            - rtm-family
+            - src
+            - rtm-src-len
+            - dst
+            - rtm-dst-len
+            - iif
+            - oif
+            - ip-proto
+            - sport
+            - dport
+            - mark
+            - uid
+            - flowlabel
+        reply:
+          value: 24
+          attributes: &all-route-attrs
+            - rtm-family
+            - rtm-dst-len
+            - rtm-src-len
+            - rtm-tos
+            - rtm-table
+            - rtm-protocol
+            - rtm-scope
+            - rtm-type
+            - rtm-flags
+            - dst
+            - src
+            - iif
+            - oif
+            - gateway
+            - priority
+            - prefsrc
+            - metrics
+            - multipath
+            - flow
+            - cacheinfo
+            - table
+            - mark
+            - mfc-stats
+            - via
+            - newdst
+            - pref
+            - encap-type
+            - encap
+            - expires
+            - pad
+            - uid
+            - ttl-propagate
+            - ip-proto
+            - sport
+            - dport
+            - nh-id
+            - flowlabel
+      dump:
+        request:
+          value: 26
+          attributes:
+            - rtm-family
+        reply:
+          value: 24
+          attributes: *all-route-attrs
+    -
+      name: newroute
+      doc: Create a new route
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 24
+          attributes: *all-route-attrs
+    -
+      name: delroute
+      doc: Delete an existing route
+      attribute-set: route-attrs
+      fixed-header: rtmsg
+      do:
+        request:
+          value: 25
+          attributes: *all-route-attrs
diff --git a/source/specs/rt_rule.yaml b/source/specs/rt_rule.yaml
new file mode 100644
index 000000000000..de0938d36541
--- /dev/null
+++ b/source/specs/rt_rule.yaml
@@ -0,0 +1,269 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: rt-rule
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  FIB rule management over rtnetlink.
+
+definitions:
+  -
+    name: rtgenmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+  -
+    name: fib-rule-hdr
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: dst-len
+        type: u8
+      -
+        name: src-len
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: table
+        type: u8
+      -
+        name: res1
+        type: pad
+        len: 1
+      -
+        name: res2
+        type: pad
+        len: 1
+      -
+        name: action
+        type: u8
+        enum: fr-act
+      -
+        name: flags
+        type: u32
+  -
+    name: fr-act
+    type: enum
+    entries:
+      - unspec
+      - to-tbl
+      - goto
+      - nop
+      - res3
+      - res4
+      - blackhole
+      - unreachable
+      - prohibit
+  -
+    name: fib-rule-port-range
+    type: struct
+    members:
+      -
+        name: start
+        type: u16
+      -
+        name: end
+        type: u16
+  -
+    name: fib-rule-uid-range
+    type: struct
+    members:
+      -
+        name: start
+        type: u32
+      -
+        name: end
+        type: u32
+
+attribute-sets:
+  -
+    name: fib-rule-attrs
+    attributes:
+      -
+        name: dst
+        type: u32
+      -
+        name: src
+        type: u32
+      -
+        name: iifname
+        type: string
+      -
+        name: goto
+        type: u32
+      -
+        name: unused2
+        type: pad
+      -
+        name: priority
+        type: u32
+      -
+        name: unused3
+        type: pad
+      -
+        name: unused4
+        type: pad
+      -
+        name: unused5
+        type: pad
+      -
+        name: fwmark
+        type: u32
+        display-hint: hex
+      -
+        name: flow
+        type: u32
+      -
+        name: tun-id
+        type: u64
+      -
+        name: suppress-ifgroup
+        type: u32
+      -
+        name: suppress-prefixlen
+        type: u32
+        display-hint: hex
+      -
+        name: table
+        type: u32
+      -
+        name: fwmask
+        type: u32
+        display-hint: hex
+      -
+        name: oifname
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: l3mdev
+        type: u8
+      -
+        name: uid-range
+        type: binary
+        struct: fib-rule-uid-range
+      -
+        name: protocol
+        type: u8
+      -
+        name: ip-proto
+        type: u8
+      -
+        name: sport-range
+        type: binary
+        struct: fib-rule-port-range
+      -
+        name: dport-range
+        type: binary
+        struct: fib-rule-port-range
+      -
+        name: dscp
+        type: u8
+      -
+        name: flowlabel
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
+      -
+        name: flowlabel-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: hex
+      -
+        name: sport-mask
+        type: u16
+        display-hint: hex
+      -
+        name: dport-mask
+        type: u16
+        display-hint: hex
+      -
+        name: dscp-mask
+        type: u8
+        display-hint: hex
+
+operations:
+  enum-model: directional
+  fixed-header: fib-rule-hdr
+  list:
+    -
+      name: newrule
+      doc: Add new FIB rule
+      attribute-set: fib-rule-attrs
+      do:
+        request:
+          value: 32
+          attributes: &fib-rule-all
+            - iifname
+            - oifname
+            - priority
+            - fwmark
+            - flow
+            - tun-id
+            - fwmask
+            - table
+            - suppress-prefixlen
+            - suppress-ifgroup
+            - goto
+            - l3mdev
+            - uid-range
+            - protocol
+            - ip-proto
+            - sport-range
+            - dport-range
+            - dscp
+            - flowlabel
+            - flowlabel-mask
+            - sport-mask
+            - dport-mask
+            - dscp-mask
+    -
+      name: newrule-ntf
+      doc: Notify a rule creation
+      value: 32
+      notify: newrule
+    -
+      name: delrule
+      doc: Remove an existing FIB rule
+      attribute-set: fib-rule-attrs
+      do:
+        request:
+          value: 33
+          attributes: *fib-rule-all
+    -
+      name: delrule-ntf
+      doc: Notify a rule deletion
+      value: 33
+      notify: delrule
+    -
+      name: getrule
+      doc: Dump all FIB rules
+      attribute-set: fib-rule-attrs
+      dump:
+        request:
+          value: 34
+        reply:
+          value: 32
+          attributes: *fib-rule-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-ipv4-rule
+      value: 8
+    -
+      name: rtnlgrp-ipv6-rule
+      value: 19
diff --git a/source/specs/tc.yaml b/source/specs/tc.yaml
new file mode 100644
index 000000000000..aacccea5dfe4
--- /dev/null
+++ b/source/specs/tc.yaml
@@ -0,0 +1,4032 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: tc
+protocol: netlink-raw
+protonum: 0
+
+doc:
+  Netlink raw family for tc qdisc, chain, class and filter configuration
+  over rtnetlink.
+
+definitions:
+  -
+    name: tcmsg
+    type: struct
+    members:
+      -
+        name: family
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+      -
+        name: ifindex
+        type: s32
+      -
+        name: handle
+        type: u32
+      -
+        name: parent
+        type: u32
+      -
+        name: info
+        type: u32
+  -
+    name: tc-cls-flags
+    type: flags
+    entries:
+      - skip-hw
+      - skip-sw
+      - in-hw
+      - not-in-nw
+      - verbose
+  -
+    name: tc-flower-key-ctrl-flags
+    type: flags
+    entries:
+      - frag
+      - firstfrag
+      - tuncsum
+      - tundf
+      - tunoam
+      - tuncrit
+  -
+    name: tc-stats
+    type: struct
+    members:
+      -
+        name: bytes
+        type: u64
+        doc: Number of enqueued bytes
+      -
+        name: packets
+        type: u32
+        doc: Number of enqueued packets
+      -
+        name: drops
+        type: u32
+        doc: Packets dropped because of lack of resources
+      -
+        name: overlimits
+        type: u32
+        doc: |
+          Number of throttle events when this flow goes out of allocated b=
andwidth
+      -
+        name: bps
+        type: u32
+        doc: Current flow byte rate
+      -
+        name: pps
+        type: u32
+        doc: Current flow packet rate
+      -
+        name: qlen
+        type: u32
+      -
+        name: backlog
+        type: u32
+  -
+    name: tc-cbs-qopt
+    type: struct
+    members:
+      -
+        name: offload
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 3
+      -
+        name: hicredit
+        type: s32
+      -
+        name: locredit
+        type: s32
+      -
+        name: idleslope
+        type: s32
+      -
+        name: sendslope
+        type: s32
+  -
+    name: tc-etf-qopt
+    type: struct
+    members:
+      -
+        name: delta
+        type: s32
+      -
+        name: clockid
+        type: s32
+      -
+        name: flags
+        type: s32
+  -
+    name: tc-fifo-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+        doc: Queue length; bytes for bfifo, packets for pfifo
+  -
+    name: tc-htb-opt
+    type: struct
+    members:
+      -
+        name: rate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: ceil
+        type: binary
+        struct: tc-ratespec
+      -
+        name: buffer
+        type: u32
+      -
+        name: cbuffer
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: level
+        type: u32
+      -
+        name: prio
+        type: u32
+  -
+    name: tc-htb-glob
+    type: struct
+    members:
+      -
+        name: version
+        type: u32
+      -
+        name: rate2quantum
+        type: u32
+        doc: bps->quantum divisor
+      -
+        name: defcls
+        type: u32
+        doc: Default class number
+      -
+        name: debug
+        type: u32
+        doc: Debug flags
+      -
+        name: direct-pkts
+        type: u32
+        doc: Count of non shaped packets
+  -
+    name: tc-gred-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+        doc: HARD maximal queue length in bytes
+      -
+        name: qth-min
+        type: u32
+        doc: Min average length threshold in bytes
+      -
+        name: qth-max
+        type: u32
+        doc: Max average length threshold in bytes
+      -
+        name: DP
+        type: u32
+        doc: Up to 2^32 DPs
+      -
+        name: backlog
+        type: u32
+      -
+        name: qave
+        type: u32
+      -
+        name: forced
+        type: u32
+      -
+        name: early
+        type: u32
+      -
+        name: other
+        type: u32
+      -
+        name: pdrop
+        type: u32
+      -
+        name: Wlog
+        type: u8
+        doc: log(W)
+      -
+        name: Plog
+        type: u8
+        doc: log(P_max / (qth-max - qth-min))
+      -
+        name: Scell_log
+        type: u8
+        doc: cell size for idle damping
+      -
+        name: prio
+        type: u8
+        doc: Priority of this VQ
+      -
+        name: packets
+        type: u32
+      -
+        name: bytesin
+        type: u32
+  -
+    name: tc-gred-sopt
+    type: struct
+    members:
+      -
+        name: DPs
+        type: u32
+      -
+        name: def_DP
+        type: u32
+      -
+        name: grio
+        type: u8
+      -
+        name: flags
+        type: u8
+      -
+        name: pad
+        type: pad
+        len: 2
+  -
+    name: tc-hfsc-qopt
+    type: struct
+    members:
+      -
+        name: defcls
+        type: u16
+  -
+    name: tc-mqprio-qopt
+    type: struct
+    members:
+      -
+        name: num-tc
+        type: u8
+      -
+        name: prio-tc-map
+        type: binary
+        len: 16
+      -
+        name: hw
+        type: u8
+      -
+        name: count
+        type: binary
+        len: 32
+      -
+        name: offset
+        type: binary
+        len: 32
+  -
+    name: tc-multiq-qopt
+    type: struct
+    members:
+      -
+        name: bands
+        type: u16
+        doc: Number of bands
+      -
+        name: max-bands
+        type: u16
+        doc: Maximum number of queues
+  -
+    name: tc-netem-qopt
+    type: struct
+    members:
+      -
+        name: latency
+        type: u32
+        doc: Added delay in microseconds
+      -
+        name: limit
+        type: u32
+        doc: Fifo limit in packets
+      -
+        name: loss
+        type: u32
+        doc: Random packet loss (0=3Dnone, ~0=3D100%)
+      -
+        name: gap
+        type: u32
+        doc: Re-ordering gap (0 for none)
+      -
+        name: duplicate
+        type: u32
+        doc: Random packet duplication (0=3Dnone, ~0=3D100%)
+      -
+        name: jitter
+        type: u32
+        doc: Random jitter latency in microseconds
+  -
+    name: tc-netem-gimodel
+    doc: State transition probabilities for 4 state model
+    type: struct
+    members:
+      -
+        name: p13
+        type: u32
+      -
+        name: p31
+        type: u32
+      -
+        name: p32
+        type: u32
+      -
+        name: p14
+        type: u32
+      -
+        name: p23
+        type: u32
+  -
+    name: tc-netem-gemodel
+    doc: Gilbert-Elliot models
+    type: struct
+    members:
+      -
+        name: p
+        type: u32
+      -
+        name: r
+        type: u32
+      -
+        name: h
+        type: u32
+      -
+        name: k1
+        type: u32
+  -
+    name: tc-netem-corr
+    type: struct
+    members:
+      -
+        name: delay-corr
+        type: u32
+        doc: Delay correlation
+      -
+        name: loss-corr
+        type: u32
+        doc: Packet loss correlation
+      -
+        name: dup-corr
+        type: u32
+        doc: Duplicate correlation
+  -
+    name: tc-netem-reorder
+    type: struct
+    members:
+      -
+        name: probability
+        type: u32
+      -
+        name: correlation
+        type: u32
+  -
+    name: tc-netem-corrupt
+    type: struct
+    members:
+      -
+        name: probability
+        type: u32
+      -
+        name: correlation
+        type: u32
+  -
+    name: tc-netem-rate
+    type: struct
+    members:
+      -
+        name: rate
+        type: u32
+      -
+        name: packet-overhead
+        type: s32
+      -
+        name: cell-size
+        type: u32
+      -
+        name: cell-overhead
+        type: s32
+  -
+    name: tc-netem-slot
+    type: struct
+    members:
+      -
+        name: min-delay
+        type: s64
+      -
+        name: max-delay
+        type: s64
+      -
+        name: max-packets
+        type: s32
+      -
+        name: max-bytes
+        type: s32
+      -
+        name: dist-delay
+        type: s64
+      -
+        name: dist-jitter
+        type: s64
+  -
+    name: tc-plug-qopt
+    type: struct
+    members:
+      -
+        name: action
+        type: s32
+      -
+        name: limit
+        type: u32
+  -
+    name: tc-prio-qopt
+    type: struct
+    members:
+      -
+        name: bands
+        type: u32
+        doc: Number of bands
+      -
+        name: priomap
+        type: binary
+        len: 16
+        doc: Map of logical priority -> PRIO band
+  -
+    name: tc-red-qopt
+    type: struct
+    members:
+      -
+        name: limit
+        type: u32
+        doc: Hard queue length in packets
+      -
+        name: qth-min
+        type: u32
+        doc: Min average threshold in packets
+      -
+        name: qth-max
+        type: u32
+        doc: Max average threshold in packets
+      -
+        name: Wlog
+        type: u8
+        doc: log(W)
+      -
+        name: Plog
+        type: u8
+        doc: log(P_max / (qth-max - qth-min))
+      -
+        name: Scell-log
+        type: u8
+        doc: Cell size for idle damping
+      -
+        name: flags
+        type: u8
+  -
+    name: tc-sfb-qopt
+    type: struct
+    members:
+      -
+        name: rehash-interval
+        type: u32
+      -
+        name: warmup-time
+        type: u32
+      -
+        name: max
+        type: u32
+      -
+        name: bin-size
+        type: u32
+      -
+        name: increment
+        type: u32
+      -
+        name: decrement
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: penalty-rate
+        type: u32
+      -
+        name: penalty-burst
+        type: u32
+  -
+    name: tc-sfq-qopt
+    type: struct
+    members:
+      -
+        name: quantum
+        type: u32
+        doc: Bytes per round allocated to flow
+      -
+        name: perturb-period
+        type: s32
+        doc: Period of hash perturbation
+      -
+        name: limit
+        type: u32
+        doc: Maximal packets in queue
+      -
+        name: divisor
+        type: u32
+        doc: Hash divisor
+      -
+        name: flows
+        type: u32
+        doc: Maximal number of flows
+  -
+    name: tc-sfqred-stats
+    type: struct
+    members:
+      -
+        name: prob-drop
+        type: u32
+        doc: Early drops, below max threshold
+      -
+        name: forced-drop
+        type: u32
+        doc: Early drops, after max threshold
+      -
+        name: prob-mark
+        type: u32
+        doc: Marked packets, below max threshold
+      -
+        name: forced-mark
+        type: u32
+        doc: Marked packets, after max threshold
+      -
+        name: prob-mark-head
+        type: u32
+        doc: Marked packets, below max threshold
+      -
+        name: forced-mark-head
+        type: u32
+        doc: Marked packets, after max threshold
+  -
+    name: tc-sfq-qopt-v1
+    type: struct
+    members:
+      -
+        name: v0
+        type: binary
+        struct: tc-sfq-qopt
+      -
+        name: depth
+        type: u32
+        doc: Maximum number of packets per flow
+      -
+        name: headdrop
+        type: u32
+      -
+        name: limit
+        type: u32
+        doc: HARD maximal flow queue length in bytes
+      -
+        name: qth-min
+        type: u32
+        doc: Min average length threshold in bytes
+      -
+        name: qth-max
+        type: u32
+        doc: Max average length threshold in bytes
+      -
+        name: Wlog
+        type: u8
+        doc: log(W)
+      -
+        name: Plog
+        type: u8
+        doc: log(P_max / (qth-max - qth-min))
+      -
+        name: Scell-log
+        type: u8
+        doc: Cell size for idle damping
+      -
+        name: flags
+        type: u8
+      -
+        name: max-P
+        type: u32
+        doc: probability, high resolution
+      -
+        name: stats
+        type: binary
+        struct: tc-sfqred-stats
+  -
+    name: tc-ratespec
+    type: struct
+    members:
+      -
+        name: cell-log
+        type: u8
+      -
+        name: linklayer
+        type: u8
+      -
+        name: overhead
+        type: u8
+      -
+        name: cell-align
+        type: u8
+      -
+        name: mpu
+        type: u8
+      -
+        name: rate
+        type: u32
+  -
+    name: tc-tbf-qopt
+    type: struct
+    members:
+      -
+        name: rate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: peakrate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: limit
+        type: u32
+      -
+        name: buffer
+        type: u32
+      -
+        name: mtu
+        type: u32
+  -
+    name: tc-sizespec
+    type: struct
+    members:
+      -
+        name: cell-log
+        type: u8
+      -
+        name: size-log
+        type: u8
+      -
+        name: cell-align
+        type: s16
+      -
+        name: overhead
+        type: s32
+      -
+        name: linklayer
+        type: u32
+      -
+        name: mpu
+        type: u32
+      -
+        name: mtu
+        type: u32
+      -
+        name: tsize
+        type: u32
+  -
+    name: gnet-estimator
+    type: struct
+    members:
+      -
+        name: interval
+        type: s8
+        doc: Sampling period
+      -
+        name: ewma-log
+        type: u8
+        doc: The log() of measurement window weight
+  -
+    name: tc-choke-xstats
+    type: struct
+    members:
+      -
+        name: early
+        type: u32
+        doc: Early drops
+      -
+        name: pdrop
+        type: u32
+        doc: Drops due to queue limits
+      -
+        name: other
+        type: u32
+        doc: Drops due to drop() calls
+      -
+        name: marked
+        type: u32
+        doc: Marked packets
+      -
+        name: matched
+        type: u32
+        doc: Drops due to flow match
+  -
+    name: tc-codel-xstats
+    type: struct
+    members:
+      -
+        name: maxpacket
+        type: u32
+        doc: Largest packet we've seen so far
+      -
+        name: count
+        type: u32
+        doc: How many drops we've done since the last time we entered drop=
ping state
+      -
+        name: lastcount
+        type: u32
+        doc: Count at entry to dropping state
+      -
+        name: ldelay
+        type: u32
+        doc: in-queue delay seen by most recently dequeued packet
+      -
+        name: drop-next
+        type: s32
+        doc: Time to drop next packet
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: ecn-mark
+        type: u32
+        doc: Number of packets we've ECN marked instead of dropped
+      -
+        name: dropping
+        type: u32
+        doc: Are we in a dropping state?
+      -
+        name: ce-mark
+        type: u32
+        doc: Number of CE marked packets because of ce-threshold
+  -
+    name: tc-fq-codel-xstats
+    type: struct
+    members:
+      -
+        name: type
+        type: u32
+      -
+        name: maxpacket
+        type: u32
+        doc: Largest packet we've seen so far
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: ecn-mark
+        type: u32
+        doc: Number of packets we ECN marked instead of being dropped
+      -
+        name: new-flow-count
+        type: u32
+        doc: Number of times packets created a new flow
+      -
+        name: new-flows-len
+        type: u32
+        doc: Count of flows in new list
+      -
+        name: old-flows-len
+        type: u32
+        doc: Count of flows in old list
+      -
+        name: ce-mark
+        type: u32
+        doc: Packets above ce-threshold
+      -
+        name: memory-usage
+        type: u32
+        doc: Memory usage in bytes
+      -
+        name: drop-overmemory
+        type: u32
+  -
+    name: tc-fq-pie-xstats
+    type: struct
+    members:
+      -
+        name: packets-in
+        type: u32
+        doc: Total number of packets enqueued
+      -
+        name: dropped
+        type: u32
+        doc: Packets dropped due to fq_pie_action
+      -
+        name: overlimit
+        type: u32
+        doc: Dropped due to lack of space in queue
+      -
+        name: overmemory
+        type: u32
+        doc: Dropped due to lack of memory in queue
+      -
+        name: ecn-mark
+        type: u32
+        doc: Packets marked with ecn
+      -
+        name: new-flow-count
+        type: u32
+        doc: Count of new flows created by packets
+      -
+        name: new-flows-len
+        type: u32
+        doc: Count of flows in new list
+      -
+        name: old-flows-len
+        type: u32
+        doc: Count of flows in old list
+      -
+        name: memory-usage
+        type: u32
+        doc: Total memory across all queues
+  -
+    name: tc-fq-qd-stats
+    type: struct
+    members:
+      -
+        name: gc-flows
+        type: u64
+      -
+        name: highprio-packets
+        type: u64
+        doc: obsolete
+      -
+        name: tcp-retrans
+        type: u64
+        doc: obsolete
+      -
+        name: throttled
+        type: u64
+      -
+        name: flows-plimit
+        type: u64
+      -
+        name: pkts-too-long
+        type: u64
+      -
+        name: allocation-errors
+        type: u64
+      -
+        name: time-next-delayed-flow
+        type: s64
+      -
+        name: flows
+        type: u32
+      -
+        name: inactive-flows
+        type: u32
+      -
+        name: throttled-flows
+        type: u32
+      -
+        name: unthrottle-latency-ns
+        type: u32
+      -
+        name: ce-mark
+        type: u64
+        doc: Packets above ce-threshold
+      -
+        name: horizon-drops
+        type: u64
+      -
+        name: horizon-caps
+        type: u64
+      -
+        name: fastpath-packets
+        type: u64
+      -
+        name: band-drops
+        type: binary
+        len: 24
+      -
+        name: band-pkt-count
+        type: binary
+        len: 12
+      -
+        name: pad
+        type: pad
+        len: 4
+  -
+    name: tc-hhf-xstats
+    type: struct
+    members:
+      -
+        name: drop-overlimit
+        type: u32
+        doc: Number of times max qdisc packet limit was hit
+      -
+        name: hh-overlimit
+        type: u32
+        doc: Number of times max heavy-hitters was hit
+      -
+        name: hh-tot-count
+        type: u32
+        doc: Number of captured heavy-hitters so far
+      -
+        name: hh-cur-count
+        type: u32
+        doc: Number of current heavy-hitters
+  -
+    name: tc-pie-xstats
+    type: struct
+    members:
+      -
+        name: prob
+        type: u64
+        doc: Current probability
+      -
+        name: delay
+        type: u32
+        doc: Current delay in ms
+      -
+        name: avg-dq-rate
+        type: u32
+        doc: Current average dq rate in bits/pie-time
+      -
+        name: dq-rate-estimating
+        type: u32
+        doc: Is avg-dq-rate being calculated?
+      -
+        name: packets-in
+        type: u32
+        doc: Total number of packets enqueued
+      -
+        name: dropped
+        type: u32
+        doc: Packets dropped due to pie action
+      -
+        name: overlimit
+        type: u32
+        doc: Dropped due to lack of space in queue
+      -
+        name: maxq
+        type: u32
+        doc: Maximum queue size
+      -
+        name: ecn-mark
+        type: u32
+        doc: Packets marked with ecn
+  -
+    name: tc-red-xstats
+    type: struct
+    members:
+      -
+        name: early
+        type: u32
+        doc: Early drops
+      -
+        name: pdrop
+        type: u32
+        doc: Drops due to queue limits
+      -
+        name: other
+        type: u32
+        doc: Drops due to drop() calls
+      -
+        name: marked
+        type: u32
+        doc: Marked packets
+  -
+    name: tc-sfb-xstats
+    type: struct
+    members:
+      -
+        name: earlydrop
+        type: u32
+      -
+        name: penaltydrop
+        type: u32
+      -
+        name: bucketdrop
+        type: u32
+      -
+        name: queuedrop
+        type: u32
+      -
+        name: childdrop
+        type: u32
+        doc: drops in child qdisc
+      -
+        name: marked
+        type: u32
+      -
+        name: maxqlen
+        type: u32
+      -
+        name: maxprob
+        type: u32
+      -
+        name: avgprob
+        type: u32
+  -
+    name: tc-sfq-xstats
+    type: struct
+    members:
+      -
+        name: allot
+        type: s32
+  -
+    name: gnet-stats-basic
+    type: struct
+    members:
+      -
+        name: bytes
+        type: u64
+      -
+        name: packets
+        type: u32
+  -
+    name: gnet-stats-rate-est
+    type: struct
+    members:
+      -
+        name: bps
+        type: u32
+      -
+        name: pps
+        type: u32
+  -
+    name: gnet-stats-rate-est64
+    type: struct
+    members:
+      -
+        name: bps
+        type: u64
+      -
+        name: pps
+        type: u64
+  -
+    name: gnet-stats-queue
+    type: struct
+    members:
+      -
+        name: qlen
+        type: u32
+      -
+        name: backlog
+        type: u32
+      -
+        name: drops
+        type: u32
+      -
+        name: requeues
+        type: u32
+      -
+        name: overlimits
+        type: u32
+  -
+    name: tc-u32-key
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: val
+        type: u32
+        byte-order: big-endian
+      -
+        name: "off"
+        type: s32
+      -
+        name: offmask
+        type: s32
+  -
+    name: tc-u32-mark
+    type: struct
+    members:
+      -
+        name: val
+        type: u32
+      -
+        name: mask
+        type: u32
+      -
+        name: success
+        type: u32
+  -
+    name: tc-u32-sel
+    type: struct
+    members:
+      -
+        name: flags
+        type: u8
+      -
+        name: offshift
+        type: u8
+      -
+        name: nkeys
+        type: u8
+      -
+        name: offmask
+        type: u16
+        byte-order: big-endian
+      -
+        name: "off"
+        type: u16
+      -
+        name: offoff
+        type: s16
+      -
+        name: hoff
+        type: s16
+      -
+        name: hmask
+        type: u32
+        byte-order: big-endian
+      -
+        name: keys
+        type: binary
+        struct: tc-u32-key # TODO: array
+  -
+    name: tc-u32-pcnt
+    type: struct
+    members:
+      -
+        name: rcnt
+        type: u64
+      -
+        name: rhit
+        type: u64
+      -
+        name: kcnts
+        type: u64 # TODO: array
+  -
+    name: tcf-t
+    type: struct
+    members:
+      -
+        name: install
+        type: u64
+      -
+        name: lastuse
+        type: u64
+      -
+        name: expires
+        type: u64
+      -
+        name: firstuse
+        type: u64
+  -
+    name: tc-gen
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+  -
+    name: tc-gact-p
+    type: struct
+    members:
+      -
+        name: ptype
+        type: u16
+      -
+        name: pval
+        type: u16
+      -
+        name: paction
+        type: s32
+  -
+    name: tcf-ematch-tree-hdr
+    type: struct
+    members:
+      -
+        name: nmatches
+        type: u16
+      -
+        name: progid
+        type: u16
+  -
+    name: tc-basic-pcnt
+    type: struct
+    members:
+      -
+        name: rcnt
+        type: u64
+      -
+        name: rhit
+        type: u64
+  -
+    name: tc-matchall-pcnt
+    type: struct
+    members:
+      -
+        name: rhit
+        type: u64
+  -
+    name: tc-mpls
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: m-action
+        type: s32
+  -
+    name: tc-police
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: limit
+        type: u32
+      -
+        name: burst
+        type: u32
+      -
+        name: mtu
+        type: u32
+      -
+        name: rate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: peakrate
+        type: binary
+        struct: tc-ratespec
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: capab
+        type: u32
+  -
+    name: tc-pedit-sel
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: nkeys
+        type: u8
+      -
+        name: flags
+        type: u8
+      -
+        name: keys
+        type: binary
+        struct: tc-pedit-key # TODO: array
+  -
+    name: tc-pedit-key
+    type: struct
+    members:
+      -
+        name: mask
+        type: u32
+      -
+        name: val
+        type: u32
+      -
+        name: "off"
+        type: u32
+      -
+        name: at
+        type: u32
+      -
+        name: offmask
+        type: u32
+      -
+        name: shift
+        type: u32
+  -
+    name: tc-vlan
+    type: struct
+    members:
+      -
+        name: index
+        type: u32
+      -
+        name: capab
+        type: u32
+      -
+        name: action
+        type: s32
+      -
+        name: refcnt
+        type: s32
+      -
+        name: bindcnt
+        type: s32
+      -
+        name: v-action
+        type: s32
+attribute-sets:
+  -
+    name: tc-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: sub-message
+        sub-message: tc-options-msg
+        selector: kind
+      -
+        name: stats
+        type: binary
+        struct: tc-stats
+      -
+        name: xstats
+        type: sub-message
+        sub-message: tca-stats-app-msg
+        selector: kind
+      -
+        name: rate
+        type: binary
+        struct: gnet-estimator
+      -
+        name: fcnt
+        type: u32
+      -
+        name: stats2
+        type: nest
+        nested-attributes: tca-stats-attrs
+      -
+        name: stab
+        type: nest
+        nested-attributes: tca-stab-attrs
+      -
+        name: pad
+        type: pad
+      -
+        name: dump-invisible
+        type: flag
+      -
+        name: chain
+        type: u32
+      -
+        name: hw-offload
+        type: u8
+      -
+        name: ingress-block
+        type: u32
+      -
+        name: egress-block
+        type: u32
+      -
+        name: dump-flags
+        type: bitfield32
+      -
+        name: ext-warn-msg
+        type: string
+  -
+    name: tc-act-attrs
+    attributes:
+      -
+        name: kind
+        type: string
+      -
+        name: options
+        type: sub-message
+        sub-message: tc-act-options-msg
+        selector: kind
+      -
+        name: index
+        type: u32
+      -
+        name: stats
+        type: nest
+        nested-attributes: tc-act-stats-attrs
+      -
+        name: pad
+        type: pad
+      -
+        name: cookie
+        type: binary
+      -
+        name: flags
+        type: bitfield32
+      -
+        name: hw-stats
+        type: bitfield32
+      -
+        name: used-hw-stats
+        type: bitfield32
+      -
+        name: in-hw-count
+        type: u32
+  -
+    name: tc-act-stats-attrs
+    attributes:
+      -
+        name: basic
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: rate-est
+        type: binary
+        struct: gnet-stats-rate-est
+      -
+        name: queue
+        type: binary
+        struct: gnet-stats-queue
+      -
+        name: app
+        type: binary
+      -
+        name: rate-est64
+        type: binary
+        struct: gnet-stats-rate-est64
+      -
+        name: pad
+        type: pad
+      -
+        name: basic-hw
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: pkt64
+        type: u64
+  -
+    name: tc-act-bpf-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: ops-len
+        type: u16
+      -
+        name: ops
+        type: binary
+      -
+        name: fd
+        type: u32
+      -
+        name: name
+        type: string
+      -
+        name: pad
+        type: pad
+      -
+        name: tag
+        type: binary
+      -
+        name: id
+        type: binary
+  -
+    name: tc-act-connmark-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-csum-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-ct-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: action
+        type: u16
+      -
+        name: zone
+        type: u16
+      -
+        name: mark
+        type: u32
+      -
+        name: mark-mask
+        type: u32
+      -
+        name: labels
+        type: binary
+      -
+        name: labels-mask
+        type: binary
+      -
+        name: nat-ipv4-min
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-ipv4-max
+        type: u32
+        byte-order: big-endian
+      -
+        name: nat-ipv6-min
+        type: binary
+      -
+        name: nat-ipv6-max
+        type: binary
+      -
+        name: nat-port-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: nat-port-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: helper-name
+        type: string
+      -
+        name: helper-family
+        type: u8
+      -
+        name: helper-proto
+        type: u8
+  -
+    name: tc-act-ctinfo-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: act
+        type: binary
+      -
+        name: zone
+        type: u16
+      -
+        name: parms-dscp-mask
+        type: u32
+      -
+        name: parms-dscp-statemask
+        type: u32
+      -
+        name: parms-cpmark-mask
+        type: u32
+      -
+        name: stats-dscp-set
+        type: u64
+      -
+        name: stats-dscp-error
+        type: u64
+      -
+        name: stats-cpmark-set
+        type: u64
+  -
+    name: tc-act-gate-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: priority
+        type: s32
+      -
+        name: entry-list
+        type: binary
+      -
+        name: base-time
+        type: u64
+      -
+        name: cycle-time
+        type: u64
+      -
+        name: cycle-time-ext
+        type: u64
+      -
+        name: flags
+        type: u32
+      -
+        name: clockid
+        type: s32
+  -
+    name: tc-act-ife-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: dmac
+        type: binary
+      -
+        name: smac
+        type: binary
+      -
+        name: type
+        type: u16
+      -
+        name: metalst
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-mirred-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: pad
+        type: pad
+      -
+        name: blockid
+        type: binary
+  -
+    name: tc-act-mpls-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-mpls
+      -
+        name: pad
+        type: pad
+      -
+        name: proto
+        type: u16
+        byte-order: big-endian
+      -
+        name: label
+        type: u32
+      -
+        name: tc
+        type: u8
+      -
+        name: ttl
+        type: u8
+      -
+        name: bos
+        type: u8
+  -
+    name: tc-act-nat-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-pedit-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-pedit-sel
+      -
+        name: pad
+        type: pad
+      -
+        name: parms-ex
+        type: binary
+      -
+        name: keys-ex
+        type: binary
+      -
+        name: key-ex
+        type: binary
+  -
+    name: tc-act-police-attrs
+    attributes:
+      -
+        name: tbf
+        type: binary
+        struct: tc-police
+      -
+        name: rate
+        type: binary # TODO
+      -
+        name: peakrate
+        type: binary # TODO
+      -
+        name: avrate
+        type: u32
+      -
+        name: result
+        type: u32
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+      -
+        name: rate64
+        type: u64
+      -
+        name: peakrate64
+        type: u64
+      -
+        name: pktrate64
+        type: u64
+      -
+        name: pktburst64
+        type: u64
+  -
+    name: tc-act-simple-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: data
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-skbedit-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: priority
+        type: u32
+      -
+        name: queue-mapping
+        type: u16
+      -
+        name: mark
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: ptype
+        type: u16
+      -
+        name: mask
+        type: u32
+      -
+        name: flags
+        type: u64
+      -
+        name: queue-mapping-max
+        type: u16
+  -
+    name: tc-act-skbmod-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: dmac
+        type: binary
+      -
+        name: smac
+        type: binary
+      -
+        name: etype
+        type: binary
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-tunnel-key-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+      -
+        name: enc-ipv4-src
+        type: u32
+        byte-order: big-endian
+      -
+        name: enc-ipv4-dst
+        type: u32
+        byte-order: big-endian
+      -
+        name: enc-ipv6-src
+        type: binary
+      -
+        name: enc-ipv6-dst
+        type: binary
+      -
+        name: enc-key-id
+        type: u64
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: enc-dst-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: no-csum
+        type: u8
+      -
+        name: enc-opts
+        type: binary
+      -
+        name: enc-tos
+        type: u8
+      -
+        name: enc-ttl
+        type: u8
+      -
+        name: no-frag
+        type: flag
+  -
+    name: tc-act-vlan-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-vlan
+      -
+        name: push-vlan-id
+        type: u16
+      -
+        name: push-vlan-protocol
+        type: u16
+      -
+        name: pad
+        type: pad
+      -
+        name: push-vlan-priority
+        type: u8
+      -
+        name: push-eth-dst
+        type: binary
+      -
+        name: push-eth-src
+        type: binary
+  -
+    name: tc-basic-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: ematches
+        type: nest
+        nested-attributes: tc-ematch-attrs
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: pcnt
+        type: binary
+        struct: tc-basic-pcnt
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-bpf-attrs
+    attributes:
+      -
+        name: act
+        type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: classid
+        type: u32
+      -
+        name: ops-len
+        type: u16
+      -
+        name: ops
+        type: binary
+      -
+        name: fd
+        type: u32
+      -
+        name: name
+        type: string
+      -
+        name: flags
+        type: u32
+      -
+        name: flags-gen
+        type: u32
+      -
+        name: tag
+        type: binary
+      -
+        name: id
+        type: u32
+  -
+    name: tc-cake-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: base-rate64
+        type: u64
+      -
+        name: diffserv-mode
+        type: u32
+      -
+        name: atm
+        type: u32
+      -
+        name: flow-mode
+        type: u32
+      -
+        name: overhead
+        type: u32
+      -
+        name: rtt
+        type: u32
+      -
+        name: target
+        type: u32
+      -
+        name: autorate
+        type: u32
+      -
+        name: memory
+        type: u32
+      -
+        name: nat
+        type: u32
+      -
+        name: raw
+        type: u32
+      -
+        name: wash
+        type: u32
+      -
+        name: mpu
+        type: u32
+      -
+        name: ingress
+        type: u32
+      -
+        name: ack-filter
+        type: u32
+      -
+        name: split-gso
+        type: u32
+      -
+        name: fwmark
+        type: u32
+  -
+    name: tc-cake-stats-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: capacity-estimate64
+        type: u64
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: memory-used
+        type: u32
+      -
+        name: avg-netoff
+        type: u32
+      -
+        name: min-netlen
+        type: u32
+      -
+        name: max-netlen
+        type: u32
+      -
+        name: min-adjlen
+        type: u32
+      -
+        name: max-adjlen
+        type: u32
+      -
+        name: tin-stats
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-cake-tin-stats-attrs
+      -
+        name: deficit
+        type: s32
+      -
+        name: cobalt-count
+        type: u32
+      -
+        name: dropping
+        type: u32
+      -
+        name: drop-next-us
+        type: s32
+      -
+        name: p-drop
+        type: u32
+      -
+        name: blue-timer-us
+        type: s32
+  -
+    name: tc-cake-tin-stats-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: sent-packets
+        type: u32
+      -
+        name: sent-bytes64
+        type: u64
+      -
+        name: dropped-packets
+        type: u32
+      -
+        name: dropped-bytes64
+        type: u64
+      -
+        name: acks-dropped-packets
+        type: u32
+      -
+        name: acks-dropped-bytes64
+        type: u64
+      -
+        name: ecn-marked-packets
+        type: u32
+      -
+        name: ecn-marked-bytes64
+        type: u64
+      -
+        name: backlog-packets
+        type: u32
+      -
+        name: backlog-bytes
+        type: u32
+      -
+        name: threshold-rate64
+        type: u64
+      -
+        name: target-us
+        type: u32
+      -
+        name: interval-us
+        type: u32
+      -
+        name: way-indirect-hits
+        type: u32
+      -
+        name: way-misses
+        type: u32
+      -
+        name: way-collisions
+        type: u32
+      -
+        name: peak-delay-us
+        type: u32
+      -
+        name: avg-delay-us
+        type: u32
+      -
+        name: base-delay-us
+        type: u32
+      -
+        name: sparse-flows
+        type: u32
+      -
+        name: bulk-flows
+        type: u32
+      -
+        name: unresponsive-flows
+        type: u32
+      -
+        name: max-skblen
+        type: u32
+      -
+        name: flow-quantum
+        type: u32
+  -
+    name: tc-cbs-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-cbs-qopt
+  -
+    name: tc-cgroup-attrs
+    attributes:
+      -
+        name: act
+        type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: ematches
+        type: binary
+  -
+    name: tc-choke-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-red-qopt
+      -
+        name: stab
+        type: binary
+        checks:
+          min-len: 256
+          max-len: 256
+      -
+        name: max-p
+        type: u32
+  -
+    name: tc-codel-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: interval
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: ce-threshold
+        type: u32
+  -
+    name: tc-drr-attrs
+    attributes:
+      -
+        name: quantum
+        type: u32
+  -
+    name: tc-ematch-attrs
+    attributes:
+      -
+        name: tree-hdr
+        type: binary
+        struct: tcf-ematch-tree-hdr
+      -
+        name: tree-list
+        type: binary
+  -
+    name: tc-flow-attrs
+    attributes:
+      -
+        name: keys
+        type: u32
+      -
+        name: mode
+        type: u32
+      -
+        name: baseclass
+        type: u32
+      -
+        name: rshift
+        type: u32
+      -
+        name: addend
+        type: u32
+      -
+        name: mask
+        type: u32
+      -
+        name: xor
+        type: u32
+      -
+        name: divisor
+        type: u32
+      -
+        name: act
+        type: binary
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: ematches
+        type: binary
+      -
+        name: perturb
+        type: u32
+  -
+    name: tc-flower-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: indev
+        type: string
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: key-eth-dst
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-dst-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-src
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-src-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ip-proto
+        type: u8
+      -
+        name: key-ipv4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-src-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv4-dst-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-ipv6-src
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-src-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-ipv6-dst-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-tcp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+        enum: tc-cls-flags
+        enum-as-flags: true
+      -
+        name: key-vlan-id
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-vlan-prio
+        type: u8
+      -
+        name: key-vlan-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-key-id
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-enc-ipv4-src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-src-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv4-dst-mask
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: key-enc-ipv6-src
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-src-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-enc-ipv6-dst-mask
+        type: binary
+        display-hint: ipv6
+      -
+        name: key-tcp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-udp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-src-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-dst-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-src
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-sctp-dst
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-src-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-src-port-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-dst-port
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-udp-dst-port-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-flags
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
+      -
+        name: key-flags-mask
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
+      -
+        name: key-icmpv4-code
+        type: u8
+      -
+        name: key-icmpv4-code-mask
+        type: u8
+      -
+        name: key-icmpv4-type
+        type: u8
+      -
+        name: key-icmpv4-type-mask
+        type: u8
+      -
+        name: key-icmpv6-code
+        type: u8
+      -
+        name: key-icmpv6-code-mask
+        type: u8
+      -
+        name: key-icmpv6-type
+        type: u8
+      -
+        name: key-icmpv6-type-mask
+        type: u8
+      -
+        name: key-arp-sip
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-sip-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-tip
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-tip-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-arp-op
+        type: u8
+      -
+        name: key-arp-op-mask
+        type: u8
+      -
+        name: key-arp-sha
+        type: binary
+        display-hint: mac
+      -
+        name: key-arp-sha-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-arp-tha
+        type: binary
+        display-hint: mac
+      -
+        name: key-arp-tha-mask
+        type: binary
+        display-hint: mac
+      -
+        name: key-mpls-ttl
+        type: u8
+      -
+        name: key-mpls-bos
+        type: u8
+      -
+        name: key-mpls-tc
+        type: u8
+      -
+        name: key-mpls-label
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-tcp-flags
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-tcp-flags-mask
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ip-tos
+        type: u8
+      -
+        name: key-ip-tos-mask
+        type: u8
+      -
+        name: key-ip-ttl
+        type: u8
+      -
+        name: key-ip-ttl-mask
+        type: u8
+      -
+        name: key-cvlan-id
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-cvlan-prio
+        type: u8
+      -
+        name: key-cvlan-eth-type
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-enc-ip-tos
+        type: u8
+      -
+        name: key-enc-ip-tos-mask
+        type: u8
+      -
+        name: key-enc-ip-ttl
+        type: u8
+      -
+        name: key-enc-ip-ttl-mask
+        type: u8
+      -
+        name: key-enc-opts
+        type: nest
+        nested-attributes: tc-flower-key-enc-opts-attrs
+      -
+        name: key-enc-opts-mask
+        type: nest
+        nested-attributes: tc-flower-key-enc-opts-attrs
+      -
+        name: in-hw-count
+        type: u32
+      -
+        name: key-port-src-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-src-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-dst-min
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-port-dst-max
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ct-state
+        type: u16
+      -
+        name: key-ct-state-mask
+        type: u16
+      -
+        name: key-ct-zone
+        type: u16
+      -
+        name: key-ct-zone-mask
+        type: u16
+      -
+        name: key-ct-mark
+        type: u32
+      -
+        name: key-ct-mark-mask
+        type: u32
+      -
+        name: key-ct-labels
+        type: binary
+      -
+        name: key-ct-labels-mask
+        type: binary
+      -
+        name: key-mpls-opts
+        type: nest
+        nested-attributes: tc-flower-key-mpls-opt-attrs
+      -
+        name: key-hash
+        type: u32
+      -
+        name: key-hash-mask
+        type: u32
+      -
+        name: key-num-of-vlans
+        type: u8
+      -
+        name: key-pppoe-sid
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-ppp-proto
+        type: u16
+        byte-order: big-endian
+      -
+        name: key-l2-tpv3-sid
+        type: u32
+        byte-order: big-endian
+      -
+        name: l2-miss
+        type: u8
+      -
+        name: key-cfm
+        type: nest
+        nested-attributes: tc-flower-key-cfm-attrs
+      -
+        name: key-spi
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-spi-mask
+        type: u32
+        byte-order: big-endian
+      -
+        name: key-enc-flags
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
+      -
+        name: key-enc-flags-mask
+        type: u32
+        byte-order: big-endian
+        enum: tc-flower-key-ctrl-flags
+        enum-as-flags: true
+  -
+    name: tc-flower-key-enc-opts-attrs
+    attributes:
+      -
+        name: geneve
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-geneve-attrs
+      -
+        name: vxlan
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-vxlan-attrs
+      -
+        name: erspan
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-erspan-attrs
+      -
+        name: gtp
+        type: nest
+        nested-attributes: tc-flower-key-enc-opt-gtp-attrs
+  -
+    name: tc-flower-key-enc-opt-geneve-attrs
+    attributes:
+      -
+        name: class
+        type: u16
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+  -
+    name: tc-flower-key-enc-opt-vxlan-attrs
+    attributes:
+      -
+        name: gbp
+        type: u32
+  -
+    name: tc-flower-key-enc-opt-erspan-attrs
+    attributes:
+      -
+        name: ver
+        type: u8
+      -
+        name: index
+        type: u32
+      -
+        name: dir
+        type: u8
+      -
+        name: hwid
+        type: u8
+  -
+    name: tc-flower-key-enc-opt-gtp-attrs
+    attributes:
+      -
+        name: pdu-type
+        type: u8
+      -
+        name: qfi
+        type: u8
+  -
+    name: tc-flower-key-mpls-opt-attrs
+    attributes:
+      -
+        name: lse-depth
+        type: u8
+      -
+        name: lse-ttl
+        type: u8
+      -
+        name: lse-bos
+        type: u8
+      -
+        name: lse-tc
+        type: u8
+      -
+        name: lse-label
+        type: u32
+  -
+    name: tc-flower-key-cfm-attrs
+    attributes:
+      -
+        name: md-level
+        type: u8
+      -
+        name: opcode
+        type: u8
+  -
+    name: tc-fw-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: indev
+        type: string
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: mask
+        type: u32
+  -
+    name: tc-gred-attrs
+    attributes:
+      -
+        name: parms
+        type: binary # array of struct: tc-gred-qopt
+      -
+        name: stab
+        type: binary
+        sub-type: u8
+      -
+        name: dps
+        type: binary
+        struct: tc-gred-sopt
+      -
+        name: max-p
+        type: binary
+        sub-type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: vq-list
+        type: nest
+        nested-attributes: tca-gred-vq-list-attrs
+  -
+    name: tca-gred-vq-list-attrs
+    attributes:
+      -
+        name: entry
+        type: nest
+        nested-attributes: tca-gred-vq-entry-attrs
+        multi-attr: true
+  -
+    name: tca-gred-vq-entry-attrs
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: dp
+        type: u32
+      -
+        name: stat-bytes
+        type: u64
+      -
+        name: stat-packets
+        type: u32
+      -
+        name: stat-backlog
+        type: u32
+      -
+        name: stat-prob-drop
+        type: u32
+      -
+        name: stat-prob-mark
+        type: u32
+      -
+        name: stat-forced-drop
+        type: u32
+      -
+        name: stat-forced-mark
+        type: u32
+      -
+        name: stat-pdrop
+        type: u32
+      -
+        name: stat-other
+        type: u32
+      -
+        name: flags
+        type: u32
+  -
+    name: tc-hfsc-attrs
+    attributes:
+      -
+        name: rsc
+        type: binary
+      -
+        name: fsc
+        type: binary
+      -
+        name: usc
+        type: binary
+  -
+    name: tc-hhf-attrs
+    attributes:
+      -
+        name: backlog-limit
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: hh-flows-limit
+        type: u32
+      -
+        name: reset-timeout
+        type: u32
+      -
+        name: admit-bytes
+        type: u32
+      -
+        name: evict-timeout
+        type: u32
+      -
+        name: non-hh-weight
+        type: u32
+  -
+    name: tc-htb-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-htb-opt
+      -
+        name: init
+        type: binary
+        struct: tc-htb-glob
+      -
+        name: ctab
+        type: binary
+      -
+        name: rtab
+        type: binary
+      -
+        name: direct-qlen
+        type: u32
+      -
+        name: rate64
+        type: u64
+      -
+        name: ceil64
+        type: u64
+      -
+        name: pad
+        type: pad
+      -
+        name: offload
+        type: flag
+  -
+    name: tc-matchall-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: flags
+        type: u32
+      -
+        name: pcnt
+        type: binary
+        struct: tc-matchall-pcnt
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-etf-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-etf-qopt
+  -
+    name: tc-ets-attrs
+    attributes:
+      -
+        name: nbands
+        type: u8
+      -
+        name: nstrict
+        type: u8
+      -
+        name: quanta
+        type: nest
+        nested-attributes: tc-ets-attrs
+      -
+        name: quanta-band
+        type: u32
+        multi-attr: true
+      -
+        name: priomap
+        type: nest
+        nested-attributes: tc-ets-attrs
+      -
+        name: priomap-band
+        type: u8
+        multi-attr: true
+  -
+    name: tc-fq-attrs
+    attributes:
+      -
+        name: plimit
+        type: u32
+        doc: Limit of total number of packets in queue
+      -
+        name: flow-plimit
+        type: u32
+        doc: Limit of packets per flow
+      -
+        name: quantum
+        type: u32
+        doc: RR quantum
+      -
+        name: initial-quantum
+        type: u32
+        doc: RR quantum for new flow
+      -
+        name: rate-enable
+        type: u32
+        doc: Enable / disable rate limiting
+      -
+        name: flow-default-rate
+        type: u32
+        doc: Obsolete, do not use
+      -
+        name: flow-max-rate
+        type: u32
+        doc: Per flow max rate
+      -
+        name: buckets-log
+        type: u32
+        doc: log2(number of buckets)
+      -
+        name: flow-refill-delay
+        type: u32
+        doc: Flow credit refill delay in usec
+      -
+        name: orphan-mask
+        type: u32
+        doc: Mask applied to orphaned skb hashes
+      -
+        name: low-rate-threshold
+        type: u32
+        doc: Per packet delay under this rate
+      -
+        name: ce-threshold
+        type: u32
+        doc: DCTCP-like CE marking threshold
+      -
+        name: timer-slack
+        type: u32
+      -
+        name: horizon
+        type: u32
+        doc: Time horizon in usec
+      -
+        name: horizon-drop
+        type: u8
+        doc: Drop packets beyond horizon, or cap their EDT
+      -
+        name: priomap
+        type: binary
+        struct: tc-prio-qopt
+      -
+        name: weights
+        type: binary
+        sub-type: s32
+        doc: Weights for each band
+  -
+    name: tc-fq-codel-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: interval
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: ce-threshold
+        type: u32
+      -
+        name: drop-batch-size
+        type: u32
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: ce-threshold-selector
+        type: u8
+      -
+        name: ce-threshold-mask
+        type: u8
+  -
+    name: tc-fq-pie-attrs
+    attributes:
+      -
+        name: limit
+        type: u32
+      -
+        name: flows
+        type: u32
+      -
+        name: target
+        type: u32
+      -
+        name: tupdate
+        type: u32
+      -
+        name: alpha
+        type: u32
+      -
+        name: beta
+        type: u32
+      -
+        name: quantum
+        type: u32
+      -
+        name: memory-limit
+        type: u32
+      -
+        name: ecn-prob
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: bytemode
+        type: u32
+      -
+        name: dq-rate-estimator
+        type: u32
+  -
+    name: tc-netem-attrs
+    attributes:
+      -
+        name: corr
+        type: binary
+        struct: tc-netem-corr
+      -
+        name: delay-dist
+        type: binary
+        sub-type: s16
+      -
+        name: reorder
+        type: binary
+        struct: tc-netem-reorder
+      -
+        name: corrupt
+        type: binary
+        struct: tc-netem-corrupt
+      -
+        name: loss
+        type: nest
+        nested-attributes: tc-netem-loss-attrs
+      -
+        name: rate
+        type: binary
+        struct: tc-netem-rate
+      -
+        name: ecn
+        type: u32
+      -
+        name: rate64
+        type: u64
+      -
+        name: pad
+        type: u32
+      -
+        name: latency64
+        type: s64
+      -
+        name: jitter64
+        type: s64
+      -
+        name: slot
+        type: binary
+        struct: tc-netem-slot
+      -
+        name: slot-dist
+        type: binary
+        sub-type: s16
+      -
+        name: prng-seed
+        type: u64
+  -
+    name: tc-netem-loss-attrs
+    attributes:
+      -
+        name: gi
+        type: binary
+        doc: General Intuitive - 4 state model
+        struct: tc-netem-gimodel
+      -
+        name: ge
+        type: binary
+        doc: Gilbert Elliot models
+        struct: tc-netem-gemodel
+  -
+    name: tc-pie-attrs
+    attributes:
+      -
+        name: target
+        type: u32
+      -
+        name: limit
+        type: u32
+      -
+        name: tupdate
+        type: u32
+      -
+        name: alpha
+        type: u32
+      -
+        name: beta
+        type: u32
+      -
+        name: ecn
+        type: u32
+      -
+        name: bytemode
+        type: u32
+      -
+        name: dq-rate-estimator
+        type: u32
+  -
+    name: tc-police-attrs
+    attributes:
+      -
+        name: tbf
+        type: binary
+        struct: tc-police
+      -
+        name: rate
+        type: binary
+      -
+        name: peakrate
+        type: binary
+      -
+        name: avrate
+        type: u32
+      -
+        name: result
+        type: u32
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: pad
+        type: pad
+      -
+        name: rate64
+        type: u64
+      -
+        name: peakrate64
+        type: u64
+      -
+        name: pktrate64
+        type: u64
+      -
+        name: pktburst64
+        type: u64
+  -
+    name: tc-qfq-attrs
+    attributes:
+      -
+        name: weight
+        type: u32
+      -
+        name: lmax
+        type: u32
+  -
+    name: tc-red-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-red-qopt
+      -
+        name: stab
+        type: binary
+      -
+        name: max-p
+        type: u32
+      -
+        name: flags
+        type: bitfield32
+      -
+        name: early-drop-block
+        type: u32
+      -
+        name: mark-block
+        type: u32
+  -
+    name: tc-route-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: to
+        type: u32
+      -
+        name: from
+        type: u32
+      -
+        name: iif
+        type: u32
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+  -
+    name: tc-taprio-attrs
+    attributes:
+      -
+        name: priomap
+        type: binary
+        struct: tc-mqprio-qopt
+      -
+        name: sched-entry-list
+        type: nest
+        nested-attributes: tc-taprio-sched-entry-list
+      -
+        name: sched-base-time
+        type: s64
+      -
+        name: sched-single-entry
+        type: nest
+        nested-attributes: tc-taprio-sched-entry
+      -
+        name: sched-clockid
+        type: s32
+      -
+        name: pad
+        type: pad
+      -
+        name: admin-sched
+        type: binary
+      -
+        name: sched-cycle-time
+        type: s64
+      -
+        name: sched-cycle-time-extension
+        type: s64
+      -
+        name: flags
+        type: u32
+      -
+        name: txtime-delay
+        type: u32
+      -
+        name: tc-entry
+        type: nest
+        nested-attributes: tc-taprio-tc-entry-attrs
+  -
+    name: tc-taprio-sched-entry-list
+    attributes:
+      -
+        name: entry
+        type: nest
+        nested-attributes: tc-taprio-sched-entry
+        multi-attr: true
+  -
+    name: tc-taprio-sched-entry
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: cmd
+        type: u8
+      -
+        name: gate-mask
+        type: u32
+      -
+        name: interval
+        type: u32
+  -
+    name: tc-taprio-tc-entry-attrs
+    attributes:
+      -
+        name: index
+        type: u32
+      -
+        name: max-sdu
+        type: u32
+      -
+        name: fp
+        type: u32
+  -
+    name: tc-tbf-attrs
+    attributes:
+      -
+        name: parms
+        type: binary
+        struct: tc-tbf-qopt
+      -
+        name: rtab
+        type: binary
+      -
+        name: ptab
+        type: binary
+      -
+        name: rate64
+        type: u64
+      -
+        name: prate4
+        type: u64
+      -
+        name: burst
+        type: u32
+      -
+        name: pburst
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-sample-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-gen
+      -
+        name: rate
+        type: u32
+      -
+        name: trunc-size
+        type: u32
+      -
+        name: psample-group
+        type: u32
+      -
+        name: pad
+        type: pad
+  -
+    name: tc-act-gact-attrs
+    attributes:
+      -
+        name: tm
+        type: binary
+        struct: tcf-t
+      -
+        name: parms
+        type: binary
+        struct: tc-gen
+      -
+        name: prob
+        type: binary
+        struct: tc-gact-p
+      -
+        name: pad
+        type: pad
+  -
+    name: tca-stab-attrs
+    attributes:
+      -
+        name: base
+        type: binary
+        struct: tc-sizespec
+      -
+        name: data
+        type: binary
+  -
+    name: tca-stats-attrs
+    attributes:
+      -
+        name: basic
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: rate-est
+        type: binary
+        struct: gnet-stats-rate-est
+      -
+        name: queue
+        type: binary
+        struct: gnet-stats-queue
+      -
+        name: app
+        type: sub-message
+        sub-message: tca-stats-app-msg
+        selector: kind
+      -
+        name: rate-est64
+        type: binary
+        struct: gnet-stats-rate-est64
+      -
+        name: pad
+        type: pad
+      -
+        name: basic-hw
+        type: binary
+        struct: gnet-stats-basic
+      -
+        name: pkt64
+        type: u64
+  -
+    name: tc-u32-attrs
+    attributes:
+      -
+        name: classid
+        type: u32
+      -
+        name: hash
+        type: u32
+      -
+        name: link
+        type: u32
+      -
+        name: divisor
+        type: u32
+      -
+        name: sel
+        type: binary
+        struct: tc-u32-sel
+      -
+        name: police
+        type: nest
+        nested-attributes: tc-police-attrs
+      -
+        name: act
+        type: indexed-array
+        sub-type: nest
+        nested-attributes: tc-act-attrs
+      -
+        name: indev
+        type: string
+      -
+        name: pcnt
+        type: binary
+        struct: tc-u32-pcnt
+      -
+        name: mark
+        type: binary
+        struct: tc-u32-mark
+      -
+        name: flags
+        type: u32
+      -
+        name: pad
+        type: pad
+
+sub-messages:
+  -
+    name: tc-options-msg
+    formats:
+      -
+        value: basic
+        attribute-set: tc-basic-attrs
+      -
+        value: bpf
+        attribute-set: tc-bpf-attrs
+      -
+        value: bfifo
+        fixed-header: tc-fifo-qopt
+      -
+        value: cake
+        attribute-set: tc-cake-attrs
+      -
+        value: cbs
+        attribute-set: tc-cbs-attrs
+      -
+        value: cgroup
+        attribute-set: tc-cgroup-attrs
+      -
+        value: choke
+        attribute-set: tc-choke-attrs
+      -
+        value: clsact # no content
+      -
+        value: codel
+        attribute-set: tc-codel-attrs
+      -
+        value: drr
+        attribute-set: tc-drr-attrs
+      -
+        value: etf
+        attribute-set: tc-etf-attrs
+      -
+        value: ets
+        attribute-set: tc-ets-attrs
+      -
+        value: flow
+        attribute-set: tc-flow-attrs
+      -
+        value: flower
+        attribute-set: tc-flower-attrs
+      -
+        value: fq
+        attribute-set: tc-fq-attrs
+      -
+        value: fq_codel
+        attribute-set: tc-fq-codel-attrs
+      -
+        value: fq_pie
+        attribute-set: tc-fq-pie-attrs
+      -
+        value: fw
+        attribute-set: tc-fw-attrs
+      -
+        value: gred
+        attribute-set: tc-gred-attrs
+      -
+        value: hfsc
+        fixed-header: tc-hfsc-qopt
+      -
+        value: hhf
+        attribute-set: tc-hhf-attrs
+      -
+        value: htb
+        attribute-set: tc-htb-attrs
+      -
+        value: ingress # no content
+      -
+        value: matchall
+        attribute-set: tc-matchall-attrs
+      -
+        value: mq # no content
+      -
+        value: mqprio
+        fixed-header: tc-mqprio-qopt
+      -
+        value: multiq
+        fixed-header: tc-multiq-qopt
+      -
+        value: netem
+        fixed-header: tc-netem-qopt
+        attribute-set: tc-netem-attrs
+      -
+        value: pfifo
+        fixed-header: tc-fifo-qopt
+      -
+        value: pfifo_fast
+        fixed-header: tc-prio-qopt
+      -
+        value: pfifo_head_drop
+        fixed-header: tc-fifo-qopt
+      -
+        value: pie
+        attribute-set: tc-pie-attrs
+      -
+        value: plug
+        fixed-header: tc-plug-qopt
+      -
+        value: prio
+        fixed-header: tc-prio-qopt
+      -
+        value: qfq
+        attribute-set: tc-qfq-attrs
+      -
+        value: red
+        attribute-set: tc-red-attrs
+      -
+        value: route
+        attribute-set: tc-route-attrs
+      -
+        value: sfb
+        fixed-header: tc-sfb-qopt
+      -
+        value: sfq
+        fixed-header: tc-sfq-qopt-v1
+      -
+        value: taprio
+        attribute-set: tc-taprio-attrs
+      -
+        value: tbf
+        attribute-set: tc-tbf-attrs
+      -
+        value: u32
+        attribute-set: tc-u32-attrs
+  -
+    name: tc-act-options-msg
+    formats:
+      -
+        value: bpf
+        attribute-set: tc-act-bpf-attrs
+      -
+        value: connmark
+        attribute-set: tc-act-connmark-attrs
+      -
+        value: csum
+        attribute-set: tc-act-csum-attrs
+      -
+        value: ct
+        attribute-set: tc-act-ct-attrs
+      -
+        value: ctinfo
+        attribute-set: tc-act-ctinfo-attrs
+      -
+        value: gact
+        attribute-set: tc-act-gact-attrs
+      -
+        value: gate
+        attribute-set: tc-act-gate-attrs
+      -
+        value: ife
+        attribute-set: tc-act-ife-attrs
+      -
+        value: mirred
+        attribute-set: tc-act-mirred-attrs
+      -
+        value: mpls
+        attribute-set: tc-act-mpls-attrs
+      -
+        value: nat
+        attribute-set: tc-act-nat-attrs
+      -
+        value: pedit
+        attribute-set: tc-act-pedit-attrs
+      -
+        value: police
+        attribute-set: tc-act-police-attrs
+      -
+        value: sample
+        attribute-set: tc-act-sample-attrs
+      -
+        value: simple
+        attribute-set: tc-act-simple-attrs
+      -
+        value: skbedit
+        attribute-set: tc-act-skbedit-attrs
+      -
+        value: skbmod
+        attribute-set: tc-act-skbmod-attrs
+      -
+        value: tunnel_key
+        attribute-set: tc-act-tunnel-key-attrs
+      -
+        value: vlan
+        attribute-set: tc-act-vlan-attrs
+  -
+    name: tca-stats-app-msg
+    formats:
+      -
+        value: cake
+        attribute-set: tc-cake-stats-attrs
+      -
+        value: choke
+        fixed-header: tc-choke-xstats
+      -
+        value: codel
+        fixed-header: tc-codel-xstats
+      -
+        value: fq
+        fixed-header: tc-fq-qd-stats
+      -
+        value: fq_codel
+        fixed-header: tc-fq-codel-xstats
+      -
+        value: fq_pie
+        fixed-header: tc-fq-pie-xstats
+      -
+        value: hhf
+        fixed-header: tc-hhf-xstats
+      -
+        value: pie
+        fixed-header: tc-pie-xstats
+      -
+        value: red
+        fixed-header: tc-red-xstats
+      -
+        value: sfb
+        fixed-header: tc-sfb-xstats
+      -
+        value: sfq
+        fixed-header: tc-sfq-xstats
+
+operations:
+  enum-model: directional
+  list:
+    -
+      name: newqdisc
+      doc: Create new tc qdisc.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 36
+          attributes: &create-params
+            - kind
+            - options
+            - rate
+            - chain
+            - ingress-block
+            - egress-block
+    -
+      name: delqdisc
+      doc: Delete existing tc qdisc.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 37
+    -
+      name: getqdisc
+      doc: Get / dump tc qdisc information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 38
+          attributes:
+            - dump-invisible
+        reply:
+          value: 36
+          attributes: &tc-all
+            - kind
+            - options
+            - stats
+            - xstats
+            - rate
+            - fcnt
+            - stats2
+            - stab
+            - chain
+            - ingress-block
+            - egress-block
+    -
+      name: newtclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 40
+          attributes: *create-params
+    -
+      name: deltclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 41
+    -
+      name: gettclass
+      doc: Get / dump tc traffic class information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 42
+        reply:
+          value: 40
+          attributes: *tc-all
+    -
+      name: newtfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 44
+          attributes: *create-params
+    -
+      name: deltfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 45
+          attributes:
+            - chain
+            - kind
+    -
+      name: gettfilter
+      doc: Get / dump tc filter information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 46
+          attributes:
+            - chain
+            - kind
+        reply:
+          value: 44
+          attributes: *tc-all
+      dump:
+        request:
+          value: 46
+          attributes:
+            - chain
+            - dump-flags
+        reply:
+          value: 44
+          attributes: *tc-all
+    -
+      name: newchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 100
+          attributes: *create-params
+    -
+      name: delchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 101
+          attributes:
+            - chain
+    -
+      name: getchain
+      doc: Get / dump tc chain information.
+      attribute-set: tc-attrs
+      fixed-header: tcmsg
+      do:
+        request:
+          value: 102
+          attributes:
+            - chain
+        reply:
+          value: 100
+          attributes: *tc-all
+
+mcast-groups:
+  list:
+    -
+      name: rtnlgrp-tc
+      value: 4
diff --git a/source/specs/tcp_metrics.yaml b/source/specs/tcp_metrics.yaml
new file mode 100644
index 000000000000..1bd94f43e526
--- /dev/null
+++ b/source/specs/tcp_metrics.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: tcp_metrics
+
+protocol: genetlink-legacy
+
+doc: |
+  Management interface for TCP metrics.
+
+c-family-name: tcp-metrics-genl-name
+c-version-name: tcp-metrics-genl-version
+max-by-define: true
+kernel-policy: global
+
+definitions:
+  -
+    name: tcp-fastopen-cookie-max
+    type: const
+    value: 16
+
+attribute-sets:
+  -
+    name: tcp-metrics
+    name-prefix: tcp-metrics-attr-
+    attributes:
+      -
+        name: addr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: addr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: age
+        type: u64
+      -
+        name: tw-tsval
+        type: u32
+        doc: unused
+      -
+        name: tw-ts-stamp
+        type: s32
+        doc: unused
+      -
+        name: vals
+        type: nest
+        nested-attributes: metrics
+      -
+        name: fopen-mss
+        type: u16
+      -
+        name: fopen-syn-drops
+        type: u16
+      -
+        name: fopen-syn-drop-ts
+        type: u64
+      -
+        name: fopen-cookie
+        type: binary
+        checks:
+          min-len: tcp-fastopen-cookie-max
+      -
+        name: saddr-ipv4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr-ipv6
+        type: binary
+        checks:
+          min-len: 16
+        byte-order: big-endian
+        display-hint: ipv6
+      -
+        name: pad
+        type: pad
+
+  -
+    name: metrics
+    # Intentionally don't define the name-prefix, see below.
+    doc: |
+      Attributes with metrics. Note that the values here do not match
+      the TCP_METRIC_* defines in the kernel, because kernel defines
+      are off-by one (e.g. rtt is defined as enum 0, while netlink carries
+      attribute type 1).
+    attributes:
+      -
+        name: rtt
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in msecs with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar
+        type: u32
+        doc: |
+          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
+          (left-shift by 2 to get the msec value).
+      -
+        name: ssthresh
+        type: u32
+        doc: Slow Start THRESHold.
+      -
+        name: cwnd
+        type: u32
+        doc: Congestion Window.
+      -
+        name: reodering
+        type: u32
+        doc: Reodering metric.
+      -
+        name: rtt-us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 3 bits fractional
+          (left-shift by 3 to get the msec value).
+      -
+        name: rttvar-us
+        type: u32
+        doc: |
+          Round Trip Time (RTT), in usecs, with 2 bits fractional
+          (left-shift by 3 to get the msec value).
+
+operations:
+  list:
+    -
+      name: get
+      doc: Retrieve metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+
+      do:
+        request: &sel_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+        reply: &all_attrs
+          attributes:
+            - addr-ipv4
+            - addr-ipv6
+            - saddr-ipv4
+            - saddr-ipv6
+            - age
+            - vals
+            - fopen-mss
+            - fopen-syn-drops
+            - fopen-syn-drop-ts
+            - fopen-cookie
+      dump:
+        reply: *all_attrs
+
+    -
+      name: del
+      doc: Delete metrics.
+      attribute-set: tcp-metrics
+
+      dont-validate: [ strict, dump ]
+      flags: [ admin-perm ]
+
+      do:
+        request: *sel_attrs
diff --git a/source/specs/team.yaml b/source/specs/team.yaml
new file mode 100644
index 000000000000..c13529e011c9
--- /dev/null
+++ b/source/specs/team.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Cla=
use)
+
+name: team
+
+protocol: genetlink-legacy
+
+doc: |
+  Network team device driver.
+
+c-family-name: team-genl-name
+c-version-name: team-genl-version
+kernel-policy: global
+uapi-header: linux/if_team.h
+
+definitions:
+  -
+    name: string-max-len
+    type: const
+    value: 32
+  -
+    name: genl-change-event-mc-grp-name
+    type: const
+    value: change_event
+
+attribute-sets:
+  -
+    name: team
+    doc:
+      The team nested layout of get/set msg looks like
+          [TEAM_ATTR_LIST_OPTION]
+              [TEAM_ATTR_ITEM_OPTION]
+                  [TEAM_ATTR_OPTION_*], ...
+              [TEAM_ATTR_ITEM_OPTION]
+                  [TEAM_ATTR_OPTION_*], ...
+              ...
+          [TEAM_ATTR_LIST_PORT]
+              [TEAM_ATTR_ITEM_PORT]
+                  [TEAM_ATTR_PORT_*], ...
+              [TEAM_ATTR_ITEM_PORT]
+                  [TEAM_ATTR_PORT_*], ...
+              ...
+    name-prefix: team-attr-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: team-ifindex
+        type: u32
+      -
+        name: list-option
+        type: nest
+        nested-attributes: item-option
+      -
+        name: list-port
+        type: nest
+        nested-attributes: item-port
+  -
+    name: item-option
+    name-prefix: team-attr-item-
+    attr-cnt-name: __team-attr-item-option-max
+    attr-max-name: team-attr-item-option-max
+    attributes:
+      -
+        name: option-unspec
+        type: unused
+        value: 0
+      -
+        name: option
+        type: nest
+        nested-attributes: attr-option
+  -
+    name: attr-option
+    name-prefix: team-attr-option-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: name
+        type: string
+        checks:
+          max-len: string-max-len
+          unterminated-ok: true
+      -
+        name: changed
+        type: flag
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+      -
+        name: removed
+        type: flag
+      -
+        name: port-ifindex
+        type: u32
+        doc: for per-port options
+      -
+        name: array-index
+        type: u32
+        doc: for array options
+  -
+    name: item-port
+    name-prefix: team-attr-item-
+    attr-cnt-name: __team-attr-item-port-max
+    attr-max-name: team-attr-item-port-max
+    attributes:
+      -
+        name: port-unspec
+        type: unused
+        value: 0
+      -
+        name: port
+        type: nest
+        nested-attributes: attr-port
+  -
+    name: attr-port
+    name-prefix: team-attr-port-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: ifindex
+        type: u32
+      -
+        name: changed
+        type: flag
+      -
+        name: linkup
+        type: flag
+      -
+        name: speed
+        type: u32
+      -
+        name: duplex
+        type: u8
+      -
+        name: removed
+        type: flag
+
+operations:
+  list:
+    -
+      name: noop
+      doc: No operation
+      value: 0
+      attribute-set: team
+      dont-validate: [ strict ]
+
+      do:
+        # Actually it only reply the team netlink family
+        reply:
+          attributes:
+            - team-ifindex
+
+    -
+      name: options-set
+      doc: Set team options
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request: &option_attrs
+          attributes:
+            - team-ifindex
+            - list-option
+        reply: *option_attrs
+
+    -
+      name: options-get
+      doc: Get team options info
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply: *option_attrs
+
+    -
+      name: port-list-get
+      doc: Get team ports info
+      attribute-set: team
+      dont-validate: [ strict ]
+      flags: [ admin-perm ]
+
+      do:
+        request:
+          attributes:
+            - team-ifindex
+        reply: &port_attrs
+          attributes:
+            - team-ifindex
+            - list-port






