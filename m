Return-Path: <netdev+bounces-283246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGDoHBvg9GkoFgIAu9opvQ
	(envelope-from <netdev+bounces-283246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C73974AE7B0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6EA3009B1F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 17:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C6B3290BD;
	Fri,  1 May 2026 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoO5Pqnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69898329C66
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655832; cv=none; b=YmtYGSLHii704P5lCvRV3FEO6Tc6P86I4vP5KjnZ2zQwTt7LUChxxv/QqDhkormWsi6oC3JUulbMGeHgcWL8U5DSRgdGO7TagYfSoUbtIj2OiXrFa7zfd+g4FxvtUKDTtc4FENb4ZexwISRHJynjoGGDxSe+sZWZcC2//+rkzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655832; c=relaxed/simple;
	bh=xwsp5iLrZTea6MovIEVmsFdqYQsIpNreqjgakR/5M2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8BoPGo+M+R4RMAoBwDNeYqF1mVBjYPSwSxQ/kYgWcc3igBqJCmAfl6kQTH0UkUmCJwIsb4EteAfcrTshiuqqpJety4cicdAtZpUdKhsWsYLEtLXhukYk+UGfifNPsx/EeWXw8DZ+0oisHe1A4vqVTq+fxUoXW25AAW4RyBPEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoO5Pqnb; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so1201420e0c.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777655828; x=1778260628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DJodchoUfkckB4s8xFgqZ8OCBPEaMXgDR5WFvqCUTds=;
        b=CoO5Pqnbdrmdsc+fJisfVD74jwkleQR/noytmtEjsK61KunABSmswchAYhT4z4qSAH
         yzrsQD/uzOlWh7SApFIHTKC+5GWfAJTFhdjwm5O3rxnNOoF8SKHqmAjT0LlrNS4pO1CO
         Pdn4y2aV00WoJfoEnRIkTHzsPMjChwjE14MhsY+965vMUTymygJTd84JDsMxYGqC7Vwn
         H1v5SxfH9xdLQ2DZ/87XtPI3X3ZDYFuUloXOoj1w0aWCBTC4GyE+Kr78dwS7mTE0Qz1R
         2LJnXgnN9kkRfimpHI2bI2a2MNYQd9MPQEPlBsnkoSbG55IvzOmhYQnfC/ZWV3/ZB5OA
         3LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655828; x=1778260628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJodchoUfkckB4s8xFgqZ8OCBPEaMXgDR5WFvqCUTds=;
        b=HKCWGVwPsT++rkK4MPQHxc3mHKtIiulJAcwNp7sKyept2qAk0sN5LmnIsNS/Je1wjN
         eHuLOhbThy2kZ3IPF+ZcCKJUy51xGHiMzIcGqr4EMr7ZagFDKYJahHUGTOi1vdHgZWbu
         lW3kg910qpdSYRKJM+f3EW82PYszYT+xM6JC9nvhygksoC6dnrva6q0TI5tZwHe+aW3L
         S46KLOVhHMiZDAhDNNtW4JGxzudM+EDXKNysoes+ZySo+ZzbH+A+V9VSg5/JM9gnmlU7
         RShzeWZJfILKKwT8u8kttGZ+j0nM7dfksKbGog1fcPqJmO16J1Xl7jaM59mdR0zz1Mj+
         oiiA==
X-Forwarded-Encrypted: i=1; AFNElJ+zseJP75FLvjUvhbOcihBQ/0IX/xH3GMjIf22SxHFXtaDXd+tIJ7R+aNRjgnG1zj9krxJP2Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUWqtklYPFFFTVn9o+VaSk3g+PorsqTknQHJgraH1/mMe5CJm
	gZGv0OIwlIto6TbyyTZvPmOmoX8uxWQhvnPKOWSJGL5wsATFs6PSZAgp
X-Gm-Gg: AeBDiesJODtpYfobGqiS2ZPg5gl5zxHlFnZ8BE1m5g5H3u9TSan48zNdSE7TgRD7CAv
	1rhzbBewTqsFEG8IqMFQLqy2o/EBCS+1UAnLssYXY7QmIs7mL8JCUoH4VFaKgJgppkiGLxbWDXo
	nv8IJRHVDFcwxeQDul01hY/jh7fw4RgdHDwyp1YJMfY+n4ekSV7VdZuaVomjtGNyCXTR1B3PSRW
	Y5FdHiM0tN1ZEd46a1wqJPREBOsnLbq+V7dbCNxlph2U9WcVYr+iBnXo0W8MR85SA3Wpb/zcxX9
	acwXkfuZON5oRkfXb6In3ICSXqn8B7j6T7iGffMNHg6/vu7NXmQNXWnEQ+eOBdjrKD0dI4FYf0J
	3D0MUPnV8IV9e7JGugX+5//t5XfgfqsgBP0jxVan4145Q2YQjAf8GTC11tYNmgrl6Z+WyoqIzUV
	teMywCSNZw1wXiUM1oZwXe05yB76YVPDDzu/AzeGcv5tgrahlVLoyVn4S9mw==
X-Received: by 2002:a05:6122:d27:b0:56d:aa1f:e48a with SMTP id 71dfb90a1353d-5750c701da6mr187767e0c.12.1777655828173;
        Fri, 01 May 2026 10:17:08 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:45::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d953sm33669716d6.3.2026.05.01.10.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:17:07 -0700 (PDT)
Date: Fri, 1 May 2026 10:17:03 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 3/3] net: selftests: add getsockopt_iter
 regression tests
