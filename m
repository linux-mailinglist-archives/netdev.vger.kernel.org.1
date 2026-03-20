Return-Path: <netdev+bounces-270002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cx+JZ+HvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-270002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421992DEDCC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7815530BCD9A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271563D412D;
	Fri, 20 Mar 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvjtGTe6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45839DBD0
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028409; cv=pass; b=alojN/vu2P1SgTK+SyjCqq5Zucxay5b/hX1Wh6nZzjRykGopce7kNx0iWoRt+ivnwJG64RLVm4nUA0XfvaIJILNOF8VVYK24fUVGBaYtw7aB6wg+fIQgRsGxoBQAWhgYX+0ObbsYH/rUunxdWP6kNgbGlKBn6Ifqkl/F68ORatE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028409; c=relaxed/simple;
	bh=xDdqDWz0NbxoUFhpzbX/VdkLo1WemrXOdNdtD0UvdEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQdTZE0U4GRtqF40Ob6rYZoSJn+edLT5nKGSHkw/whAkR02+WKgoGpwRdljG4nrEefYp6TUvl75jUWXTvr2pmiZQ4PabacdBjirQjE0CXxhKQr508YBps5tcp38yb8NW27VZnBNaXcC2tiT8+pZ4N6XTWccFTUtDuw9Oq/xCouM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvjtGTe6; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-950b801b75fso521029241.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028406; cv=none;
        d=google.com; s=arc-20240605;
        b=EIsx9mbETblDCVKrmCNrkxOBZBYH7IHikiCB1D86tritCPTL+KB7CfNPzG0L5+XITU
         eh4ThMYuvWSObDhSYVOcEBZvKUrS9MPP0NnVY2dcrOQ53uveqqWVyCrMT0bs+MYV23Vv
         tpzCVvob9LX3AvfS248iQbG05jGiseEO4TNUVX7RmEWlGLuESM6fCJYi6LMYUSEJDteT
         aPGQXvnveUKWUYQcyDq/1mWdguuOq0ng6Wnx9remwPW5Qm2FFwdfp415OYwYHawttlXf
         riNZ8FM9yA3Ldb5XJSJZDC/aHtNb4nZhWm3eZ/I8CINVA41HWsRvbipKayaBtp01w7hb
         M+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ygYDsEg+zw9Q+38To0M6wXWLzakoKeK4wI54K+VgabQ=;
        fh=l7RmR9jvcbVsHseOS8wND4uA8LcLhUXpOtsvmlGiwNw=;
        b=fR0AOM7We6qyr4kvvwTYo67c6qE159EG+BLBQzRCIJejv0oOqrxsfjqhXXjmCLMXsK
         1+3LTM+Brb+AveGRhaBkIPIri3f0pZPDpb7b+As7UMJTy0hFJIxBc2y380z+rkeIuaL5
         7X981zrSc5dxP8HduVoJFa6pg/CcU3mqc2a6Tk9OR/SrfIEoqxAkSUCfvS8c+Ieqhqa5
         NfkWLnpuFKgQ2bf1dwOdKTXvwM5BpqV50s9/rnxkGwglXlud/ANBwn+jl1lQLchZc/7R
         hgjj+HQy5TeCSq/W1631MDYFbkWjrQZH3swWhEoCPyL9EHJl2DLnpoRG8UA0MknBMAsn
         9eAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774028406; x=1774633206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygYDsEg+zw9Q+38To0M6wXWLzakoKeK4wI54K+VgabQ=;
        b=WvjtGTe6/nbu2ngUlD72pijKQFw1NyZBpn1wVS4v22cZi8SWTsnbcJXSCTNVhwS+jq
         9CKcYDMVzcl3AHg6O54LJzNTTL9UDGUjHsLQsEcgsQDv296TM2PukgNSLfnTHc+DVi19
         5ar4Xhob82lKvuEtAV74oji4lxw2/Yj/TdCc3O+akaG0BJH84jsGBHC+4neJMe7CS5/w
         +fvd1vKuSUGaFL5msFzdgbyHF2sSZ+k8KkZa8+hh0xtlmEBlFU2ZRdHFb3Eirk88d518
         WqOO5VtLxgg/dEY6rtrNnUQty2OT9AKeErwCeAoVbrWLF1mFdlFe26oE5KK/9eE84kXd
         mqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028406; x=1774633206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygYDsEg+zw9Q+38To0M6wXWLzakoKeK4wI54K+VgabQ=;
        b=eH2VybiY5SsYQe1aABwtXWC6FG2aDmkic9UhJlvl0iwEHm8bYSWttYiYdnHsslDBeZ
         JPxWYm6U4+dUuLdWGxDBEAZNAKvK20tTRXElUKjPP+RZ3irAFfSpa8Upay56l1oClBNC
         TlQfMGk4/7Zo2uIYiqwXQwfPW0wTBWDQWcftqn4lmHW95AYR3zHTuMwTbaADcCzH44qH
         ifVpPwZ/0K3bO76BrBAXlP+KFz5/m7rPpRp0pjWKQF4gWTzL096zPeWLnqGUiAB/oAJL
         Hx1zXNOvS/7PlYEpzl01jk6NYdnTsV+DPWjJwxr1JZEZV/DHREr9dm0utL/p8CsKegqk
         retQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXrwqGm7hYPVIcwutOKOWP7z1sKril5oln9vuLlVCT6WD/ScqSlJO0xauX+HmFGgS3xNmAd/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAl9fh7Jo6N/9TCWHt7DfgbQOnVjX5/5uBnoJNaTFbpQyry6Rr
	jIHRx7Cus4ckxFkkWbXRf9/OwFvZdwpQMjKtjYkgLAomyi0k/Xe5I26qFtvg1sJN99ZDUFBEdKS
	fh4bc6nsPOfbps00yCxQWdCSTSC8/ri4=
