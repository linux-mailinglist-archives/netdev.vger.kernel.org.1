Return-Path: <netdev+bounces-304677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8bDBO5nSGqppwAAu9opvQ
	(envelope-from <netdev+bounces-304677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 03:54:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7E706629
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 03:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IH5wXOns;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304677-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304677-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956FA3018BEC
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1633A005;
	Sat,  4 Jul 2026 01:54:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8B16DC28
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 01:54:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130088; cv=pass; b=luNuIuqtT0QtpseLaf8wY29D7q4l5/axJ4AZT1hphNiilGo+2oLJ+hZ/+8+roG66dQPi+IzRCS79pVd6HmAtZTgkLX6The9bvsBqJju8RkTiPl4D0vrEgvJoOH1dgSrbK8DjnJ+vFLT5LZ7i6SfzXYpAa/z9CkktqgonaNT8aMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130088; c=relaxed/simple;
	bh=M3naiXnwCNHtq9Re8I0tp6HS0IIo8aItqfkP7Mef9uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nh0n/uAQALAN2SBcyLAex1CYmO5Jpku/h5tEUDkJasjTqjplhgXPyUAicz90Pd7b64rR7ljYCjwm/k0vqmtZ8SXkTUOxBZsLiOTltGEa/qdF5miNev1UscHK5HKfIjgMrpaaEw7I17HxNdLdKn8ltogVOAfAywp6eepj2Ji7f8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IH5wXOns; arc=pass smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so8796495ad.3
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 18:54:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783130086; cv=none;
        d=google.com; s=arc-20260327;
        b=fOkwpadR/ZYEsobMt+QneLAjf+9VmZe4g9dE2DbG2XoK4PTr2yYwJ9XLX+bEeTtctz
         o+UDm5oaafec+U2vicYk+WJB3/uD6nBYEnz2F7E/EQIZUNpUxRFg+pxfYTgleclxzVVQ
         sapcBhmFxK4t8zSOFf2p5X9Y3WS2A1hH/39milrUO165B7Ins4IajiStSHZ8P3P9O5Jx
         QJTeRNgmHn2D/ZmL5lPiWUs0znaf6AVebFwY63GhYMM1CnJ+Q0rKv+DSWI5YBDPFCg3B
         TyadF3Um4+zn4zVFFhXgYss7bmoGGc6vz3gF2HPWi3ExhcLCNKVlKnU4iA021VR9SStL
         DsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIOepp1tTdYYkMqZvZOGmsSjYv3BfAn3eel8Pn6Tkko=;
        fh=i9Zd+sPKlizDMVDKS5ZG6BFak87o6L+lmRWETHqJVJg=;
        b=RS24jTTSPoaLvjxGpkEEeSNhnDT1PVTCLg3HvU2OrDoCcxy6OcJcQIQIg1WN6O07dL
         mXz7judQNQdok0mjB25ZYVwP+Tl+OKu8+x/UkOVvk+SupNRPnxpjrXRYtMlgcgntTb2f
         smfLVQxgrCQ/2k2QuXFbjJHCOqzPHf4rrlnOfb2nqZffUB1sf3U8MMZ78UcJAf64FuHe
         l8fdn5oe64ixATvIkDr3T+iNNIMJOtOk6gUlhXTcqXCtRAhpQnQP5I1lrFuAkORQrpA7
         q6q2SkZXT2A9/l4ng/TOINlmkzlcMGfoCIlnKhx37kiVSh17bmrTRb5be65+h22e3LOO
         8RGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783130086; x=1783734886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bIOepp1tTdYYkMqZvZOGmsSjYv3BfAn3eel8Pn6Tkko=;
        b=IH5wXOns1SS6FNWIW+iBdOxYUnBmAph5+ZgpbiqnhS6uWch7hFxG6ivyfchzcXv0Il
         Y9KaSoAc7Xem0Z88vdPj9lVTjQD8/GYsp+u0QMy1wE5OJr5qR/wHt7iZzLjfMN1HRj85
         wVKnmO+xnKv1Yax2kumg1q5cBEMemRxxWwqP3ozvZaXtN4U84pm55PVYwJfI8TyhKoAV
         mU8ek10sTKg2y4dK18TwDjH8jbFjhGpKz3o3wcroOgiARMTbptDZRfd3BNZtVtcSeDir
         JvyBAxCDHlL+cJIGl9EdadysG3JcxLIr8ZrDMQkFsBZV0ZCZba5ZmeTjSlJDTs0qiidr
         yYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783130086; x=1783734886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIOepp1tTdYYkMqZvZOGmsSjYv3BfAn3eel8Pn6Tkko=;
        b=qUZZXqSaNDmOzXPo/85mDVr7GzhXOrEy72x9O14jH9A7yYmoPuJtpLU7ILrqkwZI4D
         Yzeud2/cqHf4faNHXq23pX8fYga6RASdsR7UWGLbWC9l/ZnUXUcxMhFfoi0OGprPReUL
         RFzOUFtU0a9fSDIyarPiT3Fm/XFFv2GRWNwMr/2sG30loOWBg8PNtUpNXa88K9LdmlB0
         66I6Ycw9T+gXovM7oDcYa6KI+IiWk8u0MV2OALfcu2YC70ZiWSSdeM4/aSlj/ODQElf+
         wrzijJ4IXWlBV/yzHdAX5UQLIfwGUI72soZyBss4M0JfOnD/rNVhgJWCcHKJoxhgXNZE
         yYhw==
X-Forwarded-Encrypted: i=1; AHgh+Rp78EmmFFL0UZw0Zy2avl1YRucfzqfgoqVkuiVOZqCP31jqwvbz4MJaIGZBKl+fyAPFntw5naw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25UFoPMEMu1+y/RBDCT29s4jBr1Wt/p0set1ZRN6gmbJtNwUa
	wAJkPEAiL/ENDI3InmFqfCBFw1r6SBcuEGOl+LbJECkBPsUvGCBgyM8g7VHvoroDP+zGs4V6SYz
	oNJGds2n4KVHG3D0JafJHHGK5xprZtgWMg5zX2R4Y
X-Gm-Gg: AfdE7cnLiMSKDo+50MZX67q64LDwLH53mS/xiVcLexpBdlmiCsIaJq7qgql7ZiUaO3x
	OAyjYsb18ljiq5vAv+xq+zJ6Tf5/5pGCs2snTJSvh8SaNExay8PobfR++nYUOHXu7HnAHtioSPt
	cJFGHzQndFRRx3mRpOstojtc8Wl43OQ3E7tt4oc/3i8uN0wscGXhDPRuZvX3yV8w7M3bjSs8lCL
	22Rl6gleHVZGIaBtY7pheoLKGh3Vy03iRq5pljSzmSfGr3tmttbQtLeAvNQVGoldo29FwfHoj1t
	kwTqwp6IgHmgSCImXpcSNpggK3EzmqaCpWYZl5FvmUfnCTl4ff0QAgHfAutW0nu9JLrUo0YaTnx
	5D+jXnDx+o2JGhIciyDt4KtYMOQHdnwAff+0kXKnC
X-Received: by 2002:a17:902:db05:b0:2ca:d658:d88c with SMTP id
 d9443c01a7336-2cbb9ee025amr14692675ad.32.1783130085395; Fri, 03 Jul 2026
 18:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems> <20260703081416.2583118-2-John.Ericson@Obsidian.Systems>
In-Reply-To: <20260703081416.2583118-2-John.Ericson@Obsidian.Systems>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 3 Jul 2026 18:54:33 -0700
X-Gm-Features: AVVi8CfZWIuKG7FQ1KP2u9XAEWXcGQ-IULRdOp5NH2-zHRrZJ8-nYCUBaXhVH1o
Message-ID: <CAAVpQUD=30+=bdB0_UWn4CYvRHMaipYo5mQKr7ZZ8WWDPLhXHQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/3] selftests/net/af_unix: test listen() rejects
 wrong socket states
