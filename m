Return-Path: <netdev+bounces-259925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIzPKCq0m2kJ5AMAu9opvQ
	(envelope-from <netdev+bounces-259925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53E1715D7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DF73009535
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05D1CAA68;
	Mon, 23 Feb 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRkxqmkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039758632B
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771811879; cv=none; b=YGgCQShl6c3+upZGy8K2YXWR8wGPU0WD3ZIeLu9IxlYCzvOEM/mL8BX6a4JSd/yJNrEAeQKFtNYKbO2ftbndrLobFytZJ8r6kDkiNGOsgl7lZkMcSBZ2DmNAchGjsWRdEMcoO+og7+NVoeB1mWfUYRC6oVod6TnNh+f/icisagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771811879; c=relaxed/simple;
	bh=/4gziutufUrH0OFdOQhNBLXzMCh+IGZVYu9/0hxCRrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVdpnchHq717gpCs4V/y7r8dEPVGuK/5Gh+afiZbz0msnNR0dBZCQjJDrCkvvN0uyEklpLmWbFk+SIMiR3F2tJkjFkBBLCrjqb+/cVWlR6j9oPyp6c2/zLf89OWsFOkHvcGNkWERWC6FN+R8P4YpjirfiGF4xMoG7Axnuwrrnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRkxqmkz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad22a5e245so25083295ad.2
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771811876; x=1772416676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=llR/CDN0qA6HlMSpdCclQMih6ERIQrWO2TnuYjQc/wc=;
        b=dRkxqmkz4+9D9nN+FHjZ0UWxSnz83ew3lB7ZbJ+lW5/yGaAzTewmsZpLKEDH40MGP2
         8tpu0O1c0ju5UVwPop0ydHVoPZmDGgURzkpfr1x4LpTIlm5RGhq73xveEvUFMhwbzhow
         mXeeXG8QbYJm4QyKrzVzrtl/BtFZbVV/5JJMvi7vFX9PfO9o7ur64GrewoQdw/HzY9mo
         MeaSJq8cirXAdcDOIJTWgV44j/lgX8HEZwU1Pa/fdOoip3CKB6JWbpe98li8eOQnoSL2
         Vl86ArgKgMDx9IjlsL50he5EMKNZpPrulhDGVHsByzMEa9Md+UlJHG/nAdTMSkUPTag9
         9/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771811876; x=1772416676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llR/CDN0qA6HlMSpdCclQMih6ERIQrWO2TnuYjQc/wc=;
        b=lDviIa95WaBkgdjR03p6Ks3tq12+5VftJju5gM21KU0UMFwipw6CarznagXNei54Hx
         A7jTrg4GiRdhuWqd78234w/mi5sE4umRbSosGZkh3KoMTE3ueKGyRqi8C5RFF91/epbw
         Mi7HVDChTD8sRAB3yklMYXJkXV7ikZ5k9pdsAGoN2BC1WM+JSxGmnOyvXG17BuAI/m7a
         F3ONay1PLHtLKLG2jLDl1vUxpw28fL3JzAbKA9b9AyqjOAvxZtY9zSlOC5LB1QnAgzwW
         /Pl6lr6IVwnMPS49j2eOe/QlZexIKkOcoEZOialkk5/jB6AseRA2ggBtXjt6gxuS1uNI
         OW5w==
X-Gm-Message-State: AOJu0YxEFcByef7L4EBFL9Bd1jFp3kFYAz9MUUOmFtqPg6RaiQUVHrfv
	hMHx1H9Jrtyfsq7AN/i716rfdb4CS9J4m0AxrDdffciMU/igFf99PtOy
X-Gm-Gg: AZuq6aLYkfPItC1MNtHETSzIg1QM7CaPwEU+Bm/kQIKEGC0/yajIXPxq2wj0+qMAjsR
	uEsVD/IID17K8hWSj8YSpI5gZwuyNX6/4WpjxVIvbTfwytaycLuAuov5UPDMYW7tFY1uki6VhCB
	FlFXmssnD9JOvWyd0wN7hCwbf6tGFqfwpa3nEv+YorD+qG5vEwJ2V4gFIKHWii1Jp1ATZZO/0GD
	f1bNZhuAPCVbbI75qfSYyOps9B5oxzTmCor/yHHXSoHzj3xBBPNo40Gk7WDJAwsKrxRdBgje73Z
	AUWb5dDwVtOSLeRkwGJ6oQAlaak0AYorgBykE23s4QkCnPXQGVacrcFG9zsiA2DcPrPaKZ948eW
	wQJly+k8vioBcEjoaI+j0otgfGsOEgdfUE9F3T1itTr7T7jT8mt5qnZor3aBckgbvL8K3rX+W5b
	HJa38I/yRd682Cn4yDjZqTzv+u3Fo=
X-Received: by 2002:a17:902:f682:b0:2a8:ac0f:9ae9 with SMTP id d9443c01a7336-2ad7452627amr58120695ad.41.1771811876211;
        Sun, 22 Feb 2026 17:57:56 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f72497sm53662645ad.38.2026.02.22.17.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 17:57:55 -0800 (PST)
Date: Mon, 23 Feb 2026 01:57:50 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <shuah@kernel.org>, Brendan Jackman <jackmanb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH selftests] selftests: Use ktap helpers for runner.sh
Message-ID: <aZu0Hka4QRbrsh4z@fedora>
References: <20260206081704.53215-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206081704.53215-1-liuhangbin@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259925-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,run_kselftest.sh:url,runner.sh:url]
X-Rspamd-Queue-Id: DA53E1715D7
X-Rspamd-Action: no action

