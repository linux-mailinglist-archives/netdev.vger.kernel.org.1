Return-Path: <netdev+bounces-291469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPevLjG2FGpbPgcAu9opvQ
	(envelope-from <netdev+bounces-291469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:50:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC55CEC22
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFC323007346
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B33955F4;
	Mon, 25 May 2026 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="tHnPJq4N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004E385D62
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779742000; cv=none; b=u99BfZP7ju11VDm7UUc5WdH+ohbGq8GQJ9y3ZF1ZKMjoe+QAzoXLJh9fq07r48K/foanJQ23JxyuAZTlajAoCR7QD9lunRDrAwaChSM3sqCR5g1+RbSdzYVvOpM+nr8G0jG9P1wI52guCZSstOmdWxp5P5xAUTyD6DkEYZImIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779742000; c=relaxed/simple;
	bh=LWQjmkUIZAGaQ5nHbnV06UZfCBPRFmb530IuVidr4Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwdw/mdUbrvYrub58hJY+XKYiq5qDnIJ3fxgYn1ylOSm4LR4SSLcnjyWo7lB9DwQ0ohR5aUVsXq5YuZNg8+IgLA9pGwWOBWGNezedKd4PWYjLRdwrT2nyZn6OZz9BbSt4khv7XltSlw3GPx1sVfkjltgxkt88VZfJzSbJaBv5Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=tHnPJq4N; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gPSC91wgDzW3m;
	Mon, 25 May 2026 22:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779740933;
	bh=HpQXEN6tusTN7MN/f+6t2ai9RBkMng9ANiaZvvqfw10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHnPJq4NfFBy7Vvq5SoSgpwKqaHcRTUL7uHBsNV7E6CN644UoxehU0wh14Iwh1D2P
	 NiYgWJAPmAQhqsih/hLbr7jTO2dOyfsA+d/1Skgg5mnbIdZj9aFuP+t6Ll+1n3+B9O
	 61gAbJKeAA37aaUQrchA/2Q9trFSY8GwaSrq5QcM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gPSC81mHCzs7m;
	Mon, 25 May 2026 22:28:52 +0200 (CEST)
Date: Mon, 25 May 2026 22:28:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/7] landlock: Add UDP access control support
Message-ID: <20260525.aeng6Xeula5o@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502124306.3975990-1-matthieu@buffet.re>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	TAGGED_FROM(0.00)[bounces-291469-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 27DC55CEC22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

FYI, I pushed this patch series in -next (except the doc patch which
conflict).

Also, some interesting (and some other not relevant) findings here:
https://sashiko.dev/#/patchset/20260502124306.3975990-1-matthieu%40buffet.re

On Sat, May 02, 2026 at 02:42:59PM +0200, Matthieu Buffet wrote:
> Hi,
> 
> This is V4 of UDP access control in Landlock. Thanks to the round of
> review of v3, access rights have changed to something that seems easier
> to use and understand. It adds only two access rights, to restrict
> configuring local and remote addresses on UDP sockets. The one that
> restricts setting a remote address also controls sending datagrams to
> explicit remote addresses -ignoring any remote address preset on the
> socket-. The one that restricts binding to a local port also applies
> when the kernel auto-binds an ephemeral port.
> v1:
> Link: https://lore.kernel.org/all/20240916122230.114800-1-matthieu@buffet.re/
> v2:
> Link: https://lore.kernel.org/all/20241214184540.3835222-1-matthieu@buffet.re/
> v3:
> Link: https://lore.kernel.org/all/20251212163704.142301-1-matthieu@buffet.re/
> 
> The limitation around allowing a process to send but not receive is
> still there, and could warrant another patch if there is a real user
> need.
> I'm just not super happy about the clarity of logs generated for denied
> autobinds ("domain=xxxxxx blockers=net.bind_udp"), due to the fact that
> addresses and ports are currently only logged if they are non-0. A later
> (coordinated LSM-wide) patch could improve readability by replacing != 0
> checks with new booleans in struct lsm_network_audit. I'm also not
> exactly happy with the integration in existing TCP selftests, but
> refactoring them has already been discussed earlier.
> 
> Changes v1->v2
> ==============
> - recvmsg hook is gone and sendmsg hook doesn't apply when sending to a
>   remote address pre-set on socket, to improve performance
> - don't add a get_addr_port() helper function, which required a weird
>   "am I in IPv4 or IPv6 context"
> - reorder hook prologue for consistency: check domain, then type and
>   family
> 
> Changes v2->v3
> ==============
> - removed support for sending datagrams with explicit destination
>   address of family AF_UNSPEC, which allowed to bypass restrictions with
>   a race condition
> - rebased on linux-mic/next => add support for auditing
> - fixed mistake in selftests when using unspec_srv variables, which were
>   implicitly of type SOCK_STREAM and did not actually test UDP code
> - add tests for IPPROTO_IP
> - improved docs, split off TCP-related refactoring
> 
> Changes v3->v4
> ==============
> - merge LANDLOCK_ACCESS_NET_CONNECT_UDP and
>   LANDLOCK_ACCESS_NET_SENDTO_UDP into
>   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP (everything that might set the
>   destination of a datagram)
> - make LANDLOCK_ACCESS_NET_BIND_UDP apply when kernel is about to
>   auto-bind an ephemeral port for the caller. Block it if policy would
>   not allow an explicit call to bind(0)
> - only deny sending AF_UNSPEC datagrams on IPv6 sockets, where there is
>   a risk of the address family changing midway
> 
> Patch is based on https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> 3457a5ccacd3 ("landlock: Document fallocate(2) as another truncation corner case")
> All lines added are covered with selftests, except the "default: return
> 0" in current_check_autobind_udp_socket() which is not currently
> reachable (net.c goes from 92.9%->94.6% line coverage).
> 
> Let me know what you think!
> 
> Closes: https://github.com/landlock-lsm/linux/issues/10
> 
> Matthieu Buffet (7):
>   landlock: Add UDP bind() access control
>   landlock: Add UDP connect() access control
>   landlock: Add UDP send access control
>   selftests/landlock: Add UDP bind/connect tests
>   selftests/landlock: Add tests for sendmsg()
>   samples/landlock: Add sandboxer UDP access control
>   landlock: Add documentation for UDP support
> 
>  Documentation/userspace-api/landlock.rst     |   89 +-
>  include/uapi/linux/landlock.h                |   35 +-
>  samples/landlock/sandboxer.c                 |   40 +-
>  security/landlock/audit.c                    |    3 +
>  security/landlock/limits.h                   |    2 +-
>  security/landlock/net.c                      |  161 ++-
>  security/landlock/syscalls.c                 |    2 +-
>  tools/testing/selftests/landlock/base_test.c |    4 +-
>  tools/testing/selftests/landlock/net_test.c  | 1146 ++++++++++++++++--
>  9 files changed, 1341 insertions(+), 141 deletions(-)
> 
> 
> base-commit: 3457a5ccacd34fdd5ebd3a4745e721b5a1239690
> -- 
> 2.39.5
> 
> 

