Return-Path: <netdev+bounces-279439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KkxNAnU4mm++wAAu9opvQ
	(envelope-from <netdev+bounces-279439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:44:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1B41F7CA
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B0F2304DEB5
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77C24728F;
	Sat, 18 Apr 2026 00:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsVBjDgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143C244675
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473091; cv=pass; b=uv996+dtHcLy+lolzLXD2FHzOg1OZhJcQ42JLYAZGiBzd8cjBlz8uWqf3oOSFLPodtc6E8SCKelleuv9aV9WUz9uf808jShlCtUXl0zPmVU89lBUQJhY0gxQNkfOzioh0guDe4KBP/3Sqyys/hZXoqVvIUt3bxNmbtSU+l7fVdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473091; c=relaxed/simple;
	bh=QtkZKVzlWbC0y57YLALEats22IogWAhXWdiSPYN8m1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaWaNEZtey9aZaQNh2t7w2iglO4sP0BREwyOgFzIUg/srI2GnuZYvNpC33BIBqRXYw87QfS4zrxU9oEwUvmEyTv5qMRrVS5IvGmRzEXQgfcjwjwz5LrmXDQ6t57ed0fOMB6Qyh9O17oFNhACEuIn2nX3U35V4cUK5jcQ7PgncPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsVBjDgM; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c7212836bso2759462c88.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 17:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473090; cv=none;
        d=google.com; s=arc-20240605;
        b=fE0ugn3vBxr9t8kELn5EU0ABt8g5qZ/W5/ZTTe8tDeQAE9TTbGWsATN9FRsOXx0P+R
         AdbKVBfAF6Uf792xiQoRqUygANMx070Rr9prSIq7wl6rVm+lmz6TBn5J5rE1N+2JZnil
         6sqLL5CZC2NHxGNKNlqF7oUElBGfmRb6tvgThwtoiga2tm3yL9jf5Ag82dttV5iUvN9Q
         7EwxiRa2kBWoZiE+8ak/84WDYfglqol/17Cm9TdJcRGt7pEMdLJ15AharcMH/jlT1JFU
         ENB6JN/58Ixj7Ng5mVZjHH86fNE0oNBfeD2n6kkY+bJYo9vG+sY5d0vpDgo7Z/hSZsLl
         4VYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        fh=uivMYV1YCJiHoiqp8mU5ymvvwiFMbCvwnUBsN/Pz9AE=;
        b=ZIIwCNkeIYNJ191iVlCAFhmlJMGvkEJAXi/B1ULmCAMrA84MThM008reRHamc+J0nT
         TdqZnyC/hJ4A6khddu2sFNyqlPB4VAdQbWZxNHo9Fe5IKKPsU+xT37aQ3bA6IfUdVTi4
         +oDEPHeyGy/ESemnKTJ02NjGu8n8NU5bOgMRQcx0/kKKw9w+rUqU2s0MaADy4VQKrAs3
         EgpHrTdjG6vaNx1xJLjK9JdE+cRV/8pPJ/d8lNdhybrdelxkbBDQfCB/7lpR4Khil6E4
         yBmvDkIYyR2yRgqVSqXrFFksv1nPkwOnMiAsTuzpMUS+UwIGe4MYc7XrJLUK4BYGCIIf
         qjyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776473090; x=1777077890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        b=ZsVBjDgMJCim2fcT/ZFyFFHoAktdahXayPcmASCRkx9KieLmxVORaWnhxn1ojLSor3
         3A+JWYRbQrhnCFLr0lMACoxG3mcMfJYsGotUvNtdYNpgTSdMRJPfavDkrni4FnuKVq1I
         qZIZMlWV1HdYHULFz8G9923ez3pH1xPba8tnO9Z/uA2YlbjoDE6APHynhJftGqdoh8g7
         6LijC5nzvw4chaoDqSR+U27GgIBZnNaK6ot7tzjc8HERz4G0eB/u1MU9hf9SjPRjrfxx
         T+gY4h/f0W1ASlYLVtT1tqVbnmONqEYEqo/lzZdX4RJ7jILedplC3fTJ2UTIBljkdWEa
         5cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776473090; x=1777077890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0ywBDu1FJbk3C613F7iWgUPaLx2nZ37sXJ0DuoHjXk=;
        b=kmcjISn4swJQ9O04t108GU/umgK/ErYJqo+Z48sLnf3rMfuLbKboyrPT7tnFrxXpdj
         jDuUWz3ahAGg6uxt6TMMDIotJsNw1qaR1mo9tzNay5kjcWwpKG5T9v6mECdOEBtniTpY
         2TOBQjzFD+Tu1WJVc8CX8J4z8gYPcGCQUXuY2naPa/ZhafKUMdJGK9bV/K6/B5RH4FwD
         M2IuC3/eYwosnyVrzDT8+CPPOzrNm0z2YeM7pQzwqhJJzI4x2TwZswoBnqgr3pkvNUly
         RyG3yrKihWJU+hFzV2pwICKDHsTJytoKAqI5ioDDtHd+T1a+7+uPh6f8ld3Q+YuDL4Iq
         biQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LIWATw1WrvydVk9M0hYjuXt89KJTMVtAXMpkkxLoDR6RlRasNmYs6cnJyWLv/MIJjO992YdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQZqVtBZhZ/Xc6kdACseLHwNvSYFnXru1zmO7+SeEVDCueT8NN
	IpSRpyvpHQyxE7RJgRPGhFn74apuTA7xLeIFnzOd2n3jLsMGFQOVjP5J8lORx0zPno0jN70zOms
	K/R7oS1ArkgUNBdbBww2hvgkHEod80C/S1N8TTT0O
X-Gm-Gg: AeBDiev2MeDl7+HvrLl0VEyE0yXatW/Rj1PjDK9IHyaLBp1SfTT2/mDi7U+k9ipdL7D
	rLCH2oPRWM9lhdIW2U68ZAq/aNXK0jyDM0H0ai7+POtHDI9GIMovq/Rov5mB+sxfSPB2sBmlCUd
	1+NIA7mQQEdcmQ80GcqN3byOD1Va5IrwcW0UzSZ2jbhOjkf1KvuNKD6H7SnTDjYpolM03FnMBrX
	chcviJ10uhodHQuC8vUyqqbivx9Lk8sxYAcQHPCbobPXXNUDu7im4Ep2mg0i6xW7k3jJm3kb8xE
	x0oN6yNoLFvFZ/YLvAFEBsRJEEVWcmW556ksKMIV8dxwC3ArCeimN4x1FvW9ChK16HAJ+GArnSU
	s8pGiEFslagU3F8PzRQTCcAorVaDi3zMXrCjr55mNwiv9uXLW8DGeHgOvedjoFpjyDnIPNTLSYA
	==
X-Received: by 2002:a05:7022:eac8:b0:128:d386:4bbb with SMTP id
 a92af1059eb24-12c73f759d9mr2765683c88.13.1776473088895; Fri, 17 Apr 2026
 17:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
In-Reply-To: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 17 Apr 2026 17:44:37 -0700
X-Gm-Features: AQROBzBTrpaT_3MkHnlTRUTVuaFD829JUv0CkBtSfX3vhctL64YmC-K6VQWJpNA
Message-ID: <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279439-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 30F1B41F7CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aaron :)

