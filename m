Return-Path: <netdev+bounces-251613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMXMGKTqb2m+UQAAu9opvQ
	(envelope-from <netdev+bounces-251613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D594E4BC1F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DDC0A44B6F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAB3A7F5C;
	Tue, 20 Jan 2026 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5TuzjFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713636999B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941235; cv=pass; b=IVM2knUSZUrDnFGq0+Ff/d/ztG5ox/zyNPtfyn6ziQbbFJwsQERYgjPiJCL2Y/NN4beGSMjYAInY1KYLErMTdr8PjGiLcWoWFRK+qejOirH4985wMVEgP4tG1UzqGoc/0zDWzA7y7ubB2S06xnQ0w+r3sYSt6xc5nJaW+5ufOuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941235; c=relaxed/simple;
	bh=eE6+9ghpSHEBiH08UcKIQtjn3cBOKAq4G5o7/U8xqDY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Vo1uzSHrZbS6B8cYpkJ7w2xw2GkgSFYjjcsmSumTgQOVckekQ3Hfdb0zbqJbltU3L0i/qFmwuXTionEFYT/kYdIPrUr8fk75Z9qGqdmA7YlHs0i3IiCNt0fd89w00GJQrdpZa+k/vevQobnh1KuwLCJVrSMfC/V/42UieAii7UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5TuzjFv; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so8920393a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 12:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768941231; cv=none;
        d=google.com; s=arc-20240605;
        b=CnSS7sWS7bSqBD2AI259WuTKlQ7lLW32+iodJgt95kxCwPAM0Zu8Xc/QTW+vqTm5EW
         aEsm0M5UXfIFo4LMK4MRJeVEQIzq8LPKrSKCT8+qtjvXyD8CCUMyAm/dJCVB9SfBadrM
         CLK19yGOldDfwDX1QDTK0gd+eWxZwdJhzMpr/YTzYZKxlqTP6lrWpxLye545o8XW4scL
         haI4AiHuN+9BqnaN93ZqQ6jNgUliTrC7AC/VhrJ4QsPPjTWX1J/2SLYDSiXxZpOXtLmH
         2qeBEFvFrg1F+4Pvv/vMWiskbGqZ2fWf2BMmbZcL8fM8pY3wthrl9eplfFxCos5mhaVz
         oNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Gnk+hQtvUsqVo6B2SsphX2uOQ7R1a7zkjGRhTogyYBY=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=IPVdlL56Z46VBwLux/OHYoPEH2jzzOfa5dUUvMxr4iHvT8wGdFeW3YPE3jyrPKBoqF
         IrGzeIlZhH4+t6QHxBROlcg1Fr1JE2eg1k5aZjsvHSHSyzw1tGsSgrJRMuFHoGE3XavV
         V7PsCO73Trdr8+Yx9aNOKPO5QmHH9D9mo7/CRcqDeqHnJBE/oKWOfFS3yP5yTpsFRyGt
         /0Rm1aZKQUQqk49NSO6MR+smgGulcP7onusW4KkRWYNqhBVz8m1+IwhVlaGWbBPOw35s
         eFeRFpG2Fqm/hHB7BYpPHz4XW4VfRA6SKJDl04vw15/JhfzmgZhe9lu3eOScT+M3Zq17
         gmEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768941231; x=1769546031; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gnk+hQtvUsqVo6B2SsphX2uOQ7R1a7zkjGRhTogyYBY=;
        b=Y5TuzjFvsnY6jAO7tkhNeuFfOV/DbecDcXx2qKwdl3LrCtDbwnTBz7TgiLJwQjLjan
         U+GnAEVtHNhC3Y5BIbFgLCRHFcADZZ4uVh1W1KdVeHVxZ5Ot4KddV2b0RnHrcdlI2trF
         CaiJ5QpgfuoC73Jc+upFyoTNmCjVATMxDJGlsePb56BECm0Ov9FtZlKqoXkYBxDwSkv8
         /5ruTTL0zrkLKXjltwjNReyNk4Whm06FA5Yxzdv71xjbCkAAarPE0Xha9WlXWaExRI6q
         cKF36iiZjPQLUHalHFW8mAVH2pDDC0CWQsq2guXXrH6As1+vrcM2VjoPxriKJfvfhUSJ
         MAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768941231; x=1769546031;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gnk+hQtvUsqVo6B2SsphX2uOQ7R1a7zkjGRhTogyYBY=;
        b=c37tTkdS9JgRMhPLhbd2ifNdkEwKgVyyXCwUBC5D7Fab4IOYnV5aYGh01GmtBJZhqS
         2wUyXOyQ77iUdW/z4GTvJTydenWZGZq+VXVTxkYkbgy8ITcQj/narG+q/jSv8BUbrMda
         WuJRZYofVxdgT/kZG5Yqm15BgYKGgMAWkPWI9GYGrBqf/+/6U+tMZ+w+Trt8VTvCMjiW
         7qOl9alv598ip8nygYDf/7/xfxXwORot4vsH/i7ABI1cr+qgh0daig16ImfZQA4GCt4g
         nxK9yxSAYw9yGyyWpbcDy8gR2/cxuLJgDLdoON15bcsMuIM7o4VLqUUCCkEMsv7CSqXg
         G1BQ==
X-Gm-Message-State: AOJu0YwnhUcVjQuLoDfPZVRsO6DN66yYvwog7jWZ4cg/H/zQH7vnESjo
	7twze796T3SQCAEZ50IC9w3md6c+HNQJQ+WcaYTADzw1vr9+NCMJHbvBytd7noHi0buQFajTxmn
	ntzG/4wUcPIFqJRNa9cRROhnj9Va6mkgxDrMH
X-Gm-Gg: AZuq6aKE0UNx9y3XgvHQlejwhmLTPea8o1Auf1rkW92wt/+8GkHkFOE9/Qh/27n/5cH
	0GymvSVtHTdrU80HrINzBjfBxtOZKALkKJ5e0TJFEaIedtenuyLa7C7EkzHFkBp2KO+M1wYyAJN
	vW8JvmJCjTrNKDxFhiRm6TlxB9EwF4Tk4c0nwgMEB7Je2JY9kMgNSny3ylvsbG4509o4p63EQRj
	avuMx19YrxT10uacf4tXzXM/VnutV71OodYJkoZpUvjCDMcc6WNf7KeAeaVbEwgl4Jw
X-Received: by 2002:a17:907:c807:b0:b87:7b75:5637 with SMTP id
 a640c23a62f3a-b88006df34emr266722366b.62.1768941231131; Tue, 20 Jan 2026
 12:33:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
Date: Wed, 21 Jan 2026 02:03:39 +0530
X-Gm-Features: AZwV_QgebKTb27-d5PL3FyDW946w_qoqe6zuwmZirdv4f_3CHeiemojXYhqjK0U
Message-ID: <CAFWXMN3WexdQEsjZRGumLuyA8phXmSte_j7JTAjL_v11ZxAmtg@mail.gmail.com>
Subject: [RFC] net: ipv4: optional early cleanup of half-closed TCP sockets
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251613-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gopalmalaviya53@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D594E4BC1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Background:

I am looking into cases where TCP sockets that transition into
half-closed states (CLOSE_WAIT or FIN_WAIT2 after receipt of FIN)
remain available long enough to be reused by userland connection
pools. In some HTTP client workloads, especially those involving
frequent requests with large request bodies, reuse of such sockets
can lead to follow-up failures such as timeouts or premature close
events on subsequent operations.

This behavior is compliant with TCP semantics, but application-level
connection pools may incorrectly assume that a socket is still usable
as long as it has not been explicitly closed.

Problem:

When a remote peer closes its send side early, the local socket
enters a half-closed state as described in RFC 793, RFC 1122, and
RFC 9293. These states are correct and expected. However, sockets
in CLOSE_WAIT or FIN_WAIT2 may persist long enough to be returned
to userland pools, even though practical data exchange is no longer
possible.

For workloads that rely heavily on persistent connection reuse,
this can cause intermittent and difficult-to-diagnose failures.

Proposal:

Introduce an optional sysctl:

    net.ipv4.tcp_aggressive_halfclose = 0 (default)

When enabled:

  - Upon receiving FIN and transitioning into CLOSE_WAIT or FIN_WAIT2,
    the socket is marked as a candidate for early teardown.

  - After a short configurable grace period (seconds or keepalive
    probes), if the socket remains half-closed, the kernel performs
    a normal teardown using existing mechanisms (e.g. tcp_done()).

  - Sockets handled in this mode would also avoid TIME_WAIT reuse,
    ensuring they are not inadvertently returned to userland.

A secondary sysctl could control the grace interval, for example:

    net.ipv4.tcp_aggressive_halfclose_grace = <seconds>

Default TCP behavior remains unchanged unless explicitly enabled.

Rationale:

The intent is to provide an opt-in mechanism for environments where
reuse of half-closed sockets interacts poorly with application-managed
connection pools. The proposal does not modify semantics for established
connections, connection setup, or orderly close initiated locally.

RFC 793, RFC 1122, and RFC 9293 define the TCP state machine and
half-close behavior but allow implementations flexibility in resource
management and socket lifetime. This proposal aims to use that
flexibility in a narrowly-scoped and optional manner.

Implementation notes (initial thoughts):

  - Tag sockets on FIN reception when entering CLOSE_WAIT or FIN_WAIT2.
  - Apply a short timer or probe-based grace period.
  - On expiry, perform standard teardown.
  - Avoid TIME_WAIT reuse for sockets marked for aggressive half-close.
  - Keep all behavior gated behind sysctl(s).

Request for feedback:

Before preparing a full patch series, I would appreciate feedback on:

  - Whether the general idea is acceptable as an opt-in extension.
  - Preferred naming and placement of the sysctl(s).
  - Whether a grace period is preferred over immediate teardown.
  - Any interactions with existing timers or state transitions
    that should be considered.
  - Any related prior discussions worth reviewing.

Thanks for your time and guidance.

Gopal Malaviya

