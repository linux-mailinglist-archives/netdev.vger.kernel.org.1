Return-Path: <netdev+bounces-278293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IDqMcvV3WkekAkAu9opvQ
	(envelope-from <netdev+bounces-278293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F013F5CEA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B4DA3014D8D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA4D3264CB;
	Tue, 14 Apr 2026 05:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTPhZVYs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48B301471
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145849; cv=pass; b=TyM8mjcsMzeR1ctCb4XYVlLpGm90WsIsZslZwwQFb6JYgzU2irtlFyZr82RBgky7tain+sp6pId1lQ1hKNiUHAL3DPQmfaQboJ89YP0cXyj9+ORJJ+3wiu5/kIefqTQe80V69M0comIULHgWvkpD1BYY3L+z9n7uu5Fp7ms1aN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145849; c=relaxed/simple;
	bh=b4MyJjck3xfnzqA3Mpwj4CRB14hfvnO16wBz1wVugbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH0c5LHoVxGMTn1mcMI51jKto8lh7KkKg7xk0k+uT2soajIJ3KvWhomayXnPJJc7EE9BmZ9OM13tTwuN7HN7T+yOPx4B4QkqrwDkYf6UccNFBrQtdqlgza+sdEvPWuUG2+P+VvdOF5+sWJVYY0LqdHxphxvLH8rq2AeF5oRjeMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTPhZVYs; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c55e3858cso1393623c88.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776145847; cv=none;
        d=google.com; s=arc-20240605;
        b=llUXY70v2SCl+SbsAaljEDTw9YfGdnQnKkzgt9vkMFGhJTf6KtlogGYoV2sH8f008e
         EHIhnIO2QWs5e8LOqvMnfcPX3rHgDq0kge/X/5WkuY9OZtYcC3gXHEN/RZ9af0Yi0j9e
         IvLPBJPqWDaj6xOfvyNpiZnCXIkZU+oEtq81+xNhHcpia9mEBgN+RTVAtJpxkJIG/U2s
         IUk2NCrkVAvBCnu85i6tgrAKvI1F9FKGzJcRCoZBKOMIC8hM/J+YwCOGJTVFfKWa1IaW
         PMBgShfgkk079lizVQTA11sLgO0rbiidwtYb36D7L4f54ee6PbBZcWjcUngWGg+RGgop
         9kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        fh=+G+URAIuHFWXQ6/KaB/UvaKIzMRbUvWcoDn7kmvsY+o=;
        b=R1l6Mo4k5uDQ2Tok5QyMaVEa5JPHVZmCz9FUK68eOVdecd8m+65hwtmbdn/zOOSsHR
         ILPIo8r7G3i29/UlILvL1YAb+u67VnL+Tcy4axD1IsbmaYwTRP4I5eBt6Hb/2vZ7HGAn
         I/g96x64vEQxbdaH+IsB1pmUZm1t//B3klcsom/BIzPeDy7Z6j6bU9Edz18eFTnbT+ZP
         tndR37Lnw7aMaRudToCGBoYbn+hkL7GnGx+AG+/hVWCUjPoGT+Z8vvQMTAs/44FmiuUe
         0Xs8p0ilbhJHHlPjpiX0UACYEnftYACCQb0ERkaBWYcvj09EeBXMtLNoNhMsyEjoWDvH
         6MxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776145847; x=1776750647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        b=dTPhZVYss+yPe/7Qym9Fuxtiel/72rKV5iKEhnNLB7MmjcXdf0jcytvVZUt8PjFNmV
         aZx2Jim0FLyTvcOZ0ecH5OzXjvxWPUFzm65P+KJw+4Dy9KczVv7yulTWGyUP3HCw1Dfb
         /xAM+fVcwzU28L3KzNrfWxUH1H9+Nm49MnVApqA7PfTqhIrmYHSiztYa+4WlBkPUaeej
         wHQugfZlywTb2Nh/NeM4CN7wMKXnHutlIB0oOJ+m/sMVaKn/U0R0nDXkwjTCT84U+I1C
         KKCoCXmaGnCHR5zELvBSEvK9EFuby/9a0gSOdzcgGD94Q1v6T1Ieq/RJEJ2OV7aJrjcy
         6wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145847; x=1776750647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8xC/w8t49636DlDIJyIeZJFwbUar3vdMzMLV+P2FdY=;
        b=pXl3fjGVoqkyoEYNwk1hT17ase5XeVOWI0/XcY3sOb7RHDLThx7qGIeQpRYQkeKnV/
         6/ZZSSeUybqYt5e2C5hLL3UVb4Mrl+clAT1clZH7B/FH59VF/UM1Y2FfuwHyPMvteYaJ
         jFDJlyy58LwrmEgmTVWS01TRxD3ED2CLHZ88aGQkhmiDn9VV4bB9GocgSnqEPcU50wKK
         YTsBC06FJU16dHCg6FdPQWEJThI1jEYZzQ4qjaHrdrLSYLQfSSbueqbSBnbTEaC8m8q8
         LnBJFLRqYY9gnI04mNnDe9abF4ndso6/87t4iSc9p8iQ+6c/4+/YHIgeLUK/9/SMOnRv
         +DnQ==
X-Gm-Message-State: AOJu0Yx1syaLxmL+HmevVnyhE66/JP1tuGs+SOpcPN8tTCRNM8T+pzQq
	dR2lyaHIidUANHaGOfqgjhPx2msbia8gyTfdJwPDkQjLHVQU/979JiNa2MXlZe9HZ5UETlCuVkW
	pOc6ocb8X0qe07t2DaKQKIERz8InmeL0tfIA8+mAo
X-Gm-Gg: AeBDiettgUbwSIupQEav0euGD9T1hUy8HNsKl/gmM5nbJcGMlVP3dBJX6SCbDMlYuNj
	OaG5HcESxQaIzNgpKwNglAzzrNl48SaHZLdsx9Ubl/5BUtf60Xgcy0DF0wHVvSMYXgxVKhZbmzY
	FbNm1+1Mfx4cPJX6/nTNsb4kOlSzwnue1b9Y3Cs5xgSnRZcLz+dx1ecF7R8YJo3WWxKStwpDSTw
	palRI/Ys2+OiLSbDPY0EFGCRrTH3SUJ5ehJJGymg4o9l6niMvnt3iJcjJPH9FdKH9V6Ea6oh4rK
	m/95ON2uLjAihGAh9BCXJShE1zU5oioJVZvmxudzhnzi/cUPh/h55T6kGWFHi9ngDGCTy+ISmjE
	cNqV1ez1ock5IIsBf3a18SUaCyASr3jmbqHisn5w63EYHkEtnX4RjxRVwaSq6WKu2Puu0meBHhQ
	==
X-Received: by 2002:a05:7022:698a:b0:12a:68cc:3efb with SMTP id
 a92af1059eb24-12c34ebade5mr10496341c88.16.1776145845960; Mon, 13 Apr 2026
 22:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411013211.225834-1-jiayuan.chen@linux.dev> <20260411013211.225834-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-2-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 13 Apr 2026 22:50:34 -0700
X-Gm-Features: AQROBzDT2dbg9kp2qWFhZweYdMBKd3sH2bKQwiV-CoaMbLvgWGw0Wl0--ydKlAE
Message-ID: <CAAVpQUCCZVogDUUTfr3k-JxV52kpVvdYzqFC68-J3n6_ugd4Uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests/bpf: verify syncookie
 statistics in tcp_custom_syncookie
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278293-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3F013F5CEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 6:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Add read_tcpext_snmp() helper to network_helpers which reads a
> TcpExt SNMP counter via nstat, and use it in the tcp_custom_syncookie
> test to verify that LINUX_MIB_SYNCOOKIESRECV is incremented and
> LINUX_MIB_SYNCOOKIESFAILED stays unchanged across a successful
> BPF custom syncookie validation.
>
> The delta is captured between start_server() and accept(), which
> covers the full SYN/ACK/cookie-check path for one connection.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 22 +++++++++++++++++++
>  tools/testing/selftests/bpf/network_helpers.h |  1 +
>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 20 +++++++++++++++++

As you touch bpf selftest helper files, please rebase on bpf-next
to avoid possible conflicts and tag bpf-next in the Subject.

Change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

one nit below.


>  3 files changed, 43 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index b82f572641b7..3388dd5112b6 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -621,6 +621,28 @@ int get_socket_local_port(int sock_fd)
>         return -1;
>  }
>
> +int read_tcpext_snmp(const char *name, unsigned long *val)
> +{
> +       char cmd[128], buf[128];
> +       int ret =3D 0;
> +       FILE *f;
> +
> +       snprintf(cmd, sizeof(cmd),
> +                "nstat -az TcpExt%s | awk '/TcpExt/ {print $2}'", name);
> +       f =3D popen(cmd, "r");
> +       if (!f)
> +               return -errno;
> +
> +       if (!fgets(buf, sizeof(buf), f)) {
> +               ret =3D ferror(f) ? -errno : -ENODATA;
> +               goto out;
> +       }
> +       *val =3D strtoul(buf, NULL, 10);
> +out:
> +       pclose(f);
> +       return ret;
> +}
> +
>  int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
>  {
>         struct ifreq ifr =3D {0};
> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index 79a010c88e11..c53cd781df6e 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -84,6 +84,7 @@ int make_sockaddr(int family, const char *addr_str, __u=
16 port,
>                   struct sockaddr_storage *addr, socklen_t *len);
>  char *ping_command(int family);
>  int get_socket_local_port(int sock_fd);
> +int read_tcpext_snmp(const char *name, unsigned long *val);
>  int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)=
;
>  int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)=
;
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..6adfb4b892f8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> @@ -91,12 +91,21 @@ static void transfer_message(int sender, int receiver=
)
>
>  static void create_connection(struct test_tcp_custom_syncookie_case *tes=
t_case)
>  {
> +       unsigned long recv_before, recv_after;
> +       unsigned long failed_before, failed_after;

While at it, please keep reverse xmas tree order


>         int server, client, child;
>
>         server =3D start_server(test_case->family, test_case->type, test_=
case->addr, 0, 0);
>         if (!ASSERT_NEQ(server, -1, "start_server"))
>                 return;
>
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_before),
> +                      "read SyncookiesRecv before"))
> +               goto close_server;
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_befor=
e),
> +                      "read SyncookiesFailed before"))
> +               goto close_server;
> +
>         client =3D connect_to_fd(server, 0);
>         if (!ASSERT_NEQ(client, -1, "connect_to_fd"))
>                 goto close_server;
> @@ -105,9 +114,20 @@ static void create_connection(struct test_tcp_custom=
_syncookie_case *test_case)
>         if (!ASSERT_NEQ(child, -1, "accept"))
>                 goto close_client;
>
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesRecv", &recv_after),
> +                      "read SyncookiesRecv after"))
> +               goto close_child;
> +       if (!ASSERT_OK(read_tcpext_snmp("SyncookiesFailed", &failed_after=
),
> +                      "read SyncookiesFailed after"))
> +               goto close_child;
> +
> +       ASSERT_EQ(recv_after - recv_before, 1, "SyncookiesRecv delta");
> +       ASSERT_EQ(failed_after - failed_before, 0, "SyncookiesFailed delt=
a");
> +
>         transfer_message(client, child);
>         transfer_message(child, client);
>
> +close_child:
>         close(child);
>  close_client:
>         close(client);
> --
> 2.43.0
>

