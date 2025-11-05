Return-Path: <netdev+bounces-235698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA3C33D42
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F6462F3B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958FA23EA90;
	Wed,  5 Nov 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtsVwsWo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56217C220;
	Wed,  5 Nov 2025 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312078; cv=none; b=d4Mv4orK6SNleVkBfmzLg8BMEgIPS1M0C8RllqkoMX22IB9x78DIzMlv0t1nl3gP642sZsXqnui7GvkjYUB+BxcoDWYDlrBGBsowBjYpG85A/xFZLGvB8iE5x+woMyYJqmU2lKrJU0weOtEZC+YIjnhPbwEDHCKYDyrwuWxvCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312078; c=relaxed/simple;
	bh=WyTGsD4E/mKC5sFVMFInPi8p9SP3Y+rnsjGRYMHi9hY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH6gUvoYrWn4N+yWIxk1odayZb+3NB3TqeYYUb8zIQcJKYBUPTjAbhnfk5zpD0ZPhD7SQPs0tDJpVo8trIpp8TxbEl7prsrw1cO9crutNZGO672TUj9smqGMInyNNS8tBxTm/Ln+kQfLP17IMcm2+J1o6dlksFbMz38bgln79Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtsVwsWo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D520C4CEF7;
	Wed,  5 Nov 2025 03:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762312078;
	bh=WyTGsD4E/mKC5sFVMFInPi8p9SP3Y+rnsjGRYMHi9hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtsVwsWoZ5tgOigU54/r9qKEc0sjpJ/Cmr7m5hdDFZyAUFyPkMxNm8cY140u1LnCK
	 aIsI8EUYfQ/hDBcd60r7vxTHzgUQ3cMoNpFsN3Ed+4jMA1c46eLgVMz4qMC2pEZ8ae
	 bJOm8x4klgHzstv3N0z/Fb45AbK/F+EoNBuD+WDKF1JYz0I7o9Day69N1nL4LLaD2P
	 D6A9LkbWVUIxo09l5t/40QXqq4lHN2jhnnNtv594LG7PiORv7ok0ka56d/swDIse2L
	 CKzHbnbuaFRqJnABR3l3N+i0UWkSeQpfxaEHGiCUKlr7LvRhQ+28PGtCeSl3X1GnYD
	 wjaqJCVMPWWcA==
Date: Tue, 4 Nov 2025 19:07:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <20251104190756.3a69dc2b@kernel.org>
In-Reply-To: <20251031160539.1701943-5-ast@fiberby.net>
References: <20251031160539.1701943-1-ast@fiberby.net>
	<20251031160539.1701943-5-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 16:05:30 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +        name: flags
> +        doc: |
> +          ``0`` or ``WGDEVICE_F_REPLACE_PEERS`` if all current peers
> +          should be removed prior to adding the list below.
> +        type: u32
> +        enum: wgdevice-flags
> +        checks:
> +          flags-mask: wgdevice-flags

The checks: should not be necessary if the enum is specified and it is
itself of type: flags.

