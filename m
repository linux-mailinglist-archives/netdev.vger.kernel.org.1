Return-Path: <netdev+bounces-31109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E278B7F7
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB40D280EDD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC48D14003;
	Mon, 28 Aug 2023 19:17:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9FD29AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9624C433C7;
	Mon, 28 Aug 2023 19:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693250222;
	bh=Xd0NPI5AINSiQp3BWTIgRusdMob+S292Mt1WaM6gEAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhLEyR/wlE+GSa4Wnx/joKfA6iNF9Mch4GO/Btp6kEjtKLY2CJB5QRHPcypCkmDiz
	 6ye5gMoR2QRLpjoH1U7hNx6ygjctR1XuO6LvgbsMR/5E1qu5HtQq3crqnbMnuuTzHn
	 hCg7RYXzeUxsFDTfdFkGIIjfu6MMgnhMnO528MileUvi5LP2cbUZds6exj0nB842Ao
	 s89nj1eH3HBo2RMydzZsZa7KCBmh3c06QRpJOiGaXBpAwWpHp0Hjcut6MCCiU0rCXU
	 crgdWjNBnOsBeHYqGnhyH51C+4WbmIjid6dBk+7zOmdLGMnXgCKfiXqrX1gLHczool
	 BB9hqqjEIDd+g==
Date: Mon, 28 Aug 2023 12:17:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] docs: netdev: document patchwork patch states
Message-ID: <20230828121700.4a319a1e@kernel.org>
In-Reply-To: <5b7d9eff-cc95-fe37-6762-ef08e153213c@infradead.org>
References: <20230828184447.2142383-1-kuba@kernel.org>
	<5b7d9eff-cc95-fe37-6762-ef08e153213c@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Aug 2023 12:05:45 -0700 Randy Dunlap wrote:
> >  The "State" field will tell you exactly where things are at with your
> > -patch. Patches are indexed by the ``Message-ID`` header of the emails
> > +patch: =20
>=20
>                                                       of the patch's emai=
l.

The diff may be a little confusing. The full sentence is below..

> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +Patch state        Description
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +New, Under review  pending review, patch is in the maintainer=E2=80=99=
s queue for review
> > +Accepted           patch was applied to the appropriate networking tre=
e, this is
> > +                   usually set automatically by the pw-bot
> > +Needs ACK          waiting for an ack from an area maintainer or testi=
ng
> > +Changes requested  patch has not passed the review, new revision is ex=
pected
> > +                   with appropriate code and commit message changes
> > +Rejected           patch has been rejected and new revision is not exp=
ected
> > +Not applicable     patch is expected to be applied outside of the netw=
orking
> > +                   subsystem
> > +Awaiting upstream  patch should be reviewed and handled by appropriate
> > +                   sub-maintainer, who will send it on to the networki=
ng trees
> > +Deferred           patch needs to be reposted later, usually due to de=
pendency
> > +                   or because it was posted for a closed tree
> > +Superseded         new version of the patch was posted, usually set by=
 the
> > +                   pw-bot
> > +RFC                not to be applied, usually not in maintainer=E2=80=
=99s review queue,
> > +                   pw-bot can automatically set patches to this state =
based
> > +		   on subject tags =20
>=20
> Nit:
> Above line uses tabs for indentation. All other lines here use spaces.

Thanks, will fix.

> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > +
> > +Patches are indexed by the ``Message-ID`` header of the emails
> >  which carried them so if you have trouble finding your patch append

..here.

