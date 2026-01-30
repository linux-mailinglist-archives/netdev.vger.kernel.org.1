Return-Path: <netdev+bounces-255217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FvCHmfyfGkUPgIAu9opvQ
	(envelope-from <netdev+bounces-255217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:03:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ABBD949
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39BC93001597
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0134B68C;
	Fri, 30 Jan 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="g+Fpyp1C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65919E819
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769796195; cv=pass; b=MNUiTlPvE7R6tHY/x1a5uO9q9Viw6M0TI5p3MR2ThCp+rpkAUqNCvyv3lW7U87ZLQ0q+f9y8B+cNjlubjmdnCPg8W2d913pAEy0aLozGoSA3UAW9qfY51wNdNUzSMBfTSOAfpqW/aJxHUKzauesLXCQC9lwcJHXRjx6zQ/lKVEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769796195; c=relaxed/simple;
	bh=/mMMp8i3mr5QKfsno6tPsIfb257F5GtySqn3ikKFFqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMYUND1ijCnMlINdOecQj10Aiy3RALgD1ZPAo2ARc3NaRKZWB3nl5uCFAbtuoyX3o3zIaeQ780LusVOXjMkovxLqb0Q8WTTH36TcIejayF+zRGkS1qplcSmh4LM1sLx4GRrup14GZqWFOz+vIQeKiu3VOQahdfZt4sm9qtYKT88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=g+Fpyp1C; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233b953bebso3092281c88.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 10:03:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769796193; cv=none;
        d=google.com; s=arc-20240605;
        b=lAZm7EA+yra4UEMmxIDIhnDykw56WFO+rE6L1qQfgiEi38ARkoeUNhKl5zQGcHPAj9
         z6wgaovC9wUG5OgHv15vrJwwNMzvj4gq3GfyCOEKCLLwbTy5LxlyYRYZToAZDspQSaUj
         HTkgpB9eEYPLrg/TxqzrMALqMzgKwhM7hp2LMIsAydck4PKRk0aHhB0fy2Y2ZKsqVEjf
         TblYP+d6HaTBDQ3HkOm24uZK2FoVt6qIhKJmi6Hg8oW4tHnQ6s8bQZP02Gp/y0mp+spX
         A8IJjC0OSHOOhsKVseNsXSB89Jm/SLQ5TN7lBzjpGEZ5J8ZB/9wFEJUSQ5e27YPGejeS
         hEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/mMMp8i3mr5QKfsno6tPsIfb257F5GtySqn3ikKFFqc=;
        fh=7oZJiN79Ojm6osTuziDwo+FTFOcWm+AJYXYRPJpIDyo=;
        b=jnODkqFu/LSun0yywmBURIYKJVNlzKsG5QO0YOHZaBFUpr3kbroCPAFMJkrgur/Ejl
         ZUP2t+UxiWIMLoc5Xj4URMqCqV0Gvdsjr/SyQ4vglzCgDU3FYMfi3xPGxe7iVMcHFOrw
         qVn26pXsPKf8VJZVqRBo0ykDnPwUOg3dim5t0ff5Zb57uCO2+Z5rJgY6aymXPPdNsEf1
         GU9Cim+4TfrhjYILNmVpczISM5oY7R216M2cPm07EclSZef9DGkG7umiTLCTgwnNcQL7
         w/HC/a1tCiSeZpPlXR1uSsSjzs5ADA4LZU4MQASDJPESYgaB6CjGQ6VkO+YtJFWatEMh
         3X2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1769796193; x=1770400993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/mMMp8i3mr5QKfsno6tPsIfb257F5GtySqn3ikKFFqc=;
        b=g+Fpyp1CstSS/B6GBtCcxDseEztChYONWzKjaTetoOlnFC7dkSFQBmcHE5WCI76wnR
         2E7e/ruFc3uJ4Vxskv+IOdkZL1zYyThLHcLoRYyIuvdb5An2YI+wcNocJ7zuOuFBtyCl
         KHCcwgBE/hlxqsMVcJdpEN8lWyCFATMlKWJ4ta7ESMRGANY4gJYDLpA1HuDOTBVOE71p
         EBvtsAZVsAaUR8bBKEtBWqQ2JSGhRQNEkwSNGCjLkl/X98qiaPQOk/iR2QW2ujHyGX22
         bL3jOc723NHYnbXouyRvIKcMkx/dkppPx2E5xZVvUaeLvfpUdBbr/4bUeC3QN0bZbW45
         yb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769796193; x=1770400993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mMMp8i3mr5QKfsno6tPsIfb257F5GtySqn3ikKFFqc=;
        b=MCKBYI7GybMrM/l8YLsEjtxar1CzGmJd0F+Vjiir7Ewu8UzEVZPuyw/spJv5ZaObTr
         oJ/CbAIERQ3AdxKmQ0cl5Na4KowDDGtstBOSuC0T7nPmKbr7UHHH4GwHdi0EleFxA6fd
         dNZ0d6sil8m940GNVlekn1kUhPsffYsDNzltAxMxA4dEBT2+OHPLkKWjQlOqfoGzFZz+
         XG5j1AbCPG5YkPJJM5/iIyM54i4Lkz/C39sO0E/Awiv8EdJ11pMldvnaJzPRpBLX22+l
         eeYcyme23jYBRu6qJaKH575J3ORD/tu0+KLy1XCma2xqpicIdNgSTTjP4cDeVpHQdnT9
         Ca2g==
X-Forwarded-Encrypted: i=1; AJvYcCWEkzdYNSJkTiFGDK2IhScWDBOaQshQKRHCc2um38BuKM6auWeg3NwtVaLXuMt3WIK0SJTpR80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpopq1eCsLLwWcRtOh5fjSDiFpEXPT4bnGVc/6CTQJRZzgTrr8
	rca3hIbeawEeZtP3+q3H+oUqMTR6GJvXdWoKUEKfnQD4CAW/NMFaS7TMhlMobmfemI4SDPyMbDa
	ox2kbthohZIPEJ421zhkS2Y5rVkvuUos9KVBYX7HZteazVPsRJ7qiGB31IFMj
X-Gm-Gg: AZuq6aLeOujtImY9Z5lYKY73SgI7Zj+yu41bxODUQZOlfllAlPIjtPaVeDikorwYNcO
	Gjs6T6/K/jaRh9T+rkT7odmuhiV8nRSkGkL/+62pWlssU5B/a7tTyoSM4ip3IClU+XsEQhOWN07
	FCmc2BeCg9ld31eELT3FrE8yYBGB2cPsjfSXnaZun3y0O87E5lTNq8s6s5Hf3eTKM5mE7u/aeVQ
	Re7gQA3aHsVGiTLVRwi1VsKSN6meC2rt8QXRlSf3kXy2OZPRbKH1u2Vz0f8WRbuT/InhJnkPL3n
	RHGMmlGxscO87gbXrrDlV8w/CvVD4uC5xqPhjHzqjnQda3uWo1x7OSxOo8MwvcvoPB+9HT6I3Ow
	yo422Lk2CVYU=
X-Received: by 2002:a05:7022:fa2:b0:11b:88a7:e1ac with SMTP id
 a92af1059eb24-125c0fad4ebmr2190000c88.19.1769796192772; Fri, 30 Jan 2026
 10:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106095243.15105-1-maklimek97@gmail.com> <20260113214232.129356-1-alice.kernel@fastmail.im>
 <727b7f08-828b-449a-a89d-005ad1f50b32@gmail.com>
In-Reply-To: <727b7f08-828b-449a-a89d-005ad1f50b32@gmail.com>
From: Alice Mikityanska <alice@isovalent.com>
Date: Fri, 30 Jan 2026 20:02:55 +0200
X-Gm-Features: AZwV_QgGXafUaO-epf9_hvjdzlejtWJ6Urd35Lzewo5L8rpYpvVJ2MnlWsxyCbo
Message-ID: <CAD0BsJVAQinyxTx8-co3yrHqmazOiDrKPx2Wr0O6FcdfLOaAtA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/3] net: gso: fix MTU validation of BIG TCP
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Guy Harris <gharris@sonic.net>, 
	Michael Richardson <mcr@sandelman.ca>, Denis Ovsienko <denis@ovsienko.info>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255217-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fastmail.im,vger.kernel.org,redhat.com,sonic.net,sandelman.ca,ovsienko.info,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,isovalent.com:dkim]
