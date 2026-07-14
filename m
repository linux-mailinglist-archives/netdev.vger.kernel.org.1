Return-Path: <netdev+bounces-307576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Do6zKjCNVmrE8wAAu9opvQ
	(envelope-from <netdev+bounces-307576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:25:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBC758377
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:25:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=okDiCOV+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307576-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307576-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF3B13036284
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A52A481666;
	Tue, 14 Jul 2026 19:25:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CA47DD6A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:25:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057135; cv=none; b=IpXHPNVdxfvjxhXUJSUrjbYNDCLD8MnRYyiW1h9EH6Z3m3wJa/X7ua5bGk3rGjJsY9aqBBFGuelSQyY6B69ae8qXgHt7m5gitvx0fMHv4X98naunYsRvaJBjhZ+6O8QHFWG6VICgCQHCBv1FUEA/5nVP0FBfVulO4MBjGUYn49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057135; c=relaxed/simple;
	bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ3Kl3Zjs4OwQBAYoSS7UfJ286zTtryi6Xu356Bl8JaPnbpp34f+SVu+nYdV6GrKAPafVUcDfdNZOq3JurIfGT81W4pCO5bQ2DccCIbSkZNdt2Nm8/eQ9uBvp3MMIV2fdACIsyhRf/LFVANBAN5FBvevI8yif53ir9tUem8pOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okDiCOV+; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1164398b3a.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784057133; x=1784661933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
        b=okDiCOV+3P92TI+p1rRGPjtaWibaZlYz9en4uzovrh1JEHTwvrf8wKV8pcBnhyWejB
         cCYdDKiZ9qC1SEDVf2bsj7PwupV+lqsg7CpB78IgijfV9DPt/PcpQJrZytxq3L2cGPwR
         laW6yKnVJcISpx5OofxgwM0BE4JhhEmR9bHQqEN686UkmC1gVu/1461DntdIdWBKV45j
         6bczfklNterDGYn5VE7euC9RnDnwoHkqecMyLhnoRnPnrARtjNyEbDiLj46gDCa0aRqc
         uLvHIptAQNh1vsNR8FMsQGOrrfl0rQhE5gvE9aoIuuM+bkB0Y6fux/er9rbz4cBObNPo
         tmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784057133; x=1784661933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbmsLjvkZg/eOOT0pgQJu5EFYeDfVNq+y7NlJmF/jKM=;
        b=XOq3Jb8r0KsR+9sqM3VKLjpuW6/fjGcNkQksDmngDDaenDPGDjMPUa1/14zajh7zKe
         mcWtCEW05NiUHtkM4G5VzXAFK9g/439WrDFsme2SOpJCXaVc0ZhMljFX5/ipPD9UM1D5
         11CFwyjIWf5V2euii2fpVp+oneQ4pbYvNBMk5pXMQzxXbj/rAWkSQHXGYu06I3ORoW4d
         oTOm8GcDI6T59zE/ou1U8HUIEcHzhY3gHYLMhno0fgYeN+AbDWK8VlgheUqBcJft7PGk
         lBjpdNJNq+89+Vl7uqjVfduRsajPwX0jNOXF/7j58J0eqYcVjInyrWD22AsLugWDH7eN
         1vKg==
X-Forwarded-Encrypted: i=1; AHgh+RrAgT2h/UUj7gJphUHjftjUGqPgP+LVMMklM5hadCBNrihVuPf9y5KVooLuAhIFg91a67csc60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVw/3SF8tJc7itRLW3lOY89fD4xMAvYlRe5vdCnkykgxlrVAL
	JIjDJkk5UyKTdUUotpMGkekUR3yQfIQRJVgRngz4tCtNEo5I2s6oIoiE
X-Gm-Gg: AfdE7cnzyjLSCNdEg2ArI2dhGc1ageAjHWgXNzXG92WWqdLLvIlTOXWOjMUvRrCez8D
	GsliB0CifEIgaCkgu7oj6t6kZiHW6+si6W4ARbHPnaqibvPjP+WUQcDQBC3Q6zy0Zm1tjX7u38a
	NsUm6qMgKvLe1/8ZO1ZqIyNddM9j4yzTnHyUBlZ+lAQnPb4W2AHpez4f46nIGSyMp2wWDdylFYH
	gf03oba8H7nuGAw+ujqV8m6QD5DzD3Qqb3FfmNhVnegYrHgkKUEXi7qdCgqvjiE/zTSekkChWta
	OsD7fTV1OtGfhcvmaEFRSsAJDiL7MN06uc0AKGDMEwWrSCtQVionuomzEAuZ4+Wey9i0fkob0Tg
	Rz7tnIS2ylVj0fg5YPS3MBK05H69FdFLuX/PLOVmmsmaGD+zknLZT7xsVxHCiNqKYQCeFKmE9cS
	HzWl2b6E6u4g==
X-Received: by 2002:a05:6a00:4fcf:b0:847:84a1:9782 with SMTP id d2e1a72fcca58-8488971547emr13217705b3a.26.1784057133193;
        Tue, 14 Jul 2026 12:25:33 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f239f01sm2008654b3a.10.2026.07.14.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:25:32 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:25:30 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mattia.meleleo@coralogix.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test FIONREAD on a sockmap
 socket without a verdict program
Message-ID: <alaNAFBtlPy_acv-@john-p8>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708-fionread-no-verdict-v3-2-b4ee31b3af53@coralogix.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307576-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cloudflare.com,linux.dev,gmail.com,etsalapatis.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mattia.meleleo@coralogix.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:memxor@gmail.com,m:emil@etsalapatis.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,etsalapatis.com:email,john-p8:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70EBC758377

On Wed, Jul 08, 2026 at 06:55:01PM +0200, Mattia Meleleo via B4 Relay wrote:
>From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>Add a test validating that FIONREAD on a TCP socket in a sockmap
>without a verdict program reports data pending in sk_receive_queue.
>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>---

LGTM we could improve IO_TIMEOUT_SEC across all the tests if we wanted
per bot suggestion.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

