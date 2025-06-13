Return-Path: <netdev+bounces-197549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB3DAD91D0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F68817A8C1
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CD3594F;
	Fri, 13 Jun 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppKpmDYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CA2E11B6
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829694; cv=none; b=L5N3AqcYuk+a5sIq1Nqu+XCgVHn9/nfKC4KeZ4wQZBQJem8+KV5ORNLJtKrxkjQzKsIrDpnB03N/Ks6owid0eKYiRyxWeQO1Meg5oVgk9ST5ww85YabRRGeH4w91COFHxF6g8S08UHsHrIlmZtZ3eQe548JRoHjatbNlAtG0Uks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829694; c=relaxed/simple;
	bh=Svs/cCKxoXdJ9bEdX8w5KYxZenyfXCAOlQOjVi4Swc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI+naMhFSFhnMRBK6lJNUOYvVnktoYDGSox4WXPlx2hnW4bvraNsid7TXSgttgXAkf8t4AISG0JJUoIeidz655EWcPYyZ6O+HQn6tZ9/Xsz7aAKd4skPKoJ91wpFRYPYjEYBjUNwKgm473Mju9TQM9nakiLWm8mU9JaiXS7dO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppKpmDYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECEDC4CEED;
	Fri, 13 Jun 2025 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749829694;
	bh=Svs/cCKxoXdJ9bEdX8w5KYxZenyfXCAOlQOjVi4Swc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ppKpmDYLB4NzALJff+94FmDIZTp4waFI9RxJaE3Ju/RZrZkAiBcStZaQbd4mY1BF5
	 VWqRHsDzsYBtFOuptWmO2ni35FRRaLrYpNwOVFpNndOQHnjXUMgOD2g2DA2efxC4y5
	 n8Nfz1Fb/iFeG88N0Q+JtMUnMVHHGqn6Ckrfnp398l7SoWiNIR9VdbZW1Wh1rdg45c
	 LhLpd9d42jr1Ac+oukI4Hkj1FUCURSSmP9G3F4vupBXUtwgkDf/HBUg9coWC6aDAbE
	 XdyNmAiqyhWree/k/BhQ/bV5y/Qm7bjjtFexO5MCOEBQAnaM3HlJt1R1FxdXhYAJ0U
	 Mpra9CsVzNE4w==
Date: Fri, 13 Jun 2025 08:48:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Message-ID: <20250613084812.4e945368@kernel.org>
In-Reply-To: <cover.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:34 +0200 Petr Machata wrote:
> Multicast routing is today handled in the input path. Locally generated MC
> packets don't hit the IPMR code. Thus if a VXLAN remote address is
> multicast, the driver needs to set an OIF during route lookup. In practice
> that means that MC routing configuration needs to be kept in sync with the
> VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
> routing code instead.

Crazy, the leaks are back in NIPA. 100% reproducible it seems, the
patches have been in 3 branches and every time the first run and 
the retry is reporting leaks. I'll try to dig into this a bit,
but I'm gonna set the patches as Deferred in PW in the meantime
to avoid blocking the queue.

