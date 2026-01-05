Return-Path: <netdev+bounces-247115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B51CF4C22
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48E1B30ECA54
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6C0285C89;
	Mon,  5 Jan 2026 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="R6RbdP9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B62405EC
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630122; cv=none; b=aHjn1o1EJfQqQYgauSdDRdmar/6xtZr0NSe8rWEQruhv80VZwenp4FhsAzupWZICZTtluiBzL7okMghGOMMB/LZKEeKMIhLBulTN7fljXaU/Don8HNmiK7TL0mLkmKuExLHxeQZUjd41wcnA9a2bZmh1/B82bbgAyAQW8mBqQ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630122; c=relaxed/simple;
	bh=0SOZObbSeAoHjarXi+RDp8H4CbREBxG7IO0uxXTMoqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K3n9NTC8E6z1koSClRaIyyP9b3fZ0Q78BCzouUceMlpiMr0trH89UuhFdvomr+6tR827SEoMAZM2FF436eWrZ/YgFGICWkuym62t6e3rNSQcYsyPZ9mw6SfzXrGw1SnKWgrC73qJjV764vB3Ima7F9FcgTVU/1FajDLERFObZg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=R6RbdP9C; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1767629618; bh=0SOZObbSeAoHjarXi+RDp8H4CbREBxG7IO0uxXTMoqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R6RbdP9Cctp5c2PIqVIM55KhRn37ZuinnjivHWNgPKefJUxxKIDDfvlDmX+9Wc/8l
	 oelbERWKdmU/6rpoy5LGejxjmU32RFXyO8Gq5CJjt16QvU4c6sa54W4OwQ28lebEVs
	 fMxzEIMeWAADGEMfKo5044uQYhO53pnmQQoobO7ODn8d8eVwmxyybcjilWfUAX1wv2
	 +w2c1fUyf+gbSC76mJbDA/HLm3DVDDICdr2qs/QYf1Ukergru9cz3EnFbwvyUxlybW
	 1Ij+hrxOmJ0/L/VY5uqArEYBKGWUb3JaKd30lEgRk6hiznMwIuU+YpmuHh+fZGI5A9
	 7YKJztynY61HA==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas
 =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/6] Multi-queue aware sch_cake
In-Reply-To: <20260105072414.50f4537e@kernel.org>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
 <20260105072414.50f4537e@kernel.org>
Date: Mon, 05 Jan 2026 17:13:38 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87seck5971.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 05 Jan 2026 13:50:25 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> A patch to iproute2 to make it aware of the cake_mq qdisc will be
>> submitted separately.
>
> Could you send it out? I think we need to apply it to TDC to make the
> test pass.

Ah yes, of course; will do!

-Toke

