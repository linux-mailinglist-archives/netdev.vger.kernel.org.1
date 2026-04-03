Return-Path: <netdev+bounces-275002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DRBKNGnz2mZyQYAu9opvQ
	(envelope-from <netdev+bounces-275002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05664393C9E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9310B30715F2
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B503B27E0;
	Fri,  3 Apr 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpfbQd+j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3AUVhqi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8993A758E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216424; cv=none; b=h+2+zLISJyRkyb29Xl4kcLLAIMIC/w31pYIgsvoUBvRuftNmhw9ikkiIwIOmyhE2i5dPHPo40ZkY+Dku0jRJz4pOcvslshkzF6+4KXR+vhhYG6ocooHAdf8PBCS/YJTr44bSrgMYYs67npNPUeyaHMZD3Ohf95DK9phVGOeIWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216424; c=relaxed/simple;
	bh=8TN+BlZjPY5l08/Ao9K/M2zGY/MEGID9w+7QBFQZdLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWlnhJVlMko/8CL/6DdhDUoCkV77OP5Y/MxEVn7jFhiSPkjiLaTMr7vrkF/Prs/QqEWIW0jKm88G++mnfqkmiAVzN5MJbZf4+RMlZfx9zPJEWKKrWf8H9u+z9ktB/UjjhfXrcvem2mjxiq3panpDl0Nv1vCOrEafdYYpGC9yHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpfbQd+j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3AUVhqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775216421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppi0x+HSa6LF7yaD9isSOML84wuFQNIDT2AkWs8WtI8=;
	b=SpfbQd+jFLwJ1uhFrO5m5GdkxKZ5pvpCvX7m7wr5HJUkH5yp9AN5GTsoYN3mgIaJ1hxXYt
	Ck98C7scqb6NQA3eCc6bjorWAtwI+Tw85W5ZgVulTOKHV6eaMByCsup+3Z3aOUc94NbNr5
	9vIP0odpRmRQLV78N2LhbzgoFm8dlRY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-9i1xNnwaOVazCzKIpJ0mig-1; Fri, 03 Apr 2026 07:40:20 -0400
X-MC-Unique: 9i1xNnwaOVazCzKIpJ0mig-1
X-Mimecast-MFC-AGG-ID: 9i1xNnwaOVazCzKIpJ0mig_1775216419
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48544725bdeso24070715e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775216419; x=1775821219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppi0x+HSa6LF7yaD9isSOML84wuFQNIDT2AkWs8WtI8=;
        b=d3AUVhqiooJNkfXPc+IXHF5NRuFQV4EeG2rO12SX1wjWXFHfMkyYlFVAyyGbhBiceO
         eOq/UYp4Ynh5AALhIQK9CY77uhV1K7LJM5OJp+6pYA/YbpW5S9C/qvyFncAgkzHI5Mf7
         i617pv3TZI5RyW2WidA1Hwj/2lMVrXlmrC30LN2W4ZC7m7Us0QPh48AFJNcryDfaZrqa
         YCuORYwxnGwshw4ovHRcSLMDv/q4Rvmv6sp9s20F3ZjKJw64b+e3ZIywp5kKz7witphR
         hkgpBT3C8NTJ1iZfUER4h4lkcbXz3Uy2bfSkhCJuaBa94+uyXfr3N/oNaOrNTZAV29lz
         sbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216419; x=1775821219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppi0x+HSa6LF7yaD9isSOML84wuFQNIDT2AkWs8WtI8=;
        b=Q9FfbjxclTcdNsdoOWHLM2qijcLryWcxXytkcs6FautWm7N1hLAg3KyKwnnvDQvDbT
         onTsgHgarZnXgE/ykBwPE/FNZBPi6WnGBnwSx9w1uqPhH+XhjZ+VoE5n7U5qtv0WXMgs
         ZRViRagkoly/5Umr36jbQRUUuC11OVbHRE9FRY0+m/AOZoQrlFRcYqPBhduSu3dD009V
         QApiqjh9FEZRr2fRTC1TIo5tDuPi6tIJ+q8LUJG8VXCFscmAd+s4ODX+cwfhe7mGGz0I
         WCkv0TTVYfkoUCYkbX9D621VgR2L/J/n/mYHryVO2tleNqxjwXw/Nq3X+UVTo6RSl8pX
         0Cnw==
X-Forwarded-Encrypted: i=1; AJvYcCV7YHcSdVfuEdPjzEUIbrJaMOGoNnaPrDncxgOpnqa0H9HKVBQFBXiumFUnvjxoIzekNFzZG7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPvJg75Rau3hoQ9E46oJpnxr0I5ZrCQZTZeriCFdhvhfgCGWg
	4IMApehXR/5v1+735XSifgAXV8U29pM5J3iRW6qXrJkShtdAjEDf3lyVckbo9/G8d+N0yGRG4e5
	xBjtQq/kDfRrux8ItpL3YkttyDVtwoNH46w62C4RxJKfV0XSJWvALYtJDtg==
X-Gm-Gg: AeBDieupxBdW/ehQysBLZnVvro/79Fbg6OQyAppcpTF67D19b5vCHQJyhKHWL/Kxh7J
	EJWL4fFkpMNTFTtA48qAPvzcbopUZ6lNpYgbVyuOUENeiy+05KJb71kkvlSWkbnoT8FHNwRGOYV
	zlabvlUAp7LtJSH6JLrgISH9HGyZyfUfsxRBmpLDvLK1OzhPReCbD4QT0oAp+l9bvEersBhqacY
	qRjmKEkceYqxf/pvSRuE6D79HUEtCHCkooBW2O7/tMSWZQFkoYjFVtZ/cfuuIotxByLBnfyE482
	yA5UDNOjTpQKgpntq5MRC3WhPz8oRTXAuBcIb+4g2uc4EAlEeOIqq93xL8ubd7+XMYsbo00G5mA
	G+Velas6uOjE5c2NeFXHUEc/FCH8=
X-Received: by 2002:a5d:5f86:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43d292a9591mr4506593f8f.22.1775216418989;
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
X-Received: by 2002:a5d:5f86:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-43d292a9591mr4506537f8f.22.1775216418515;
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm15087517f8f.29.2026.04.03.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:40:18 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:40:15 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <ac-mZ9vHII96dTtP@leonardi-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
 <ac5qWSEBM--HuKQK@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ac5qWSEBM--HuKQK@sgarzare-redhat>
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
	TAGGED_FROM(0.00)[bounces-275002-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05664393C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 03:28:25PM +0200, Stefano Garzarella wrote:
>On Thu, Apr 02, 2026 at 10:18:02AM +0200, Luigi Leonardi wrote:
>>Add a test that verifies MSG_PEEK works correctly after a partial
>>recv().
>>
>>This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
>
>WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
>#11: This is to test a bug that was present in the 
>`virtio_transport_stream_do_peek()`
>

oops, thanks :)

>>when computing the number of bytes to copy: After a partial read, the
>>peek function didn't take into consideration the number of bytes that
>>were already read. So peeking the whole buffer would cause a out-of-bounds read,
>>that resulted in a -EFAULT.
>>
>>This test does exactly this: do a partial recv on a buffer, then try to
>>peek the whole buffer content.
>>
>>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>---
>>tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>>1 file changed, 64 insertions(+)
>>
>>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>>--- a/tools/testing/vsock/vsock_test.c
>>+++ b/tools/testing/vsock/vsock_test.c
>>@@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>	return test_msg_peek_server(opts, false);
>>}
>>
>>+#define PEEK_AFTER_RECV_LEN 100
>
>Why 100 ?
>Better to use a power of 2 IMO like we do in all other cases IIRC.
>

