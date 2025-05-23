Return-Path: <netdev+bounces-193072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F33AC265C
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A45416DAF6
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA7621ABCB;
	Fri, 23 May 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="v/sEEhbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087D21A428
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013835; cv=none; b=h7oQhM/W9YEeWRRI6Egm+toCKfarBpwCSniJFWvVFonJ5SeiYgtQndGs43Ife1GQubn3yKA1xdT2BGbHQHe5TrPAoiPpWhhUcWew5s/xca+aJflbg+iZckDpnzFrlBzau+VAZo/RUHwQoNtqdJC7BRGs596LkW2Yr8YBTZXrSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013835; c=relaxed/simple;
	bh=cNdE3mA63Jn/g1dx5IAyngmczbPW2O7PAiJD1liYvzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHtQXq/qQDpNTI87o0Qk026RrIJUErs4U92Y3WagNylWvM3DFH7wT0c4ekCNCEyqLQU3kBEpf4A53mCFm4q5s0o/363IIPvUmKACCEkw4WS5CdBbLCBNGKUCqaxULYJWsv7zaDpnKzj1rV7nqI793yyaNK0VJliIiToDSu0I+vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=v/sEEhbn; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1748013829; x=1748273029;
	bh=cNdE3mA63Jn/g1dx5IAyngmczbPW2O7PAiJD1liYvzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=v/sEEhbnfpvV2Rgn5A9ydZ4MrwCdfk50UL/gUL1u3VQRAGnhZMvIUrfwNAFOKArzT
	 LQPtulTUndldNP7ReS68E5eCku4LApl/f8c2bi0hVM4hBX2hWC6Klwodnz8tmDlBQE
	 smYrByKY83HA5teKcmPrjau5ugbVi09uvfQCYV200GK/3+cj2fyxD24zD5GqvmeGDM
	 g+CMkakJ2IfpEcmV3mHJYmliGEtkDDT+wL+vql097UQY/4PHfzAnPwGdj0HE/A5A2V
	 NvBHinMB8WkRdlMqSWAEdTodjIuRCnDJkqrxGUIMuzKOCOsvIpT6WcQGOgqqVw6HyL
	 mmv61iaxZauJQ==
Date: Fri, 23 May 2025 15:23:44 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io>
In-Reply-To: <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmKL68r_b1T4zHJTmdZPdCwS69F-Hh+0_ev+-5xPGy2=w@mail.gmail.com> <DglTO9NHmtFTRrCJf07R16_tYUUqoTV7M0hID_k-ryn5mAhe4ADq1mBpAuxNK24ZTnzIPaPq4x1woAtqZGXgAQS4k64C4SGRCfupe3H3dRs=@willsroot.io> <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com> <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io> <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io> <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com> <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io> <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 7c37660cb68d8732286633ec0b409d69f4252d86
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Friday, May 23rd, 2025 at 11:01 AM, Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:

>=20
>=20
> looks ok from 30k feet. Comments:
> You dont need a count variable anymore because the per-cpu variable
> serves the same goal - so please get rid of it.
> Submit a formal patchset - including at least one tdc test(your
> validation tests are sufficient) then we can do a better review.
> And no netdev comments are complete if we dont talk about the xmas
> tree variable layout. Not your fault on the state of the lights on
> that tree but dont make it worse;-> move the nest_level assignment as
>=20
> the first line in the function.
>=20
> cheers,
> jamal

Ok will do. Can you clarify the count variable issue? My understanding of t=
he count variable is that it accounts for both the possibility of simulated=
 duplication or loss. The nest_level I added is to prevent against duplicat=
ion of a duplicate due to re-entrancy.

