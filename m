Return-Path: <netdev+bounces-258310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFIINmivjGl/sAAAu9opvQ
	(envelope-from <netdev+bounces-258310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:33:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BEE126276
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC45300407C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644B33AD8C;
	Wed, 11 Feb 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1jIeM/8n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC502BEFE8
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827619; cv=pass; b=A/g6affGQOP/r82IsnWvQCEgJkqZtwr7HpofjnmCtz0jUrtH6P+6JSLJgtiLc9EaIaBYzgWg+fQajKdpe8goKIgfMAzgLcA+H/WJf9f60CmoUkhoT6KsdBL9fc5M2OoihC7DB1Y3vK6U/MZkB073tHoH7oFknfGj2AxvHigG0EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827619; c=relaxed/simple;
	bh=4LpeSXnde9oxtdb2uNAFwjQ6tzFf9rkYzSfSqCKOwlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ctcqchv8wz1t2ja890RNfkqydj1r13VQOhX2RFcaCEXCHua/kxbn8MSJ5C7mnawYJtvLCoyZBG45FFTssjqkWdne+Qvw1T96A+KM9oDBWgvjXQN4O44eOzOkwiNGaeM51TuanMLx2fQLR9+8bbg+6iXQV7ja+mFTWjI3BM8mt8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1jIeM/8n; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so1113769a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770827617; cv=none;
        d=google.com; s=arc-20240605;
        b=hZBzK0IJYCG5JIXK5nyh3V7EJjFx6fhxiScpPdOYGcAyWULhk+K55MJXFOhKLUF4oF
         pUnBYfVMcKlPETrF3z6v6ezhIRg/Y+ubOwwOtPyPMY4jOSMqROEBAEBrhDQGcuOnjW4w
         cUHvWveFzZwxvZtLjhmYdoPLqZ3OXZ+rORiWYl+udDs7LPV8ONv4AyXaDKG7y/Ox+T8f
         KPUCs+K6b8roBc7oUYDFB+T4Extn/e5z8dK55kahgagh2WLmGmriV5EsVT/Pf5ugqC/X
         5ybC+ybbU8Z44tPLzBUTUItJn8yeN3nbY2TDuksb9uJB5/TQY/Px6cXtWQS+yvauteSL
         /GCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E/NghktvPIM9E/smo+3dJvHO03RGD+5qrINGUzerKvk=;
        fh=QezftzjOACfcwBc/X2ts2TVy4tlIhIxP+2xH+nIwRN4=;
        b=RH2WdVUtNzztXVd/SLeJJvpTVSzR92uwR8O35De537rW0dPJcLNcqg4Zb8p0DBVJRf
         9rvJyBHhdlvYiyvF1I50NtDvrLQf1CV/qzGYR+S43j4nvOSotopsNdHHo87s/IOE34W3
         Jg8sxMcGa6XjMQHHH8zcV8ARLxeBoexpWRA9mpVSZVAffg+S91h/0nGyp4KYMOAdfdgv
         gQouAQLA4D2MKtllstgH0Bp+CikwV4uO5s0LBXY44qmbwzx87xlRR6GB4KJ3fjlK3msV
         jFGfG8ReMLxU19TY64XUSLWGSFWkwZ9aJOJEYL5Mo0kW4ua/IbKiYI3iIwK+C/vIRtnd
         AP3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770827617; x=1771432417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/NghktvPIM9E/smo+3dJvHO03RGD+5qrINGUzerKvk=;
        b=1jIeM/8nyklFoRyMice3nZm5BBp9iB0A7UeeomkPF8mdZwM9+O8OJ/TLJrhqWwQJvp
         Zw0L+XajSlAdEvk1BWXgVO/++9U2dSfO9kXRbbvqN+hPBAJRjpcZj0ZWEtd1lBgQP61x
         zh9wQ1E+a8XnpMouarWCnDjW2YDzQwZcYw8t4UkOPVOZLq59kqgULnUsfy9ve/xDiI0J
         Tpf9o1e/lbcmFyVVMo3KpATwPUaZn7NENa7MHklf0fyXW/1BH9ySXFEkmDI9bjGbezTn
         BdzxCoYu3WV85l/w+S/Eif/+ZA2tiUq5bQDIkaT/eQf/6A4V+h8M8Wj7vzQQVzuwPIB5
         U/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827617; x=1771432417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/NghktvPIM9E/smo+3dJvHO03RGD+5qrINGUzerKvk=;
        b=Rnc1X/b87fiZgk4+tyCB6EC024rvPxKI7Tdk0rBKpHxYjKQrgelKI5hbDXPbakJ8T+
         rYY1rlWRX4qhLFH6CG9I+ZCqsJLAd5mO1Yd97qTsr92NA4tJbzIEJQOqkN4H5ZePlpVe
         XdlQEj7Msq2TVMdUZiyiG2xucBN4bDYsuf1t9DiZNHPbV6R6mOX4MY1yLKYL/ujZkudL
         C41L6SliL77dbeon+Qdf6OvBNRNAb4xC197a0rTME2jZ9Z/C6Nf8PSpgBAapvrZUO3yA
         M/P1n0MTj1JzKhum7doonIRI8Vq+0LiPbEeYnmtbUmrXhgZvpPJqYaIcWd/clKsMV5wu
         oG3w==
X-Forwarded-Encrypted: i=1; AJvYcCU4rhQZsNsNf7ZOGDP8HPHTKGEXRv5DsiXWEGngS2sMRyXqvaI88cSoB/pq3nq9pCho1UpqZ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDSDxPaJZY1oSo4ojM0rmHjSYdRBD7iofR4GAXwTAfqFssUPDS
	MpxmOTjx9OtT7+PAezFD2gStRtbYgoTLLi0jV/2xodpd1wNyrnE1mqTmgNi7YevgvOjLtDfiw6M
	QMzfo0FEpops/C88hQRqyLBIk8AvCMXHIPCq0g5oV
X-Gm-Gg: AZuq6aLTumAgfhRL0HfCvZ4zlUeCXyBiU5+FyywcuqRaCMoidHhcNj4xuvqRajaOtC3
	2/3u0g7EHvLmDt9/JwlYnJnYjLME4/SK99EMMA9252f7RHd72nWgABUr6BkYS2kGZDzFA6FESvG
	zfpAcH8PYuNpPaZwRRmE7ZDxpDa4c2afyYT6qToQNRTsFTwAjZPnpQaRDqHHyqTvqmljOuxFlRP
	C/7yUXEUbp0e4JQuVBigVEhxbVxZPYolePyO1TZc+W3L1uYgVt8Q5BBhdKuLm30bDvHDPuyJy5y
	ClYG0hm+Mr9iUlc=
X-Received: by 2002:a17:90a:d006:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-3568f32ed1emr23755a91.16.1770827617203; Wed, 11 Feb 2026
 08:33:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com>
 <8698fad4-c406-4bd8-bfe3-33e5fda641e2@lunn.ch>
In-Reply-To: <8698fad4-c406-4bd8-bfe3-33e5fda641e2@lunn.ch>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 11 Feb 2026 11:33:25 -0500
X-Gm-Features: AZwV_QilP9UZ0eUp3x3pmvkEawCMskSoC0KUoiU_RDtMTfn6ywxPDIGGCf-cAjw
Message-ID: <CAM0EoMnS5yTW5X8uMw4Q2v-b7vGLaG019=GV_U0pC-7oyHSMnw@mail.gmail.com>
Subject: Re: [tc] Invalid JSON output from hfsc qdisc
To: Andrew Lunn <andrew@lunn.ch>
Cc: Deren Teo <deren.teo@outlook.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258310-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,lunn.ch:email]
X-Rspamd-Queue-Id: D2BEE126276
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 10:09=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Feb 07, 2026 at 02:01:01AM +0000, Deren Teo wrote:
> > Dear Jamal,
> >
> > I apologise if you have received this email twice. My first attempt mis=
takenly contained an HTML part and so was not delivered to the netdev maili=
ng list. The original content follows.
> >
> >
> > The JSON output for the hfsc qdisc is not parseable when a default clas=
s is specified; `hfsc_print_opt` uses `fprintf` to print the default class.
> >
> >
> > Environment:
> >
> > - Fedora 42
> > - Linux 6.19.0-rc4+
> > - iproute-tc-6.12.0-3.fc42.x86_64
> >
> > Reproduce:
> >
> > 1. Add a hfsc qdisc with any default class. For example, from the tc-hf=
sc man page:
> >     # tc qdisc add dev eth0 root handle 1:0 hfsc default 1
> >
> > 2. Show the qdisc with the `-j` flag:
> >     # tc -j qdisc show dev eth0
> >
> > Actual results:
> >
> > [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{defaul=
t 1 }}]
> >
> > Expected results:
> >
> > [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{"defau=
lt":1}}]
>

Yeah, I do note that iproute2 lacks support for json output for hfsc
(and a couple of other qdiscs).
Should be a simple patch.

> Just an idea...
>
> Could the self tests in tools/testing/selftests/tc-testing/tc-tests be
> extended to dump the configuration in json and test the output is at
> least readable by the python json parser? That should catch simple
> formatting errors like this.
>

I believe the iproute2 folks already do this..

cheers,
jamal

