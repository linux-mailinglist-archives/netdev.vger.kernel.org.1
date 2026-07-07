Return-Path: <netdev+bounces-305583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q12NH95UTWrxyQEAu9opvQ
	(envelope-from <netdev+bounces-305583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:34:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7F71F436
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:34:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lRwTLzuc;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305583-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305583-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A802300CDAB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF86D38F920;
	Tue,  7 Jul 2026 19:34:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D99366045
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:34:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452890; cv=none; b=AZVeJuLfMum207DdtHnN6K7BAv+xxt5SSS11Bt1iUJWth7TgoVJDWp4766DHDaJBExHaWzbUYI5158qMjIGmCCOrbfqyxDw6YoBYyFTMWhndONMfWDrfAdq+SMCoq0joBamr4mqw6EPYZDFrjipd7dIcOH4Z3kylsIO3vrULZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452890; c=relaxed/simple;
	bh=kgvAzl0jFPBOKDpzKXGh8JkHqnr9U4lh24SXiJfx0Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np0mQy1d4JBYKanSJiOy47pQFtbWGHW1A6OK9VB8utZYjPn5Sum7VTXzN7wQlZ0p1s0I88hZQai6fIXMcQn+UkA2EEWK7gEC7H7qoC7K0mum1cZ3tO2w1t/Lq72a2HjC6gXJCwWL7LHmoLUk85vWDnmH973ynH/JQPRrSc6Cxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRwTLzuc; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so48015725e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783452888; x=1784057688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kgvAzl0jFPBOKDpzKXGh8JkHqnr9U4lh24SXiJfx0Tw=;
        b=lRwTLzucCDT+/DVNgxt3Artq7jX/cP3h3Hr9nYbxHrJKxzwQXcn1OwLnmRxobud7z3
         v1AFgLkWwHZ8o8LR2sXzYkmLbplomLC+xv9TkOcJwA8TZNw4xTorsIgljifwHwKkhxYz
         29eF8uMK89byowtqNXY3l7VmnDCS04QqR+KTNmog6MvOJ1Myu9+oHeJVaSSfh5Ft48c8
         Je9ASF+wBo0U/ZLQ5RwN0d4QLSy9aFGeyV7psl6kTsAyi2Vbb7LTQe+Gu9qBDMo78TS5
         I3l87hng23ZRF2zQ5UDEtkAcJaPmX3qRPaQmq0wPr6x+259ojqIMUAEfCUV1wZeRSylY
         rU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783452888; x=1784057688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kgvAzl0jFPBOKDpzKXGh8JkHqnr9U4lh24SXiJfx0Tw=;
        b=Z9BtWZgF+uEmHfCm7VkkDkYUjdKjS1gAzdAWcJqP0IEqhLRxUb+EWz/6UOu70BpIMQ
         UBwNVtSl+IpsVZsiL2SbqB2fA1BAnMf4yKHt6lZyYT5es8UqcT+msvs6P6xtMTf8nxY4
         q+LvFi5I5+u7+SrblKYmzozW8cOLYFP/gbbVDTWfzSvaoDe8KwnIhPJcKE4atWXZFU8f
         brp/lrHduwVzQ+KhM+cZfWLUGraUnc/0GzGx7c9aKclrvXNPUnSUZbrcW7HbkSIPaJKz
         eIMf/zZx5A1YQ2knCWfmslS/9knVw0yog92UeZVF8lc4306ESt3TICoL0iGNXja5bJbs
         OmyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAAXQSuG3I52LugewEH5RfFUco5okeW1z/2Zg8iwOMB8CFlzaGTr2UbAqlcYWPOOAaGFnjngw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR52yu1tjgGgaioR/KisOaZJpNZiF6hIXhQ1ISkSrXqqOwNXeu
	dQdAug9tZ/xHMcIAm3LW22TRE1TRZDpVm2bbvfGtzlYq2AqRItK4G3M4
X-Gm-Gg: AfdE7clRjwcGs/JRND82TaReDrcLtY8M1mv/NYrBd2ESDQK1lHyNcgT77YXjOYmp2kJ
	CJmBDCgXsEdGacS4/01+lMjJkCInUwnJVCNmhLim3VPUCUurbSM4nzjRHNPIutVPhebiLZWp+HG
	t7CvSG5BiFlowQ5YjrUKQNdXrraUs5+C3zxgjEI0PtWogFVfiNNUoNh7kHzZQDyUMZjYgFZo64n
	gchCJ96RvHVGD95kYM0zMAIKar83lwYWLOZjs51VFg9oBEPm2G7b2x0xIgYeoeEHCohFIKd8g/b
	KespEupWEEh/yRodzXlD0K7fwPJ22TgENAwBmKEymzgcsXdqjaK1Xd9DNsMbHR1ArAmyzoXptSg
	ein24tzihTQNLFT7Knx+DiU1xy0ecGyCRwrTLaC0OWjnsj8Arvhx/Npcb40SfhzJv5Bmf++aMEZ
	QawzTHDq0rcZ0NpGpTqDRkguT4a563lo1KvYThrbiYkegteWTBZH9sVN/uxRuPWDQa7vw=
X-Received: by 2002:a7b:c00a:0:b0:493:bfbf:1da4 with SMTP id 5b1f17b1804b1-493df065f71mr54067895e9.22.1783452887404;
        Tue, 07 Jul 2026 12:34:47 -0700 (PDT)
Received: from localhost.localdomain (i689755CB.versanet.de. [104.151.85.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm123294955e9.13.2026.07.07.12.34.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 12:34:45 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@everpuredata.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Tue,  7 Jul 2026 21:34:43 +0200
Message-ID: <20260707193443.44553-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAKaoeS3Yg=kncNQRRcVh8JrQXy4Aah=3fuBwcitD6mjAEJOKOw@mail.gmail.com>
References: <CAKaoeS3Yg=kncNQRRcVh8JrQXy4Aah=3fuBwcitD6mjAEJOKOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305583-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@everpuredata.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BF7F71F436

On Mon, Jul 6, 2026 at 3:14 PM Rishikesh Jethwani <rjethwani@everpuredata.com> wrote:
>
> Following two patches should fix this issue:
[...]

Thanks, Rishikesh.

Both patches apply cleanly on net-next and fix the crash in our setup. I
tested repeated channel-count changes between 64 and 32 under live TLS 1.3
RX HW offload load.

Tested-by: Nils Juenemann <nils.juenemann@gmail.com>

