Return-Path: <netdev+bounces-134037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBE997B23
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59761F21CAA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39C18BC0F;
	Thu, 10 Oct 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dredr+ZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8918A922;
	Thu, 10 Oct 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728530082; cv=none; b=sx4yk5aT8MhGVFiNzedzLIFp7ZahlkM3fsp3XboQKGqbUwGKVVTw5m5M79M/KOOJkHV9dKQuVc1kTezMqMhLPXQGdgypWnbc+IL211ONHkgy+tmj7/jqdPVRdGfNqvJXpnT3zblGsNhkCOIdLsgH8c6MSMIBAFxkM+j14Q4XmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728530082; c=relaxed/simple;
	bh=+v3HaTqzIfswAN88MhGiwgigMsy9+bix6EonG+bPB1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDrvUvKn36cOhy1DRJrMWIwdLpuyx1DP0XXtsEZwdaXnVBL7q0Z5EHfZXS4UhCvvfjHjBFNXLOIE+0QQTL/q/amDI/jnBNUSg5CdRwq6vnYhlqms5ff0rJ8x4VobTw1eiuF/ri+NjAm3aO6w95elK9d7+8Or+apPQuFsVoJjI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dredr+ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10DEC4CEC3;
	Thu, 10 Oct 2024 03:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728530082;
	bh=+v3HaTqzIfswAN88MhGiwgigMsy9+bix6EonG+bPB1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dredr+ZY7fSrDDEoVg8iFW16tJpfUTVPRucBkXwfCoz3VKfGm0CNDExy1OO8oCLme
	 UZq3x6K+aqY+MpU34E/hHCenrFOjXdf52OPmHask0n5Ocs3ifFpKoDe2yq9gdUMQn1
	 A1if+GAfzgGk/MLKxOhjrRpznXVbVdwKVZafydagMkeJ+6yg77Kd2gXgtmhthZGvdD
	 x6uZ2Wu+e6VjH3rxT4ggoI2+a1x2T+lqntrYRq7ruXhT9a5/wNXud6Es20jElTs7wq
	 DY9OkT7lyuFePs5r7CHKk8pCYYsa3Y0VgDDTW5jSXTEedb9CyAOZb3lgIdRAx8X6uY
	 RqHjBUY0YtMlg==
Date: Wed, 9 Oct 2024 20:14:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [net-next v5 4/9] netdev-genl: Dump gro_flush_timeout
Message-ID: <20241009201440.418e21de@kernel.org>
In-Reply-To: <20241009005525.13651-5-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
	<20241009005525.13651-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 00:54:58 +0000 Joe Damato wrote:
> +        name: gro-flush-timeout
> +        doc: The timeout, in nanoseconds, of when to trigger the NAPI
> +             watchdog timer and schedule NAPI processing.

You gotta respin because we reformatted the cacheline info.

So while at it perhaps throw in a sentence here about the GRO effects?
The initial use of GRO flush timeout was to hold incomplete GRO
super-frames in the GRO engine across NAPI cycles.