Thanks for the report.

On Fri, Apr 17, 2026 at 5:20=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> =
wrote:
>
> Hi,
>
> We have identified a TCP memory leak issue on Amazon Linux with kernel ve=
rsions 5.15.168 through 6.18.20 that occurs when closing sockets with SO_LI=
NGER set to l_onoff=3D1, l_linger=3D0, on servers handling many persistent =
connections with full write buffers.
>
> Overview:
>
> The issue was discovered on a public-facing non-blocking TCP server that =
maintains many persistent connections and streams data to clients. When a c=
lient cannot read fast enough, the TCP write socket buffer on the server si=
de fills up and send() returns EAGAIN. At that point, the server applicatio=
n disconnects the slow client by setting SO_LINGER to l_onoff=3D1, l_linger=
=3D0 and calling close(). This is intended to immediately reset the connect=
ion and release all associated kernel resources. However, while the socket =
disappears from netstat and sockstat (TCP inuse drops), the write buffer me=
mory is not properly reclaimed. /proc/net/sockstat shows TCP mem pages accu=
mulating with no owning sockets, causing the leaked memory to grow past the=
 tcp_mem limits. Setting SO_LINGER to l_onoff=3D1, l_linger=3D1 instead doe=
s not leak. With l_linger=3D1, the connection goes through FIN_WAIT1 =E2=86=
=92 FIN_WAIT2 =E2=86=92 CLOSE (confirmed with BPF tcpstates), and all memor=
y is freed properly. With l_linger=3D0, the connection transitions directly=
 from ESTABLISHED =E2=86=92 CLOSE via RST, bypassing the FIN states entirel=