X-Gm-Gg: ATEYQzzR1Irzz90P+ulYr0Zhxt+4eMAYEU+qN5VOXHeECLyUcIaT1QYKmMDeI71NvTW
	FMN7q4N6uY4gNTzlcQOXrbxY+XnxMU8jzfM6dPVwSHWgPK21CVFRY6F9uLBsEaXpsgcKL1pMg34
	us7s0Rz5w7AuFhbLxEkJzbuElgh51BueSzHuTbmwpAy8z21BCx6jAvj/cPFuj48HPT7ihnuF3bR
	m47S2/Nz7SS8JHMVjyONzUl6Vh2bjsOVZVCKnubLBb/Feyz+kjs/tPgRFD53mGlNGXIjHnt1/Pq
	Us7k4+g=
X-Received: by 2002:a05:6102:c8f:b0:5ff:a16b:93f8 with SMTP id
 ada2fe7eead31-602aea8f384mr1707116137.6.1774028405997; Fri, 20 Mar 2026
 10:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319141846.78222-1-seanwascoding@gmail.com>
 <20260319141846.78222-4-seanwascoding@gmail.com> <abwLFk0L_kCZqIiK@ashevche-desk.local>
 <CAAb=EJVCkn9_iO_YHMbLU1VR1OsKqTSg5Jo9jviaT3dEq0k5vQ@mail.gmail.com> <abwbB-AkHH9Syppw@ashevche-desk.local>
In-Reply-To: <abwbB-AkHH9Syppw@ashevche-desk.local>
From: Sean Chang <seanwascoding@gmail.com>
Date: Sat, 21 Mar 2026 01:39:54 +0800
X-Gm-Features: AaiRm519Rj80SD1FrkklLWEP1Cp-ZwIYOKAqklaTPoSVzVD9RJRLOv7YfSE8PCs
Message-ID: <CAAb=EJW-BDmq0yrMu=nGbGN_GsEV6GfZSJPuLz=A+6CdGKhUrQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] nfs: refactor nfs_errorf macros and remove unused ones
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Chuck Lever <chuck.lever@oracle.com>, 
	David Laight <david.laight.linux@gmail.com>, Anna Schumaker <anna@kernel.org>, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,vger.kernel.org,intel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.638];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 421992DEDCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:49=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > > >  #define nfs_invalf(fc, fmt, ...) ((fc)->log.log ?            \
> > > >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> > >
> > > >       invalf(fc, fmt, ## __VA_ARGS__) :                       \
> > > >       ({ dfprintk(fac, fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
> > >
> > > Why not all of them?
> >
> > I initially only refactored nfs_errorf because it doesn't return a valu=
e.
> > For nfs_invalf, it will always return -EINVAL. Would you prefer me to
> > refactor it using the ({ ... }) statement expression pattern to keep th=
e
> > return value, or is it better to leave it as is ?
>
> I don't think in this case it improves the situation. Yeah, it's unfortun=
ate.
>
> > #define nfs_invalf(fc, fmt, ...) ({            \
> >     if ((fc)->log.log)                \
> >         invalf(fc, fmt, ## __VA_ARGS__);    \
>
> I believe this already has an error code inside, that's why it's only add=
ed to
> the 'else' branch.
>
> >     else                        \
> >         dfprintk(fac, fmt "\n", ## __VA_ARGS__);\
> >     -EINVAL;                    \
> > })
>
> Okay, let's go with your original approach (ideally these all probably sh=
ould
> be replaced by static inline:s).
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Tested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>

Thanks for your review and for providing the tags!
I'll include your Reviewed-by and Tested-by tags in the v4 submission.

> Unrelated to the series, but if you want to address these:
>
> nfs/super.c:1170:49: warning: incorrect type in initializer (different ad=
dress spaces)
> nfs/super.c:1170:49:    expected struct rpc_xprt *xprt1
> nfs/super.c:1170:49:    got struct rpc_xprt [noderef] __rcu *cl_xprt
> nfs/super.c:1171:49: warning: incorrect type in initializer (different ad=
dress spaces)
> nfs/super.c:1171:49:    expected struct rpc_xprt *xprt2
> nfs/super.c:1171:49:    got struct rpc_xprt [noderef] __rcu *cl_xprt
>
> nfs/./nfstrace.h:1488:1: warning: dereference of noderef expression
> nfs/./nfs4trace.h:2168:1: error: too long token expansion
> nfs/./nfs4trace.h:2234:1: error: too long token expansion
>

Regarding the Sparse warnings in super.c and the trace header errors,
I've noted them down. I'll look into them separately and may submit a
follow-up patch to address them later.

Best Regards,
Sean

