Return-Path: <netdev+bounces-276424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLNPH6Er1mkUBggAu9opvQ
	(envelope-from <netdev+bounces-276424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:19:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3013BA6D4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 122D4301D098
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2103B5319;
	Wed,  8 Apr 2026 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0NmZGeL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rXAAA3bs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B03B38B7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643503; cv=none; b=se9UCJczCLCIQv5Frte4E+MniAmkYceFxDpfDEf29RDsLD5sT8MnE4RSFjhpZshtx6TclgS283b3bAOwd3R8npNGncSVoft6AKIExOG9tKonCw98YRaBMNiDHK/vb2CCcLqtZG/T6QNy0TCED1nbnU9OceDdCgmPd2cdux/igPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643503; c=relaxed/simple;
	bh=6xSUwHLjkibUmQWK2HeD5Idw7sBp7VhBE/kVSPW3QPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm//7zW2nV96rXFgj6EU3M/ob5SsWgcA+COjC7RAvWa614tKrCY1hplS8hSN1KnMKX/BDlBaCef82ANmwgt2Kr1G4kq9qrvEI87IfcuMakWlW25pstvSTWf+4oY4mszv820ISSoumW/nKfwKjhqH4Yi6XN1NlsAo+PyQ7y1gMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0NmZGeL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rXAAA3bs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775643496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
	b=d0NmZGeLoud2awWSrXglrZ+tskoS26dw81wxhRs0VsgEQ0ZuFd0Sie6/c8Fvp/n0upfhRz
	tnx+jjdR9Vqci7aCBiu8pB360b9BI0Ftue0LEg9Fq3txBId6F74Svy95pDR0+eeb4JIn3D
	2fXrbr65RGrLsrYbw8SEK2pZl+y3zvY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-VNP13HO0PtuOIqyYH1nFdQ-1; Wed, 08 Apr 2026 06:18:10 -0400
X-MC-Unique: VNP13HO0PtuOIqyYH1nFdQ-1
X-Mimecast-MFC-AGG-ID: VNP13HO0PtuOIqyYH1nFdQ_1775643487
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c74405ecso3389405e9.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775643487; x=1776248287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
        b=rXAAA3bsiaRt3mvZCAWgOOBUKm+GB8C3WGb+FIQ/AG9adI50ax4uxohvRk/ymY28rW
         8uxXjISrwJqJS/gGcgtvwbwQJ1P5mG/nFNc9dcUsUSYNlzMjRVeZtuosR4auS1KgjZiL
         9mvZVDyAZ0OHqqElGF5qUo3W++2XU3au95NjPIC4yUW164q8hr5YyJZlPfU4VYI/XMJp
         bu0fjNJWEQtUdwCaWkvJJKfD2OstpTfj4ZNe0jphzk0kcDmkLPuDQJChQBDKXiGS14Fb
         7URjXpV7oBIbZM2vTI2+mUe0mxhvTc1010viXRuB9Qrp4Z3uJSRIgp20eN0PyCVhzCn+
         Le+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775643487; x=1776248287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfb2nFt+DWPOPwjJLlcYgP+BepPoSw8wC9wFBQagHJw=;
        b=rz4Tdpeu8ZNRWFXSlFPBXn66ht/P/avEWDn2vvv5C8uSWFUN4e9eFoxYhvms1F1dqt
         0/y22ESbvLsOEXUFWMV1W5gC7kGN2Th848OP7mZ1i73aCihWjrzjUumsA9XULCuvfUq/
         9e/4norD3vsNmQK/3GRNsgwqxEx1aPgFKjLpkuBe1Klwu3mY+yhw1yP1aG3iejq+lomH
         VZKYsc00W8blm1XrGrzW6biPQPoj0yKROlMPR8rbK3Fp8ku/LGBbRsmprREcJptzjid9
         7S+2T94LPRPprCdLHVxPZL0VjUvFggFurx6ZAaw3kaQraUT6tzoYNeAlHfPel0IU7XKa
         0ySg==
X-Forwarded-Encrypted: i=1; AJvYcCX6SJDktZf296dCORBLnIfSjOvjgzfAL1XAaK3XDhmc7EKzS8mJqUlwnCPiKxTyvB/xvYCvzdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7456DzLoMgZDz3EhUTRSBtF5ZuPi1hHQqqwvgiTPbNefz8Ga
	bJZuA0yCZjPvuLHJ+A1ZlWaKj0oRpFYxrG+6ZfSFhYk0etVJjbwPTyR4SWXtExlp3kn+5Eoj31p
	iZsqq9F57gsSQqf86n5LYbaWG2NiKkze58D4LLGeqmIm1GYTgJpV3Mp3wpA==
X-Gm-Gg: AeBDiety3rVEV23fHHitNtHFn8wS/L7GZp5J8dHzeXVHV2MNTtAHzgU4hjM53WlgSY9
	38rtTAcYKXRUlI7t5llRytiap9v8bprnXD2oZOMp6zeiFYXI3zuKpi1mb293TEziceIQQRbfv2y
	8Vtt6VoplCnbMFhXqSTN5Kr9sf8YGqUMeJQ+lJPPAee5Aw/mIcWaI2BYbskBkpBHP/mlkNN/4qQ
	WCtk7ZrMEzD2tIC5fOjQ3G0DDteTiWm8uRWKj5MeKNqqFxHxi7iQ07qm4sKQ09eqXeY63RkspKQ
	XbNHSJCFLWIDHkbcrgEqor49z5RJlaYYCwMKfzXBwEeXBK6dIGYcIO+EVKn4amOgEZrOQSAmrI2
	wabeJ09v03F0L4wWTe0kD3z8o37tjBByzIb900vnjjXEjhYfD30/UmXbJVDdzlgWqDzp2pR/10Q
	==
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282885415e9.29.1775643487285;
        Wed, 08 Apr 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-488998f488cmr282884915e9.29.1775643486788;
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c76d9ed4sm34393955e9.2.2026.04.08.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 03:18:06 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:18:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock/test: add MSG_PEEK after partial recv
 test
Message-ID: <adYoNtv8-fQLts1V@sgarzare-redhat>
References: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
 <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260407-fix_peek-v2-3-2e2581dc8b7c@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276424-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E3013BA6D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:13:57AM +0200, Luigi Leonardi wrote:
>Add a test that verifies MSG_PEEK works correctly after a partial
>recv().
>
>This is to test a bug that was present in the
>`virtio_transport_stream_do_peek()` when computing the number of bytes to
>copy: After a partial read, the peek function didn't take into
>consideration the number of bytes that were already read. So peeking the
>whole buffer would cause a out-of-bounds read, that resulted in a -EFAULT.
>
>This test does exactly this: do a partial recv on a buffer, then try to
>peek the whole buffer content.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> tools/testing/vsock/vsock_test.c | 43 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 43 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bdb0754965df..d38a90a86f34 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -346,6 +346,44 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, false);
> }
>
>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];

