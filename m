Return-Path: <netdev+bounces-46180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589C77E1EE9
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE99280F8B
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B141799C;
	Mon,  6 Nov 2023 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkKw53tT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B418035
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 10:51:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8F92
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699267864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
	b=CkKw53tTBW8cvWiSDK825vkAyi7WX/i4WR3AC2mHhhGtwXWUG0FwmnkYHJA2vIHKf3Y3WZ
	hq0+rNQkWBOz7zPVDiY6gRFoyTCBTBb6crVU2esecOz7WE66kXKHskQGgxtNPr3iOtfXaV
	jjkOkw2NR8AKOoYsnSgIs4W8i6Sv4NY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-u3ZWLdKYPiSZne0HwXkIqw-1; Mon, 06 Nov 2023 05:50:52 -0500
X-MC-Unique: u3ZWLdKYPiSZne0HwXkIqw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-778b5445527so793543085a.1
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267852; x=1699872652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGKHksPd501hQHA9eLNxN+ry44710hoCv07MExLKHVs=;
        b=w+QOt5vbLgHxQcfF52/uaEMKD7NPR7L2bCM9eNaZGcRdPnlbZxvP+F0zFtvovZqKi5
         6mZP7opyGAxUkATTosdnTJAoTx5lGz/L+jC3EuUMhqLI3q3CK2JpjXcLXCsjwYO/dSXt
         s0M60Nlo5KmVtrXvQ305QbKrUg8RdQlG37kKbOsOrIOSuSWnfChgaixpFWl1KKKtPmOM
         +Uxa18bkTttBekf/2Q+PktWsONBj5ybstVYMpBf9+2yAhzeOEaYX81RM/fZa96uDIr8R
         vyElFwySJgfzobacIkcdOSNzC1Vi4b+jYIbdO2f14gWHTKdbusFyoJj/dcHsGYBu14Zi
         SX3w==
X-Gm-Message-State: AOJu0YzO1XaA2Qq8mBOqsZrTzluy8ZE+Qv3hr7e6SaUp0l9Ga/AzyTfu
	o6xDVueHY3rZPedD+DqkWO1ewTUCA2+ZiTW62goWtza/de17WwufHS9Am2g4bVuYx7CQhaZG6ZW
	ckj93F2XocckNHyeE
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id ea17-20020a05620a489100b0077421d8b0bbmr12492215qkb.24.1699267852267;
        Mon, 06 Nov 2023 02:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0WMQS53FSstaaqoM5HU6Y+QSQp08ZUPiU8X5BKecLqp2Qc+R6PUnmsWzejkhzBiVviTEyQ==
X-Received: by 2002:a05:620a:4891:b0:774:21d8:b0bb with SMTP id ea17-20020a05620a489100b0077421d8b0bbmr12492204qkb.24.1699267852003;
        Mon, 06 Nov 2023 02:50:52 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a125a00b0077892023fc5sm3168522qkl.120.2023.11.06.02.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:50:51 -0800 (PST)
Date: Mon, 6 Nov 2023 11:50:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Cc: luigi.leonardi@outlook.com, kvm@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, mst@redhat.com, imbrenda@linux.vnet.ibm.com, kuba@kernel.org, 
	asias@redhat.com, stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 0/4] vsock: fix server prevents clients from
 reconnecting
Message-ID: <arbypnxtolin6jhz5wqguh4mnqlejtorgx5gvicwbuqdivjpds@lvitwxxfgy2g>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-1-f.storniolo95@gmail.com>

On Fri, Nov 03, 2023 at 06:55:47PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This patch series introduce fix and tests for the following vsock bug:
>If the same remote peer, using the same port, tries to connect
>to a server on a listening port more than once, the server will
>reject the connection, causing a "connection reset by peer"
>error on the remote peer. This is due to the presence of a
>dangling socket from a previous connection in both the connected
>and bound socket lists.
>The inconsistency of the above lists only occurs when the remote
>peer disconnects and the server remains active.
>This bug does not occur when the server socket is closed.
>
>More details on the first patch changelog.
>The remaining patches are refactoring and test.

Thanks for the fix and the test!

I only left a small comment in patch 2 which I don't think justifies a
v2 by itself though. If for some other reason you have to send a v2,
then maybe I would fix it.

I reviewed the series and ran the tests. Everything seems to be fine.

Thanks,
Stefano


