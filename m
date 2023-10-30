Return-Path: <netdev+bounces-45291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22627DBF4B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0FB1C20A4E
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82962199C9;
	Mon, 30 Oct 2023 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VGqYZiGZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCD199BD
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 17:45:02 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF0C9
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:44:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40839807e82so28416525e9.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698687896; x=1699292696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7al2b/2zhByEaCyFJyvoG/06fDJKEZg/ESJAS5x0TA=;
        b=VGqYZiGZzmjyix7uT77D06o16aWVjTl1Gz5QqNMwSwQ/gZEWEGox5RbWZQRASCmB+8
         X1NRklyAHeFaHjaRPvzvek5tSRTZtUIPVpxU3LK4rS1QwQmK93yvCuj5fBmBI/z9rBQh
         cxebdeDTIXPNNwRBOwcFh4IOj+sMiGWPk8FhYEy7wRYecT/2lVHluyfNmHC9pYIpiI8Z
         7FDRDWA/G+00cerbq4C17nOfNvfMgFoUomNIEOBlzDBhdedyI+qCGnE70lWBAVROiZCM
         XB0xktEgT+joSxF3UVdr+QLJNuu+VVucVA2IgYIi0iITQ53J7IFPQeaYVIC6RHzD2Frg
         BeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698687896; x=1699292696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7al2b/2zhByEaCyFJyvoG/06fDJKEZg/ESJAS5x0TA=;
        b=hTRskTXahLzNWaMNUfd1WasykimFMF5Uf59KLeCf1XOghj5thzy0bsUAgKKV8Dbv5T
         aVmOKkOpujbrk+/M8mIKkGga0AYBBSpdgNYQqO+EriALm9gmfw5SXHu8AgjWkt7NbQYJ
         oGwV9nj0IpJR3+H05OfUTCIKjsdbp9CkhSF8/RoU7KRXUV7n5JcmdbAp7rRXZw/UxkFt
         p/iMEhyl+c4oChY6BK+YpDFz53MtLIOmR2lBD7jqWndD3+FU69lS/eC++bkZMhhR66Vo
         unrmBQiHSNE+qZkhOS/U594YRdQIkbIZrtI7iKKSJY9e4SmM/l2RoczkyHmA2cRRlVnh
         Burg==
X-Gm-Message-State: AOJu0YwUnCTQGNgCNHe8AEoyXgqzCNFNF8YhYUcLEgAy22Tnt1es9EEx
	2dlrHZSkvBeC+f5lwIUGpBhaeg==
X-Google-Smtp-Source: AGHT+IHjVsfeQaLVAw8QRYpPOrXmkuIn9PR0bd/WaTnyVSvIBK/qVIcRCXGKCUX/5vQZrKyO2idimw==
X-Received: by 2002:a1c:7405:0:b0:405:29ba:9b5c with SMTP id p5-20020a1c7405000000b0040529ba9b5cmr381850wmc.16.1698687896491;
        Mon, 30 Oct 2023 10:44:56 -0700 (PDT)
Received: from ?IPV6:2a02:8084:2562:c100:228:f8ff:fe6f:83a8? ([2a02:8084:2562:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b004064ac107cfsm9931435wmq.39.2023.10.30.10.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 10:44:55 -0700 (PDT)
Message-ID: <cd025d15-4e2b-4727-a10b-a6da98af4058@arista.com>
Date: Mon, 30 Oct 2023 17:44:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the crypto tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>,
 Linux Crypto List <linux-crypto@vger.kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231030155809.6b47288c@canb.auug.org.au>
 <20231030160953.28f2df61@canb.auug.org.au>
 <ZT896a2j3hUI1NF+@gondor.apana.org.au>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <ZT896a2j3hUI1NF+@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/23 05:23, Herbert Xu wrote:
> On Mon, Oct 30, 2023 at 04:09:53PM +1100, Stephen Rothwell wrote:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Mon, 30 Oct 2023 15:54:37 +1100
>> Subject: [PATCH] fix up for "crypto: ahash - remove crypto_ahash_alignmask"
>>
>> interacting with "net/tcp: Introduce TCP_AO setsockopt()s"
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  net/ipv4/tcp_ao.c | 6 ------
>>  1 file changed, 6 deletions(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Dmitry Safonov <dima@arista.com>

> If we simply apply this patch to the netdev tree then everything
> should work at the next merge window.  But perhaps you could change
> the patch description to say something like remove the obsolete
> crypto_hash_alignmask.  It's not important though.

Thank you,
           Dmitry


