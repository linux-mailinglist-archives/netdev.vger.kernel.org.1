Return-Path: <netdev+bounces-249098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B4D13F67
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C60305E3E3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211C3644BB;
	Mon, 12 Jan 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Pcq+7xEk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8273644A4
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234814; cv=none; b=CyoHf8b/+BfSJT1GMeBnATOEuMk31Czu+ikhmcpRpH+Y8z8T6AW//m3f9c+rFeB1pdkt5GrYrGDcDMu/DrJE+yZSMTJXHjlRZSdVl9tpvSKP6TqDIJAqD/hGKBDBEkgCH9bSU+XgkA48KZm17tm9sxRaMYUqSciO/BKwXkA+Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234814; c=relaxed/simple;
	bh=1nBCITjqomWB9lUtyhFM4fajJwtdvdo71dDPZ6vyU+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2SObyW46gEBJIK9bar95uL3394On55l6IHFfdED8ReXGHCsjmbCNWoYdhVHRSgx/O7tDkn9R/GM2XJyjPn7lg1JMnHY5C8HGc3E9tUWpuWVg8v41anY5Mk14Fvg82gFpjCy851hUxCrNmZabOf0WUo9ZNFb2scdKB++aaD23Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Pcq+7xEk; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dqcjd2T3gzjrv;
	Mon, 12 Jan 2026 17:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1768234085;
	bh=fuGNBBmrV1aaR4mfqBEY752BSmb2lnimAb5XpRaYrrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pcq+7xEkzz8ORRTFZUA+HkwHYaf0f3sb4sKz3kod+D+bbNzuAkYf2+KhMGcZsi7EU
	 hFw+UNsLt7NF0TdHkiUpVv4c+MTIhZl97dmeJRKH8QcZr4mlpJ4dwDODuPyiKOIXiN
	 PpKC7k3BV+h9XTEmgCL/E0hRMsIpJ+cmiXrPofGI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dqcjb6Gvrzg7Z;
	Mon, 12 Jan 2026 17:08:03 +0100 (CET)
Date: Mon, 12 Jan 2026 17:08:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260112.Wufar9coosoo@digikod.net>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260110143300.71048-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sat, Jan 10, 2026 at 03:32:55PM +0100, Günther Noack wrote:
> Hello!
> 
> This patch set introduces a filesystem-based Landlock restriction
> mechanism for connecting to UNIX domain sockets (or addressing them
> with sendmsg(2)).  It introduces a file system access right for each
> type of UNIX domain socket:
> 
>  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM
>  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM
>  * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET
> 
> For the connection-oriented SOCK_STREAM and SOCK_SEQPACKET type
> sockets, the access right makes the connect(2) operation fail with
> EACCES, if denied.
> 
> SOCK_DGRAM-type UNIX sockets can be used both with connect(2), or by
> passing an explicit recipient address with every sendmsg(2)
> invocation.  In the latter case, the Landlock check is done when an
> explicit recipient address is passed to sendmsg(2) and can make
> sendmsg(2) return EACCES.  When UNIX datagram sockets are connected
> with connect(2), a fixed recipient address is associated with the
> socket and the check happens during connect(2) and may return EACCES.
> 
> ## Motivation
> 
> Currently, landlocked processes can connect() to named UNIX sockets
> through the BSD socket API described in unix(7), by invoking socket(2)
> followed by connect(2) with a suitable struct sockname_un holding the
> socket's filename.  This can come as a surprise for users (e.g. in
> [1]) and it can be used to escape a sandbox when a Unix service offers
> command execution (some scenarios were listed by Tingmao Wang in [2]).
> 
> The original feature request is at [4].
> 
> ## Alternatives and Related Work
> 

> ### Alternative: Use existing LSM hooks
> 
> The existing hooks security_unix_stream_connect(),
> security_unix_may_send() and security_socket_connect() do not give
> access to the resolved file system path.
> 
> Resolving the file system path again within Landlock would in my
> understanding produce a TOCTOU race, so making the decision based on
> the struct sockaddr_un contents is not an option.
> 
> It is tempting to use the struct path that the listening socket is
> bound to, which can be acquired through the existing hooks.
> Unfortunately, the listening socket may have been bound from within a
> different namespace, and it is therefore a path that can not actually
> be referenced by the sandboxed program at the time of constructing the
> Landlock policy.  (More details are on the Github issue at [6] and on
> the LKML at [9]).

Please move (or duplicate) this rationale in the patch dedicated to the
new hook.  It helps patch review (and to understand commits when already
merged).