Hi Shuah, Brendan,

Any feedback for this patch?

Thanks
Hangbin
On Fri, Feb 06, 2026 at 08:17:04AM +0000, Hangbin Liu wrote:
> This has been on my todo list for a long time. We should use ktap
> helpers in runner.sh. I saw Brendan did some work in d9e6269e3303
> ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> run_kselftest.sh exit with the correct return value. But we still use a
> custom solution in runner.sh. Let's convert all the print messages to use
> formal ktap helpers. Here’s what I changed:
> 
>   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
>      is the only caller of run_many().
>   2. In run_kselftest.sh, call run_many() in main process to count the
>      pass/fail numbers.
>   3. In run_kselftest.sh, do not generate kselftest_failures_file; just
>      use ktap_print_totals to report the result.
>   4. In runner.sh run_one(), get the return value and use ktap helpers for
>      all pass/fail reporting. This allows counting pass/fail numbers in the
>      main process.
>   5. In runner.sh run_in_netns(), also return the correct rc, so we can
>      count results during wait.
> 
> After the change, the printed result looks like:
> 
>   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
>   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
>   ]# echo $?
>   1
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 83 ++++++++++++---------
>  tools/testing/selftests/run_kselftest.sh    | 21 ++++--
>  2 files changed, 62 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 3a62039fa621..f3307f2d1f48 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -1,8 +1,8 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Runs a set of tests in a given subdirectory.
> -export skip_rc=4
> +. $(dirname "$(readlink -e "${BASH_SOURCE[0]}")")/ktap_helpers.sh
>  export timeout_rc=124
>  export logfile=/dev/stdout
>  export per_test_logging=
> @@ -44,17 +44,11 @@ tap_timeout()
>  	fi
>  }
>  
> -report_failure()
> -{
> -	echo "not ok $*"
> -	echo "$*" >> "$kselftest_failures_file"
> -}
> -
>  run_one()
>  {
>  	DIR="$1"
>  	TEST="$2"
> -	local test_num="$3"
> +	local rc test_num="$3"
>  
>  	BASENAME_TEST=$(basename $TEST)
>  
> @@ -102,16 +96,17 @@ run_one()
>  	# Command line timeout overrides the settings file
>  	if [ -n "$kselftest_override_timeout" ]; then
>  		kselftest_timeout="$kselftest_override_timeout"
> -		echo "# overriding timeout to $kselftest_timeout" >> "$logfile"
> +		ktap_print_msg "overriding timeout to $kselftest_timeout" >> "$logfile"
>  	else
> -		echo "# timeout set to $kselftest_timeout" >> "$logfile"
> +		ktap_print_msg "timeout set to $kselftest_timeout" >> "$logfile"
>  	fi
>  
>  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
>  	echo "# $TEST_HDR_MSG"
>  	if [ ! -e "$TEST" ]; then
> -		echo "# Warning: file $TEST is missing!"
> -		report_failure "$test_num $TEST_HDR_MSG"
> +		ktap_print_msg "Warning: file $TEST is missing!"
> +		ktap_test_fail "$test_num $TEST_HDR_MSG"
> +		rc=$KSFT_FAIL
>  	else
>  		if [ -x /usr/bin/stdbuf ]; then
>  			stdbuf="/usr/bin/stdbuf --output=L "
> @@ -122,33 +117,37 @@ run_one()
>  		elif [ -x "./ksft_runner.sh" ]; then
>  			cmd="$stdbuf ./ksft_runner.sh ./$BASENAME_TEST"
>  		else
> -			echo "# Warning: file $TEST is not executable"
> +			ktap_print_msg "Warning: file $TEST is not executable"
>  
>  			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
>  			then
>  				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
>  				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
>  			else
> -				report_failure "$test_num $TEST_HDR_MSG"
> -				return
> +				ktap_test_fail "$test_num $TEST_HDR_MSG"
> +				return $KSFT_FAIL
>  			fi
>  		fi
>  		cd `dirname $TEST` > /dev/null
> -		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
> +		(((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
>  			tap_prefix >&4) 3>&1) |
> -			(read xs; exit $xs)) 4>>"$logfile" &&
> -		echo "ok $test_num $TEST_HDR_MSG") ||
> -		(rc=$?;	\
> -		if [ $rc -eq $skip_rc ]; then	\
> -			echo "ok $test_num $TEST_HDR_MSG # SKIP"
> -		elif [ $rc -eq $timeout_rc ]; then \
> -			echo "#"
> -			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
> +			(read xs; exit $xs)) 4>>"$logfile"
> +		rc=$?
> +		if [ "$rc" -eq "$KSFT_PASS" ]; then
> +			ktap_test_pass "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$KSFT_SKIP" ]; then
> +			ktap_test_skip "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$KSFT_XFAIL" ]; then
> +			ktap_test_xfail "$test_num $TEST_HDR_MSG"
> +		elif [ "$rc" -eq "$timeout_rc" ]; then
> +			ktap_test_fail "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
>  		else
> -			report_failure "$test_num $TEST_HDR_MSG # exit=$rc"
> -		fi)
> +			ktap_test_fail "$test_num $TEST_HDR_MSG # exit=$rc"
> +		fi
>  		cd - >/dev/null
>  	fi
> +
> +	return $rc
>  }
>  
>  in_netns()
> @@ -164,27 +163,34 @@ in_netns()
>  
>  run_in_netns()
>  {
> -	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
>  	local tmplog="/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
> +	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
> +	local rc
> +
>  	ip netns add $netns
>  	if [ $? -ne 0 ]; then
> -		echo "# Warning: Create namespace failed for $BASENAME_TEST"
> -		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
> +		ktap_print_msg "Warning: Create namespace failed for $BASENAME_TEST"
> +		ktap_test_fail "$test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
>  	fi
>  	ip -n $netns link set lo up
> +
>  	in_netns $netns &> $tmplog
> +	rc=$?
> +
>  	ip netns del $netns &> /dev/null
> +	# Cat the log at once to avoid parallel netns logs.
>  	cat $tmplog
>  	rm -f $tmplog
> +	return $rc
>  }
>  
>  run_many()
>  {
> -	echo "TAP version 13"
>  	DIR="${PWD#${BASE_DIR}/}"
>  	test_num=0
> -	total=$(echo "$@" | wc -w)
> -	echo "1..$total"
> +	local rc
> +	pids=()
> +
>  	for TEST in "$@"; do
>  		BASENAME_TEST=$(basename $TEST)
>  		test_num=$(( test_num + 1 ))
> @@ -194,10 +200,19 @@ run_many()
>  		fi
>  		if [ -n "$RUN_IN_NETNS" ]; then
>  			run_in_netns &
> +			pids+=($!)
>  		else
>  			run_one "$DIR" "$TEST" "$test_num"
>  		fi
>  	done
>  
> -	wait
> +	# Handle the return values when running in netns.
> +	for pid in "${pids[@]}"; do
> +		wait "$pid"
> +		rc=$?
> +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=$((KTAP_CNT_PASS+1))
> +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
> +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
> +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
> +	done
>  }
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index d4be97498b32..10930d09f2a5 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -110,18 +110,23 @@ if [ -n "$TESTS" ]; then
>  	available="$(echo "$valid" | sed -e 's/ /\n/g')"
>  fi
>  
> -kselftest_failures_file="$(mktemp --tmpdir kselftest-failures-XXXXXX)"
> -export kselftest_failures_file
> -
> +curdir=$(pwd)
> +total=$(echo "$available" | wc -w)
>  collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
> +
> +ktap_print_header
> +ktap_set_plan "$total"
> +
>  for collection in $collections ; do
>  	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
>  	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
> -	($dryrun cd "$collection" && $dryrun run_many $tests)
> +	$dryrun cd "$collection" && $dryrun run_many $tests
> +	$dryrun cd "$curdir"
>  done
>  
> -failures="$(cat "$kselftest_failures_file")"
> -rm "$kselftest_failures_file"
> -if "$ERROR_ON_FAIL" && [ "$failures" ]; then
> -	exit 1
> +ktap_print_totals
> +if "$ERROR_ON_FAIL" && [ "$KTAP_CNT_FAIL" -ne 0 ]; then
> +	exit "$KSFT_FAIL"
> +else
> +	exit "$KSFT_PASS"
>  fi
> -- 
> 2.50.1
> 

