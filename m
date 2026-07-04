Return-Path: <netdev+bounces-304685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f3EEAyOjSGq4sAAAu9opvQ
	(envelope-from <netdev+bounces-304685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 551F7706D05
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 08:07:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=byBM+RDc;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=8fc0NOUQ;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304685-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E9E301A924
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 06:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F4638D414;
	Sat,  4 Jul 2026 06:04:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787903064B2;
	Sat,  4 Jul 2026 06:04:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145042; cv=none; b=XxfJp8J7/I7CZ8/pmn5lZU97IpgPkfJSoKOElvXDPSd1jL1A3G3XgYUDrIR35dLx+CZQisEzA8z4ohwPk0K6O4b+7FRUXWNrDzLZzDKR8nZU8XtQJamBzQP0WsazlsV/coslp0o2zh3PVIuyATbeVjTONsjbgqKo8UBFUi17quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145042; c=relaxed/simple;
	bh=jIMGvQqsIvIyUCsNTGB+vuaIlrGlYDapnlkWplv0DVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Deba3RZrGOoaCLiaUNMZTnClHF0nstxe7+Em4vmaVtHsdc6Dw2fiJLNGUfg/njh8PNFr8f4BDZKUzpwVhvPzTTVI3ND+UXDkQTYSqYYOw1Bv1YLN1ajFiCCiySnOC7Jpn1PUEazINEQZvJaek4IQThFcN//0paMaGoKfF28PvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byBM+RDc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8fc0NOUQ; arc=none smtp.client-ip=193.142.43.55
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783145039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpfS25J8dv9TjWmef95+8RlZGNip6QMU6GFSfOmOoq8=;
	b=byBM+RDcZ2xkcau9XQkczUfq3+pZGm3Pfqey7HMu/GzJ6kO5Y7BHF6M4raL9W4hBhhQ4yF
	cSVNrMyMeFi699K62CwfoYSQ1mInkFFPBiwp01ZxUgPa99K5/jiE9Za8nAA14uaGY6sFR7
	El7BcvJC3aXlIK0/apV5Xs6jYkkljOfHEhhWugdiRdEYvATHxHE5bkt2pPuXqhZBOLyHGH
	xmhRoxqQRZx59cAqVSOk3ArRSawFsxk7fkSwEpdoBNzh+faf2XQ9pb3/6rVwzcS1w11lkY
	7sO4zNLTwo9i8hTD/WYkunhW7ZDIbdJX4/GfNxfoD9jdrN9E66oL3isI1Q9U+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783145039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SpfS25J8dv9TjWmef95+8RlZGNip6QMU6GFSfOmOoq8=;
	b=8fc0NOUQCgRXYPdMXlGSRmvZ/kH8U8FCpujnYHmtwirY66tx4b7MSlp+5RuTqWSL7kmmwH
	y/d7LS6BUiDd5XCw==
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: sashiko-reviews@lists.linux.dev, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
In-Reply-To: <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org> <87mrw8sjo3.fsf@yellow.woof>
 <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
Date: Sat, 04 Jul 2026 08:03:56 +0200
Message-ID: <87wlvbmgtv.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304685-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:sashiko-reviews@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 551F7706D05

Kuniyuki Iwashima <kuniyu@google.com> writes:
> your patch makes it much easier to abuse.
> UNIX_INFLIGHT_SANE_USER is usually much smaller than
> RLIMIT_NOFILE.
>
> unix_schedule_gc() in sendmsg() is to self-regulate malicious users,
> otherwise GC relies on unrelated AF_UNIX socket's close() and could
> be triggered too late since GC is system-wide.

About the abuse, the scenario where inflight sockets bypass
UNIX_INFLIGHT_SANE_USER and delay GC until an unrelated AF_UNIX socket
closes actually exists today.

For example, the following program creates far more than
UNIX_INFLIGHT_SANE_USER inflight sockets, which persists indefinitely
until another unrelated AF_UNIX close().

#include <sys/mount.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/wait.h>

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static int send_fd(int unix_fd, int fd)
{
        struct msghdr msgh;
        struct cmsghdr *cmsg;
        char buf[CMSG_SPACE(sizeof(fd))];

        memset(&msgh, 0, sizeof(msgh));

        memset(buf, 0, sizeof(buf));
        msgh.msg_control = buf;
        msgh.msg_controllen = sizeof(buf);

        cmsg = CMSG_FIRSTHDR(&msgh);
        cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
        cmsg->cmsg_level = SOL_SOCKET;
        cmsg->cmsg_type = SCM_RIGHTS;

        msgh.msg_controllen = cmsg->cmsg_len;

        memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
        return sendmsg(unix_fd, &msgh, 0);
}

int main(int argc, char *argv[])
{
	int fd[2];
	int i;

	for (int n = 0; n < 100; ++n) {
		if (socketpair(PF_UNIX, SOCK_SEQPACKET, 0, fd) == -1)
			goto out_error;

		for (i = 0; i < 100; ++i) {
			if (send_fd(fd[0], fd[0]) == -1)
				goto out_error;

			if (send_fd(fd[1], fd[1]) == -1)
				goto out_error;
		}
	}

	return 0;

out_error:
	fprintf(stderr, "error: %s\n", strerror(errno));
}

To address this properly, we can schedule the GC at task exit. I can
include that patch in my series, if that sounds good to you.

> Previously every sendmsg() had to wait for GC, and now it's only when
> there is a circular reference AND user has too many inflight sockets.
>
> Please fix the root cause; the former condition on your system.

Can you clarify what you mean by fixing the former condition on my
system. Do you mean ensuring that no application creates a circular
reference?

I am afraid we cannot rely on all users and applications to behave. We
do not want a buggy program or a malicious program to harm another
time-critical task.

Nam

