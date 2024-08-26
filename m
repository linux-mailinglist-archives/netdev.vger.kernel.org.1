Return-Path: <netdev+bounces-121874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850C895F198
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FA81C21767
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CA1714B5;
	Mon, 26 Aug 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="veiNOL6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4601714A8
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676025; cv=none; b=PjmbBNwtUwYc3h/q7GXiyBHcurzIkK0OgyX92tkgTzP34zQXq4+II6eYSfL5Ya5CKVUL+EK1GikEpJMV7AiDyajsn+lMtqOSSAuGjTJ5Qql79ke+4ZbmwARtd275McJ/zU5B9ltynNYsaWTHZCY8N+3cadOaVYM6DxpA5c8DcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676025; c=relaxed/simple;
	bh=fkiLOGVa7i+9iWY0FNJz2I4RqFP7yHaRFHUezaG2fOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THYKxkkcM3mPVjJ+HPSePq9PCv/tOc87GbVzRQoiHixyjXhcuFGSxPIzRoSyqaLCnyHtzK9cQ972MDwfnzxw6BvSSQZQ5gAAMgisQrAZpmu7l1EETwezcr6dHv45qnnPA2SuwpJrxR/hHW71ejWa9Rd6rnpUbnKcsj8b/7PmIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=veiNOL6I; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WsqyN3h6DzFqy;
	Mon, 26 Aug 2024 14:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724676012;
	bh=KsV8rfenMKN3qDcsb+DhferSBFj/rGnhu6CFyw+X3hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=veiNOL6IGeHEruX7680sdIhjDZhQGQh3Ew/BjNpMACBlPjkNoyZs/qiKcwL13q2+5
	 ENQeYxYwCPM7AjP8yQKGSr0X0Vtbk46sTDkI+t2LVLhYvvY4TvnZaiq/KL4/zn99ZZ
	 vGJ6VMkNrkkTATbST+WIPGy/k75p1hrtXpcjyvjs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WsqyM3mlJz3qB;
	Mon, 26 Aug 2024 14:40:11 +0200 (CEST)
Date: Mon, 26 Aug 2024 14:40:07 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 3/6] selftest/Landlock: Signal restriction tests
Message-ID: <20240826.queS8Fah5foo@digikod.net>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <82b0d2103013397d8b46de9fc7c8c78456055299.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82b0d2103013397d8b46de9fc7c8c78456055299.1723680305.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 15, 2024 at 12:29:22PM -0600, Tahera Fahimi wrote:
> This patch expands Landlock ABI version 6 by providing tests for
> signal scoping mechanism. Base on kill(2), if the signal is 0,
> no signal will be sent, but the permission of a process to send
> a signal will be checked. Likewise, this test consider one signal
> for each signal category.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> Chnages in versions:
> V2:
> * Moving tests from ptrace_test.c to scoped_signal_test.c
> * Remove debugging statements.
> * Covering all basic restriction scenarios by sending 0 as signal
> V1:
> * Expanding Landlock ABI version 6 by providing basic tests for
>   four signals to test signal scoping mechanism.
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 302 ++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 tools/testing/selftests/landlock/scoped_signal_test.c
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> new file mode 100644
> index 000000000000..92958c6266ca
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Landlock tests - Signal Scoping
> + *
> + * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
> + * Copyright © 2019-2020 ANSSI
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/landlock.h>
> +#include <signal.h>
> +#include <sys/prctl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "common.h"
> +
> +static sig_atomic_t signaled;

static volatile sig_atomic_t signaled;

