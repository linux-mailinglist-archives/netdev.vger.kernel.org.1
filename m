Return-Path: <netdev+bounces-108542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE749241D9
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B2CB2732D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA971BA86B;
	Tue,  2 Jul 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwDOsJbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA7A1BB682
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932695; cv=none; b=HsOKBGKmUmoOZysh64GISIIYdM6M8XwUL3XGhlAC2RwbwT6KUTYl2nc/T9PNoXb5V8AvduK+WSYHmaUlY+U5itvYMDV0LA2DFVsskcP2gwUfEZQAuCWZh7LXC89YjpIYdyUWHo0PJKEnJzLPABgcV3/tF9L+17eMmdDvBRGVfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932695; c=relaxed/simple;
	bh=w7/wTgVovHICtuZHKHCXp8nonLiQDD9PfU1CxzQnodo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdbbVpbcesEmhsFCbbXDHLS0vgvwFHdYnqSuGQQqKhFkrIIIIZlh+LwHcKjjRxx1bTjEPQdCbNfzMztAQAatu6TPEso0VNLMJUYrXgADj4PWJVRJarVkcybkFDmwSHQXdeKbZf/YBCE1Vx/4CM3mii1euwHEPyynSMj0JD5xz4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwDOsJbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546BC116B1;
	Tue,  2 Jul 2024 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932694;
	bh=w7/wTgVovHICtuZHKHCXp8nonLiQDD9PfU1CxzQnodo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwDOsJbQ5UR6rl7GDgmIFbz6MRlYbq6kyRgkEPSJMcnQXGeRELT8kIPKcT3VK1qi+
	 m8T4wlUhORGgkUNwl4gcTje4z+VcGijuTD2f7oNHwfalKeAgeS2GyBGgRji5kfP47j
	 z197ncoNqnAXL2aE5ZfbUvBqI2Bvvyu3U7WMevEVyPdxMSRpBVPWhd7QqTa8MQg0Qi
	 TcI8TjkgH8xGfHYGLXyCBTeGaAHedW4V/+cURe2Yojd1bI+Yz+zYeoUijLoQAZAZQv
	 IKBC8TqsHniPC8hC3mhLP59Ok8RRHl/Hy/7KFJgXAvcj8q+/k/tsWv0ET3hYpYSJ+5
	 x91bxcvEATTtQ==
Date: Tue, 2 Jul 2024 08:04:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
Message-ID: <20240702080452.06e363ae@kernel.org>
In-Reply-To: <e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
References: <cover.1719518113.git.pabeni@redhat.com>
	<75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	<20240628191230.138c66d7@kernel.org>
	<4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
	<20240701195418.5b465d9c@kernel.org>
	<e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Jul 2024 16:21:38 +0200 Paolo Abeni wrote:
> > I see, I had a look at patch 2 now.
> > But that's really "Andrew's use-case" it doesn't cover deletion, right?
> > Sorry that I don't have a perfect suggestion either but it seems like
> > a half-measure. It's a partial support for transactions. If we want
> > transactions we should group ops like nftables. Have normal ops (add,
> > delete, modify) and control ops (start, commit) which clone the entire
> > tree, then ops change it, and commit presents new tree to the device. =
=20
>=20
> Yes, it does not cover deletion _and_ update/add/move within the same
> atomic operation.
>=20
> Still any configuration could be reached from default/initial state
> with set(<possibly many shapers>). Additionally, given any arbitrary
> configuration, the default/initial state could be restored with a
> single delete(<possibly many handlers>).

From:

q0 -. RR \
q1 /      > SP
q2 -. RR /
q3 /

To:

q0 ------\
q1 -------> SP
q2 -. RR /
q3 /

You have to both delete an RR node, and set SP params on Q0 and Q1.

> The above covers any possible limitation enforced by the H/W, not just
> the DSA use-case.
>=20
> Do you have a strong feeling for atomic transactions from any arbitrary
> state towards any other? If so, I=E2=80=99d like to understand why?

I don't believe this is covers all cases.

> Dealing with transactions allowing arbitrary any state <> any state
> atomic changes will involve some complex logic that seems better
> assigned to user-space.

Complex logic in which part of the code?
It's just a full clone of the xarray, then do whatever ops user is
asking to do, then tree walk to render diff as a set of ops.
If you mean the tree walk to convert tree diff into ops, I think we
need that anyway, otherwise we may get into a situation where there's
a dependency between the user space implementation and driver
expectations.

