Return-Path: <netdev+bounces-267194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DPNKTAas2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9842785B0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD9FB310A7BE
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4945B375F7C;
	Thu, 12 Mar 2026 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXocr4nV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603C358375
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345326; cv=pass; b=WAQkMtg6mopzoD7LEH/dutHOmNXrxCmXdP1eFxNJFYDXLVbrPTuU7BZ0wfop1vGZCj8MYbCa6uUzpoaC/hE1lx42hcNa5zYl3kvw7c0HZ0haqiU7OyOrD2zQPpVLFdGnR5ecJLkv8wmi/S3OPbvANGmejSvpTgyfRtaRGRKSnfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345326; c=relaxed/simple;
	bh=oCflAIcaU8cJ5GfvBURzV9pp2HPFgbotY1UGVrlIQN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQv6E1TD9qRYPpmSqdA+5mrU4Zu1gdhMlgekaIQfZxIL1mqaJZVPDRT0kKYqCrOlxe+Q+VEB60e/sIpNiH8G1m96+rNMCv41WpOHnxv44oWkysYwlGkmHQzw4TqK25t3Fj3pEziVOKDGp1HUCTGD6J1lb04DdLCEegRN7Znnm5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXocr4nV; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-94ac7f22d23so375320241.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773345324; cv=none;
        d=google.com; s=arc-20240605;
        b=Oif/VOLLozUZM9zbg85aIJfCuuniWnFDYoNSFXrCjkyMIj/DGh111lciE/1InO2p0I
         AiSHKDdjRirbvujXTvGHQLG6nJ7IsR2bzG90+tdQUB+TjolxtMRJp5skc8HbKytnUgup
         6sX9uIEv+17GScFbLUDxi9A8Hdj9zwfTA2T5gW+IAAx3vvotOGhphi+84QWmrX7/UqhF
         6hPpXaGzXHHTnjf/LnAMGw4NmtxuwbEg28vH2TlOer503hnkOuKYJxd7tKln/JcYgGwS
         slue9oLEUyOfolbdcJlB4nidEpi0l96kP33yXVGal/bEIToCHP35Gjfry5YZ2eax4tqk
         5ZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oCflAIcaU8cJ5GfvBURzV9pp2HPFgbotY1UGVrlIQN4=;
        fh=GNHU1c3A5V1kU9ua86JZPtQ8lMOy9HT18Bx6u2y5sbs=;
        b=G6BhbwgMomWep5/zkgGzJZpP4JnzNDvP0d/eTl9zNumGok2FnLawJmpuwqySJoXXOp
         W9YlPWz4yzqltwJFuMULOKcIH6VJvsb5HXJLW16Mleg7d+HN7BMd27N6RF5bwzzkXMxx
         OawdN/A2W/Jr2dT3RGy3sXFSA6t9EEOlQy7zbDakFPLUsMhDhgdNQ6EQrI5IkatiY+an
         4Y84OUxN+/oiP2uLth4Lk5hHyH5yOesAKccrC1H1QOAu4wNI5WOq/UmYNJb7c4Js5zz/
         glcFpfxZQAUqpznwyJNAYQ9dvG7JqqprVxFgWc2AFE6RpqKR3PgkS6mvKJPSRC53KDI7
         9k6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773345324; x=1773950124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCflAIcaU8cJ5GfvBURzV9pp2HPFgbotY1UGVrlIQN4=;
        b=aXocr4nVTuuGStNeMDmGvWXiYkGjk+/bEfiVxH9Z5ePJ7GmsibksGnu8CCJdHnFOnI
         CF4kRkPlfBm8TKkx55CetgjxlmUJ4HSNU8oSHRY0fiOJxkFiWeBM01PzaR7jI7CQUH7Q
         UgnXNeDttz3o4C1GeVFKPY4kLcFs4ZanoXlH74jJkLM/qim4w/xVMP4p65m9nrDl94NY
         4t330Z5zIj+dfOIdB7ynqtJlvUhXOkPVngmpKbMrpDhEUyzDTYnSp8Ga9qXLc/5vm8WC
         CSr+huDEKxD4w2F87v0ImdrvjTY/4txgVtE4QElac+wP1Rzu2sl3ZPUC6Za7XIVXS83G
         YKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345324; x=1773950124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCflAIcaU8cJ5GfvBURzV9pp2HPFgbotY1UGVrlIQN4=;
        b=EhrUannGGYOetU3+dFIw+S/lc99zQeRtxyLjggYfaDP//YIQ+EaO+3NRqUU8Rvpypx
         OS24ooLuNzyAC+fimZZytCXyNiXM2EzQC1p8w5ZTBxx4ZEPT0yWU+Ov5b1WVYKLMPpfG
         Fl79s5yCYBtQeJDeGARojtYRKTOim/5rVOYXxrveP4Vw7bMcQnsgZPaJC/mdZ5CzG1bE
         1YzGXMZophps/OPR0R/mxUOXs7m3AyZZ6h6v+cN7azXblF4y7fxn6wQAoPmiLbku+aa6
         gPUaq/3FRoUW+Oi2K/zyQ45hMeZGoZPstr6tbAIj2PUWduzlzvN8kWKqHn5CiDJOjo8S
         X8Lg==
