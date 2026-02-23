Return-Path: <netdev+bounces-260167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IdRMj6knGnqJgQAu9opvQ
	(envelope-from <netdev+bounces-260167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2117BF72
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3645530379B1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B447C36998A;
	Mon, 23 Feb 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icdj5tdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EB2BD5B4
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873332; cv=pass; b=UhhXp6NuRjwRFYsjql0zE/SSdWC/WWJPo0QwStsdurUOs+0fsiI8bukqwAxlkPl0KSityyMeWiSrukZnPKA2L8KRkWNn27dQdlbJx0SFJ+b3uLVCMfSC2MbfqUbPW4TC86kSvB6tVWAMppS3aUFwrlf+sKUEHEAoUQIwL8H4T1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873332; c=relaxed/simple;
	bh=PQtU11o/pVllcRjEGRMTRHv52zEbmbFwhyOmug1c8+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDSAQ05syyGCeArDYFJOmDOKItPKNsresjVVIyn7W/CJ6WSgkPGgZyiZYffTm8NgApzdHagab8wo3szVmyJso9KNeuc8M/Wing8B8+5EctQzu341Qno4ZQjXiXywTeIEMA2UfNxapIX9RFES3i7+awAAJAjdv8wB+djzjd+cgAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icdj5tdq; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124a635476fso4334543c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 11:02:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771873330; cv=none;
        d=google.com; s=arc-20240605;
        b=irYJ0lK2GkcoM29fh9FBY0nMhIydxe+U/E2XsLkeugo00UXc+4yOuVwGyIUqtKtUxp
         xXO+aTiEArjs7vN6vCjNIRF92pRWgzEkRnYJWiGpT8ktreg8RHJrWov0fBVggG5+O2pD
         i9j8jTGGfUqw3B8rUMbsAcBN4N/5W5yVBUTl5lSNbE+L5ZojmIpcTHmymur3X1JfRjnY
         h0JAmem0kYg09nTuH2gCWzOq5BvVMHNGOv1w06/ctLmY6xVKf+fowsYgB+l3TN32AcZO
         YrmvO2VO7kr+2ROz+U5RCbB87LRLrrhNChw7SiFHKtCXK9iN9g3uZYBqBuQd+2ah621u
         UZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nKyvC/C1K2KJeIBpWBcQI9HX/uEjCBK0PcY6IGP/xRg=;
        fh=G6AUw4h4UFm0jGB7S32bHn5wTlZ4Rzqplg7Bf9fEF78=;
        b=SoG1Gu3j/cmampdFVdiBcpvrmUDwY5ia2YOZks8I075m7raYFgAecykLm9t1Aeyi2K
         UHwO0kUreHf/ougT/O++gS5q2MvQ6UkxfMOoPSr36E2pgmykeZRGspTYn50jbg64YMIM
         yCUBPrbOkmOmA5FUuA4yluXJYjs+nufkWcCECqYrLFtouxF+SDezliNgmBPhOw80jMC9
         ORWBy//oNp8kZO1MWmthXVHkeKbfIZUQB+Ku0qTM97M6PbMkSTgmmUZpkABIY170q/5s
         vOQ/vyJBKqgK5smi+w5Di7Wd0AD8K9JvR8GjW+mU+m+VprhLTCPC5DvM7SuPWaVCxfp+
         Qubw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771873330; x=1772478130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKyvC/C1K2KJeIBpWBcQI9HX/uEjCBK0PcY6IGP/xRg=;
        b=icdj5tdqP3BAPidXt+ioZ1ad7RiOg70tFKD/uHXgDRkwQvzAMY0Nd+WDf2xeMAz0U7
         t6t6r1TW6xuZEvJv7Y0UKR6vsATvqV2S7lCk8Bu0/RPgE+VaFyx7XE3qnyLErduCTI8N
         JfJKaqeVmPdCX9EAXIjh3rg4JFGvtoiXCSvoFDwshm6LvoTyA+bkaG7k2h1gcOZ4ziDO
         ydWdknDs4QGdqOg8rxWzB0MuW0TlNp42ojP+eohlEG1VF3fbr20QHwTsFlXOo6q2TM8T
         iUWLTZR4RCR2IoGWObYa/YbVJICNXOtC6CRxu2mytoshVmcJFiVceCCy41n15ACfKprT
         oKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771873330; x=1772478130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKyvC/C1K2KJeIBpWBcQI9HX/uEjCBK0PcY6IGP/xRg=;
        b=D8ALajU38TPRHNDS36Z9SyMODsAZ56nsgf8wCk4fBYYVgo3XMHqGQxvUDb0t2j0rOe
         S98A1PXb9ciTYHk+Gau5AY3KJPAq6bHDJPq6UqUqCE5WF5566+gwZP7SigClAmLRnXPn
         7f+bYmm9VEtdc0IbEFn55njMM0zt8i4BpXtSRyID3NhunwB7GsUeBZWz9f9Cm46M5yKl
         zjlD94I83VnTXG8D3HdaYY7IdY4P7dhHSpvRL9zcvhsp+b/jHzvlJhwkzEurnHDCPT4L
         j/aBdVlAIwdGPmXUop/+rkMBbp1raJ1NipXzfumnk1asAVhVtNk4J2G7D+Li57RIBvL3
         qROQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYlsHIHKPx18yuAgam1IMBm0I/lq3S6gLFunkiwF+9baavXgby16NydVLxkylnboaH7kg8IJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJz0SNyv0X4w0DMoFaXw7bQvOL8qM881XtCMNzKxjD0s82D59T
	4RKuXD9JHf/rmd9u6VZzB4sKioO93LnEfq4VkZ8JsYpwg88MGEsc5T6VkeZNTY81GLDginyLc+A
	5Ixa0kDiRw8+tv1CwWRsPM3W4HUBFMdBu1EFrC3y6
X-Gm-Gg: AZuq6aIrY2/xkXKJRcsoJIO1jzkd0ZwxlqpintEn0keGsd22LytmZ8xssUKmW1mZvHS
	BOMy6fgROuo1YWwFUNcP9DvyMEEbUz/Bpg7FPPkRnyEbVedhohK3g0gXOlZjDnnce1HvXwtueID
	HY7lakHQKOc9A0WIEA99nGPWK3hmOctd8jyk6awns/Rve6qOnTCEtVunT8L4qHKHA65Xjp7Zb5c
	RwAaSVjbebgL9AdnYpWKEIfqiIMqNtnU1MinZ0E/iPRRFnyGRMOUA63HGAmQxxvHDyPB4Hh1naG
	UtvuBwqWV538GuPqkzF4fEetgbgMY5MSyfhZnjDiE+0VZa3j1/nQ+ZnYxRRQq2edOtTElHBL
X-Received: by 2002:a05:7022:6199:b0:11b:9386:a387 with SMTP id
 a92af1059eb24-1276ad47c01mr4419946c88.42.1771873330047; Mon, 23 Feb 2026
 11:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223153342.892477-1-edumazet@google.com>
In-Reply-To: <20260223153342.892477-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 11:01:59 -0800
X-Gm-Features: AaiRm50Yv5Cc27eJbq-JV0c2BOHfXvQ5Z5HlpP7v6BnM8tRCwMW3f4kLhzg2I8U
Message-ID: <CAAVpQUDvNoxfNVY+4m8ZQL_rqij8BQCykk5m9P9cgo3mg8-pSA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260167-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BA2117BF72
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 7:33=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> can (auto)inline it from ip6_xmit().
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
> Function                                     old     new   delta
> ip6_xmit                                    1481    1528     +47
> Total: Before=3D25076476, After=3D25076523, chg +0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

