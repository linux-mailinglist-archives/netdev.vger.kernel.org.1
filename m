Return-Path: <netdev+bounces-61576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932478244E5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267C31F214CB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F688241F0;
	Thu,  4 Jan 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfSPJ1VJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF241EF
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFD5C433C8;
	Thu,  4 Jan 2024 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704381954;
	bh=rphsPNHRCNsHFIyjFjtDonMxrBGKg1q/qp1ZZYvLO1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfSPJ1VJrW3R+5i5v6aKdFJFuhUtsh1pZr7iXPUZR6n4py8LXOEtTn0qxC+yvoPGE
	 5C4/1qFFT8jtPdv8wRjrnwL8BgS1mn/yzS/5jwvHde91qnMIVHciuYXOfu2EUOtqjK
	 5hZz9PSI4Yt7PPwmcGtMSkTd3ClFEo3gN1HaWI4kmNPuDPUMP9l+96/Nmr86iPeFxt
	 wvexUeVUIFrX6XOQ9+2LTAivxYeM4SEJ7sfDD4C/f5QxIyvRwyYwxUcKtk6a+L85x2
	 BOh+dY/P7h7SVoMD1NypGyVg55TKDqbSmU7ZyZWh6uaIeh63ZLnrIqNK2cU+JSznZ+
	 jUGV/aCp1UnKg==
Date: Thu, 4 Jan 2024 07:25:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger
 <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
Message-ID: <20240104072552.1de9338f@kernel.org>
In-Reply-To: <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
References: <20231226182531.34717-1-stephen@networkplumber.org>
	<CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Dec 2023 12:25:24 -0500 Jamal Hadi Salim wrote:
> On Tue, Dec 26, 2023 at 1:25=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > There is an open upstream kernel patch to remove ipt action from
> > kernel. This is corresponding iproute2 change.
> >
> >  - Remove support fot ipt and xt in tc.
> >  - Remove no longer used header files.
> >  - Update man pages.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
> Does em_ipt need the m_xt*.c? Florian/Eyal can comment. Otherwise,
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Damn, I was waiting for Eyal to comment but you didn't CC
either him or Florian =F0=9F=98=86=EF=B8=8F

Eyal, would it be possible for you to test if the latest
net-next and iproute2 with this patch works for you?