X-Gm-Message-State: AOJu0Yw4gSqoanAHVBonXfFYvG8GpmwZf78gJR5J18Mn4zBNAQxpn/ab
	KFvw3XHqnvtC9E1FKvvymJE8mBhtYs+xc7desSQb7KgJi3GDCXcX6TBiWRVLNNCaif6auoDsR94
	xqUUXBkiDuY49h60J+x4kuxeNNBqBT4E=
X-Gm-Gg: ATEYQzz1WouAMTDlGx+Snhcpul63A8sosW6SzD9JbasK7Z2Lh+nSl3KUe4R8v//LM8W
	IgU4fiDgGYSS0aH7gmuooPSQQf4pPre9ZZbL55GVxUC7JlXFGI4XBvgWPtJtb7AZKSgGtWOqCpn
	vl4xMxvVieEPgrk3eBK5+INJeVAtCgnG4T4zqGHTe330NXRYneyoTs6co3cODUQX00eItohVlty
	V6SJR7Gxz27790uyBRlF74mTgLjknJuyPHebZ34QwZtUVgOkBNrnKvnjEoaK7E+P/J4ppeqdvDH
	+I5uNXFwGfYeL0IUHPnZ8qzBbMgNA8iERmcq20y4
X-Received: by 2002:a05:6102:d92:b0:5db:dd12:3d16 with SMTP id
 ada2fe7eead31-6020e1ea457mr295903137.6.1773345323944; Thu, 12 Mar 2026
 12:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com> <20260312165757.GA3411905@mingi>
In-Reply-To: <20260312165757.GA3411905@mingi>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Thu, 12 Mar 2026 12:55:11 -0700
X-Gm-Features: AaiRm531cGavUd6TfQBCpFcdkWmrcWpyrZZG-YzmZLxSd5NkU3mK1_kzRbiOYTM
Message-ID: <CAM_iQpVcBEgLDDw=p440dTcXs7QC653V488gL76dsgrhv1EKmw@mail.gmail.com>
Subject: Re: [RFC Patch net-next 0/2] net_sched: Move GSO segmentation to root qdisc
To: Mingi Cho <mgcho.minic@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	mincho@theori.io, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267194-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiyouwangcong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 1A9842785B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 9:58=E2=80=AFAM Mingi Cho <mgcho.minic@gmail.com> w=
rote:
> Hi Cong,
>
> I tested the proposed patch and found that the reported bug was fixed. A =
qlen mismatch between Qdiscs can potentially cause UAF, so I believe this p=
atch needs to be applied.
>
> When executing the PoC on the latest kernel without the patch applied, a =
warning message occurs in drr_dequeue() as shown below.

Hi Mingi,

Thanks for testing.

I quit my maintainer role and TC is none of my business any more.
Please contact other maintainers.

Regards,
Cong Wang

