Return-Path: <netdev+bounces-109934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2341992A50A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29742830FA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98C1422C8;
	Mon,  8 Jul 2024 14:47:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FE1411EE;
	Mon,  8 Jul 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450048; cv=none; b=aw8T/31PjuByaLTskE7o8/IYaIAvuuCVfNwLrTYfXyEOz05bC4Mdtcn2CrBabck36emtN9rPJVT3arXy3tEUlG8a+lpMeeS3huvdDQZUCSUCgU0Xn+GjWWvfLq+MGxTv6+Iy7A0uU0j1it7QFyav3pd02KijaR51EzTVdKHSOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450048; c=relaxed/simple;
	bh=6YtOJc62IZD3zEm+Ob4Mw4kHJnWZBKG1hE1ocMnAQ5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPdtKA/PgKW9NajsjbDYx3TM0cBX7SlN6xAtklg4DLJH5xPBU+gN09Ujt16W75L8RuTFzFA5YdAg9Pqf1h6aqAmJLwqJQOwfmD5lptrO5Ll7J55ckYN70jbUIgu682lrSC9RujxVO0rm1NfWx6ixAAnYQSPFN2TxBVrxaTzKw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4265c9c9539so3022915e9.3;
        Mon, 08 Jul 2024 07:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450043; x=1721054843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YtOJc62IZD3zEm+Ob4Mw4kHJnWZBKG1hE1ocMnAQ5I=;
        b=te0rM6XISAglw46XG82DCUCNHYr5M2i9gTIGNKSiJUx1vluisSvwMglJwMYvwGbM+L
         zHpXwORr3VTSXlNUD3lgChf9a9nDsFvx04jHfJhDEqbyVQqma3dk2DLGpp8whlKdoLCw
         kJrEyAjEsMHBQjvFYyQJrLweL/qyAcYdwdZ0qURkUZBO3u9EPcMIsQZat6X/UHrRgKcA
         RXsJlFKjbGzoLkLy1rbvO0ryy9g2M4IKplnHJvpdQPYl8Ux1lLuRvZUdK2IHEiilNPkq
         pE34t+7YWZNp64w8+lKq71QuC12/yZZyrQTTRrpsR5Pl/n6c5IhC0ONNBPa2WaWLpWEf
         Ak1w==
X-Forwarded-Encrypted: i=1; AJvYcCW00eGBloG81MNEjJeM3Rr9CLJbwWwbtV8s/WjMcpkZiM0vF8sXuzWOQRGub1xac9DfVJq/Z88B7OjGxh3igwE6ynujG7F1OUNY1z+hAhlA2bt+4K+dkuot5cztFgRtU9KoqSVD
X-Gm-Message-State: AOJu0YygvRleBIdJtx0lF+unDQqffxL18lmiGK/qfjfQEx2zEHaqJZiZ
	NDGweFNQH92yIWfWAYB6Kk8Iv/8ttNWOcF4JuTInqUVkEx49xm6G
X-Google-Smtp-Source: AGHT+IGoavdvJbLdWOEmbt9THk29jyUtAr5aGBIhFtxtQwmzaVw8t7tFdv/op3PGsgfWVVAgWjb47g==
X-Received: by 2002:a05:6000:400e:b0:367:95e3:e4c6 with SMTP id ffacd0b85a97d-3679dd12d7fmr7712742f8f.1.1720450043455;
        Mon, 08 Jul 2024 07:47:23 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a31e1e7asm9936247f8f.113.2024.07.08.07.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:47:23 -0700 (PDT)
Message-ID: <51b9cb9c-cf7d-47b3-ab08-c9efbdb1b883@grimberg.me>
Date: Mon, 8 Jul 2024 17:47:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fix rc7's __skb_datagram_iter()
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com>
 <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me>
 <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2024 17:46, Hugh Dickins wrote:
> X would not start in my old 32-bit partition (and the "n"-handling looks
> just as wrong on 64-bit, but for whatever reason did not show up there):
> "n" must be accumulated over all pages before it's added to "offset" and
> compared with "copy", immediately after the skb_frag_foreach_page() loop.
>
> Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks Hugh,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

