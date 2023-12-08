Return-Path: <netdev+bounces-55491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73D80B0AE
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC211F21335
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A05ABAF;
	Fri,  8 Dec 2023 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1UWn6VK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B01F92D
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 23:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F9EC433C9;
	Fri,  8 Dec 2023 23:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702079087;
	bh=p4muyRkOeoon7+OItlmp/SqNIwUB/QpxiJ5EJQLn8lA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1UWn6VK3O2AggDI52OH6w/EQ7r7huK/mt0C5ryTpKJC277xLMZATD+tmhqZ1zsCH
	 Yy9bv4ovOPJkEG2ZKM5pjznfpOgJDUPpj2PSvj+8va+LwgiHhDYvVRlSskyu1RN6Or
	 13qQpiEXSq9Legh/RZHcgJFEmCY8ZbpWCIB5OFm1e0l9rtnF5T6GA4yveaIq3tZo39
	 /JYx+uZSLZzEysel3/idui0CqBembgLEGUWkikEo3vhh853D6KQVG9YiTrBqQO+eHq
	 EMuTSoWZJ9L6zARUV2E0vHRPzmhz7pQFOVZeJyvuxUb/x+/YWEzr1HXSJsb8BUMtmc
	 kKTYwPhwTZaBQ==
Date: Fri, 8 Dec 2023 15:44:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Craig
 Taylor <cmtaylor@apple.com>
Subject: Re: mpls_xmit() calls skb_orphan()
Message-ID: <20231208154446.0feee63f@kernel.org>
In-Reply-To: <7915A22A-F1ED-4A5D-AC2A-25D0C05ECAA0@apple.com>
References: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
	<7915A22A-F1ED-4A5D-AC2A-25D0C05ECAA0@apple.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Updating Roopa's email.

On Fri, 08 Dec 2023 13:15:04 -0800 Christoph Paasch wrote:
> > On Dec 8, 2023, at 1:06=E2=80=AFPM, Christoph Paasch <cpaasch@apple.com=
> wrote:
> >=20
> > Hello,
> >=20
> > we observed an issue when running a TCP-connection with BBR on top of a=
n MPLS-tunnel in that we saw a lot of CPU-time spent coming from tcp_pace_k=
ick(), although sch_fq was configured on this host.
> >=20
> > The reason for this seems to be because mpls_xmit() calls skb_orphan(),=
 thus settings skb->sk to NULL, preventing the qdisc to set sk_pacing_statu=
s (which would allow to avoid the call to tcp_pace_kick()).
> >=20
> > The question is: Why is this call to skb_orphan in mpls_xmit necessary ?
> >=20
> >=20
> > Thanks,
> > Christoph =20
>=20
> Resend in plain-text. Sorry about that!


