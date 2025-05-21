Return-Path: <netdev+bounces-192310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF7ABF70A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F28C9E5D3F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB818A92D;
	Wed, 21 May 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="pmD/JPZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C32D613
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836234; cv=none; b=a+rHRoOKugzMS9EF+xqxUfeb3qwQsHOt7xCoRU6yLTmqDNdVYyRUuFKWHZXNjR1gXparKJz8qssOEuqZQfmaDFZxaKCVgNVzh4G+Nw8qxJl/SNhyYN1qIHY9Ym8C8eT8D2HV0ue8nizRDRk8twNmsNdWlo6yBd0cHWecdpGSvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836234; c=relaxed/simple;
	bh=aUpK6F1vieS89w5al6dvXytAKjpxGiK9NGGWcqokAaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2DPMRl27lHYJ3rWlWxGI4gvFl3E8U3Xcg9Gmnic3zTWF2d9Ela/pmT7v///I/atJMxNvzajE06dQmerDKnD8E6L1vaY5suAGJR/N+zyGUrarB6Mh1FVRA+Ew+vCgMSYvDWEzM999hiIUrm8LPvms90JmmZlm72qyd8hhW5KAJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=pmD/JPZX; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1747836222; x=1748095422;
	bh=aUpK6F1vieS89w5al6dvXytAKjpxGiK9NGGWcqokAaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=pmD/JPZXp1JgmsMxaoLiWXIrAswmtvLFnyetmwX2jyO9gDMX6fEXIyjwWHyBDv6H6
	 c30fV71xZUaKgsq5rymgctwJ88WjH3ZMnh6Lc2r62658HL4owrpu2v8YPaJODltrr5
	 uHYht3eN8lsr997rxR4fOO3A/JZwcSikI43Ie0idy+s+AkMv2E/lS59jEBtYHTJELO
	 NJL9NvQl3iX4sKQLPf84TcGMJN10eDkCcPqOUw8FUZyePu7Dn7+Kxuz2yYQzRzJSHk
	 N6vTmdBYRxp3KhnlNOy4kkdsa+mZ1GCajzFfdN6Iqf7bIubfogJh0tJOr2GF8SfHHC
	 Xqx10Ldkk/UpA==
Date: Wed, 21 May 2025 14:03:36 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io>
In-Reply-To: <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com> <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io> <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 829ce49c067a3a5ac2562f590917866f88eb2798
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, May 21st, 2025 at 11:06 AM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

> I am afraid using bits on the skb will not go well around here - and
> zero chance if you are using those bits for a one-off like netem.
> Take a look at net/sched/act_mirred.c for a more "acceptable"
> solution, see use of mirred_nest_level.
>=20

Ah ok, thank you for the suggestion. We will take a look at that then.

> Not that it matters but I dont understand why you moved the skb2 check
> around. Was that resolving anything meaningful?
>=20
> cheers,
> jamal
>=20

Yes - otherwise the limit value of the qdisc isn't properly respected and c=
an go over by one due to duplication. The limit check happens before both t=
he duplication and the skb enqueue, so after duplication, that limit check =
would be stale for the original enqueue.

Best,
Will


