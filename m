Return-Path: <netdev+bounces-197484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46AAD8C26
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE753AA38A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A543D76;
	Fri, 13 Jun 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHVcayBb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700023C26;
	Fri, 13 Jun 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817837; cv=none; b=efOnIHmuvv3WSpNPxRmRG5Cw93YC3uH4D6eQLDXuvCB4H822otda3TA8WSD3INpA2ALAeXAiv3NPN9Oh/g9mO1B4zIplDM06cXDhuIb5OrDXFWhfW4pkv5MGjk04GcKHkHNCO37aTG74ONbDqw+cnokNA/0W80Xv3Bkzgt6537g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817837; c=relaxed/simple;
	bh=IJX1C2H88d25bNe5hXlRqag8Mz3+ciOE8mS6zl1EXxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4xTj7Fc50A3IAzHBYc9PkNPBTYcJd3nE2FaDZThzFu4IVav4WpzZIMFD+YOmUA8FJeDWUxc6uVcMScUwkc+xTakfGbGeG8nqXqHMd4HjzY6uEVadl9Yd5koO0tKiFKJatbMXmt8k/0koJuDCakNbuSVLtHO6HvL3bARJF8DcXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHVcayBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD4FC4CEE3;
	Fri, 13 Jun 2025 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817837;
	bh=IJX1C2H88d25bNe5hXlRqag8Mz3+ciOE8mS6zl1EXxY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHVcayBbqOyNBLQpD0xErm2r6KmC5mjKTRF9konGfLgYKMp1AKzsj0D9XLW33dMpZ
	 W3e+T4xkqnlJkvwJMUvmLTG6iYL5W1S9c2jNqi3JubRp2FI+VXeHrpQKuy/wSEhTKQ
	 9H6+WxXJ8BwNDKcT4mh0WkehtDPIjh+oZpXiEUgSucObS8YoVRNKZr8cmRgokWZMem
	 0PhunEUD0uDq39R4/ObL2VPB/DQSJj1Oy6WiiPjc3McPXh76DFBJqLyG0r5uFyxuyF
	 ByV0OCMBji2NcKwDf+y8hq6sijchfbMSp61IJkbhndSEEmffu7WAhvGlbKn/VXVSu8
	 vQNSJMHNvvg6g==
Date: Fri, 13 Jun 2025 14:30:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Ignacio Encinas Rubio"
 <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>, "Marco Elver"
 <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben Wauters"
 <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 12/12] docs: conf.py: don't handle yaml files outside
 Netlink specs
Message-ID: <20250613143030.3f78f367@foz.lan>
In-Reply-To: <m2h60jn9j0.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<d4b8d090ce728fce9ff06557565409539a8b936b.1749723671.git.mchehab+huawei@kernel.org>
	<m2h60jn9j0.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Fri, 13 Jun 2025 12:52:35 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > The parser_yaml extension already has a logic to prevent
> > handing all yaml documents. However, if we don't also exclude
> > the patterns at conf.py, the build time would increase a lot,
> > and warnings like those would be generated:
> >
> >     Documentation/netlink/genetlink.yaml: WARNING: o documento n=C3=A3o=
 est=C3=A1 inclu=C3=ADdo em nenhum toctree
> >     Documentation/netlink/genetlink-c.yaml: WARNING: o documento n=C3=
=A3o est=C3=A1 inclu=C3=ADdo em nenhum toctree
> >     Documentation/netlink/genetlink-legacy.yaml: WARNING: o documento n=
=C3=A3o est=C3=A1 inclu=C3=ADdo em nenhum toctree
> >     Documentation/netlink/index.rst: WARNING: o documento n=C3=A3o est=
=C3=A1 inclu=C3=ADdo em nenhum toctree
> >     Documentation/netlink/netlink-raw.yaml: WARNING: o documento n=C3=
=A3o est=C3=A1 inclu=C3=ADdo em nenhum toctree
> >
> > Add some exclusion rules to prevent that.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/conf.py | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index add6ce78dd80..b8668bcaf090 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -222,7 +222,11 @@ language =3D 'en'
> > =20
> >  # List of patterns, relative to source directory, that match files and
> >  # directories to ignore when looking for source files.
> > -exclude_patterns =3D ['output']
> > +exclude_patterns =3D [
> > +	'output',
> > +	'devicetree/bindings/**.yaml',
> > +	'netlink/*.yaml',
> > +] =20
>=20
> Please merge this with the earlier patch that changes these lines so
> that the series doesn't contain unnecessary intermediate steps.

OK.

>=20
> >  # The reST default role (used for this markup: `text`) to use for all
> >  # documents. =20



Thanks,
Mauro

