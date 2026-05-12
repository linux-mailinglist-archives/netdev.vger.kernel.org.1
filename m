Return-Path: <netdev+bounces-287266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BZwOMd3A2pY6AEAu9opvQ
	(envelope-from <netdev+bounces-287266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C464528440
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611B931C67C4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2D25B0BE;
	Tue, 12 May 2026 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfjPCIM5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DE25B09A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610763; cv=none; b=TCTMa3frkv1zALqb4YmqTOLnHT9oB3uQ0vEmU3gBMfLkApwI51WYUcVFZl+atK4AnDEJEyhqLjt28VJeUl2zXr2o06BhNpCtToZgvqd+I2OC9WkRu3sbWLxYcFK1PY7QpZ2t+cwz6H7CgywU2nFvdgKMlfaq8+skM50mH1BM4rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610763; c=relaxed/simple;
	bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S3aaHgBrneePPENB8189epGzRm83Qhw1VkX0x0Av+RBFkm2W+H36/YTkKi+PUT+Zlcsv/VY2AblRRNUEUaj1EX5/8azgcSa/mL4MMcJemqOWG0yaJa0JST7iyj7twg18jdtw0dYIGndwNKd7qrlNcdot4nOJ7/bpW8zUEbJvNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfjPCIM5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c795f441ff7so4315359a12.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778610762; x=1779215562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
        b=SfjPCIM5cJ6+xHAu0booYkkcVzq6W+iocCZhZqhWtYyT+LVm9O0xRSdQ7TzlUn133l
         d8nlmfDsO8t0eq6/oT+7wt5fV4mrIRpfViVCoYWzsTMNlgYjpL2fblsNLmNVUGm20PlM
         qQuDLiq48mxo1ZTwIEZWDDccJzKs/ZIO2B3X3i9tOf+NZCEpVC39eeq7GO3MxAseMWtT
         lbYgAXMSeTgBZmW1Jt6XIVxm8HjXOMA0wKYklcG3F9mLjgFunpjSxW48SBAyX4IobRf2
         IyYpfePzTMx2qjpoLbT5mdgsNR0WPVaFt8bWvA9KTSv3v18wUMoimIJU2QOyJDLTxezG
         JQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610762; x=1779215562;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=788A2bdcpOBapdqNI4/QSoomT4A1912/zFYTBA+/vOc=;
        b=fHz2K+mxch5Yx4pH8Iiez1sNkU1fZDejXGfHN5RCuIm9RwHkEaAXtXr+mXgtNCPVax
         /R9N/bz0+Ua1RX4kP2OXiozbANnVaONlc9E9xiXEjdTTOY+0eBl9q6RN5HH3qa/aTtbj
         1f6uDuBW6F3q4sOG7pqph6Yw6vX14GeqgqO5qJMFYmFOe5un78usRrxjgPVSxrPoUMph
         jeCZF4/L/Iik9yFTJw0vT+Bywg1dTjgLe2SR4XEjWWJAtvons9qOMqZIZNfW2wj7DLl+
         zhuGAerUaVJw3fPjv8DZ8zjvnP5v+oKS3dcgrsljE0y7fezc+09YgRSOPuCRLz3nONbw
         8VZg==
X-Gm-Message-State: AOJu0Yz2FgOjMCFKX/aQRPcnPgjHGSCBUHpQOhWnT1ZvY7B7uky3WblC
	imQGMDyMfWZwD2SJsj2LMezhC9iwCnY0pSINlG2cwmAKNq+IvLvcmdL0
X-Gm-Gg: Acq92OGza+tU6069Ci61A2WNO+pZmWgWm/9p4Nkz0i5305fNvY5lrseW44oAO4uSXcN
	mLFY2L+X8Q6UIhdumpD+bo9GsMITH8DbmZtAQlPWnuzn/blggIKuRS4p6cz1GO1mQoSu6wUiqQB
	fmZqQMGSnhMp/RAaY3QQxtIxH+xgvhi5u8ZZziGW/2oWtee7hEpKV4jvfd2Nf8VZT+leCwE4SNk
	6VlnUKYFykTeCEeqKxyx/Mc1ZC9B4B6iI54x1nRdR40pSQLm6rw+mBt+j9EWYNvtiXXVL2APxR8
	Wof/MLbTdOP3i52feNVK1w0yxnMwwizp7EvhrW5/XBVY1zVo0ffgYynjRaXOIJdR6lKgZPpc8Ew
	jkbuihk8tr2VwiQv1SpQuTpavNZsB0Yb7mJoiGoZwDHcan04Zw9QECH757Z+aJ0qPafqSjGnlVr
	dJSDxFYQffuCH2BReW3Akk/UoMgRtQ4EEfgXI5IX7mg8LhGpql6bRS
X-Received: by 2002:a17:902:c405:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2bd271283bbmr2687245ad.5.1778610761632;
        Tue, 12 May 2026 11:32:41 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ec232esm148513515ad.81.2026.05.12.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:32:41 -0700 (PDT)
Message-ID: <f89db2ee4911db2d8bb1da5b44e318d98bece0e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: Remove redundant dynptr arg
 check for helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Date: Tue, 12 May 2026 11:32:06 -0700
In-Reply-To: <20260506142709.2298255-7-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
	 <20260506142709.2298255-7-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4C464528440
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	TAGGED_FROM(0.00)[bounces-287266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 07:27 -0700, Amery Hung wrote:
> unmark_stack_slots_dynptr() already makes sure that CONST_PTR_TO_DYNPTR
> cannot be released. process_dynptr_func() also prevents passing
> uninitialized dynptr to helpers expecting initialized dynptr. Now that
> unmark_stack_slots_dynptr() also error returned from
> release_reference(), there should be no reason to keep these redundant
> checks.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

