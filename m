Return-Path: <netdev+bounces-279074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH6sC0L34GnZnwAAu9opvQ
	(envelope-from <netdev+bounces-279074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:50:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A840FD0F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7ACE0300622E
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397823BAD89;
	Thu, 16 Apr 2026 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNVNWIJl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CA2750ED
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351024; cv=pass; b=emkt6zShCyTntgm6KHQtBSLTfKJHFTj6lH+d9HZNIMhV8Y2kexHl0BrEUbwWKTknJhD9FWI+NxfZWpng9za03r0yn0WGKxYcgmyf1umq0/1iSWu0ADwFUXS94PjwSYrTcKvdVKprC/F2pi3M0AgpXOFMyZxy3sfDKOyxNmAZG20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351024; c=relaxed/simple;
	bh=fg6ea/cTyU3kXAWhy5uORHT0C9/0VDP8VOBhB1dTXh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH7+h/atvtCgwqRnnXEtlAT2LCVC8nJRzTdC0GLGJ3Z8e4Sjf9nBAF3NlDdjc4sCwGrIUpzH9Gx0fhYJNOLdG11rDKOBGJqQgwv3Rf0uhx4dXqlkgJ6QODWgYKLmcI0fNXc/MODFI3T0f0TOQOh2Eii1FdWvWiAUx1B5LTtjXsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNVNWIJl; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60fce51aa55so1431371137.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776351022; cv=none;
        d=google.com; s=arc-20240605;
        b=OQgPjwXKGMuCpi+6kKX1arZ19NCSC/UATMa0lAoSQfrQOnuabhMcMIMWwMYGHU+AW0
         wrry+fUCIxvfdYLPSRs+4MSbdnB9Vw/pe/3fjDDQ3E7CzFGUw0X9axqARpc9QKdZ7Tdt
         eVE5XIKpnbyMHcdsTjigc756NzMtcClUmRAbxAvofQ/rBNpw0E7YEv7WWu/8Uc0PN9q2
         ydnT6D7OO/THgCaQ1DNFE9XDgpsDLvoxmIK9HkLIFYTF34p+w4lsiW0gQOZ5VR/TNd+0
         bM4/Rn1aA93pYqtYlqMkQiTR2ENzkbNLZy6SsOGGEDmrD3zEubY+DizqROwcGhd4Q/OO
         3sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fg6ea/cTyU3kXAWhy5uORHT0C9/0VDP8VOBhB1dTXh4=;
        fh=b3bTXQB2IE16fQ7hBKFchkrZfYYt50w0humVHDHmII8=;
        b=Y9RD2Eui2ezacBDWZp/AK6sTAKmmAqFTvO2d0QR12Utr7xAW+GJ9OrkJD1MYmb9xAL
         J4TlHEwEifnnEROob84+wofLC4c3L/Zhxg5jn4rWuCIToU9omukG6x0tf/XPwYKU97Ya
         UC/6lP9fGgbHF/5wVJGiLUgMBjCGLLC1pkXYndEk66ce4SKJP2PSA6Wa/fpjkoX1/ENZ
         nv0QnU2iNw9VvM3WbUV5gbpa9WpjwJogqyYWtXrhSMoZM3OIkcsLunapQwih9tMCYaB8
         gFdopzXtqDXnc7xwpFEJYGLnnqQtQFqD7q7s0J+Pu5dJ+s8BO+SwzoM1kOAo7AXy3LdR
         l35Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776351022; x=1776955822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fg6ea/cTyU3kXAWhy5uORHT0C9/0VDP8VOBhB1dTXh4=;
        b=YNVNWIJlOeGYZCxnDZ77DH+4U8WE0NKShV9yueLwjKjIzRrgJGDe2uDFSURn1It9TG
         0Hp9Msil1B6m2VNNRVgKkVWGnS4ZaVMM9kNAD2fmw07Av1TeXa6hZKRHLmdzK5rsQJyr
         5DeThEt889EVoKKfVRjm2Q8DWeiTcqo18cWRGd/rzYhbO3eqIGT0zYwqi6JiaF5hxZYS
         33yQiAPNDYZpMU2UKvZlSo/lYq6D9zN02U0I3eaQbTxVl7rxvohCOyD6o0gE7S5ABx4K
         jHIQkbh4qwDaLhg4ChLJpU+O1EI9SOyjKyTnFUzZvJBoaI8rNon/4HFgUI/MaDIFt3Im
         /kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776351022; x=1776955822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg6ea/cTyU3kXAWhy5uORHT0C9/0VDP8VOBhB1dTXh4=;
        b=SO0eVc8zGlUdagA+zW1+VIPQvLD2wf/gjwm+jxsSkrrRLoL/YeEUtl57B5wUsYRHas
         9FuKUVi4sKrGZiNjQLpo/tEeEJ5I+VYYKKVz2bA5Ay2xj7l85OEpSbcTsJcz2RtY7lmj
         8DOMmylKjyhP0WgdDpxkh1iWxdIUmJTtxsaYtW37ab1kFj72+AOagFzaMKcVf+7zojow
         MEmCH+//m1CYMFeImM1Pf4/S28Z42e2nSXMtIeAcfq1abqkoQLBFdUgtn5I8GlZr5GfP
         cHUQ1NzLmRQ5k7ak662nbFqmC+piVXZysocPS9uqzbrcAE2102afZIFp7tu/bkdziErz
         ga4w==
X-Gm-Message-State: AOJu0Yw5Qrd/WWOfvOCh34CaE4+UgTnCbNvOJW3uviaz+SUPt+TrPPWu
	KESAXflLw4V+L3LCSRyzKLDCkomzYT+v4S4qhMyo+r8N6ez2EV+LzbnCJI6UylYlYornn3yjBuT
	oCmLcs5fb+3KmgYKp6IVcYY+uyGUYtzc=
X-Gm-Gg: AeBDies6PYlTcOgIMKbkXFdDWUlQ3PwcgN42YQfe29h3DxXiJBfrYR+ZDdXip8Jo8Mh
	ZJ0tbKfl+BBXj72lMHHWLHINOxnA66hTxhZ0RyuQwT7YfInfka3Sqlb/AWdBbIGy9BfFjhgS1ZU
	zco4oGnuv61yWerrjgvM/jwJpKnacADnZvO87CGLYMa9nbOzjWrRSaWhtZUZZP3pOz/krkvvvVh
	nIEiorkUSbhAU/W62i1EAxosvTKci34XbCbc6IJl+IjYq4VLOtHf/Mi0EXzrzfUYugU32z4dMTb
	PX9Avh31gEGLStV8eITebVAtFlZUPMHr2yvXTg==
X-Received: by 2002:a05:6102:8555:20b0:60f:c9ba:b999 with SMTP id
 ada2fe7eead31-60fc9badaebmr5674668137.21.1776351021341; Thu, 16 Apr 2026
 07:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414071322.30851-1-shuvampandey1@gmail.com> <20260416125029.851168-2-horms@kernel.org>
In-Reply-To: <20260416125029.851168-2-horms@kernel.org>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Thu, 16 Apr 2026 20:35:10 +0545
X-Gm-Features: AQROBzD5-qJVtSAuUoc2qU7aEWEuYGtgrjxEcQ85ta_cQmevCyPzvkSJyxBLIgY
Message-ID: <CANAAWHJg7z0_ZtP97Fzb6XKRYUCR6EnEbymu9_WFyYEXmaPcXg@mail.gmail.com>
Subject: Re: [PATCH] mISDN: socket: drop device references acquired by get_mdevice()
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuvampandey1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1E9A840FD0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Could this introduce a use-after-free regression if the underlying
> hardware is removed before the socket is closed?
>
> [...]
>
> This isn't a regression, but is there a use-after-free in the stack
> teardown when the hardware is removed?

Thanks for the review.

Looking at it more closely, I agree the close-path part of this patch is
not safe as posted.

While get_mdevice() does return a referenced device, the sockets also
keep raw mISDNdevice / mISDNstack pointers across bind, and
mISDN_unregister_device() tears the stack down while those pointers can
still be reached later from socket release. In addition, several mISDN
drivers free the enclosing allocation immediately after
mISDN_unregister_device() returns, so adding put_device() in the socket
release paths can turn this into a close-time UAF. The delete_channel()
/ ch->st case on the data-socket side is the same underlying lifetime
problem.

I'll drop this version and revisit it after reworking the unregister /
socket lifetime handling first. I also want to re-check whether the
temporary get_mdevice() lookup references should be fixed separately or
only once that lifetime side is addressed.

Thanks,
Shuvam