y.
>
> Reproducer:
> ```
> /* tcp_linger_memleak.c - SO_LINGER(0) TCP memory leak reproducer
>  *
>  * Build:  gcc -O2 -o tcp_linger_memleak tcp_linger_memleak.c
>  * Run:    sudo sysctl -w net.core.wmem_max=3D4194304
>  *         sudo sysctl -w net.ipv4.tcp_rmem=3D"4096 8192 16384"
>  *         ./tcp_linger_memleak
>  */
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <unistd.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <sys/socket.h>
> #include <sys/wait.h>
> #include <netinet/in.h>
>
> #define NUM_CONNS 5000
> #define PORT      6666
>
> static void print_mem(const char *label) {
>     FILE *f;
>     char line[256];
>     f =3D fopen("/proc/meminfo", "r");
>     while (fgets(line, sizeof(line), f))
>         if (strncmp(line, "MemAvailable:", 13) =3D=3D 0)
>             printf("%s: %s", label, line);
>     fclose(f);
>     f =3D fopen("/proc/net/sockstat", "r");
>     while (fgets(line, sizeof(line), f))
>         if (strncmp(line, "TCP:", 4) =3D=3D 0)
>             printf("%s: %s", label, line);
>     fclose(f);
> }
>
> int main(void) {
>     struct sockaddr_in addr =3D {
>         .sin_family =3D AF_INET,
>         .sin_port =3D htons(PORT),
>         .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK)
>     };
>     int opt =3D 1;
>     signal(SIGPIPE, SIG_IGN);
>
>     int lsn =3D socket(AF_INET, SOCK_STREAM, 0);
>     setsockopt(lsn, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
>     bind(lsn, (struct sockaddr *)&addr, sizeof(addr));
>     listen(lsn, NUM_CONNS);
>
>     /* Fork client: connect N times, never read */
>     pid_t child =3D fork();
>     if (child =3D=3D 0) {
>         int fds[NUM_CONNS];
>         for (int i =3D 0; i < NUM_CONNS; i++) {
>             fds[i] =3D socket(AF_INET, SOCK_STREAM, 0);
>             connect(fds[i], (struct sockaddr *)&addr, sizeof(addr));
>         }
>         pause(); /* sit forever, never read */
>         _exit(0);
>     }
>
>     /* Accept all connections */
>     int clients[NUM_CONNS];
>     for (int i =3D 0; i < NUM_CONNS; i++)
>         clients[i] =3D accept(lsn, NULL, NULL);
>
>     /* Freeze client so it stops reading */
>     kill(child, SIGSTOP);
>     printf("=3D=3D=3D %d connections established, client frozen =3D=3D=3D=
\n", NUM_CONNS);
>     print_mem("BEFORE");
>
>     /* Fill buffers and close with SO_LINGER(1,0) */
>     char buf[2048];
>     memset(buf, 'A', sizeof(buf));
>     for (int i =3D 0; i < NUM_CONNS; i++) {
>         int flags =3D fcntl(clients[i], F_GETFL, 0);
>         fcntl(clients[i], F_SETFL, flags | O_NONBLOCK);
>         while (send(clients[i], buf, sizeof(buf), MSG_NOSIGNAL) > 0);
>         struct linger lg =3D { .l_onoff =3D 1, .l_linger =3D 0 };
>         setsockopt(clients[i], SOL_SOCKET, SO_LINGER, &lg, sizeof(lg));
>         close(clients[i]);
>     }
>
>     sleep(2);
>     printf("\n=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D\=
n");
>     print_mem("AFTER");
>     kill(child, SIGKILL);
>     waitpid(child, NULL, 0);
>     close(lsn);
>     return 0;
> }
> ```
> Output (Tested on 6.18.20):
> ```
> =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> BEFORE: MemAvailable:   95491288 kB
> BEFORE: TCP: inuse 10005 orphan 0 tw 5 alloc 10006 mem 0
>
> =3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
> AFTER: MemAvailable:   95321800 kB
> AFTER: TCP: inuse 5 orphan 0 tw 5 alloc 5006 mem 8300
> ```

Unfortunately, it dies immediately on my end.

=3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
Segmentation fault         (core dumped) ./linux/tcp_linger


Did you see actual memory leak with kmemleak or is it
just the tcp_mem counter that is really leaked ?

# echo clear > /sys/kernel/debug/kmemleak
~ run repro ~
# echo scan > /sys/kernel/debug/kmemleak

