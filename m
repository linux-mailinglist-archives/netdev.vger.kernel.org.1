Return-Path: <netdev+bounces-47215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636F7E8DA9
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 01:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B010B20A1E
	for <lists+netdev@lfdr.de>; Sun, 12 Nov 2023 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62010ED;
	Sun, 12 Nov 2023 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc8uC4Vc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13010E5
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 00:44:50 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112B2D77
	for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:44:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2809748bdb0so378121a91.0
        for <netdev@vger.kernel.org>; Sat, 11 Nov 2023 16:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699749889; x=1700354689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrNlo7h7ddYcvYhRPoxpQ4H7DqlIfuQTY1IK7GWdC7o=;
        b=Nc8uC4VcAVTnSWWkegV7tsRaef7+braTaEPl94+ZXgJCUHrTta04xUbMK6/ungZ7hU
         AKWC0wlJqIVspMyrxcjKNZLPzIVpLzVEZD6KhgSTxElKj9r0/GRyzcHL+VDuT2VFpaIC
         9HNLqOfQ/6PrvZ7Mx/UdEj7JHxzay03FsVZNnvFsfFKHGzUMg/LePZ0SKcqMNpjYpIMr
         /JahubXzv5kw/NJjnBxtdhUe02lnml3hxZBvPdJnDvIwi/x4xnEIT3x0weeA/snOzDeh
         cEO6PFPQNtxkb375hvwi0NIezgHnEJA9tedEvBK0Y4LngpKfQiC0KtVnU74/zK9JE4lI
         Hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699749889; x=1700354689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrNlo7h7ddYcvYhRPoxpQ4H7DqlIfuQTY1IK7GWdC7o=;
        b=aL/kzAGQiO7CRDiqEy3g3KWCLBlc35XQ3AfvcFFZGCG2sVqnDZUhsPDcAg21eeOOyN
         oqseiYdaOEdy5FwBpZ1I1tDQ5bNaOYyYaZ/ReaEGfenuWfewjuTACDPZRncfVN81DWAi
         MwsBIuOjyFXbI+K6C6NKQTTjGCuLHlVqpG0j2HVqDJE77NOxfz5MfX8jRoueCI5skaCu
         yxxB4k65WNdt9xgOfEjN388kNFBzu/DfT9pP8jELIeC0Sd1gBH7YUE4FxrW/hYt8X72v
         o8FKsLVt0VyEtk5o/fzUfUDArb5a4CKE978i4L0rmKUQzdg9if4xpJBM2oA3h1hF0yt7
         3CUg==
X-Gm-Message-State: AOJu0YxRln+4KQz9MFuXpCow4r0ZwjMMKcd7vLVQNDBl4EB9NIBGeZ0S
	PNlT1REx2tK8yBlowpv7P3A=
X-Google-Smtp-Source: AGHT+IGKRDS5g6nIvT7j+VSqgF2ApG8QxuMnlTdgH3/I8c5Q2hoNrUf6bxRoe5rRx1eznzO07JtsGA==
X-Received: by 2002:a17:902:db0c:b0:1cc:277f:b4f6 with SMTP id m12-20020a170902db0c00b001cc277fb4f6mr4286713plx.6.1699749889306;
        Sat, 11 Nov 2023 16:44:49 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id hg23-20020a17090b301700b00277560ecd5dsm3686662pjb.46.2023.11.11.16.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 16:44:48 -0800 (PST)
Date: Sat, 11 Nov 2023 16:44:46 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
Message-ID: <ZVAf_qdRfDAQYUt-@hoboy.vegasvil.org>
References: <20231109174859.3995880-1-edumazet@google.com>
 <ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
 <CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>
 <ZU5j2V9aUae0FE1o@hoboy.vegasvil.org>
 <20231110115224.3d2f180c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110115224.3d2f180c@kernel.org>

On Fri, Nov 10, 2023 at 11:52:24AM -0800, Jakub Kicinski wrote:

> Meaning we should revert 8a4f030dbced ("ptp: Fixes a null pointer
> dereference in ptp_ioctl") ?

Yes, I think that would be ideal.

The test itself is harmless, but keeping it will make people think, "oh
this pointer can be invalid."

In fact the core stack ensures that ioctl() can't be invoked after
release(), otherwise Bad Stuff happens.

Thanks,
Richard



