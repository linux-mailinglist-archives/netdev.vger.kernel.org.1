Return-Path: <netdev+bounces-225093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5DB8E2CF
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B7F177F28
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 17:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47C274B2F;
	Sun, 21 Sep 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+KTHxHf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4485271443;
	Sun, 21 Sep 2025 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758477592; cv=none; b=SFai9mVQXMhjtiQQXCoWp9n6Z5eKc/UuUefxLLLaMvv/06M3lvaVh3cHeUngM2ELIQDy2A2rylBkTAi+yaeW4ot3tTtjZHoiIHKnSmPqMvN4F4wUHZo7E54rMJZVlh0FYSvrNjX16Q6t5surkVG8SPX3z1FKduQqIKJV+JICIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758477592; c=relaxed/simple;
	bh=ukRxplsQpCB+Qv3RlPxu32B9rZQpb3Mn+2vSepY0/b8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=iF34khWkQ1w8mmsX432LD2+XKE/bse+ONDuDH81LApHkDLpThXWL5638ePuuqbIMc/VrRoSS2qxQCXhFbo4jj0hcSrGRVsA0k1s2+E6eX8c0lxcAOEfaOmoG6KnlsxXmEFdyXplPsGHApyIu7lhJeXJHps61AP7iuLwizcGFfQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+KTHxHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5BEC4CEE7;
	Sun, 21 Sep 2025 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758477592;
	bh=ukRxplsQpCB+Qv3RlPxu32B9rZQpb3Mn+2vSepY0/b8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=k+KTHxHfPfr8EXksvM/wLT81aulWBskeXWMKERc4UGZvOZzJRmDZbZDpJzK9qQ2C1
	 5llmaz99fVHZMizwf15WID2RvnVRxkImeLU4yrxUhTumAflYH1JU2YCD02XtReCeDG
	 9vLKEhdwtv2n/rWrxWUJGCutDDwVp1ZP5A3w3gVKYfq7GQjaQ20IHC10idUJSUKMPl
	 7UGl88n0QkkrLtrQaD2Xc11kaCeij88Nn0yymv1Lw5xCYXymeLW0twgej9+rc6mwOP
	 uzb2z1y1OE+pJ/pfKDA65ZCXteQLXiCSvgd9hMzTVMtyQvsRwq37hYy3H15GP1H+Bq
	 fmVDLX8XSxdjA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7dd9bca2-6c09-4067-b3f8-9bdc10dea39f@altera.com>
References: <20250513234837.2859-1-matthew.gerlach@altera.com> <175133195554.4372.1414444579635929023@lazor> <7dd9bca2-6c09-4067-b3f8-9bdc10dea39f@altera.com>
Subject: Re: [PATCH v5] clk: socfpga: agilex: add support for the Intel Agilex5
From: Stephen Boyd <sboyd@kernel.org>
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, Teh Wen Ping <wen.ping.teh@intel.com>
To: Matthew Gerlach <matthew.gerlach@altera.com>, dinguyen@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, netdev@vger.kernel.org, richardcochran@gmail.com
Date: Sun, 21 Sep 2025 10:59:51 -0700
Message-ID: <175847759120.4354.5284082297601743277@lazor>
User-Agent: alot/0.11

Quoting Matthew Gerlach (2025-07-02 09:04:17)
> On 6/30/25 6:05 PM, Stephen Boyd wrote:
> > Quoting Matthew Gerlach (2025-05-13 16:48:37)
> > > @@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex=
_gate_clks[] =3D {
> > >           10, 0, 0, 0, 0, 0, 4},
> > >  };
> > > =20
> > > +static const struct clk_parent_data agilex5_pll_mux[] =3D {
> > > +       { .name =3D "osc1", },
> > > +       { .name =3D "cb-intosc-hs-div2-clk", },
> > > +       { .name =3D "f2s-free-clk", },
> >
> > Please don't use clk_parent_data with only .name set with dot
> > initializers. This is actually { .index =3D 0, .name =3D "..." } which =
means
> > the core is looking at the DT node for the first index of the 'clocks'
> If the core should be looking for the first index of the 'clocks'=20
> property, is it better to explicitly to state ".index =3D 0" or just have=
=20
> the name?

Be explicit with '.index =3D 0' and don't have a '.name' member.

