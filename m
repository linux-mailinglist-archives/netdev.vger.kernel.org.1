Return-Path: <netdev+bounces-247000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6BCF3655
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FF5F3003B3C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A248C333755;
	Mon,  5 Jan 2026 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ij48lTOs"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB92333451;
	Mon,  5 Jan 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767614406; cv=none; b=QJ7Rh8Gcobxy1lKpsr1nT9MBxLuPCKkBng/h0rj60HK99uP0qh7DNtjUcr0LYl266rVmVQMnH+rwMMZ8WDElku+AsEz0suaqPEieriL0tacSywUpESi6iYvMztxOVLy/bx1wlf2AyayG1SF/n5yQIi3YQhsb1IYBXmGTxliMBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767614406; c=relaxed/simple;
	bh=n1qvQvUP8Tc1ge0D3hbyWIHdrfniwFulB8hQ3XwguQE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NvnYUJm7jAUIYdegINEXY2uYTVVQT+qh3vBJNK8aIc8AYbfaLaCBTPbWvGbgwlPC1eA/JmjmNhEV+C0EQnjwuA4jjq45RJHisF2WjTtTGFw4Sr/Bqw2WOGcgcWNVd3LTH+pqUaIHvOZpygd5ZNKNmDbU+Yw6sfyK0hKCSak9wTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ij48lTOs; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767614392; bh=ZHsshIjfSqIMQ3XoA6Iibo5+CynohV16uWOFfEhVjRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ij48lTOsLKkblyVAztR2FaTuDAuzHsgwF2l7dnWSCk/WxTWOaG1zRgSJ8yofWkP85
	 AaNx4FSlmsm5UeYHuaPrHF57FCaGWPBlmJ+hJc7BWK54yZLTs3jv1wBCsqjwIuwNNB
	 8m8Eweb+6QTi6ftjipWKshFZS1tQZcONmGQH1LHo=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id EF0A8E12; Mon, 05 Jan 2026 19:59:48 +0800
X-QQ-mid: xmsmtpt1767614388trjnbkar0
Message-ID: <tencent_DEB3B993C801A1D507C53976DEA7F6940D05@qq.com>
X-QQ-XMAILINFO: MMwjR1C73eIsPqlrovuwgOgybZRKqow9kNg5BmWF6S7qErNMeqkWu6+VQi28Lv
	 saIyjhbPxM6h4565rvqFl5HQLwuLy0ksvN5/jAk482wP0tf9Sub35FQBgMM7yZmodOpFReXHD0o2
	 u3TpfoOsY+mBedwitU7SouVYxpP9o0HPySkHPzZ80ZVz2BA9/MbYwkgDXsYaUMaCv1NBwNDLIm0s
	 IHWPTaxj7g1w4XGUQx3v0hK/1Y0P517UuqegKUTOSDxE4mGf3SDE9ArfThcJ0T74HaG/8c+EAjj4
	 ekh1Of2iguFcfWIfkWgGC6Xp4Ng8+uQUQOTtif9wZK53gYd0xjYOiy/6vSWpliRH6K/0rHLcpoo9
	 dlbChG0Xs88QmmKiffGx5pYGFIR4kxbi1glMjjy6tNWsOCutgRm34cmHIrNinhvsIhUXs9reDBuJ
	 9qBBUt+0sEUorbyy39MCslk7KKCoJkKvGsG9IlKngzQzwdVo5f1hw63wvYfc1vtG9lFtZ8w5EQlX
	 TBF27PDY28MDKQH7sNr/kDuA9AnRt/iQu9TeofyJluGTffgOGu6JyXfBtW7D1F3w+YEwNXfgV5yo
	 knUhcF2KcjtgLEnt0s0hAPTSsrFqjae0CdP/pPmY78PeqcD5XkgcJXtlXOA0TJXmGtCL9ZCpa2k8
	 ybI38GZSN4JcZVMA5hFDQhnrWnlhjZHVKRELVdigIx8lCROMez9lnpHqmRHhMXTsho3hdCj3aKdT
	 E0NXqEXavO5DBAZVxMLUOJ6aVgAPAQW/t9kEWbWwDa3GfSzmLr/8LUal6O1xVBxH3ISHfpuiXhbu
	 2kUu7rZmoPBIvOADuJDalWeBb3FeUbo6h/JQkHUMrJFy4hJOUtjLsBBWy9QHekp8qCL0rdscWUhA
	 y7GKzAADF5M0zSbV3/Tlw8HFfzJMDt46ZaWvl6YbYdcm6W/qGZY9FAvaNoe2ez4np7GiCAJtF+Uy
	 HWRMDmHktJ76ClJ+75Ca85zHMwG+wJfpovxjETvyAptaEEEpHfv5JGqSCoMtNfb2Vo7vcTLKyfIG
	 L5TFhtiQIV1F6ZhtBffoeD7dLBlMmo7yvn0IT+Zg+tGYiwmCNF
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
Subject: [PATCH v3 0/1] mm/page_alloc: dynamic watermark boosting
Date: Mon,  5 Jan 2026 19:59:42 +0800
X-OQ-MSGID: <20260105115943.1361645-1-realwujing@qq.com>
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

This is v3 of the auto-tuning patch, addressing feedback from Vlastimil Babka,
Andrew Morton, and Matthew Wilcox.

Major shift in v3:
Following Vlastimil's suggestion, this version abandons the direct modification
of min_free_kbytes. Instead, it leverages the existing watermark_boost
infrastructure. This approach is more idiomatic as it:
- Avoids conflicts with administrative sysctl settings.
- Only affects specific zones experiencing pressure.
- Utilizes standard kswapd logic for natural decay after reclamation.

Responses to Vlastimil Babka's feedback:
> "Were they really packet drops observed? AFAIK the receive is deferred to non-irq 
> context if those atomic allocations fail, it shouldn't mean a drop."
In our high-concurrency production environment, we observed that while the 
network stack tries to defer processing, persistent GFP_ATOMIC failures 
eventually lead to NIC-level drops due to RX buffer exhaustion.

> "As for the implementation I'd rather not be changing min_free_kbytes directly... 
> We already have watermark_boost to dynamically change watermarks"
Agreed and implemented in v3.

Changes in v3:
- Replaced min_free_kbytes modification with watermark_boost calls.
- Removed all complex decay/persistence logic from v2, relying on kswapd's 
  standard behavior.
- Maintained the 10-second debounce mechanism.
- Engaged netdev@ community as requested by Andrew Morton.

Thanks for the thoughtful reviews!

wujing (1):
  mm/page_alloc: auto-tune watermarks on atomic allocation failure

 mm/page_alloc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.39.5


