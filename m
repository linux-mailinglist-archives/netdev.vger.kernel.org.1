Return-Path: <netdev+bounces-280656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM5DFKrS6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:04:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF444E4AB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CF83088086
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220DB349B1F;
	Thu, 23 Apr 2026 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npm4m/63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBA311963
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931262; cv=pass; b=GZTYQb3eYrR3Ts6TKKXjZSs1mKZNYEKh9nAX7+c+8WOPQn0yAzGmgcgJachzOSdR0xwifE4XQ4PKq7+lX5J86SXVrext4+4RTsxuqcMFoV7B2fvl0FASSionIFWBTaCm6wo1MDSA2rtEPuIxIRn0HliI4VzbsXL0WcktyHV3VZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931262; c=relaxed/simple;
	bh=oV+qRGBoOguFntB3gQt83gXw2H1PXenjp6DBJv+PwnY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CiqkbeW7JyAQcG3ghp32dLe5/1hyBRG6/rpnxZZHgV7p/Gga0ZgKQVays/PxK243k7JHsJqnZX0on2TP+4Z2XKg/FICUCHmOtNPFozgvCZmNrFmVJdurWZkpViENyLA+t4OQFDFZN0Zfefc/yGe3sBkJlEA7/lnqxCWsmW3dUyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npm4m/63; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso50711927b3.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931260; cv=none;
        d=google.com; s=arc-20240605;
        b=lFQvX4Qs1ZhQql6GgAfRUKK3FE08+18uHN+LAlguI4Y3q0tkBsDOm6Trj2jdbTtFVw
         aWlF6vwO9CK1SFSlakF+1/RP1JR1M99nTd3f20CNZf8OE+WZmHH3e19Py3p9AG+86Vg0
         8ywoXTl/wL8F/P5rRO8YmTi8aFp9xGAPeIQY0sohEu2AgbkqH+Q6Axl7lUIHzHnsUopC
         B+YkuF0iruXufXjBFnUSDXWInYldjukpTtpWS1kk/6dPVgzPEghVHNz6UxV/OjQvDVoE
         EjrSHH00tk/dj3+eNv7hhesbpx2NBDVOkCCkuTm4yMgKRWcQFmpRrjl1tmFCrITTHle3
         n8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        fh=6jTDs5uG/5bmC3tBMHnesdaiNAzSvoYZx+YAcD0NptY=;
        b=Kkz8zQnz4SpnZPqZLR02v9k2pKUQfoTBSZgohq03Gzs7P0agHBblJsdSvYtpshjHXV
         rbOURqAJ0xXClISA3F6ZtX3rf3CmLbLpZdb9wMdLq1smvsQWmPkTWGayn+jW9Z+D9xQi
         Kh3EL8i1ctIiju2jK749J+bWAjoAP3nOW15YMXiKRMySLuUuGb9YuefAnGzUT9XKWrdC
         ZLbWTb50RdYCxou+/BN33yAbEawBrgwml8nqHR190zF/XGVnMTM8Xp5mQrhU0j0Obha+
         JItXsaBFwdugW7bUWzFruDkNELpaIYWXcgxUVyc0259ml1KvKlMV+vSr26sdU9HpUgtI
         Xjjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931260; x=1777536060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        b=npm4m/63uTCwDd20xBQd9nCXj1JRN36cbk4JhsMjEVroMfrOg7cbw+gU6600pMz/ID
         Ec0Ga67yR9DhqvF9h8YuGZ8nYOiweHDSjrUuwR/oWn38qq2vUwOC+mAXcae4HFYxB50u
         LsxlvwMsayUrQ+CSDp1j5Ci663fG0Ckj4h/UKyMDt6blmPCbEw8hLbjCq0Hp6iCdQOr+
         ojqyBG5fHJI3vOqJWFB5sMQFbupH/L5IYR4Dn/Z9zMRN5FKu2v4ZhxYJ0eBbzKVKvtND
         kxGoqQiD/gCnqNwzLyKHoYQmiuzwIOA8eORmqd21Ghyb5Owi1b2gcwJpWWmK3gAwUfAo
         xGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931260; x=1777536060;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foidsqa8Olw1KsuUlxfrgdXZyCf9RpiewIo9G3B1QpY=;
        b=ZYJjcb2lxkNO3D4bmMsgCyS9KH9YCsboTKhebRNQNSzCYAZRb+1htQuMQQYjZsMJGA
         MdHEY1jfLwrfDWR1OfW+A5vUG4YhO3Awo8BxDHE++0Tj4VWic1lwxnZtNn5HUbxgfG13
         j4octvJYO5osL+GMNnZyf/0fbiIGfqUKL2mq0XFFG7vKlvr3NjzSnhj4Qa4uIqNZCNCl
         eCPH4PBsVYgkH8nF6yir4MmawpkUQh37c7nLu7i4Pr1NIAsIi1FZOlGKK1vd9M+TEDCZ
         gDzF+Kka3pxY0AH8eEyoCCelaEitTmVg7l1voyysYvHUr3Q0+ThGnGB2ZJO2kEazC/0m
         kKkg==