> +
> +static void create_signal_domain(struct __test_metadata *const _metadata)
> +{
> +	int ruleset_fd;
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPED_SIGNAL,
> +	};
> +
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	EXPECT_LE(0, ruleset_fd)
> +	{
> +		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
> +	}
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +static void scope_signal_handler(int sig, siginfo_t *info, void *ucontext)
> +{
> +	if (sig == SIGHUP || sig == SIGURG || sig == SIGTSTP ||
> +	    sig == SIGTRAP || sig == SIGUSR1) {
> +		signaled = 1;
> +	}
> +}
> +
> +/* clang-format off */
> +FIXTURE(signal_scoping) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(signal_scoping)
> +{
> +	const int sig;
> +	const bool domain_both;
> +	const bool domain_parent;
> +	const bool domain_child;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_without_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_child_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = false,
> +	.domain_parent = false,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_parent_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_sibling_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_sibling_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_nested_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = true,
> +	.domain_parent = false,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_nested_and_parent_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain) {
> +	/* clang-format on */
> +	.sig = 0,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* Default Action: Terminate*/
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGHUP) {
> +	/* clang-format on */
> +	.sig = SIGHUP,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGHUP) {
> +	/* clang-format on */
> +	.sig = SIGHUP,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* Default Action: Ignore*/
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGURG) {
> +	/* clang-format on */
> +	.sig = SIGURG,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGURG) {
> +	/* clang-format on */
> +	.sig = SIGURG,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* Default Action: Stop*/
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGTSTP) {
> +	/* clang-format on */
> +	.sig = SIGTSTP,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGTSTP) {
> +	/* clang-format on */
> +	.sig = SIGTSTP,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* Default Action: Coredump*/
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGTRAP) {
> +	/* clang-format on */
> +	.sig = SIGTRAP,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, allow_with_forked_domain_SIGTRAP) {
> +	/* clang-format on */
> +	.sig = SIGTRAP,
> +	.domain_both = false,
> +	.domain_parent = true,
> +	.domain_child = false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(signal_scoping, deny_with_forked_domain_SIGUSR1) {
> +	/* clang-format on */
> +	.sig = SIGUSR1,
> +	.domain_both = true,
> +	.domain_parent = true,
> +	.domain_child = true,
> +};
> +
> +FIXTURE_SETUP(signal_scoping)
> +{
> +}
> +
> +FIXTURE_TEARDOWN(signal_scoping)
> +{
> +}
> +
> +TEST_F(signal_scoping, test_signal)

Sometime, this test hang.  I suspect the following issue:

> +{
> +	pid_t child;
> +	pid_t parent = getpid();
> +	int status;
> +	bool can_signal;
> +	int pipe_parent[2];
> +	struct sigaction action = {
> +		.sa_sigaction = scope_signal_handler,
> +		.sa_flags = SA_SIGINFO,
> +
> +	};
> +
> +	can_signal = !variant->domain_child;
> +
> +	if (variant->sig > 0)
> +		ASSERT_LE(0, sigaction(variant->sig, &action, NULL));
> +
> +	if (variant->domain_both) {
> +		create_signal_domain(_metadata);
> +		if (!__test_passed(_metadata))
> +			/* Aborts before forking. */
> +			return;
> +	}
> +	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		char buf_child;
> +		int err;
> +
> +		ASSERT_EQ(0, close(pipe_parent[1]));
> +		if (variant->domain_child)
> +			create_signal_domain(_metadata);
> +
> +		/* Waits for the parent to be in a domain, if any. */
> +		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));

There is a race condition here when the parent process didn't yet called
pause().

> +
> +		err = kill(parent, variant->sig);
> +		if (can_signal) {
> +			ASSERT_EQ(0, err);
> +		} else {
> +			ASSERT_EQ(-1, err);
> +			ASSERT_EQ(EPERM, errno);
> +		}
> +		/* no matter of the domain, a process should be able to send
> +		 * a signal to itself.
> +		 */
> +		ASSERT_EQ(0, raise(variant->sig));
> +		if (variant->sig > 0)
> +			ASSERT_EQ(1, signaled);
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +	ASSERT_EQ(0, close(pipe_parent[0]));
> +	if (variant->domain_parent)
> +		create_signal_domain(_metadata);
> +

/* The process should not have already been signaled. */
EXPECT_EQ(0, signaled);

> +	/* Signals that the parent is in a domain, if any. */
> +	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
> +
> +	if (can_signal && variant->sig > 0) {
> +		ASSERT_EQ(-1, pause());
> +		ASSERT_EQ(EINTR, errno);

This can hang indefinitely if the child process sent the signal after
reading from the pipe and before the call to pause().

This should be a better alternative to the use of pause():

/* Avoids race condition with the child's signal. */
while (!signaled && !usleep(1));
ASSERT_EQ(1, signaled);

BTW, we cannot reliably check for errno because usleep() may still
return 0, but that's OK.

> +		ASSERT_EQ(1, signaled);
> +	} else {
> +		ASSERT_EQ(0, signaled);
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.34.1
> 
> 

