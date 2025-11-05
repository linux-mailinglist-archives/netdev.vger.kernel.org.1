Return-Path: <netdev+bounces-235863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE9C36AFD
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43D86658C3
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC7D32E743;
	Wed,  5 Nov 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="baFM0iyx"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96561D5CC9
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359139; cv=none; b=heZKMnJF/rqEysxK5Nu0fevFZYRK5TPufG/5yR26AjbvXqlFnP2Hsg8xpWti0A1VyzbY50r1WQ+okHgsBpJx95vgXJT1TbyyimWBvTABwAzIAAjSExfyXnM2sHsfYjy/AFPGEaFGtl++FV3AzWusTAl+Uxb+9IUd083ZjRJgc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359139; c=relaxed/simple;
	bh=JV1piMY9FWz2kSzJwBr1bGiqxTKtVt93I5kC9mSL670=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=iGAiQrkL3vJe4/3t2bI208aUKpKjCnp6r5Pf/UBJDisDeUzTwNciMd+MfNbQ5xOHQceNSFdgk9Y0pDmhVHRBD3J0blWRr6t8jfnMOTN7OrVBhI6VbxjWruduIZnQl7wEAjErK/Lad0yA+oJrI/EdQsdOBw90iYrII0FtKU2+pHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=baFM0iyx; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762359133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeV2eLUSuSC3/7iM2Op1hOrd03eB07H/sYIO5UnkqUc=;
	b=baFM0iyx/644TXbP264AjlW1hrp+adGSBbouysT9eCsZZ3ETuFrLWy9FzSI4zuuvM5TFDC
	newPzkAqxcA7ZDBXqoi8d/E8pyATVRRdcHzCBzxWE8i87FuUGdvMC8fy061exlb2zZie0x
	K04dxU9GXpFjCfaBg0nPGYZqRdkyrcY=
Date: Wed, 05 Nov 2025 16:12:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b5f67a681be12833efa12e68fc3139954b409446@linux.dev>
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
In-Reply-To: <665825df-b995-45ee-9e0c-2b40cc4897ee@kernel.org>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
 <20251105113625.148900-4-jiayuan.chen@linux.dev>
 <665825df-b995-45ee-9e0c-2b40cc4897ee@kernel.org>
X-Migadu-Flow: FLOW_OUT

November 5, 2025 at 22:40, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20Hi Jiayuan,
>=20
>=20Thank you for this new test!
>=20
>=20I'm not very familiar with the BPF selftests: it would be nice if
> someone else can have a quick look.

Thanks for the review. I've seen the feedback on the other patches(1/3, 2=
/3) and will fix them up.


> On 05/11/2025 12:36, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> Add test cases to verify that when MPTCP falls back to plain TCP so=
ckets,
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
>=20Do you use this new include?

"EOPNOTSUPP" I used was defined in error.h.

> >=20
>=20>  +
> >  +end:
> >  + if (client_fd1 > 1)
> >  + close(client_fd1);
> >  + if (client_fd2 > 1)
> >  + close(client_fd2);
> >  + if (server_fd1 > 0)
> >  + close(server_fd1);
> >  + if (server_fd2 > 0)
> >  + close(server_fd2);
> >=20
>=20Why do you check if it is above 0 or 1? Should you not always check i=
f
> it is >=3D 0 for each fd?

My bad, ">=3D0" is correct.

> >=20
>=20> + close(listen_fd);
> >  +}
> >  +
> >  +/* Test sockmap rejection of MPTCP sockets - both server and client=
 sides. */
> >  +static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> >  +{
> >  + int client_fd1 =3D -1, client_fd2 =3D -1;
> >  + int listen_fd =3D -1, server_fd =3D -1;
> >  + int err, zero =3D 0;
> >  +
> >  + /* start server with MPTCP enabled */
> >  + listen_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
> >  + if (!ASSERT_OK_FD(listen_fd, "start_mptcp_server"))
> >=20
>=20In test_sockmap_with_mptcp_fallback(), you prefixed each error with
> 'redirect:'. Should you also have a different prefix here? 'sockmap-fb:=
'
> vs 'sockmap-mptcp:' eventually?

I will do it.

> >=20
>=20> + return;
> >  +
> >  + skel->bss->trace_port =3D ntohs(get_socket_local_port(listen_fd));
> >  + skel->bss->sk_index =3D 0;
> >  + /* create client with MPTCP enabled */
> >  + client_fd1 =3D connect_to_fd(listen_fd, 0);
> >  + if (!ASSERT_OK_FD(client_fd1, "connect_to_fd client_fd1"))
> >  + goto end;
> >  +
> >  + /* bpf_sock_map_update() called from sockops should reject MPTCP s=
k */
> >  + if (!ASSERT_EQ(skel->bss->helper_ret, -EOPNOTSUPP, "should reject"=
))
> >  + goto end;
> >=20
>=20So here, the client is connected, but sockmap doesn't operate on it,
> right? So most likely, the connection is stalled until the userspace
> realises that and takes an action?
>

It depends. Sockmap usually runs as a bypass. The user app (like Nginx)
has its own native forwarding logic, and sockmap just kicks in to acceler=
ate
it. So in known cases, turning off sockmap falls back to the native logic=
.
But if there's no native logic, the connection just stalls.


> >=20
>=20> + /* set trace_port =3D -1 to stop sockops */
> >  + skel->bss->trace_port =3D -1;
> >=20
>=20What do you want to demonstrate from here? That without the sockmap
> injection, there are no new entries added? Is it worth checking that he=
re?

That's redundant. I'll drop it.


[...]
> >  + if (client_fd1 > 0)
> >  + close(client_fd1);
> >  + if (client_fd2 > 0)
> >  + close(client_fd2);
> >  + if (server_fd > 0)
> >  + close(server_fd);
> >=20
>=20Same here: should it not be "*fd >=3D 0"?

I will fix it.

Thanks.

