Return-Path: <netdev+bounces-84017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8F89553A
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EF528998E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A183CBD;
	Tue,  2 Apr 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN33QKup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C680631
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064102; cv=none; b=hHtN8RHY4zS5VodTmLJZcJ/SR5J6fTgSHFNzxVTguB9HsLHaBQNunOFjBwqHgOpghI9UrglREZ0PmGk5+7EBCklNhTylzVuXxlBipYP4VZ2WK4Alcr0G/bo+ji23gY0YjPTn6nSmJVELbbvadfgFq1YSl72WUhdIEI3mOG0COGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064102; c=relaxed/simple;
	bh=b3kmnv1FDRxwV263u4ew1pheWis3dH1OItiCNoIagzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0djfDGSSofGJF/snuGwS8Br72usfejEUpbvDRKq8ZwgGQ6YnEk6BQSmF54k7r7D+Nidu5peyMYH8satXqAEvBf9LcpyRnTSkk+PTNNEYdRMC8VzTK6RlM3KETMaKZL+x6VKoE6x0nH/Oo6g8iqdNgiztF5lDJx3DA4ysGf3Jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN33QKup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0B3C43390;
	Tue,  2 Apr 2024 13:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712064102;
	bh=b3kmnv1FDRxwV263u4ew1pheWis3dH1OItiCNoIagzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN33QKupi9NOPvpCLUY4DNWqiSyGXd4lBa+IuG63gFtpeSKMgghnynCphAZ4moJsq
	 2ZW42stgH+Kr36ffXBAWsJeBmnja5ktSCMQXhlb1clU1IyvazaT68+R75ALc9whV2n
	 69K9MM7uhzSpqXPW94CVPUhnzuMmMdJN5TbQO/bSmal3+LgH/Li9ZrHWH3wnnQeVt9
	 HVX38469AXyGFy9LXgHt4xACIhYNE3H8Jak+JGvX2uRQiVs+zmkxgQkSFH1qLVIFw/
	 FT5IeH7SNYrZF2FWcj0Wql40puqe/zDeBCuWJvqVYSkwrdJr42rxknT4xtnzMW4nY3
	 QGDvsI9oQAhNg==
Date: Tue, 2 Apr 2024 16:21:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: ICMP_PARAMETERPROB and ICMP_TIME_EXCEEDED during connect
Message-ID: <20240402132137.GJ11187@unreal>
References: <20240326133412.47cf6d99@kernel.org>
 <CADVnQymqFELYQqpoDsxh=z2XxvhMSvdUfCyjgRYeA1QaesnpEg@mail.gmail.com>
 <20240326165554.541551c3@kernel.org>
 <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJDxv2hkT7-KCaizu3r44HpT=xbvRtMXjxd-LUQS=Br8g@mail.gmail.com>

On Wed, Mar 27, 2024 at 02:05:17PM +0100, Eric Dumazet wrote:
> On Wed, Mar 27, 2024 at 12:55 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 26 Mar 2024 23:03:26 +0100 Neal Cardwell wrote:
> > > On Tue, Mar 26, 2024 at 9:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I got a report from a user surprised/displeased that ICMP_TIME_EXCEEDED
> > > > breaks connect(), while TCP RFCs say it shouldn't. Even pointing a
> > > > finger at Linux, RFC5461:
> > > >
> > > >    A number of TCP implementations have modified their reaction to all
> > > >    ICMP soft errors and treat them as hard errors when they are received
> > > >    for connections in the SYN-SENT or SYN-RECEIVED states.  For example,
> > > >    this workaround has been implemented in the Linux kernel since
> > > >    version 2.0.0 (released in 1996) [Linux].  However, it should be
> > > >    noted that this change violates section 4.2.3.9 of [RFC1122], which
> > > >    states that these ICMP error messages indicate soft error conditions
> > > >    and that, therefore, TCP MUST NOT abort the corresponding connection.
> > > >
> > > > Is there any reason we continue with this behavior or is it just that
> > > > nobody ever sent a patch?
> > >
> > > Back in November of 2023 Eric did merge a patch to bring the
> > > processing in line with section 4.2.3.9 of [RFC1122]:
> > >
> > > 0a8de364ff7a tcp: no longer abort SYN_SENT when receiving some ICMP
> > >
> > > However, the fixed behavior did not meet some expectations of Vagrant
> > > (see the netdev thread "Bug report connect to VM with Vagrant"), so
> > > for now it got reverted:
> > >
> > > b59db45d7eba tcp: Revert no longer abort SYN_SENT when receiving some ICMP
> > >
> > > I think the hope was to root-cause the Vagrant issue, fix Vagrant's
> > > assumptions, then resubmit Eric's commit. Eric mentioned on Jan 8,
> > > 2024: "We will submit the patch again for 6.9, once we get to the root
> > > cause." But I don't think anyone has had time to do that yet.
> >
> > Ah.
> >
> > Thank you!!
> 
> For the record, Leon Romanovsky brought this issue directly to Linus
> Torvalds, stating that I broke things.

Just to make it clear, Linus was involved after we didn't progress for
more than one month after initial starting "Bug report connect to VM with Vagrant",
while approaching to merge window.
https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com/

Despite long standing netdev patch flow: apply fast -> revert fast, this
patch was treated differently.

> 
> It tooks weeks before Shachar did some debugging, but with no
> conclusion I recall.

Shachar didn't do debugging, she didn't write the bisected patch.
She is verification engineer who was ready to run ANY tests and try
ANY debug patch which you wanted.

> 
> This kind of stuff makes me not very eager to work on this point.
> 

OK, so it is not important at the end.

