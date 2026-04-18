Return-Path: <netdev+bounces-279443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCi1KB7Z4mnB/AAAu9opvQ
	(envelope-from <netdev+bounces-279443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE0A41F8E9
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 03:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26EB3031AC2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 01:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357A123EAB8;
	Sat, 18 Apr 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWmBFDe8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345D175A77
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474381; cv=pass; b=oXq3C0TGaqRZPJtDg5xw/GKBHulzaSt2HZ5HmHmhPGYEIOIPHOeitpbZwph2N36jna/66NxbP/sm93CTxE8D9OKcUy/kqZArsSQ3T9oTw4jes4759H2KVAc19UHpbJ7p5EXCesPngURpqAwphFe/uprrRwjXmetUeSfge+5cvqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474381; c=relaxed/simple;
	bh=MbJYuLV62yQM19c6dC9DtbHde8fn9mzXMYXm24tfU1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gcwl8gFaMNHOlTFUgf4DfOGK87wnGx+KyqfE0CB7jS8PSnQPGtZfo7JRPqbzrwYr1AQ92cWtphrFkzfTmqCES5OEzdRZGrTrDeQlUGkVxa9AZEMDHOmRR+c8diJNliRwkXwEWycWncAN8yJdpAq37hTq79FvyMaH0iNW6Vj/8/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWmBFDe8; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c637089ccso3022658c88.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 18:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776474379; cv=none;
        d=google.com; s=arc-20240605;
        b=dS8uq2z3/gFm34PaEWKgLpGPXUWfp+Kul5CHxtcTihp0V6jdH5BM2Xu4U/uPm9lC7y
         WXIpoSROBMvdA0mWmDLhVsol5MnohSlj2y20zimxIMHj9Ml6cwSpNv6er2TrgZv6853Z
         VbNYfxRtSpB1502sIKcaP0+KsOy26jfCGOVZiZ3eaZ/XVEmOKY+FKhpLjOJlJ2yRjnln
         uWCQYUQAZuR4SYPO4PDZj2hirvTDnE7Z2mzQDaPv7U6cEsT4iCdunlNMwuwLoL5ACQT1
         LfGoVCtkrlw+av8n6pllUSFmqtw26AiLeMvgFk8Qx0JfDAnUIzCzdFIXVwpEig3AH7DG
         V76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        fh=lkIwV34RzVSDHwGuOkYQUbcb5R3BgxSMO7poIeciMF4=;
        b=jryYR4AQiqXZGR1AVMVMU+8Yz4f6EA96Soo7iTK9ybd0j9owGb3JsapLSrQxrv9wHt
         cnD+v7m+ZK9A3rCQH6IyMRSWNPf2kGniG4HCuqjZ9RxEFKPdKhuNtx/3n8u7lYUDhzei
         syNoT82sXk+kwlEIGUShn08pVL2W30gDsG/cbZGucjE+LDzQUxZBc+8LzLxdXMjYq+Qi
         odVNC4/Nuly9QEdQPVoxht0VBtXJwk5q4b24Ynp2puU+rNoiOU7nViKviTp+BoqTFFlD
         KX/N+91DKD+51S80JzzcdDJXbM0aKAZMda4/+16UHmSzHlvT5b6nan0ApHDsnv1VfkVB
         tBSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776474379; x=1777079179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        b=bWmBFDe8TPAgdIkqnhrI2L2M9JUCB2U/YmtNDhyhDwB4nFZoCpf0maWtZCXLyl9NVZ
         72L8icwvTEAU/sDwRvnO+tW74FOStnw1tUaKUHk6ewJR3a7lLmpV/ywVmBixwZ7al6pA
         1rAyB8DuIEFGNyDbUzIZR6cRLOky+rFEVWd0OLQxgv5x0hOjA0DK/JekuL49oTvTMvry
         8PNgd1+mxGMuEPXbK9kIwfNvK15kl5cNCxiMk/Y/WAEgxJ+ask2TOT654mP6ny08uHBV
         ukqAY4zJY4mYLc4pAFo2n/5O/IgMJdIHvAT6ePB7Nf1IX3ZXm+WvWNZzbyaLlre1DOh1
         8pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776474379; x=1777079179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJtzeCKdAvR+EBp3Q9RY8pglCClr3YzbEiQaHvpvF0E=;
        b=i7EZczWLiWCSqFOYZpJITn6GhCyEJKTsn1XQbow2HpNlaDPBoLM5rizoE2GyuEmNAw
         5Ux2dQMk8vAmq3YsRaut2VgGWmlUGfvoBfyBtyQCSybV6l8qYPsgBzgWWMrOALFTkIBg
         PDlOEUke+u4n0xWFRBaDqd74xNSP8T/9fi9jg3mFIGw2kVEP3nvg/BnKkkcQTId+LRhn
         /o7vOEsp6sQ2I5eSI4UMbU8kT6OUPADJgRADuTHJWo649sGfsB8b31Yj9WK25UQz6gDu
         ay6VqAGXtVA6C3FFLWEXdH3hq4NH4/Sty2PoDCGiOY0/jyVFgGZO0XB4QtXdKQ7ffakj
         KjZA==
X-Forwarded-Encrypted: i=1; AFNElJ//FGKdnRD/GSxLSpYzyx9/qttKlc5pjCC73nI6vBsBPxZqAkZpVPx4FONhZA6k4RjGnZqkBXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylYhVlECiqH3RELraM7x+h/K2HdULoXIhbPq7HhM1EkczX/TjA
	vq98XbwaPSXei3Yo9cvOfM6pFqq3aqHBTJ1H349Sw5EXhap3lpmiN/0YAty+06vJJnIl5GzPzUZ
	d2KVptMVM5p0KV3uJtkTz6ULd3J6J5jis+l2ID4Fe
X-Gm-Gg: AeBDievEWZgg2NoI2MezfB3/Bn6+P7eaW1eH+BBHH6PKoumj+w4DJE8b8AKRerApfH7
	OFqbPKiPJ6dUnJ/pHewTD6D0nABqbbB1Dl+M4U9ZVO699KJ/8FI33Wk/TqMTDFhtcyk7r2BwasT
	yy0N87OEb7VLE3GrjFdWK/HJg3efTBo/lQxBdTmkTaiDs1czaRzSxKK8uP6auCWytHaAe7373td
	HdOV1We6yY7iQ8nz9tFzBRq3MwrdRPNLkskfKm96qp5Ic4a911Zg7LYT102ayK8PMKHCz2xyiQa
	ORYiP0OsAbKQ7LOmt4nCLkMtCnv39RNfeQaqHZPx8j27YOYNu9ITxzGxx+8dmjPctMoCJpok/C8
	osAbxyH2fsqwFMhwS/d2RfcIExjmUDm6tZG5B0DrF/+yBIJpdQwcvH7dxIMgz8DH8MJm2vvRAeA
	==
X-Received: by 2002:a05:7022:6085:b0:128:d7a7:5261 with SMTP id
 a92af1059eb24-12c73fa6408mr2590847c88.30.1776474378110; Fri, 17 Apr 2026
 18:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com> <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
In-Reply-To: <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 17 Apr 2026 18:06:06 -0700
X-Gm-Features: AQROBzAOzl4NDI37MDHb3Ki8sa2fZpf7yMu6HwGCVtU9lB0D-1xhB2T9BL_jaLE
Message-ID: <CAAVpQUDj13+MEz8HJTRyAcBYwUa6a2t7PNx_7qJRkjbihYk2Tg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-279443-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,74.125.82.49:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FE0A41F8E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 5:44=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Hi Aaron :)
>
> Thanks for the report.
>
> On Fri, Apr 17, 2026 at 5:20=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com=
> wrote:
> >
> > Hi,
> >
> > We have identified a TCP memory leak issue on Amazon Linux with kernel =
versions 5.15.168 through 6.18.20 that occurs when closing sockets with SO_=
LINGER set to l_onoff=3D1, l_linger=3D0, on servers handling many persisten=
t connections with full write buffers.
> >
> > Overview:
> >
> > The issue was discovered on a public-facing non-blocking TCP server tha=
t maintains many persistent connections and streams data to clients. When a=
 client cannot read fast enough, the TCP write socket buffer on the server =
