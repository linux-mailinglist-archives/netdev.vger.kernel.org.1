Return-Path: <netdev+bounces-290348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD1XGjjlDmopDAYAu9opvQ
	(envelope-from <netdev+bounces-290348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:58:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D019A5A3ADB
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 340F1300492A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303173B1EF9;
	Thu, 21 May 2026 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aQqOxkaF"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC51E0E14
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361078; cv=none; b=NZI6NdjYIyikVXtNoPJdztrMkfnWv4NaHqOfvtpSocy7+EvKB/SPeavyV6t+sBFQGvuipTZuFqE0gboo1+zTC3q620M51hw5HknaN5yKg7ZLMXWTwUCf+rDnyYjXf0qk5yZr9KwUGwfIQ/uO1H3nhR9sl8dIshqdrmQ1YdhuEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361078; c=relaxed/simple;
	bh=fh+GUaxsgqLWS6ryQDsMxL9t3QlgJryYzSiMvwNgTI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAMOJk51dDM3oyVJXnbfwVaskAOVkQfEeg8lR2byr508V8op+rQhjwHC0kyNBrm85qbEd8PBWDvleeeFGRNTB8KN9fIScnXFieSnA4a6vO/5bXMztcpPXGnYEB5eWVMBzWsiYnIF5Lz6x0Uujd22AQMnLuKhiyxtIngWUZ/eTlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aQqOxkaF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5978f34d-dbcf-4196-8a95-13165a5ba034@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779361074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZNzMc5nC0pYCsQzpVY1yiRB0QD6dbT5pt1SyEwFs/A=;
	b=aQqOxkaFXfvIEAVrIYSsLChxrwpQV7FLwVjCI3ThPHXtIpCXTsS+coildE7bmWv3UGDE3I
	uHZXu0mEitZxahUuHQ7LiUKrXrqMSw33j9CoKAtUW3wezCxBvKGGJfiwZeUnIEJIqyJCNp
	yccULdsT72cxXKcuHCcf+pr2hsXudWk=
Date: Thu, 21 May 2026 18:57:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests: tls: use ASSERT_GE in test_mutliproc
To: Geliang Tang <geliang@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <0ee9f412b6bd1a260a547d19f979f73b396746ac.1779354585.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290348-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D019A5A3ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/21/26 5:11 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> In test_mutliproc(), when send() or recv() returns an error (e.g.,
> -1), the test continues to execute the remaining code and fails
> repeatedly due to using EXPECT_GE.
>
> For example, if a TLS connection is broken and recv() returns -1,
> EXPECT_GE(res, 0) records a failure but does not stop the test.
> The test then proceeds with left -= res (where res = -1), causing
> left to increase unexpectedly, and the loop continues indefinitely.
>
> This results in a massive number of identical failure messages:
>
>   # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
>   # tls.c:1686:mutliproc_sendpage_writers:Expected res (-1) >= 0 (0)
>   ... (hundreds of identical failures)

I think it’s worth backporting, so a Fixes tag is necessary.


> Fix this by replacing EXPECT_GE with ASSERT_GE. When send() or recv()
> fails, ASSERT_GE immediately aborts the current test, preventing
> the subsequent undefined behavior and endless failure messages.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/net/tls.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 30a236b8e9f7..9b9a3cb2700d 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -1549,7 +1549,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
>   			res = recv(self->cfd, rb,
>   				   left > sizeof(rb) ? sizeof(rb) : left, 0);
>   
> -			EXPECT_GE(res, 0);
> +			ASSERT_GE(res, 0);
>   			left -= res;
>   		}
>   	} else {
> @@ -1566,7 +1566,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
>   				res = send(self->fd, buf,
>   					   left > file_sz ? file_sz : left, 0);
>   
> -			EXPECT_GE(res, 0);
> +			ASSERT_GE(res, 0);
>   			left -= res;
>   		}
>   	}

