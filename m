Return-Path: <netdev+bounces-157248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292DA09B90
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E812166993
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9C24B23D;
	Fri, 10 Jan 2025 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="zDJZBpUc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5E24B221
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536015; cv=none; b=g3gPGdzVjzlOdYF9UdS0JV0S/5aB0T7pt5DGdy4urb08SGH+WHhJosSDT1qf9/dUF1ETzKT3qb9gF964p8h6IQs+AaZOyswMsXQjU+f2Br9a3/0ifzCj4JU47pmij3vkSkgNyyrjKz1sTv3retBPCPSoHzFG3EPQKFKOvlP5ql8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536015; c=relaxed/simple;
	bh=qvX1+j6yNE11POaTQoCavgYvPEMbYzdCpCYQFl5ghoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WOLU0ML8loGCXJwTAhRPMxXFkWr7nppqas0J5yaRsIWOra5Cj3+nzd2RWRNi7YXML2fJoi0J63WEP5pRt4h0JqgSqtQd8aWhXtSnFvG2UgUlcr/t4OreIt83yMZdnvhXwGwdCjfq52MbotCOYZa85l/eE/QCP0Ueny1i5Rhm93A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=zDJZBpUc; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736536000; bh=qvX1+j6yNE11POaTQoCavgYvPEMbYzdCpCYQFl5ghoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=zDJZBpUcuz/1hL7DlgLKlCao4Z1JqaJcZlWVI12ZHKWHKbZkhPSnzViEpTG07Ag9O
	 cV23fGTC1YuoprIYl5HrGoLX31gTJYdBp3fnZ3MFRiXQZJAQ5Hl0njpnn7w8VsZD9m
	 tMsmQWzDbgTlCDu5m8KA779wZCooZbnQ03CDBVKjXU/X40Mk/a18vWdkNqYBKTaZPB
	 yQwfA2QHbG4ZDv9lW4GbNGmLITrCJVxQBx+vJe9lda7qXS2+93xDbJwvfUnSwd2Pbc
	 mheHZBBYDwlGHicoVgyWZsE25OH4wekRwqBwtaNl+dnecwRtvku6IWvhB9MkvjdsjU
	 0j/VDvQZtNo9A==
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: Dave Taht <dave.taht@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sched: sch_cake: Align QoS treatment to
 Windows and Zoom
In-Reply-To: <20250110155531.300303-1-toke@redhat.com>
References: <20250110155531.300303-1-toke@redhat.com>
Date: Fri, 10 Jan 2025 20:06:40 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87plkuh4jj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> From: Dave Taht <dave.taht@gmail.com>
>
> Cake's diffserv4 mode attempted to follow the IETF webrtc
> QoS marking standards, RFC8837.
>
> It turns out Windows QoS can only use CS0, CS1, CS5, and CS7.
>
> Zoom defaults to using CS5 for video and screen sharing traffic.
>
> Bump CS4, CS5, and NQB to the video tin (2) in diffserv4 mode, for
> more bandwidth and lower priority.
>
> This also better aligns with how WiFi presently treats CS5 and NQB.
>
> Signed-off-by: Dave Taht <dave.taht@gmail.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Alright, there was some discussion on the cake list re: this. Please
drop.

pw-bot: changes-requested

