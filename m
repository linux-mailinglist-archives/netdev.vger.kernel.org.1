Return-Path: <netdev+bounces-218858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF9B3EDFF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AFC3AD12C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D421B195;
	Mon,  1 Sep 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3Ay50Pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1C16132A;
	Mon,  1 Sep 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752119; cv=none; b=ORELPrR+xdCaxr+gg5YFumhdEqOjKjcXfbevMCNKcdKruoEd/OKSdh0Wbrbn/fBgm3llv96fJctTQt3icZal7kXtdl5+zfJt7PCNVFzuddkSRedBtbCFbJuQBY0KImGA4VFtIRkrowGW2lexVi+A8N1LMKct9GB+n5rzKtaZFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752119; c=relaxed/simple;
	bh=kh2X5DtKZqbOAKtH4yJZK0cd8MIEzYP+jLYnyLVhX2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO8rpEPk7oprP6Ti4J/70AYHFWyHQqXm4Csbm2AH3V34LJRsPG/ZWZD0TNFIbxbQdsAIOsn9AkB5U9O3/CrAjZ5A1BvJERACJe3DVxO+an7a+EUd0+LKS5+JgjL/UOKtm/8JIEcgv41XrTtLOjobqlZa1y6+T3sjC0Nf6C4/Fio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3Ay50Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F73C4CEF0;
	Mon,  1 Sep 2025 18:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756752118;
	bh=kh2X5DtKZqbOAKtH4yJZK0cd8MIEzYP+jLYnyLVhX2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q3Ay50PlYcX4k48lo98gCagp9YcxRpuJ3B+uAzjfUVPImE0Gj1Z1xbXhNAYQ/aa8a
	 S+njl1V0F+GgWHho5xTFWas0HR9mlF7HqcX6rRn44RT6QShsemU0n3/Q6+j6o1GbGs
	 HmTh5K0hxzv8CXUZSRmhjF1gnWwJYcgcjnH4TzXJ7zrzwDPO2MHGC1FN0pMNgxNtX/
	 LsQQxw2N0KhDYaC1s/cDjJC6iWZZfq9YanEE7ObFTWivc+/MZMH+TolkksHH7AMyPK
	 QlEjoBFVp40CBMDkxpgSvYJma+WxzBeIDnmTJieruM9zW+4oABJxz02LKNWZXPyhLs
	 wUxcfqsLzh+jw==
Date: Mon, 1 Sep 2025 11:41:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: mysteryli <m13940358460@163.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
 <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Jason Xing <kerneljasonxing@gmail.com>, Michal
 Luczaj <mhal@rbox.co>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Biggers <ebiggers@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mystery Li <929916200@qq.com>
Subject: Re: [PATCH v4] net/core: Replace offensive comment in skbuff.c
Message-ID: <20250901114157.5345a56a@kernel.org>
In-Reply-To: <willemdebruijn.kernel.1137e554f806b@gmail.com>
References: <20250901060635.735038-1-m13940358460@163.com>
	<willemdebruijn.kernel.1137e554f806b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Sep 2025 09:32:17 -0400 Willem de Bruijn wrote:
> In general old comments are left as is, even those that would perhaps
> be written differently today.

+1 please stop resending this patch

