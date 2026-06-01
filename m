Return-Path: <netdev+bounces-293845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMSBDHi5HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 829A5622DF5
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCA1303769C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ED032570D;
	Mon,  1 Jun 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0M4qnYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28207310779
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332363; cv=pass; b=NkhikqPRebcTNAGpISTosBHkAhzKlWIweTJHeiZimi94R89jtj1MY77EX9OnWWHLCkAaHIn0KuaGTO/888iRXz76EDKEk3+8PQZDnM3Jc/882tSauSaIm3xw8+VNGA0JjFNwcTJxXAIqZbSOHAAK3k3nodpU9u4OdShIFNp+0AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332363; c=relaxed/simple;
	bh=nozntogzwu8XrYMaALgJ/9r5EMgDTBdhZKxzPsTSeOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqjScm1LBjvdOWQcD+WvAvG0+mAWjGmbMnfu1TolFnxFAmeWB6Y5gvN9WrOX5I0ILQA08S1zyIwEyi66Lxlmlv5esHgG3tqEIv3M+2MEyxymczRQVF9Yxe9eCSn6HAzh4ZKdFYhtVwBnZGpHYoJkk/JMVSptF2Fsgmw0dQShQX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0M4qnYl; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so621790a91.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 09:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780332361; cv=none;
        d=google.com; s=arc-20240605;
        b=ChxXfrID3OjeuergWWiC78gyTgxWX75++fKjIFcsX7hHuzPD8z7JEZ3TKOQvt/dXOz
         XgPdypAdZsfJC5XQGEAFURIIup493mp2bN7/EpGtFdusBYDwRlwK8MfZ0vDVjkshskyb
         MIMpZGFPAN1YLmblSXNdd4f7cH3bSmWgqYHZ2vtdiGFiLilPNq/yZ9G/P4O16f6XZuQo
         rdMVM0nfLhNu2QpaQ+bEdI4Smem3zJtqxci2jI8OLoiAVcyfJsrdJyG4C+y9cgGrC0oU
         JPC4n1mUtNC/8GY43Eq3uda4Gnzi5vCEChY4MpEWE+Qct5RclDVagkeAkIRATog0l35s
         WDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ANhlLkwHvRoelO6mK6br0cQySzE0loZY7WZgKnNoyg=;
        fh=dRE+umWMkh2TIExOs2vQ4m3Zk2GM+Au+WZZWsXoXA6k=;
        b=GHCJxAm3VaproTAm+rNHEMfhxJ/nwKfXhOkRq3gymHU5CcDgOftGsc/54O+DYwxinq
         bIhRcxDYJJmwM1YDP6kU4leYQdoH3C1mZuYMdGitY/+XTeIfckjVZ5fE8uRJEO+Xzl93
         vLcl4mDWsWGHxGU2F/Eh3S1C4KtL6O7VJyhRm1oaQbC+tD5BvXV1ta19NE3yxTdugDnU
         01OlBppGrc9436pra3RXal70QiVrvRtjTZ5Jxmka1vFaInfesBCIWsoDe5Er0phPIfmU
         oTzq6zMO4whXqTxCV3AE0OLwDUvJ+DtmDJi3LhJvBCGkqBguZ/jOiC1y1UIeGT2nwRVc
         YiGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780332361; x=1780937161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ANhlLkwHvRoelO6mK6br0cQySzE0loZY7WZgKnNoyg=;
        b=i0M4qnYlNI7K9IKot6mK0VcIXHVmji37zDfHPwbAA8gtSfkAyShyuLHqrVdL4F7KAE
         zjoQbT71o5dpCgjaK3Ln9cmgRglZ/3dsu55XM4TQ+QVlJtgu/VFxTs0uNcEF5ZQDU1C/
         N3lQzFXg/bIcxCsmOuPzG+pvkxzfeR9u5BbIsyPE5mFi/2PV7f5qa0zBTvpf0Q+/dKNa
         A3AbsoIFOCRsrH8/TS6hNOuhqtQMJJKzMsTfUKtNfsPquptItYaVquA5sjHl2Qq1ZlQR
         qkPe8h/lE310ySHrWJ+iHR4eqQLsOSMyvDo8YeTGnDuvHfPiuXLsK/UnIus0uICoPlU7
         I4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780332361; x=1780937161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ANhlLkwHvRoelO6mK6br0cQySzE0loZY7WZgKnNoyg=;
        b=Y/g/Bhm0rB0FTlsu7Pd9L7PzD5uS0rHygcXu3Qxv7YcvT3FFy67A3JrvrIBsvwj1wI
         kDcDwKBNh4S6gXs+xny1Zt7z3qx9ouwF6YVig6ku9+6cdkUh3BukXh44DTdkDQK49sPd
         DP59n6DjQVXimHTK+DKAEfPWBMS+WKv0+6Rfn4OiVz2ZG34Mh5lrY1JZO0KOLmxnqFJ6
         noXQJ/Lzw6GrT2NmXCpQDljlZJQuqnG15dvAeyy6pCN+ma9eT7Klfc4cAotzXKQ8OwiJ
         HktzVh1ZhhxefFi6q4O/W+qKnB3cYk3+38qdenpS0I92wgsIB0TKlQhCkc3S8gAmZmnt
         LN/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/7PbyTCllBipvXunKNfzC4QRpK12ID0pWmd154YFTcu+3E1BcKpxOBKch6j/2bwiJQd2gfw0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMFD0NVGJzYW8j+PrHTrU3RAIWHGyMWRezXq6beBMWXO/ZTJI
	rhiwX6gKXtTM0mFUz2iEy9sUYZLInXepCGl3x4x+3CH1QeCl80kHwkUF7xhOyRcO6/kQkrxHvzt
	pmxozkiA3ChXYO8DcSb4ab1U6PBmvjDQ=
