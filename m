Return-Path: <netdev+bounces-159658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C0DA16487
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 00:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123BA188500F
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78C1DF983;
	Sun, 19 Jan 2025 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/hmYgiu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E476257D;
	Sun, 19 Jan 2025 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737328910; cv=none; b=Bu5ZC6p1ssdkp56dhTBdX84LzLMdImpTFm3Uz1IdpcFvYi9BPOWqku1lO8yYmSQn2ZhZ4zs4nf0NlFcmBFPi0JwsqKpBXfGOlG+sg7px98TjsVwdBUJROUnFFTzLNIPS7X84VZ6XMH373bHxIWpK/UeFhcvBlAP1wsXx9V7YPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737328910; c=relaxed/simple;
	bh=XKGZeDhU7PiQpRL7YUAxTH2jEdoWiRxN53NNgDlLeD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaG4xhol7Ska8z7+ryrp0yiJ4wrSLG0UtPXhuHegxOaguE8F3Cu4O+8dY0uOtfZ5drolzjP6AtD/8xCz+Uh1LHA3BPjqlH3BQ8DgVdp5r8Gklmd3owNYK2yR/AMYhL67pfE0LJeqoeZuPR0y1EcGjD3IGgIlDAnMZI17cOfg3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/hmYgiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D635DC4CED6;
	Sun, 19 Jan 2025 23:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737328909;
	bh=XKGZeDhU7PiQpRL7YUAxTH2jEdoWiRxN53NNgDlLeD0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h/hmYgiuG4Dav+bb3wj0XPjSalVEFtLV8aec+edtN7flfYYWSRqiCzXbyzRyjInPI
	 el5xLioyc+gr6uifqUHcrlzNQhDHSrHu++a9y624q5VT7pB188CeTwTs2eHUxddUsJ
	 tccF7vNSRqpkCTw4NBgf/OU/R3mAlDmmPWR8w/SIDRK5k1vcVWSZYRtT+xNLHh1/sh
	 vDe/WZK+ZSiug8SLRhEpiYcRkB4pcJ9uNBI2lvbLnALUud22u9Q6N5oa3+Bb3zk3SV
	 gR4xg4eKMASthk80E7JwrlBuHL5wSmp4qXaIoAR/aV7CvrPTrpbR2Ya5VBz4sTi5Xh
	 5kn5xrfcKSzLg==
Message-ID: <44d9b02c-becc-4578-ba06-d4d9fa77b493@kernel.org>
Date: Sun, 19 Jan 2025 16:21:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Content-Language: en-US
To: =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?=
 <Shiming.Cheng@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
References: <20250103054413.31581-1-shiming.cheng@mediatek.com>
 <76edb53b44ba5f073206d70cee1839ecaabc7d2a.camel@mediatek.com>
 <8645aa77-eb46-4d87-94ce-97cd812fd69e@kernel.org>
 <5dbb7b8db7f4d31b620e5780e4716a9881252534.camel@mediatek.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <5dbb7b8db7f4d31b620e5780e4716a9881252534.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/25 8:11 PM, Shiming Cheng (成诗明) wrote:
> 
>   ip -6 -netns test1 rule add from all unreachable pri 1
>   ip -netns test1 rule add from all unreachable pri 1

The bug is in ipv4, ip_route_output_key_hash_rc():

   err = fib_lookup(net, fl4, res, 0);
   if (err) {
        res->fi = NULL;
        res->table = NULL;
        if (fl4->flowi4_oif &&
           (ipv4_is_multicast(fl4->daddr) || !fl4->flowi4_l3mdev)) {
...

The fib lookup should fail because of the unreachable rule, but the
output side is overlooking it for this legacy reason.

ip6_route_output_flags does not have this exception and so it is rightly
failing.


