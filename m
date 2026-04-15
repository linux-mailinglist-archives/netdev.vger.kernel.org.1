Return-Path: <netdev+bounces-278751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOzQM2V432kATgAAu9opvQ
	(envelope-from <netdev+bounces-278751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B742403E57
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE723059E3C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187E336895;
	Wed, 15 Apr 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2nf7olA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqqrRiIa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099D2E0938
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252700; cv=none; b=FqZKujmLkk+gO91/dUFWlcFSLseWbg7NdL+qiWy7PAgc4OWvpgjn71bzK9wGXWeffaSeNNPaT4+NuLOJSOGB45zXt15M6MPJM4wYya2tFNR0ZNWDE7YLdjz8VVptPhbsFsUSfr+UM1aQNCV5dni0WZEI/ifrrjrlo5UzPG7x4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252700; c=relaxed/simple;
	bh=QLX1J418M4jWHF/CD6zKmlQZG8fsqg6qyHarNz+l24E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc9F+TNof/ZBfBXdIRxCWUtMpgw9V1RlVrB5OeBg7QJ2daPU9XR6iUu2TXivsd8lxpzPgYm0w6N7Pd0NjGQg3AbyopnIlrL2oS7njyN7OJcw7RAIwEp1a72ihji/Ldk6qPwXLdroUKUl+RMXMrkSfFFx3n5SedKFqhDc2xtpddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2nf7olA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqqrRiIa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776252697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
	b=f2nf7olAztvNmNsEpMWPTH46rdxshFlVR/Y+o5kEmDhoyLX72y4zAboS9xTnrvmmIskzXs
	oM32zm2lX/AIIlK8BWqOhyw8dile2uMX12GmC5mmZ/beBYxct4U8wybF2cPRcPur/42LuV
	Xc9PEypVSLKw5lxPyLsdMqhNFPHr+nI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-SXiO6rcWNtai0FwaeR1Zkg-1; Wed, 15 Apr 2026 07:31:36 -0400
X-MC-Unique: SXiO6rcWNtai0FwaeR1Zkg-1
X-Mimecast-MFC-AGG-ID: SXiO6rcWNtai0FwaeR1Zkg_1776252695
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso35565815e9.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776252695; x=1776857495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
        b=SqqrRiIacLIukQom1KZIcaycjKkh7czuM0KNoRgdqGyPlnHjHey0xkFNWmXOmv+oyo
         A3HliPYbKwFzgEe13rCbRJ20acG1J5uXPGcbE0TyQrFU2qKSE6QqG5Pq4TwLq4Yomge7
         Uuweg396a31kLXW9otPZgMY8+QKfusn1tVNV7zfld229r+ZUZ6adp0RpROUn6RuG/q90
         5FI02Jh1aq8qqGWA6zZjT7SBf3mJXTWunZj9D66vexZPunNcMlQngSuk0UCX+9qOJGry
         MeQbVNCwRD+5sA5NKbwskeLreRF2KINYiYRcTY60rG1IWqT5KuSnJiQ6H91qxhd2qAGJ
         GeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252695; x=1776857495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGpVm/oGR94wogmAdWmA8vqPEnCDIzFyVWrXuXhdJ4U=;
        b=LVaVVdKcWI0v1dlhYLqwcUsg83YJCJ7f2BJbFuuwnHp28jYeqBaI0N5QXkJSGRwmtt
         xTPgfxodU7qUi8ckgiEE0CDH7sPO9ERsEfs4PDyZyLFiVYyvZxR02S/V6mGfJgQMP72i
         KYYMOXs9nXJ7nJaw+FNzTbm6hYWVIeTfIozsFHn8bCl2Os6Wn4StyDcwexPy8XBiSeDP
         2kkvi+fKzUr5z3W7Io0FKSUn9pBJg98MkZLp8588FNYH5jW/gD3eeuzcDDyYh5UMbmqJ
         L0sEkp+5DrMf+fWRKMsn/tgNKdvCcWGeWRxBZYPya9X9M6jSk2zaM6/7t3ZSWNQMdlLt
         ypLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/nGevN2nh8Vzq7UBHsD5GkhPl2taaWByL4LaaJyxv6BLDPv94ThV6Wjxmt2m22EsLr6i0D+KE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx932DKUysP00tSfm5v0lkDxs1hycBAeRiD3BMv2uK5vMBlPDXy
	/4PjsZScUKwIJR2RUXHoFagzl7whb7oKvDTGRG6tzbpwSkb7PkFIhaTjA734JAnW9sit9yNNFrw
	FsrGkAqGKVU+S6cDn6Doo+/NstdMCniDBCbHdWtlpz/IcqKlPzkGPM+A3/Q==
X-Gm-Gg: AeBDiet5m1gXQKcMD+3m/RsRqCwSLTf75f8IDSb3Hla08n5r0PTHHX03fPkJVvBXAwj
	ogvaJIJSODJB+th8a+11v2DMFpCNiIDzqAsK6w1Oy0hOOzIjIRsfqUU6ty+K6iJCF8Xh3R5jMjN
	9QAX3UhuO9zTNO0UrhYz3TbZxjF7g97/5NDMT6YLbH0GUpMJgB2GAUkS3cz6Rzd69+WeWvzmGgE
	Y0Pw1ryhbyxypYtMSG7eIi7JZ+9zjAbEp4DSoeTPdFZsLJh+971oErZg9WcBZ0RzNPV3rSdq9x8
	VYDNyZXo9ps4FeNg6FCbEeUpbAo7AwZTN0ykedMYS4XXc7PmZaGAdjHKw06Vyml7ZFaom2cCXea
	kcALuJSaBS5V9ecrT5NqiiQXtFAipY+vU2l6mxjQYWrg7jp+nm+l4A2amivg27b+kfDGPhXFc7N
	7IDq294Q==
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202998215e9.19.1776252695196;
        Wed, 15 Apr 2026 04:31:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c108:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488d684bd3amr202997745e9.19.1776252694669;
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d6e9sm4680580f8f.1.2026.04.15.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:31:34 -0700 (PDT)
Date: Wed, 15 Apr 2026 13:31:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] vsock/test: fix MSG_PEEK handling in
 recv_buf()