To: John Ericson <John.Ericson@obsidian.systems>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, John Ericson <mail@johnericson.me>, 
	Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	David Rheinsberg <david@readahead.eu>, Cong Wang <cwang@multikernel.io>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@obsidian.systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304677-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,johnericson.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,obsidian.systems:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CD7E706629

On Fri, Jul 3, 2026 at 1:15=E2=80=AFAM John Ericson
<John.Ericson@obsidian.systems> wrote:
>
> From: John Ericson <mail@johnericson.me>
>
> Add a regression test for the `unix_listen()` state check. The key case
> is `listen()` on a bound socket that has already been connected: it is
> no longer in `TCP_CLOSE` or `TCP_LISTEN`, so it must fail with `EINVAL`.
> A `prepare_peercred()` call slipped in ahead of that check once left
> `err` at 0 and made `listen()` silently succeed there instead; this
> guards against a repeat.
>
> The neighbouring outcomes are covered too so they cannot regress the
> same way: a bound socket in `TCP_CLOSE` listens fine, re-`listen()`ing a
> socket already in `TCP_LISTEN` is allowed, and an unbound socket fails
> with `EINVAL`.
>
> Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reap=
ed sk->sk_peer_pid")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: John Ericson <mail@johnericson.me>
> ---
>  .../testing/selftests/net/af_unix/.gitignore  |   1 +
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_listen.c       | 126 ++++++++++++++++++
>  3 files changed, 128 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_listen.c
>
> diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testi=
ng/selftests/net/af_unix/.gitignore
> index 240b26740c9e..973176644103 100644
> --- a/tools/testing/selftests/net/af_unix/.gitignore
> +++ b/tools/testing/selftests/net/af_unix/.gitignore
> @@ -6,3 +6,4 @@ scm_rights
>  so_peek_off
>  unix_connect
>  unix_connreset
> +unix_listen
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index 4c0375e28bbe..57d159803a3a 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -14,6 +14,7 @@ TEST_GEN_PROGS :=3D \
>         so_peek_off \
>         unix_connect \
>         unix_connreset \
> +       unix_listen \
>  # end of TEST_GEN_PROGS
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/af_unix/unix_listen.c b/tools/te=
sting/selftests/net/af_unix/unix_listen.c
> new file mode 100644
> index 000000000000..7b5264c97f52
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_listen.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tests for the state checks in AF_UNIX listen().
> + *
> + * The central case is a regression test: listen() on a bound socket tha=
t
> + * is already connected (i.e. not in TCP_CLOSE or TCP_LISTEN state) must
> + * fail with EINVAL.  A prior change accidentally let it return success
> + * without doing anything, because a helper called in between reset the
> + * error code to 0.  The neighbouring checks (unbound, already listening=
)
> + * are tested too so they cannot silently regress the same way.
> + */
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <stddef.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#include "kselftest_harness.h"
> +
> +/* Fill @addr with an abstract-namespace address named @name. */
> +static socklen_t unix_abstract(struct sockaddr_un *addr, const char *nam=
e)
> +{
> +       size_t len =3D strlen(name);
> +
> +       memset(addr, 0, sizeof(*addr));
> +       addr->sun_family =3D AF_UNIX;
> +       /* Leading NUL selects the abstract namespace (no filesystem entr=
y). */
> +       memcpy(addr->sun_path + 1, name, len);
> +
> +       return offsetof(struct sockaddr_un, sun_path) + 1 + len;
> +}
> +
> +FIXTURE(unix_listen)
> +{
> +       int sk;                 /* socket under test */
> +       int server;             /* a listening peer, when a test needs on=
e */
> +       struct sockaddr_un addr, srv_addr;
> +       socklen_t addrlen, srv_addrlen;
> +};

