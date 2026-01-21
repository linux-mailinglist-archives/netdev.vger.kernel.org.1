Return-Path: <netdev+bounces-251860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBzxDDfKcGkNZwAAu9opvQ
	(envelope-from <netdev+bounces-251860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:44:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0556FC6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 803D572CE22
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3748A2D0;
	Wed, 21 Jan 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQ/TNF0/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2YJyP0e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD448A2B9
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998963; cv=none; b=AYYa87iSVWDl6Tt7DUDQxoi1C+Q6vs7IUffzSvrrb8j79s/MXWu6Px967U4oqs7nQBbwutex97i+Rflm4slyONtmKU2osCU/4JCLJDDSOy/CcEdWANeGWPWb5Jx3XpGFPeQ0h3CR56yQt2nBQHGJS/2xuI5vwIxtXBfUsI2kNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998963; c=relaxed/simple;
	bh=mha0I0VeVP1yXEtwsIMyiWq7J0MEXEEXF4v+brwB7Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFqPOmdouPUq1X2hkgD0CpmZB3bJSi+mAi1Lhf1JwTZ40yw0WVOu5J1Z7wTePvFazYvQXoI/h32o52HUzs0TNUqsZtGp0POriUbBHmeyRkn6ETrl3lPRAqSI5ofTHq7Fye5wOHchtbypLOJaF0aewQttkEW+XT6+oA6SSaeLlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQ/TNF0/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2YJyP0e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768998960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnPI8AJirXqjwQZgXHxL6NbBtlFdMp2kOfgYwwE6c8I=;
	b=KQ/TNF0/jsR1ZYVlVbn5nL2dTXQQ4Cp91gq8JdBGYbJv0WzRAHoycBGiI3q/YZrFIwLP8i
	fRiIlEnUiYOdNg7EQDlMGuz34Pls6RrPtABLc5+wizr3LW+uDSJuJhv7FHTYn2s038N05z
	yEX9iG4Ent2W1xm0aXUVq9B4jyJCVGo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Cc8Y572hOhqkvQuzmUUegQ-1; Wed, 21 Jan 2026 07:35:59 -0500
X-MC-Unique: Cc8Y572hOhqkvQuzmUUegQ-1
X-Mimecast-MFC-AGG-ID: Cc8Y572hOhqkvQuzmUUegQ_1768998958
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee8808ffbso48397835e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768998958; x=1769603758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnPI8AJirXqjwQZgXHxL6NbBtlFdMp2kOfgYwwE6c8I=;
        b=e2YJyP0eTNS932V2wD03A9ExfaNr0MsBa0cSDjf0VDWECGqEuH2K52zFG9cwSlu+FG
         CUavymRALV6Zv71/tRFiTPuJm5ugs1xKqay7LK50HI+xxebSkQSSS5watxOyh6bLGYy4
         /m1bNIM69axgme56u3fghXKdOsxgJQIQdDDmIFuvYKubWCjKwnevysCszJNrOBTbj8p8
         y4B++MEFLAUAAPHxEkjgQ2amuKDeA2pw+gaxKkWWApvc7AjNN348EDXanAcdTaVntBsW
         YmTqT3TOv0dWDXMIwqawRXPldASbXoGgUjvrbyO4Nla6+kbiNT1oaZKt+W5HbT/4XSlg
         Erig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768998958; x=1769603758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnPI8AJirXqjwQZgXHxL6NbBtlFdMp2kOfgYwwE6c8I=;
        b=Dh7TNxqTis8eaVfhXvddGScaFulJl8RQDZPJQDsvkdlrA7T0ZYRotz54iu4lyEGqAf
         YD4QhWVT0fLs8CQJESLENbw2rJY/10hKAY7/geRmK8GvC5JpT5iSeaPKIeF9GsU+nKiA
         /tUGyhFPVafhJJMDtGTNP5WIMB/L7dioseSA04YNbcL2tT87Y7dvnRM4wL0WrvMSGgir
         Ky5PxiXZV7+mSVDKoOw7zOvml7s8cEka7KuqXxMHtCkr48cO5FzwpIzaZgeQ1gT7bXht
         bf4Slm6d2hmnYbylCfAmAtx65vZpkYMXZuduFwNJazbcc+wI3rOsxpnubjdMZ1CZ9X62
         nHLA==
X-Gm-Message-State: AOJu0Yy728HIBVhERc7JtvWLzVAqGA99HXhK82X7CFcdo3b3yAzhErFz
	or2fOp+yXLa1wJtAmjgdPMMCBNM9rHBW9wT0EUazzpdt/92nIG04o3VvtjqBSKNewpYbM00tVyu
	rjriCNjdA5e0CnUgBh+RJ/AhseF4vsfP1C/dlmvpNZDpNx2zhE4v94d1puA==
X-Gm-Gg: AZuq6aJbgQFhh811v+FivTKGXzGeV97PJiVG5b/ZD48hCR3sqRnGH3JjVhWkC0tZcth
	t2TX3W2gEXWxx9zT08xE8XO9h3gu4giQa+KfdGJec9527caWYFsBjIWa78vz/vIrdYgcoBTEf+K
	SgYt+b+AsMAHDHVVt5dBBEEpDF+FZRsO/YzMsYclI7I2q6pELe246cbAB4TuNmilAJ5bSZ3sWrH
	TBiUQv/6rR/IKbN9HZ9kUUt+b/BPAYFQ6Zcw9lfqbcSfcnptJhzbuHaEXbPiBr3gOy4CtVea//h
	RBauwtGQSFsO3VgTUrYEUl98nBNdTI5kxPF15YIUjikDGsP7+reYpznBMvPY2ny9NbW3XNfapUj
	hoGhRdaX4zrLWrb/7uwj1ilaIEDoHFo4=
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4801e34651dmr231392775e9.30.1768998957678;
        Wed, 21 Jan 2026 04:35:57 -0800 (PST)
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4801e34651dmr231392355e9.30.1768998957206;
        Wed, 21 Jan 2026 04:35:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm362908205e9.3.2026.01.21.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:35:56 -0800 (PST)
Date: Wed, 21 Jan 2026 07:35:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Subject: Re: [PATCH net v6 0/4] vsock/virtio: fix TX credit handling
Message-ID: <20260121073547-mutt-send-email-mst@kernel.org>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-251860-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 98A0556FC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:36:24AM +0100, Stefano Garzarella wrote:
> The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till v4.
> Since it's a real issue and the original author seems busy, I'm sending
> the new version fixing my comments but keeping the authorship (and restoring
> mine on patch 2 as reported on v4).


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v6:
> - Rebased on net tree since there was a conflict on patch 4 with another
>   test added.
> - No code changes.
> 
> v5: https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/
> v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/
> 
> >From Melbin K Mathew <mlbnkm1@gmail.com>:
> 
> This series fixes TX credit handling in virtio-vsock:
> 
> Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
> Patch 2: Fix vsock_test seqpacket bounds test
> Patch 3: Cap TX credit to local buffer size (security hardening)
> Patch 4: Add stream TX credit bounds regression test
> 
> The core issue is that a malicious guest can advertise a huge buffer
> size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
> excessive sk_buff memory when sending data to that guest.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
> recovered after killing the QEMU process.
> 
> With this series applied, the same PoC shows only ~35 MiB increase in
> Slab/SUnreclaim, no host OOM, and the guest remains responsive.
> 
> Melbin K Mathew (3):
>   vsock/virtio: fix potential underflow in virtio_transport_get_credit()
>   vsock/virtio: cap TX credit to local buffer size
>   vsock/test: add stream TX credit bounds test
> 
> Stefano Garzarella (1):
>   vsock/test: fix seqpacket message bounds test
> 
>  net/vmw_vsock/virtio_transport_common.c |  30 +++++--
>  tools/testing/vsock/vsock_test.c        | 112 ++++++++++++++++++++++++
>  2 files changed, 133 insertions(+), 9 deletions(-)
> 
> -- 
> 2.52.0


