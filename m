Return-Path: <netdev+bounces-27122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79277A6A1
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480F5280F02
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4086FA6;
	Sun, 13 Aug 2023 13:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2F2C9D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 13:53:45 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328691716
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:53:44 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99b4865ad55so81127666b.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934822; x=1692539622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxjLMaFLcmqkMgJF8iD7IC0NJ8XJCbj3i1mghtiuiEo=;
        b=S4qIITwyLwrdzG84nECkxIeP+uw/et9yYgahTKHRDqvE9OcGTKrwD/l/LGOPoCWPmX
         jF/JTyB6x//VcuRKxrwsE0i+PJb8xh42Jf5ftz/fGC1B1S4BL2mCoxr9S2euKl/KcnUk
         +dgbogKVx8KOqueIAcs3ydGaKqPsJw0iclKcXvoz0zlezeO3DulBayXBHgY/v8QI9DlZ
         K3rn3JM41LxSnH88eWlupse5vUW9X3yoPrp0QrIcEiHb8EUnJhwLtAOME9183MlG4EAB
         +Eoom7i4NqYRiBQr3J4Nih/IHcVBWO+kh5A22UJghW/7bT/YgY8gab4O3PVULpa8ROrR
         ZsrQ==
X-Gm-Message-State: AOJu0YyitE2xl76J6ZJgOgX1i8wyWjm2HozTEmrReNZJyTo2JwfBa0u9
	rKLz7f00IKicaTbAHCffrNfVqCIxIiA=
X-Google-Smtp-Source: AGHT+IGd75FvfJU2yF+AhkdNfnKGyxKiNOVLrKo+LHk8jKKRREPCEXPJ47ksx29qEFkf/ramlOdo6g==
X-Received: by 2002:a17:906:74da:b0:99d:675e:5217 with SMTP id z26-20020a17090674da00b0099d675e5217mr4843605ejl.7.1691934822590;
        Sun, 13 Aug 2023 06:53:42 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id si28-20020a170906cedc00b00988dbbd1f7esm4587539ejb.213.2023.08.13.06.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:53:42 -0700 (PDT)
Message-ID: <5b6ff1d7-00e0-7f16-ece0-a80426821b32@grimberg.me>
Date: Sun, 13 Aug 2023 16:53:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> @@ -928,6 +933,46 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = key_lookup(key_id);
> +			if (IS_ERR(key)) {
> +				pr_err("Keyring %08x not found\n", key_id);
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			pr_debug("Using keyring %08x\n", key_serial(key));
> +			key_put(opts->keyring);
> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id) || key_id <= 0) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			key = key_lookup(key_id);
> +			if (IS_ERR(key)) {
> +				pr_err("Key %08x not found\n", key_id);
> +				ret = PTR_ERR(key);
> +				goto out;
> +			}
> +			pr_debug("Using key %08x\n", key_serial(key));
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;

Didn't we agree that we will share the code and simply return the key?

Maybe I missed further discussion on this?