side fills up and send() returns EAGAIN. At that point, the server applicat=
ion disconnects the slow client by setting SO_LINGER to l_onoff=3D1, l_ling=
er=3D0 and calling close(). This is intended to immediately reset the conne=
ction and release all associated kernel resources. However, while the socke=
t disappears from netstat and sockstat (TCP inuse drops), the write buffer =
memory is not properly reclaimed. /proc/net/sockstat shows TCP mem pages ac=
cumulating with no owning sockets, causing the leaked memory to grow past t=
he tcp_mem limits. Setting SO_LINGER to l_onoff=3D1, l_linger=3D1 instead d=
oes not leak. With l_linger=3D1, the connection goes through FIN_WAIT1 =E2=
=86=92 FIN_WAIT2 =E2=86=92 CLOSE (confirmed with BPF tcpstates), and all me=
mory is freed properly. With l_linger=3D0, the connection transitions direc=
tly from ESTABLISHED =E2=86=92 CLOSE via RST, bypassing the FIN states enti=
rely.
> >
> > Reproducer:
> > ```
> > /* tcp_linger_memleak.c - SO_LINGER(0) TCP memory leak reproducer
> >  *
> >  * Build:  gcc -O2 -o tcp_linger_memleak tcp_linger_memleak.c
> >  * Run:    sudo sysctl -w net.core.wmem_max=3D4194304
> >  *         sudo sysctl -w net.ipv4.tcp_rmem=3D"4096 8192 16384"
> >  *         ./tcp_linger_memleak
> >  */
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <unistd.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <signal.h>
> > #include <sys/socket.h>
> > #include <sys/wait.h>
> > #include <netinet/in.h>
> >
> > #define NUM_CONNS 5000
> > #define PORT      6666
> >
> > static void print_mem(const char *label) {
> >     FILE *f;
> >     char line[256];
> >     f =3D fopen("/proc/meminfo", "r");
> >     while (fgets(line, sizeof(line), f))
> >         if (strncmp(line, "MemAvailable:", 13) =3D=3D 0)
> >             printf("%s: %s", label, line);
> >     fclose(f);
> >     f =3D fopen("/proc/net/sockstat", "r");
> >     while (fgets(line, sizeof(line), f))
> >         if (strncmp(line, "TCP:", 4) =3D=3D 0)
> >             printf("%s: %s", label, line);
> >     fclose(f);
> > }
> >
> > int main(void) {
> >     struct sockaddr_in addr =3D {
> >         .sin_family =3D AF_INET,
> >         .sin_port =3D htons(PORT),
> >         .sin_addr.s_addr =3D htonl(INADDR_LOOPBACK)
> >     };
> >     int opt =3D 1;
> >     signal(SIGPIPE, SIG_IGN);
> >
> >     int lsn =3D socket(AF_INET, SOCK_STREAM, 0);
> >     setsockopt(lsn, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
> >     bind(lsn, (struct sockaddr *)&addr, sizeof(addr));
> >     listen(lsn, NUM_CONNS);
> >
> >     /* Fork client: connect N times, never read */
> >     pid_t child =3D fork();
> >     if (child =3D=3D 0) {
> >         int fds[NUM_CONNS];
> >         for (int i =3D 0; i < NUM_CONNS; i++) {
> >             fds[i] =3D socket(AF_INET, SOCK_STREAM, 0);
> >             connect(fds[i], (struct sockaddr *)&addr, sizeof(addr));
> >         }
> >         pause(); /* sit forever, never read */
> >         _exit(0);
> >     }
> >
> >     /* Accept all connections */
> >     int clients[NUM_CONNS];
> >     for (int i =3D 0; i < NUM_CONNS; i++)
> >         clients[i] =3D accept(lsn, NULL, NULL);
> >
> >     /* Freeze client so it stops reading */
> >     kill(child, SIGSTOP);
> >     printf("=3D=3D=3D %d connections established, client frozen =3D=3D=
=3D\n", NUM_CONNS);
> >     print_mem("BEFORE");
> >
> >     /* Fill buffers and close with SO_LINGER(1,0) */
> >     char buf[2048];
> >     memset(buf, 'A', sizeof(buf));
> >     for (int i =3D 0; i < NUM_CONNS; i++) {
> >         int flags =3D fcntl(clients[i], F_GETFL, 0);
> >         fcntl(clients[i], F_SETFL, flags | O_NONBLOCK);
> >         while (send(clients[i], buf, sizeof(buf), MSG_NOSIGNAL) > 0);
> >         struct linger lg =3D { .l_onoff =3D 1, .l_linger =3D 0 };
> >         setsockopt(clients[i], SOL_SOCKET, SO_LINGER, &lg, sizeof(lg));
> >         close(clients[i]);
> >     }
> >
> >     sleep(2);
> >     printf("\n=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=
=3D\n");
> >     print_mem("AFTER");
> >     kill(child, SIGKILL);
> >     waitpid(child, NULL, 0);
> >     close(lsn);
> >     return 0;
> > }
> > ```
> > Output (Tested on 6.18.20):
> > ```
> > =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> > BEFORE: MemAvailable:   95491288 kB
> > BEFORE: TCP: inuse 10005 orphan 0 tw 5 alloc 10006 mem 0
> >
> > =3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
> > AFTER: MemAvailable:   95321800 kB
> > AFTER: TCP: inuse 5 orphan 0 tw 5 alloc 5006 mem 8300
> > ```
>
> Unfortunately, it dies immediately on my end.
>
> =3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
> Segmentation fault         (core dumped) ./linux/tcp_linger

