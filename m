Return-Path: <netdev+bounces-262676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFMDDmqfpWmuCAAAu9opvQ
	(envelope-from <netdev+bounces-262676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:32:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A00F1DADC3
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09D1B300788C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C03FD15C;
	Mon,  2 Mar 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOMo/0SW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qnFcY04Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08E1E5B88
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461866; cv=none; b=kyRsYk0Ibd9lPlzpu5SgGt/EbLF/0pwFqqTAP1Hb+wbf38LKt4EZau8bxIozRmEx6i4jVleHqBgfKgGdgSLMiwrIdsd3Xz40/A1NFJIKmm9I0EfW2K100lgS59RWh+EVEuKerCdqsVf1KDA9I/Osfx7RoFG3Noekzb2JNlekVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461866; c=relaxed/simple;
	bh=tu6vW5JzAvAhrtnD0Orm8DgWyEhTriU4R1yaRjCyZQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwDxU3bt5ymxLT0IpkjkUREz2D8Xx376thuV1Zb7OS0uqBSyXL50eqj4/lUUREApSaC+sPu18oRHEpJJQKC54EN0f9CKFQml7wDx+ceqWtaXt4tm/ZNIhYTfmtSOniKAYCLMQsfdMj0cfxmXopAtJDpzzdpXx0vRGWmiisgL60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOMo/0SW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qnFcY04Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772461864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKZvtx1jQH7FuclJfSavk4MXL11q6SiX0sIanHFtIBI=;
	b=FOMo/0SWrxVbghAOHZMptVK13+Y0e7xsTsV8DeeSt2FX3pg4vQeSV/MpHKrIZxvE2OzXBq
	KFhTsRyP7KrMgZoq0NxNX9A/3iZUgU2O8HnH8iFQBlTSlwW0obmjkThAmzMhQtWJk95zPL
	4xLVebMK4P1C19/wtcfu61gFUEuRUeU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-uvyLtve3N7GVjJDBHQ__iA-1; Mon, 02 Mar 2026 09:31:03 -0500
X-MC-Unique: uvyLtve3N7GVjJDBHQ__iA-1
X-Mimecast-MFC-AGG-ID: uvyLtve3N7GVjJDBHQ__iA_1772461862
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483101623e9so42293605e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772461862; x=1773066662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKZvtx1jQH7FuclJfSavk4MXL11q6SiX0sIanHFtIBI=;
        b=qnFcY04QZhtGR/Q79DN22LxyPSlJMCrxEGWYhXtPkaiY1vh7Y9c6rBygQM/CDxsQIX
         3i60swndx7rl3Qk6IUbhIckBLiwkOVlpweZiLr45Jpx2+7tITucbxrfNgoHlhztRFmHK
         kmWoXXVk7ClcBqvKY+Jt0bFsIkUStT+j40hamsbo9e7Kmxh1tROXFruxzfC4+BNjvA6x
         2HYQyduwO/VpocpHyRj1puBnN8IX+0eYxEPjHXixYKxyLbv/cIf8HRW29sYdEPL+3wrX
         Ek7SnU16GQD6LEhOJf+5qjYsKo8SupWV6SroRzE6tGFgXjYn0mVcHV5c60OJzBEX3nCI
         VBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772461862; x=1773066662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKZvtx1jQH7FuclJfSavk4MXL11q6SiX0sIanHFtIBI=;
        b=SoDdWI+7XSXkA8+n3a9BJMeYOvqGy8nX+3QBMIo3++XN49Lj/iesE5VwEYXz1gGEZh
         t7QS0ScQreBYduVvtYpChkshcgj8Fy8Dqi7AW1V+XkWozpCKbIzq3CNLSod0JKEVw6kj
         evXZshlcO+Elx/uiaAlS0sLJSEkG4y+vYQw/AFlXqq8oq30yPEFiBHM5WnaF3t3+YxRj
         f7lHRV2GwkCL+4HXXAkzC8uSkQCx/BedEhEJ82PZbIqPT16yAVhahveTgVhbyHJfDBV/
         yH6VMtgpRNsfQEsW44M64/pweXeNoyOqg5uDs328oZrX81C7WOBQ0pyisKgnoFZrLwKl
         pcWA==
X-Forwarded-Encrypted: i=1; AJvYcCXRty64FCLNo31IM8mTS1ikPU1c/G7MlyGncLM1ZSh8IL7A0b8POSTPxNB1SFK5ygRUMvUVeZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwcJuNmALEPqIFQWYoJPZcFRFJzmLxe0kQ0XuMX2ZknmcX1hV
	/1JxefoYv8EbJvQTqeAKEz+9UwppE3Wn1AWPaIPlAioyIxsgfMl/gEoxHfykbAwhKkcTLxTpW+z
	hWBumoJeNpKN4KLROi2J30W0ILIcLXa5auAX1uL80ErFSMf2gbaQnfyOqNw==
X-Gm-Gg: ATEYQzz2qHdyCwJ+OdLiAaDD+6meH/RopnTGQAfNNwcKFLdjwAd1Q7NTlPVWFkB/uGG
	lyzQjNpGHMajkTuvS83HWtQr5yRmrHD7911QbmRExDJlkwJOrLv3aK9HUx0X8SgLbcL/eioEx67
	Snmx8MkCAaE+4paLtpPP35owN3E95YOEnTnMV9OZyn08czBbkSPhRRvAbwS7H75pSWIPJuG9k2m
	CB0BkFzNlFjJqC3xePIKaVQnWkIrb4bzP2DfrzTq6UKCClbGOGDoNbuh2mEWiUsWOB4/81ZbznF
	LB5tV9A5cpKM7BwBEhu1T1FzPDjqFUiWN7xXGBLci4brb6PVCC2hngx35huNref7NYMPtA7c5RD
	K5S26QM31VxZgXf+B2XUjCow66IupwQa9JZK1J1JLEvUheumnMS6Tk7UZDNtYVTtp/j0tG/M=
X-Received: by 2002:a05:600c:64c7:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483c9c19a6emr218449465e9.24.1772461862162;
        Mon, 02 Mar 2026 06:31:02 -0800 (PST)
X-Received: by 2002:a05:600c:64c7:b0:47d:73a4:45a7 with SMTP id 5b1f17b1804b1-483c9c19a6emr218448515e9.24.1772461861478;
        Mon, 02 Mar 2026 06:31:01 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb318fsm206220415e9.6.2026.03.02.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:31:00 -0800 (PST)
Date: Mon, 2 Mar 2026 15:30:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, ShuangYu <shuangyu@yunyoo.cc>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
Message-ID: <aaWTjPXDqhMZlwLr@sgarzare-redhat>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
X-Rspamd-Queue-Id: 7A00F1DADC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262676-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 03:51:49AM -0500, Michael S. Tsirkin wrote:
>vhost_get_avail_idx is supposed to report whether it has updated
>vq->avail_idx. Instead, it returns whether all entries have been
>consumed, which is usually the same. But not always - in
>drivers/vhost/net.c and when mergeable buffers have been enabled, the
>driver checks whether the combined entries are big enough to store an
>incoming packet. If not, the driver re-enables notifications with
>available entries still in the ring. The incorrect return value from
>vhost_get_avail_idx propagates through vhost_enable_notify and causes
>the host to livelock if the guest is not making progress, as vhost will
>immediately disable notifications and retry using the available entries.

Here I'd add something like this just to make it clear the full picture, 
because I spent quite some time to understand how it was related to the 
Fixes tag (which I agree is the right one to use).

   This goes back to commit d3bb267bbdcb ("vhost: cache avail index in
   vhost_enable_notify()") which changed vhost_enable_notify() to compare
   the freshly read avail index against vq->last_avail_idx instead of the
   previously cached vq->avail_idx. Commit 7ad472397667 ("vhost: move
   smp_rmb() into vhost_get_avail_idx()") then carried over the same
   comparison when refactoring vhost_enable_notify() to call the unified
   vhost_get_avail_idx().

>
>The obvious fix is to make vhost_get_avail_idx do what the comment
>says it does and report whether new entries have been added.
>
>Reported-by: ShuangYu <shuangyu@yunyoo.cc>
>Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>---
>
>Lightly tested, posting early to simplify testing for the reporter.

Tested with vhost-vsock and I didn't see any issue.

Thanks!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> drivers/vhost/vhost.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 2f2c45d20883..db329a6f6145 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> {
> 	__virtio16 idx;
>+	u16 avail_idx;
> 	int r;
>
> 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
>@@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> 	}
>
> 	/* Check it isn't doing very strange thing with available indexes */
>-	vq->avail_idx = vhost16_to_cpu(vq, idx);
>-	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
>+	avail_idx = vhost16_to_cpu(vq, idx);
>+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> 		vq_err(vq, "Invalid available index change from %u to %u",
>-		       vq->last_avail_idx, vq->avail_idx);
>+		       vq->last_avail_idx, avail_idx);
> 		return -EINVAL;
> 	}
>
> 	/* We're done if there is nothing new */
>-	if (vq->avail_idx == vq->last_avail_idx)
>+	if (avail_idx == vq->avail_idx)
> 		return 0;
>
>+	vq->avail_idx = avail_idx;
>+
> 	/*
> 	 * We updated vq->avail_idx so we need a memory barrier between
> 	 * the index read above and the caller reading avail ring entries.
>-- 
>MST
>


