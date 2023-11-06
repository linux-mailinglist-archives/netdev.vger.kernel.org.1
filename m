Return-Path: <netdev+bounces-46177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ACE7E1EC9
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6BF1F21A42
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEBD18035;
	Mon,  6 Nov 2023 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoIlfKgt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0717751
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 10:46:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423CCC
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699267607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
	b=AoIlfKgtM32JzjZXRiExtFHgSjuldVg9A732Xod2htQYVtd3inmtz2nPDFK/HEbAjLNpyD
	te3Q7IUKgctWm6AnFv6vNSdJRu0BdNZz/0YWDQW1UhS+/ciP0mUZPlq0cOGSRMU+SNRXjO
	hQi9KGzNFAbJWIQ9TjcGWBgJXkKK4AY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-MRv0bQsAMNK8G2HRlmP-Og-1; Mon, 06 Nov 2023 05:46:41 -0500
X-MC-Unique: MRv0bQsAMNK8G2HRlmP-Og-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7788fa5f13cso653029685a.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 02:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267600; x=1699872400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6QcvY42P7J5f+1XN4Qoz7DTeNEAzvUSzxn7o+ZphKQ=;
        b=UGIFqGi4rg3FVPjShKej7oweiun07GMvpz1jRR0zDVQttxSWKVx9JL2qIfXzYoL7ds
         0vI4eMurRkUwsCaQYmsFWBUYj2xpsBd6/yPUlefk7r0IgM3WxJbncYVr9rLfOD5IR66r
         fO0r9OZzRHZ1itmZ5k7YFSTUQ+5UXbP43YwUZ3eSXfG+6tg7zlw0oEyMlHL+1mdXG/74
         OjncpqkNCmNQAg9oPCSx7u8QQjcGY9zDqzJzHXMW1siVr6fGInTXDanAeC3SaIXcZ9A4
         y60W/eqjQ/u1DMyrD0OdFzbLNJpNCmKf+c4hbE4naS75UoV2QCxKtJw+ugZiONRdq72R
         3gnQ==
X-Gm-Message-State: AOJu0Yzy9l92aDYEKwAGj3aakz1dVYpQ5tVAri+i6qX3vy7LK2Hhwcwq
	bNwbewqqs0mOGXaXub6NoODbZCPIn6bqHcP9vuyzycLB/sYU+UoGkja3uzl7S0pAJ/7xiecJcMy
	pXdW30ag00VH+qEz6
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id br34-20020a05620a462200b00779cf708495mr13042340qkb.22.1699267600587;
        Mon, 06 Nov 2023 02:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0MTPNegxkHg2EtjSBJdIkcLWvJeBZhkiYCgUyFVAeJU8p43NP4uMhUlLf+FYjn63g6E1jfw==
X-Received: by 2002:a05:620a:4622:b0:779:cf70:8495 with SMTP id br34-20020a05620a462200b00779cf708495mr13042320qkb.22.1699267600334;
        Mon, 06 Nov 2023 02:46:40 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id ay18-20020a05622a229200b004181c32dcc3sm3258973qtb.16.2023.11.06.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:46:39 -0800 (PST)
Date: Mon, 6 Nov 2023 11:46:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Cc: luigi.leonardi@outlook.com, kvm@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, mst@redhat.com, imbrenda@linux.vnet.ibm.com, kuba@kernel.org, 
	asias@redhat.com, stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 2/4] test/vsock fix: add missing check on socket
 creation
Message-ID: <dhech4poimv5fphsxpy4oxy5ks5kpki6kzboy6kpnfm65vz3tp@nm6hoicgj5ze>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-3-f.storniolo95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-3-f.storniolo95@gmail.com>

On Fri, Nov 03, 2023 at 06:55:49PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>Add check on socket() return value in vsock_listen()
>and vsock_connect()
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

If you need to resend the entire series, maybe you can remove "fix"
from the commit title.

But it's a minor thing, so I would only change it if there's something
else that justifies sending a v2:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 92336721321a..698b0b44a2ee 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -104,6 +104,10 @@ static int vsock_connect(unsigned int cid, unsigned int port, int type)
> 	control_expectln("LISTENING");
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	timeout_begin(TIMEOUT);
> 	do {
>@@ -158,6 +162,10 @@ static int vsock_accept(unsigned int cid, unsigned int port,
> 	int old_errno;
>
> 	fd = socket(AF_VSOCK, type, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>
> 	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
> 		perror("bind");
>-- 
>2.41.0
>


