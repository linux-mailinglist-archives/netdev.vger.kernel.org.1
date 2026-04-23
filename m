Return-Path: <netdev+bounces-280637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5j2JJQ3K6WmpkQIAu9opvQ
	(envelope-from <netdev+bounces-280637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:28:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E144DF72
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F17B7300BB95
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C22FD1C2;
	Thu, 23 Apr 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X594Ofdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8122F999F
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929289; cv=pass; b=gn67mixmSZOcI/1aJIK3ll/1AIJzw8hkreLFsmGZZATjS8WEQg2Ha6VXmOul2vwIsuTNn+GhusMoO4e783OQeUXxuPYdwzR5Qp7BgPnut+/YbjXSdZtO3LBujBq4jdqra9SpEAElfnvUAxH3ha1nrroaq2+QwEBqD6V9SRL88Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929289; c=relaxed/simple;
	bh=5yw8g8XFUdWb9UghxesiQ1xjOzz57lIbFFFsRe+uzxg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hMxOyW8NO4UbUH7dmwbmB5KFjm9ZQRNqfqt4yNJoMYGhjixD3G5L9dEbOqsvMKMqxs0ASnWx38A8dbIsDVEiGLQQiJN11gY+mJtJ1kNLqAXfzM6uTpN0a0VRKWsZ3rlayXh5Irf8w8jG30jpVyXYZwdWGNX8ujRxjD5cZ2H9tPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X594Ofdr; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79827d28fc4so63356847b3.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 00:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776929287; cv=none;
        d=google.com; s=arc-20240605;
        b=kLW7W0a/5Fj9/oxNjYNS3ReAnTxj1tbOBiJNA953F15Vs3qTABojU/YrgwjzfoNWyQ
         moZqfRHkJT71uKkib9409Wp4+4Nj6xaC00Lzn72WEeR2MmIkRBPC0ogZCK+MyAqFUxh1
         XdDoRO7THi/GZzEzlprCS9UQHWpesTte2wmxSk/tJjn5Kk522Bq0QFxcNa/GKjmsjovz
         GkAb17c9w0eEVHdlP+bExA1b+AXWmfzZKqYjtVvQMHwbcGeJ/r41NxUB+IQwPKrL2ggw
         vCu3O7e32VtEDGmjAyCgUQw1W6rGyioy6+fPBH7d54650fuwzqhJYdAIsT7LyYYG6DOR
         n+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jQmlk/yKjczRcTAz28plcJ29BII8uPeCQOY4QMYcZ/o=;
        fh=jq7KfhrPAEOkvrGp74foMMaIFLiAY6OvtzS32kUHwkk=;
        b=ZU/CfudrGmoAwUoU2wATjsga+1ZTl2JtR6+K+iSdodaJHdVdW7t07s/nvEMpNaX5lk
         8pjfDu8QDABPuFIzlLQtlgfF0F0vqCiwJ0RjoMNbiH4ZM8z3zVhtz7MjzyGU7PTKcFpC
         zrbcsNUoWexvFhG2/3KstCjXcpvgz+QxGf/b2MPICCRiT+6eMMcaYkTXhitKWzoIxPRE
         skDWeiza6OQsLL0miivJIokUfwdbukpUaSRdJM89WwmOf1Mh4g2Fh19CaJItmdv6mJye
         FCzDNsKiNFsIHCrLUA5FCnBUQNKKtbOKG0hwAogxedYckk55VMwuqXcSyn0mM0jtHMrB
         dOyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776929287; x=1777534087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jQmlk/yKjczRcTAz28plcJ29BII8uPeCQOY4QMYcZ/o=;
        b=X594Ofdr3Lnh43wbmH8BnvD/1tOFMAuOUL9S+fvD2VBQdQpsKN2JGVVKZD7DIfoEXG
         lA1E1D2UZldEHQT74mX20Vsos7XpDlxije7/HEB5K2cXwlbOOx28RBh9CRnJlm0wv0Hp
         emgK3HiQGT9U0Z1oywYezi8nfbO6hEKi1uEUmKZQ+CDyy1pXwzRyIgdG6lgnip05Z5zS
         CpFUsYX72llD9mqc9mlIxCyKRrfKzGK2Wg/Xkbyaid7rtiIWmd8CTfPq88GbDqDlg86E
         N0P2x3VY3i+3CXkQxHVWIARs8iNOmCtlSODhpowAtt5SOrHFDthkQB39Aua4WC+e2H39
         cI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929287; x=1777534087;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQmlk/yKjczRcTAz28plcJ29BII8uPeCQOY4QMYcZ/o=;
        b=hOa5KYtlAg2YqpsLy/Ye1zSy+yVOy6n4bJ0jbM0Q79DXvF5fA3/qPAuCGRhRm1qKhR
         g5z439H8YZEkjkONSqNGb3F6iVunt+9CW9pAjgKg0QIcFtmiih0SWLif1ys7Xh+ZAsX+
         1lOhYj5L0q0IUOIbwDR2RLneN7wfvEvGUPRqs55TgJXV7PcgHkXBZxErYI+BJK1hRq64
         hWTj2Sgq3kwO3lbfj2tNH5uOaYrnuJb5xv9JdvkA+n5J2AYjQ4DeHWGDD4N5TpneCUZz
         ou66IMH6QQX51VEfUQ95AtIqPOfY4kmq4XclP9D86Gu8bDaNAcUccxMJp3iazKvj+7m9
         j5NA==
X-Gm-Message-State: AOJu0YybZEs94Fcwlr/JoO+dH2V0DSH6irSHi+QilpZIgxFagksqazgB
	4V+S2SJp3Z/JO9vuTT2H8Ei3HXLFQ5A09JF8/3Xjc0Wu2EVIb18q2UhiBTdTVhiIk0THOvFeDBS
	1gsRVnIbHZSutGVz+hUQ4JRsJ4OYPfFj0zwztAnQ=
X-Gm-Gg: AeBDieugZxONBg5yCZDIomMQ6QSUwly44Xg2pRBZ+VFR46r4q2jm/OZ45VRt21lSjTw
	+KJTxGyv2rIopduLdPU61UVePJrsoLJ9Izo90YFe3EjamEUfq1oCL+YKi7SLXJ2bvXCM9JhMuo2
	+12ABsimY3XpsWQVy3h7SeIr5uzjBJqcNNCZiUkQSQFr9wPYIMLhieT1b132Xztm9UjF+m1dUp6
	N+QtiuUK71Me8PwERMcgheAOQ5KFkDhXX0SGil1LYL8qCjHf4/4Sdd4BR36bisUmFN7/pLM/NEs
	qcqsx5yHj6mx615gE8ixvLLl0Iokttw=
X-Received: by 2002:a05:690c:c4e9:b0:7ba:f2f1:86b5 with SMTP id
 00721157ae682-7baf2f18fb0mr171663307b3.14.1776929287162; Thu, 23 Apr 2026
 00:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Thu, 23 Apr 2026 15:27:57 +0800
X-Gm-Features: AQROBzDdEa1YUatb3ogl5sfM0j7IHDGd7xHyBBqGW7GUCRpfw6kRrbdoP3PvaMI
Message-ID: <CAGp+u1bQg=Xc6d61o8i2Vi30z5G4A-iEWmvE_G-ygbL8weXFkA@mail.gmail.com>
Subject: [bug report] Potential atomicity/refcounting issues in
 'drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c', between 'cxgb4_clip_get()'
 and 'cxgb4_clip_release()'
To: bharat@chelsio.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280637-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 257E144DF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Linux kernel maintainers,

My research-based static analyzer found a potential
refcounting/atomicity bug within the
'drivers/net/ethernet/chelsio/cxgb4' subsystem, more specifically, in
'drivers/net/ethernet/chelsio/cxgb4/clip_tbl.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
cxgb4_clip_get
     --> read_unlock_bh(&ctbl->lock);
     --> refcount_inc(&ce->refcnt);
or
cxgb4_clip_get
     --> write_unlock_bh(&ctbl->lock);
     --> refcount_set(&ce->refcnt, 1);

T1:
cxgb4_clip_release
    --> write_lock_bh(&ctbl->lock);
    --> spin_lock_bh(&ce->lock);
    --> refcount_dec_and_test(&ce->refcnt);
    --> spin_unlock_bh(&ce->lock);
    --> write_unlock_bh(&ctbl->lock);

In T0, the refcounting increment on 'ce->refcnt' is not operated
within 'ctbl->lock' and or does not check whether the refcount has
already reached zero, i.e., not synchronized with
'cxgb4_clip_release'.
Although 'ctbl->lock' does not seem to protect 'ce->refcnt', this is
potentially problematic because T1 decrements the 'ce->refcnt' using
synchronized locks and refcounting decrement.

Thank you for your time and consideration.

Best regards,
Ginger

