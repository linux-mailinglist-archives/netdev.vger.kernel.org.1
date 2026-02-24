Return-Path: <netdev+bounces-260540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JHYBEOnnWmgQwQAu9opvQ
	(envelope-from <netdev+bounces-260540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83572187A70
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93EC530B92C5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3925137C102;
	Tue, 24 Feb 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaPIvB6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE431690A
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939313; cv=none; b=Z9Wx+tZ9xP/7atcq/dlo+8taslWDP1ilqNXDdFx84PAyLs7ulVZcWaciTSWgpiN1lC9GxMIRALIS78W8vJz+MiIcACOXbVrox7zk7qFL6i5qfppb0S1XmaBjoibD0gPmvYtxCGYAS7StReLf8tS5l53iXfvY9ZYkZsJFgn6ceWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939313; c=relaxed/simple;
	bh=KdFMNqHQC0OZGucm4zJmZCgBBYcLdHV0SzSRNUCwqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNnlbKMHRh+9kvpRUChLDnlibLRXElLT1TybUQbNxPfktpaChr9lq8tO+BCwwxA80E6AVR/g8ulE3WOvzG/oCP6XD07WAE44MW+SUfwQIOmXa854Kc6VSifBEjHfpI7X+FDSZoPPkPXP//qlSRjkuIrUxdYf6Kgq364qK9gXZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaPIvB6Y; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-824b32875e7so2637121b3a.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 05:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771939310; x=1772544110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DBQxTCdml7S+itQTZYwXfqu7v90m5fsL9enZcs6YS8=;
        b=eaPIvB6YkP39abDnLKdEavBvegdKPDFge4lbX5NUsvE2eOLIjcJrz1WoauILO8FXTM
         arVUDuORiqB5jRkigAyJq9+MenGqERBgRk61KNInHeKLpBKt7pVfdiMbj/B7wktL68PU
         8dVB8/ozgC0SNrv60jwqPq3ypxKtyjU3Bn9uCbRmL1Cd0/P+hKVkGthm3Vg35qql3GYO
         ridB0gZcWCdfKsuTQrjU7RGLvtw+D6e3sQ585Oz1rRkGZ3Bb9LHLvTUt31DkzwInbO48
         EsNMBjFpfetMZxryknmoWEKMmSdQuSuT+ltcoXxg0XqWMAJqML5y9IqDbNYwOUAoN/u4
         xnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771939310; x=1772544110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DBQxTCdml7S+itQTZYwXfqu7v90m5fsL9enZcs6YS8=;
        b=dBTkeujVxCVDMlAAqCC8fTC2aohNp2RdBuuth1gFTfBlQ9qSjnAILB+YD4UbAJi0lR
         GPU3meVFUzuHpXcsgKj3UXJ83hwWksxZwl3nKGer8bVTYfGnSzoTf3v/fiYfsxaHTdS4
         O9a/34Mj0RnEAPc06XqRa808k7LBiog9dqu9rt/XMQjeZt8iPrug4EtJj/tkLQVkc/CW
         swQ3stFcEglQRbIKe7vtCwwsFi6j/jGkxyV0U3LlSMfp6Xkanhs+oI9GBsOXVGh7LiNv
         H1h+BGHItcIZjavya0SgaiJLyE2O6tAkjuu10Of4AgZH25HO/9TkqqImwpZhE5kxVU0z
         Q4IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqCA3UpZH9raSwMUw9z7NWIPhfweiJb8tuWEJ+3g2rd6pxtML98l1bdU2goo9AkJZcW2J0lWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Z5c3oLOW7PkvpaAAoSFTA61Kxj+5Sp3MjqBKFCccKVCCGN0x
	XCOVU57g9qEcKwhUN8rQHSlC/WbUBuXDueoMBqJJEeYe3imPH7H7/VQ6
X-Gm-Gg: AZuq6aJ2cZ5TJoS/W9r4aPcP/DCs1uh68DlBiSEgV/fCLe+4Lo6NRngbByp64EmLsHX
	oMCdTRzrX6XBLxaDw6n9bAT6DXl8t+S9UdScDdd2afdgkWxT1TYZRHSJUrk0iBCm85WNijHCOq2
	dyjUYJ9pXX+6gJx63DSHiTYucxxHHk28yfsyFzYfnYH1vzNnbpgAR5VyF6/0GQCoRRaVUTWYuXY
	RzVNI3RJvuPugmKxofN/B7sRaGLMN5a56PMJo8962JGnRMuTbP3TM5WMprdcJm0a7jMsfvGPSPt
	4lLMIoYjhj86FseRWyrEveBCZ2rS8GB2RWY5CkyhRVoFCLzlRKnZ3L9IjAjp7B/Lw+IoMoQMbix
	CWIwi4k29NOiPOjp1vrmO3VmF+7yFXkzCWj4SIhPRRuSPZ9zFMB7Kk4R6tQc4l4b6TtueGeGapA
	nmoiymk2gDgcjVkSyP9Ra1jT0ha7U=
X-Received: by 2002:a05:6a21:a03:b0:38b:d95e:69a9 with SMTP id adf61e73a8af0-39545ebb962mr10908349637.16.1771939310267;
        Tue, 24 Feb 2026 05:21:50 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358f5f7457csm883925a91.16.2026.02.24.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:21:49 -0800 (PST)
Date: Tue, 24 Feb 2026 13:21:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCHv2] selftests: Use ktap helpers for runner.sh
Message-ID: <aZ2l6dN2fZapf4eP@fedora>
References: <20260224041048.6570-1-liuhangbin@gmail.com>
 <DGN5V6ZKYQ3A.1F5DK46XY82YB@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGN5V6ZKYQ3A.1F5DK46XY82YB@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260540-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83572187A70
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 11:38:34AM +0000, Brendan Jackman wrote:
> Cool thanks sorry I did not really review the code before but now I'm
> taking a closer look.
> 
> I don't parse KTAP but I did check that this doesn't break my usecase
> [0] so:
> 
> Tested-By: Brendan Jackman <jackmanb@google.com>
> 
> [0]: https://github.com/bjackman/limmat-kernel-nix/blob/master/ktests.nix

