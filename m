Return-Path: <netdev+bounces-218866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C69B3EE2C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB531B20C30
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61601FC0FC;
	Mon,  1 Sep 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImQQgPl/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA1E555;
	Mon,  1 Sep 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753062; cv=none; b=n9vCtaI812uTKj9jPjWcYVcL6BH8HGIdawYMiJ8eT8E7JnVMmmLqBjhh7nSwd1OkvlHa32+MnabikUCuUkbVaM2jlz94tyLbXam/7VJxkGPI184wWxSESjCT9lxNDgrDCWbdAcA6F1otXrQsBqa4Dkh3YB2t8HQcXDoZ8hOPycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753062; c=relaxed/simple;
	bh=PckdC7F68wIdYoJvngu5KIjJjy9IEm5ftefjYkXfX3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP22f8XbG82IG+sUnDbQ4t3zKXZA+sFksVq7FEUJb4jdbfau86AF/blZh1X4nX1FJbe/x5qjL5LBHdd77EWdBF7BO8/YSIoQuiSqagmqdgSIjrVyYQOGD7CHKPSykUwQ6sEh8ijlils2WHvml4s8BrotIrEEKPWSAs59p7ODWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImQQgPl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682CAC4CEF0;
	Mon,  1 Sep 2025 18:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753062;
	bh=PckdC7F68wIdYoJvngu5KIjJjy9IEm5ftefjYkXfX3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ImQQgPl/zAxX53chICGr2t8almNcpNLB1ePSo3phCzDJxkLtGDoNCG2MbLDuy1ZTt
	 cwliDehEbD0AQ/sMKlhX1+4xgSTEgvtsvDwPjQAcCq2DIoua9WLLnL0uu4ctCoOhC6
	 M/CoPbr7tYkUJCpHqQI+w4xSDk5nPPflKpo/uqwMvYbYF2w7JqpNHFP8bYUkjrhaH5
	 Ee8LUbNHeeiLF4QJ0BNIntXqxRxtp6BjcCF7CqLT3duzWqiLXEQ1+lWCMf0gVZaVC0
	 nlYcf/1hAnHY2oHUJp4TQ87X/aVJ+899MPDDRahuoki7LHLWWiNXgugIxRq6oZO3wG
	 QCQFLJUyHQU1g==
Date: Mon, 1 Sep 2025 11:57:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Matthieu
 Baerts (NGI0)" <matttbe@kernel.org>, David Ahern <dsahern@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 4/4] genetlink: fix typo in comment
Message-ID: <20250901115740.686152b9@kernel.org>
In-Reply-To: <20250901145034.525518-5-ast@fiberby.net>
References: <20250901145034.525518-1-ast@fiberby.net>
	<20250901145034.525518-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Sep 2025 14:50:23 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> In this context "not that ..." should properly be "note that ...".
>=20
> Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly=
")

Looks good, but this is not a fix, please repost without the Fixes tag
and for net-next.

