Return-Path: <netdev+bounces-280901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D8WG3u/6mmvDAAAu9opvQ
	(envelope-from <netdev+bounces-280901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:55:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFA458A09
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A16F3009CED
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95C31E5207;
	Fri, 24 Apr 2026 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K52iS+Ah"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97247175A80
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992119; cv=none; b=elZnJ+terG2evS5Phap7UgHmA5tD98BeXtHNOC+CtaomIzZED8v36fb7s9L8u0o3nTsArPqig/XHZpZd2BdjVls+7DTYLGE/R7N+fowSB4vHSI8XOnVt9gFjcqN0ecQIvjBEPX4jZ2sWoAjVfq/vkTNn9ONd+KWX7EdUe7DhC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992119; c=relaxed/simple;
	bh=tsNf7Q4xUJvKzvuCYiNrQ69+xti15CioD1p4JUZoUbU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pLVu2Ex2SToNkuZ39daArcDBT0I4fQVGhs0wsQijaSkuk+KZ8m4hcDoYnGLdf21qO7Oo2aEHE8ybQOWXYRVoFN6Iz8qKngVzwWhJKpRqvI793vPf4AY5ACkdN76OyjCcBvnqWVdKplFDYicQy4pcXEoKznmW1McVKuxyPSJ0iHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K52iS+Ah; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479d85152c9so1936054b6e.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776992117; x=1777596917; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daUKMSC47II9MVuGQH8hcn1P3eQ2BwvljBL8L7L5CYs=;
        b=K52iS+AhNYyMP3Po3l0zCJd7pJFbOuLqmwqsTwpBVndczBQH3bkI3uW1tqQLLKRtQv
         K9kL8XpqApV9dJogHt1pqAXlApw1BNAsFiSxY9lL0vopTnjBpoUnk1lmbr6R9UyIZXUM
         EvydesIa8l0cSoSHC38QGK1XbAvkNKEUqZVhRKGaSO4RDchScUFhcZm+3xPqp/eEvPDf
         JIuE6XsH+6FvHjWHiKF7yc+VwjlfFmOJUQYtOtB1Uy9rmoQYjG7+Mz657mPz7V52VpbD
         cZ7nkT4QpF1kpWzQRoyYfJWxAFq7VLK8jKZKoCR3YL1BPqOU4Atmx/x0NLKHkao5mFyD
         Kchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776992117; x=1777596917;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daUKMSC47II9MVuGQH8hcn1P3eQ2BwvljBL8L7L5CYs=;
        b=WxzmIL10qeOc6XA+mJx3gWLni2asGU44roU2ZbVaD4zdAOjS5wj33txRzwC7FG4p1n
         XpZ8FKov5jiAkKQsO5ZlcI3GI8MgRNx8OkChlera9f4uAEWtPTOuUGkL+qmJqkSpz3BP
         JQhthj2FeqD+DV8tBdse4IKNtH8F4OY+3b/czyTKSBq2mxWyGPMqAI+Buff/xxLEbDZx
         bzV1IJdA4GZogSaYH6FKs+kqkr/KMcFmWD7r3opYTRF1ZYMVM4ib0H2DujArgoX8OmVb
         y55gczZ41OcvqVzUNc+DZIhob51rfCENzYC0eyia8HhGX0HQjHRisCH2yE77QN0Zly0D
         t/MQ==
X-Gm-Message-State: AOJu0YxLdzb256VeSbky8Z1rSWtvUuKfIT0AFtdcJhJUIbhAfWLt7oHY
	wAUimII1MiqGe7Cak1fKwSI/UJf8V9zoymvzJtaaiSyH+xkczpBrOdGd
X-Gm-Gg: AeBDieuRGu7OdU71VM4Yd0TqUVmegQgi8OAbmOF8pGikeTDR/+p3U+RIPHq0kwFIj2N
	4VLkPA6w6oF788p1tFlxV/L5mH5Vj5E/ThRwlvDoNq0GAihG/8DlB3fqZ7api/uV31VgfChtItD
	X2qRy9eVp8NE1gEn1GJ4wOrZJrxE1fI6epkeOGSIFcym5lPX2ZMnsHBfJqTznarNS/PGySqWxVQ
	HDXj+G0BvoMZHmWsWqWdFRtRKD/k1ARxj3sSZeu9vDSKvziFiwWzVDqkM80M4F+B6Jb2r1v0Kna
	xOejIIiPb8NrTbuL40b3AUDmmPKQ2xbJF5DdGzuHuwnIhL3+rSaLVWuj9fFb8MXn6/SkvdkDwn1
	PEtvreJULVcoF4kEtQzX8iIsjTGsHKg30w5IoNNl20m42VDax8d3VOrc4UPrRhB89ogT9I8sCqR
	HBtXnXvIfyJBexfd5JjwhKIX4a5QdnONoQiSjPpEX3S2CxdHee0cZHAVsii9mPbu/EJr9Xj1eLE
	cx3oGd8XbzHR59WmIsa1CKuwwg=
X-Received: by 2002:a05:6808:181b:b0:467:462b:ab0 with SMTP id 5614622812f47-4799c91783bmr16986548b6e.2.1776992117516;
        Thu, 23 Apr 2026 17:55:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a02097b6sm14515077b6e.14.2026.04.23.17.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 17:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 17:55:16 -0700
Message-Id: <DI0Z4SJ0TXOA.2N0IY94AF254F@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@kernel.org>,
 <mykyta.yatsenko5@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 0/9] Refactor verifier object relationship
 tracking
X-Mailer: aerc
References: <20260421221016.2967924-1-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
X-Rspamd-Queue-Id: A3AFA458A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280901-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue Apr 21, 2026 at 3:10 PM PDT, Amery Hung wrote:
>
> (3) Referenced dynptr with referenced parent:
>
>                      file (1,1,0)
>                            ^ ^
>      bpf_dynptr_from_file  | +-------------------------------+
>                            |       bpf_dynptr_clone(A, C)    |
>              dynptr A (2,3,1)                  dynptr C (4,3,1)
>                          ^                                 ^
>                          |                                 |
>                          dynptr A and C have the same lifetime

If I understand the proposal correctly above should be:

                     file (1,0,0)
                           ^
     bpf_dynptr_from_file  +-------------------------------+

ref_obj_id will be inited bpf_dynptr_clone() as 3 into A and C.
but original file->ref_obj_id will be zero.

?

