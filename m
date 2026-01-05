Return-Path: <netdev+bounces-246912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7ACF25A6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D27B3002D42
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59631283B;
	Mon,  5 Jan 2026 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hdTqEWRZ"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5855310655;
	Mon,  5 Jan 2026 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601060; cv=none; b=aQ53LYWP4fE6ryzo4+AqImlDQjZqZh8Blbx9gtXWDDKFm1tp/viRXIn3hvwrqHkFEKMsprGRBA8TPZA13jf+9uALkMphTi3XoFRjGVFjgOIVTKAFhrZz6TixTW+J6CrO5pFWxrl1DjM0Y7tjtmnSxnB0rthGIsKjHknb8XXHIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601060; c=relaxed/simple;
	bh=zKb6CEYkVPozCJjHj/3qRQAdm4aEU4Yi0el+RO9isVI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NZwJWr9FRCpUHuLi0k8N/HQ97QMZcy5NQAokSns5c+MhrY5gQRmrd2VOnzp6GnXKv0TtRCByKVRhXkJ10jGi9ZYfBoKBlPstQo0fj+wlHO8ZtQP8oUPn/k4tkI6UvSzKR+7h3J/Gss5+VNxnpw7GgnQMN5KEg1TTxQUQXV7yd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hdTqEWRZ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767601049; bh=q8PYrconV/pGJiTnOLgaKM2tzH4gfcBembmmbwnpvAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdTqEWRZZWPDJwd3bZ2B0A7tSviL085doleiZq9OnhhTf584ryjuvVTtVm08gs58H
	 BgOUn0GfPZbCg3C83HXjOHDI88rD0fzkiHVA822lU0DgkJkVP2G/q6xvKuDcEJJzsr
	 LFSwVZb8zXDZ6ypIp+skuDsg1ZuXezvu5uy0p7Fk=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 45A9DAB2; Mon, 05 Jan 2026 16:17:26 +0800
X-QQ-mid: xmsmtpt1767601046tk0l7qgbj
Message-ID: <tencent_D4B501852276CE87F53409B3B5F3C9E1AD05@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOiiFfNjyLDiYDUwlNR5+8OwxpXYAXJbW8qwmg8vv2SEkbkJsbX2
	 wYqNjcF+OIx010iKB4ApHEReDpa+28vnTwSdNNr7co7vFj0pZWfIjedNG2bv/niz++w+2PG1QAgH
	 a5F7455f7z7shUrT/1eXFFuvA+scWhR+jOHw74V1ISIIz23jOnRnVvjU4Tg4bfhh0GhEUVaGmwAx
	 HegTb2zFKG1F+HMUp/boF/OX2mlgP+kGOz7MBVygSUki+zQ/BxbKb4m3e/pBKSye54CKsnK766bd
	 ejjwJJjXwToCkcw3+d8U26jy5HSmnhiLyMIW/bTMEQJZkTCKPcBkuQHD3OHCL9nop8F8tZXh4DNW
	 EDrx060/F5WTGGvlRBInzlPTnQCPInk6RpnEGoKx8wBuBOLeNzRAoclXVHdpmYOBEzOwdnnYZ5Gv
	 77dWhxFUuag4y73dX4pv0VrUPDrzdEguIzbRntAzGUvgKWeTcEj06l+jQAUc07DFy0k/oiYBnQMy
	 +8hlip++5/uG/Q2G0op1UE1oo/1fOgEDZooj28h088gef8dLeMRe/+Lm+svomIwmp0MS7V81XQd/
	 6OPiAym5XNua3KHtIb79qqx0GEOiy5aB6bwNi3IZDPLUv90puw/D10o6RXtCG2UEiKNHZUVNOF/X
	 HGzGSrfb2PZkbmZ4Rkez9r1KCvysaPgDc72h7v+dVEhsTHsMGlJBhTLgvlB0BgGnZ9/5Vzk1bKVG
	 YyJUZGY2BtJrtsQMb45NiQj62zTwb6BaIKliw0zD5NP9ymZr9IAWEbIMLiIQwYbuXPpwXIsFHx37
	 WU0HMaafcpEJZp+9x/O0I17FIL/BHvwco02yjb9wQ1DYi3eKtDgb2OKTC6sjIX0apq0Koz80h96O
	 14hMnrF+d9DgO+JmrMYdhGLF5CQqcs3KLm/lVuFBErZr+Rp5aBYvUQeAatwsRT+6OYgW3w0kSctA
	 BTq+dA/9+DRpd4qhW3E94UdCENLAlE14L4RbidLowwkX/Z3g/CTQuX9njzVNUC5s6JS45iVzElzW
	 vYigj4ttrJr3eTlxx5VuwSbYaPOV3+sam5dZ/3Ynaz5xHB/haL
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: wujing <realwujing@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lance Yang <lance.yang@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	wujing <realwujing@qq.com>
Subject: [PATCH v2 0/1] mm/page_alloc: dynamic min_free_kbytes adjustment
Date: Mon,  5 Jan 2026 16:17:19 +0800
X-OQ-MSGID: <20260105081720.1308764-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <tencent_C5AD9528AAB1853E24A7DC98A19D700E3808@qq.com>
References: <tencent_C5AD9528AAB1853E24A7DC98A19D700E3808@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the auto-tuning patch, addressing feedback from Andrew Morton
and Matthew Wilcox.

## Responses to Andrew Morton's feedback:

> "But no attempt to reduce it again after the load spike has gone away."

v2 implements a decay mechanism: min_free_kbytes automatically reduces by 5%
every 5 minutes after being increased. However, it stops at 1.2x the initial
value rather than returning to baseline, ensuring the system "remembers"
previous pressure patterns.

> "Probably this should be selectable and tunable via a kernel boot parameter
> or a procfs tunable."

Per Matthew Wilcox's preference to avoid new tunables, v2 implements an
algorithm designed to work automatically without configuration. The parameters
(50% increase, 5% decay, 10s debounce) are chosen to be responsive yet stable.

> "Can I suggest that you engage with [the networking people]? netdev@"

Done - netdev@ is now CC'd on this v2 submission.

## Responses to Matthew Wilcox's feedback:

> "Is doubling too aggressive? Would an increase of, say, 10% or 20% be more
> appropriate?"

v2 uses a 50% increase (compromise between responsiveness and conservatism).
20% felt too slow for burst traffic scenarios based on our observations.

> "Do we have to wait for failure before increasing? Could we schedule the
> increase for when we get to within, say, 10% of the current limit?"

We considered proactive monitoring but concluded it would add overhead and
complexity. The debounce mechanism (10s) ensures we don't thrash while still
being reactive.

> "Hm, how would we do that? Automatically decay by 5%, 300 seconds after
> increasing; then schedule another decay for 300 seconds after that..."

Exactly as you suggested! v2 implements this decay chain. The only addition
is stopping at 1.2x baseline to preserve learning.

> "Ugh, please, no new tunables. Let's just implement an algorithm that works."

Agreed - v2 has zero new tunables.

## Changes in v2:
- Reduced aggressiveness: +50% increase instead of doubling
- Added debounce: Only trigger once per 10 seconds to prevent storms
- Added decay: Automatically reduce by 5% every 5 minutes
- Preserve learning: Decay stops at 1.2x initial value, not baseline
- Engaged networking community (netdev@)

Thanks for the thoughtful reviews!

wujing (1):
  mm/page_alloc: auto-tune min_free_kbytes on atomic allocation failure

 mm/page_alloc.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

-- 
2.39.5