Message-ID: <ad9uYrUjgCkW1D_k@sgarzare-redhat>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
 <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260414-fix_peek-v3-2-e7daead49f83@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-278751-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B742403E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 06:10:22PM +0200, Luigi Leonardi wrote:
>`recv_buf` does not handle the MSG_PEEK flag correctly: it keeps calling
>`recv` until all requested bytes are available or an error occurs.
>
>The problem is how it calculates the amount of bytes read: MSG_PEEK
>doesn't consume any bytes, will re-read the same bytes from the buffer
>head, so, summing the return value every time is wrong.
>
>Moreover, MSG_PEEK doesn't consume the bytes in the buffer, so if the
>requested amount is more than the bytes available, the loop will never
>terminate, because `recv` will never return EOF. For this reason we need
>to compare the amount of read bytes with the number of bytes expected.
>
>Add a check, and if the MSG_PEEK flag is present, update the counter of
>read bytes differently, and break if we read the expected amount.

nit: "..., update the counter for bytes read only after all expected
bytes have been read and break out of the loop; otherwise, try again
after a short delay to avoid consuming too many CPU cycles."

>
>This allows us to simplify the `test_stream_credit_update_test`, by
>reusing `recv_buf`, like some other tests already do.
>
>This also fixes callers that pass MSG_PEEK to recv_buf().

nit: this is implicit from the first part of the description.

>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/util.c       | 15 +++++++++++++++
> tools/testing/vsock/vsock_test.c | 13 +------------
> 2 files changed, 16 insertions(+), 12 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 1fe1338c79cd..2c9ee3210090 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -381,7 +381,13 @@ void send_buf(int fd, const void *buf, size_t len, int flags,
> 	}
> }
>
>+#define RECV_PEEK_RETRY_USEC 10

10 usec IMO are a bit low, it could be the same order of the syscalls 
involved in the loop, I'd go to some milliseconds like we do for 
SEND_SLEEP_USEC.

>+
> /* Receive bytes in a buffer and check the return value.
>+ *
>+ * MSG_PEEK note: MSG_PEEK doesn't consume bytes from the buffer, so partial
>+ * reads cannot be summed. Instead, the function retries until recv() returns
>+ * exactly expected_ret bytes in a single call.

I'd replace with something like this:

    * When MSG_PEEK is set, recv() is retried until it returns exactly
    * expected_ret bytes. The function returns on error, EOF, or timeout
    * as usual.

Thanks,
Stefano

>  *
>  * expected_ret:
>  *  <0 Negative errno (for testing errors)
>@@ -403,6 +409,15 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
> 		if (ret <= 0)
> 			break;
>
>+		if (flags & MSG_PEEK) {
>+			if (ret == expected_ret) {
>+				nread = ret;
>+				break;
>+			}
>+			timeout_usleep(RECV_PEEK_RETRY_USEC);
>+			continue;
>+		}
>+
> 		nread += ret;
> 	} while (nread < len);
> 	timeout_end();
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 5bd20ccd9335..bdb0754965df 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1500,18 +1500,7 @@ static void test_stream_credit_update_test(const struct test_opts *opts,
> 	}
>
> 	/* Wait until there will be 128KB of data in rx queue. */
>-	while (1) {
>-		ssize_t res;
>-
>-		res = recv(fd, buf, buf_size, MSG_PEEK);
>-		if (res == buf_size)
>-			break;
>-
>-		if (res <= 0) {
>-			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>-			exit(EXIT_FAILURE);
>-		}
>-	}
>+	recv_buf(fd, buf, buf_size, MSG_PEEK, buf_size);
>
> 	/* There is 128KB of data in the socket's rx queue, dequeue first
> 	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>
>-- 
>2.53.0
>