Right, I'll reuse `MSG_PEEK_BUF_LEN`.

>>+
>>+static void test_stream_peek_after_recv_client(const struct test_opts *opts)
>>+{
>>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>>+	int fd;
>>+	int i;
>
>nit: int fd, i;
>
>>+
>>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>+	if (fd < 0) {
>>+		perror("connect");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	for (i = 0; i < sizeof(buf); i++)
>>+		buf[i] = (unsigned char)i;
>
>Why setting the payload in this way ? Can we just do a memset() ?

Good point.

>
>>+
>>+	control_expectln("SRVREADY");
>
>Why we need this barrier ?

leftover from development, will remove.

>
>>+
>>+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>>+
>>+	close(fd);
>>+}
>>+
>>+static void test_stream_peek_after_recv_server(const struct test_opts *opts)
>>+{
>>+	unsigned char buf[PEEK_AFTER_RECV_LEN];
>>+	int half = PEEK_AFTER_RECV_LEN / 2;
>>+	ssize_t ret;
>>+	int fd;
>>+
>>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>+	if (fd < 0) {
>>+		perror("accept");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	control_writeln("SRVREADY");
>>+
>>+	/* Partial recv to advance offset within the skb */
>>+	recv_buf(fd, buf, half, 0, half);
>
>Why reading half of the size ?
>
>IMO is better to read just 1 byte, since it is almost certain that an 
>skb does not have a 1-byte payload.
>

will do

>>+
>>+	/* Try to peek more than what remains: should return only 'half'
>
>How we are sure that the sender sent all the bytes ?
>
>>+	 * bytes. Note: we can't use recv_buf() because it loops until
>>+	 * all requested bytes are returned.
>
>Why this is a problem ? (an useful comment should explain the reason)
>

Some changes are required to `recv_buf`, I have a working v2 version
that uses that. Thanks for the hint.

>>+	 */
>>+	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
>>+	if (ret < 0) {
>
>Should we handle EINTR like we do in recv_buf() ?
>But I still don't understand why we can't use it directly.
>
>Thanks,
>Stefano
>
>>+		perror("recv");
>>+		exit(EXIT_FAILURE);
>>+	} else if (ret != half) {
>>+		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
>>+			ret, half);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	close(fd);
>>+}
>>+
>>#define SOCK_BUF_SIZE (2 * 1024 * 1024)
>>#define SOCK_BUF_SIZE_SMALL (64 * 1024)
>>#define MAX_MSG_PAGES 4
>>@@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
>>		.run_client = test_stream_tx_credit_bounds_client,
>>		.run_server = test_stream_tx_credit_bounds_server,
>>	},
>>+	{
>>+		.name = "SOCK_STREAM MSG_PEEK after partial recv",
>>+		.run_client = test_stream_peek_after_recv_client,
>>+		.run_server = test_stream_peek_after_recv_server,
>>+	},
>>	{},
>>};
>>
>>
>>-- 
>>2.53.0
>>
>


