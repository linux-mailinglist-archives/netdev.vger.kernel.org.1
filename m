Return-Path: <netdev+bounces-272174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJZ8F/9wxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F1833965C
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75D6730EE52F
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A74421883;
	Thu, 26 Mar 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9MnzqE5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C153B425CEE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546434; cv=pass; b=aZB5z+prlyMH8O56TKbMMOsucrNSV0IF9hiqvt7gr53+mdU5MEUiI4frfyT4O8oPTKAnB5S0BzoljG/AP4yZnM5HJ3+EfQ+xbjrxLH4Z469PKsJ7I2FE224/Zl0m8UvbqTBCDegx5hF9TKMDLFrqsYuc+zw/kYaqBVRTFzwZ2HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546434; c=relaxed/simple;
	bh=enIR8hn0lGh5urCvp0sBzvHWDNRFkxHFSP3DvhwRZr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufjdhFMI7fCUEwQ9+cKSCSQEbvcQ4jSKFcY+kreiRTWTaZqjyNGu8H7kH7z1Q/viiDjoJoSFsJGgS2XJzBkbJ9Sdj5ckwT69xolL9oDfEyxEiYOcaKj6DioUnumhj1+G18ZebLAa9oZkyzVjwSI5r3TAsV+Ag0nUeWhpU1TolLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9MnzqE5; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128e4d0cc48so1576340c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 10:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546431; cv=none;
        d=google.com; s=arc-20240605;
        b=OiX2x5tDfjgOYUJrqQ4CMOc9Ff9ibWsLN7OlBtExcft6WlRTzblyO5gPVgvaps5z4k
         r+Cb8IUC7DUKbkdd8D1F2+MDFryoDrcxeD8CG9Tktb38K+d7pplSaYUrHS9GjEJXL94B
         nyFZXcSycTiB1aqLrl78l2HIDpL21g9311hgmK+9mxe6hrmU5fgm29TMBFbDlYXnim1f
         HzfH3HIouJ5pSHeNokDqVDFcK6m7DbZiQGqLQudt9QnoZIhHMVwt/wXjK6lvPVf2V+4l
         lMbVLcOmfzhK9421X8npMAymUwNrGrw1c1mgRSWtNQMbNfvw1PhkVlFNodNHpLCNGkka
         Q75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        fh=UZt7F/y9N/tWvexsvQp1TmHwtwFT4bVtfOkmVgntoD0=;
        b=HBZkPX/eXDDdaEwEo7M0frNuRKWGdhs0JDWe0bpIKYvSuPqfK/1BRK66pwvOEViZ6n
         w7dj6k+CmO8zg5U5G8hGd76OQ47TpLFGSTpnbQZnb5ywUBu+CF9sCkkR9SOF+1uEErXE
         Lc81mFTi8wNBhg9WDQBM3iFG3lkdmzlxJSX8XWigZXIn7yJvpL2qBF3hFJxysHkUVUup
         QXLdMf1DXbHtXsWeyF6qZcFea9OwuI+RCSva/si4rFhqhBZDFkf80iq2pKjWkeO4GWfV
         nzRN+IRSuIibUUXWl8cYl4ShLbVo9fpe37wmwSTlHusWlTBsqwBH69YLzxQE6Bv2jbQF
         /eAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774546431; x=1775151231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        b=v9MnzqE5YJGSnT7br/Zv+Fxx6l1BdoHZyk8LKc5ZBuyMk8dwPUMP2owMvvlJwDwOjX
         QY7eWIbbW76V0ed6fnlT9KibT+0r12tem9fvYXxNblzWx5XTpgqrC/SJVUUlVAYrGldL
         AG9OcmM0KYCBb51+k4kCBjO/gcnknfnD0PNIHvQ4aERdVsHxBxOVZ91LXJzLt36KJtfy
         TPjGplb58TWu1JuqmgAUGLPWvKbW79LKFIWztfIDkOhe0j5GUv7EgDyg5JtUsTpKRuNz
         DG+X53cnXqR0mT77d5XciVbG95bQG4ttoZZrW5PqoDl4gwqzaCW6aAQvoIE1FWJN+FB8
         lK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546431; x=1775151231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBlbyIdCNBEMI5MiB4eQOKODfC+ZCUFx/Clh1SgBkSc=;
        b=RHKmUX1riDv379EPmvRkkPUktB2+LjRghf3vE2wE0O6X2MRTHSXxAtK1cJYTby/yay
         /kkNAA7av3q3+Hfa79arDxEnBKP+qP9xL7IpE1De6qBrK1OniMcHuK6LmwlZPTlLEXTJ
         Jv23x/li0YkQFEAo7Of6VX3WaFWFJRCF4pSiiAhtw2b8qMVlyXouZAz2J6dF25I54wOO
         QUavY31G7s2V1xXEGD/ed4AMq78bT+kCB/zTny0d7PVqwk7/PucIcfyhQdTCSVwQ5Sa9
         dqL+cQnN8BxJlShdKCX4Y13e+NajlIV2CNQsEB1Hf2pQWfbUP+wH4n5qHId9i/OV5VOv
         mWSA==
