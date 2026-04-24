Return-Path: <netdev+bounces-281006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DBJIsyO62k+OQAAu9opvQ
	(envelope-from <netdev+bounces-281006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E607E460DC5
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C06C530056FF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409FB3C944A;
	Fri, 24 Apr 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvNpa1Xr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0577375F67
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045118; cv=pass; b=cKgXSxZ+VAgT3O42I/HWK1FLMYJOQ2V9lq7r1XxXStXqnCVzBjokIxB/gWIatO7OeoqqkwLIY010cxGEZprrQ60OntrUSz8v85uSUR/pQiHcPBURMgkb5Ut+XtxW2GMb2+CP9gjNF9W1gSflYf5QgDYChyP1sSqoTpFbcC3nEDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045118; c=relaxed/simple;
	bh=t2s8TOYKzXfm5hu2EobCVmvlkuIXHiKwz45fcRLOMeM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=krTx0GAldI4ftSQnYnt+jGXhcoKmKYTbDAUtPpxv5JURnNVl1ja7nM0F7b8dxTz1EhkdPRz83TaTmhhwqq5SIhLx9ekYM0EwLbdTx6b5tE1yvnIajq/yxjsdlyiiHI5SSPA8RCNpteL7qxRzbtFzEpuZHUvaT55Jm2XhF4sIp+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvNpa1Xr; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7b186dfc1d0so116138327b3.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777045116; cv=none;
        d=google.com; s=arc-20240605;
        b=lYl0ZXFgSzG0m/FPov6A3rRr/jsSwj05BpLoJY1WzBkaqWHqFyzZhUJwdibXqfoScS
         oPmTdhoIWoG+iONySs5LY1IELS8tjtl6HgRvSV5zj/3JTzuCHLR6c26Bt0MKS02GPd+O
         q7WHbdpr4612n90AO4rjO1FRtmpxadwYIHnq6F9RmaNzkzLTCNdBky3Styz5r0ITfNtc
         /7YKChu+/1+bQGyV+f8u/dfL14xhBHf/tQxyqtgPDVaXDenxIRg+WfxjduSmMNG/mtDE
         6VwdjBKswehkd1jxE8qDcZwEUAhexZJgOtKnUDdODI5NEC1+ToWSq7jp08/hsIPq0mxm
         2kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=lFIO3uQpbUozDPauVGMEhXnxUhDHFob+Eqm+rPUSPpE=;
        fh=qjnuJwxat15Ik7BDKodJDPh6nS4+1Noq0e1B2tj8WKE=;
        b=CgHwADardn8oRPq76ZrriEn5WMi29Tqyqul+GjfOhYj7M/fyR4kewmJ2GyFm8hX71e
         4SOBK6lCciSa827kYhYRDLlWZX0d6GngJI1flZbMZkuTYUPR+oI4dyq4yCUN9djyR47/
         oSj5I7YXTI8y3SbnincNjPq4IiZ/oFfczH9CzyZp/8CC0SwcY3VI4zA3SVId7bBnA2oB
         CwRJr4c16eR7ble1Kwr3KSKobSeNTc+BSPQwDK8jPt2ilZXaDyGMkZcYsYVeYRc9Gz5Z
         /QnDogp36bfD9wvoVQE80TrPzxDUVVCDZJiYr1341CgEbg3yTlafSxi55oPl3RwW7It1
         YE8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777045116; x=1777649916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lFIO3uQpbUozDPauVGMEhXnxUhDHFob+Eqm+rPUSPpE=;
        b=QvNpa1XrZ8Y+Ned+cnHbten96mIUvqNqfXOLyrebXWgXzYfPtfnDj7X5JffNmOFPuN
         9GXiFRjIg/YNfJz4BdTfIySR8bGXjS/qFvrvPtFSU0IlaOEndHrOmcCXkbtqQfVdXdL9
         ak2z9SEIjHsH6iPWY1n7iANlVdkyR7UUH8ztwEFyBQbueS0ezOW0UbXtxy8VwvO5rfPX
         1RTU9wcwQxcjFN/WOcsWeeMPg6e+oYp3JjYHtOyBQYrbZdF//uqBBcjiqc0ku8UrX210
         A9ir838S0Qd8J1ZieFC/HWkGqJE5o2DlirQJtKc3XwtvPR6khLZ+zZG1VnOD5D4zCi1y
         q5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777045116; x=1777649916;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFIO3uQpbUozDPauVGMEhXnxUhDHFob+Eqm+rPUSPpE=;
        b=IoMnU+JhQYcovucp5oyT0EJKHtF1DBzLd07hCOxvmaP0302dltcaayq4zIvQAL87YD
         wK0VO3qx9sx0WwtA9GDGzqV7N8wQ4tKd4mP0Ps/nG7JG2IuSyZ6h9TbXgMjT15eFCAtg
         iBf1NoasyUZGkGPq6MThx5Lq5LjR971vgZVh9bMbyLTYEv8M2LpYjKn+hieZwO2UBZKI
         AiuNtKbPTqpQPSQVejzdGkv7r2TkkD4W5Q7BZIEZA9T3PtfF2gM4YlCsYZkGj6yU9I+B
         lyolm4xk/3rq8WHLU+gMdwZvKzLK7GqLHzD2yfMeJSzjeeZoUNHwtkTyrkoRbgXPsMVc
         WtDg==
X-Gm-Message-State: AOJu0YxB3KE2r7p6F4JmqCcXkJrO1qmcr59taJEBrZPFjrZQRuvTVa8l
	DCUs3Rap+NF1UzUJjV71/B/qcjC++8Gk5jz0qFOVCrlzQdzfaFUT1f2FsepWo8yEwwj/8CBD6Lp
	i4c3ayF2/26iC3hUYNEsv8ZQEkIyO4og=
X-Gm-Gg: AeBDievr+5lc+YpNQaCfxodNhbMhkH4TURuxkyKMRj/lFJ/l6oF+MY1YPjXVi01Bm0w
	nJugj8Z1F6NFSF7XY9iZhfCj9tYaheAhrzAqfCWj+o7E0k6SJ6d1PRytCFyCH/R3gtW1c43bag/
	ZTJHE9vpDsN0GeA8y7dp3epsxWutjZ3yNuKSdfaTy2CTXshVFzClJnMbd5nXqko6QRBwcr8m/jx
	kBaYsMlc/ZQhIb59/xSQlQFGoJ0JuZURM6j1N2jlWIwhVJpwP52MT72KDWsgXl1ddoBwThpXUt2
	KOyzFfOlglozizBypQ==
X-Received: by 2002:a05:690c:60c1:b0:796:335a:895 with SMTP id
 00721157ae682-7b9ed276d80mr249748887b3.6.1777045116040; Fri, 24 Apr 2026
 08:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 23:38:25 +0800
X-Gm-Features: AQROBzDa-ba3rxrcGLluwm_UKDLvPUDqU6X4wB1CkviEyhJRfKGAD_27cMY0vDs
Message-ID: <CAGp+u1autEHVxgs1pdqxz0kwExuKE3+XmQOtTC5bv-R7WU8nBw@mail.gmail.com>
Subject: [bug report] Potential order bug in 'net/xfrm/xfrm_state.c',
 primarily in 'xfrm_state_walk_done()'
To: steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E607E460DC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281006-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential orderbug within
the 'net/xfrm' subsystem, more specifically, in
'net/xfrm/xfrm_state.c'.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
xfrm_state_walk_done
    --> kfree(walk->filter); [t0]
    --> list_del(&walk->all); [t3]

T1:
xfrm_state_walk
   --> list_for_each_entry_from(x, &net->xfrm.state_all, all) [t1]
   --> __xfrm_state_filter_match(state, walk->filter) [t2]

In T0, 'walk->filter' is free before the parent 'walk' gets removed
from the global list. Thus, it is possible for T1 to still get the
same 'walk' by iterating through the list linked via 'walk->all' and
access the 'filter' field, which has already been freed.
The concurrent buggy order is t0 -> t1 -> t2 -> t3.

Thank you for your time and consideration.

Sincerely,
Ginger

