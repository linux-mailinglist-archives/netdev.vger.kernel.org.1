Return-Path: <netdev+bounces-281872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGaECaK78Gn+XwEAu9opvQ
	(envelope-from <netdev+bounces-281872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACFB4864A3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E821332FFEBE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431FD19992C;
	Tue, 28 Apr 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePgWc4Fs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="osYpFarW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA233EFD3E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381975; cv=none; b=RXHopbloOqCzI2vJQKrWDRPtXcKomnIlM1uOAmBEEtYPNAal0iNOzXgun3r+1gWCcvjo+me/a6JLjanw8dYdKNxgHHDIRApw+5z1rTRrtCZhcsYXTTicog43y71S4Lnv3r58LVji1PAoVyNf4/5aK6gLAiiQByyT8EKgTlfqchs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381975; c=relaxed/simple;
	bh=ENP0+US9+uoSMKwsdCFAUa8StYi9uiDiDLxaqDcJiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp09uIi9YUeBxP/57HNCIGLOeIwJmwRV58ouFt+/gNq6tQoDF6mrVj34ZUBHmlEYyUL1k1dQYKG6EN91s9TSSHZs4l36/kN6CiR1ROzqCcy+8uDQU6uNZiy8paVVujmmgYdsVidn3SIjNHZOAwN4dYwiiUwhrZaWS8JHmIZbsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePgWc4Fs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=osYpFarW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777381973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
	b=ePgWc4FsEKSvIGT8d8UPpYA3d1ygcT8H14YcDuaG9AkbVgJzd9ssvzwGLJRBcGTSUCw6X2
	cmnL0AqCRGNBil3tGy3bNxWAys5Da9uYiyjwqC6Pcg2dPrmqwV7dn7eyKYN1p5JPkqjSsT
	Ks//biiSeOxVo34rVQ5CJcdHV/gAzrM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Rd0AwdWHMSORBVHfZIxGkA-1; Tue, 28 Apr 2026 09:12:51 -0400
X-MC-Unique: Rd0AwdWHMSORBVHfZIxGkA-1
X-Mimecast-MFC-AGG-ID: Rd0AwdWHMSORBVHfZIxGkA_1777381970
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d2cd2674so88917425e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777381970; x=1777986770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
        b=osYpFarW/+gzfYCnP1vTXAPp26eIN9gv09kD6jmCwFhEjrdjHL9bDatZ7kgtoBmneE
         i0DCcbUIBnHuIo12V1SPplpe6Z26XvcKYy9SViSMhj+eIp+c4O4anS4lrsKjgrVST1we
         j2XW+fUimi1of09xNwQ6uWS9st5TIvtXiSmEkiDL4Y+RVq1/WyKv3dl4CQh8BF+o61KX
         7zlOlSP5v73kvyoZqsZoMtBkRC5rjFzj3qwEoCSnjm14lST0Lwtmx+CAxi9NlAHEbtBH
         jmQZOWIA9bH9aT7ShbgTGGC1yPY5A4NN831cxIm9RGV4wVhsxZZWvbTz/UpjvkwseQxz
         hMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381970; x=1777986770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7GdUrfWfNS9OpD5GGiftL2t6uJKybTSHgDqr3QHoPs=;
        b=KgxAsJXMp1ZPTzJtsR4DC5mafo2/Z3LUhoIs8Syc4gSRDVnRFrgD75bqEFlEJo6TrJ
         dbitu5PukkyXkpf6Ijr8pPsDX+5UKXHsgvoDiwHj2UmYLkjKSufjNS45DxTp62Lrf5Ve
         eMqteGivZrdV89JSAuN5K0O4g01zxnk0nrs4gDx/6KaY1UY88QC3ktG4m81qlHt8u3Qn
         6pC5ZHDshiOkHZPp8qcmCzhsBI2A7DJZG/p3JtE9iu39Q+AekG+jvc0F1mxfCeQ+J0v9
         KA5zjXPN/kF52I/mNrzOkvvqa7RBLIob2nruGtv/IzO7ZcxKfSJTguunKnAf8OL5BiLi
         Xkkg==
X-Gm-Message-State: AOJu0Yy9bpL8Z6fRpX4U+7an68/mEwQZbb9yJlSHdb4XVKRiHJKJHOTv
	1vXYFIRD3ozAcLlKA3ubl52XWlRsdxopQSsksN06UWZJLhrATCPj9TtzSAnmqCsLQyzNbUjKn84
	wPXxDzof/seXpKQM9nH+SEyyRLfoZhdPn74mf5In4H57ExSa64EdJcJDaAw==
X-Gm-Gg: AeBDievACAqSLlpPoFq6QejJ6E3vpU4mH3ps17/Ib8s8hN/M7m79DgFdeh4hZwjR+Ef
	F8yuAlTLZvrvgGLWn11BarKws2lp9L5gwMqRMRh4vdxKMFaSb1yU6g90tnnE7F1uT5kIuWtKL7m
	f+SJ2sB0BonVRMklHcD0WLz0cyaWd1RvtOtojsosBESzQZPAgptld1dSyPrz4KDEOAGtr35K1NX
	8VdHhHm9AQ03+ophgIXO0YIglBS/lTq6QuVZea9uWPDEj87q8VB/JVnQ4NJAkYBN7MWLL4JiwLW
	CT7hv6aVx/lRrRBdiwGrqqD7i9kb8QL2IVnHvtFz0eU2emyovFy2bYGZEsgQIpdowZjisIKiS53
	Gnf+aqaD54uuHaNW/zacA3F2MtF22VNHZzpRp/GG3vAO16WYsO01QCKUnS9qyOSg/VbWPSEvlf0
	P2F6/Acw==
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248745e9.8.1777381969863;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
X-Received: by 2002:a05:600c:8b57:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-48a77aed628mr53248255e9.8.1777381969380;
        Tue, 28 Apr 2026 06:12:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f270sm6398058f8f.9.2026.04.28.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:12:48 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:12:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Himadri Pandya <himadrispandya@gmail.com>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCxfHKA7hJilGM3@sgarzare-redhat>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
X-Rspamd-Queue-Id: 8ACFB4864A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281872-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

No version number in the subject?

Please next time follow 
https://docs.kernel.org/process/submitting-patches.html#subject-line

   Common tags might include a version descriptor if the multiple 
   versions of the patch have been sent out in response to comments 
   (i.e., “v1, v2, v3”), or “RFC” to indicate a request for comments.

On Tue, Apr 28, 2026 at 08:53:39AM -0400, Hamza Mahfooz wrote:
>VMBUS ring buffers must be page aligned. Therefore, the current value of
>24K presents a challenge on ARM64 kernels (with 64K pages). So, use
>VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
>hold all of the relevant data.
>
>Cc: stable@vger.kernel.org
>Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
>Tested-by: Dexuan Cui <decui@microsoft.com>
>Reviewed-by: Dexuan Cui <decui@microsoft.com>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> net/vmw_vsock/hyperv_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 069386a74557..40f09b23efa3 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> 	} else {
> 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
>+		sndbuf = VMBUS_RING_SIZE(sndbuf);
> 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
>-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
>+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> 	}
>
> 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
>-- 
>2.54.0
>


