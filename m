Return-Path: <netdev+bounces-28385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D99A77F463
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C31C2133D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC3EAD4;
	Thu, 17 Aug 2023 10:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD3D314
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:41:11 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362382D54
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:41:06 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52577034655so778949a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268864; x=1692873664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U107HDGRsnh6fdBS2dCkA5s3quKWrB4L5clKKz8Y48=;
        b=SK8L/zDC0o3Ppe1+VJg/ptgPntUFxDs6zjKw8hM9aEIStDf+OcwEL3Tcu5BuKKI3mx
         DqsOs7qSDt3v6EWgODhYNDVYOOewbAPb/9JRKj3LxDC9ey9tpePPlW7LLnbfEqxfZFgy
         A2KYQVotUdbQFiOpF8qws+KS2BmdXM3a0eG+Qeis6B0iIpBMMrWKxXcOjPrCSNGqMctd
         H1FfEBxRJMGMWtqhdG80BW4TssLMX16Co04/hMci6B56h7dnSLYlnmlP7uYCdtdJnxtb
         riNKdWxiPTI9NWv7jQ2k7/p8o7X2Sqv7g63F21N9wQEw3aGn5uYNLiY7nnLT2NZ2nouv
         PdEg==
X-Gm-Message-State: AOJu0YyYAFjXBfwDt7pyeXD9cAG828qTEMFVCjU+gyERlnVjXM2/TBz6
	FwHtxw/tUL6U8PYIe2ouH5k=
X-Google-Smtp-Source: AGHT+IEEcEG8xciklrkTtRDf013vKDyTeBMMfVJwWYnTLSpQ12iIDmmG1BPA1bQl4oRaikbABWmHdw==
X-Received: by 2002:a05:6402:350a:b0:523:2e64:122b with SMTP id b10-20020a056402350a00b005232e64122bmr3589269edd.3.1692268864434;
        Thu, 17 Aug 2023 03:41:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402121700b00523653295f9sm9549069edw.94.2023.08.17.03.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:41:03 -0700 (PDT)
Message-ID: <615aaad8-b216-ceaa-1553-d283a3c4531b@grimberg.me>
Date: Thu, 17 Aug 2023 13:41:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-12-hare@suse.de>
 <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
 <b460dc0c-3254-0c97-557b-3cf42041c247@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b460dc0c-3254-0c97-557b-3cf42041c247@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>> +        case NVMF_OPT_KEYRING:
>>> +            if (match_int(args, &key_id) || key_id <= 0) {
>>> +                ret = -EINVAL;
>>> +                goto out;
>>> +            }
>>> +            key = nvmf_parse_key(key_id, "Keyring");
>>> +            if (IS_ERR(key)) {
>>> +                ret = PTR_ERR(key);
>>> +                goto out;
>>> +            }
>>> +            key_put(opts->keyring);
>>
>> Don't understand how keyring/tls_key are pre-populated though...
>>
> They are not. But they might, as there's nothing in the code preventing 
> the user to specify 'keyring' or 'tls_key' several times.
> I can make it one-shot and error out if they are already populated, but
> really haven't seen the need.

OK, now I understand. its fine.

> 
>>> +            opts->keyring = key;
>>> +            break;
>>> +        case NVMF_OPT_TLS_KEY:
>>> +            if (match_int(args, &key_id) || key_id <= 0) {
>>> +                ret = -EINVAL;
>>> +                goto out;
>>> +            }
>>> +            key = nvmf_parse_key(key_id, "Key");
>>> +            if (IS_ERR(key)) {
>>> +                ret = PTR_ERR(key);
>>> +                goto out;
>>> +            }
>>> +            key_put(opts->tls_key);
>>> +            opts->tls_key = key;
>>> +            break;
>>>           case NVMF_OPT_DISCOVERY:
>>>               opts->discovery_nqn = true;
>>>               break;
>>> @@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct 
>>> nvmf_ctrl_options *opts,
>>>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>>   {
>>>       nvmf_host_put(opts->host);
>>> +    key_put(opts->keyring);
>>> +    key_put(opts->tls_key);
>>>       kfree(opts->transport);
>>>       kfree(opts->traddr);
>>>       kfree(opts->trsvcid);
>>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>>> index dac17c3fee26..fbaee5a7be19 100644
>>> --- a/drivers/nvme/host/fabrics.h
>>> +++ b/drivers/nvme/host/fabrics.h
>>> @@ -71,6 +71,8 @@ enum {
>>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>>       NVMF_OPT_TLS        = 1 << 25,
>>> +    NVMF_OPT_KEYRING    = 1 << 26,
>>> +    NVMF_OPT_TLS_KEY    = 1 << 27,
>>>   };
>>>   /**
>>> @@ -103,6 +105,8 @@ enum {
>>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>>> bi-directional
>>>    *              authentication
>>> + * @keyring:    Keyring to use for key lookups
>>> + * @tls_key:    TLS key for encrypted connections (TCP)
>>>    * @tls:        Start TLS encrypted connections (TCP)
>>>    * @disable_sqflow: disable controller sq flow control
>>>    * @hdr_digest: generate/verify header digest (TCP)
>>> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>>>       struct nvmf_host    *host;
>>>       char            *dhchap_secret;
>>>       char            *dhchap_ctrl_secret;
>>> +    struct key        *keyring;
>>> +    struct key        *tls_key;
>>>       bool            tls;
>>>       bool            disable_sqflow;
>>>       bool            hdr_digest;
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index ef9cf8c7a113..f48797fcc4ee 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1589,6 +1589,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl 
>>> *nctrl,
>>>       dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>>           qid, pskid);
>>> +    if (nctrl->opts->keyring)
>>> +        keyring = key_serial(nctrl->opts->keyring);
>>
>> Maybe populate opts->keyring with nvme_keyring_id() to begin
>> with and then you don't need this?
>>
> We could; one would lose the distinction between 'not specified' and
> 'specified with the defaul keyring', but one could argue whether that
> brings any benefit.

Not sure I understand.
What exactly is the distinction and how is it manifested?