Message-ID: <afTgD99BJQxR8YDc@devvm29614.prn0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-3-810ce23ea70e@debian.org>
X-Rspamd-Queue-Id: C73974AE7B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.linux.dev,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,devvm29614.prn0.facebook.com:mid]

On Fri, May 01, 2026 at 08:52:53AM -0700, Breno Leitao wrote:
> Add a single kselftest covering the proto_ops getsockopt_iter
> conversions for AF_NETLINK and AF_VSOCK, using one fixture per protocol:
> 
> netlink:
> 
> NETLINK_PKTINFO covers the flag-style int path (exact size, oversize
> clamp, undersize -EINVAL); NETLINK_LIST_MEMBERSHIPS covers the
> size-discovery path that always reports the required buffer length back
> via optlen, even when the user buffer is too small to receive any group
> bits.
> 
> vsock:
> SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path (exact size, oversize
> clamp, undersize -EINVAL).
> 
> Each fixture also exercises an unknown optname and a bogus level so
> the returned-length / errno semantics preserved by the sockopt_t
> conversion are pinned down.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

This all looks good to me. My only thought was
SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW/OLD would be a nice add-on for testing
greater than u64, but probably overkill since you already have
NETLINK_LIST_MEMBERSHIPS.

Code all looks reasonable.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/getsockopt_iter.c | 213 ++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index a275ed5840265..baa30287cf222 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -176,6 +176,7 @@ TEST_GEN_PROGS := \
>  	bind_timewait \
>  	bind_wildcard \
>  	epoll_busy_poll \
> +	getsockopt_iter \
>  	icmp_rfc4884 \
>  	ipv6_fragmentation \
>  	proc_net_pktgen \
> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
> new file mode 100644
> index 0000000000000..179f9e84926fd
> --- /dev/null
> +++ b/tools/testing/selftests/net/getsockopt_iter.c
> @@ -0,0 +1,213 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Quick test for getsockopt{_iter} tests.
> + *
> + * Each fixture targets one converted protocol and pins down the
> + * returned-length / errno semantics across buffer-size variations,
> + * an unknown optname and a bogus level.
> + *
> + * - netlink: NETLINK_PKTINFO covers the flag-style int path; the
> + *   NETLINK_LIST_MEMBERSHIPS cases cover the size-discovery path
> + *   that always reports the required buffer length back via optlen,
> + *   even when the user buffer is too small to receive any group bits.
> + * - vsock:   SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path.
> + *
> + * Author: Breno Leitao <leitao@debian.org>
> + */
> +
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/vm_sockets.h>
> +#include <sys/socket.h>
> +#include "kselftest_harness.h"
> +
> +#ifndef AF_VSOCK
> +#define AF_VSOCK 40
> +#endif
> +
> +/* ---------- netlink ---------- */
> +
> +FIXTURE(netlink)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(netlink)
> +{
> +	int group = RTNLGRP_LINK;
> +
> +	self->fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_NETLINK socket: %s", strerror(errno));
> +
> +	/* Joining a multicast group grows nlk->ngroups so the
> +	 * NETLINK_LIST_MEMBERSHIPS path has a non-zero size to report.
> +	 */
> +	if (setsockopt(self->fd, SOL_NETLINK, NETLINK_ADD_MEMBERSHIP,
> +		       &group, sizeof(group)) < 0)
> +		SKIP(return, "NETLINK_ADD_MEMBERSHIP: %s", strerror(errno));
> +}
> +
> +FIXTURE_TEARDOWN(netlink)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +}
> +
> +TEST_F(netlink, pktinfo_exact)
> +{
> +	int val = -1;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				&val, &optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +	ASSERT_TRUE(val == 0 || val == 1);
> +}
> +
> +TEST_F(netlink, pktinfo_oversize_clamped)
> +{
> +	char buf[16] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				buf, &optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +}
> +
> +TEST_F(netlink, pktinfo_undersize)
> +{
> +	char buf[2] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, NETLINK_PKTINFO,
> +				 buf, &optlen));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
> +TEST_F(netlink, list_memberships_size_discovery)
> +{
> +	socklen_t optlen = 0;
> +	char dummy;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
> +				NETLINK_LIST_MEMBERSHIPS,
> +				&dummy, &optlen));
> +	ASSERT_GT(optlen, 0);
> +	ASSERT_EQ(0, optlen % sizeof(__u32));
> +}
> +
> +TEST_F(netlink, list_memberships_full_read)
> +{
> +	__u32 buf[64] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_NETLINK,
> +				NETLINK_LIST_MEMBERSHIPS,
> +				buf, &optlen));
> +	ASSERT_GT(optlen, 0);
> +	ASSERT_LE(optlen, sizeof(buf));
> +	ASSERT_EQ(0, optlen % sizeof(__u32));
> +}
> +
> +TEST_F(netlink, bad_level)
> +{
> +	int val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1, NETLINK_PKTINFO,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_F(netlink, bad_optname)
> +{
> +	int val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_NETLINK, 0x7fff,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +/* ---------- vsock ---------- */
> +
> +FIXTURE(vsock)
> +{
> +	int fd;
> +};
> +
> +FIXTURE_SETUP(vsock)
> +{
> +	self->fd = socket(AF_VSOCK, SOCK_STREAM, 0);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_VSOCK socket: %s", strerror(errno));
> +}
> +
> +FIXTURE_TEARDOWN(vsock)
> +{
> +	if (self->fd >= 0)
> +		close(self->fd);
> +}
> +
> +TEST_F(vsock, buffer_size_exact)
> +{
> +	uint64_t val = 0;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
> +				SO_VM_SOCKETS_BUFFER_SIZE,
> +				&val, &optlen));
> +	ASSERT_EQ(sizeof(uint64_t), optlen);
> +	ASSERT_GT(val, 0);
> +}
> +
> +TEST_F(vsock, buffer_size_oversize_clamped)
> +{
> +	char buf[16] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, AF_VSOCK,
> +				SO_VM_SOCKETS_BUFFER_SIZE,
> +				buf, &optlen));
> +	ASSERT_EQ(sizeof(uint64_t), optlen);
> +}
> +
> +TEST_F(vsock, buffer_size_undersize)
> +{
> +	char buf[4] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK,
> +				 SO_VM_SOCKETS_BUFFER_SIZE,
> +				 buf, &optlen));
> +	ASSERT_EQ(EINVAL, errno);
> +}
> +
> +TEST_F(vsock, bad_level)
> +{
> +	uint64_t val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_SOCKET + 1,
> +				 SO_VM_SOCKETS_BUFFER_SIZE,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_F(vsock, bad_optname)
> +{
> +	uint64_t val;
> +	socklen_t optlen = sizeof(val);
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, AF_VSOCK, 0x7fff,
> +				 &val, &optlen));
> +	ASSERT_EQ(ENOPROTOOPT, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> 
> -- 
> 2.52.0
> 

