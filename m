Return-Path: <netdev+bounces-305766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5OP5G04wTmrIEwIAu9opvQ
	(envelope-from <netdev+bounces-305766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF09724B06
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fSIgkP4a;
	dkim=pass header.d=redhat.com header.s=google header.b=U43iV86f;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305766-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305766-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDFFC308BD21
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA33842E8EC;
	Wed,  8 Jul 2026 10:59:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F244242E8C1
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 10:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783508397; cv=none; b=EQOUU2cd5SM0c2/xiS+UGvcZgqizs+uEyUOBfWJQXeEjODrIdO59H6ljURFe3jrsa3DTsJC3xhRFxEl5qMxz5f77rDKC3v/tC14NKr2xMmsdQtD+jFV7HoMHCDF+jXeyzpX7EMU5C3pua/hMO2c6AMOw3/7w8Zbhtk+bqCuA/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783508397; c=relaxed/simple;
	bh=Wxh1h5TWAdT1dv/JQYXllO6752pAMRojLLF30bzxwcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4tKPkzHPxQ1J1ZSsLi4ISDQkR+hl4VpLrnTEBUiiYjy+mtfOfA4dEicFt62xb9H72JPpDmjQG5Qb4Sx0rQ/9dmVP826Et3bHlTxX6L9P5ujOmEWPMF6dJNXJST2If9atu/LQ76//tddapYp7Ay/CVB5BKvkrVvDFDnI1Rabzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSIgkP4a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U43iV86f; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783508388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
	b=fSIgkP4aB8vRI30T8/D1IVgLDQMg6UJqNGmESanK4fH0qws8UEKVIfwGBMmTBnmHqstjvg
	GJz/YUzukx5WzVeKEEVnQxjmjelT5/6q38jJ3UB91pbDQ0jdT0GuIvTBQJKj02Em0H+e/I
	4XpsKnuzjanPWBwPABMAXzyQZmtZfUA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-e-FZ04W2O1K4TVrlcgujeA-1; Wed, 08 Jul 2026 06:59:46 -0400
X-MC-Unique: e-FZ04W2O1K4TVrlcgujeA-1
X-Mimecast-MFC-AGG-ID: e-FZ04W2O1K4TVrlcgujeA_1783508385
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4773d2405c5so761585f8f.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783508385; x=1784113185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
        b=U43iV86fQCWGaoUI/WbpgRWUHK8p0DDASayl+U6HMl3tGqxvancJNoM0c599lEZw9L
         20rXFVd7Le8jtiCtOTnNoF2ec0xRqSep8iJM5MBAfHPsSVuD/vxEY291bip7esSQ80U3
         MRO/J9rVE8PwfMgvW1wvC0GIQ1Eucn+57cmgJ9wxkTO5aJ6eUcRm0TBZVNaaBtZi+hP2
         f50H7ZEqCXlnufZgQUeK67RWMPp1f8Q8zFJjdRu4Fumh88QjBpFzlWeLzbU16TL2r31N
         1VhKcCdBca0ciN0ndeoB+BoJTR1er/q7Oo3VPGfPOxEdDg7eiMZz7dqFU8YXlilHRLbQ
         HYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783508385; x=1784113185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6E0ixpEMrHT9a5crJiV6RHWP5trgVnT1h9yDneEUY78=;
        b=H0NkuzARQZ8nzVFnKzSKfCr6XzoaHzS1oxs/164InL3v8w4RgxIy56gZxmZBYnGq9t
         N0T0aiy+vXRT4l8icVu6W3zOQZOmjiK9vACi07SZdTvDLa+c9ernhfnczstFicdJATz/
         7XL3hpILuogS3AF6f1mNMyAfAvQdZCbCaPhn5kABoQs7Kl8On4fZRPBUK54DTXlqGKzK
         ClffNsZexIXR2cUfx2kAyLprCjKC7v07cimHadt9F/yQhjtk1b3UgZP2RSMhwmHxDL69
         1BL+17+o6yBEg64C3NhAtIOi+ObTtWoYLBe34VX7NZ9J8kbCtaoBAeIsGMvwnhiVVME2
         rnBg==
X-Gm-Message-State: AOJu0Yx64QmmK5pgL05PxHIrZfNnBH0s7smIQebE05o1xBR6NdcWTIQ8
	Ek6EBFKFReag0Y8Hvulgy1JFB3S4t6crZdpR7L7+TMOec3R8e5SXtZ2qD+d7ENBJBsObLPM5h/D
	J5uu1Rvzcp2ZxMGwykQogIuMS5/W4FKdUZ6Q2gdw77M0S2nfEmVPie0rS0Q==
X-Gm-Gg: AfdE7ckTcG1ovbapTiSqRRD1unkJ0aZq7PF0jctmmCJH5jZpneCJjMfmYX/eP6oLve8
	Bg5FAbIJg8JnrEKlUqFyD1/g7+4Yzh4HkWSVDcgd5WN4YlOda1xsgfwewR3g7ePWVDsSLfBbQZB
	HKLk/Uxeh3/XKzcTXQPApOn52jkIsnjfoM73+JbGWMe9ifTGfr6BvJ7l4h9JwR77fiHJDSt/rhZ
	LhXSc7q+PnIwVEPOvslYxrv2vFuM+oW7mrWI20C5J+nl0pG1T0SgKiwqE7V7Es8um0VbQ2pEq1E
	eo5N96tAuDBQnPQ3OH70qnDG+exBAa4uHGNRw6J2C4ANlpz6Kcrvztqs7Vdazf5QkfrQ639I/qB
	0eP5zoJ1TjeWU6HORPhiQIvpsy1MeTqUw
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128504f8f.16.1783508385269;
        Wed, 08 Jul 2026 03:59:45 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:475:5e4b:588f with SMTP id ffacd0b85a97d-47df075a119mr2128475f8f.16.1783508384801;
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm43295235f8f.2.2026.07.08.03.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:59:44 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:59:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <20260708065853-mutt-send-email-mst@kernel.org>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708102904.50732-3-sgarzare@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305766-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,linux.alibaba.com,google.com,redhat.com,kernel.org,davemloft.net,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:jasowangio@gmail.com,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:eperezma@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:pabeni@redhat.com,m:virtualization@lists.linux.dev,m:kuba@kernel.org,m:jasowang@redhat.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEF09724B06

On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> Add a test that sends 2 MB of data using randomly sized small packets
> (129-512 bytes) over a SOCK_STREAM connection. Packets above
> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
> forcing each one into its own skb.
> 
> Without receive queue collapsing, the per-skb overhead eventually
> exceeds buf_alloc and the connection is reset. The test verifies
> that all data arrives and that content integrity is preserved.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
trigger?

anyway

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/vsock/vsock_test.c | 87 ++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 76be0e4a7f0e..b4ff9f946565 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -2347,6 +2347,88 @@ static void test_stream_tx_credit_bounds_server(const struct test_opts *opts)
>  	close(fd);
>  }
>  
> +/* Test that many small packets don't cause a connection reset under pressure
> + * and that data integrity is preserved.  Packet sizes vary randomly between
> + * 129 and 512 bytes, above GOOD_COPY_LEN (128) to bypass in-place coalescing
> + * in recv_enqueue, forcing each one into its own skb.  Without receive queue
> + * collapsing, the per-skb overhead eventually exceeds buf_alloc and the
> + * connection is reset.
> + */
> +#define COLLAPSE_PKT_MIN 129
> +#define COLLAPSE_PKT_MAX 512
> +#define COLLAPSE_TOTAL (2 * 1024 * 1024)
> +
> +static void test_stream_collapse_client(const struct test_opts *opts)
> +{
> +	unsigned char *data;
> +	unsigned long hash;
> +	size_t offset = 0;
> +	int i, fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < COLLAPSE_TOTAL; i++)
> +		data[i] = rand() & 0xff;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	while (offset < COLLAPSE_TOTAL) {
> +		size_t pkt_size = COLLAPSE_PKT_MIN +
> +			rand() % (COLLAPSE_PKT_MAX - COLLAPSE_PKT_MIN + 1);
> +
> +		pkt_size = min(pkt_size, COLLAPSE_TOTAL - offset);
> +
> +		send_buf(fd, data + offset, pkt_size, 0, pkt_size);
> +		offset += pkt_size;
> +	}
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	control_writeulong(hash);
> +
> +	free(data);
> +	close(fd);
> +}
> +
> +static void test_stream_collapse_server(const struct test_opts *opts)
> +{
> +	unsigned long hash, remote_hash;
> +	unsigned char *data;
> +	int fd;
> +
> +	data = malloc(COLLAPSE_TOTAL);
> +	if (!data) {
> +		perror("malloc");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	recv_buf(fd, data, COLLAPSE_TOTAL, 0, COLLAPSE_TOTAL);
> +
> +	hash = hash_djb2(data, COLLAPSE_TOTAL);
> +	remote_hash = control_readulong();
> +	if (hash != remote_hash) {
> +		fprintf(stderr, "hash mismatch: local %lu remote %lu\n",
> +			hash, remote_hash);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	free(data);
> +	close(fd);
> +}
> +
>  static struct test_case test_cases[] = {
>  	{
>  		.name = "SOCK_STREAM connection reset",
> @@ -2546,6 +2628,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_msg_peek_client,
>  		.run_server = test_stream_peek_after_recv_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM small packets backpressure",
> +		.run_client = test_stream_collapse_client,
> +		.run_server = test_stream_collapse_server,
> +	},
>  	{},
>  };
>  
> -- 
> 2.55.0


