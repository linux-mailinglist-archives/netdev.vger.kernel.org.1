Return-Path: <netdev+bounces-295244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vTQtF8d9IWqHHQEAu9opvQ
	(envelope-from <netdev+bounces-295244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7A640586
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:29:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XxzqfsTJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295244-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B75C6304FB42
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221DE3A5E92;
	Thu,  4 Jun 2026 13:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC71917FB;
	Thu,  4 Jun 2026 13:21:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579318; cv=none; b=CfMgF9s6HiWVFFZ+dv1kZEJ/2tIPrbah5JnXITY9DbslJOMcPp1lyPoX39re92TJ7KcytmwtmMY+noNz5GiLv/FU+xpbcloTZDXzMU1xp2DUn6SWMTdO6G71f74IOgLiGiCQldIkgpm55sp9nNqEc3kf38Qr5+gZ8YtaCDtJmwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579318; c=relaxed/simple;
	bh=pXUNbEWCMR85osdK/op/ojECmWrGtQTXkPsbVoZ2ZUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN3UD9rjBQ4qLRPHMXw258ScKSZqvzeJvx0ttSIoDJ1zNnds7HtUzktVitBdTmpfRCIO1WFdzLF7McrvHFoA8am7v6BMEHj4swfJ05Vt2FA9f33oE2YD6Q0CQbyt9laz35inYaFGytImJf9BaszwOec0l2Ny1tXzEQ99SnPJJkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxzqfsTJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245FD1F00893;
	Thu,  4 Jun 2026 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579316;
	bh=ve97dki2PV3LjRGiFHzMYMHrM8bU+3Hy/Ds/lCO8I2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxzqfsTJlSthH0Q8C+QmnFn+QeSZWliUvafSEEcMxGLGoGjNig6UC96HYtANo6kIh
	 xFhGqKajU916+21pSWploQGt5yk3S16jrpkjt5oXDvWDh4IYWngMRMmAS30QoUXD6/
	 j2shD5UP1fkMr1rgEutm3FvI+RhWX1hLKHjuCc/L4haRbfbdAda4Wda9iu6fEUe5Rf
	 w/0TeFVXNwkrwavsgcu8Xl2kh51TO/UJgSRWvbtJ9Icn7XL0cWU5GxejTNgBJQFbRD
	 JWXmp01PdBjwXDzfQTA+bgH5v4bVbSErhwMSePrB0QyK1yyAq6kljbk43B2dBYva4A
	 yxzRxzFuvNP0A==
From: Simon Horman <horms@kernel.org>
To: aroulin@nvidia.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	roopa@nvidia.com,
	petrm@nvidia.com,
	idosch@nvidia.com,
	chirag@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] selftests: net: add vxlan vnifilter notification test
Date: Thu,  4 Jun 2026 14:19:25 +0100
Message-ID: <20260604131922.3928241-4-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602185138.253265-4-aroulin@nvidia.com>
References: <20260602185138.253265-4-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:aroulin@nvidia.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295244-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url,fdb_notify.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8B7A640586

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/

Simon says:

There is also an AI-generated review of this patch on sashiko.dev.
And AI-generated reviews of other patches of this series.
But I believe what is forwarded here covers what should
be considered in the context of this patch-set.

---
selftests: net: add vxlan vnifilter notification test

This patch adds a selftest that exercises VXLAN vnifilter netlink
notifications by running bridge monitor vni in the background while
adding, updating, deleting and re-adding VNIs, then counting the
matching lines in the captured output.

> diff --git a/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
> new file mode 100755
> index 000000000000..9d51a9e02ae0
> --- /dev/null
> +++ b/tools/testing/selftests/net/test_vxlan_vnifilter_notify.sh
> @@ -0,0 +1,184 @@

[ ... ]

> +# Run bridge monitor in the background, execute a command, then count
> +# the notification lines.
> +# Usage: vni_notify_check <command> [args...]
> +# Sets: NOTIFY_COUNT with the number of notifications observed.
> +vni_notify_check()
> +{
> +	local tmpf cmd_ret monitor_pid
> +
> +	tmpf=$(mktemp)
> +	defer rm "$tmpf"
> +
> +	defer_scope_push
> +		ip netns exec "$NS1" bridge monitor vni > "$tmpf" 2>/dev/null &
> +		monitor_pid=$!
> +		defer kill_process "$monitor_pid"
> +
> +		sleep 0.5
> +		if [ ! -e "/proc/$monitor_pid" ]; then
> +			RET=$ksft_skip
> +			log_test "iproute2 'bridge monitor vni' not supported"
> +			return "$RET"
> +		fi

[Medium]
Could the skip path here turn a legitimate skip into a failure?

When bridge monitor vni is not supported, the helper sets RET=$ksft_skip,
calls log_test from inside the helper, and then returns ksft_skip (4).
Every caller follows the helper with:

    vni_notify_check \
        bridge -n "$NS1" vni add vni 1000 dev "$VXLAN_DEV"
    check_err $? "Failed to add VNI"

Since ksft_skip is non-zero, check_err treats the return as a failure
and calls ret_set_ksft_status with ksft_fail. Per the merge weights in
ksft_status_merge (pass < xfail < skip < fail), that demotes RET from
skip to fail.

NOTIFY_COUNT is also never assigned because the function returned
before the grep, so the next:

    [ "$NOTIFY_COUNT" -eq 1 ]
    check_err $? "Expected 1 notification for VNI add, got $NOTIFY_COUNT"

also records a failure, and the caller's log_test then prints FAIL for
the real test name in addition to the SKIP printed by the helper. The
script ends up reporting both a SKIP and a FAIL line for the same case
and exits with a failure status.

Two related observations on this same path:

The bare return is issued between defer_scope_push and defer_scope_pop,
so defer_scope_pop is skipped on the skip path. Does that leave
__DEFER__SCOPE_ID off by one and the registered defer kill_process
"$monitor_pid" only unwound through the EXIT trap rather than the
normal scope unwind?

Would it be cleaner to signal skip back to the caller without going
through check_err (for example, set RET plus a flag and have the caller
short-circuit), and either move log_test to the caller or restructure
the skip path so it does not straddle defer_scope_push/defer_scope_pop?
fdb_notify.sh uses a similar pattern without mixing log_test and an
early return inside the scope.

> +
> +		"$@"
> +		cmd_ret=$?
> +		sleep 0.2
> +	defer_scope_pop
> +
> +	NOTIFY_COUNT=$(grep -c "$VXLAN_DEV" "$tmpf")
> +	NOTIFY_COUNT=${NOTIFY_COUNT:-0}
> +	return "$cmd_ret"
> +}

[Low]
Does this counting strategy actually distinguish RTM_NEWTUNNEL from
RTM_DELTUNNEL?

The commit message states:

    verifies that RTM_NEWTUNNEL and RTM_DELTUNNEL are sent correctly
    when VNIs are added, deleted, or updated

but NOTIFY_COUNT comes from:

    NOTIFY_COUNT=$(grep -c "$VXLAN_DEV" "$tmpf")

which matches both add and delete events emitted by bridge monitor vni.
A regression that emitted RTM_NEWTUNNEL on delete (or vice versa) would
still produce NOTIFY_COUNT=1 and pass every positive test. Would
differentiating the two (for instance, by separately counting lines
that begin with "Deleted " versus those that do not) make the test
match what the commit message describes?

