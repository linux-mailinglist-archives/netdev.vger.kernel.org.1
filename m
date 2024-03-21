Return-Path: <netdev+bounces-81094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC8885C55
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 16:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7C1C203B6
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA0128381;
	Thu, 21 Mar 2024 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7vJaxSc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5EF126F1F
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035702; cv=none; b=Dl1+1OgwMM17hhYbcy6EAcJYzzpTk4xwgKTArWmfoZ7NxRFNsaKdD1Rm6YchMKMZ192Syz65SICB6lQL0mzrpXkfaw7K8LqWP/QPfusy9r5DtWOy0tW5SqaCjPXznb7bBbEEOVs3dFF1+o4ZR/VHrAs5a8t92UN1/TWbQ3n13dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035702; c=relaxed/simple;
	bh=411u/QLZGX71Y3U5+YaJNy/+WsA2picHQsAagnJwAyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkiXcYheLO8PpRuWN7ZUUDXBJDeRFEZzPCHu/mGduxMQxNlnu73BpGhDiCmU/q4KKsXlUNvLAFIywuZv5DJUJN0CjdqRkRp0m1EZ5DeBqBZvuOPdoN3mQVwKBYG/44E4ChdFS2cXTpzVK3E+7PjoT/YGqd1wZmbYO1ubf/JVcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7vJaxSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A514AC433F1;
	Thu, 21 Mar 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711035701;
	bh=411u/QLZGX71Y3U5+YaJNy/+WsA2picHQsAagnJwAyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7vJaxScSws6Wh/yFpOZN5tf5ImMUNW1YTCi19rQvB4q2ftxMJoKnsUqE7Ebo2TKA
	 l2o/t5P01Pqk1v6K0iZV0Iezk6wnp5jgrPE05h8g1g+YeiwHUmNejfhmDTeSU2ik7M
	 v3vKC3PFQbj4ts0vA33cp+C6uvUBo9Tvrb0lTeSTD/0Jq72covckIhlPkWLzA5lMd2
	 e+oTsMsGqig8yBjtZIHT01tESblBelKnbtC9bw/RS8KrxexoBvkc7/Wc+iY7+X6f+d
	 Ti1Hddb7tqIyuqQhfWurBb2YqGgw3CgyAJMIM3BV3+/90zPCSZ8zj/FQW6fJcaxyKj
	 80cIk5Dnhtmcg==
Date: Thu, 21 Mar 2024 08:41:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lynne <dev@lynne.ee>
Cc: Florian Westphal <fw@strlen.de>, Netdev <netdev@vger.kernel.org>, Kuniyu
 <kuniyu@amazon.com>, Willemdebruijn Kernel
 <willemdebruijn.kernel@gmail.com>
Subject: Re: Regarding UDP-Lite deprecation and removal
Message-ID: <20240321084139.4dac7e74@kernel.org>
In-Reply-To: <NtHhf_6--3-9@lynne.ee>
References: <Nt8pHPQ--B-9@lynne.ee>
	<ZfhLUb_b_szay3GG@strlen.de>
	<NtHhf_6--3-9@lynne.ee>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 18:58:10 +0100 (CET) Lynne wrote:
> Mar 18, 2024, 14:18 by fw@strlen.de:
> > Lynne <dev@lynne.ee> wrote:
> >  
> >> UDP-Lite was scheduled to be removed in 2025 in commit
> >> be28c14ac8bbe1ff due to a lack of real-world users, and
> >> a long-outstanding security bug being left undiscovered.
> >>
> >> I would like to open a discussion to perhaps either avoid this,
> >> or delay it, conditionally.
> >>  
> >
> > Is there any evidence UDP-Lite works in practice?

FWIW I also vote to delete UDP-Lite unless we have real uses that show
benefit, preferably _in production_.

> > I am not aware of any HW that will peek into L3/L4 payload to figure out
> > that the 'udplite' payload should be passed up even though it has bad csum.
> >
> > So, AFAIU L2 FCS/CRC essentially renders entire 'partial csum' premise moot,
> > stack will never receive udplite frames that are damaged.

Plus FEC protection on top of FCS is increasingly common.

I presume someone did mathematical analysis that UDP Lite is sound,
but my engineering senses are tingling at the thought that we're
simultaneously saying that BER is high enough to want to process
damaged packets, and low enough for the internet csum to be
sufficiently strong.

The whole thing feels a little bit like an attempt to preserve
zero-checksum for IPv6. For HW which wants to spit out IP headers
followed by a block of raw unchecksummed data. I've done such things
in the past on an FPGA out of laziness. Nothing to do with receiving
actually damaged frames.

> > Did things change?
> >  
> 
> I do somehow get CRC errors past the Ethernet layer on consumer rtl cards,
> by default, with no ethtool changes, so maybe things did change.

Yes, but that's just the last hop. Is the entire network going
to disable L2 csums? Or are we just going to use the UDP-lite-
-abilities on the last hop?

> I haven't sacrificed a good cable yet to get a definitive proof.
> The cargo-culted way to be sure is to enable rx-all.

