Return-Path: <netdev+bounces-54057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02946805D0C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 19:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6AB1F21785
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0168B62;
	Tue,  5 Dec 2023 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0uGtqoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2234675B2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 18:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3375DC433C9;
	Tue,  5 Dec 2023 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701800210;
	bh=jxpd6aMZQiPOgYn/LEW3yh+7VW8tSj4hyyw6gS6Z6P8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W0uGtqoenh2vIn+zQc4qWETn1QFuYucms7KfbvdsXOWoJ+cZbiTdSFaT41YCfZpeA
	 nWVzi6t9MwVKLJAW3wFbtvs/SWyRLCqB3SAimZufiOwDXQ+SpQ6I/ZO0Hss88LwbsE
	 Qpp305n5f3+cqRGhn4LrKRlN36XLDOze5HegQPfylPmezmpcHU2hz7aLFVujvfnyvY
	 URThu/BdYXC3tpAjt+oCduKp9D9E491/4xZE26jBrZNASKx/zVIZJUTUKyURxdD7C1
	 ly+F52B3UTMOK7WKxyGj+bRPT02Zl/9olEFwQdSsxSgHNlOEVq/KyGtO2n+tKQ6nBv
	 OVE4tnWscz9OQ==
Date: Tue, 5 Dec 2023 10:16:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [ANN] netdev call - Dec 4th
Message-ID: <20231205101649.4403be0d@kernel.org>
In-Reply-To: <20231204100735.18e622b2@kernel.org>
References: <20231204100735.18e622b2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Dec 2023 10:07:35 -0800 Jakub Kicinski wrote:
> I, again, have a minor update on the CI. I'd also like to talk about
> end-of-year shutdown. Please suggest / come to the meeting with
> other topics!

Meeting notes:

 * Testing:
   * The testing repo is now fully operational, branches are combined
     net + net-next + all cleanly building patches from patchwork.
   * next step for Jakub is to use it to run slow build tests (htmldocs,
     cocci)
   * Jesse trying to get GitHub runner targeting Intel-internal machines
   * reach out to Jesse / Jakub for access to the GitHub

 * Winter Holidays shutdown:
   * Anticipate merge window to start Jan 7th
   * Initial plan - 1 week starting Sat, Dec 23rd to Tue, Jan 2nd
   * Polling in the meeting: 5 votes for 1 week of shutdown, 2 votes for 2 =
weeks
   * net-next will be closed for new features (fixes for code in
     net-next will be accepted)

 * Dealing with inter-dependencies w/ other trees: what if something
   that landed in net-next is needed in RDMA? If it=E2=80=99s already in, i=
t=E2=80=99s
   too late, if we=E2=80=99re told in advance we can make a =E2=80=9Cstable=
 branch=E2=80=9D.
   Andrew: note that only build time dependencies are a requirement, if
   the functionality doesn=E2=80=99t work in either tree until the merge wi=
ndow
   - that=E2=80=99s fine.=20

 * Next meeting on January 2nd (skipping one!)

