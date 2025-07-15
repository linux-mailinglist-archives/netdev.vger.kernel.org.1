Return-Path: <netdev+bounces-207174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F7B061A0
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC477A31D5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546D1D88AC;
	Tue, 15 Jul 2025 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHG8E4yd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B903597E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590740; cv=none; b=n7/doCe7te5LHSB0h+nSaxZwF84Ujapg+p9bMnpnBJM4m4ufV3O+q+28ITU8quw2/NzPigxX7hDbN/tpmbmtkdt7t2QbZlx0tBRZc9qFqQsAgzU2tVUKr5yPR3wjMwmOOHqy3Bq5At17RF2kzi0UnxjezdBAAHzcLN55WsI7coA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590740; c=relaxed/simple;
	bh=NRCSIddfwJt5FTQEEysmGamLF2a+L5PtpK/6ivPO4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI9QUAWfhDZsljD6G8KuzTsvs5ZjEO3pz9SdI1W8ZN0HZn3oVPR+8p/QLldII/SUKMDT4Z/LOSrvFfILuubJj25VDXR0ms3RNDkHtHrpkS920wAwTqYEhbRgDieyTnNe1+7J88Zpq9cVpjxhueMp2fRlecvnkIv9vCsjYrdeL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHG8E4yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421D8C4CEE3;
	Tue, 15 Jul 2025 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590735;
	bh=NRCSIddfwJt5FTQEEysmGamLF2a+L5PtpK/6ivPO4QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHG8E4ydpoKK0JYV8bPVWqH20/SNMJY4bH571czTqHM5kFgDLN4udXekvQ7rbe1rC
	 Pnl2LMkj4DNsK7oulyhfpP/Ki4o8RRL67Q/faikkIGYeZ50UkIGyQ3ccR+cA8HMVqw
	 /faoiz3w2jlKUt9rcq6AIVZuOmh1oi3YmvKKr136owDiWrdX1rmo9ihIQWJ3w6n3i4
	 xXNAi4DCY+pMe59qFBC+15RB/eHJYXHHCD9WWlvJ9Iais/JtsVCYsqo9FXCHilMxJK
	 GwxAZRyFfkAGaRaGKBy3j76Mb0WfSdzIhCRaeKIifPXwj+H64N6kXJuib97Xq3VNX7
	 2+76ONHBDhKVg==
Date: Tue, 15 Jul 2025 07:45:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, sdf@fomichev.me, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 08/11] netlink: specs: define input-xfrm
 enum in the spec
Message-ID: <20250715074534.30783870@kernel.org>
In-Reply-To: <7fe0c573-4a4d-4cff-a1c2-9d4638eea3e1@nvidia.com>
References: <20250714222729.743282-1-kuba@kernel.org>
	<20250714222729.743282-9-kuba@kernel.org>
	<7fe0c573-4a4d-4cff-a1c2-9d4638eea3e1@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 11:35:08 +0300 Gal Pressman wrote:
> We kinda use input_xfrm as an enum, but in theory it's a bitmask, so
> while this is OK today, I'm not sure this patch is future-proof.

Yeah, a little unclear at this stage if it's a bitmask or an enum since
we only have values 0 1 2 defined, and the defined values cannot be
composed. Adding an entry that'd compose would be painful if we go with
the string. OTOH I can't think of any composable transform and it's
extra effort to extract the entry form a one-element set each time.

I guess we should go with future-proofness when in doubt. 
I'll make it into flags in v3.