Thanks for the testing.

> >  run_in_netns()
> >  {
> > -	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
> >  	local tmplog="/tmp/$(mktemp -u ${BASENAME_TEST}-XXXXXX)"
> > +	local netns=$(mktemp -u ${BASENAME_TEST}-XXXXXX)
> 
> Nit (no need to respin just for this, but if you're already respinning):
> Diff noise here.

This is to make the variables in reverse Christmas tree based on kernel code
style.

> 
> > +	local rc
> > +
> >  	ip netns add $netns
> >  	if [ $? -ne 0 ]; then
> > -		echo "# Warning: Create namespace failed for $BASENAME_TEST"
> > -		echo "not ok $test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
> > +		ktap_print_msg "Warning: Create namespace failed for $BASENAME_TEST"
> > +		ktap_test_fail "$test_num selftests: $DIR: $BASENAME_TEST # Create NS failed"
> >  	fi
> >  	ip -n $netns link set lo up
> > +
> >  	in_netns $netns &> $tmplog
> > +	rc=$?
> > +
> >  	ip netns del $netns &> /dev/null
> > +	# Cat the log at once to avoid parallel netns logs.
> >  	cat $tmplog
> >  	rm -f $tmplog
> > +	return $rc
> >  }
> >  
> >  run_many()
> >  {
> > -	echo "TAP version 13"
> >  	DIR="${PWD#${BASE_DIR}/}"
> >  	test_num=0
> > -	total=$(echo "$@" | wc -w)
> > -	echo "1..$total"
> > +	local rc
> > +	pids=()
> > +
> >  	for TEST in "$@"; do
> >  		BASENAME_TEST=$(basename $TEST)
> >  		test_num=$(( test_num + 1 ))
> > @@ -194,10 +200,20 @@ run_many()
> >  		fi
> >  		if [ -n "$RUN_IN_NETNS" ]; then
> >  			run_in_netns &
> > +			pids+=($!)
> >  		else
> >  			run_one "$DIR" "$TEST" "$test_num"
> >  		fi
> >  	done
> >  
> > -	wait
> > +	# These variables are outputs of ktap_helpers.sh but since we've
> > +	# run the test in a subprocess we need to update them manually
> > +	for pid in "${pids[@]}"; do
> > +		wait "$pid"
> > +		rc=$?
> > +		[ "$rc" -eq "$KSFT_PASS" ] && KTAP_CNT_PASS=$((KTAP_CNT_PASS+1))
> > +		[ "$rc" -eq "$KSFT_FAIL" ] && KTAP_CNT_FAIL=$((KTAP_CNT_FAIL+1))
> > +		[ "$rc" -eq "$KSFT_SKIP" ] && KTAP_CNT_SKIP=$((KTAP_CNT_SKIP+1))
> > +		[ "$rc" -eq "$KSFT_XFAIL" ] && KTAP_CNT_XFAIL=$((KTAP_CNT_XFAIL+1))
> > +	done
> 
> Can we please be consistent about how we do these two big conditional
> blocks? Also should they use `case`? Also please add something to not

Ah, yes, we can use case here. Let me update the patch.

> fail silently if $rc has a garbage value (I guess just log a warning).

A log here may break the KTAP output. While run_in_netns() calls run_one()
in the end, which will print the exit value if it's a garbage value. i.e.

    ktap_test_fail "$test_num $TEST_HDR_MSG # exit=$rc"

> 
> FWIW I still think this is very yucky but, it seems switching to the
> helper library is a worthwhile cleanup (plus, this patch drops a level
> of subshell nesting in the tap_timeout pipeline, which seems like a step
> in the right direction!) so I think it would be irrational to block that
> cleanup just coz of this yuckiness.

Thanks
Hangbin

