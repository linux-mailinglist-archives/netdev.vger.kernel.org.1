Return-Path: <netdev+bounces-277600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP14Ozl52WkzqAgAu9opvQ
	(envelope-from <netdev+bounces-277600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5D3DD35C
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 00:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83C803007239
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 22:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE4318ED7;
	Fri, 10 Apr 2026 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="eocndxLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574026FA5B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860018; cv=none; b=SRNHo0UEEgEI018sfuFXjAhGQTMNo0CjRD75WefSpkITkLTxlDzlYymTnq3477Fc1EkpzdttB0Z5OM8/KVpyXK/ax6bWL7dMK/BBTb3AFLoz9QW93YbomovzsiLbL0rQ3IHCsn7CGgGKXIBuZMZ7o+yzyOwUd2VUsf9sqhzRUm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860018; c=relaxed/simple;
	bh=4uZxXqXTtxFTKvyB8htIKdhYNiMzjhnwJlKtLbHBlyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEMPYj81U7UPfT+wNxhJWstGhH1ICgy8zdVSW2ww6dTj/oBQJfFqsEiQwWIQmo6j9hmxsjcUG7lY8wOkbL6UR1vmFZrRgfWDkveP+CpvIMZC7uEun0Jp9uxcYTR298C1saYDxDdy5XhmqBtCFGovDGINc+cIZERtVPmYWnmsRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=eocndxLl; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128b9b7e3edso1354469c88.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1775860016; x=1776464816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tdpns4J79CTSG20PPocMii+A9ltfsYSZSY7ojnImb2M=;
        b=eocndxLlYLmgWbRjT6q43/mDZujenfiF8GbIAeM6YzF0tkUMTjTKsfn9rGaxfMDaef
         B+kQVZmq9+yQEmYwMTunh3D7/a7vZULX/feZ0W1GNL+66tLpZMHKElE5Rz4elR+JR/bP
         Su4JPV7oXA+13R0cmY7voZUKgBP87f4oG7KXGDVK85LnH6d6dC52T/A9WjzeFOTJGAjo
         ZaReEbevgQhrIYx0rGayLOpjtmj9yxaQxRW5hDnhMpV7kTZii2rbXiusLyCOh/awfkR3
         R+E3U73KhDBgnJCgXD0KkPZt3coOgLAC+LkqmFGfgE+P3dlwedZ+CM0XYTD2pjtyucit
         8ejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860016; x=1776464816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdpns4J79CTSG20PPocMii+A9ltfsYSZSY7ojnImb2M=;
        b=mIo650SrmFahDHfMylJXs9+GLizEaTeoszeaGBs1h2UsREkG9bTTeE0aaD5aYd3E0x
         Nk3L6W/Dl30XFvII1h5XzaRZ/bE9peXk1g2TSvZAgsDOBD9tQ7HuiWac/TWFfrQnnqFH
         G3Pq+dkbwZQfwoBiYMUzxgNVFsIEYC98Z/MXfMXh9UaAwbFhcnSFJE9gXPu+OrCzineF
         7Ot/IGPNWrUBV/Ja551KEkIRPJ5R41H9Mut6AXt1nVw7ZS/KkHtvcOBmZ7au/5wwhTrW
         e++NNf18KfmgIKXL2BNoZJRJ/AZW7RLHKjFAGpVj336zMWx1EEf/UfPwZEGa1k15sNeo
         x8jw==
X-Forwarded-Encrypted: i=1; AJvYcCV8cTlYDd3pZ4d+qLU+SOajFrSZ7UXVk2A7xdf2fFeHxPt2xd7Fw6hSpvCPkwDMOiYEE0jovYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACO0h+qlxUp+xHW71KXiOTaVlucEIczZKqvQGhWTJGxukq5jU
	q7QKDJiZohR23h+8YORbug/sqPXJNaWpBvCuQtGbqMQx9L+LZE5SFbnDuVhzOcUXPSo=
X-Gm-Gg: AeBDies33WCoisRyxom1FSsKGQAgXIjlkdDmpUSxplAHEUdFyFxW3BsapTWKHcArJ8l
	nmHzAbIC9QyRTqwe00CoiI598g160GaEoxp8ROac6ZNbZZy/uIgVzCloNGQs7avJXbgfCTIXpU6
	qhJ0fY4fIEKxL6Knp2i4vyEMIskxJFW8PIAbvW/qq2J4mAQZrqysj1bdtyUD8xtwYGQQpL1f1iS
	B4IEh3LDr8xwvvQgB/9MoQnkmAjZbYsGuopMs/Ey0kea+BbgEE1o0KJnGpjLIFPFGv55aSg15Qp
	Cv9xp41Krej5r2p3MxHcnBayEPjtCJGOzqTTAGBfugchZrB07mdLD9/ihofIfuEz34Zo4pMP/Oy
	OzN9lvEk9kkTF3nFsJrtkzO249KUGI1jABHDu/TW8OZqA1OcugfWNqpjfPyJU1MgPF3vp2smJyS
	yJeNguL/pEbuM4NeCqRXUc0Ywx+Oz8zyNCX4sMBCJTpOoRZebb6LAbRRlKH2z+nB3fyPgpf6bpE
	D4Q3+XvJzrcnsBA0F/RSlLr
X-Received: by 2002:a05:7022:eac5:b0:128:d2b3:5df with SMTP id a92af1059eb24-12c34ecea05mr3008359c88.23.1775860016079;
        Fri, 10 Apr 2026 15:26:56 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::2:b03a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346eb314sm5052315c88.10.2026.04.10.15.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:26:55 -0700 (PDT)
Message-ID: <d3777e86-2859-491d-8071-77871df13c08@davidwei.uk>
Date: Fri, 10 Apr 2026 15:26:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] selftests: net: add rss_multiqueue test variant to
 iou-zcrx
