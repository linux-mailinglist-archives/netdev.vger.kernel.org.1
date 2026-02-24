Return-Path: <netdev+bounces-260673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKFZLvc3nmm1UAQAu9opvQ
	(envelope-from <netdev+bounces-260673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:44:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1880218E2D3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8F53053773
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08F363C7C;
	Tue, 24 Feb 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0sfX/HQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489721638D;
	Tue, 24 Feb 2026 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976689; cv=none; b=eFWx1n2ZNnbmSpzUTH8guV3wjiabBeRZzPAiCNQyMkElhjv+t5DVfP4dhWwQHoTJgEsb9EbQMQ/nUvDe/SwTn+XnZnwECh0+vDqwml480JgWq8p7K+sz06RCyPexuxKma2h08eLN94oTvdBXuL+BgQj8JR1tZrIsz9AO0SmD9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976689; c=relaxed/simple;
	bh=Te9Sf434ncdnfzDw9exdh64Guu6TGx9lSLSzoDo6dxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iu3UnLE+hzHbukniljuqHduo4AY+ZkU5iZ+S729xfWQMGzCk3ggVhYFbp45ClCOCkjGwHfOXNXPZQP0laHA7jj68AIUi0vOWnhHsNiYQ14qU/G9ZqWWBU/1Q+6L2tRKETK0WLL6Ey4qtl+V5OnCB4ilhHe6UL9CO+FsKI3ZA24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0sfX/HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E6EC116D0;
	Tue, 24 Feb 2026 23:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771976689;
	bh=Te9Sf434ncdnfzDw9exdh64Guu6TGx9lSLSzoDo6dxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0sfX/HQPZZm/5dIbvJN9WmvSMdgFLV3+BggJukbhaVUT1VBNxaltJyCJctKN/Ql3
	 /FPPl8Le13kdRHYUMxoNCtm90AL1CdoQIzsyGZ5nNIiD9Mg3snvzBGaO6S/WTE+yJ3
	 CQSz0jxcuOxfAH2KA6oDKrUolyQvj3NKw/lKtR7ermp0tePh8ypf/5uriiBVvT9sOH
	 pxJFCZTsjs5yRt/rjMjeZIRU08DAo9wqr8K5Om1yNXyv2u3GZ8aOY0j9zIhmf0OiCT
	 zg8Rm/6/SC/6oI1GWwPSCTEZBujz2KJYQpy7q+PWB+9XiWfU8EPtPCS2Sks+S2zX1H
	 POHDLZmPRfoCQ==
Date: Tue, 24 Feb 2026 15:44:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, horms@kernel.org, shuah@kernel.org, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org
Subject: Re: [PATCH v2 1/2] selftests/harness: order TEST_F and XFAIL_ADD
 constructors
Message-ID: <20260224154447.61be24de@kernel.org>
In-Reply-To: <20260224113900.3331-1-sun.jian.kdev@gmail.com>
References: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
	<20260224113900.3331-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260673-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1880218E2D3
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 19:38:59 +0800 Sun Jian wrote:
>   *
>   * EXPECT_* and ASSERT_* are valid in a TEST() { } context.
>   */
> +#define KSELFTEST_PRIO_TEST_F  20000
> +#define KSELFTEST_PRIO_XFAIL   20001
> +
>  #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)

You inserted these defines between the kdoc for TEST_SIGNAL() and its
definition.

When you respin, two notes:
 - please wait 24h after the previous version before sending a new one,
   to allow people in all timezones to comment and avoid splintering
   the discussion
 - please start a new thread for each submission, and refer to the
   previous one with a link in the changelog:

 v2:
  - bla
  - bla
 v1: https://lore.kernel.org/20260224104434.14912-1-sun.jian.kdev@gmail.com
-- 
pw-bot: cr

