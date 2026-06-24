Return-Path: <netdev+bounces-301783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NyI0FZJRPGpamggAu9opvQ
	(envelope-from <netdev+bounces-301783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:52:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B846C19CA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="RF/Bc85L";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301783-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74333018426
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F77277C9E;
	Wed, 24 Jun 2026 21:51:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7AB1DF751
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:51:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337918; cv=pass; b=c81MEFiMuoLGJs+fddAGooHWBGp2J7H0hvzpjf74QZAY/vr+KxZ29p162hlC4nw53AdaykxyIKGwtTIrs1cdyMXp13I0gB/r2zAQj7rZwWLHgPCg6RpChSyrGsUxoPfqrC2Ni2b/UoaWedA8L3xkOCiclUKSscfGwmRY1qn/DLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337918; c=relaxed/simple;
	bh=WaN4T3fbz8Ix268G4AelzWRoHuaajgHJySjLnaW2MDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BXXB4msgYlbhTBuSdiCDfykIkHCS2zJTq/W+snQE/SDf/Iwa8LqSbrDeJpWqReo5xW0qi5gRUfvZ8Lg42Kg+RZ7eeq2WvWQbTB75JN098pzZ/ye/ok6Lr3HDkfUqd1w8I1KtvkHUXC3nag8fMaVFSsi7+95tjH/+cPWQgVo1ftA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RF/Bc85L; arc=pass smtp.client-ip=209.85.128.173
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80260a90522so22263087b3.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337916; cv=none;
        d=google.com; s=arc-20260327;
        b=jmScBXignBlN9JroGAtQ35w/26lV6pdk7cpXOysjrdq8VKwZeUmKAmaD4XFGvP2/N5
         NOxew6HGxPNSJg+AWXTUePeSo9O6qc9d54Qkk8hR0LpqRua53/hpbAFSQLdGZlgC+HxJ
         IU+P4e7tnGHvtQHUHfBRDf/CJMNLaAjsVzAHvsW2IDnpzcSwQRvoU7dwBOnnh1j7aenj
         NyoHBycrHbJldpIv4WhS2nMTzIZwb/lmIhqWx2hdFIAJmoMyViYOy6BYJAOohGFJub/4
         olCT0fiSdnvBPGI19hLfjlRM2xJE7irnY4PjTMTesY+lOSss9HbTEPPg3kDRcgG2unPT
         VkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        fh=nTcpdv+qbVOC8g3GpO6w4B/28ijWjGWHIbnIuv/nS7s=;
        b=dW0foaw0xV9OsadRlUxGIBengnYDgQl/kbfY0/CQod8uCh9OPyux+buauuly9GY9HH
         2i/8BNoc3Y7kGZrRBbDBDeH6fHdtatgz5LPwCeADXR3R5Jlc3FVr0OtBb2WPQAtgf4Qq
         H/VSD1BilRjtok/HU6CVGObm/OtCCd+KY3db1cBKtQPUMLmowhEBis14MOngP0IpR7Ja
         M5clxLvJQw57i8rP3ue5QnYBXi9dtAdP4kVwIIM3q/u9q6NTgxRzJ/3lBLeWHBUENpXU
         /ssSVo/+rut4t4yyMib56ZgfLPnmJgkzD5rPqCGIPQ6K+pNRjK0FAiwDdGguQUfd2kbZ
         VA9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337916; x=1782942716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=RF/Bc85LqTbcwUVVB8x+8gfAWttuqs6TPWRM+ddZTH30IRk4Gfr2IUHh229ngysJRc
         jIPnOR7AtPxnRMLg1GnDi9ae1VajTJGEZzEpmtngXorhQ3EGaZC4jGR6UIYQxmLdELWV
         F85eBolqrrpfeYCuXeG/zpKhtWar+B+HZzXfhafHZDotnuBQf5q0fx+b0qbwPphAYssJ
         bQvNZylMbU+Y1K//xRp6Grt75ajYRujDc3kM3LBNe2cUUyJZ6cL8cBYs2BOb6yaOWiGz
         XGyaJBg7EZf8P0LrqGYDU5DO9e7GLHiUJj2xpV5N4KNiZAy3JzuDgwoXNHhE8KWtYcxe
         2s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337916; x=1782942716;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RixWKHZinu4raaWl5ThljyTjQxSCORSwNJIFX3DhaYU=;
        b=WJFjooAbwl5uo04tD+vbA6e6WPCnadaCInm8hAjsTGwxplt0Ory1ky0oSj5PEM5Bbc
         uMdwWEfrVTmS2juw87S/53WU2yJlt0C0PICtYTDX/yAyI7zrPJVo2ruOPpMm+f7V4vyn
         Pk00Dvz2tTXcusP1rpLXfScnPPEW6XMTS94iAaWFLpTMOsUji7FCEcclzMbuVgd9gNq5
         sI99kucSJXoAGzYD9JqUZ8wM1noaxgIBEz9g7rZnAW9lFROuk2kq4gxbX0CK6LpbRqeC
         PIuixPTXv4KQzKkh30fy276sKG2voTQ9m9vtvNAzLxJm58KeM7by1CXHcDJmiT1PVhYx
         ocrw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5uvREbCPI+CjuSe198GnXHAhlGfHLIeL3psACQAUnTyfE1L3faH5EK36gg2yOyMqKfdMRR7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuCNyVWyMRHlu2/ia3xQEUFJgRgPpMHo3wfbUDSQ4UFK/+7y1
	xuA3pLgJRIh8/Y1gcm4Cb+Oo1o0myc1rQZyx4soGDcl5EbWzuKljo4TBKIpvy2d9h8nvedqDUjx
	QRNrD4HuuM/cZI/+DYT/NvSiIc+8Q13g=
X-Gm-Gg: AfdE7ckAeUik4L52yPTMaNnUkWNxO/d0S4snl6sEnMURD8UR3AZsHfOfeHtPIYmB/ew
	juhVG6gOP7U4nOTaqwmIz39vv7T8SG7TMeQhAFCMxCh8/wtA2BEBwHnAXU12LSiVbuVVVPTFyMI
	KeZehJzgRxJlsgODCmwqMcsL0wiUGPXg2bJS9FVqgIMdJgydNlRjWrXrwsqmeitxqnWJqTx1UdT
	Rkx4hDTg+qhl1OjEQLYHSG8tyqn2C+RIec9sD8f74LJ7WsadYnjtvY+li7i1wycMxFfu1y/
X-Received: by 2002:a05:690c:a98:b0:806:8eaf:cf1e with SMTP id
 00721157ae682-80a698b8b07mr44057b3.25.1782337916257; Wed, 24 Jun 2026
 14:51:56 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:51:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:51:53 -0700
X-Gm-Features: AVVi8CdHz4x01_NrUP0s8m15X4RCCzs8WdYKYti90s1WpO20ye-Hi9vgV_npMcM
Message-ID: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Subject: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on 32-bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B846C19CA

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Clarify that the overflow is on 32-bit systems.
- Drop the unrelated memlock check change.

 drivers/vhost/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa..38b28ed3d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
 	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
 	int ret = 0;
@@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	if (perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;

-	npages = PFN_UP(size + (iova & ~PAGE_MASK));
+	page_offset = iova & ~PAGE_MASK;
+	if (size > ULONG_MAX - page_offset) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	npages = PFN_UP(size + page_offset);
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
-- 
2.54.0