What about:

	unsigned char buf[MSG_PEEK_BUF_LEN] = { 0 };

so we can remove the memset() call?

>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(buf, 0, sizeof(buf));
>+
>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+
>+	close(fd);
>+}
>+
>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>+{
>+	unsigned char buf[MSG_PEEK_BUF_LEN];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Partial recv to advance offset within the skb */
>+	recv_buf(fd, buf, 1, 0, 1);
>+
>+	/* Ask more bytes than available */
>+	recv_buf(fd, buf, sizeof(buf), MSG_PEEK, sizeof(buf) - 1);

What about checking also what we read like we do in 
test_msg_peek_server() ?

Not a strong opinion, but if we go in that direction, maybe we can just 
reuse test_stream_msg_peek_client() also for this test case.

Thanks,
Stefano

>+
>+	close(fd);
>+}
>+
> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
> #define SOCK_BUF_SIZE_SMALL (64 * 1024)
> #define MAX_MSG_PAGES 4
>@@ -2509,6 +2547,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_tx_credit_bounds_client,
> 		.run_server = test_stream_tx_credit_bounds_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>+		.run_client = test_stream_peek_after_recv_client,
>+		.run_server = test_stream_peek_after_recv_server,
>+	},
> 	{},
> };
>
>
>-- 
>2.53.0
>


