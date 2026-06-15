Return-Path: <netdev+bounces-299367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dnVeMjTAL2oGFwUAu9opvQ
	(envelope-from <netdev+bounces-299367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:04:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E36684DB3
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:04:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qhYgJcRv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299367-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299367-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCBB0300A13A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D83845D9;
	Mon, 15 Jun 2026 08:55:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164B37DE83
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:55:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513734; cv=pass; b=b3k1oys7X2F7qKlwI6MwizCP8Kv+4QUnWvEIczHySrLHBxUtEdBrBiU4zXI3EBkYNY0zT3sO1ywEa9lM7lybxcOJCYNa0mpT5VNwPh2uyKmu7COyinmQOLvUfvJx6uV4Oi57ZB2ztAu+o/7a9FgmI3vUekdBJI171q6EhOTRnKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513734; c=relaxed/simple;
	bh=sCBe8brqgBMLwyxrWmm1aTT+c8EE+4KnvX68TDolPLA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cq8YXh39W/d5aS91pwqwxaIXUe6q7HGJ/X0lo2HzDRulhgZ4hvKaNJsMwl/RqVelnl4VO+262Akx2cn+Uk7gFR6eYJ5OGSKNIQl78JA0EyX4RO/sr//gsSBALHe6nIoil/dIlgpuvV4aFSVS69R4NRha2RmQMxAPauf267HSk3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhYgJcRv; arc=pass smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6607e80a846so2974836d50.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 01:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781513732; cv=none;
        d=google.com; s=arc-20240605;
        b=Gxuh2YTqskFNplpPEddnCH28er0yKnzWNjXMZEf2f+tuaHAYGhFRbubA4fy3RtB5ov
         d8yMhEp7zkAr5HwaqgV2suM8jN8xadbOK1sUgNjz1LgfzNBVDbFiYUzgzndsFXlP05mC
         TX5TKdrYqpIJUYV1BEfhyYiX2srde6BFbmhj59tQNg0fFr8EuQMg83G1F1a/E1s3AVsT
         s6iMJCKvFxNo3tX5IAd7cqycwIOCLJzog+Syr3foCFsMIB9nz6v5ua2LYm7eeDF7DlBX
         SyfwVubHsLWcVUhiCizT8CZYNbw3yopWP7QLYkMBu8IjOAU3aqAzyCyfUTfacQ6GnO/e
         QDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jGyHie2kBOh6HC3rJ8F3ozKKcQYFr64yzrJQUrW1eHs=;
        fh=xWeJMg84cXVL8TbndyzVFgOIKAStPjStTFqex1ZkBeM=;
        b=fYvSGQsAnEVWPrIGpd1+eniqFRJbmAjkoySHZ+eKpqRDqNTLIopPS7dIgnsHRrmcfy
         deCbEtGdbv38eT2lxgVoY5kJQ0zpx1294fw+7MF0eLOfOQ8uigyG4q3Q52eW0aX+bqkc
         iYjn5FagfwkC2g+kQNhWazjyGBn6cKEVjSGHv2OSJ/9GtX+86IVxG8Y1bk/1sCix1crB
         x1y0Ttu+jM5WcCrk0Gomxb2HVWR3rdD2+vadb1PCpxCQSKY04dzd6yXQctjaAygyWAbK
         BrvtRjw0bJT6VHpVfpkuOb66G8HIrDnmjavG6OGQNGXchQU8QGR+cShn4ofUcHHV54UI
         AGOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781513732; x=1782118532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGyHie2kBOh6HC3rJ8F3ozKKcQYFr64yzrJQUrW1eHs=;
        b=qhYgJcRvTsTC5m4bRz8kaZi9ygijTEW76jDMyF1yYdY+R1Lz548HESU57eBN0T+I8L
         vPox5632bdPN8rFHnFYFDo827gGGb8qjGnsft90YXNyc1Le/bS5kWrwqtb8NeU7qjvBX
         VlK3Gq2OMKMso6FxRPmZEu1n6S5vxKWxtOKhr8KpFsATgTy+tCWHijuMrVffXy408dLJ
         +G2G9kWyPvo0IKsHA6W010mgZjEjQycXKin6I4bQ98S2Wsb9v+2RIe/R/hBzB3kDc6Jr
         eYSyLcTND5PXUFa4owI7yinpHU8f/tUQDHnGqwBgpnTl+i4ivVcwCRaKwP7iusvB6NKU
         QmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513732; x=1782118532;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGyHie2kBOh6HC3rJ8F3ozKKcQYFr64yzrJQUrW1eHs=;
        b=B14cC+EgD3j8Kz39Blh8wGBsHs0jntpYdFJRqDjsjSGlCddcxf9d7lXy1KQ2jywBU/
         i3Qfkk761IoxaYCv+pZaLDos8rsPewu1ilFNiPGSuIB3DjbLZmFHmmgFJXf3Q5rp7e4L
         /3b11acmVy0Y+yxSUNNUenCvwDOspIDfugAPoy7gEXgaTPtpR61hLVscDKKqVTjKp68A
         6KPJvA64mOdpzQYW57be2SgRJRWNBHFfLX2CsaWiCXTKgUjUY8/QXyPm9VQPlOYCoiuZ
         ovs2qVCa027bcqgXHegjz22/q+ampMYre0QXhQnpIY8zsj47srnsM7WnRMhZeP4mOVzo
         +7aQ==
X-Gm-Message-State: AOJu0YzPJnDJo4swCy+IDL3lgUuI4rBRtawI8/vOQ6lwekLY6D2C0CPY
	Qe8VcTsUL273he+Jlzo8IHPNBrmC5Pq//CigTwV+FH6u9mDouVU4SPqWnRzPzlnk2qWKuv/F9HF
	Gbr8NiFlhjqixJRzIH8/ofQBScYZm1OI=
X-Gm-Gg: Acq92OFneWmfUHioGJjIe3d5MO8bO6ng+dnc7gSdVTV+ggce4JjhJ5F07wi7OAlWUsP
	ERvi8BD9HJddsTy2w/VI+/mFj3CP3TYH63cNiphwx3SzARJq75eX5uZshtOUql+K5zu6l8jlPyM
	yUBpP/ATx2XDp0Foi4U9IbUw03Dn6gYGqoY8sm6bsnq+2qh2f0PW+Tlgz2DGHnV7CFoEwPOM6gA
	JoEnnSZWyF/bTPqUwGOedtaDBdPTjtDv8hnlVYw/32wdkCG6Cx/KSfZ1naSRHba9Nov6WVVjy8f
	dF23kCvQ
X-Received: by 2002:a05:690e:480d:b0:65c:5b88:84a2 with SMTP id
 956f58d0204a3-66284e8d09bmr5747376d50.4.1781513732202; Mon, 15 Jun 2026
 01:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Mon, 15 Jun 2026 16:55:20 +0800
X-Gm-Features: AVVi8CdE-IHtBPsUroqoiasN4jWlhpU_t4gS2UwBdfnaINV9aCNKQ7aXDMRL5Ww
Message-ID: <CAGp+u1a70_qRvoKLXEgDPmyPQ91PO7f+kTzOAEi6bYQ1E2O4MQ@mail.gmail.com>
Subject: [bug report] Potential double-lock bug in 'drivers/net/ethernet/davicom/dm9000.c',
 from 'dm9000_timeout()' to 'dm9000_phy_write()'
To: andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299367-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21E36684DB3

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/net/ethernet/davicom' subsystem, more specifically, in
'drivers/net/ethernet/davicom/dm9000.c'.

This potential deadlock occurs because the spin lock of 'struct board_info *db'
gets acquired twice within a single call stack.

Upon checking, this potential issue is present as of git commit
eb3f4b7426cfd2b79d65b7d37155480b32259a11 of the mainline kernel.

Potential concurrent triggering executions:
T0:
 dm9000_timeout
    --> spin_lock_irqsave(&db->lock, flags);
    --> dm9000_init_dm9000
        --> dm9000_phy_write
            --> spin_lock_irqsave(&db->lock, flags); // The same lock,
re-acquired

It appears that the 'if(!db->in_timeout)' code block in
'dm9000_phy_write()' should
consider 'db->lock' as well.

Thank you for your time and consideration.

Best regards,
Ginger

