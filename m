Return-Path: <netdev+bounces-277058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GFpNu/M12mrTAgAu9opvQ
	(envelope-from <netdev+bounces-277058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAFC3CD40F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8320307BBEF
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A5D3BAD93;
	Thu,  9 Apr 2026 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="dF23tueO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F93DE44C
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749876; cv=none; b=XhMiF3v4N1uxeyTM6pNE3cWbr/H3yYLX3Znnk5ZVmYQnjqXSUsgn1jxlBc+9tV8UdlKP72Tt+8ThHetYDEN6D9i7STWEk7FVLH9LDStTwKr/uLRulh4Avv+L2Hh66tTGod8uIj6Qhcq/zFZJCCp2MpbUr6ROgbwf08xjQGy7cbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749876; c=relaxed/simple;
	bh=mmJ06jy2TRAp9JHZtaaPZH8WfhjCq9loxOBon8M6vkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FHoDVDZCRmYp265+/Ewrf7HN8wiwk6vRYrvaFwXPgstrzXNQ3+abBWgvazouE3l+rI71/emJqBeuXDZoXkNJmWbaAoOK/7MbB4UZbDxgs9ovJqn9aiJrV8xDsyJtEPEOt58qSYjuN8dgJ9nBH4BAjA5VD4KfSWP1etsFqIgieKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=dF23tueO; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-126ea4b77adso8868022c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1775749873; x=1776354673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7WsOe+EtDka5xrwHY8lzBfWh7cNZdwWw52ogv0Oxzc=;
        b=dF23tueOID13zmpYbWd3K3IUQ1qljkVr7cwhBPd72Ix5XS0gCV+xVt/jVJNKM96vEg
         cCzc4fLRdzoU2USsy6M8gArmtcmte6BTtMTT9QkESrflJfrUme1y4BEK7L//35mDrRq5
         2+QhMGRNQSyVpiajvz33G6WeYOWk+yjQQE7CSYfW23bCdXxLruavBBe7rDfrHJtgoHlV
         bK7MMQ9ZBEwMGGlnbljEVdwCxj6/y7HVJQ16e1KmWQM0BmrGowRRfZIn7E3bUew6Xu3b
         N3cm/g1iiqka+Hicuzx9YumcphM7yA8gdzbeaO/Wi1XfZuWzDlYF69EUxcXIg/K0MNfG
         nSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749873; x=1776354673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7WsOe+EtDka5xrwHY8lzBfWh7cNZdwWw52ogv0Oxzc=;
        b=au+9UKlT4rEbjZ2bQzRWYWjLudGwNVDQYxSpcjErDyZeeVYFko2GtVsx0csDglRhAM
         zcTzI1aAyuOBONdSfzF9XEbyMsTHYxwddV6HqhY9DZJNXX7PP6wS89NPLv+/v2ItI8ME
         SR1JrsB9+iKHqFKEq3rOYSKZHzyoUXsj7ll9V9Fv75ySdyNGS7OVV08VTBoPQMg0RtCs
         BeYg5VspRT/VcpsZOnGKRjqqNl0FlY3sSadmPM8D+Rnrxz6neX7ByFNwc3uLzOHvGjs9
         ClZ5WWyn4yC9pE27ZHf7DJCln1jUMuj4Mo/nT/CGQFtxRJ/syMH8W1S+7REOHKkKC4Wo
         wJxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3g06bzrIcYWZlpJre6jRFKib5dFjj+QGgyE6W704nC5YICerUbGQ3l7Fun/H1zbr4OKiLlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOJYzl7/VyPObjEgv0V69qqU694q5QfqHSDj99Ww9jRVU7V9Z
	3nmohdR51wJzL5tkBEFmv0Jq/oD8LF4kBGEx+s4X/dfbZW6qrlVf+Wr7uiUfzCdrsMrhSUb1rAa
	TyLwY
X-Gm-Gg: AeBDieva1c1vrgarkxX0+a5gD5BG38MzY+JvUdCOBfss2hbN/jGXuwlud7cs8VPOnYR
	DOJz93U4YrwTceep1AA1VtkZaQSB2ZixQbAU0K4hqzLxXZtjW+1mnuD+ccvCXnhv3mK/oNv1VgY
	pnixoqNBtoLwzGGCPkcvhO7QfRuRhQHkSm2BqriRf/ExKZ0z8URja92nBOSmx70yagFkHrE+oXC
	yeqZbuQ13Hm6xP9JID3nQJVpAryIa7F/z4+EYaqsJK/cJtj9PIxb+YYz+DZAy3oPOMyaxfvDNHl
	xl3AYhjh/ehAheHrIna/5qHM8yFZpsnQMjxvm7iFxsr+J+AlC/BG85aolhKDRXdU8AvctfJIxFr
	QKgRGSP09G928bsBDZMGqMCeLdotPrVdVfT6RkPr4Qp3uU6ZCrtavyGAhEVhrfIRGAai66/zhpP
	hS0ayQvnUqtYfbW+X2z5XDyZr+r2JKRqhZsPFTUYC9Q2FZCqnaFgy0UhIwTTUWKFtwyyWJInR6t
	bAqUaWkTBOeo7RkpaiM7cmZ
X-Received: by 2002:a05:7022:62aa:b0:127:3f2a:af21 with SMTP id a92af1059eb24-12bfb70eae1mr12688196c88.15.1775749873001;
        Thu, 09 Apr 2026 08:51:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::3:da93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm12556215c88.13.2026.04.09.08.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:51:12 -0700 (PDT)
Message-ID: <8fa08d73-28a3-4521-bcfb-ec81869c24f3@davidwei.uk>
Date: Thu, 9 Apr 2026 08:51:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] selftests: net: add multithread client support to
 iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
References: <20260408163816.2760-1-juanlu@fastmail.com>
 <20260408163816.2760-3-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260408163816.2760-3-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[fastmail.com,vger.kernel.org];
	DMARC_NA(0.00)[davidwei.uk];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei-uk.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BAFC3CD40F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-08 09:38, Juanlu Herrero wrote:
> Add pthreads to the iou-zcrx client so that multiple connections can be
> established simultaneously. Each client thread connects to the server
> and sends its payload independently.
> 
> Introduce struct thread_ctx and the -t option to control the number of
> threads (default 1), preserving backwards compatibility with existing
> tests.
> 
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  2 +-
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 46 +++++++++++++++++--
>   2 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index deeca3f8d080..227adfec706c 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -80,5 +80,5 @@ include ../../../net/ynl.mk
>   include ../../../net/bpf.mk
>   
>   ifeq ($(HAS_IOURING_ZCRX),y)
> -$(OUTPUT)/iou-zcrx: LDLIBS += -luring
> +$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
>   endif
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 334985083f61..de2eea78a5b6 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -4,6 +4,7 @@
>   #include <error.h>
>   #include <fcntl.h>
>   #include <limits.h>
> +#include <pthread.h>
>   #include <stdbool.h>
>   #include <stdint.h>
>   #include <stdio.h>
> @@ -85,8 +86,14 @@ static int cfg_send_size = SEND_SIZE;
>   static struct sockaddr_in6 cfg_addr;
>   static unsigned int cfg_rx_buf_len;
>   static bool cfg_dry_run;
> +static int cfg_num_threads = 1;
>   
>   static char *payload;
> +
> +struct thread_ctx {
> +	int			thread_id;

This is set here and in patch 4 but I don't see it being used.

