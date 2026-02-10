Return-Path: <netdev+bounces-258134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPyRH/Bpi2k1UQAAu9opvQ
	(envelope-from <netdev+bounces-258134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:25:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97A11DE80
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19D6E300DA60
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABFE38885B;
	Tue, 10 Feb 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss73s5h+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88001388840
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744285; cv=none; b=LYZU01mVqSFfqR1JBkxBX4tt8dDVHP5jd8yr64EUI+3ezPWN10H9W6EomWYi2ymSLhtKziZuFiWollmAC7XVzZHiPwmeYsg+E63sTxOF+/PvGQUFsMEj/YLxIhSt9IWoko0IlEbSVCtIipS8i1gd9QgSBqW+lNn0f5qQAKLHK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744285; c=relaxed/simple;
	bh=Wd3YSz4r0LCpgTa6gQcvb7t6hbNezRGr0SM90Ujny/A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1onneqZR8h4n13Bcj3aMURwLmakaioV8GAjxJ65jKMQGsgna86+lE3aDaiTsbE316xvT8rNMuCdS7Lo7lc0qrBopivLEinNlD0iOpze2dAuT9suVpcDPvO/QFScvvO1zptA8fDXhGCJFExXkG3ngOq/2+tUcJYVrDitv9ygW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss73s5h+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a91215c158so8020365ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770744284; x=1771349084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=exOj3yYPEa1TYDiWarKxK5k3MV6+EjzaaIJ4oOWyLaY=;
        b=Ss73s5h+GElY1s0DhutSz6CbTo2WTDHzihInucAby4sIk9S78raW4udZBEDt83cKRs
         c2PFGO8/9tx57oj8MUdQTOkFbGxRXSB3ceQIfSND1kjeENAn1m1yEbmemxmsqgZ9ymfz
         iFDe7L5nmo2x2IcmrReuFIU7a8ehiCvJFibPUYyIJkhupoyCtCvIezLvq/bRmcd4axdc
         8amGYHbDqOCocQNTEiiiaJpY64UNUCDfWjOfl1WqK9UZ/PkbxANuDaIkoC9k58ZfN+G6
         e+ar4O4g6GDuaJNiB4sDw1M78GTEHY966jt3L4X6g4LdDCvl/a11N+HEaAD2UhmzUpSX
         OwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770744284; x=1771349084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exOj3yYPEa1TYDiWarKxK5k3MV6+EjzaaIJ4oOWyLaY=;
        b=ZYTV1qFZBlTrkc+1T0uj/0nZ+MXYPI5snUzwtgLZvqGLX7ywfzofICnwWUnUzj5KWF
         QRYF7pw4GygtHoTxZWZfMC5e+XUQvlgCoiU1BHfm18DuKffFz6eQsCqJM527X1oTaNXo
         VHCvYYA1H3okzjtojG+0Q/KmqPBKT8nSgZK1cBI+Ztmyx35rPTkoXxkR7b/OU/9kc7AV
         GSewBxVqQdD7/Z5377XR8CU0/RDzjNDm4KgfI9gfj2n0ztFWIhhk93C60qr4puScXX6N
         L4lxmHSnNO68lJOvV+SNmLZDJjNXs30O4dub0QqgHey68o7baedkUtTyFal/ZaRLyJLg
         qNTw==
X-Gm-Message-State: AOJu0Ywv1QE0xsXsjct5eeJgrt1RjNNcb1NdQSVpuCexkdb93QRwxu/c
	tETLhgZh2Z0JEzv3G4+ql6+CivTqyUi7C6MAntQ3Bw6ttfcCG5y06Eya
X-Gm-Gg: AZuq6aI9Phly6WYkksGCy1ufuN6BjmxlmAVZQ0sUiLk2o8eRu0KkKO1wZyy4qIWd/nT
	bjB6UVHH2L8X36hnSrgAmE8Y3deHkMkVVvvMxCij96N6QYvFaysuY5QPUSov3gpO6qNEWX07HHs
	YYLpLoESZbNe5MsrPL/JkkrsTE542mZIOwX5pym6c+A+GhmmPuNNyji9Ybzjd9Niyfc4Vncrarf
	2BtnAanDvQVrlh8HtAeuxEamRZbpMWgrxTetiC+Y2qsEfxcbVDtZWfRP8o+2u3how2+bf56Q56W
	dXwRbQ4ODWDKdWA7qr/K+vCDtfqYYQekz4WEXh+quVrhxY2AmciLQBxTYq2tzDj2bxIOA/LH4tW
	wdGULACuyKfGtZYt1c5tjr0mNwQP+YlVwZzQVsImbBr1DI76/V1FeOayhb2zkuUd7n1I9rM6294
	9ypeh/w1sPO5bF1DLEAI1dk/MXApfofPH0HAQMKm6BIs9UyeJmjC++iVE1RsXFQpUCsisw7Rjxr
	TKjV403sVK1yWFQ1R4uVFA=
X-Received: by 2002:a17:903:2f8b:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2a95194ab72mr139665545ad.50.1770744283691;
        Tue, 10 Feb 2026 09:24:43 -0800 (PST)
Received: from [192.168.0.128] ([98.97.33.227])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a9636184a3sm110427275ad.20.2026.02.10.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:24:42 -0800 (PST)
Message-ID: <2c0395d5323770a32d53c6b874a735b888e4d4f1.camel@gmail.com>
Subject: Re: [PATCH] fbnic: close fw_log race between users and teardown
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, 	jacob.e.keller@intel.com, lee@trager.us,
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Feb 2026 09:24:41 -0800
In-Reply-To: <20260209163854.521415-1-dg573847474@gmail.com>
References: <20260209163854.521415-1-dg573847474@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258134-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,intel.com,trager.us,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE97A11DE80
X-Rspamd-Action: no action

On Mon, 2026-02-09 at 16:38 +0000, Chengfeng Ye wrote:
> Fixes a theoretical race on fw_log between the teardown path and fw_log
> show/write functions.
>=20
> The fw_log null check was performed outside the lock in both
> fbnic_dbg_fw_log_show() and fbnic_fw_log_write() (called from debugfs
> paths or mailbox threaded IRQ handler). Concurrent teardown in
> fbnic_fw_log_free() could clear and free the log buffer after the check
> because there is no proper synchronization, leading to list traversal or
> buffer access on freed memory.
>=20
> fbnic_fw_log_write() can be reached from the mailbox handler
> fbnic_fw_msix_intr(), but fbnic_fw_log_free() runs before IRQ/MBX
> teardown. fbnic_dbg_fw_log_show() runs via debugfs and seems to be
> not synchronized with removal either.
>=20
> Possible Interleaving scenario:
>   CPU0: fbnic_dbg_fw_log_show() or fbnic_fw_log_write()
>           if (fbnic_fw_log_ready())   // true
>           ... preempt ...
>   CPU1: fbnic_fw_log_free()
>           vfree(log->data_start);
>           log->data_start =3D NULL;
>   CPU0: continues, walks log->entries or writes to log->data_start
>=20
> Move readiness checks under the fw_log spinlock, and clear the log state
> under the same lock in fbnic_fw_log_free() before freeing the buffer.
> This makes readers/writers mutually exclusive with teardown.
>=20
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

You conflated two cases. One that can happen and one that can't.

From what I can tell the debugfs issue cannot happen as the debugfs
files are removed before the log is freed. If the debugfs files can
still be accessed after they are removed we have bigger issues.

The log is initialized after the mailbox is enabled, and freed before
it is disabled so the write can currently race with the free call. That
said the current fix is pretty messy in terms of resolving it.

A better fix for this might be to pull out fbnic_fw_log_enable/disable
from the fw_log_init/free and leave them in the places currently
occupied by the fw_log_init/free calls. With that we could place the
log_init before the request_mbx call, add fw_log_free as an exception
case before "free_irqs", and relocate fw_log_free to the line after the
fw_free_mbx calls as it is a resource that should be put in place
before the mailbox is enabled, and not cleared until after the mailbox
and debugfs file has been disabled.

