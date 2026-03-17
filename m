Return-Path: <netdev+bounces-268662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJDWJ6l3uWnQGQIAu9opvQ
	(envelope-from <netdev+bounces-268662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:47:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7472AD48C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C801A3019FDC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE8F271A7C;
	Tue, 17 Mar 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="GOKgP+4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58325221265
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762470; cv=none; b=Ar/2ih3RUnWD8KqY6s0nSsNC9opczXTtcb3VbbyQar+qUd3rjjVhUE27r5yp5r9nNlxweukV5K+5t863eK6Bbyc7GNR5t+R/QqxwZ7tFQuHG9VXKotIn+0dveGu/6oezHsJXC+SH/Y891cbGDFHEWwmbrFBMYP02a+eG8awCQ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762470; c=relaxed/simple;
	bh=IjrsCxwkBJOYLk4aZ6wtP5PCepQhlJsiDOrbtIUG05c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5lmD1NcZoDSiLTq6ZKeKRYmKNzZWsXBxqYAhlaZVUzx4BMkoGAIdo4Lp88hMEZ8w2T8TWkNkH8FJECLsy0nBz3D8wesRJETSIubQ/HKm7eeJ2KzRHlreKrN+jW3UDREgrlcj/6OOahPjhW5vDR9o7/O51EpDdWU3fUypUmmYWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=GOKgP+4a; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso18421455e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773762467; x=1774367267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWTbSNP2WHzhEIrAEAxvT9LPjTJQPOi5iCIjuQ8jmQA=;
        b=GOKgP+4ai/XEdjAJTPYrQiwtoq5enJR2T09vveK+WC3ytUZXf7Js1+gQd9Jooyu5qy
         evfqED7ehLPqEv3N9JPZk0Lt/Kxebs/7yIIJG5DpE5ALpKXMpzwnNrypXr0Pb7PSw7Qd
         09zQdJ92O+V0ohAaWJmr51azduIUtN2iVSyQ78DxPdIMRyWlbZGhpE46waxdxUtkPEIl
         cCZboJum1zu3Y62RGkiUihsU1rU+rdciTmoDbeERfPrXtRVdM+dgHtephzirAGRjab/l
         6nJEoDQgD1f71//RPzLBXAJJFFs4BSM+F5k5YoQyRqZgHC6BOXw++luyRbgml6aZkF6K
         EuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762467; x=1774367267;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWTbSNP2WHzhEIrAEAxvT9LPjTJQPOi5iCIjuQ8jmQA=;
        b=o8MwCbwaEm0HFjHLsw7tbAkVaUgyHnE1j+ZIjNnVjIdsbicE55QY3RHnY5fDAivYFl
         Y6MM5emJRGSipjY0XYa1x1LfMx7d4ToMRWvwWcnebGz+arenpISdXYA6LyYfS5WY1YbB
         b7ul+aSC7xhnzY99cBqs4/C/N4QEcwIW4s/08fETrjun7g0vpqhK0r7j4mWGfYHGRzKV
         I1hIIHm6AxIG/Y4DZV9xx2ZjfDt0k56WePjHDI3R706mLj5s7IwfkpgsYt14w5rKBy1p
         Yj8XP+h4GuO75chVcu/VnVZObHwPnb8R25ygf5arUjkefGi3EPFvkNmYOYkNIXUH8WUz
         r8sw==
X-Forwarded-Encrypted: i=1; AJvYcCVMy2z66MweRf76ttU/A+9AjpHXcWm9mSn8CaxcLjc0HgC4jIPS8iKvHda1gqwRT/4cunqOzU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPmrMvlKYTWUexPP6p5/Ozw1aRXPOJ0JQTCtWoC+sTRsg+3aZ
	1dayf7XUlLij4dOCw70vKPHkuRf5kUTFsLgeOkEM3M2X6v0yWL3FMgS8+ZB3EHZDCAA=
X-Gm-Gg: ATEYQzwaZ+fND2zbKYLJ2SEI3ylcL01+CCtR1DzRM/vpLRncMdup2I1vv4R1uZxnSSP
	oEBRe1liMpujFRqvKNR3nC5tXFMuohwB1TJCbepL4MkEPyJTpAaGQbqcZ7bzvMErSO/VUqqdq5o
	vPIcm4hcu7amWAWIHCWfMPvfmAvcLly+abtT882vInkvqaavF0lzxlipOXcNYiza2DIYMVqAEqm
	XThh6vNi4b1K3ERcD8ffJ9mSVwyHLXELHkzffdeIsin0RXAumrKMFlWLO1FAxBxh+mZP7qowL4y
	4KCPsUlj4kh8nbRxrlaALkRHFcKo8bVMDNyk4lr5MmFauXZatAuMUWQk3arYHZYD49TqksYZ7OI
	X4HaILh2nMFfcn8amBMjQxV6sjpGVM/uPJq2toIEiGKHpydUpTIYn9+5XR0P2yPxOyIa9W76qXG
	/Pm6kVdcz78Z3rF7kakp7eR4PAoApolfSDc3hpebrtLYgNhcecOsLbmPthn9uSDaWBB6gYVf9Aw
	NVpTy7Wn5lwIxk=
X-Received: by 2002:a05:600c:8483:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-486f4430051mr276845e9.15.1773762466590;
        Tue, 17 Mar 2026 08:47:46 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm132412305e9.1.2026.03.17.08.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:47:45 -0700 (PDT)
Message-ID: <085c9532-5440-4879-bcde-4d70c980c839@linbit.com>
Date: Tue, 17 Mar 2026 16:47:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] genetlink: add multi-version family support for
 protocol negotiation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
 <20260316113736.1085a124@kernel.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260316113736.1085a124@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-268662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linbit-com.20230601.gappssmtp.com:dkim,linbit.com:mid]
X-Rspamd-Queue-Id: 1D7472AD48C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 16.03.26 um 19:37 schrieb Jakub Kicinski:
> What's the delta between the families? Do you have any examples of 
> the the version ends up being used?

The main difference between DRBD 8 and 9 in general is that 8 only
replicates to a single peer, while 9 has support for multiple peers.
This also introduces major changes in the genl family. For example, the
"connect" command works completely differently between the v1 and v2
families.
In v1, it takes all the net_conf parameters and immediately sets up the
connection.
In v2, you need a new_peer / new_path command first; the net_conf is
passed to new_peer in this case. The connect command then only
"activates" the connection.
So the semantics are completely different.

Other commands (like "state_info") were removed entirely and split up
into different commands.

The specific exact diff is available as part of our prototype DRBD 9
branch (included in linux-next):
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/diff/include/linux/drbd_genl.h?id=11b8887a3efae2868037f2bd8dbbc68a8591f66c

As for the usage: the plan is for drbd to register its family with
min_version=1, max_version=2. Then we would dispatch the v2 commands
normally, and the v1 commands through a thin compat layer.
In the in-tree DRBD, the version is currently unused. In the (still
out-of-tree) DRBD 9 though, we do check that the version is what we expect:
https://github.com/LINBIT/drbd/blob/master/drbd/drbd_nl.c#L426

This would be replaced by the mentioned compat dispatch logic once we
have in-kernel infrastructure for supporting multiple versions.

Best Regards,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage


