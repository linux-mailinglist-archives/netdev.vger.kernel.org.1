Return-Path: <netdev+bounces-242638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9E5C93434
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 23:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3277A4E1916
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980A2D6612;
	Fri, 28 Nov 2025 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="nr8PHpwz"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81822F76F
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 22:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764369216; cv=none; b=ddRrrvxIgDEqtomFRqvSRZmSxA06pdmjm2FTmsydv5+qx+6SeteP3Kc3xl7Y0vP9Hn1lQAOyYB/Y3+jbCUYaJ3hQG/JsQr8Iauh65gkFKY0hbdc/SoSxjMYh1PgdyaN+ogx4aMIQuNOH1o0IWC3IvmxLEQ215h5EBFwkBShtNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764369216; c=relaxed/simple;
	bh=WL9A52lnn5mHxkJ6CM/+q+QoyHQOWevPx8HeleWcZVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FoabMuRdNSQCVss5/4dyWHJ4ut47eAtl1gQ1Rgz5K1BDBrVVLmUAZ9yq6wBSo9bzb9SzAgJO6HXe4vi2gfDxGcHiHaAsTTCL64DYtv0zJ/4XCUXbG7XgCfOWohnADiPyMEI62R4Jn/kBnKs249FHLG2i1ZAQeg8+qtFyAuLCOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=nr8PHpwz; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1764369207; bh=WL9A52lnn5mHxkJ6CM/+q+QoyHQOWevPx8HeleWcZVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nr8PHpwzi9hitypynJygbrU3FqdFQz4aVV+9edEeHouY4mMqN11i9dvSqztM3Uqjm
	 KgriF4kWUUBlnWanIrPuH43/BWoAAaLu25PbDO8z3OPE270g3355NGUGH0J9K3+AY+
	 dulxjCw2lvFTGF0cpQXlYmfBSezrgYu9h1xvikpn3KU9rnQbpoMLRY16Zbme65tXDN
	 pwG+6m3sOP3Cfe7+gi3cvoLeiOJdYndUYqa5KoEXTTunE6qOdSJZJ8cRaj/FSAi8pT
	 Qg7QdwQ63ruwu72gF3/Bo9kemZND7BklxsFiTE+Se4uxfGkKez/mhZTUCcZz/3ubNo
	 eTLR9NUsQB5nw==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonas =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Multi-queue aware sch_cake
In-Reply-To: <20251128095041.29df1d22@kernel.org>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
 <aSiYGOyPk+KeXAhn@pop-os.localdomain> <87o6onb7ii.fsf@toke.dk>
 <20251128095041.29df1d22@kernel.org>
Date: Fri, 28 Nov 2025 23:33:26 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cy51bxe1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 27 Nov 2025 20:27:49 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Is there any chance you could provide selftests for this new qdisc
>> > together with this patchset?
>> >
>> > I guess iproute2 is the main blocker?=20=20
>>=20
>> Yeah; how about I follow up with a selftest after this has been merged
>> into both the kernel and iproute2?
>
> Why is iproute2 a blocker? Because you're not sure if the "API" won't
> change or because you're worried about NIPA or.. ?

No, just that the patch that adds the new qdisc to iproute2 needs to be
merged before the selftests can use them. Which they won't be until the
kernel patches are merged, so we'll have to follow up with the selftests
once that has happened. IIUC, at least :)

-Toke

