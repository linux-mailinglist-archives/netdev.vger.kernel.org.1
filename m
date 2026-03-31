Return-Path: <netdev+bounces-273532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHkC32Ny2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A73669D4
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8333081A8A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53663E5ED1;
	Tue, 31 Mar 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fM27D9v2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E4B3E95BF
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947171; cv=pass; b=MMszYgDt1veX5mHYnB5Z0+VIqnBTLFfr0bfFsbFvUjYz4aYGo6Mx5agzxe2AWsuKzqEv+pR763bgHSTC4ZPh/gC0V/LCybLp7lt+HiRRNohSpfpomTJtZwr1usjs9SxsVyZERJs+tgqUSvGzkQiCm0T1mIgH+ezrLyhNFyLCxuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947171; c=relaxed/simple;
	bh=HMzb593tFht3aK58XBG4Aj5ZSTTbPJrSBZv8E4FAh9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nye8lWJ+lLfmZPdHdLgleUOcW92BALeTcMPU4xynQh0kR3Pch1FPxUHjrNBSZ2AnsvXVwrEx2rVjBfgylpdUh4GCG0QfEVKNxoMrxIn6t9GHQba8mZZEXlmn3+zwghu9w4bkXIOSfjuRmQZW3RWR/q8Dh6IBDCnD/rfqTEhAQTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fM27D9v2; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfdac74050so718445885a.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947169; cv=none;
        d=google.com; s=arc-20240605;
        b=B8yhfwZqCsGH58zYRobdLpaf+5BGT5XkXJYTBWL5k+eTPyC/pYRe0KNBGUXRz55qgn
         zAp3doyhMWOao9L2IdrgzroiqBnWXHW7OQa3fHEew1M7eoA27m+Kvp1JYsenPiXYf823
         qvfULEbI2umZ7ZKoJR3XS9DeMP/SgmAjzLfLNRvQlNI+ydYLXCzDvLllOOMHbYiTtU65
         3PWd3rpLV0Ws5TNm08tDU2bCZ183xRyKHQ5Qt28sI4q1Vt8mdDo6PnwKbNqSnzSJFyvW
         tOQeuOjfzZ8SSrL9l0fiZ6UdsI6ilDsqiFIsWtsWtoFYG11BnppoxfKHv6nHIESmW2Yj
         ziKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HMzb593tFht3aK58XBG4Aj5ZSTTbPJrSBZv8E4FAh9Y=;
        fh=D+xndRA63Prc1AiEm6mlnxaTda1moqWDgeC1Y/bfZwg=;
        b=GtPbHpd3RmLwyYI4sDyeaOI9ihd2CfWEda1L52AmKIEJ/AKitU/MlpJstbviaiLKmQ
         h3qMTK9eOTQbJCGoWJx0jwNdYM18FAsDNgZwEcj7zbj4G3QcQbDSCaY4k0b41DPOIguw
         HQy54xWpoqFqSnJA6RopSCXAU7yEUc2CNCQOxf0jzRNzkzAoIRuTGHo2JYGZu4KNk0cb
         LNnDgo76mjjyeI+5mZoKnE242aVa8Zun+xHyWQ+6lXWHTarA01psXYakhoDRfouwPYXD
         qJ9fM4cxngO7fiwsvadJLGVYNHatvOlYKvz6cKoMM2OFV87lg9aigUFUKO4+GJuEKzCc
         JxaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774947169; x=1775551969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMzb593tFht3aK58XBG4Aj5ZSTTbPJrSBZv8E4FAh9Y=;
        b=fM27D9v2SlSeyKy+ZJBrOJLqaQ6jUv45UVgDGX5liaPLO0DHtr3bZ4JGHABM4mYHw7
         Th5oFWMH2Y6z0jqUn8ZZmTi44f//gWcZYrcoAzR2REYvbbPZ7wvjMZ0jIDwuFroKvs5m
         HqtSUh719kG+KqEcy6kcza7mpR0/n0LMkCsuhhBkUvSMWhUnxgRokwX2Rs//cCAgW8ZF
         ZFos1GU5rPzN364JJc3hmzbpmoEcgpGYeJuYqVSA6AgLCy5M9QaS/0XMz8HYmo7MxY+V
         mRtdtqNM2aX0xDA+Xd6E4qpmFL7xuy5/MFIVHeEcpRDwEi19q8A/HVNs+i6h3SVj3c54
         ZNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947169; x=1775551969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HMzb593tFht3aK58XBG4Aj5ZSTTbPJrSBZv8E4FAh9Y=;
        b=UZS+R97TXfjA1nrY0u9CIFR8QTIQu/B9QlSX3di+5e755UTi1IXII4Afb5PxCjW9ZB
         e+GIjUToOcUi8xxci/vVZUqwI2QRZN8zCtic1MBsz5ExBqvGfXlpUAm5aCArIDj0oGEM
         PfTUmSEe9oPUjxvqqSUuI2YG7qnkBhsy2ZGkQJwHM12z6gw2FQ/Rl3tDXViipbgzGA25
         9Tep4V1Pgd2h/DaBHUsUwmD6JdzyS0fJMBjmwRvInWVUSR8extwVcBGG9F1f+/iIRDuy
         Dm9JQwVAIkcT3bx+IT2v7P8bBkDpbfo09JzyPVcfZyBgu9Q1af4VmWVnc4XCkS1q+AQZ
         m9qg==
