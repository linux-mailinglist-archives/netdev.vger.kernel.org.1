Return-Path: <netdev+bounces-34154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42307A2592
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4A42817AA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573B18AE7;
	Fri, 15 Sep 2023 18:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D2D15EBF
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:23:36 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903711FCC
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:23:35 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34e15f33a72so8509715ab.3
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694802215; x=1695407015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYxJ9BLaAiW6l+EYIbRNs2EfTz/cHO+AS5Sh/AKxz44=;
        b=fmqxx+cq47BZDL2vZQI8LIEBA/7FBllB9308nVcPNiVJd1FoYDxLk7yUeiDl8iE34y
         60jlEEcxSGyq9NILnNVP8chL85wczwYCzI+2IWUVciFkUDJdneb+2ENYsbWps90kUTEC
         5qSnP+gamRvyd4tnEHJ4zi0F0vZSHS143Cp4qEr/4ULOiOUCQ0FmibLIazShIfB2Z4YQ
         hidTPY4TazfCiVQCb1w0GS6EDVyBgS/1TFl7bAOFy5Fqwl4WY+k1qSE0iRYYAjv/z3kA
         BddbzeyFWXoFA5SJjv+5zigPQEFucJd9s3e0grPW6MjXR+fmnJRSNBPrcX1ZDKMVZ36i
         g7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802215; x=1695407015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYxJ9BLaAiW6l+EYIbRNs2EfTz/cHO+AS5Sh/AKxz44=;
        b=O+F1yw+AUJTr4psuq2Kd5IzJzS8n/giGllQujGhvUkXFf7LQ3qckyRN4ty3f3PkqW5
         eFthzWlTOwa7XDcudqpsYQzuWLf8yw+ibGrYGmJtYrV3a9U+ro8BaVng3B7ElDVcvC9v
         b54tBLH9sHj23Y59K3pAL0rznsjZkG4w8PaXaxEZKZ/Ltx/lRpDdB4wZAWE4OsNLeBok
         fzbPHipvBHjFq3EOFVV2f7eXgsoah/7tCTOT4acmfm9HOkIN9Zjvl8hmJvjOeAu47g+P
         M9DAfGw2G+WiAS8ddWkb7QgwsfS3xUfUsvEVdByh/I6yOx4h92KvxVLp8Sk9u55RiKXP
         4icg==
X-Gm-Message-State: AOJu0Yz4qcovsrj/PoAgLfiTMg2xExgxc8Rb8xzFPlxu7B3ZCtp0TdCZ
	Gor/O0CeKXqN8KGutEnNKNRNlSlV3ic=
X-Google-Smtp-Source: AGHT+IHG/1JiPTqFFT+zwwZkcrKJI6knZFW6aeAV8ejlSH7FRmnFV6eCqbJgBY/RFpMVceTcMIbopQ==
X-Received: by 2002:a05:6e02:c08:b0:348:c57f:b016 with SMTP id d8-20020a056e020c0800b00348c57fb016mr2857517ile.3.1694802214890;
        Fri, 15 Sep 2023 11:23:34 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:2d71:6451:e70a:d690? ([2601:282:1e82:2350:2d71:6451:e70a:d690])
        by smtp.googlemail.com with ESMTPSA id a8-20020a92c708000000b0034f47db5b40sm1255500ilp.74.2023.09.15.11.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 11:23:34 -0700 (PDT)
Message-ID: <157bf0b3-a37b-675a-1518-7161a47aed71@gmail.com>
Date: Fri, 15 Sep 2023 12:23:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH iproute2-next 1/2] configure: add the --color option
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>,
 Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org
References: <cover.1694625043.git.aclaudi@redhat.com>
 <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
 <20230915085912.78ffd25c@hermes.local>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230915085912.78ffd25c@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/15/23 9:59 AM, Stephen Hemminger wrote:
> On Wed, 13 Sep 2023 19:58:25 +0200
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
>> This commit allows users/packagers to choose a default for the color
>> output feature provided by some iproute2 tools.
>>
>> The configure script option is documented in the script itself and it is
>> pretty much self-explanatory. The default value is set to "never" to
>> avoid changes to the current ip, tc, and bridge behaviour.
>>
>> Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
>> ---
> 
> More build time config is not the answer either.
> Don't want complaints from distribution users about the change.
> Needs to be an environment variable or config file.

I liked the intent, and it defaults to off. Allowing an on by default
brings awareness of the usefulness of the color option.

I have applied the patches, so we need either a revert or followup based
on Stephen's objections.

