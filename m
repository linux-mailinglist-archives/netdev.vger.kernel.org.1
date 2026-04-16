Return-Path: <netdev+bounces-278929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CXfFmp24GkfhQAAu9opvQ
	(envelope-from <netdev+bounces-278929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEC340A69C
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955113036764
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00138378D93;
	Thu, 16 Apr 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyAxBYNG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D70378D85
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776317956; cv=none; b=L26+AkfjP2SvakUCK3k8JyTZ4SmI1znraOPYuuB6B+9ln47Yqfq4KpwOJqbYbnk2HmW8JXV9M0AgZ+/fILePKg6hH/FT9bN4DueuXQfM16Vw8/1O93TAw0cZyyijPQgPo5YNSldNXPexAVSBdC9NRR02Gu9Kk/2S33U9MWTCzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776317956; c=relaxed/simple;
	bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=RJj9HEFnR0LHZYTOZNJ/rbpaNkEII+STRro8yKdndYiJEoq55D7wIp11fDTNccZlbYuobQ+MQ9eygPLI45G7h0c3JKGm1NwmG2ud/syUk6sXy4/MB8cLnebUgL2IEVwGrZsOvsdLF9xPZZhLpIWoc1oNK3ceiCvBxVnbAGRJ5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyAxBYNG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50bbc41677dso103043851cf.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776317955; x=1776922755; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
        b=gyAxBYNGO0944S9MKltImXjBJfUVrj2z22Kf4X/6PQ8oRHX98V+ApLFx7XHh7HrUaN
         lRooy+ms32oAXcHmeDQuZGdHdaQkyLiSGiR5L5hAjAMXcvTmTAZbCuuZjKkej0z477id
         1Zwb4gNFbX144sCb1LlNdpJHMQ9Y2kNsKQ/TOfaDRZEojYqBI6Jsj762nfPelHKWA/EF
         hxBVECjqr3whsNf969/qvCXdGng0azx64lcs0RuOAxXGBLcPSozryAq6JuU6NoLfZaPN
         qmpQWEZNh45nKABKnF2QdP9g4duwk6J0K0+YDLnf2FWqI6FiivS6lC71pse9QL3+Pi+E
         fDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776317955; x=1776922755;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0T590H9heaCHgH2KW+HuYix7auOVSrFYd7ngm6UIiY=;
        b=rxdw3W4TyBVw9ncdjOVLsaeJEpQq38DxNH2sErOgvsqj+Y3qnJbEpoL7yTRUWqbmVk
         huwetkNe7YkbT/5ShaOiUodPIh6/7nv3keauvEXOc0NPp3b31XL+eciQCFL9xEDC9rHY
         Tqccl2y4iV1fAmVgrbnLgmuAB2+XTl4/lAHLESl74JhZytzqjplC3DiSnjLs8VibZby0
         U1YEUCNR01psEJKkuU3hcyo3iy8pDhTKEKMj5BrbXOfSQrdwQayrb3dmV1MKH71dk+8F
         EGijqd8Q+GWQWxP37TU9ijVb8gpS/kpfNk/tsynv+IfPI8NvC5t26ypeR9dbajCyWLMr
         qYpQ==
X-Gm-Message-State: AOJu0Yymw5nzrofJF5cX02BTqg+1qfNd8jwuMyYAF8r632ECtf45Wj4D
	tXueB58dtMtX0L6Z+SfWmJGCx2lHdA1y4tohosL976caDN0odTqM8RPg
X-Gm-Gg: AeBDiesr0mApiu1dkqdSstbfpBLBO7jIvaVrIZBmwQsO1N99nPkSsmDsmaboMh14RXQ
	bUOxdVSHgP/OShPjLDMeni3F9Erw93+6x5c+9rHESngtWutWdTDT8gjPcCuULRd7+kukS+DMDBC
	q7gas8jiiXd6YiWM5nNq3BKxpgxkUBfNQvX6kykJVLTTdZSrf9gWEDu3nY43SAxVwN15UOEPTEW
	3GyN09oPPQ+fOy/bVkDiKdbiWuSY1Y6tx6J+tTzkaCKN7wZV+rNOcZBfvIeCBCYgfqVJ+7PCJio
	JyR1kqC6HAA3AyKJAWmiMueLP1JbjQGJtYowJh1EOWG8sCP74aqtRDApz+qabTNVWVqptUu0SC5
	14Lmbr/xo76gNpx5cW5fw7n30WK5TqF9neh1Y/aZZ43vwNY6PMvzMpI+HrlFv+7lbl0chUrqL52
	I/F3Y4pwu3bsQyQw/nf5hHXVUfQ/RFFIGj//5rQR3Oahgli19VfqHj+LeRFfrMBOEKmCI4GA9Ox
	eY5+1Ivig==
X-Received: by 2002:a05:622a:1493:b0:509:68c:634d with SMTP id d75a77b69052e-50dd5b95a14mr387417291cf.10.1776317954583;
        Wed, 15 Apr 2026 22:39:14 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1afc597fsm30185571cf.24.2026.04.15.22.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:39:13 -0700 (PDT)
Message-ID: <69e07601.c80a0220.2f9024.1e0b@mx.google.com>
Date: Wed, 15 Apr 2026 22:39:13 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] ax25: fix OOB read after address header strip in ax25_rcv()
In-Reply-To: <20260415085921.757b48a0@pumpkin>
References: <20260415063654.3831353-1-ashutoshdesai993@gmail.com> <20260415085921.757b48a0@pumpkin>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278929-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FEC340A69C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 08:59:21 +0100, David Laight wrote:
> Is it just worth linearising the skb on entry to all this code?

Thanks for the feedback, David.

skb_linearize() on entry is a nice idea for simplifying sanity checks
overall, but it wouldn't fix this particular bug on its own - the issue
is skb->len dropping to zero after skb_pull(), not non-linear data. We'd
still need a length check regardless. pskb_may_pull(skb, 2) handles both
in one call.

That said, linearizing on entry to ax25_rcv() as a cleanup to simplify
future checks sounds worthwhile - happy to send that as a separate
net-next patch.

