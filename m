Return-Path: <netdev+bounces-282985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBAJEhLA82mw6gEAu9opvQ
	(envelope-from <netdev+bounces-282985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC294A7E7E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38F413061DC4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57684376BD6;
	Thu, 30 Apr 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icZoEP0e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A83A3830
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581178; cv=pass; b=K5kTSs2HZo/ICVZ1JuCJbx9pJev+Svy5WkYhs+KxqMPMa3VUF5joj+XPDDBJJyQaO5JbRwwikoJqUP0hdARaflX4Sn4n+uis1qDTGsjMpjk61AI8ia5+efvGg+rH1XpGiS5pU6HqtmeB/whllBZoXQ8KOtyAEtB3rwqG8SYzqkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581178; c=relaxed/simple;
	bh=U2eH8NGTZAa0spz3Gpw8B0ZcuVJWHa8CNLda7oex5Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ekq0vSw2bdpByOsqytXOp1pE9yBhi1Ocr3hOi55RjKwOC+qdNJM6IKKHrsS99RAgg9sgUfj/+URWU9Td0R6B+rMMp1iXMLq8dpybkJdkNFKwixcorilpNAH6qkTkV8C/+bsZy4n1lmZZIasxJJAQzHcJT0hNOkUW/kLZU1Gd3gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icZoEP0e; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12dca45ca21so1831526c88.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777581176; cv=none;
        d=google.com; s=arc-20240605;
        b=XOY879g3cX9faEravujy1m3VSl0xKdsiYxD13VGyrXgEMWQuAslaSZRhUsyALK37Rb
         VRPx9dCm5E3Y95Wh+106guovJ3Z6Qy4MBDsSVhzG3yERF3NH0X4OWcs16tCIjCmafdvk
         BxRtvR0OXCg6uh+6eXJLXIpo3ejYzo7dSz82SPQ8IHZR9b3NkMOGgY7jXTAGd5SedUdG
         qPB7yQxQXOMJrMM3p4824O+ZrKoYFrLnFkotOFpWs9Ljd7+oasKNKVPvNb7ptR+sYdQN
         Lztu5HfUAFPx8qqp3HtyFLJDQCZ/o1gbVpFU9bobBXt08r5OjyOo4mG/zgQd7iv1F80Z
         NY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        fh=AGVKekq6vkSql6ETFDc+MFhi7eEQLmZOyjHq94+f1EU=;
        b=PG8r5fNLQhBI2r1mTtXJkg69mQQplCrFRmkoYa+AlVirj8lWi346RbI849KRiCvLx+
         0sfyEwWBjtGQobDu6wucMPdNkrWjGG8EFC30nnQ0hsRBG8UlEFABXlnDyVxH6Vmmgdlz
         PQgTx/XCGvZ9x4JumDy+2bKAifVVBYNyPuybZiCy0ToTB71AV3PfZDEiL3ZYSQNqE3Mq
         5fNzC+2mF2j+MCpNVw7A15w/vgRfU1qJ6SmV9zRWePv95DMITFpYXb+9/XcOHe6e/+lr
         96duCnJ8/Yyao2eAAoNtLgaB5FQwAphhugEsbaGZMzEBwKNSKURITq//18vxNUV3rcjp
         QZGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777581176; x=1778185976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        b=icZoEP0etWqUV5+RIHho1Peu9vOEoiezTz+D8YB0T/YQL1PAim0nF54pPOm2jNqGbI
         9kCvMDq2hJOB85t+TjOTzw4zzHKcXIlB3ZsWlKZfalJ/hyA9UFHWX1Q0+Et4aA+rXNOZ
         RqIQHv273qs1xSxTpn+uX4idOUHuouj8apeYXtLIYVYDnKdKUXvtKuMZkcskhDKil0+3
         vzH/dqedaxvlTX4knBKaP/12HmGA4XdLWIwiIPBAvrUv1XISk+jgazuMIeRlgvNp/Pno
         hNGkQpi/7ej157c7NX97ImsWviAdFjXG6MtW2A0N7XvEYUYgZyvxdy/a1tPsM26W6sf9
         3jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777581176; x=1778185976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMxaUy4qZ0yhVhil4Cjh0E5+hmuhmKfd+HYIaVWBDiE=;
        b=a1tbVO5MevziGKJqsIiFOTcYYFr/0XA9bY0+uHMMbG2GKlclrNLB/br/5YCIoH+qo4
         WzjC8dUGKviHA73gvPa9JDEpF5QNd+1VLzGXkdXtqub58/IQJa2O5spoagUbAzeyJfl6
         obZMVqRmReIA+QLNn1xQWmCOGvLIfEBHGMLBUq/W3WBLYhKJ3P0dq+Xs0f1zqTzVU5gr
         ddDpDDfMgWxpHuFedbdE04G8b9opmWAPxJkKTPmfR58/ZdHjXeRd+FuAxc4P7aeUPSyW
         bi0DvL5yY22UnV/fVfViJNIUXG7eSdUmDXIk2xtTs3aE5J7GPuld+vdHbIAJeAr/IYlA
         4PYw==
X-Forwarded-Encrypted: i=1; AFNElJ9oTbAYISSoKMeHyp1liOpSSBaPdoAqN8b6/VVwJOPeQe0kGpQv3B9U0HoKF+szyTAAswt6hrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZaWOMlp30L9ZlYCUElU1rua3fail5fvbDnQe0yB4F21Ur6/c
	FeSEGZ8Agu+ErSkQUNIEe5izTU6MLsv7dVL+WjDj6DtbSj3Y5/rWBOxk3o6vNZ1g69o7bdRqd9I
	i1nIRctz8BRrE3ZZmzVt6/EMnBWNtvuzvmqyHl8Rp
X-Gm-Gg: AeBDieuBqNbIhkzsAYsp5CNj86bKHCGeHO6LLmwORUc2ShH53I5pD41kSZ62XmZWikB
	eJO2/J4DbnEG4wrrEnS+od04F5fCyVTcxW3OjVT1xenPNFvdQ7XgR0M5ueaDvZuGVIngexqZ6gg
	t7NGwB0UUR3q+qhCSc2czv6B1HfUwm7puRofrOmHuE54VOYZK5u2TSO08H5OGjAM0la/fEDuMmQ
	hDjPs4KX+JwpwwS+WUYZbuixmZt8LM+8C8KTgYVCVRpoX5Z3A3+d43HlWcl1zSZl3/pD0+g2v0N
	ziCFHTfbkzeXIltLF8dtjW7n0GWxBJTSSPsBMHaiMOBwOK40FwfKu6UuWEw91K4KiZsLNKs+7tL
	RMU9rZcgMSfosOHUiN0hcHiWnxXSdqBbaa+2PC24yDOc2QeTou2fOokTPvp5iwbEephQg1SsHDN
	OoImPRaEcn
X-Received: by 2002:a05:7022:427:b0:12c:8e7f:1b30 with SMTP id
 a92af1059eb24-12deac42292mr2220710c88.2.1777581175300; Thu, 30 Apr 2026
 13:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430184405.1227386-1-kuniyu@google.com> <20260430184405.1227386-3-kuniyu@google.com>
In-Reply-To: <20260430184405.1227386-3-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 30 Apr 2026 13:32:44 -0700
X-Gm-Features: AVHnY4Ls7u6p0o5JMcAnAHJzpiAZfoiB3CE6dVbmTrXjuY0KiwPbdq7_p-En4PA
Message-ID: <CAAVpQUC83MxhfV-sreAPvfPJoqW=G20CPCPdRaQ6hvMt_khFtw@mail.gmail.com>
Subject: Re: [PATCH v1 bpf 2/2] selftest: bpf: Add test for bpf_tcp_sock() and
 RAW socket.
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9AC294A7E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,google.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 11:44=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Let's extend sockopt_sk.c to cover bpf_tcp_sock() for the
> wrong socket type.
>
> Before:
>   # ./test_progs -t sockopt_sk
>   [  151.948613] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [  151.951376] BUG: KASAN: slab-out-of-bounds in sol_tcp_sockopt+0xc7/0=
x8e0
>   [  151.954159] Read of size 8 at addr ffff88801083d760 by task test_pro=
gs/1259
>   ...
>   run_test:FAIL:getsetsockopt unexpected error: -1 (errno 22)
>   #427     sockopt_sk:FAIL
>
> After:
>   #427     sockopt_sk:OK
>
> While at it, missing free() is fixed up.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  .../selftests/bpf/prog_tests/sockopt_sk.c       | 17 ++++++++++++++++-
>  tools/testing/selftests/bpf/progs/sockopt_sk.c  | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/=
testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 53637431ec5d..87e771c8991f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -190,7 +190,7 @@ static int getsetsockopt(void)
>         fd =3D socket(AF_NETLINK, SOCK_RAW, 0);
>         if (fd < 0) {
>                 log_err("Failed to create AF_NETLINK socket");
> -               return -1;
> +               goto err;
>         }
>
>         buf.u32 =3D 1;
> @@ -211,6 +211,21 @@ static int getsetsockopt(void)
>         }
>         ASSERT_EQ(optlen, 8, "Unexpected NETLINK_LIST_MEMBERSHIPS value")=
;
>
> +       /* Trick bpf_tcp_sock() with IPPROTO_TCP */
> +       close(fd);
> +       fd =3D socket(AF_INET, SOCK_RAW, IPPROTO_TCP);
> +       if (fd < 0) {
> +               log_err("Failed to create RAW socket");
> +               goto err;
> +       }
> +
> +       optlen =3D 60;
> +       err =3D setsockopt(fd, SOL_TCP, TCP_SAVED_SYN, &buf, optlen);
> +       if (err) {

Ugh, I forgot to commit s/err/!err/ change.. :/

pw-bot: cr

