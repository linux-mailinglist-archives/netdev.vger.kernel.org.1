Return-Path: <netdev+bounces-235699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D3C33D48
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9372518C12F6
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B125785E;
	Wed,  5 Nov 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6jIHDjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4A25228C;
	Wed,  5 Nov 2025 03:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312123; cv=none; b=UGSz0SsW2c5w1VeyzQjrp7weWNGeYIjBm9yt8tjGgW+eIPlO97fPVhGCoJt99kUB54D63xTGPjWM9FzafXDYPvhfz6fZlVq8iz3rujUiVBaQfg/FW4sOkXAPqxPYl1NSXOyyLGBD6n2EaDOljYoc8F25DkUo+aQiuoD7h4tuqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312123; c=relaxed/simple;
	bh=NvQUlmMUDmhAWgdOKXsE+mpimU1iKO5RAOMSw6oUQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND8LKQI/C8xjuB0x18i5FewmKdrCk+uEFu9wyN2/YBS5+pFZr+ex77Q484ezSWpkxNKGZ9WlRUWjRj5Ix/6rbR3UP+dZ/NgKDBoetFu5GRgNqld1wM4fQHSsJUCCrN2t5O/rm9N7MQRvnkAGiO6ltZDGasQVscGW92ilbc0puEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6jIHDjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A519BC4CEF7;
	Wed,  5 Nov 2025 03:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762312123;
	bh=NvQUlmMUDmhAWgdOKXsE+mpimU1iKO5RAOMSw6oUQrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P6jIHDjTeyX6ethNRRJMD5EovegiDTduo6YGzggos3a/DH7mxZ6y1XOVS+SM288nR
	 b6ffktFLr2RjpZ+R5u7qtaHkQZpi2pGDrYQxCilhwAxJXXbdW+TKws+sesrBVisLUy
	 meauF+6T+gDFizvVM6FrdvFCAU1sA3gzeh9CHjhWNzvTr5MRzRrif4vsOuLi60LOH6
	 F0apF7oF+tJ8/8gZwJzw5ybZUS00LOm5FCNmVKTW/qJGXW5mqWrxu9ODysMRNXMALZ
	 IY8DYag1RUtySxaBU7ieGvy9E6Io6ZIDLMtxG9dPj5087XqlbJ1NNVeNslEV5LJgvA
	 JLDRCjVoFsWWA==
Date: Tue, 4 Nov 2025 19:08:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/11] tools: ynl: add sample for wireguard
Message-ID: <20251104190841.4582e578@kernel.org>
In-Reply-To: <20251031160539.1701943-9-ast@fiberby.net>
References: <20251031160539.1701943-1-ast@fiberby.net>
	<20251031160539.1701943-9-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 16:05:34 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +F:	tools/include/uapi/linux/wireguard.h

Please don't copy the headers. Add an entry in Makefile.deps instead.

