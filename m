Return-Path: <netdev+bounces-236129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FDC38BC3
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B68188054B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8E225390;
	Thu,  6 Nov 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWwgSzs1"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144E118C031
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393582; cv=none; b=khQdeJIXToe/cgz/73y1YaFGhFS3Q2kJkWC0u2kCZA5ZDPxYr3jwqgu4stgt+vi4gdv2BNOkODrV6XF4jp0yzQV6/l6yLhNVKg/sRK+5pnT4oHmXvytRPcpqz+4FcMeNXyZkruCKAB0bfocrWUZPM+HfsC54LDiVP5oqHdq8tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393582; c=relaxed/simple;
	bh=sIbyxHknlRsPOtfBGxTjFEh2g6VPtB+XJiqFkPf15so=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=jGITKq5JPeopkkHSl7D117mv/hCkPkykEdnMWLTwnCX6el9KM0uIRXsgzOA7PXQOh5846+bWLbLu5mqyzf75HgKaay4+qaz0ZRaKc3iRT1c0HnVmxh1k3Kh8EuvcsHSWt2KA9ZtZnXvOhw1t6hlxJDwSH4j7CTxUP9iWp1m8B5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWwgSzs1; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762393567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TszfmSBW/nkrbrb4ErvSXyzWPbyqJ16xZJGZgrppN1w=;
	b=ZWwgSzs1l8+/kBA1AzIAztTGWHUCkndRwz80sDGaHGF9OcCjNleat0dCFw0sEcrm1e9bUk
	T1WQAW1mAvWASoO6nwlAtIkY/TYhkVj5KAcGOGN38sFHlTUhCO/4pv8HoS14km22aCd7KO
	QEVNcyhzfnsVb+7CTIe+A/gzbrqFiUo=
Date: Thu, 06 Nov 2025 01:46:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <44dc1c4ae2304201a92d348030460a6eb8d4a282@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v4 3/3] selftests/bpf: Add mptcp test with sockmap
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "Mat Martineau" <martineau@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah
 Khan" <shuah@kernel.org>, "Florian Westphal" <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <cc5017b8-5802-4cf5-93b1-18b1e2bd8ae5@kernel.org>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
 <20251105113625.148900-4-jiayuan.chen@linux.dev>
 <665825df-b995-45ee-9e0c-2b40cc4897ee@kernel.org>
 <b5f67a681be12833efa12e68fc3139954b409446@linux.dev>
 <cc5017b8-5802-4cf5-93b1-18b1e2bd8ae5@kernel.org>
X-Migadu-Flow: FLOW_OUT

November 6, 2025 at 24:28, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20On 05/11/2025 17:12, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> November 5, 2025 at 22:40, "Matthieu Baerts" <matttbe@kernel.org ma=
ilto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kerne=
l.org%3E > wrote:
> >=20=20
>=20>=20=20
>=20>=20
>=20> >=20
>=20> > Hi Jiayuan,
> > >=20
>=20> >  Thank you for this new test!
> > >=20
>=20> >  I'm not very familiar with the BPF selftests: it would be nice i=
f
> > >  someone else can have a quick look.
> > >=20
>=20>=20=20
>=20>  Thanks for the review. I've seen the feedback on the other patches=
(1/3, 2/3) and will fix them up.
> >=20
>=20Thanks!
>=20
>=20>=20
>=20> >=20
>=20> > On 05/11/2025 12:36, Jiayuan Chen wrote:
> > >=20
>=20>  Add test cases to verify that when MPTCP falls back to plain TCP s=
ockets,
> >  they can properly work with sockmap.
> >=20=20
>=20>  Additionally, add test cases to ensure that sockmap correctly reje=
cts
> >  MPTCP sockets as expected.
> >=20=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c | 150 +++++++++++++++++=
+
> >  .../selftests/bpf/progs/mptcp_sockmap.c | 43 +++++
> >  2 files changed, 193 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sockmap.c
> >=20=20
>=20>  diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tool=
s/testing/selftests/bpf/prog_tests/mptcp.c
> >  index f8eb7f9d4fd2..56c556f603cc 100644
> >  --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >  +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >  @@ -6,11 +6,14 @@
> >  #include <netinet/in.h>
> >  #include <test_progs.h>
> >  #include <unistd.h>
> >  +#include <error.h>
> >=20
>=20> >=20
>=20> > Do you use this new include?
> > >=20
>=20>=20=20
>=20>  "EOPNOTSUPP" I used was defined in error.h.
> >=20
>=20Ah OK. I usually only include 'error.h' to use 'error()'.
> Is it not 'errno.h' (or 'linux/errno.h') you want instead?
>=20
>=20I'm just surprised it is not already included but another one above. =
But
> OK if it is not.


Okay, I'll look into it and see if I can get rid of the error.h header.

> >=20
>=20> >=20
>=20> > So here, the client is connected, but sockmap doesn't operate on =
it,
> > >  right? So most likely, the connection is stalled until the userspa=
ce
> > >  realises that and takes an action?
> > >=20
>=20>=20=20
>=20>  It depends. Sockmap usually runs as a bypass. The user app (like N=
ginx)
> >  has its own native forwarding logic, and sockmap just kicks in to ac=
celerate
> >  it. So in known cases, turning off sockmap falls back to the native =
logic.
> >  But if there's no native logic, the connection just stalls.
> >=20
>=20Good to know, thanks!
>=20
>=20So MPTCP request might still be handled by the "native logic" if any?
>=20

Yes.=20If native logic exists, simply blocking the mixing of MPTCP and so=
ckmap
should mostly keep the user's app working.

Thanks.

