Return-Path: <netdev+bounces-109336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4527928005
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A72823B2
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E410A24;
	Fri,  5 Jul 2024 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsGSWuUl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D97E9;
	Fri,  5 Jul 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145158; cv=none; b=d21ZJF2uRMWQB+x7yvfFK/SzIPrmL73K/jJ5TcluxraOLBbQcHTpakqCJyN2ZRLm+6cte9VytVcR45cyUSwy5+It+fXNEe7PdQcViXqWI7S16yL5gf93nG6f4+ft0lTL55tvJ/3UfetGJhaiFHwEh/Qg4/yBglOMBhtedbw80wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145158; c=relaxed/simple;
	bh=jQ+KnmoPJFhcY+yLO2JlSVwFLUUN0eSbHrU/2G2aOws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iON6RxKjV+yyoNJJ603SQg9ADLHqZuTqNlcO07OPJH5rkDR43PHhLhIbfHvpREV6yjdyVWgEtyC+Nv8e5ONkT9mSEe/svyvxYgremJk3Bb4LoNUf9QLwHeajaG6VGmBzVon8rWpdCfhBGnBhsVxLR81Jpp09IjojiP0Fj8DsRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsGSWuUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C11CC3277B;
	Fri,  5 Jul 2024 02:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720145157;
	bh=jQ+KnmoPJFhcY+yLO2JlSVwFLUUN0eSbHrU/2G2aOws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hsGSWuUl8T6tzyzPawCdY5r0SABSolaIANXpd8rijtIZqbKtFlZzH1NEv7/V3nPau
	 Hk9aodw7VDIJWLuvgUWQKjI6pIJGCoywuOl6R4Bh+OwNxa8czqU5pdB7D3ZvN9Qhnb
	 e6kQ7kObGRFxkfQnQvxfyipLyMCv4KDyDhC4V0BOEnBeX+1vocZSDeaQ8qIQd14tMQ
	 /WFhb7WoFGozpMKPkVD8u8jgWPSHUvi1Vs05+0Lj8hg1xE43GFN6pEGj4sTJOuTftc
	 QlAQBYu8t6AorEueaNtFFp7TJSPtDJDDqjmvOGJHiPSZ8wLtv6vXp+vO82q3VN1Z1z
	 UYGWTZ/5qz2Kw==
Date: Thu, 4 Jul 2024 19:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Florian
 Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] net/sched: flower: define new tunnel flags
Message-ID: <20240704190556.410667ba@kernel.org>
In-Reply-To: <7db43f91-80d5-4034-ab25-f589e5510024@fiberby.net>
References: <20240703104600.455125-1-ast@fiberby.net>
	<20240703104600.455125-2-ast@fiberby.net>
	<b501f628-695a-488e-8581-fa28f4c20923@intel.com>
	<20240703172039.55658e68@kernel.org>
	<7db43f91-80d5-4034-ab25-f589e5510024@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 21:45:14 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +       /* These flags are internal to the kernel */
> +       FLOW_DIS_ENCAPSULATION          =3D (TCA_FLOWER_KEY_FLAGS_MAX << =
1),

Looks good (assuming TCA_FLOWER_KEY_FLAGS_MAX =3D=3D TCA_FLOWER_KEY_FLAGS_T=
UNNEL_CRIT_OPT)

