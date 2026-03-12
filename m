Return-Path: <netdev+bounces-266819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLNRHwoRsmlaIQAAu9opvQ
	(envelope-from <netdev+bounces-266819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:04:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9926BD44
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1683A301DEFC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B39F1885A5;
	Thu, 12 Mar 2026 01:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b42Duxsd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722C846A
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277446; cv=pass; b=lLDvBf8PWQ8VUQQmsmGYq1Zqs1xOuueaRAkyfwQBMopyXeUJOi/xToqj8fcZVFWIfm6ke39VJPjVUkfEBDzZVnKsw88t58/ucIqJLPibAkP7zrVMkpySeepvVwjelXINWbbniGIw96Tj2BXPTx1uHoOmwyxMY3ZMkaUAkmxQ+gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277446; c=relaxed/simple;
	bh=rmT+fAUMiRC31pfP2h76YC6JoDsmkBZAWUlKYhvU2MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1JlMnTmpKUD9C7UyXJKLstLjgSlYecem4lzk+qxOaZ1YeGXjZ3fBLz8fBz0BwaXHvoZEegdw2hX9T6JgUKW2zXGYj26/g4hFT2yLybwGQoRIBN7/Wg71jcCg8okQip24zBJ9zMmJ0HARhI3Hq7F4gJYSJMQvSYnBIiwFE/FIGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b42Duxsd; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7da9so4950577b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 18:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773277444; cv=none;
        d=google.com; s=arc-20240605;
        b=kvekpC7AqDLUr/a5k88fh6PIG/yn5eHCZfk+TSRCiUnT+/666rCy9KaI7DWkzZJK4y
         iIAjk58b8tm0M/UkpTTMOTFAsCRgPx6l/m8cQIK65XnZnHi65rqLiro2B7sFao9bbl4R
         YhKgiSL1m5bOWOyu74g+mab95VB7FFd4dD95bmIcnLAqJeoks5kQSY8u6a6XScagSMk3
         MxpblKDB9KnTcNVA2cfBuGSizYyL80pwc1r6YXzJFtsP6SvjQj8JdanTOPCKT210fgiZ
         mzu91cRA3nzDpjRcfZZbx86p9toQ1hHWsTK7y1d7AR/JFYajGQMuSiuBbqkAMsF65psD
         +g/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fzUFvGVCltzN0RAWISKR32Ax/FFrPzSzqmmi8wdYP54=;
        fh=AOyy6we/I9aqPgS7botFnbyuI1/A1301M4XMWh/ri/8=;
        b=VXGjiU2rum9EJi1hW7WK3Add8IB1gq1AY2BHCKdjx3Dk9/EYts0XY+DOsuGLBaVu/h
         CNrngbjzKkRMt8M4HT2eBl8Chk3789/Ygy7PFSiFaxOTTFdlL3GVy+5QisZg3s15usJR
         RoYctbboqoWuFh5xKve7JlYED4wrRzoUz8C5euNEkp+wfTG5+EF91ptuMOCh15h8csum
         n9Gjy4WWtMUxU/zO9KWWYBhhqY0zF6gq4pGlTvQKGz/r9m4jdiDt34D+mJ22qiDVyvaa
         1IXckT40Sf7O7j20bW+UIYlqXZjpkFyeOYj7T44H1dEhIfdqsnyZa79MswFYQCAh1Lxp
         kKUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773277444; x=1773882244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzUFvGVCltzN0RAWISKR32Ax/FFrPzSzqmmi8wdYP54=;
        b=b42DuxsdeUUsZOp9K5ToJTXwOwBUrQKZK9vetD2mjgWJAHBvcwUQ/SYgeh+QStP1Vf
         bRuamMumVBipTO7Wb5ZacVYyDXQwnlhPPhavCD6ssPd7trDd7h+JB4/YU5g1pooCOvdb
         0Uy1/EBmNKEiZ1G29E7tr2hzga6Z7NlzOKvwAXQVH4tmVF0r0XCur5MRBgR+QGf2urXk
         /moym5+lmrsc+1r+blTsvdnwhni0gZvQ8At3iQwZ47dbCrX5ViDl3AID7QBKLqvOTfnm
         agAZsQy1inQRArhln8UMFQ4TfEV8TvSF4JaxAV+Z6utVd7cxu1/5NyJxhEO+SeGKKWat
         cUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773277444; x=1773882244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fzUFvGVCltzN0RAWISKR32Ax/FFrPzSzqmmi8wdYP54=;
        b=IT1naWb3KCw74AoymWAfexUGn2n8fCqVEBfo5ntYjzo3uUBisl0e1u0kNYdfXEaPMh
         gIJ+cX2aFUC7GVqT9F0qG5HFB4zzSRZePe77C3Xrd5mSkk59/X1+O44dqyM7a0aiaX/+
         dcYVxVEcy8ntfUqoMoyrLV+UrS/FZrN9skyQQ+YhVL8M/npp12Zqp92QV3BFgn4wVP+A
         d7ShnTBwwnc+DLDRNUVOmZx64ljatwOdddGv0qkEh5Bllz45IcuWDTRQI/7blT1ISKz8
         XOJgflECVCr11lq54/8C3BOxaO34cimmXRLnal+hDt3ALxdYNXzofz0K+N/bDZl8heht
         uH5w==
X-Forwarded-Encrypted: i=1; AJvYcCWgy+1epSH9Hb/ztKAQ+Q8KCModh9ig1B25YeUsQUIhqklkH5Oaywlwb2rmnxJdRZioDNiLNQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfcSEZg6wV8p3FbSA4fyVHaWqhx+RaKGqrX8lxnO9NJ2yzyIm
	dEBzj2cq/W3O3bNkvVlZyalOYWZXnR8EWQf26+f1IoCao/31eTyQBJW+bDxFvh2Br/rZDmF07F1
	tx8Rz4OgaykWQfD+PVXUrIAqThn93tFg=
X-Gm-Gg: ATEYQzwtR+R5L/kCqELBKf/Bsu5on3i8VtO5gdTDjdosxF8TDWLBd7U/upnFxx+tUVg
	wB4NLURiziEaU0GSWHgR3xdIvcyryd7vM+qvCPmAq0eMM5PpjvJelA7TMxN3gP1ea9LHmTDC5rS
	taMf1fhF9uhKgoiuJSn9O16OUbHM3W7axLpqMmRjT8dZajE+mLEjVi5fN6y4npfqwQfsEYQR+rR
	tOng229RhaTelIRqXvEN8MJOi7eIUHe5D/tEiliH7daLg4wWiF+mFfPgPLkkv1d9B/h1sF/RiRP
	wWaDt65FtjA1Ob1vitly0FiJJJajKaThN2uFNUUIQPhYaWSQc4LVx1gk7n8pyqn01IsQJbxb
X-Received: by 2002:a05:690c:3612:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-79917ec5620mr45739367b3.20.1773277444021; Wed, 11 Mar 2026
 18:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309155908.508768-1-kartikey406@gmail.com> <20260310031805.752-1-hdanton@sina.com>
In-Reply-To: <20260310031805.752-1-hdanton@sina.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Thu, 12 Mar 2026 06:33:53 +0530
X-Gm-Features: AaiRm50OlQRd6wGGHnmXTGF_wgJYclr4sB-xVAI-hQwMdFy42jTT2HSWko-ORLs
Message-ID: <CADhLXY7LcCFzJEcxoVG44AvpcV3x-o36xOxTdQhktihDVeXyAg@mail.gmail.com>
Subject: Re: [PATCH v2] atm: lec: fix use-after-free in sock_def_readable()
To: Hillf Danton <hdanton@sina.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+f50072212ab792c86925@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266819-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4A9926BD44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 8:48=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> At this point priv->lecd is no longer used, so why not make lecd valid
> throughout the lifespan of priv and free it after stopping dev queue,
> instead of the tedious rcu trick?
>

Thank you for the suggestion.

I investigated this approach. While netif_stop_queue() stops
the TX path and cancel_delayed_work_sync() in lec_arp_destroy()
stops lec_arp_work, the bug is actually triggered from
mld_ifc_work (IPv6 multicast workqueue) which calls:

mld_ifc_work -> mld_sendpack -> ip6_output
    -> lec_start_xmit -> lec_arp_resolve -> send_to_lecd

This workqueue belongs to the IPv6 multicast subsystem and
is completely outside ATM/LEC control. Neither
netif_stop_queue() nor lec_arp_destroy() can stop it, so
simply reordering the calls in lec_atm_close() would not
fix the race.

The RCU approach with synchronize_rcu() ensures ALL callers
including mld_ifc_work have finished before priv->lecd is
cleared.

Deepanshu Kartikey

