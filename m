Return-Path: <netdev+bounces-251576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOW8J7PMb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5125B49AFA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E77FD7E91A8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BE42981C;
	Tue, 20 Jan 2026 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anpmUNjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EEA33A717
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932577; cv=pass; b=I5kQpkAFhL3F5xZoZGINpOfSI0qZ9xU4/EkTAbyO8ze+6SISdrIIkuCoiIqDto+2Bgq7nNAY5zJFxyiUI+jWNk+QRLyEO3Ym0H3g28P2oXAvqE9sR8tYvOazQDpCApy1QaFajcTEKws6m+nx+6xzIcmfS+aD1U4gPZAtccoatGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932577; c=relaxed/simple;
	bh=eTFUWY468LUtnVCss8fPkcZUiGciOVE22kpbUyP5ONQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gKCD6Lp2QnP8vyDbDSUz1VZVuK+5Ak7AKMCsSuBqpBOCYKvyG9Pxh4IRE4g1qBewwuVRy88hiLhAU5mkCkBLVru9r89+jnba0KmRbuoZTbso3MPEGRAhl9omcOoof+zQZIvuHhwbfyqxnRninaqZZ1GmCaHckELpmrAceI6QMhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anpmUNjS; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5635f6cb32fso1609666e0c.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932575; cv=none;
        d=google.com; s=arc-20240605;
        b=bnkF780kuPke7unj6x1P/GICxoHSpHnbAC7qEbEkyzZXPqErjTSNSayLJiLlA6D3MT
         ZRjHR5ODSnF/yGC3+K+c68lzg5jrCK1TIFK0CdNE1c3E2qlKCS9R78hrlNvgF/QMQldQ
         02nNaY5Rf2R3vL5zrvH2ZNamNRrkMln02r4dovs/8NK0oWHFBToPYDpA5ZhnmLLTgasd
         Ir/Bw+HtWfiT4YdSLmuAGmQRpW2BC/a0eAYCJVoBzG5Ad0WPkFEfUUeY4r2mtEGKLVlt
         IGnlXgQoYx+4hbzsd7UXc0jEJ0RKkNQoN9P9Jtwg/ARX98X8asxBk5UcqTx5WlrKKhQj
         LO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DDj9mqdrWsbrK71m//NPirTRtybReP/0C/yGwpyeOug=;
        fh=u7hFgsDtI4PLxxS+Qne9rgcDtKx6/hSQXWTqfJo35Iw=;
        b=fRXa1J1jS33qWyoj0kjWDscW/qK76w26qFztOXH4CGeopX2lCFUwdapuBEta10bl53
         eomeIN7IDBbjNxBDedgQQ4siApMBY8iG9JriBPPTSYKa5XXw+/G6/lFag3xPgH3zA87J
         rgc+ol8A3jdmoSaLP3t3dUfbUmR4+eqwj3PWPvEWXHalqpadHrKfBvMPxEXlCpqXcNu8
         s6/1GcL7HTvWBqZPJs0ng8IYjfeItm0LbUaARtRcqKvOekTVJfuRQVOKRQWGd0yW6YXS
         e0c6cylMOAbB2vbMdXTJUrW37pEzF+TqygEymuxFtdcIxPl2csHP7hzMBTl/h2j8qI+0
         8eFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768932575; x=1769537375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDj9mqdrWsbrK71m//NPirTRtybReP/0C/yGwpyeOug=;
        b=anpmUNjS8yrDJH4LPi37oCbe+cd8KnzGB43Ljez4/HTCmQiGXXZiREJ3udKTWynWQf
         Ein5SKdb3xhJ3o2HY1Sou5NXnNLARo3DyBmonytS/BKY9AHcNw6Xw7WeksguGv1DHyP1
         MCk0joGCLGJ9bWo4WqtU53vOnI3DdwBdgQaNcngaXQPm6BzY0kjsonvhoYqOmdXweDNY
         5KVXfiilb3pAQdr0pJPX2cx7Vxi1RErZYevPDeG0Sz2FmgKdTU4zF+2czic9E6wsqcCT
         kBPfIBTKVMZgxcpbXI5eNWgmMQNLsw/8cKYq2B2PhYZW/5BHY66TDguI7jAn/RAsBs11
         z8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932575; x=1769537375;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDj9mqdrWsbrK71m//NPirTRtybReP/0C/yGwpyeOug=;
        b=TiW7u6w2Lff4OuFIS64DPVoF7MybkE82LmTU0y8JbEkXaijJoVjM49SC/NBA7zlmoK
         6cwMIWIIeWQuL0RGf3I5rneyzSDgAaY6UVCUSV5EW+m2NPtybiDcPXH3aPcsABRsdnaE
         gud9o50co8pAOEgmrLdmrLtE7N7gvzcc7v7YFeJogZ2E5GBir+y0832slcpXVC9g3JYh
         GwtlBxOFfc7/31HVoSU6lEDNvs5kDh0kV70Bm3tYPWa0F2HFddfj00O+OlFNR87U8BI4
         BXq9seVRX/dLWWvJaT8DiJZPY1w5Xiv9TbpqgDgNLz0f3D1paO3Sx/XA548frKd2eurj
         eHOA==
