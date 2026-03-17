Return-Path: <netdev+bounces-268367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJSyFfimuGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:57:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932C22A2624
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A1A303309A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138F8221FB1;
	Tue, 17 Mar 2026 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PpWd/Z1P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F321C160
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708931; cv=none; b=DL6hfsrHsyn0ojYKC9bfMHhGNnmqU2tvOX6EMWOLOkkt+ZUTsqFtD5Ykq4RXsV2fGNXLKXODirjR9kqBwR4YQOaiN9dpZPJ+tpkQdLOJVAh59Ndxn08JmCAmbIjljsp9OPbe8bSHmanqWVXVCHBkOxm3BB4AFRbTKpLJgEqdWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708931; c=relaxed/simple;
	bh=fKItGyuXH2mFbACzPqtA0yQGZq5TH0CL/xP4z5Jd+u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hd5XjYB/L5ETIFkJ2l/6qP5MKvOuvWTevUxlpq77gEbdR1HwD+ClGp6fqYNX+XmqFHJVHBaiXH86NHUsAl7WAVSweFVKwsPS8tU3vzIacDthRSf1PVdlyGqAVM8pGK0NFU9jO1L99W9TKrrhjWswD5LR+sx/iiCpD8tMKc1SV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PpWd/Z1P; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35b98def50bso1312413a91.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 17:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773708929; x=1774313729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsLpt8lcv5WQpxHKp0h6sX5BtmKvbqo1zBFdOaFwJSI=;
        b=PpWd/Z1PQvR+yJhO4LtN7JbmTlQtrNznC7TOSsdaw0bUDzQ49Q6fK2yqTaTZ4pkey1
         CcH00FKZFXCVz27y9OgnMLzUWruZ826XkG2cz/oYi2T96dOijKeQTPPgnWs/AYSUkxA4
         aqSMQXQNnB1y0pYlE+y5RPny70DTlvPJIKHm6ECc9VT8wmIytCTUD/s1yELUeyUVx0Yx
         siU2V2zH5Si4dKBtcy8uAmRA7pk4xyNnl7pBWYVQqOo+hzK0EJ1+dy/uzKIkpds3RVQJ
         qhr7LbpnXzbmhThXTRsE/K0v8lySuMLg68fDcVexICt7z8PHscMRkQKfdylVTpTNt0Zr
         96WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773708929; x=1774313729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gsLpt8lcv5WQpxHKp0h6sX5BtmKvbqo1zBFdOaFwJSI=;
        b=nRG+Rvhadq9uicEXVjbtJzB6qzgy6YLXJrxXzVHqz75sBKZiCDGWKOsGaJxwUQP0hg
         Bs+iMOnbgVwuabG324jz+dp3th0ZUY0ndLEDSRbYHx9Sv1G2T15mCVxlDUBje7ctLP1F
         ybxZYysIndIrzRrlK1ma7YptzwuNPeebkvlTkcH2xcdefzlEpDjNojNvJKwObk0/6ryx
         7rCY2jxnQR0pFrK+iR7/HbF1Sk2nUN3K9B4lDI3VtkGWUi5djNc0ldi4u4YaYWNJKKtd
         12Hxdj88hqWfJhhK8rqs2Hx9KK+YREzccjEC5vVtHGEo/z+Jv6ErnIhjNvaVt2gX6ZT3
         R3eQ==
X-Gm-Message-State: AOJu0YwAfnlqXXvPHV+W4gtmHp8L5UKLYf4SaNrSi0KIv1b6d0QakdeZ
	8hqdQuHCBYOmRmZD8cS4irhFphOMaUxPGyE4FU1eLijjor6Y79cCkQfK/+/lIUjGDdxEg/f0sha
	621H1
X-Gm-Gg: ATEYQzzYEhz6ymCz6wMtb/+A5q08YEd8ntcqgPvmzJdOeDNpU4QlFRWWBmCcG+f0wyP
	ieqdJ23TYgxi0aI3IUtcWCtoyMXld3shskgJBCzHjj2FgaMnovpHkWPkz2pc9SPP5O0Xlcjiqw7
	ITb746R1e69RkUKXMlGdhtf3MPlXeFfeDvJdTtGtKqoNmoCY1lh+/DEHCF0UI7BaMO6iv/BG+aF
	uRPtls5Y8V1J2EGJzt6fG8zPqpRx3bPubo03Ra1eEWdRil7wZOUzb40sP9886iBHyDQRwFnmLVj
	ubTdeBwhK9KGVdOeGrcoMkU6lkL/5PkzVhE7mZWNFSbHhdFLA9pJg1Mki1IJO2os6KuiEiwei06
	MakWdP1B4T2zEj8NE4T+wk5vlKy7bdznrCl1EmO3cFDof9RMxyfCmHZCiynhZPTz/1DR6JXzIjc
	9lcjznRQkZuYlfV2Wr0bbWxoxWK+WvLnL7+22vlCplR9ooRZZNL46IUTwtY+LfvaFJulSWrHP+D
	1Zn2Xy4RftfkggTgt8p0A==
X-Received: by 2002:a17:90b:4e8b:b0:35b:a53a:7d08 with SMTP id 98e67ed59e1d1-35ba53a7e81mr3761711a91.26.1773708929199;
        Mon, 16 Mar 2026 17:55:29 -0700 (PDT)
Received: from stephen-xps.local (h216-87-238-89.thvror.broadband.dynamic.tds.net. [216.87.238.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada43329sm913671a91.6.2026.03.16.17.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:55:29 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:55:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu,
 pctammela@mojatatu.com, savy@syst3mfailure.io, kuniyu@google.com,
 toke@toke.dk, willemdebruijnkernel@gmail.com
Subject: Re: [PATCH net v2 4/6] Revert "selftests/tc-testing: Add tests for
 restrictions on netem duplication"
Message-ID: <20260316175525.4f455ca5@stephen-xps.local>
In-Reply-To: <20260316211052.332383-5-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
	<20260316211052.332383-5-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268367-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stephen-xps.local:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 932C22A2624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:10:50 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> This reverts commit ecdec65ec78d67d3ebd17edc88b88312054abe0d.
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Are the tests being replaced in a later patch.
Want more tests so that this is covered.

