Return-Path: <netdev+bounces-43286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C487D230A
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 14:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AA01C20860
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9753D2FE;
	Sun, 22 Oct 2023 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxBaJA8m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F46FBB
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 12:02:15 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99917A3
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 05:02:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40842752c6eso19270645e9.1
        for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976133; x=1698580933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIiDzhSKjpqG1MFmmCaso+V5S/eDJUgzaV0g+NTPOUo=;
        b=QxBaJA8mPFutleqxx8WA0eWQb+z8p7jDQLiHJISx/KJmjRF9AKzVM+poc179PT+hPu
         83r93mi/qRlwXHmiHQjw5aaJv+ako2rHUEOreAiw/iyE5nNfnuqzKX14CFPdVWQoRD7d
         QcAYleGWG4diIVBW39a/dHmhNOqAS24cN9zhm9qhJ3E9kow2iDu9xKZOlKFcqv8fEgxi
         iCRb9vCmyYMyruG84nNL4a2bjG4Cb9TgiE/8UAsNK7lj965pXMQ77ooOsh7uprP9i9Ik
         40azxhMX/3e1GBjjw2/NP4Sm7wgvzRIXX3xUdavUI0siMXvcV5tBuerLPNAFRFj7r7nB
         fH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976133; x=1698580933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIiDzhSKjpqG1MFmmCaso+V5S/eDJUgzaV0g+NTPOUo=;
        b=Y+u2OLk51t5AP5cqpK+wFSXzslS0437SXcVnSK/xytWAfaiiUJkNF756njHTRidzoE
         Fe7C9A3Xjd/lNH1zl6W59rEKh3PEaFwlgoxrcv4A6vk3+GEXQfLq7RIoak2SeRcA45RS
         kgTI4GEjJ4I95tCtLYJ/r0Og28VRE8pNm1VmxjOf419ky5brMyMYFkCNNhSgp1Vb+If6
         lnlz0jhvG1L/ddfNDPgpwBg5fE6NEWiWkfbjRuaFBqexkesqzVegUgJuKOtB6MQrVA00
         XB6I9dbT5C2f5Zc3ZgTuUCyg65hX/sAb1FNVXtCbzU8V46xm1RVLj6xs5y1niPfDlGWO
         L3Zw==
X-Gm-Message-State: AOJu0YynY6d9CZojdDTRYUNiX5dDMw5UIIJU9vBnfjcrGEzS5YvDuptM
	bsGiCIFwrlEQkdDytFfCxj0=
X-Google-Smtp-Source: AGHT+IFW0mUk10bI7tShRcuB49SVLne+FDEdTXGetPp9IWkqIlQjLYOkNaFVbK+lHSlBXwpG4yzfnQ==
X-Received: by 2002:a05:600c:1ca6:b0:408:386b:1916 with SMTP id k38-20020a05600c1ca600b00408386b1916mr5023953wms.8.1697976132675;
        Sun, 22 Oct 2023 05:02:12 -0700 (PDT)
Received: from [192.168.0.101] ([77.126.80.27])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c189600b004083a105f27sm11391482wmp.26.2023.10.22.05.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 05:02:12 -0700 (PDT)
Message-ID: <daa80210-255e-48f4-837d-0a1aec3f6f70@gmail.com>
Date: Sun, 22 Oct 2023 15:02:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tls: don't reset prot->aad_size and
 prot->tail_size for TLS_HW
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 John Fastabend <john.fastabend@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, tariq Toukan <tariqt@nvidia.com>
References: <979d2f89a6a994d5bb49cae49a80be54150d094d.1697653889.git.sd@queasysnail.net>
 <20231020171448.484dcf2a@kernel.org>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20231020171448.484dcf2a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/10/2023 3:14, Jakub Kicinski wrote:
> On Fri, 20 Oct 2023 16:00:55 +0200 Sabrina Dubroca wrote:
>> Prior to commit 1a074f7618e8 ("tls: also use init_prot_info in
>> tls_set_device_offload"), setting TLS_HW on TX didn't touch
>> prot->aad_size and prot->tail_size. They are set to 0 during context
>> allocation (tls_prot_info is embedded in tls_context, kzalloc'd by
>> tls_ctx_create).
>>
>> When the RX key is configured, tls_set_sw_offload is called (for both
>> TLS_SW and TLS_HW). If the TX key is configured in TLS_HW mode after
>> the RX key has been installed, init_prot_info will now overwrite the
>> correct values of aad_size and tail_size, breaking SW decryption and
>> causing -EBADMSG errors to be returned to userspace.
>>
>> Since TLS_HW doesn't use aad_size and tail_size at all (for TLS1.2,
>> tail_size is always 0, and aad_size is equal to TLS_HEADER_SIZE +
>> rec_seq_size), we can simply drop this hunk.
>>
>> Fixes: 1a074f7618e8 ("tls: also use init_prot_info in tls_set_device_offload")
>> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
>> ---
>> Tariq, does that solve the problem you reported in
>> https://lore.kernel.org/netdev/3ace1e75-c0a5-4473-848d-91f9ac0a8f9c@gmail.com/
>> ?
> 
> In case Tariq replies before Monday and DaveM wants to take it, LGTM:
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Hi,

We're testing this fix and will reply ASAP.

Regards,
Tariq