X-Gm-Message-State: AOJu0YwVs/AkbjYTbObACp33H2oPmtfXEPs0DP0dTWp0FCSMZhAopU+3
	mX8rjT3XQ0fVBcHMjk/ESIvJLvijedD79zTLHPvfs/J4+NadtD+5QbtxAO2n12F7aI7um5AIjbV
	fcIXQGHOmJhp+5bp/R3BAMF4IHzzEFc0J8Ldo
X-Gm-Gg: AZuq6aI/dndDPhhBpWO4dUUSUPKO+5yzIlBFJdoE0rxwR3YXPAyHpshMKhDZQIazvgh
	Ta1Us50RreHMjrF+yCVWfIFDviBmeaP/GsfOfKXIN/qLXBpznxuSRgXR4xMOG9ibG5J5yRFEOiw
	rgkG984Y+WoRcnpsEAeZ2PfeIFmhy8LJwYfbZg7MN9v7JbewYjH/eoJSGSVWdEJHj3UwN4xkZFg
	Z+TE6a+vxdxoopRlxbWIAk7HIQNnF5PhALv/3sfQbpCMBbXxn8oMWEwTq+Iqq65YATJ5Mh25SYa
	aPKpvIKUPIlg2I4CcLu2Ns73QtjBHpA=
X-Received: by 2002:a05:6102:2ad5:b0:5f1:606f:2a1e with SMTP id
 ada2fe7eead31-5f1a55c31d4mr3830204137.43.1768932574556; Tue, 20 Jan 2026
 10:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 21 Jan 2026 00:09:22 +0600
X-Gm-Features: AZwV_QjMFCC8-ub5lLBu5zwl2IvXXlPrrtNq7cLCe7RsPXC-9OEECgK0657C8JU
Message-ID: <CAFfO_h4kZQu6CY_U6cfakQ7Zozo8fg-LpQ_n5UiLZDVhqxMC4A@mail.gmail.com>
Subject: Question about timeout bug in recvmmsg
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-251576-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5125B49AFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(Note: I had posted this before in
https://lore.kernel.org/netdev/CAFfO_h5k7n7pJrSimuUaexwbMh9s+f0_n6jJ0TX4=+ywQyUaeg@mail.gmail.com/
but got no reply, so trying again. I would really appreciate
suggestions on this request. Thanks!)

Hi,
Hope everyone is doing well. I came upon this timeout bug in the
recvmmsg system call from this URL:
https://bugzilla.kernel.org/show_bug.cgi?id=75371 . I am not familiar
with the linux kernel code. I thought it would be a good idea to try
to fix it and as a side effect I can get to know the code a bit
better. As far as I can see, the system call eventually goes through
the do_recvmmsg function in the net/socket.c file. There is a while
loop that checks for timeout after the call to ___sys_recvmmsg(...).
So this probably is still a bug where if the socket was not configured
with any SO_RCVTIMEO (i.e., sk_rcvtimeo in struct sock), the call can
block indefinitely. Is this considered something that should ideally
be fixed?

If this is something that should be fixed, I can try to take a look
into it. I have tried to follow the codepath a bit and from what I
understand, if we keep following the main function calls i.e.,
do_recvmmsg, ___sys_recvmmsg ... we eventually reach
tcp_recvmsg_locked function in net/ipv4/tcp.c (there are of course
other ipv6, udp code paths as well). In this function, the timeo
variable represents the timeout I think and it gets the timeout value
from the sock_rcvtimeo function. I think this is where we need to use
the smaller one between sk_rcvtimeo and the remaining timeout
(converted to 'long' from struct timespec) from the recvmmsg call (we
need to consider the case of timeout values 0 here of course). It
probably would have been easier if we could add a new member in struct
sock after sk_rcvtimeo, that way the change would only have to be in
sock_rcvtimeo function implementation. But this new timeout  value
from the recvmmsg call probably doesn't make sense to be part of
struct sock. So we need to pass this remaining timeout from
do_recvmmsg all the way to tcp_recvmsg_locked (and similar other
places) and do the check for smaller between the passed parameter and
return value from sock_rcvtimeo function. As we need to pass a new
timeout parameter anyway, it probably then makes sense to move the
sock_rcvtimeo call all the way up the call chain to do_recvmmsg and
compare and send the finalized timeout value to the function calls
upto tcp_recvmsg_locked, right?

I would really appreciate any suggestion about this issue so that I
can try to fix it. Thank you!

Regards,
Dorjoy

