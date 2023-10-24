Return-Path: <netdev+bounces-44006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400067D5CDD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAB21C20BE8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84063D3BA;
	Tue, 24 Oct 2023 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QH2Ig5DC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5C38DCC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:03:32 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9F10CE;
	Tue, 24 Oct 2023 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=U6f71o0M8j67PJk0jApPuiTvaRlL6vkWjyyB+z+T3ss=;
	t=1698181411; x=1699391011; b=QH2Ig5DCPYpmPrdBXvw2+qP34j5AYNlUF7EwT0qStk2gkIR
	NosE8Gv43zzB9/NGHUzI/WvEAReVJ50UvKUluNKnyOgkoPQGDSjmJS6L5J3JN09U5QDL3jrAzc5CT
	qfNDdRM2ZpI5BVBQs7OLau/IWB7M8p3ayaHfWm51b8dge08sAolA8yANpxuoD5A7qmCg2H9wmnOfg
	0O3t+hyEthwvkT3txrfaKJ8VS2Qdd2Zx4X/5BMirEYv43TM62Pr7WMjTNPUxE7DPlNTFGJEI+sKNT
	qpg5t6Ki74uFmmxqMRhJw+9W93MWH9y7R2iO66Wyu687l4UUHdQZOtjlj7bEM/3w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvOYj-00000001bwn-0gTI;
	Tue, 24 Oct 2023 23:03:29 +0200
Message-ID: <03a72c1e38a8967e477ea3edeaff3839c6149899.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2023-10-24
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date: Tue, 24 Oct 2023 23:03:28 +0200
In-Reply-To: <20231024140146.0d756a96@kernel.org>
References: <20231024103540.19198-2-johannes@sipsolutions.net>
	 <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
	 <1020bbec6fd85d55f0862b1aa147afbd25de3e74.camel@sipsolutions.net>
	 <20231024135208.3e40b69a@kernel.org>
	 <f53b015defece9c4b29fbecfaa6fc50d2f299a39.camel@sipsolutions.net>
	 <20231024140146.0d756a96@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-10-24 at 14:01 -0700, Jakub Kicinski wrote:
> On Tue, 24 Oct 2023 22:54:50 +0200 Johannes Berg wrote:
> > > > If not, I can resolve this conflict and we'll include it in the nex=
t
> > > > (and last) wireless-next pull request, which will be going out Thur=
sday
> > > > morning (Europe time.) =20
> > >=20
> > > Sounds good! But do you need to do the resolution to put something=
=20
> > > on top? Otherwise we can deal with the conflict when pulling. =20
> >=20
> > No, not really, nothing left that's not in wireless-next already (I
> > think), except maybe some tiny cleanups.
> >=20
> > Just trying to make it easier for you, even if it's really not a comple=
x
> > conflict :)
>=20
> I think "Linus rules" would dictate that cross-merges to hide conflicts
> are a bad thing. We don't have much to win so let's stick to that :)

Fair enough :)

> Hopefully I can deal with the resolution, but if you want to be 100%
> sure - you can drop a git-rerere resolution somewhere I can fetch it.

No need I think, just the return codes changed in the -next version for
better skb drop reasons :)

johannes