X-Gm-Message-State: AOJu0Yw7lWprvNl3cCOIUcWUU1gQ0948DrUQXIQCknRJXLUdlF+ObV4S
	PPHqM0wGboznNxfMjiYbRscRL7ppF3YqZSo9/3FXla24JWhD6YTzz+YzxtR/ilD1uvUe3q0ZDSb
	gW+enSj8OIKOqCQoEiMQlXy4Cd3XpMv//tURLELuo
X-Gm-Gg: ATEYQzwm4l8mFsGaTuAN6hA1voQloNDTh4oFGjKRgAg/onq2kgSk2hxYGkltey1Q64U
	DHiV/Gy5h7XFcyc4oU+3lIBYjM5xc+dGJpuqi14usIP4wBDCVEshBvDKmsPwiunWIkzhW6q7Je0
	ABz1tUrJ8cpl2VUBgh2vrmVAoceXrSwKN5qclk4flE0PokkujpZqqmbJ2oO0fxZGTaRd2FIiVRI
	zov2tFSPej2rzpy2n5VossdaDpwJSoBzy6RXA0No7rZF09ZDTGVbh9rNx+zo95m1JgnHQthBvsJ
	w9KM+CP3Y+o5gBq3739QfgQwmPwtcF60rv7BX58kn/yZ7acl/8Bpj8ipaCmKC46rVTYz7A==
X-Received: by 2002:a05:7022:510:b0:128:c77a:6c8e with SMTP id
 a92af1059eb24-12a96ee761bmr4396564c88.28.1774546430167; Thu, 26 Mar 2026
 10:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326062657.88446-1-jiayuan.chen@linux.dev> <20260326062657.88446-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260326062657.88446-3-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Mar 2026 10:33:38 -0700
