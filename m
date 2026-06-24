Return-Path: <netdev+bounces-301791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1PWCF+ZTPGr+mggAu9opvQ
	(envelope-from <netdev+bounces-301791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:02:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE1E6C1AAA
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:02:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jYTEBVPv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301791-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301791-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EFD0300F447
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF39305682;
	Wed, 24 Jun 2026 22:02:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880626159E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:02:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338527; cv=pass; b=JTmzYn5sC8y2l4ZZLC+fIsv9enU8g83e1qx8JKn5Rg6g48oESvT1BpGAtpCWtEjG82l2mbKivmBngIYQMDqIoCu0OhwBBNVJyKA/Z6ecEXlZe2YgVYcUOVDo5NfuBJNR2L4I7/7clqe/QK0PNjc7B3CcEvyXuvQTujKfHDQub4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338527; c=relaxed/simple;
	bh=7lfnvnV3tDsdkAeD8ENY3TZFcgviUe6OdssAmRPb6ME=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NAHxd4D2pyp/Sj5toQNtsZaiJw3C0Lc7ZVgma3OeUZynH+yGPrhEYeVEH/3fPeFQ6bhyAidDrSJW/GmusIXu4ZPM+Y0GINs91BrPXaSZsme9xuZ/oLrLMu2Sc8JKPrMEPCZ6IrUyBMB30+UPy4U28OxHMM4OWJDxCtRWwg6d/eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYTEBVPv; arc=pass smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-807bf286000so15188167b3.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782338524; cv=none;
        d=google.com; s=arc-20240605;
        b=GzXoHhs4sNa+2ZfJc3PLljeKNuca6kiF79ug9G8LBWl36SPvWrw8QV0Jzp0FnpjZps
         y3MEPtq8+lXx2H1yzUKBzLo2aXKhugk64Ly3qCJHM7Fx9Oworyx543SHcXt2o7Bw26JU
         HBKEHZnlRR8Yyt374rAtqXoRry67AlpeuFij53p0H3ZgD55itvSYkRLPrFWSaP5KtWqb
         nJlf6NGZVVTxIeZb/mrBRAueuJ21GXiw97t2GaOUDyYBD0DiZSUMujUc1ypz9LL1aogG
         v6Ea83DbYeUA5mVQhpPg/iKwE3z+vCWDG64zi9nNlqXJLkLvOe5UWAhaudnHAQBtTlmH
         KH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        fh=C3L6tu04vFMwBUWJQME8z8mha61IMUxp/NngiF3+MMY=;
        b=i2hOXx4YkO6ffOW0PQXWx79Vru4q4uRruywb5eoY88GpJYo3Gp1BZsDogHmaZOHOQU
         91Xfyq8HuYYUkQlOwRwBsycjOejMRB2BfLAe9hJ2g08Dozy3uTBmkIq4hqlD9LBqLva4
         y+6NxRWnSSYOIfmOTYseJ9UQ++xUxvUTwpCEPZ7IkmKWxbEYIb0keRt4FyCzmXaXUo5c
         ss/NM1Y9BVPqf/Y83iXmAy5aZVZ9rIF2f8jEL+ufkI1BdnBluxwX0TFoK0aBgRPtdA0w
         DlTtRYW4hfliQcEZHkWSecijSOgEJ7Hs8E0gGw2S4hj+Dlr69iyYGOG493B3c6p/TeP4
         ri6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338524; x=1782943324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=jYTEBVPv0Lq8+4hXuCybKJFhzU+GYv4nB7+oPItBwyD2Iy10+tL0hJhfAnIJPSvb5W
         nmSrzJImS6MvubZwWAFDCYrygJpoXiYK7ArvsqQzsK5uh3Jxy13bJfId7rjPLQ/yph/A
         tVbq7Jc1j8IEauss63loTziXBGbXib2MWMy7j2CmctutcndasghMnL3ofkZz2zdsUJ4v
         mbwNoYlEj+vuW/6tledvCuf0s7e6HGq6Cp0768V++FKwpQa77eheIwfmsq3Hua9oGSUT
         4YTs7TCyoRuxOtuM7XHy81zD4z2aC3J7mwGrff57hjudeYqMDBdMAzCJHiOXJ2XuG3eC
         eVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338524; x=1782943324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xItY7SuPRYPt+AaXU+DYzekCb5pQcTJpSYGHn52GHR8=;
        b=HGecuk3LwhzhEx+3So4XLNF/WBV1A2mxWrYq9L3xbPfsBF6uamfuRSkrkHeJLW0ArZ
         PWfW4p24J8sEHg6zg55syBh13aP2E1REg6sziNemhIO2w0+LVFWMbnGg6WnBqtrIHh+h
         CvZEfIzEti8Fyd99wMkwlIGEEkfzjPPneYpyx4cXQ0hAxmfTy5hHdx1/QFzZcj0rAJvz
         8ObspugGEf9C32YeDWVubL/MV9HgVvkRqETFSy5l/5ZhZlf6ZO8fhd5RP717BLoQhO7l
         56Eaa8LiaUwMI+EWfvkR21nL9hwkiJ4gpdxbkD7nq5FkcRKOQ4VHssK0zpK7Sn5CZJAp
         OP0g==
X-Forwarded-Encrypted: i=1; AHgh+RrAXQ7IH8pKBS+mh4aUGd+l/z1ZA7/KzaNPnf+eWFQecNJLdkj7tkoxHfFqI79qk5ymplxKYFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuNcLj2KdtEed8/ScrroZvmt8AzEEBM04x1AMyaHq0y0dQBUqV
	C9nsOM59KjCDJrbItxhCr4dUphIh9Ro607v5qgQ9YYT/L5kZkcEm2HGwiahmWyAhT/Me6HOrpW7
	EekZisVb+XiUyq/ZjXZ3wRLxL5nncFLY=
X-Gm-Gg: AfdE7clB8N2GJOWER5+2mfx1qspGx1SSPEJAu3V/1stkqFp0JLQ6P6wF9uVqxMH337g
	9EAid1/bM2rbtKZMOmg909oJ1ltzock5d13C9jvosxhndDuXVQhQOMVHoNHmbcjpd0kA6Kj2M0J
	CgqHcT+26RTEU54YYwHKARX0B845bi+GTMULPvt5tM5dA58bu5Z8muzDEaLjgAO4fsk3jBU6wlY
	Kwj1NmcNBXoh/SnXP45HDbNkifhH4iemMciBc3dIjxVDgnaXZ6cReaa1isbUhS/0aopwVrw
X-Received: by 2002:a05:690c:b19:b0:7f8:7e31:28ae with SMTP id
 00721157ae682-80a662eb798mr848857b3.48.1782338523988; Wed, 24 Jun 2026
 15:02:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 15:02:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 15:02:02 -0700
X-Gm-Features: AVVi8CdqX4PfLHQXiwpnwtEKJdmkwx9CQ3waCkhoXh_EjZA4ykU1Up_eDosLuk8
Message-ID: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Subject: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on 32-bit
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301791-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAE1E6C1AAA

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.

Reject sizes that overflow the unsigned long page-count calculation.

Fixes: 22af48cf91aa ("vdpa: factor out vhost_vdpa_pa_map() and
vhost_vdpa_pa_unmap()")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v4:
- Keep the Fixes tag on one line.
- Add Michael's Acked-by tag.

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