To: Juanlu Herrero <juanlu@fastmail.com>, netdev@vger.kernel.org
References: <20260408163816.2760-1-juanlu@fastmail.com>
 <20260408163816.2760-6-juanlu@fastmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260408163816.2760-6-juanlu@fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277600-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7A5D3DD35C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-08 09:38, Juanlu Herrero wrote:
> Add multi-port support to the iou-zcrx test binary and a new
> rss_multiqueue Python test variant that exercises multi-queue zero-copy
> receive with per-port flow rule steering.
> 
> In multi-port mode, the server creates N listening sockets on
> consecutive ports (cfg_port, cfg_port+1, ...) and uses epoll to accept
> one connection per socket. Each client thread connects to its
> corresponding port. Per-port ntuple flow rules steer traffic to
> different NIC hardware queues, each with its own zcrx instance.
> 
> For single-thread mode (the default), behavior is unchanged: one socket
> on cfg_port, one thread, one queue.
> 
> Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> ---
>   .../selftests/drivers/net/hw/iou-zcrx.c       | 81 ++++++++++++++-----
>   .../selftests/drivers/net/hw/iou-zcrx.py      | 45 ++++++++++-
>   2 files changed, 104 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index 646682167bb0..1f33d7127185 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c

Please make all changes in iou-zcrx.c in a single patch. Then patch 5
only changes the Python selftest.

[...]
> @@ -397,12 +410,36 @@ static void run_server(void)
>   	if (cfg_dry_run)
>   		goto join;
>   
> +	epfd = epoll_create1(0);
> +	if (epfd < 0)
> +		error(1, 0, "epoll_create1()");
> +
>   	for (i = 0; i < cfg_num_threads; i++) {
> -		ctxs[i].connfd = accept(fd, NULL, NULL);
> -		if (ctxs[i].connfd < 0)
> -			error(1, 0, "accept()");
> +		ev.events = EPOLLIN;
> +		ev.data.u32 = i;
> +		if (epoll_ctl(epfd, EPOLL_CTL_ADD, fds[i], &ev) < 0)
> +			error(1, 0, "epoll_ctl()");
>   	}
>   
> +	accepted = 0;
> +	while (accepted < cfg_num_threads) {

You're using epoll here but it is still accepting a fixed nr of
connections. The server should be able to accept an arbitrary nr of
connections, dispatching them to the server worker threads.

Also with multiple queues, connections must be dispatched according to
their NAPI IDs to the correct server workers.

> +		nfds = epoll_wait(epfd, events, 64, 5000);
> +		if (nfds < 0)
> +			error(1, 0, "epoll_wait()");
> +		if (nfds == 0)
> +			error(1, 0, "epoll_wait() timeout");
> +
> +		for (i = 0; i < nfds; i++) {
> +			int idx = events[i].data.u32;
> +
> +			ctxs[idx].connfd = accept(fds[idx], NULL, NULL);
> +			if (ctxs[idx].connfd < 0)
> +				error(1, 0, "accept()");
> +			accepted++;
> +		}
> +	}
> +
> +	close(epfd);
>   	pthread_barrier_wait(&barrier);
>   
>   join:

