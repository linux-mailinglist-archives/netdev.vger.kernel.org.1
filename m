Return-Path: <netdev+bounces-281783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKj2Id2L8GkRUwEAu9opvQ
	(envelope-from <netdev+bounces-281783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:28:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086AB4829CD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C98DD303AF22
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841E83E9295;
	Tue, 28 Apr 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIKrx2Wm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B643E558C;
	Tue, 28 Apr 2026 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372104; cv=none; b=SpWP3GCUZtm2fjEa9xPgc4YFt/Xjj/mDVQlWv6S3Al5zn5mksqSFFICyOPi83xYPBpuRXPSTkpOCx7szpedihLvOZGASC+w45EwKA0re12rbASjgbWqnzEI+RApE7aIhH/+iUlfoxY+lkJvg9f2zGCCK9Ey/hDWjQEq15UgMP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372104; c=relaxed/simple;
	bh=SLgVYK/tGlFyKAB1dxJHoLFTJWRSgM8nMEvuFI1vfoY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=udwTUt3r7NOzFiuaOxYxucPTqJobcWS4cn5k3Uj8rFRVNo1ahdu8KHAam1sNShjxHNHbO/yDX4UA4fiDuQuuh6xqQJyQWH4dmG0sREMZAy1IZOxeT01ExA8ovD6r+69EAu8KPI/Hk0bO7eLneuEDqm1u203Gt7pyACs989H5UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIKrx2Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11DC2BCAF;
	Tue, 28 Apr 2026 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777372104;
	bh=SLgVYK/tGlFyKAB1dxJHoLFTJWRSgM8nMEvuFI1vfoY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=vIKrx2Wmdk7VlGdLYplTGfmTRWHs1aS4E9t8IVUtbT2twEnNO7P7Pm0e+xCgDLSfz
	 4tw3nbPpKmdmfNW8gJZ15Wt9yvu0C/riqhWxaTmdLYMJJk1RlD6AQRh995uzXGVxdK
	 OYHuUvG1mBQLjegZAyrYpWgF1bapjZuK1Isdf5gc8Mq+zcSaJAMqwyIdazwN3Qun8d
	 9slq/CeWx/y7DBKGSHGOVEij2uB9fkfxnVMEe/OsyvnOW9KXzXv3QyfkQhoaOkk0Jp
	 VtifzvPEr6r9u4x8b2N6rAzwEzFzNJ5HZ5nQLANEuNQCQ4NcobbX8BHaQNU5ujCYt0
	 RO80XVfeUgd4Q==
Content-Type: multipart/mixed; boundary="===============0722090956758177500=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e859787db4c4e0410c0a4110f162a0238673579eaca9ceb0a18702faf975000@mail.kernel.org>
In-Reply-To: <20260428080317.702124-2-tushar.vyavahare@intel.com>
References: <20260428080317.702124-2-tushar.vyavahare@intel.com>
Subject: Re: [PATCH 1/5] selftests/xsk: Introduce helpers for setting UMEM properties
From: bot+bpf-ci@kernel.org
To: tushar.vyavahare@intel.com,netdev@vger.kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,stfomichev@gmail.com,kernelxing@tencent.com,davem@davemloft.net,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,tirthendu.sarkar@intel.com,tushar.vyavahare@intel.com
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 28 Apr 2026 10:28:23 +0000 (UTC)
X-Rspamd-Queue-Id: 086AB4829CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281783-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,vger.kernel.org,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

--===============0722090956758177500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> index 7950c504ed28..d5cd8f590b25 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> @@ -303,6 +303,22 @@ static void test_spec_reset(struct test_spec *test)
>  	__test_spec_init(test, test->ifobj_tx, test->ifobj_rx);
>  }
>
> +static void test_spec_set_unaligned(struct test_spec *test)
> +{
> +	test_spec_set_unaligned(test);
> +}

Does this function recurse unconditionally?  Looking at the functions
this helper replaces, the body should set unaligned_mode = true on
both ifobj_tx->umem and ifobj_rx->umem.  Instead, every call to
test_spec_set_unaligned() recurses into itself with the same argument
until the stack is exhausted.

Five tests introduced in this commit call the broken helper:

    testapp_send_receive_unaligned()
    testapp_send_receive_unaligned_mb()
    testapp_unaligned_inv_desc()
    testapp_unaligned_inv_desc_4001_frame()
    testapp_unaligned_inv_desc_mb()

Each previously worked by directly setting the unaligned_mode fields.
After this patch, those direct assignments are replaced with calls to
test_spec_set_unaligned(), which crashes via stack overflow instead
of running the test.

> +
> +static void test_spec_set_frame_size(struct test_spec *test, u32 size)
> +{
> +	test->ifobj_tx->umem->frame_size = size;
> +	test->ifobj_rx->umem->frame_size = size;
> +}
> +
> +static void test_spec_set_frame_headroom(struct test_spec *test, u32 size)
> +{
> +	test->ifobj_rx->umem->frame_headroom = size;
> +}
> +

[ ... ]

> @@ -2025,8 +2041,7 @@ int testapp_stats_fill_empty(struct test_spec *test)
>
>  int testapp_send_receive_unaligned(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	/* Let half of the packets straddle a 4K buffer boundary */
>  	if (pkt_stream_replace_half(test, MIN_PKT_SIZE, -MIN_PKT_SIZE / 2))
>  		return TEST_FAILURE;
> @@ -2037,8 +2052,7 @@ int testapp_send_receive_unaligned(struct test_spec *test)
>  int testapp_send_receive_unaligned_mb(struct test_spec *test)
>  {
>  	test->mtu = MAX_ETH_JUMBO_SIZE;
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	if (pkt_stream_replace(test, DEFAULT_PKT_CNT, MAX_ETH_JUMBO_SIZE))
>  		return TEST_FAILURE;
>  	return testapp_validate_traffic(test);

[ ... ]

> @@ -2380,10 +2391,8 @@ int testapp_unaligned_inv_desc_4001_frame(struct test_spec *test)
>  	u64 page_size, umem_size;
>
>  	/* Odd frame size so the UMEM doesn't end near a page boundary. */
> -	test->ifobj_tx->umem->frame_size = 4001;
> -	test->ifobj_rx->umem->frame_size = 4001;
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_frame_size(test, 4001);
> +	test_spec_set_unaligned(test);
>  	/* This test exists to test descriptors that staddle the end of
>  	 * the UMEM but not a page.
>  	 */

[ ... ]

> @@ -2411,8 +2422,7 @@ int testapp_aligned_inv_desc_mb(struct test_spec *test)
>
>  int testapp_unaligned_inv_desc_mb(struct test_spec *test)
>  {
> -	test->ifobj_tx->umem->unaligned_mode = true;
> -	test->ifobj_rx->umem->unaligned_mode = true;
> +	test_spec_set_unaligned(test);
>  	return testapp_invalid_desc_mb(test);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25045852068
--===============0722090956758177500==--

