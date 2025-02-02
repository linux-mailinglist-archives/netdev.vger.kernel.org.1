Return-Path: <netdev+bounces-161992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90437A25005
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 21:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458FF3A4DAD
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCD2147E0;
	Sun,  2 Feb 2025 20:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0D2144D8;
	Sun,  2 Feb 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529751; cv=none; b=TXze8+74EW6m235V0ZwEEwOTdbFfP3rCdcjUQev8X1Pc9yrlY4ch9VXab6u0RhXlKHNA//RLCm/iwtc8RBUOAygoFZ+iGqkNv/LuZHFKNZzbAsprQUNvN5S98zA8FTq6RNTYRXZAinkKUsXnY1hN8rk0ZQbqrw4ISy+CgETcoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529751; c=relaxed/simple;
	bh=DQosqtRZSxKfbqx/NoW6In9I4lB44YHTpQfGR519/ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCcgLSoDvFoxe+E8QlhjOKzv0pTnG4dnGgkNNtrM3n++3YjXEUxxui7mW0S22rrqYts6aoduPe5h8Mhkg9vrB2vhTpcRWkqa0d4f/pPhuzVGdyeSArn7Gv67CbfFvHNho+CgpCARCmZCXN/djfwXc9MTHUVQAJd2c3jwgjlG0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab6f636d821so532158066b.1;
        Sun, 02 Feb 2025 12:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738529748; x=1739134548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poe6drOjTOYsDCAwDHGjHlxEZ536/WH5uWxLtf2GTsg=;
        b=CuTqtZ4LiKfSqtiwaW3xiw3TqWolOH32rgjJaDD2kdTrw8RXANqKoRgSEDCeZvDoW0
         e0VXyxINjNoj8pdkz+TrG0XowqnxMCXvx/wkaIORWE4ko5NVZ9hMnQw21qmaO3LM/Bv3
         8gOh9QZhnLoIDRaPCMpVH4bwolq4F5iw9/3J8Txt593rWTPqnXj4vzC3qmRpMsgw4+h7
         dvy2U1rEcwQTydU0Q/g6jLhF5b8mUSN+fAe8XGLzOl3Agypl2v6NS0I/XGkdW3goVtGO
         rTCA49Vb51/Mkkl7P3K9lLl6tfT6Zisf5imbJalNx52IitDth4a/pNrpwBeBPvQgQhLA
         8NRA==
X-Forwarded-Encrypted: i=1; AJvYcCV86f6oMPoUk2qDy2cVSgwoc9QxJIVGRtVYw2lHbLyfljgXu1DXnXJtZWGUJDWDBlCediGh/zlu@vger.kernel.org, AJvYcCXXGokLy6gPws6K1dlkmL0zIBYOdoSiXYrEp7whV2STnCvf/2sPFkpbmn7WETimoOp7ebKvrVqB90w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmEISBmsHPdg3rAH1sbIS9zMPECmoSBWzSPWCU+UnsVLT3xuH
	ixLyhzhDowqjgSkqg4QVETWGuYdV4IVIZ+Key2jXvVFKfrrgEY0y
X-Gm-Gg: ASbGncsiR+PBEyFlgON5S0y8j7T5QKRckdxwywbc3ENJy8LiJKARf2nScGegnAYfhCQ
	Ioi/CLcJ6kOCNgEo8LpPRxmIM85jBlwKSOcL9qtjlxP4e9NQ8OKB87M+ubdQq3YOO7pSNVogVpJ
	68k9Vtdg5rmbhLCBaLkD3rL4LC+gxxxxMCiB8B6nur38a1mGjxRinISjFJpwht9tirmmF1TANfw
	qOdqfOaw/xh3OOjginJHYIOG+W9o/C+UvdLcRVR18z4KAxQQlMdSx9v+VS8Ljfh9LSxc4r7SoRc
	RT4PGj5jgQvtkmE=
X-Google-Smtp-Source: AGHT+IEKbAz2zVgJC6vmaniVDDsmyTegQgYClI+FbH09aFMnhkb0r4Wpem8s8i/s2Ib6KT/7+xNgvQ==
X-Received: by 2002:a17:906:c114:b0:ab6:ed9e:9739 with SMTP id a640c23a62f3a-ab6ed9e9903mr1334106766b.42.1738529747865;
        Sun, 02 Feb 2025 12:55:47 -0800 (PST)
Received: from [192.168.0.13] ([86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a2fa18sm637027766b.131.2025.02.02.12.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2025 12:55:47 -0800 (PST)
Message-ID: <b9a9922c-1290-4d58-9e37-6d999e6c70d1@ovn.org>
Date: Sun, 2 Feb 2025 21:55:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: networking: Remove VLAN_TAG_PRESENT from
 openvswitch doc
To: Andreas Karis <ak.karis@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, corbet@lwn.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, ovs-dev <ovs-dev@openvswitch.org>,
 i.maximets@ovn.org, Paolo Abeni <pabeni@redhat.com>
References: <20250129160625.97979-1-ak.karis@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250129160625.97979-1-ak.karis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/25 17:06, Andreas Karis wrote:
> Since commit 0c4b2d370514cb4f3454dd3b18f031d2651fab73
> ("net: remove VLAN_TAG_PRESENT"), the kernel no longer sets the DEI/CFI
> bit in __vlan_hwaccel_put_tag to indicate the presence of a VLAN tag.
> Update the openvswitch documentation which still contained an outdated
> reference to this mechanism.
> 
> Signed-off-by: Andreas Karis <ak.karis@gmail.com>
> ---
>  Documentation/networking/openvswitch.rst | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/openvswitch.rst b/Documentation/networking/openvswitch.rst
> index 1a8353dbf1b6..5699bbadea47 100644
> --- a/Documentation/networking/openvswitch.rst
> +++ b/Documentation/networking/openvswitch.rst
> @@ -230,11 +230,9 @@ an all-zero-bits vlan and an empty encap attribute, like this::
>      eth(...), eth_type(0x8100), vlan(0), encap()
>  
>  Unlike a TCP packet with source and destination ports 0, an
> -all-zero-bits VLAN TCI is not that rare, so the CFI bit (aka
> -VLAN_TAG_PRESENT inside the kernel) is ordinarily set in a vlan
> -attribute expressly to allow this situation to be distinguished.
> -Thus, the flow key in this second example unambiguously indicates a
> -missing or malformed VLAN TCI.
> +all-zero-bits VLAN TCI is not that rare and the flow key in
> +this second example cannot indicate a missing or malformed
> +VLAN TCI.

Hi, Andreas.  While mentioning of the VLAN_TAG_PRESENT bit is clearly
outdated, I don't think the other parts of the paragraph should be
changed.  The openvswitch module is still using VLAN_CFI bit in the
flow key extracted from the packet as an indicator of the vlan presence.
See the parse_vlan() function in net/openvswitch/flow.c.  And it's
still required for userspace to have this bit set on the flow key for
vlan packets to be correctly matched.  So, while not directly set in
the skb, this bit is still set in the flow key and that's how the flow
key can still indicate a missing or malformed VLAN header.

So, while the VLAN_TAG_PRESENT remark inside the parenthesis can be
removed, the rest of the text should stay intact.

Best regards, Ilya Maximets.