X-Gm-Message-State: AOJu0YysjpPFgQzVH8ydjDogFKWIsj53PXvLVuDfQQ0m1d34qxHx7vgK
	NqTHtGPQEx4LvK7qaXlVLNFH5/9imNSdn9a23RzlgvAGfkVKRYcBeBDuONaX0xS2hmF2vnwF7uD
	yD1SbRBNML36lmhUZp4rsg/sLtty1ntUlQ/ynoUU=
X-Gm-Gg: AeBDiesFkoVjaq3HW9gnV+S78m5BtYShCvC635SkZZqMIcd3axBZ/6lbJQH4UrwZxcS
	C+WXP8A9JbcCj1OM8mwgTudeOUwUb+guggtANuYuXn9yuBcKnPYfJc3Varsfx7wWbwz29hxcJw5
	g+YySgfXOmM8hHhzzAsNkcKWaH6pBJ1EtGRoOGVvgDAW4C5kTSk2caoEVORpErgYyVXHHPw31Aw
	dmas9eMEzCewUV5leIA3/aVP31PJv0oDAStgz1nXI0tZjhIK8HpkWnRFm7yqVH6vPRdylbc8S/B
	Dnie385KvIK/K8jeAYl2cswC4vZxRcI=
X-Received: by 2002:a05:690c:385:b0:7b2:136d:240a with SMTP id
 00721157ae682-7b9ece5aac0mr252351357b3.9.1776931259677; Thu, 23 Apr 2026
 01:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Thu, 23 Apr 2026 16:00:50 +0800
X-Gm-Features: AQROBzAvsqNdWL8c7JxoMrUuUFDjBJrCLgdZwcoJLGOGcJKSspjOch6mGaahHfE
Message-ID: <CAGp+u1Zt7xjm9H=sY_BDV1z9-J5WaUZCcMb8KB5h_8eE55H5pQ@mail.gmail.com>
Subject: [bug report] Potential refcounting issues in 'drivers/net/ethernet/mellanox/mlx4/srq.c',
 between 'mlx4_srq_event()' and 'mlx4_srq_free()'
To: tariqt@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280656-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAEF444E4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Linux kernel maintainers,

My research-based static analyzer found a potential atomicity bug
within the 'drivers/net/ethernet/mellanox/mlx4' subsystem, more
specifically, in 'drivers/net/ethernet/mellanox/mlx4/srq.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
mlx4_srq_free
     --> spin_lock_irq(&srq_table->lock);
     --> radix_tree_delete(&srq_table->tree, srq->srqn);
     --> spin_unlock_irq(&srq_table->lock);
     --> if (refcount_dec_and_test(&srq->refcount))

T1:
mlx4_srq_event
    --> rcu_read_lock();
    --> srq = radix_tree_lookup(&srq_table->tree, srqn &
(dev->caps.num_srqs - 1));
    --> rcu_read_unlock();
    --> refcount_inc(&srq->refcount);
    --> if (refcount_dec_and_test(&srq->refcount))

In T1, the refcounting increment on 'srq->refcount' does not check
whether this value has already reached zero in T0. In that case, if
the refcount already reaches zero, then the first 'refcount_inc()'
will increment it to one and the subsequent 'if
(refcount_dec_and_test(&srq->refcount))' will test to true, resulting
an additional call to 'complete(&srq->free)'.
This is potentially problematic for mlx4 NICs.

Thank you for your time and consideration.

Best regards,
Ginger

