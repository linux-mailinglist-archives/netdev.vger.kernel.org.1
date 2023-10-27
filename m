Return-Path: <netdev+bounces-44785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74607D9D3C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66952824C7
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221E37C99;
	Fri, 27 Oct 2023 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwa5h2i0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00355D530;
	Fri, 27 Oct 2023 15:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093DBC433C8;
	Fri, 27 Oct 2023 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698421407;
	bh=fW1iwSQjrGUOgKahb2I9wionUD0d03M3iNVyFD4+qUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iwa5h2i0SUwKbH3CXWxfZdjkPJgSe9FB14y77dpheQk4DnKrzCwZglkv96JtfV1GT
	 WH/eTsJ+y3CoAurbQXV8YIfYu207jMWmIj9vXrNwgWh1r3jMAIYiolvcOMS6mr9OuT
	 TQTV6Qwkrxg0zlPT5T52JpRfGsEXk/LPvMixYoiFnldrANanNpo3DhEMlT8E22qwsw
	 lQsYH2GUFYvg+XdNgjBP3DZ9jU9WmaP2bmxV94RtDS186XX5YFDPKnIOZqmk+ywcci
	 MUnQDsPorVfA+cMxIqehKFpg2AuZsr5a8mQKuDIpJUW+liHfDLBTRtIsS4Fe2rwB3P
	 UTxQNeE1hWTkg==
Date: Fri, 27 Oct 2023 08:43:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, Kishen Maloor
 <kishen.maloor@intel.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID
 0
Message-ID: <20231027084324.42e434bb@kernel.org>
In-Reply-To: <aa71b888-e55b-a57d-28cc-f1a583e615f9@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
	<20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org>
	<20231026202629.07ecc7a7@kernel.org>
	<aa71b888-e55b-a57d-28cc-f1a583e615f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 08:34:27 -0700 (PDT) Mat Martineau wrote:
> > This series includes three initial patches that we had queued in our 
> > mptcp-net branch, but given the likely timing of net/net-next syncs this 
> > week, the need to avoid introducing branch conflicts, and another batch 
> > of net-next patches pending in the mptcp tree, the most practical route 
> > is to send everything for net-next.  
> 
> So, that's the reasoning, but I'll send v2 without the cc's.

No need, I can strip when applying.

