Return-Path: <netdev+bounces-193230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D38AC3130
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0736517D939
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EEE23741;
	Sat, 24 May 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="e1uZHz1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAF2DCC06
	for <netdev@vger.kernel.org>; Sat, 24 May 2025 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748117375; cv=none; b=HAFA+EviXz6KrNBchc9I2w01sOi9/TlXGmSRV1NFkj4cYhuErc2uFVAcAy2exKZ4EoDZ6E5ffs3ZekYB0kluFKOvMojtRsNDdlmwm4z+46KJ7vBtZhpeiX6Ps9PVwoWihNbOW2iwrUG1XWcRoadI5tTwM4fcE8R2mF/5WuPGfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748117375; c=relaxed/simple;
	bh=c+/+InaJhSyNmGIihD4rbWrbCKtnc39+MWZfRXC5bE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxqKLHiQsDMW3eBW6NI6xah09KpiqUO5apGt17WgnfN8gVWyZ2J+Ya+MzmwsqGXR4FG5iE92yfqCHjMP94/1f6aVMpDSRLcE1ySZpHdjcE2E58R1TJJVKuFm10F9YbzTiKl8/jn0wYWd9Id4u+ngNG2oFeYqgPc5FLCs/L233kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=e1uZHz1M; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1748117356; x=1748376556;
	bh=c+/+InaJhSyNmGIihD4rbWrbCKtnc39+MWZfRXC5bE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=e1uZHz1Mk2Zx5b4/mkQKlhukSF267f+fSJ9Z8/UuzAfSDhO903xCjHJWzgmg1VBHA
	 jS8pGhSFI2PBssf90eoWiJdAet96JYBa94Lo0sRM9TVkGdege0CbTT2o8u4sx/MUo2
	 SYUjrEiHblFpSXjWVNZgojOcp2lKBu1g+WsEXddazzX9PwNV8ZIcHB+R7c7A96bn8W
	 DGvpfZkLxw70wqP6uQ0FBTQEczhq4wT/umrBrYKo9a9c4rY1xNkLcLq640e66P1jIQ
	 2JaJVOxu5a6fYPFn/PptEsgygHbgb0LQtfBZSz3uNYOimdTfn84N6GHI4Jl0n5Qmnv
	 7P1PZKr/V2DtQ==
Date: Sat, 24 May 2025 20:09:11 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Savy <savy@syst3mfailure.io>, Cong Wang <xiyou.wangcong@gmail.com>, Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <FiSC_W4LweZiirPYQVe8p7CvUePHrufeDOQgkDT07zh-uy5s6eah-a8Vtr_lPrW73PAF51p6PPIrJITwrJ5vspk99wI5uZELnJijU5ILMUQ=@willsroot.io>
In-Reply-To: <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io> <CAM0EoMmQau9+uXVm-vpuWqYjh=51a_CCS6orS6VrK6qBdddxrQ@mail.gmail.com> <iEqzQsC-O2kAXqH1_58I59DIhBjRgebyGym2ZqyMEI3DaMtgsKSYR0KUsbxj5xqvfzf-4XzpM8dXvATHJhVVw3NedRdL3j1FJaqiXPlNWeE=@willsroot.io> <ggSxq-NP-LDpev4N-rvkgs0Rrd0qOrbwtGRjcu4j4y3SuZth9k5RxTg2tFvhriQu4w_GxRPYjnkKN6VqFP6Q6FCyqWudz7_5iuOV06IEzgY=@willsroot.io> <CAM0EoMkd87-6ZJ5PWsV8K+Pn+dVNEOP9NcfGAjXVrzAH70F4YA@mail.gmail.com> <Ppi6ol0VaHrqJs9Rp0-SGp0J1Y0K8hki_jbNZ8sjNOmtEq0mD4f0IozBxxX-m4535QPJonGFYmiPmB643yd4SOpd1HDDYyMeGQuASuFHl-E=@willsroot.io> <CAM0EoM==m_f3_DNgSEKODQzHgE_zyRpXKweNGw1mxz-e3u6+Hg@mail.gmail.com> <8fcsX7qgyK6tCGCqfi8RN7a-hMGfmh0K2wOpqXayxNM0lKgbjttNfpYkZHA29D0SN5WJ5h3-auiaClAq1nGw5BulC8wOzfa_lqR4bx73phM=@willsroot.io> <CAM0EoMkO0vZ4ZtODLJEBP5FiA0+ofVNOSf-BxCOGOyWAZDHdTg@mail.gmail.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 1cf62111fd09474bfc336ca4d4ec1eba60787fa7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, May 24th, 2025 at 1:07 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:

> "count =3D=3D 0" seems to be only needed for the loss when a drop decisio=
n is made.
> Slight tangent: Looking at init() the setup does allow for both to be
> on (i.e could be "and" not just "or" as you state above). It feels
> sensible to me that if the loss function decided the packet is to be
> dropped then that would override the duplication.

This makes perfect sense to me.

By that, I agree that the count variable is not necessary. However, I think=
 it's good to introduce a duplicated boolean instead for readablity's sake,=
 instead of merging all the logic into nest_level. I will get a formal patc=
h set ready sometime soon to address the bug and the other behavioral quirk=
s we found here.=20

Thank you for the help so far!

