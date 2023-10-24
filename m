Return-Path: <netdev+bounces-43889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375477D535F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AAFAB20D2C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51162B5FB;
	Tue, 24 Oct 2023 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idI2ELXd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C06125DE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 13:56:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B32721
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698155787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQvE8OdPfOZYSkHw0w045+f5o9rL3SeUMTEWpiF8tRY=;
	b=idI2ELXdouh4VlS9yesttPTSys+fXimNaHqzKxVnSwebjUcgxSF1axKqifbQSsiCwIK+6P
	iPo9fJp72GOlSYNygoFAq9r+u/pIxH8uP5pboNGctdfoKEacTeQwkAFJT4K9MhBf7RGkMY
	fB6QTmyhDbToA2VFqWu7ZuAB3Qil/ys=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-p7qvA9ucO3SIb9liDZ5axA-1; Tue, 24 Oct 2023 09:56:21 -0400
X-MC-Unique: p7qvA9ucO3SIb9liDZ5axA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41e1ecf3350so5723311cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 06:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155780; x=1698760580;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQvE8OdPfOZYSkHw0w045+f5o9rL3SeUMTEWpiF8tRY=;
        b=NstwtffzZTtB+8Bk24CEvnCO6KcjuyF3NjhPCqSjoE6lcXM9j9HBV6jGQVByLIfyUR
         E/Fsue6MMeD0iOlXZKTLBzDNOJtwocsrbRU6LmP+Ks7+OJr+10wZFevVLiRoz00dk7F+
         TzjAHryzC16ejfrr9CEwWygCo9DvBmNhmhQJoT3wkEMwXPPjxK1FXwMjDNnMRMrNFOtB
         PGl8b7/gA/RdVS1mY2esqsVHacV8UNKVZX8GMGPY5J+ff8vUXjEfVdfQ/o+tcOoXVxjz
         bT8+ofDV9dEISNNliJlkFYfXPi6jDzWE9qQTBybuHXXwKvCXp6cmIxlatuUanq8XHl71
         UPMQ==
X-Gm-Message-State: AOJu0YwRbRCNoje82hagnTx7cnPkj0O+yPjRcwWMwSznDtLscpJjc7M1
	hSxX1jHxhRnDqzPbS5PwV/rtfrIDZynIk5IdYAvD/WDvCDFTFKdfCbzsjCL06KskZlxJn4HydWa
	TFKLGi1arUT4lLiWj
X-Received: by 2002:a05:622a:15c2:b0:41c:d444:d08a with SMTP id d2-20020a05622a15c200b0041cd444d08amr14354092qty.5.1698155780638;
        Tue, 24 Oct 2023 06:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp3HkQo1SE5CjzQCJM1P53fM6YXXkusZPqIbLJPLZVwjCEjtEC1Ta45eBdaH/W2xlMVb/FOw==
X-Received: by 2002:a05:622a:15c2:b0:41c:d444:d08a with SMTP id d2-20020a05622a15c200b0041cd444d08amr14354077qty.5.1698155780340;
        Tue, 24 Oct 2023 06:56:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-180.dyn.eolo.it. [146.241.242.180])
        by smtp.gmail.com with ESMTPSA id bn14-20020a05622a1dce00b0041aff9339a2sm3450689qtb.22.2023.10.24.06.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 06:56:19 -0700 (PDT)
Message-ID: <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
From: Paolo Abeni <pabeni@redhat.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski
	 <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>, kernel@pengutronix.de
Date: Tue, 24 Oct 2023 15:56:17 +0200
In-Reply-To: <20231023121346.4098160-1-s.hauer@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> It can happen that a socket sends the remaining data at close() time.
> With io_uring and KTLS it can happen that sk_stream_wait_memory() bails
> out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for the
> current task. This flag has been set in io_req_normal_work_add() by
> calling task_work_add().
>=20
> It seems signal_pending() is too broad, so this patch replaces it with
> task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.

This looks dangerous, at best. Other possible legit users setting
TIF_NOTIFY_SIGNAL will be broken.

Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?


Thanks!

Paolo


