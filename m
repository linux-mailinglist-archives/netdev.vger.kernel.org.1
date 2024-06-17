Return-Path: <netdev+bounces-104171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC990B684
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F9A1F23838
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276415F30B;
	Mon, 17 Jun 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ5rxkkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12215D5CA
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642182; cv=none; b=FasPozaB1J8d3QjHGNcif4FUQ6R/hBfRn+auO6LezWvCEJHW0QFqeYCZBQWhYWxr9mFkgYhX+qxp3cjf0t3v0ZajF80FliJ6/za3qTMTHG5CUIMgYme76FYakb+TCzwEOx6qbBHQcn5fahh7I1w6TcTq7LoioZPX7aVyfaVT40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642182; c=relaxed/simple;
	bh=CSL1o6fxGIv2fzLFvOKd91kLRU4Tlnt1Dy/MrMijLHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLl45DiLENGieizjhDuTsKGGD5OxFHVHMf67+ePSNL7yd3FQPlVHA9zE+VF2TiD+zgBxtKAAjBz1Asr6LJyJc4tK9McW4f7NPbmVjijrBfDX+hDwoOw1g2zU7Sj2fd/qCOX0cl1rITmkkntg/uAbsOhedOXbsK4VsvBsteKdZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ5rxkkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED13C2BD10;
	Mon, 17 Jun 2024 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718642181;
	bh=CSL1o6fxGIv2fzLFvOKd91kLRU4Tlnt1Dy/MrMijLHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZ5rxkkVgYgfYqImdSA/XCUNH35lYEgmuFPMboc2Ikai6OGxt0rhSTlDiVBFexuCV
	 2f9IoQJdO9DF8S/ojMND0Wah2Ng5XrC92HLlvEOU0AKnOqCZ8aWTr118RZcvIc7GtO
	 o2u43YZ/3AMV2f2XcWnWXmGy7VkB/XsaDHloo+LA1K3IsPanI+4/TQnU/sO5D7OAVU
	 FqMonfQVMYFk5fA4E7kuS2mxQNEV+hssrH+TMzg3529szQuGsAYfBF8M87DNyARCpU
	 pyKcPSbzMS7RAQIB3qUghiuLSnVEwqTPJ16Cn1rWdc1xZsyNsc96HFUfttiaDGzgUU
	 Db9yDVfczVgUQ==
Date: Mon, 17 Jun 2024 09:36:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to
 RTM_GETNEIGH
Message-ID: <20240617093620.12a9b539@kernel.org>
In-Reply-To: <CANP3RGeENFk0RFD2m1kBuOJxdAhKEjR=9caokkKah35py5kXbg@mail.gmail.com>
References: <20240615113224.4141608-1-maze@google.com>
	<CANP3RGeENFk0RFD2m1kBuOJxdAhKEjR=9caokkKah35py5kXbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Jun 2024 10:09:07 +0200 Maciej =C5=BBenczykowski wrote:
> For the other patch, I've tracked down:
>   32affa5578f0 ("fib: rules: no longer hold RTNL in fib_nl_dumprule()")
> which causes half the regression.
>=20
> But... I haven't figured out what causes the final half (or third
> depending on how you look at it).

To be completely honest I also have a fix queued for the other case,
since it was reported already a month ago. But I "forgot" to send it.
I had these tags on it:

    Reported-by: Stefano Brivio <sbrivio@redhat.com>
    Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
    Reported-by: Ilya Maximets <i.maximets@ovn.org>
    Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@=
ovn.org
    Fixes: 4ce5dc9316de ("inet: switch inet_dump_fib() to RCU protection")
    Fixes: 5fc68320c1fb ("ipv6: remove RTNL protection from inet6_dump_fib(=
)")
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

LMK if you want to resend yours or I should send mine, because Ilya
pinged the old thread this morning..

> I've also spent quite a while trying to figure out what exactly is
> going wrong in the python netlink parsing code.
> The code leaves a *lot* to be desired...
>=20
> Turns out it doesn't honour the nlmsghdr.length field of NLMSG_DONE
> messages, so it only reads the header (16 bytes) instead of the kernel
> generated 20=3D16+4 NULL bytes.  I'm not sure why those extra 4 bytes
> are there, but they are... (anyone know?)

They are the error code. Just like in a netlink ack. And similarly
extack attrs may follow. Main difference with ack off the top of my
head is that DONE never echos the request.

> This results in a leftover 4 bytes, which then fail to parse as
> another nlmsghdr (because it also effectively ignores that it's a DONE
> and continues parsing).
> Which explains the failure:
>   TypeError: NLMsgHdr requires a bytes object of length 16, got 4
>=20
> Fixing the parsing, results in things hanging, because we ignore the DONE.
>=20
> Fixing that... causes more issues (or I'm still confused about how the
> rest works, it's hard to follow, complicated by python's lack of types
> and some apparently dead code).
>=20
> Ultimately I think the right answer is to simply fix the horribly
> broken netlink parser, which only ever worked by (more-or-less)
> chance.  We have plenty of time (months) to fix it in time for the
> next release of Android after 15/V, which will be the first one to
> support a kernel newer than 6.6 LTS anyway.
>=20
> Furthermore, the python netlink parser is only used in the test
> framework, while the non-test code itself uses C++& java netlink
> parsers (that I have not yet looked at) but is likely to either work
> or contain entirely different classes of bugs ;-)

We do have: tools/net/ynl/lib/ynl.py in the tree, FWIW.=20
It's BSD-licensed, feel free to lift it / some of it.
It's designed for the netlink YAML specs but the basics like=20
message / attr parsing should work.