X-Forwarded-Encrypted: i=1; AJvYcCUeoX/1OToud2ARBhWqF9yJEI+7flMFPxj8+iK/U8p8VWx+F5oC48JSh29C/xz8fE/AP56hdg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9SNjM5nwRnunKYl3ApIRwPxyfDmTNcTUpsHtwVf8AI4bQSqS
	7GQQ83hXfoNB86B6fURyUVi0mOGLmInY0E7uN+sVFyGiCIB5ynvT6zOPs8yeX9N/ewAbUzXpNkv
	c3+YPn/QsM+5uA3ME4CxisTOGO3NIB+MEAF5YYh07
X-Gm-Gg: ATEYQzzrJivnptcw4ORkfFJuFp3RVGbtzOcS1ZNGhCucC4o9KVgvinMlvAZa870SBkL
	NLQeQHKIchfyq8dyBGP4o7imUYiTzyyCRHm3soLQ1mmrvKiRRBlUETG4Re9JPZkMfPG1WSbqNuG
	FVMTXPr5EpnaOUUWpoyBybIajTtuTxvnv4TJ9ZBkH61lsuzKfMI9kgv0rgtCDIvnHcBBEAR4+Jb
	McdqMOrsiqQ1qsD5ba75SEE0qEugAkNP9fa8yE3aSlh9fcrEvREP4RFItkymmMTyXDE1UOiuk+s
	gKU8M5X15Wd5tF26
X-Received: by 2002:ac8:5906:0:b0:50b:41ff:e9d2 with SMTP id
 d75a77b69052e-50ba384f772mr213911251cf.21.1774947168552; Tue, 31 Mar 2026
 01:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774855883.git.zcliangcn@gmail.com> <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
In-Reply-To: <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 01:52:37 -0700
X-Gm-Features: AQROBzAUJW0CX5_lJi9MVCZ56vOTpJzFKOOWqcQOD8HBR7t1T83p5FIK2-NVoCo
Message-ID: <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: security@kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	afaerber@suse.de, mani@kernel.org, yoshfuji@linux-ipv6.org, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com, 
	bird@lzu.edu.cn, enjou1224z@gmail.com, zcliangcn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[lzu.edu.cn:query timed out];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-273532-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,gmail.com,lzu.edu.cn];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 145A73669D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 1:34=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhengchuan Liang <zcliangcn@gmail.com>
>
> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
> RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
> is present.

Some points :

Please do not CC security@ if you submit a public patch, there is
absolutely no reason for it.

Please do not resend the same version within 24 hours; this creates noise.
Your patch wasn't lost; we have many patch reviews and similar bugs to addr=
ess.

Thank you.