X-Gm-Gg: Acq92OHGE8uGLxBRfKrlFOEhqLhbGpGduy1GOpC8DdTuiG93TQ2kTH9zTwEnArOElGE
	IhMTunf+/34DSyyLfuVvsDyNmocXHhegDUvDREtol1befvtyzPbwq7xaxLBRB/jC4MMK9l1Qhj5
	saasVFlxG/p8xG+dHzc7l4oKgR/vrQS6skCs3Ei/leImNUmqfiXCTkDSrf2LAqm8QPIYtiXmgou
	Q+DufsVAJCt77LvN7zoCb3vW3lg0Xl8xofeum/wGHMHNhJaPjKt40b7pGxnW5Ic8p9aUhXViB4x
	6/RFqVSTYITwEb/3tCs=
X-Received: by 2002:a17:90b:3a4e:b0:36b:ba9b:7efb with SMTP id
 98e67ed59e1d1-36c4fef39c9mr11682696a91.5.1780332361350; Mon, 01 Jun 2026
 09:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch> <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
 <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch>
In-Reply-To: <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch>
From: Grewstad <dogestad24@gmail.com>
Date: Mon, 1 Jun 2026 22:15:49 +0530
X-Gm-Features: AVHnY4KRCdi0h0Pqu6KDLr2ceAipTIZUEfDFKMo7TgmBS2phs0b3-uUhiqQc9gQ
Message-ID: <CAD03fja5oG3-BrQoy4+LEmCWPYGW_JWDEkaPndjSVz=PbRj4wg@mail.gmail.com>
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem direction
To: Andrew Lunn <andrew@lunn.ch>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, jacobsfeder@gmail.com, 
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293845-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dogestad24@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:url,lunn.ch:email]
X-Rspamd-Queue-Id: 829A5622DF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks. My research shows that no user-space application depends on
this driver. As you said, we cannot determine the subsystem without
knowing the actual end users.

Thanks,
Arihan Bhor

On Mon, Jun 1, 2026 at 5:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jun 01, 2026 at 11:35:14AM +0530, Grewstad wrote:
> > On Mon, Jun 1, 2026 at 1:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > >
> > > In addition to what GregKH said, look at the vendor information:
> > >
> > > https://docs.amd.com/r/en-US/pg080-axi-fifo-mm-s/Core-Overview
> > >
> > >   The AXI4-Stream FIFO core was designed to provide memory-mapped
> > >   access to an AXI4-Stream interface connected to other IP (such as
> > >   the AXI Ethernet core). Systems must be built through the AMD
> > >   Vivado=E2=84=A2 Design Suite to attach the AXI4-Stream FIFO core, A=
XI
> > >   Ethernet core ...
> > >
> > > when used for Ethernet, a uAPI is not needed. The FIFO driver would
> > > just expose an kernel internal API the Ethernet driver would use. Are
> > > there any Ethernet devices using it? Is there a driver for the AXI
> > > Ethernet core?
> >
> > As I said to Greg K-H, it's 'chameleon' hardware because we don't know
> > what it'll be used for. It could be SDR or Ethernet or whatever it is
> > programmed for. The main thing is that it is a streaming interface.
> > But we cannot assume the use case.
>
> Flip that around. What is it actually used for today? Make sure it has
> the correct APIs needed for what it does now. New APIs can always be
> added latter, especially if they are in-kernel, code to glue it to an
> Ethernet driver for example.
>
> However, a grep for XIL_AXIS_FIFO suggests nothing in-kernel actually
> uses it.
>
> Are there any real users from user space? You talk about SDR, does GNU
> Radio use it? Using what hardware?
>
> If you have no idea how the code is used, you cannot say what the
> correct interface is....
>
>         Andrew

