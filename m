Return-Path: <netdev+bounces-46211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17727E2757
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07231C20B9F
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6028DAD;
	Mon,  6 Nov 2023 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FKLzxAib"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296324214
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 14:43:51 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1B8112
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 06:43:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso671127766b.0
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 06:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1699281828; x=1699886628; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSySmtz3iv59MVKPeBfK4m30gXKygHdiLZCdVGtoL4=;
        b=FKLzxAibfYMZJyga3kFlWQsSvBE4CYd97NzJ3/nAxRLofQ9to6QZntIx1tUoAobUog
         2S4mWs0n2RWN7YG1AvGILrxZVb1T48JWDMJ8EOo3l/anDs0B4UvqfFR8U5j6TCRL3cJD
         J17ivQp9h9a/GJx6+ktRLC2WUchHSYEOuaDvr47kIG9lJP4wftHlQWf8jhfJk4fOPbhF
         Mtwsd8yEuXLRMsbMqNd8PoqPcFmUsfPKm/C1Kx4DkLIEJkhxzyQcZR600TXhOW2CIkw0
         hExnbjNPqYrJ1AbBqHjbAiBl/C2jenxVx2EWoUy+wZawXSWg3j/j4Y0QFdZzUsnbzoAw
         Tnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281828; x=1699886628;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDSySmtz3iv59MVKPeBfK4m30gXKygHdiLZCdVGtoL4=;
        b=MnKpGBm8xHX/WxN/03aTIGJSu7fd/8oSSwqRHBUlEm3m36NcddZLKWBfKagNY47CtN
         gBDrRl0a4e7qpsGgrgHd2RcSC5i2eZW08xILDY8hY4dDUhRZaI8Y3xW753FasqohIBIk
         MvHKtsqhpi0Hkn0GYWo7+J5OoUI5gcTaFMsxFzgw0XaZCR+H7YenHhgGNoUh7yqiODrC
         rQeGvON5VJHNts+X4V+PpIj/qQzgaeQdLUgzVTyu6rE4fSwnVWflTsCGPjq3uDXCe5fr
         q17vVt34b7wF9puVQHVnavLOHNvKqQQ3A1qcgo8FImTCXfrKaFSO8M6VRzRc0LDScRRC
         YRew==
X-Gm-Message-State: AOJu0YzUAaRRNn9cvHROJuGwldJpOpk80b37WP3tDhU3BnXd+P1wSsCp
	sH6XOQvQ+VKVT8Lh2sVf+0I7JsYMx2ccMbo4V2U=
X-Google-Smtp-Source: AGHT+IHBOBsU4XTxsmO0ZGIusix3dN8s9ToLcljRr6B+3pF2tycujXUw9E7lDLAQVi6XwymnDm46Jg==
X-Received: by 2002:a17:906:7307:b0:9bd:d405:4e7e with SMTP id di7-20020a170906730700b009bdd4054e7emr15452858ejc.6.1699281828187;
        Mon, 06 Nov 2023 06:43:48 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id g17-20020a1709067c5100b0099bc8bd9066sm4268993ejp.150.2023.11.06.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:43:47 -0800 (PST)
References: <20231016190819.81307-1-john.fastabend@gmail.com>
 <20231016190819.81307-3-john.fastabend@gmail.com>
 <878r7bjb1a.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangyingliang@huawei.com,
 martin.lau@kernel.org
Subject: Re: [PATCH bpf 2/2] bpf: sockmap, add af_unix test with both
 sockets in map
Date: Mon, 06 Nov 2023 15:42:17 +0100
In-reply-to: <878r7bjb1a.fsf@cloudflare.com>
Message-ID: <874jhzj61o.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 06, 2023 at 01:44 PM +01, Jakub Sitnicki wrote:
> But I'm able to reproduce the bug by running the VSOCK redir test:

I should clarify - the bug reproduces only without the patch #1 applied.

The fix is good. It just has some unneeded bits (unix_dgram), IMO.

