Return-Path: <netdev+bounces-275009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IH/HNWuz2kjzQYAu9opvQ
	(envelope-from <netdev+bounces-275009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:13:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C9393F6D
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 14:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE7C308E06C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AD36B043;
	Fri,  3 Apr 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVuswBYh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF58d7+n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DA36495E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218221; cv=none; b=Gtg/r7h4IIX/Ucomu/B6CoNIIwVsMDcXuARBRRU7j9R3qkgv7h+e1i3xoiv6X2UE8AuD3xgeO8YEaCVYvYNiRwf1M64vt7h3JL7tqrVxSVkHH6MusoylbVOI/SkUz+yDlwtjtxhes+yq6BiQa7+IbOH35UrlmKw2zpsh4td4IuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218221; c=relaxed/simple;
	bh=gKuPZPZjAF2bu9KQLK5KUDtBDxAA9ZaVqW9WeXW5oAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU0jWg7Nai7hai4K8DkRuzdQ4EGFLlsYpw/JB50tXFd/HxDwLVyWIzEAggf82qkF6DE3oeqFg6/81KpeO2RtQS07/Z96sWnooJ7RnTrg79AGwyz7hw4fGmsGEI9CEoz8NgrsT8tL/BMmpNjh5qACk8nnlKSBqz22C0zpLQQTceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bVuswBYh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KF58d7+n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775218219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XT4Axufy1UQO5/IB2/wh8iVy7omBnkBDck5yhzPJ1BM=;
	b=bVuswBYhuCThhml6Abwk7Ce/Myowt/niNV9haqVC2w57bT6IfY88cuFKBy38gdSw+kiqYI
	isUbaOzM9AazkUCoYkTohQh8Hk69hmB3yH/iuz/5yV6Tel9wPj/VdPms63FcihTaXTrAjO
	ZV39lQ/yoo6lwVmovaGnePaJBZVdv8I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-AwvqERDVNda4nSki_8XPYw-1; Fri, 03 Apr 2026 08:10:17 -0400
X-MC-Unique: AwvqERDVNda4nSki_8XPYw-1
X-Mimecast-MFC-AGG-ID: AwvqERDVNda4nSki_8XPYw_1775218216
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so17542305e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775218216; x=1775823016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XT4Axufy1UQO5/IB2/wh8iVy7omBnkBDck5yhzPJ1BM=;
        b=KF58d7+nhyIaqSg4E0d5wKRbMzZOFvJLFSdfbWm6QgnLH0GhUI87u2s336dDkth5o1
         SZRJVQli1rp3hUR4WTFQaPPh86tkwNkpa2HpjtJ1KyuXIip3PTDSlXwrCxTZ3qJd2fr+
         UmPJktceXffZyvolQpVnyjFj1TR/g+t3SrRD58gQlUXjzeuTUTJ7btl9ynTJTlgSjsoe
         cdpaYj906lEXhbhTtuUdlSkN3i0HjWvkSaZOi5Xgbz1biDnjU/bWFgjyes1ePuF1FINs
         YEQ5OG7iSEODYt/758MT5z4rwz25R6n50TaF3lYte4ih5z0IwdtY7QEn3Z2iUAAjpR0M
         eaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218216; x=1775823016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT4Axufy1UQO5/IB2/wh8iVy7omBnkBDck5yhzPJ1BM=;
        b=mgbeNb2MYCROe5/bkM+bhh6L0UveRIm7mNd+lIJkj1+1gvc+Aa2wtUd/YAPgdE1dVY
         PfEdbAvfeu+k7JuNB7Xme/o0ZrJ7YDHpiRmSyKYuKZe9kGzCGwP6FHMOBoiaLDUES7rE
         QNkz00gldAry0Ki+MTwXQqurDyHbJb+zswqWEfN+bLC8M26h9szRjwwxCXGt3+qWPF6P
         k56mTTwrmrhNPjZSbaLskOSE2MkXGNSz1+uhLxoV6GNoTAUAx7NkezNgST0ltJjCqpjt
         hqcsonzLL6AU5YDNsE+VgGrIjqJBrY2r4luyR1jw3iuaRLHrGLdSSTQmNrdarluLws6+
         gPEQ==
X-Gm-Message-State: AOJu0Yw5eo1LawhlIuKX4wJL4rZdei9WIARxf6PUGO+1TnQxITfovT1c
	pk63PNJzzmfsxUaKd9pVPH44h1EGte4+Zdt+iwQZFEiUytCRJpYTeYEIF+LVBXPCajB9soDZA1a
	FaTfbtgPdYNqsTCEnI8cW55qb2TaJPtLc9MmLPcSBgFZKbDI5bA7xpnan2w==
X-Gm-Gg: ATEYQzyBPArFbb+clOMZ67cXSxamnAiKi/7e23ha8+OoSJbi9931v1yFz7epzwYYKVZ
	/Vyg470NW7Rct+5hg8clELiEGQhu8Fc+gYuh0vjhAhpFVWEYjkwb0vVw1Z7A+wbgrhcts+J3Wb2
	oDRKEkiM/jN/w8R+RYN1iz8QBqQzP/GpqlYgC5nXhsqhjfqOPdbHPJQVuo90fWND5sHgxcoishc
	l6FgwRgfWBaGYfJtKhdNKm/XCdwO+NjJ98UPcYCXsiEFLuxlf45AxY4KOFcH08hXxVPF6EmoxLM
	wHWPuS8sd+khP4SoTnx0J3tOMJstiNFgnLPEtc4MC0obGaQnrUu0/7TB/MXBpd/r27XHcMnjIsd
	qeOua9Y3vScZmXn+7WjKFz7Uvrig=
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr39169295e9.13.1775218216481;
        Fri, 03 Apr 2026 05:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr39168825e9.13.1775218216048;
        Fri, 03 Apr 2026 05:10:16 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm22557565e9.12.2026.04.03.05.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 14:10:13 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
Message-ID: <ac-uFMz-tFFQIOAE@leonardi-redhat>
References: <20260403093251.30662-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260403093251.30662-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD5C9393F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 11:32:51AM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When send() or recv() returns -1 with errno == EINTR, the code skips
>the break but still adds the return value to nwritten/nread, making it
>decrease by 1. This leads to wrong buffer offsets and wrong bytes count.
>
>Fix it by explicitly continuing the loop on EINTR, so the return value
>is only added when it is positive.
>
>Fixes: a8ed71a27ef5 ("vsock/test: add recv_buf() utility function")
>Fixes: 12329bd51fdc ("vsock/test: add send_buf() utility function")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> tools/testing/vsock/util.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 9430ef5b8bc3..1fe1338c79cd 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -344,7 +344,9 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
> 		ret = send(fd, buf + nwritten, len - nwritten, flags);
> 		timeout_check("send");
>
>-		if (ret == 0 || (ret < 0 && errno != EINTR))
>+		if (ret < 0 && errno == EINTR)
>+			continue;
>+		if (ret <= 0)
> 			break;
>
> 		nwritten += ret;
>@@ -396,7 +398,9 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		ret = recv(fd, buf + nread, len - nread, flags);
> 		timeout_check("recv");
>
>-		if (ret == 0 || (ret < 0 && errno != EINTR))
>+		if (ret < 0 && errno == EINTR)
>+			continue;
>+		if (ret <= 0)
> 			break;
>
> 		nread += ret;
>-- 
>2.53.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


