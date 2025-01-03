Return-Path: <netdev+bounces-155030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12209A00B71
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7541884510
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E263B1FBCA4;
	Fri,  3 Jan 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcpYtjvN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE41FAC5C;
	Fri,  3 Jan 2025 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918272; cv=none; b=oIy6oYkh/D3QruA59VFvWjc/bzL+pgHBph9hOSUszB6krJUoZML2pUIKqy3Nx3cLqGnZjCLHFJumEJosvA2c4a+qmx5+bMp9E0frHDXCw6Vjwuoyy1Dl+H3ks9wKTSXdd/A3/2K1lq8GL577Nzez2VcFibXVJ0muUqE9EJc1sbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918272; c=relaxed/simple;
	bh=WF98epXw3Qv4CPbGrRECANv2+XQKUkVYnJNebl2i+cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHz8gg63/2IGn3aGOZ+NwtwXYkasd7y+OoQtqDyAWIHEmcKLUwfaK3QBYQnt5fcBpASTaHnABQZbaMohz+KtVc9ZpCFFjJKEZTzM/n5Sz8Ei342mSAmYH7K4y6tgdBngsw/dr4DqGCA/HA3pWXK3aBMzi2xjT0oX0vBN7G3eU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcpYtjvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0917C4CECE;
	Fri,  3 Jan 2025 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735918271;
	bh=WF98epXw3Qv4CPbGrRECANv2+XQKUkVYnJNebl2i+cY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tcpYtjvND1iL1I5IXZ1WoMXTgkM62MCXZoV9Cyi/B4KjjcCpfCkLfzmjCl07me2Nr
	 Puyi2zLuPSpzWJxcMDpxx8JxqCiiLoi6l35mejj66mMjmxZ5Jvj0qUYwyJ2K2hPeFn
	 t7WkXhUFRJszM90uWcxTlmV4DOta2asykROg+b4yyR5Xzkxo+UP69XY6XV8OSeqD+t
	 ELOIiUaxp3XCKU9EhpTJOZlHsDDlRT2LZGjf9S4QhE63JBvoFiySMvwmAhOxQWwF1T
	 fSzbWeEDIUzO1uv2FPUxMKJ5BEpOYNqNPwnMcQNJDYLnRfoayf1jos6st2H124B0OT
	 hwR+HFZREtkfw==
Message-ID: <8645aa77-eb46-4d87-94ce-97cd812fd69e@kernel.org>
Date: Fri, 3 Jan 2025 08:31:09 -0700
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
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <76edb53b44ba5f073206d70cee1839ecaabc7d2a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/25 3:27 AM, Shiming Cheng (成诗明) wrote:
> Test cases will be provided later, below are the corresponding IP rule
> configurations for IPv4 and IPv6 that i provided, as well as the
> differences in ping results, the IPv4 result passed, but the IPv6 result
> failed, after adding this patch, the IPv6 result passed.

I do not want the output of a complicated stack of ip rules with a ping
a command.

Provide a simplistic set of commands that configure the stack and show
what you believe is a problem. Anyone on this list should be able to
quickly reproduce the setup to verify it is a problem and investigate
what is happening.