Could you add test cases for SOCK_SEQPACKET and pathname
sockets ?  so it will be 4-patterns. see unix_connect.c


> +
> +FIXTURE_SETUP(unix_listen)
> +{
> +       self->sk =3D -1;
> +       self->server =3D -1;
> +       self->addrlen =3D unix_abstract(&self->addr, "unix_listen.sk");
> +       self->srv_addrlen =3D unix_abstract(&self->srv_addr, "unix_listen=
.srv");
> +}
> +
> +FIXTURE_TEARDOWN(unix_listen)
> +{
> +       if (self->sk >=3D 0)
> +               close(self->sk);
> +       if (self->server >=3D 0)
> +               close(self->server);
> +       /* Abstract addresses are released automatically on close. */
> +}
> +
> +/* A bound socket in TCP_CLOSE is the normal, allowed case. */
> +TEST_F(unix_listen, bound_is_ok)
> +{
> +       self->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, self->sk);
> +       ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
> +                         self->addrlen));

Personally I think this style is more readable:

err =3D func(...)
ASSERT_XX(val, err)


> +
> +       EXPECT_EQ(0, listen(self->sk, 8));
> +}
> +
> +/* Listening again on an already-listening socket (TCP_LISTEN) is allowe=
d. */
> +TEST_F(unix_listen, relisten_is_ok)
> +{
> +       self->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, self->sk);
> +       ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
> +                         self->addrlen));
> +       ASSERT_EQ(0, listen(self->sk, 8));
> +
> +       EXPECT_EQ(0, listen(self->sk, 16));
> +}
> +
> +/* listen() on an unbound socket fails: there is nothing to listen on. *=
/
> +TEST_F(unix_listen, unbound_is_einval)
> +{
> +       int ret;
> +
> +       self->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, self->sk);
> +
> +       ret =3D listen(self->sk, 8);
> +       EXPECT_EQ(-1, ret);
> +       EXPECT_EQ(EINVAL, errno);
> +}
> +
> +/*
> + * The regression: a bound socket that has already been connected is not=
 in
> + * TCP_CLOSE or TCP_LISTEN, so listen() must reject it with EINVAL rathe=
r
> + * than quietly succeeding.
> + */
> +TEST_F(unix_listen, connected_is_einval)
> +{
> +       int ret;
> +
> +       self->server =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, self->server);
> +       ASSERT_EQ(0, bind(self->server, (struct sockaddr *)&self->srv_add=
r,
> +                         self->srv_addrlen));
> +       ASSERT_EQ(0, listen(self->server, 8));
> +
> +       self->sk =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_LE(0, self->sk);
> +       /* Bind first so the unbound check does not mask the state check.=
 */
> +       ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
> +                         self->addrlen));
> +       ASSERT_EQ(0, connect(self->sk, (struct sockaddr *)&self->srv_addr=
,
> +                            self->srv_addrlen));
> +
> +       ret =3D listen(self->sk, 8);
> +       EXPECT_EQ(-1, ret);
> +       EXPECT_EQ(EINVAL, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.54.0
>