This was due to small ulimit -n and fopen() returned
NULL being passed to fgets().

But I don't see any leak of memory nor counter after
the repro.

Note that the tcp_mem counter could be cached in
per-cpu counters, see proto_memory_pcpu_drain() etc.

---8<---
[root@fedora ~]# unshare -n
[root@fedora ~]# ip link set lo up
[root@fedora ~]# echo clear > /sys/kernel/debug/kmemleak
[root@fedora ~]# ulimit -n 100000 && ./linux/tcp_linger
=3D=3D=3D 5000 connections established, client frozen =3D=3D=3D
BEFORE: MemAvailable:   54683048 kB
BEFORE: TCP: inuse 10001 orphan 0 tw 0 alloc 10008 mem 0
=3D=3D=3D All sockets closed with SO_LINGER(1,0) =3D=3D=3D
AFTER: MemAvailable:   54616304 kB
AFTER: TCP: inuse 1 orphan 0 tw 0 alloc 5008 mem 3842
[root@fedora ~]# cat /proc/net/sockstat
sockets: used 0
TCP: inuse 0 orphan 0 tw 0 alloc 7 mem 0
UDP: inuse 0 mem 0
RAW: inuse 0
FRAG: inuse 0 memory 0
[root@fedora ~]# cat /proc/meminfo | grep Available
MemAvailable:   54732456 kB
[root@fedora ~]# echo scan > /sys/kernel/debug/kmemleak
[root@fedora ~]#
---8<---

