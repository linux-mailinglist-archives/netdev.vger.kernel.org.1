Return-Path: <netdev+bounces-81222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC475886AAF
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874A5283BD6
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783E117552;
	Fri, 22 Mar 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwrfzS6C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5416E3A8C3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104513; cv=none; b=nUe/W4yULApSc3SO6HMqf8jKD02MabZCfek6FItAq2/XpPPLKlqiBLohTLTYm9h/9NFuv9FMzam0HrLjnVGGbDO2wrMVp1amy4oJla4PoQy9W+UWyxdLEL7bYP8syNzq0r3aC5ajYExi0vJCVd0bZT7TDAnWpDWulWBgIphan7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104513; c=relaxed/simple;
	bh=GE3qRPSws677uqHztNKZKfC30ka2aP3SgK2AS2XA9Es=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=k0Tfm8Y2pouidK5DfC2nGg3APAnHktA8V+mioCn11ufHSrvxnzREbY0+BeNhyGNDDudakjjWZh+QqvFCQQ/Z7szzxdNtWBom2ECxRlepxnEJAO+bcV7LcmN0ls8HVk232Pg6HCop8yHGnARi1QaugeRZReN55WFFez3wxSg4vYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwrfzS6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C1FC43390;
	Fri, 22 Mar 2024 10:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711104511;
	bh=GE3qRPSws677uqHztNKZKfC30ka2aP3SgK2AS2XA9Es=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rwrfzS6CQOfKPMF+mb1ZXsddGFFy9UOAz1pNTGq9fJl3rwgSbwkySNRtTSz5r1F4t
	 /TLozo0gG0lXfApNeNSR/Bpjg4oolfDgLwE0W8GAD4zcXmHxfpjbRhUOX7D1UwPUv3
	 czKmVWAcIvOabVN6cLTzavBODs0ad/caibkmiHOUDq6Y/7R19vHPR0IxQn6sL4sL9S
	 h2Jhd7pY2uFc/y1V6HiRy636boNagXiOkjWXQoXCpr7H+l+xVRSBA1QPDkoftmCX68
	 wDAJoG+LOGPrkLtw4eKS3e4f3TjHNjRJEdnSl56ndutTHprScrPw5EN2UBKor4ws6f
	 /1Zq3t3gHXoYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <65fc78cfe99a2_25798a29475@willemb.c.googlers.com.notmuch>
References: <20240319093140.499123-1-atenart@kernel.org> <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch> <171086409633.4835.11427072260403202761@kwain> <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch> <171094732998.5492.6523626232845873652@kwain> <65fb4a8b1389_1faab3294c8@willemb.c.googlers.com.notmuch> <171101093713.5492.11530876509254833591@kwain> <65fc4b09a422a_2191e6294a8@willemb.c.googlers.com.notmuch> <171104177952.222877.10664469615735463255@kwain> <65fc78cfe99a2_25798a29475@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to unnecessary checksum
From: Antoine Tenart <atenart@kernel.org>
Cc: steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Date: Fri, 22 Mar 2024 11:48:28 +0100
Message-ID: <171110450850.6370.16241018889344457476@kwain>

Quoting Willem de Bruijn (2024-03-21 19:13:35)
> Antoine Tenart wrote:
> > Quoting Willem de Bruijn (2024-03-21 15:58:17)
> > > Antoine Tenart wrote:
> > > >=20
> > > > If I sum up our discussion CHECKSUM_NONE conversion is wanted,
> > > > CHECKSUM_UNNECESSARY conversion is a no-op and CHECKSUM_PARTIAL
> > > > conversion breaks things. What about we just convert CHECKSUM_NONE =
to
> > > > CHECKSUM_UNNECESSARY?
> > >=20
> > > CHECKSUM_NONE cannot be converted to CHECKSUM_UNNECESSARY in the
> > > receive path. Unless it is known to have been locally generated,
> > > this means that the packet has not been verified yet.
> >=20
> > I'm not sure to follow, non-partial checksums are being verified by
> > skb_gro_checksum_validate_zero_check in udp4/6_gro_receive before ending
> > up in udp4/6_gro_complete. That's also probably what the original commit
> > msg refers to: "After validating the csum, we mark ip_summed as
> > CHECKSUM_UNNECESSARY for fraglist GRO packets".
> >=20
> > With fraglist, the csum can then be converted to CHECKSUM_UNNECESSARY.
>=20
> Oh yes, of course.
>=20
> > Except for CHECKSUM_PARTIAL, as we discussed.
>=20
> Because that is treated as equivalent to CHECKSUM_UNNECESSARY in the
> ingress path, and if forwarded to an egress path, csum_start and
> csum_off are set correctly. Also for all segs after segmentation.
> Okay, that sounds fine then.
>=20
> There are two cases here: csum_start points to the outer header or it
> points to the inner header. I suppose that does not matter for
> correctness post segmentation.

Right. I'll send a v3 to keep the none -> unnecessary conversion and
fix build issue in patch 1.

Thanks for the review!
Antoine

