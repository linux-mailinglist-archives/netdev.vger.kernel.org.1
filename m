Return-Path: <netdev+bounces-276571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFv4LV9q1mnIEwgAu9opvQ
	(envelope-from <netdev+bounces-276571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E63BDD6D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3A39301B712
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286F83D3323;
	Wed,  8 Apr 2026 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wx/wCoWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D1381AF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659528; cv=pass; b=UBa+R8ooe/bJAg9giU7FNMsq0Il/flBnkrT8P87aJbzp0LttjGUiur5sZ73PUvOCrm7ObW3Vw8wAdLyLYVnJQhf/QK0XQlm9CwfynFCXloCIgVPGbOpyOhRQJeEsIiP0RbhhfiofrwpBCfkf8jgfdy7nykgWsGUCZsFx2Vi0CO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659528; c=relaxed/simple;
	bh=7WWEVmdRPiT7f289OaSJsFmfX9oA/TDlvLCf/13l4VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1UedF8/bbsqDnwJOVcP/+n9vsjtkAGjyMhmvoXhU2VXGsJghECYOmR6qn/qT6lHh2qN+GbPYnuKrdTC/QJJ0658GYEG2p09OuyCITbB9I2q+SA4JEcZNoZbMynfKiQnD4PIdIQkrfp69OPajnrklejLacglcjSeVJDGg9k3hVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wx/wCoWP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so12792a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 07:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775659525; cv=none;
        d=google.com; s=arc-20240605;
        b=BzMhKEREKvgwNk4zdWz9w35HPrKQ+0rJT/izecIJyvek9xPxe+QmPwnyAKF0b+EYvs
         gEBREP8EeIXWZsV6b/1TtXILx3U9IMAcC7FS/boIc6uUd2LcrZ7ekgp/OJYdCbhHd2z7
         pnCGIBAevplOM6WIt8mU+enp0m+jHdjWgISKGERASUHG1yUpzrMbVVTjWi+3YJJo3jRl
         bQPufOREIjka7Kj1eZnZoamHGSJr7ghB1CGqlIKn+0NDUxMtgeB1pzWdsrjj9ALDFmOd
         dGqRZJCNtTGfavxYvzYKgS/2MFJnHAKDA3a0RtGDEsSDdxZ9SPgDbxKVmQgusuQ8aKgr
         encg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MmqzRiNS6xuaL0kfejl+4H9dS6ueoOiO9jYV6nFXdlM=;
        fh=+4X5g2n0kfpbIeFGBTQEIGqvcvW090HeQXG5spiY+pc=;
        b=ZNudbXihqkLmjWyx9qawZtKNx8yFe+/7kHCgQK8lhHuGg4NX4Lbbd+LBP6uWBvqQQO
         6Zv/x9GRCrY0FRN+SHkSrb+IpaSWgDqJmL88884uOI3Pdgero3MBZ5uiX+mOdUuQdveD
         wVJ8gp/QGdt2D3qYFJrn9P/RAAwhPewDsFabUZAe+Bmqak2UutAtgmROOkmE3UuILEuX
         1t6m3xQwCJK1szn9pzFfFpPQaAzoB6GP/FVvmkzqxp/NOYogpcFkj8x4SYS9tY8Gwajx
         kz52ABjOf3jRUVNSK8jwLefMY/2R8ePIIEBgvDCmays3kIyRhBh5BZvWUxCip/iwDORd
         HKew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775659525; x=1776264325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmqzRiNS6xuaL0kfejl+4H9dS6ueoOiO9jYV6nFXdlM=;
        b=Wx/wCoWPvb0nTk4/abXLu5Nn8rzeF52qBN3BgxTDxHYlfwtY5rv8123+XwVqXcfMW5
         pYI9QtaVGDFAYOHlO9nDLgOocRZUDsLXR+CMxQzkyBBYAC6GXsqN4SA5v+X/6ocP66oZ
         fghTtgJWjHXnS8n6NGBWPF5BgYIw0lIbyDvvkeI86HCH4Xq+Ae9JUmYBUtZxFTXLQW/r
         LMwOJIgW8smmtf4ffjvYEyV6PdeiDi8RJS04wCJd0/2sYVbOAFQErDLGfdUDQzS6NslE
         879aISJZv/HiyJNybThgLV18aQ6kxfwPrNCV1Jp7q7qD+87yJJx3GEVRtnLcND5vjTiN
         pigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659525; x=1776264325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MmqzRiNS6xuaL0kfejl+4H9dS6ueoOiO9jYV6nFXdlM=;
        b=l8G1mcEXgg/SMQ6fD0O6pmlolkUySCd4QtUhkPp+4E6wAVqjcG1/SQjJO72jknF+WH
         uYM2OdejP6oujMA20Cctw3prjAdP9VV0zG0XLVUjKQ7vcc/jCxUKPzQO/P4QZsvk9ael
         eawHbDfJ1ZaijMpR9ZEfiT9CtvWySRksP9ZRzI0GHZ1NXQ1VR0L9PCkqZunxkYZttbL2
         taDSAo2n7Sr3xhSIPARVyMNSEe6ihKy19vxLwiRwfpL4iejH/Cvv0VLjXbmO++cMiRwP
         0hYQCyxQsUuNKZtAIHu7HwEy2GMphcIMoMOx7pz9LGcvFoiU4p+eAqHQMSSbEU4a3TSC
         9MFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlCS44vZ7IwyKqp/0eI1ycJh+53LExoQg92AO+MOQPAGfRsKkPvcToWm8wuM5gRMzEHwHdHCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5nIEP+S3FXTgIKLOOQImO6+tpvcmMpZPaxDV8d3/ZyjDKuTz
	+F3EgNGt+Hpgq0siAd5hvA4zBb/R7W2eyW14Y1R4EMxS43Zq+B0SZ7NVN6zYQs5mFU79FuUFOPs
	EM2klyvPlzO65SPhDXtb2OwPRhBqj2shJ8cK7DnwA
X-Gm-Gg: AeBDiesPYRGhFiswOI6RpHKLQP3CWVIQZYgRsNBAG4fD4glqywttefLEUuaQ1ntCXrC
	t7Zh2th7EnBde91g9popybcIINt5ChuvScj44zwk6XP5ZuT36J3+BgD0YfMpr8SHFZPKDKiHjIB
	axMc3ZY8u2KmRC6R667SDRnlt63g5jJ+chQqYgczI72dLYXrngKG3gCyerF2xrFQ0e0cwC0iGeD
	LXwE+5diTtTnRNVPqIJiHMxahHFOZ/DAmWbC0Idcp3Vo1QxBMd1+D4dxaWtd3uyyOq1sqBO3gMN
	ER+m2oGq3YR+5KsFipY6fvYgPxrO10lCFXJZpOOfLJW4dEDoJs2ldjekyevIzsb//41H/Dde
X-Received: by 2002:aa7:c456:0:b0:665:d39:4afc with SMTP id
 4fb4d7f45d1cf-66fed2719f1mr6766a12.6.1775659524299; Wed, 08 Apr 2026 07:45:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408002802.2448424-1-ntspring@meta.com> <20260408070514.1840227-1-ntspring@meta.com>
 <20260408070514.1840227-2-ntspring@meta.com> <CANn89i+6ZaTKZbQrjF_d0mbMkYYK4a5B_Neef9VsgpuVCsU6Ag@mail.gmail.com>
In-Reply-To: <CANn89i+6ZaTKZbQrjF_d0mbMkYYK4a5B_Neef9VsgpuVCsU6Ag@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 8 Apr 2026 10:45:04 -0400
X-Gm-Features: AQROBzAixdwItFNI5Ddcg54JvPPNmxeccVcYYNmiOUVqF_sfI3IH5Q0gsrV57qY
Message-ID: <CADVnQymujiNnVUrQBOJ8gQQY1oTvBiceZ63yTnPRzpX4+bCrPg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: rehash onto different ECMP path on
 retransmit timeout
To: Eric Dumazet <edumazet@google.com>
Cc: Neil Spring <ntspring@meta.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276571-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E8E63BDD6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:13=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Apr 8, 2026 at 12:05=E2=80=AFAM Neil Spring <ntspring@meta.com> w=
rote:
> >
> > Add sk_dst_reset() alongside sk_rethink_txhash() in the RTO, PLB,
> > and spurious-retrans paths so that the next transmit triggers a fresh
> > route lookup.  Propagate sk_txhash into fl6->mp_hash in
> > inet6_csk_route_req() and inet6_csk_route_socket() so
> > fib6_select_path() uses the socket's current hash for ECMP selection.
> >
> > The ir_iif update in tcp_check_req() covers both IPv4 and IPv6
> > because it was cleaner than gating on address family; IPv4 is
> > otherwise unaltered, and not having autoflowlabel in IPv4 means
> > I wouldn't expect a new path on timeout.
> >
> > It is possible that PLB does not need this (that there are other
> > methods of reacting to local congestion); I added the sk_dst_reset
> > for consistency.
> >
> > Signed-off-by: Neil Spring <ntspring@meta.com>

For the next rev, I would suggest in the commit titles to rephrase
"ECMP" as "local ECMP" (e.g., rather than "tcp: rehash onto different
ECMP path on retransmit timeout" using "tcp: rehash onto different
local ECMP path on retransmit timeout").

Rationale: the existing Protective ReRoute ( from 3acf3ec3f4b0f "tcp:
Change txhash on every SYN and RTO retransmit" and discussed in
https://dl.acm.org/doi/10.1145/3603269.3604867 ) already changes flow
labels as an attempt to change the ECMP/WCMP path in the middle of the
network. So I found the original titles (like "tcp: rehash onto
different ECMP path on retransmit timeout") a little confusing, since
they read a bit like they are saying they implement something that is
already implemented.  :-)

Thanks,
neal

