Return-Path: <netdev+bounces-82311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FE88D2F6
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43521C2D47E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082813E055;
	Tue, 26 Mar 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbr52LBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3953FD4
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497356; cv=none; b=KdKrL65EDfuSmqRsEBiBvTSAfUEvDZc51iq7Ew61HVyUxDw18sGYnemo/hYrGkXOAy/st2kn/l7j7RC1R4Mgw3CeIeM9e272Q/8WUwV8PHwavdmVtGiooMRNBXpCWcx0Dp+t5sKRYlSnAVJTre/cwhIHFyHPUPxqirYHyfdgXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497356; c=relaxed/simple;
	bh=nTsjuWRBzs6ll6Ln6p1WmIeya74BF+wioNG3VxeygSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFoAccZevn8vwF7CzR2jVxZuywoJ2yfHDzi3jW43RlhFiPXcjEYSBvcxF+C39XrQAkm2KeIpD+9vB31Rc1HWy2QmoIkflK1Tw94FZ1Dc3FkDpxLDe3CMUj478fiu8DVXOPia3rzeDx/kd4dRdtB28572zfDe8P4J3/s8M9ft2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbr52LBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB2C433C7;
	Tue, 26 Mar 2024 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711497355;
	bh=nTsjuWRBzs6ll6Ln6p1WmIeya74BF+wioNG3VxeygSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tbr52LBF3VFSRGzP/8QnAlFF4dZwJvSJxKJlVyq5uaw8OzVvMRgkS6w6IQfTK3ncj
	 p2ktA1Riqzo0COWMM2c+KlahS0sHNr6E2YEJSwJ8ZTwicUDqoevFfUdvNbUuXbINdM
	 nKlJHHqn9j3+p2bvtr8MS6jVmNiu60hydBq1UpIOU0q493IFu3+ykMd6PQueCEW49e
	 fFbzwacldKbh48GGCGnT7GD1QnkcfZT6UKfBqpkYvN+emggiCPypKAwmiHyE7WyQdd
	 Q+E6jgcO7AWdXVjBpHaCJs2TocLOYTozlwxl00gMBwGNotd1ThwdEPVxdlXhEufP89
	 Lhjd5McpdtvxQ==
Date: Tue, 26 Mar 2024 16:55:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
Message-ID: <20240326165554.541551c3@kernel.org>
In-Reply-To: <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
References: <20240326133412.47cf6d99@kernel.org>
	<CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> On Tue, Mar 26, 2024 at 9:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Hi!
> >
> > I got a report from a user surprised/displeased that ICMP_TIME_EXCEEDED
> > breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
> > finger at Linux, RFC5461:
> >
> >    A number of TCP implementations have modified their reaction to all
> >    ICMP soft errors and treat them as hard errors when they are received
> >    for connections in the SYN-SENT or SYN-RECEIVED states.  For example,
> >    this workaround has been implemented in the Linux kernel since
> >    version 2.0.0 (released in 1996) [Linux].  However, it should be
> >    noted that this change violates section 4.2.3.9 of [RFC1122], which
> >    states that these ICMP error messages indicate soft error conditions
> >    and that, therefore, TCP MUST NOT abort the corresponding connection.
> >
> > Is there any reason we continue with this behavior or is it just that
> > nobody ever sent a patch? =20
>=20
> Back in November of 2023 Eric did merge a patch to bring the
> processing in line with section 4.2.3.9 of [RFC1122]:
>=20
> 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP
>=20
> However, the fixed behavior did not meet some expectations of Vagrant
> (see the netdev thread "Bug report connect to VM with Vagrant"), so
> for now it got reverted:
>=20
> b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving some ICMP
>=20
> I think the hope was to root-cause the Vagrant issue, fix Vagrant's
> assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
> 2024: "We will submit the patch again for 6.9, once we get to the root
> cause." But I don't think anyone has had time to do that yet.

Ah.

Thank you!!

