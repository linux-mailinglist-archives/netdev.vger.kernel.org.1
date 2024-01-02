Return-Path: <netdev+bounces-60932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891ED821EA1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E74283C55
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF5514278;
	Tue,  2 Jan 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FuI19ODj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38414F62
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ccec119587so35343611fa.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1704208887; x=1704813687; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=23Yjqa1K2ZKWifm2e0b07/yhhITrtoxV2d/ytUflx7M=;
        b=FuI19ODjEggM4C6e6i25ebX8UKy1j+UDY2hvy9hQYFOsJfUZZO8iCHS6lev7IXKKK0
         UQwVsBKwENcC1SavPizNnHrMFBSnUEPKDHIv68974RteZWzNRbhozpbAe1otPYKCqv00
         bhqfqupQ9IS+T4SmmmTGEHWE2dmi/tf9qBTOlpXkdXJtxA/36ICFvruqpKeIrlkBETXJ
         dCELCvI6oH35TNSKxYjs8nEnMLkfy5adczilrPv/Dk/8x+Zc5o14nQF6rMcE8SudoiSm
         fLn8amw7fARjT9QE5tf+Geh8SAvibxxFQebPQr4QsQHNCbt8LsYEO6C3ERFzBytAoUvy
         BjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208887; x=1704813687;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23Yjqa1K2ZKWifm2e0b07/yhhITrtoxV2d/ytUflx7M=;
        b=tYjVdOMwKH0TOZ0ghiP+ljBhcyx9ZBHjkyTyipEYpjRWRricTbNCjaJGZ4AGdnEL3m
         AM8eAnCqOjmepta9boNoFIJupmSWUVc7QU/Z11TOC7YrP9Ex+B3Up0kW5WXGzF1mmpKf
         IatfJMR/WNDe7L5KlxJTroK0Mv6ckQ2dcZUWJfnok7JpRsfsF6XciGcjAUky5Y2SZniI
         qrf4FgemdmK1UWX17Z0QGJNyrh1txL0kHuXF1YR/CmmvXmph5nxKZeO5haiouG0FjU6C
         /H6IrkPRyy1R5lMVH/BRTdZeIOiZMfyFXr6Gm8ELfV1OusRcwtdf6h9whnhR8CI0UJfs
         VUzw==
X-Gm-Message-State: AOJu0YzKXjr4xFEbT1eTIetHEzwi+9Lu1oWknQrjcu009jQX2bwwfqVA
	n2FH4CPAm2qIpchkknw63jzSuzJJI7IRxQ==
X-Google-Smtp-Source: AGHT+IFO++5dPfkYIw4MsSRkyBjU+nNhBLMxi/0tykqj7t7GBEs/5SGGzHucmx457CqX1zIO12lHFw==
X-Received: by 2002:a2e:9c89:0:b0:2cc:f5b6:91ed with SMTP id x9-20020a2e9c89000000b002ccf5b691edmr2424859lji.23.1704208886934;
        Tue, 02 Jan 2024 07:21:26 -0800 (PST)
Received: from cloudflare.com (79.191.62.110.ipv4.supernova.orange.pl. [79.191.62.110])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b00552d03a17acsm15891594edb.61.2024.01.02.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:21:26 -0800 (PST)
References: <20231221232327.43678-1-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: rivendell7@gmail.com, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf 0/5] fix sockmap + stream  af_unix memleak
Date: Tue, 02 Jan 2024 16:18:29 +0100
In-reply-to: <20231221232327.43678-1-john.fastabend@gmail.com>
Message-ID: <87v88bvk0a.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 21, 2023 at 03:23 PM -08, John Fastabend wrote:
> There was a memleak when streaming af_unix sockets were inserted into
> multiple sockmap slots and/or maps. This is because each insert would
> call a proto update operatino and these must be allowed to be called
> multiple times. The streaming af_unix implementation recently added
> a refcnt to handle a use after free issue, however it introduced a
> memleak when inserted into multiple maps.
>
> This series fixes the memleak, adds a note in the code so we remember
> that proto updates need to support this. And then we add three tests
> for each of the slightly different iterations of adding sockets into
> multiple maps. I kept them as 3 independent test cases here. I have
> some slight preference for this they could however be a single test,
> but then you don't get to run them independently which was sort of
> useful while debugging.
>
> John Fastabend (5):
>   bpf: sockmap, fix proto update hook to avoid dup calls
>   bpf: sockmap, added comments describing update proto rules
>   bpf: sockmap, add tests for proto updates many to single map
>   bpf: sockmap, add tests for proto updates single socket to many map
>   bpf: sockmap, add tests for proto updates replace socket
>
>  include/linux/skmsg.h                         |   5 +
>  net/unix/unix_bpf.c                           |  21 +-
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 199 +++++++++++++++++-
>  3 files changed, 221 insertions(+), 4 deletions(-)

Sorry for the delay. I was out.

This LGTM with some room for improvement in tests.
You repeat the code to create different kind of sockets in each test.
That could be refactored to use some kind of a factory helper.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

