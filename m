Return-Path: <netdev+bounces-301786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 38tsARNTPGqbmggAu9opvQ
	(envelope-from <netdev+bounces-301786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5896C1A4F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:58:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ln4PsI+r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301786-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301786-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E673047416
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824842C326C;
	Wed, 24 Jun 2026 21:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86E28C5CB
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 21:56:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338183; cv=pass; b=gvCD9VazKFTuFPAIZzb7PiBJewxJ98vQhbxHitphs4a4mYF+K/8Bk3zzG/exSEhTYADxFe5Jxq/ZhAzy4Wm0T8V2mFWtrmzZz3qJfCU5Ypmcr09+5plSMzpsQ4w0GKfFclXBC6dOUDE66eOFN8n8GG1OO+YFE1vojWdqFblFBmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338183; c=relaxed/simple;
	bh=O1T7BsM1mJR790dEAc6emGIwnJEEqVArxUUj+UuSsVU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gpQolA2d10Yi+dEe9LX2HlQs7lR2hxMdg+YAZy7rd20z0zt50QbK9D8Lve+dDNzBnkj+QTGgxEkd+rWQdaJcpqMkDSEQ4o3y8rQSo74NHb45Zfju9dHARzbIP8JYzydX7QOAU57bHdAc1HmRD4P6u4dqNhXSCEMXVHPjZs+emuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln4PsI+r; arc=pass smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-805f5d1a6c3so16307677b3.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:56:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338181; cv=none;
        d=google.com; s=arc-20260327;
        b=P5PoOHs4IUNsommvnXjLBgPXhpzgp4lJJpX+D6GFcMh7nTSYFlUVOScQhPvUw6rkad
         4hZCq119DTswYo2kq9QzIwlgrGIx/ZGl2A2/PzwY5rraakrMcGxJuQ7VZL7nYfjdymK8
         wZic1Tvziq029h9nV0BS6Y4p3b7n7nS1IvqsIc3KiP2naSdOZimnMqQ9o4qrmh+XlFtb
         c2SCaOy7/iWLEQy9+8Qg4y3mAJTFBcS1oPpRZq/zHn03Lur0ZfLlb2He52Wy5LN8MjV2
         pbsScc0U38s1Zc1Oo/Ct2m9K+ttmBSmwVaBGedFr9rI6Ljp9fOQwyYSqyxSTjOEZ0unT
         RGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        fh=j36DsJ0VNei5E3xqyXqg8frhBtSAhvpaiwuY5PUVNyw=;
        b=pjBzAVvrymrwZ8GS+2YGqzqBF7WPQuqcFEpiLnHTGbtANxiXBfoFGiQI4VKlD9paM5
         6suHoI+fmOxy1DKwv2Y8J145c1nUKJqtMepi6SiKfIIRSQkoeJ+J2npuS+LDy/l/+qF6
         u30UntBr/6icgcFM2sWGm9EBnflnrY2RAmnDpkecsJJiXFdhLhRr6i+dMdTB6DM/JZhn
         37xLw3ycW9XU4iHzWqPycgOlvOYLudDjOYf/iVYS/cenVVXzKRcrP0LN677zcoX16khR
         QekKVsU/vVW6U92U+O80+tioW2pw42XBeULvOpPEyfov7on+xlSE17VDHDlswx2tpbeq
         vMvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338181; x=1782942981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=ln4PsI+rqtXHS3wnZsR3Et7kSgmam43rF93aBQkrqd/QWwqExuOsFcNI0u69eJD4h+
         Hvp67N1n01WntAfy4NcJ9x1piKTk1KGpz9kugi16OuyxcTM3BOkfOxqmDeDDPshmIHLU
         ml+jY2rXCjfr1dzchYrnSGmdOXoEcyip2/p0enklvUeH1qL45QJ+PII7IS2WObzL80Yo
         TbMF4ZQsL/zQ/RazEFLVFymd1Fq9iSbWOcHpsA436NOnR7ZTeMX3B9XLL3yzIZ+qKp9v
         +RJbR3++4VbSJwJTySRuv5Ds5zeHLtN6Be/iRA4l6RLAoyo8nVn9wEvKEnRyIiD8u4kG
         mI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338181; x=1782942981;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cG0L5wE2JOyF0l3KfEX31n6sxNxxq9vcNO1p89nvlFQ=;
        b=N+lXpbsYGJk17CDaPcv7AexNkqrO64pEUzCDX0fL6BpoL+atJoCXkZ+H+l5mjNIS29
         Sb7144SeMQ4RZAANDcK/ZXbwfSY4Y4j+5tZXkEM45ph+6tzKLyKglODEAs1KtmZC0H3q
         NIQr3/GoMhOPoUiOFc9lBORxx6Aobg0xY/qVdfDZ53TpYGyjl2hg1SE8JYzZUbYGw4x7
         B8pZ3N/s9f374TYDeS/IRK+VVR7L8TxNBXlCbdvIYaUAbIn6CHSOQBifX+23byQ/6pnX
         Yz6smiGJQc3c7+HdGxB9dSG29WxQFkcB7nZU/YfEZo86sws8K+Hn9/krN5tnYI0cGfk/
         FgNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpV5MExcO74hSW2IyXz3kRQ5y7+W90seCLIUc5XQOgodbgYkS+rJiLCqdnzW/d78jmEmtNG9Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxCzR1w9Oq/o693HTUGMEJp5cN4elMwhwQlhk7alQbMNf+5Gd
	MpPOV8pdAFzIbPoYmha81+qRyRV/PTZtJPhxuOKS1Sc5chj35C7yVJvnkHlK3+MjKQ4olfH4ytK
	Y9C2YJ1+hRs1rgR9gsERaY/soAfjLPoc=
X-Gm-Gg: AfdE7cm6P/JOuEAwgX5Rr/29BDYyEW6tUXozK/SwvCMQ7bJ7Wb4aTXbupm2XHug+aJi
	tr/OHZvTYxCmkIzTe4kUb5j5pm9PFTSzT16Xs3kYUrajggt5X3JtWxtuRPIJuH76RILqWfn/WN5
	CKrzsCYB0omsrEASN5YpUgdzh3CV/KwGDgyphUfvo7vpOPwT7gGJBVPvxfN6DukCM9RgliOFH4y
	p0EidVSvy7ctmkZVmkzMsiM3sP8bjPWcxTRX75xZnWTMaKn5Ewuditv9XXfQC1rHf7vFVPe
X-Received: by 2002:a05:690c:e17:b0:7fe:27a7:1c26 with SMTP id
 00721157ae682-80a678089ecmr497127b3.6.1782338181128; Wed, 24 Jun 2026
 14:56:21 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:56:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:56:20 -0700
X-Gm-Features: AVVi8CciZ2XEwtuWFeWZQavetqbmxlWkUIUYW-f6jq5xGyaQanvMGnD6EWJ2eVs
Message-ID: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Subject: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301786-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B5896C1A4F

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
vhost_vdpa_pa_unmap()")
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v3:
- Add the Fixes tag.

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

