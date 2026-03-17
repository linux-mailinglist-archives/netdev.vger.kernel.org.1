Return-Path: <netdev+bounces-268859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPn0CxoYumnyRQIAu9opvQ
	(envelope-from <netdev+bounces-268859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:12:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E3B2B56C2
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D991303099B
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25029B8CF;
	Wed, 18 Mar 2026 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="BvNRRQAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8140129D288
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 03:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803541; cv=none; b=u4a/tcNp2Ii15pgPnSilN17XFPFJyblqcr1vZ5y4RPYryp5BFjh/FrSEwsV8sW5VMYNBDGl8dEaellQKruRbkvdK3GTC55umdgt4WtozuUmdG9x8nK6NFl9asLqhMyVOG1Yp2lqzNDjMj13qQcQEG3lOVdFJ5v0D4Ejg3SyWeo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803541; c=relaxed/simple;
	bh=3pUDkXCIbbQSzBElrtyiHqwHZfJM/t5oVW8R2mOuWGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGIqc5Ljf6+AtXcTx+n/dUZXpeKkOUKQ3/39uvgsFxA7eJLPyLzECgcsVFtpUpGvXiangitmI+TMfwWsT5im7T0a6Az4SvTSqcLMQdJZiFVmuuWh550JsFCSKJUtEJWhAP4+Ku6u5OYacZFb2Ljs4vogBHn6h4CBSsn2y+4rPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=BvNRRQAt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a9296b3926so52292865ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773803540; x=1774408340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmt9Nb6iGmPmgCfMpxJvJLPWltN9srw4zOG8bLYlkhs=;
        b=BvNRRQAt3QXoRw3bnVNLwnhaGq3yRtgIMpi6CdToEADtOpyTfq/NpfFY6xKQE5TVO+
         S44C5aq/TXR/QTrnvVTrgxwdmIkoqxiyncN0dII4wOrNDNyjlZD3Z528ksXmzmjoEpzc
         5kpDtnZ3oIP9fpEdY0bIpUm+9UxUeblxOhwymKOQ+clyQ6w4hbTamIF4LF5fKtdQmq8P
         zWt4VJ6InV3kfTjZlrk+ZAq6yhCN4Ydcjnrl7QKPC8lkr7vEogMgxBXbU4a4H/mZxR92
         Z5aCBNo7HP6iCBI0DDeNlRc4YFTBXVlmit3XnicbR+vB+vVh66pBJNp8sAVsUW9xdkzV
         h+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773803540; x=1774408340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmt9Nb6iGmPmgCfMpxJvJLPWltN9srw4zOG8bLYlkhs=;
        b=HQ/KzfG3bwAGurMRlMwzVWQAFN6DKEV6JbovdXBvwystHReFcvuH47J1is1erQNbRi
         DWe4WGux7clzMcVQ5zAV4jNratQ6sNakrNNePYnm8PCWk6v0yc/5xwqQ52w8IvW3DMDN
         5RxX9RMiH7xl86r/5wdaPOQMi9U4arKKfooJRCzI7FvdT3VGJykkDYp0ZtY4GlFE268P
         Qec4pSlTwf/03YKCvxgYrQNvht7/aQvDjHq8WhnmSIU0IZ0fMSEOODkozJuwQNfMUg1/
         u8Mhjywsa0UCxlhUKY4aBDZCXbcTdWFp2o8U/2FwmypBLbsyW0d9poXJ08TLLqUlRHy8
         Q4Ag==
X-Gm-Message-State: AOJu0YzLQeO1QgrJu1eZ8FNMm1XFdmC9XLMU1dWh/rpalUpxqWWhkTth
	9qW7TXC0rUXHWsDMQEOGJ09h3/rN0SzF8XHzHnCnM0Nqx9faVhGyDF0eniREAzbaDqg=
X-Gm-Gg: ATEYQzwbUWZlQsv0GCMo9MPf9JxkSOxemBVSES8UTpxyIKJVnOPQWbHaFx8TWXOn72R
	8vDXqF+TIuQdog6fQaOqfxQXb16X0R7iXxMDonCVrVN6xtiEAg5awgm4J5DBT/KjZBKQ9DpBPsz
	GfF2hHHAMv0G4qXtKmpkjWq5QWkr+G+egFOK17mvYod5k1TWVXnaJN8Cg2kRQ1G2z1X7rpDW2/b
	tUxK/NPLVf/d7m0kkR/h6eQCJSQJN0mytvsAYKsI+RrE94qVifKJKznED/LcfGZpA/vvGm3hWyo
	m4a+/vPzvQQWUxVlh6WlTsYcWGEgf4A/7vjOWtVB7JwDEFS0d/jhy8grQzLBjZG6Qpf7LYQqaXi
	tmnfTGrI7nFf5s3J1mttCcQYJ7gcRo58qpCRPhpKbGEBgRld26iHh6AJkfZkE80bsbre7MS9CRK
	4soF72J7Ftd7h7x9lnIEBUZpurN+ckvW0x3qJlxpe1y+UG/q2pByxE4+zOjw2OWnBZugbRq+/b5
	BP3T60GxPHZnmpLq7L+sQ==
X-Received: by 2002:a17:903:3bac:b0:2b0:4b3a:9b4b with SMTP id d9443c01a7336-2b06e34dfd3mr18296765ad.16.1773803539771;
        Tue, 17 Mar 2026 20:12:19 -0700 (PDT)
Received: from stephen-xps.local (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0704ccc67sm3889565ad.15.2026.03.17.20.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 20:12:19 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:58:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu,
 pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com,
 toke@toke.dk, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 6/6] selftests/tc-testing: Add netem/mirred test
 cases exercising loops
Message-ID: <20260316175801.3a1546b7@stephen-xps.local>
In-Reply-To: <20260316211052.332383-7-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
	<20260316211052.332383-7-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268859-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72E3B2B56C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:10:52 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> - Test netem's recursive duplicate
> 
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
>  .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  33 +-

Please split mirred and netem into separate commits.