> 
> ### Related work: Scope Control for Pathname Unix Sockets
> 
> The motivation for this patch is the same as in Tingmao Wang's patch
> set for "scoped" control for pathname Unix sockets [2], originally
> proposed in the Github feature request [5].
> 
> In my reply to this patch set [3], I have discussed the differences
> between these two approaches.  On the related discussions on Github
> [4] and [5], there was consensus that the scope-based control is
> complimentary to the file system based control, but does not replace
> it.  Mickael's opening remark on [5] says:
> 
> > This scoping would be complementary to #36 which would mainly be
> > about allowing a sandboxed process to connect to a more privileged
> > service (identified with a path).
> 
> ## Open questions in V2
> 
> Seeking feedback on:
> 
> - Feedback on the LSM hook name would be appreciated. We realize that
>   not all invocations of the LSM hook are related to connect(2) as the
>   name suggests, but some also happen during sendmsg(2).

Renaming security_unix_path_connect() to security_unix_find() would look
appropriate to me wrt the caller.

> - Feedback on the structuring of the Landlock access rights, splitting
>   them up by socket type.  (Also naming; they are now consistently
>   called "RESOLVE", but could be named "CONNECT" in the stream and
>   seqpacket cases?)

I don't see use cases where differenciating the type of unix socket
would be useful.  LANDLOCK_ACCESS_FS_RESOLVE_UNIX would look good to me.

Tests should still cover all these types though.

What would be the inverse of "resolve" (i.e. to restrict the server
side)?  Would LANDLOCK_ACCESS_FS_MAKE_SOCK be enough?

> 
> ## Credits
> 
> The feature was originally suggested by Jann Horn in [7].
> 
> Tingmao Wang and Demi Marie Obenour have taken the initiative to
> revive this discussion again in [1], [4] and [5] and Tingmao Wang has
> sent the patch set for the scoped access control for pathname Unix
> sockets [2].
> 
> Justin Suess has sent the patch for the LSM hook in [8].
> 
> Ryan Sullivan has started on an initial implementation and has brought
> up relevant discussion points on the Github issue at [4] that lead to
> the current approach.
> 
> [1] https://lore.kernel.org/landlock/515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com/
> [2] Tingmao Wang's "Implemnet scope control for pathname Unix sockets"
>     https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
> [3] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/
> [4] Github issue for FS-based control for named Unix sockets:
>     https://github.com/landlock-lsm/linux/issues/36
> [5] Github issue for scope-based restriction of named Unix sockets:
>     https://github.com/landlock-lsm/linux/issues/51
> [6] https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
> [7] https://lore.kernel.org/linux-security-module/CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com/
> [8] Patch for the LSM hook:
>     https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/
> [9] https://lore.kernel.org/all/20260108.64bd7391e1ae@gnoack.org/
> 
> ---
> 
> ## Older versions of this patch set
> 
> V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> 
> Changes in V2:
>  * Send Justin Suess's LSM hook patch together with the Landlock
>    implementation
>  * LSM hook: Pass type and flags parameters to the hook, to make the
>    access right more generally usable across LSMs, per suggestion from
>    Paul Moore (Implemented by Justin)
>  * Split the access right into the three types of UNIX domain sockets:
>    SOCK_STREAM, SOCK_DGRAM and SOCK_SEQPACKET.
>  * selftests: More exhaustive tests.
>  * Removed a minor commit from V1 which adds a missing close(fd) to a
>    test (it is already in the mic-next branch)
> 
> Günther Noack (4):
>   landlock: Control pathname UNIX domain socket resolution by path
>   samples/landlock: Add support for named UNIX domain socket
>     restrictions
>   landlock/selftests: Test named UNIX domain socket restrictions
>   landlock: Document FS access rights for pathname UNIX sockets
> 
> Justin Suess (1):
>   lsm: Add hook unix_path_connect
> 
>  Documentation/userspace-api/landlock.rst     |  25 ++-
>  include/linux/lsm_hook_defs.h                |   4 +
>  include/linux/security.h                     |  11 +
>  include/uapi/linux/landlock.h                |  10 +
>  net/unix/af_unix.c                           |   9 +
>  samples/landlock/sandboxer.c                 |  18 +-
>  security/landlock/access.h                   |   2 +-
>  security/landlock/audit.c                    |   6 +
>  security/landlock/fs.c                       |  34 ++-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  security/security.c                          |  20 ++
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   | 225 +++++++++++++++++--
>  14 files changed, 344 insertions(+), 26 deletions(-)
> 
> -- 
> 2.52.0
> 
> 

