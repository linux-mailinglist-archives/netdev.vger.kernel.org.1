Return-Path: <netdev+bounces-111203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B81A9303BB
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 07:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0464AB22202
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 05:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907218C08;
	Sat, 13 Jul 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0bXfe9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9479DC;
	Sat, 13 Jul 2024 05:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720847725; cv=none; b=X7hnPaMc56HW091Pno4UzRjl5coK8o0h9E9FpN+JBh8NFCkzQxO/6tnQvc64hULpJL0ZNM6iFu4KEb/wjgwvMC9j1xb+/bI8gtDTBPVjizDD6oMhnxa+ct6NWbRT7Z5lu4JwK7VUPlMBMRU/bcBU34YkvnZtYi3x6U/4i8TFDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720847725; c=relaxed/simple;
	bh=x9bE3N0T6p6TwaaCc8hB6uR11kYedxdDAc0wg2J27qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXvoU1aC1zWzZA2afwvm/RUHHFlqz41V4sZRjVKjHxsywzBlsZesfvaQDqvHeA5nG1z/FjO+P7B+fyTFxGABa3ndgBFMiFjKzBqYiv37HmBHjY77weNjiwchkXLz46ioz9j1+9pghzGIbKYYqczzUdyzuHeyTTCXJXVOX7Yrahg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0bXfe9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE156C32781;
	Sat, 13 Jul 2024 05:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720847724;
	bh=x9bE3N0T6p6TwaaCc8hB6uR11kYedxdDAc0wg2J27qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0bXfe9yZRSnBtzCTxFULBgN6DvVsnY0/x0w1lFhTdpIluKigJx5CdtOCSQllEjEV
	 X5xNKR14ZehKtfbe4jawvq3yOD4YFNVm2xVecLys6X8N+aHuxn20xLa4Y6f88vKuIa
	 X1qn9lNr4mhh3blEgq0OUKwXeEonM805Egetcxs/yHz0mj3sKpDzHXAg5EBmKqXgYp
	 +ExtB7RHJLtV1C7QQKdEu5jI8VRMoUsDIODNELjwAtGj40ft5jBubnlnIgn+SUeR7j
	 IICN4dwDtOyPKhbt0dj7A/+AiI21W3aD9/f+s5J4c3wS22KX39oqcx+qLqkYDPjo+T
	 klfFkZNE/A/Zw==
Date: Fri, 12 Jul 2024 22:15:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, Ilya
 Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong
 Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman
 <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Florian
 Westphal <fw@strlen.de>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/10] net/sched: cls_flower: prepare
 fl_{set,dump}_key_flags() for ENC_FLAGS
Message-ID: <20240712221522.4a24671a@kernel.org>
In-Reply-To: <84b4b03d-3ec5-48cc-a889-bbeaaf3ceb0c@fiberby.net>
References: <20240709163825.1210046-1-ast@fiberby.net>
	<20240709163825.1210046-4-ast@fiberby.net>
	<20240711185404.2b1c4c00@kernel.org>
	<84b4b03d-3ec5-48cc-a889-bbeaaf3ceb0c@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 01:14:57 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> After propagating tca[TCA_OPTIONS] through:
>=20
> Netlink error: Invalid argument
> nl_len =3D 76 (60) nl_flags =3D 0x300 nl_type =3D 2
>          error: -22
>          extack: {'msg': 'Missing flags mask', 'miss-type': 111, 'miss-ne=
st': 56}
>=20
> In v4, I have added the propagation as the last patch.

Sorry for the misdirection, I realized this morning that the Python
code can't descend at all. I only implemented decoding missing attrs
to names if they are at the root level. C YNL code can decode.. but=20
it can only do genetlink.. :)