X-Gm-Features: AQROBzDQ517miMG9UXLHYmpX05dz7v3KwflXAHCbFO1GCpDNoBoxWfF4Zv9vwmM
Message-ID: <CAAVpQUAKAeU8SXpKQwcQS6P6aFJ_BxmevcrK=Hs+_rf_mnaLXA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add protocol check test for bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272174-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,ipv4.sport:url,shopee.com:email]
X-Rspamd-Queue-Id: F3F1833965C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> Add test_tcp_custom_syncookie_protocol_check to verify that
> bpf_sk_assign_tcp_reqsk() rejects non-TCP skbs. The test sends a UDP
> packet through TC ingress where a BPF program calls
> bpf_sk_assign_tcp_reqsk() on it and checks that the kfunc returns an
> error. A UDP server recv() is used as synchronization to ensure the
> BPF program has finished processing before checking the result.
>
> Without the fix in bpf_sk_assign_tcp_reqsk(), the kfunc succeeds and
> attaches a TCP reqsk to the UDP skb, which causes a null pointer
> dereference panic when the kernel processes it through the UDP receive
> path.
>
> Test result:
>
>   ./test_progs -a tcp_custom_syncookie_protocol_check -v
>   setup_netns:PASS:create netns 0 nsec
>   setup_netns:PASS:ip 0 nsec
>   write_sysctl:PASS:open sysctl 0 nsec
>   write_sysctl:PASS:write sysctl 0 nsec
>   setup_netns:PASS:write_sysctl 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:open_and_load 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:start tcp_server 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:start udp_server 0 nsec
>   setup_tc:PASS:qdisc add dev lo clsact 0 nsec
>   setup_tc:PASS:filter add dev lo ingress 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:udp socket 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:sendto udp 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:recv udp 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:udp_intercepted 0 nsec
>   test_tcp_custom_syncookie_protocol_check:PASS:assign_ret 0 nsec
>   #471     tcp_custom_syncookie_protocol_check:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  .../bpf/prog_tests/tcp_custom_syncookie.c     | 84 ++++++++++++++++++-
>  .../bpf/progs/test_tcp_custom_syncookie.c     | 79 +++++++++++++++++
>  2 files changed, 159 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> index eaf441dc7e79..c50b76f70988 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcp_custom_syncookie.c
> @@ -5,6 +5,7 @@
>  #include <sched.h>
>  #include <stdlib.h>
>  #include <net/if.h>
> +#include <netinet/in.h>
>
>  #include "test_progs.h"
>  #include "cgroup_helpers.h"
> @@ -47,11 +48,10 @@ static int setup_netns(void)
>         return -1;
>  }
>
> -static int setup_tc(struct test_tcp_custom_syncookie *skel)
> +static int setup_tc(int prog_fd)
>  {
>         LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point =3D BPF_TC_INGRE=
SS);
> -       LIBBPF_OPTS(bpf_tc_opts, tc_attach,
> -                   .prog_fd =3D bpf_program__fd(skel->progs.tcp_custom_s=
yncookie));
> +       LIBBPF_OPTS(bpf_tc_opts, tc_attach, .prog_fd =3D prog_fd);
>
>         qdisc_lo.ifindex =3D if_nametoindex("lo");
>         if (!ASSERT_OK(bpf_tc_hook_create(&qdisc_lo), "qdisc add dev lo c=
lsact"))
> @@ -127,7 +127,7 @@ void test_tcp_custom_syncookie(void)
>         if (!ASSERT_OK_PTR(skel, "open_and_load"))
>                 return;
>
> -       if (setup_tc(skel))
> +       if (setup_tc(bpf_program__fd(skel->progs.tcp_custom_syncookie)))
>                 goto destroy_skel;
>
>         for (i =3D 0; i < ARRAY_SIZE(test_cases); i++) {
> @@ -145,6 +145,82 @@ void test_tcp_custom_syncookie(void)
>
>  destroy_skel:
>         system("tc qdisc del dev lo clsact");
> +       test_tcp_custom_syncookie__destroy(skel);
> +}
>
> +/* Test: bpf_sk_assign_tcp_reqsk() should reject non-TCP skb.
> + *
> + * Send a UDP packet through TC ingress where a BPF program calls
> + * bpf_sk_assign_tcp_reqsk() on it. The kfunc should return an error
> + * because the skb carries UDP, not TCP.
> + */
> +void test_tcp_custom_syncookie_protocol_check(void)
> +{
> +       int tcp_server =3D -1, udp_server =3D -1, udp_client =3D -1;
> +       struct test_tcp_custom_syncookie *skel;
> +       struct sockaddr_in udp_addr;
> +       char buf[32] =3D "test";
> +       int udp_port, ret;
> +
> +       if (setup_netns())
> +               return;
> +
> +       skel =3D test_tcp_custom_syncookie__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +               return;
> +
> +       /* Create a TCP listener so the BPF can find a LISTEN socket */
> +       tcp_server =3D start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0,=
 0);

Can you add IPv6 test as well ?
You can reuse test_tcp_custom_syncookie_case[].


> +       if (!ASSERT_NEQ(tcp_server, -1, "start tcp_server"))
> +               goto destroy_skel;
> +
> +       /* Create a UDP server to receive the packet as synchronization *=
/
> +       udp_server =3D start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, =
0);

You can specify the port to get_socket_local_port(tcp_server),


> +       if (!ASSERT_NEQ(udp_server, -1, "start udp_server"))
> +               goto close_tcp;
> +
> +       skel->bss->tcp_listener_port =3D ntohs(get_socket_local_port(tcp_=
server));
> +       udp_port =3D ntohs(get_socket_local_port(udp_server));
> +       skel->bss->udp_test_port =3D udp_port;

then the 3 lines above will be unnecessary,


> +
> +       ret =3D bpf_program__fd(skel->progs.tcp_custom_syncookie_badproto=
);
> +       if (setup_tc(ret))
> +               goto close_udp_server;
> +
> +       udp_client =3D socket(AF_INET, SOCK_DGRAM, 0);
> +       if (!ASSERT_NEQ(udp_client, -1, "udp socket"))
> +               goto cleanup_tc;
> +
> +       memset(&udp_addr, 0, sizeof(udp_addr));
> +       udp_addr.sin_family =3D AF_INET;
> +       udp_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +       udp_addr.sin_port =3D htons(udp_port);

and you can reuse get_socket_local_port(tcp_server) here too.


> +
> +       ret =3D sendto(udp_client, buf, sizeof(buf), 0,
> +                    (struct sockaddr *)&udp_addr, sizeof(udp_addr));
> +       if (!ASSERT_EQ(ret, sizeof(buf), "sendto udp"))
> +               goto cleanup_tc;
> +
> +       /* recv() ensures TC ingress BPF has processed the skb */
> +       ret =3D recv(udp_server, buf, sizeof(buf), 0);
> +       if (!ASSERT_EQ(ret, sizeof(buf), "recv udp"))
> +               goto cleanup_tc;
> +
> +       ASSERT_EQ(skel->bss->udp_intercepted, true, "udp_intercepted");
> +
> +       /* assign_ret =3D=3D 0 means kfunc accepted UDP skb (bug).
> +        * assign_ret < 0 means kfunc correctly rejected it (fixed).
> +        */
> +       ASSERT_NEQ(skel->data->assign_ret, 0, "assign_ret");
> +
> +cleanup_tc:
> +       system("tc qdisc del dev lo clsact");
> +       if (udp_client >=3D 0)
> +               close(udp_client);
> +close_udp_server:
> +       close(udp_server);
> +close_tcp:
> +       close(tcp_server);
> +destroy_skel:
>         test_tcp_custom_syncookie__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.=
c b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> index 7d5293de1952..386705b6c9f2 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
> @@ -588,4 +588,83 @@ int tcp_custom_syncookie(struct __sk_buff *skb)
>         return tcp_handle_ack(&ctx);
>  }
>
> +/* Test: call bpf_sk_assign_tcp_reqsk() on a UDP skb.
> + * The kfunc should reject it, but currently it doesn't check L4 protoco=
l.
> + */
> +__u16 tcp_listener_port =3D 0;
> +__u16 udp_test_port =3D 0;
> +int assign_ret =3D -1;
> +bool udp_intercepted =3D false;
> +
> +SEC("tc")
> +int tcp_custom_syncookie_badproto(struct __sk_buff *skb)
> +{
> +       void *data =3D (void *)(long)skb->data;
> +       void *data_end =3D (void *)(long)skb->data_end;
> +       struct bpf_sock_tuple tuple =3D {};
> +       struct bpf_tcp_req_attrs attrs =3D {};
> +       struct ethhdr *eth;
> +       struct iphdr *iph;
> +       struct udphdr *udp;
> +       struct bpf_sock *skc;
> +       struct sock *sk;
> +
> +       eth =3D (struct ethhdr *)data;
> +       if (eth + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (bpf_ntohs(eth->h_proto) !=3D ETH_P_IP)
> +               return TC_ACT_OK;
> +
> +       iph =3D (struct iphdr *)(eth + 1);
> +       if (iph + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (iph->protocol !=3D IPPROTO_UDP)
> +               return TC_ACT_OK;
> +
> +       udp =3D (struct udphdr *)(iph + 1);
> +       if (udp + 1 > data_end)
> +               return TC_ACT_OK;
> +
> +       if (bpf_ntohs(udp->dest) !=3D udp_test_port)
> +               return TC_ACT_OK;

You don't need to worry about other program sending UDP
packets in this netns created by unshare().


> +
> +       udp_intercepted =3D true;
> +
> +       tuple.ipv4.saddr =3D iph->saddr;
> +       tuple.ipv4.daddr =3D iph->daddr;
> +       tuple.ipv4.sport =3D udp->source;
> +       tuple.ipv4.dport =3D bpf_htons(tcp_listener_port);

and you can simply reuse dport here too.


> +
> +       skc =3D bpf_skc_lookup_tcp(skb, &tuple, sizeof(tuple.ipv4), -1, 0=
);
> +       if (!skc)
> +               return TC_ACT_OK;
> +
> +       if (skc->state !=3D TCP_LISTEN) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       sk =3D (struct sock *)bpf_skc_to_tcp_sock(skc);
> +       if (!sk) {
> +               bpf_sk_release(skc);
> +               return TC_ACT_OK;
> +       }
> +
> +       attrs.mss =3D 1460;
> +       attrs.wscale_ok =3D 1;
> +       attrs.snd_wscale =3D 7;
> +       attrs.rcv_wscale =3D 7;
> +       attrs.sack_ok =3D 1;
> +
> +       /* Call bpf_sk_assign_tcp_reqsk on a UDP skb. */
> +       assign_ret =3D bpf_sk_assign_tcp_reqsk(skb, sk, &attrs, sizeof(at=
trs));
> +
> +       bpf_sk_release(skc);
> +
> +       /* Let the packet continue into the kernel */
> +       return TC_ACT_OK;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

