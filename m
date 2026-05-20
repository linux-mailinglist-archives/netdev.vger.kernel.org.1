Return-Path: <netdev+bounces-289979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NvzEGzHDWr93AUAu9opvQ
	(envelope-from <netdev+bounces-289979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8658FC46
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCD49302237E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4433ECBC8;
	Wed, 20 May 2026 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyOh2LDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6B302767
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287874; cv=pass; b=g6DKErk2wAdF+ek41iDjdb/LKaQUcZDROFGqdwkBdKtz+CabPOdTSU4n6O0uOTG27+qsvlQ3HtXzkaqeIE2+61gnDx1oCbbKHN3Qpp3yh5nky0+VEk1hWLGVVET8hrpUfFTbz42Q8dsg5bUGAGmNyAx5ctDrLyoqt2hjkL2LPyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287874; c=relaxed/simple;
	bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMVHkXm6J52SqZ3ZKb9Db0Xso2o9n+8vVcXmu8zk/UrZMfTZTvp/dgOOULX1VYu6FQ76D59cmsOAi1eilEGah7scFG+rLuEynYvXO8MvHQpNnrYtIcgBFE8A/FJXaqNOjJkH6SdwlnO9Kw07EfBBdjQ/nn9IyHqeqo1B7iS/eFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyOh2LDR; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso224a12.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 07:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287872; cv=none;
        d=google.com; s=arc-20240605;
        b=E1ch2XumCcY8X9AfOl0or62LdSXsm1KLN/jOz3d5LO6AztLJPT5RRGLtqiTqznxNYp
         zCcC7TBIj/wg+BOw2+9+7QvewatvSGwBy5sON/mIPD8KipPRtytzLSGTwhkw+tJvKMS9
         2tm5ouCXbeN2cj9bBlyNyoOy2rdC8Xf352kEmD6agaMaceqsfmIU8qXAezrneQ8WG92E
         hAC+9Fyq9Ip3OrHWFxQpOxsKLv42KBW5CcOS+DPHCxCMSl1g9kBe5YrgFCN1lYAdWv4u
         HR7ztEP8dl4wGgOOqXyqeSL4gKIIRLv2y6rSzEc4JHW0JIW/9LFjLCzDBHEX8w66U9c7
         bFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        fh=i+IydB8zlT5QMQzT/OR/Y76hIORNJDepqzr1bhtm/Ms=;
        b=U5NodXlgan+E08NeIDeBjuhkihr/V3DUSBgDD9hdfMe1osLiWo40OWphdgIH8aw1fj
         5rQjys8/qsJ6qehY4/H3ny/b4xXY/rI27wLBE2eJ7KctSSb11Rzlp7XZN2CDA4E2hNL7
         pXS3Rvs/h7q2owWuF7JFTwKuXUI7+J65pdQISiJ/luG/IBKgyKJ8ldswgb0nBw/1O/zG
         2uuKM+RY3W4qIB9X1joU/VIQs8YVAnYR+hmIf/ra7lqkn679LQrvB11Db0fk9JOs/qaL
         JiiDsmmD5BzobXlxQTrwhFDQU8WKOl+1BZFYH280FzlcEzZdi8IBCn914RcBfmrSEn8/
         ZUOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287872; x=1779892672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        b=vyOh2LDRFh+8nzniZGVV4HtgfkxTX8VTeV/5Ug/quh43BVXtjsHZxCV5APMQYStviE
         9vXjVOuVVtXp52eIinuip4T+XiN9Shr8amLpQCyLxMJi+QE3mzcCMjQSPv3975ZPv8hZ
         kJwLGqsy9T5IgERpHQ69j8LAOG5DK674Q3BmpCxTYKuebThkZs9VU75DDSHeLlWKtz2L
         oGECftGOh+fVU4bXdBat89YFLonB3BGaRi8JpCAYx5R08Fsy/7wjykk49GP4en3VNdI1
         bECsp8lRtxy3z/fl1aglgrFFj5XfWC8ycdzIyY422FhX5w/8ZNyc+FGrDB0E9/Z02r1a
         rLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287872; x=1779892672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        b=UxQatt26tVmXd9JunGifxfAThFrlIL8dgd+WEEEYQhug/ih1JARa4yKVAPVUBmeOqq
         yVGm1MTD3thRNGB41pi74lG+3riXyHXBcP0izpY3J0WQsFL6yZIIt1cDFtwBfFHtTHgA
         /gjSt9aVmymzjSH9n3ef9MNO77C/30SsHrixc8mtw5EzK6FoIr8cVffwIrCFkbDeWI3e
         TfiPooiYaib5HXLoMeGjD+Hz4aDASWchNrWBrEjzA1R5qzspGzebZf/YS3MtEtDiWpm5
         XvWsBLldZ6kFxBh075c8F+PJkmG1L2LlYD1GVghGtw0cXhNnR6l9NTmuXYBXtXYFkWtQ
         Nflg==
X-Gm-Message-State: AOJu0Yx9vdnqfD5ajfC4+8mYWn5mAa37XDduXtLxqd5gcOv0EndILZhb
	ZS6V7+TYIai7ezMrRF0a3QvuWYCtMboUsAf8kDS626lH+2uH6PuwIMXQSjwIxkcp/Gr1UrU5HBf
	0Ohp6mUPQjxIm2bJXn50Zn5OofLBV8o7Ii/fhVh9h
X-Gm-Gg: Acq92OHjg/2uIpLySZJSock9pt+RtFOF5Y3gGSE4UoSn9MEnl4xkbL0DgfWor+D6vMT
	s7qUzn3su+72xf3L/lw7+XT7oNii7gmfaRm2X/6Ss5D11IXpG/IoFcvOfI0nDBLZM8ijbcmqslm
	3qejsUE88PbwtbAwB9fHBmMLFa6oIu0sWDZEZOWuFhVRuk8zJSQBkBQ2W6Re0Ln32xwIkxB5U7X
	P2gXnjcQsz96DE33Ld+O/gHC20HsXq9QKFxTFlH7CSSFCf9X2ymxEDtyhzAYFoiwHXIHLQ52jW0
	ytTT0QVsSDQDZ+nBuNGoNk8oacrOz1NNfNa6zphKjtX9zq++tPBcmNHe6n0=
X-Received: by 2002:a05:6402:d0:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-6848ae091c3mr263359a12.10.1779287870810; Wed, 20 May 2026
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
 <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
In-Reply-To: <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 20 May 2026 16:37:14 +0200
X-Gm-Features: AVHnY4JdoSHTr01XEaHyQuaQze9A_sGnydtK3RAXhZIwV8GUqbo1qEqHkb2In6M
Message-ID: <CAG48ez2KxGKH69m1TG2DwQkm5mZXQdxTkLL0_wqOgo3S7cTNOg@mail.gmail.com>
Subject: Re: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,google.com,arm.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-289979-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D1D8658FC46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:00=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
> On Tue, 19 May 2026 at 21:19, Jann Horn <jannh@google.com> wrote:
> > For debugging/fuzzing, it might be useful to have a KASAN redzone
> > somewhere between legitimate data in an SKB and skb_shared_info
> > metadata, accesses into which would cause KASAN splats. Maybe we could
> > split sk_buff::end into two separate members for "end of tailroom" and
> > "start of skb_shared_info" so that a redzone can be placed in between?
> > Or let debug builds store the skb_shared_info in a separate memory
> > allocation?
[...]
> Hi Jann!
>
> There was a related issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D199055
>
> Not sure if it's better to include this into the existing issue, or
> create a new one here:
> https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=
=3DSanitizers&product=3DMemory%20Management

Ah, thanks for the pointer. I have now filed this as
https://bugzilla.kernel.org/show_bug.cgi?id=3D221554 .

