Return-Path: <netdev+bounces-14269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5D73FD61
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1136D281083
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE818AF6;
	Tue, 27 Jun 2023 14:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16F182D5
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:07:56 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10FD2D76
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:07:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e09a5b19so2948486f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687874870; x=1690466870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URP4w9NbHkDIhOTNM+jmfKoDsuQhG73YLtbTbRIt6ec=;
        b=XihVKXTOWQD+19odFGRG0YuaEZoaxw/eJk0oL3bC+dOWoZNZwCsZ3ZN90Y3RzAPIO+
         QoRzHz2F483EHfsnT4ESXCIx73EmsgWcmKjVCtRNKETboW88mTWYQJWdWurMI4tLrroe
         t3VdLjf45na4yI2trEH44VVmMGPb6s81/d5scfCyiU/4cIgKpBY0SvSTIQiB3Q6tjLgD
         4Ud0VdMI9ay+0Z8fX+MnOK0xE5+YGZjDj6z3q6AF3bW3eXsnpK9aCIli6juzSt3LE9yo
         7OJc1vMv0NtzkrXBf3Aff3HhnsvyknN4DvmaQU2EX7WU7E5Sk7QqNmNs4dIggxS57CSH
         aPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687874870; x=1690466870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URP4w9NbHkDIhOTNM+jmfKoDsuQhG73YLtbTbRIt6ec=;
        b=kiRlTC2K6NQ1J83BMnHENGaehosa+vTPGwKeAHgHIqA2sq1wdyHdc/4xzrFIYAJmEA
         dHwiJRAx/6XPBNDv/UO8KDHZWotqw6QOPZryK2jiAqceZ8MgnLnUI1jT+BLlKwHV5AU2
         jxMnkP1eyFMAR9zFPh/0NEt7+0nedw/re3/upEgPjmjrhblTLzAV8vYkg0JtOYPMzdnc
         RW1LLH6KpYBWg9XviL1D6yEAiIYA49IS+zmChu6h2gAk6SRySVxW2u9RC2uCY1FOWUhB
         jj657iXN3CTqS9MAcKwEMjf+oytcQplYKWBQtorDxSm5ohZFi5LIRNTGyHFxWgDDNpaa
         Eg8A==
X-Gm-Message-State: AC+VfDyTtAJQBBkP+TCroADJA54L+IT2E4eisfwJZbl6Apw1UUc2SaxW
	Nmb4KIbIDjnVTTTX71U2tl3UaQ==
X-Google-Smtp-Source: ACHHUZ5jkm4Djh1mswAoItnBIZ+PivpdKy+mCgHjkZxsqQIDVKtTw1AqWJ9mCVkwNGaSCR/phrhocw==
X-Received: by 2002:adf:edd1:0:b0:311:3ce9:c9fa with SMTP id v17-20020adfedd1000000b003113ce9c9famr24603315wro.3.1687874869948;
        Tue, 27 Jun 2023 07:07:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d19d:8256:aa6f:f56? ([2a02:578:8593:1200:d19d:8256:aa6f:f56])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4c41000000b0030ae499da59sm10461518wrt.111.2023.06.27.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 07:07:49 -0700 (PDT)
Message-ID: <e90fd57c-c4f5-958e-8e2c-fcf7ad587052@tessares.net>
Date: Tue, 27 Jun 2023 16:07:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 2/2] selftests: mptcp: join: fix 'implicit EP' test
Content-Language: en-GB
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mptcp@lists.linux.dev,
 martineau@kernel.org, geliang.tang@suse.com
References: <cover.1687522138.git.aclaudi@redhat.com>
 <70e1c8044096af86ed19ee5b4068dd8ce15aad30.1687522138.git.aclaudi@redhat.com>
 <30ecb04c-47b1-fdf8-d695-e9b9b2198319@tessares.net>
 <ZJrngsQIAI3ATrlU@renaissance-vector>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZJrngsQIAI3ATrlU@renaissance-vector>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrea,

Thank you for your replies!

On 27/06/2023 15:43, Andrea Claudi wrote:
> On Mon, Jun 26, 2023 at 01:32:17PM +0200, Matthieu Baerts wrote:
>> On 23/06/2023 14:19, Andrea Claudi wrote:

(...)

>> Out of curiosity: why is it in iproute2-next (following net-next tree,
>> for v6.5) and not in iproute2 tree (following -net / Linus tree: for v6.4)?
>>
> 
> I usually target fixes to iproute2 and new stuff to iproute2-next, no
> other reason than that. But I see your point here, having this on -net
> may end up in the commit not landing in the same release cycle.

I see, thank you for the explanation.

If I'm not mistaken, a big difference with how the 'net' tree is handled
-- i.e. only bug fixes -- 'iproute2' tree accepts new features as long
as the kernel using the 'net' tree supports these new features. If it
depends on features only in 'net-next', then the patches should target
'iproute2-next'.

> Should I send v2 for this series to mptcp-next, then?

Yes please, only to the MPTCP list without netdev list and maintainers
if you don't mind, just to avoid bothering too many people with MPTCP
specific stuff :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

