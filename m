Return-Path: <netdev+bounces-57330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4C812E45
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C517281F36
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611233FE48;
	Thu, 14 Dec 2023 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuqOHNOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188D1B7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3332efd75c9so6852809f8f.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552359; x=1703157159; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfhYXLUByn6MkqOiWgPxpWAyQFGvsuv/ii+WDxTewkI=;
        b=EuqOHNOehHd2DTsZh5VSmys+kKaWLKxx9j/p8sc0z7IN4Otl22NLGHYutgGG1fr+61
         yno2Ww2Lai7c4pAoJQvkReWNwn3MUJTv6bzbdTCu5yTFJTHsq7Ne1u0c800JA+ugUqh7
         i59Bp7Z4jkO6boHSsVrOTtShU/qfwV3v1DRD4fRaORHW/gplkD74Xl5RB61vLg+E1SOL
         Ad99SQn4h8kSdav3AlZf3CidyFkozb2sHWC15hpsjPxcfkseyeJRmlS9Z0U1YRCKnsxH
         IzVtdLQA9qdczEhy4keG89fncgmjSad69oOO8ZLd//p79PyKuJNl3c5G712hUZAalYZr
         F53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552359; x=1703157159;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfhYXLUByn6MkqOiWgPxpWAyQFGvsuv/ii+WDxTewkI=;
        b=xBKNA60EXLhxPRlgE7OUpPuO/Rd+cqv/kM9tUgXyKBoEuZDG4OFdZ4AYeed7SXhvg/
         S3zPL+Bhv6f+RDXI3WTcXFVFb/7Qjcc4FPSIqpQH2oZ/WSZkxb+sM4DUizh0ZqZRwyXD
         MgFJhe67fuHqmOFqyKz3CjftpuCIGyj+LFVsLM3Rm1BNxe4KrvTlT5BaImTcKs/LVm1y
         iopU0NLPbWr1TnKb4pJkhml+Hgoe9ZlAnou46aatM9fNEtwHIrFp2vllJHNM4pqFhlHv
         9Fs+Y+9NzqAojSBi65c/00H8CIc9/fSUuf6fzDgDKU+xUcSWlTfaMG6cclZACFH6pR/Q
         Ge0w==
X-Gm-Message-State: AOJu0Yz8krfirb9v694gKfctZWw8jv0L5jVbT1fTi5XS9pyB7mttgCeF
	8h6YL4l2IExYfPKUJQ6WSnA=
X-Google-Smtp-Source: AGHT+IGMUaCKkYpUYN4xcHIMg9DYg8v8Wnt9aQQtVxlHvLl/9EJxDiP/8QPCpjNwkPi6DtXrvbYAuA==
X-Received: by 2002:adf:e90a:0:b0:336:38ca:70e4 with SMTP id f10-20020adfe90a000000b0033638ca70e4mr799491wrm.201.1702552359522;
        Thu, 14 Dec 2023 03:12:39 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm2403793wru.78.2023.12.14.03.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:38 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 3/8] tools: ynl-gen: support fixed headers in
 genetlink
In-Reply-To: <20231213231432.2944749-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:27 -0800")
Date: Thu, 14 Dec 2023 10:57:53 +0000
Message-ID: <m27clh59vy.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Support genetlink families using simple fixed headers.
> Assume fixed header is identical for all ops of the family for now.
>
> Fixed headers are added to the request and reply structs as a _hdr
> member, and copied to/from netlink messages appropriately.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