X-Rspamd-Queue-Id: 9C8ABBD949
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 11:00, Mariusz Klimek <maklimek97@gmail.com> wrote:
>
> On 1/13/26 22:42, Alice Mikityanska wrote:
> > On Tue, 06 Jan 2026 at 10:52:40 +0100, Mariusz Klimek wrote:
> >> This series fixes the MTU validation of BIG TCP jumbograms and removes the
> >> existing IP6SKB_FAKEJUMBO work-around that only fixes the issue in one
> >> location.
> >
> > My series removes IPv6 HBH in BIG TCP entirely:
> >
> > https://lore.kernel.org/netdev/20260113212655.116122-1-alice.kernel@fastmail.im/T/
> >
> > I believe, it makes this fix no longer necessary.
> >
>
> You're right, your patch also fixes this issue by removing HBH headers
> altogether. Thanks for bringing this up :)
>
> Heads up: I'm working on another patch series that uses some of the code
> you're removing...
>
> Paolo: should we still merge this or should we just wait for Alice's patch to
> be accepted? Also, should I already submit my next patch series or should I
> wait until we're finished with this one?

CCed the tcpdump folks: I would appreciate if you could take forward
either of these pull requests:

https://github.com/the-tcpdump-group/tcpdump/pull/1329
https://github.com/the-tcpdump-group/tcpdump/pull/1396

That would unblock the kernel series and allow Paolo to merge it, and
also unblock Mariusz's work.

Thanks,
Alice

> --
> Mariusz K.

