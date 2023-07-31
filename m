Return-Path: <netdev+bounces-22728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D1768FBA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C961C20B5D
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEF11C80;
	Mon, 31 Jul 2023 08:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983F2117
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:13:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F901FC1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690791164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2c/vsUe51aE0k9BbQvxW32USgWcCe8PJ604bKyDOMe8=;
	b=HdytL9vMEkjJR+70IQMrWeHshn7cuFEkfP5B/gO39u4uLgXTqlqBBOXPDan2W/GmkTiS4E
	sEpadICDOMSWPC0uMnu3YoNfjn/PurTwg+sgPl1PEU7YRgLH5efYtrBhn4DVsGuTAF0E2V
	bDKxI2bQzM6SWjDiCKYIJyxPRYhV70g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-WKX4frAdOX2SwlPB_hx82A-1; Mon, 31 Jul 2023 04:12:43 -0400
X-MC-Unique: WKX4frAdOX2SwlPB_hx82A-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4055b94c7c9so30845931cf.3
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791162; x=1691395962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2c/vsUe51aE0k9BbQvxW32USgWcCe8PJ604bKyDOMe8=;
        b=fuRKURWmukLTd3IA4LojFo6l0CzIFz6MvOSezh9gZLA/1Gqv+eKCUTeSCSt6KJlZkx
         2+6tciApdiGOaG6HWMAU/YamqIZsbLpkEb8nmceai/lf111ZIcg06aIpBHc8tT0QqKT6
         nlsCnEidD7pzgYWgfSNWb3Sr54m1mTECdyJRQ4c/M1PkmgwN7VrY/OQJaRqlJGvXaQHb
         qnvtJhDEqFPbGnMrwTsGY88LgR9ZiLN0dqBRCUwkSrlFXjMxU3NH0Z7kOHWGz5lTsRI8
         el4f8HAFyXXMlU/BprgAE7h+/8eYBnLkuQn/YK5kOe5MkRKOmSJmY49jFn13PhVznCHU
         w4PA==
X-Gm-Message-State: ABy/qLauymC97kMJvoyPCyikbBjVgAJD05XhJA6ZjKAd3XnTOAflJfRx
	UYxfF9EgKL6ZoEeshcBjS9YsC+1Wh4YIYxIy9oG+0kGEVMiwSYposKYA+KN3YyZjZEMK0Y7HDh/
	XhHcJBbq1BOHs5wsL
X-Received: by 2002:a05:622a:190d:b0:403:e72d:de3b with SMTP id w13-20020a05622a190d00b00403e72dde3bmr10105467qtc.11.1690791162639;
        Mon, 31 Jul 2023 01:12:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfihXxVxe2THySN65yC0X9qRZygsDhfZFLzNNVevm07rRDA8kf/DhsULumUW0tjBaqIEESdw==
X-Received: by 2002:a05:622a:190d:b0:403:e72d:de3b with SMTP id w13-20020a05622a190d00b00403e72dde3bmr10105454qtc.11.1690791162339;
        Mon, 31 Jul 2023 01:12:42 -0700 (PDT)
Received: from [192.168.0.12] ([78.19.108.164])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85485000000b004055d45e420sm3307149qtq.56.2023.07.31.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:12:41 -0700 (PDT)
Message-ID: <7634af55-8a87-1b21-8ba6-8b1a8d245792@redhat.com>
Date: Mon, 31 Jul 2023 09:12:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 0/2] tools/net/ynl: enable json configuration
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Donald Hunter <donhunte@redhat.com>,
 Billy McFall <bmcfall@redhat.com>
References: <20230727120353.3020678-1-mtahhan@redhat.com>
 <20230727173753.6e044c13@kernel.org>
 <908e8567-05c8-fb94-5910-ecbee16eb842@redhat.com>
 <20230728084902.1dd524c5@kernel.org>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20230728084902.1dd524c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/07/2023 16:49, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 11:24:51 +0100 Maryam Tahhan wrote:
>> On 28/07/2023 01:37, Jakub Kicinski wrote:
>>> On Thu, 27 Jul 2023 08:03:29 -0400 Maryam Tahhan wrote:
>>>> Use a json configuration file to pass parameters to ynl to allow
>>>> for operations on multiple specs in one go. Additionally, check
>>>> this new configuration against a schema to validate it in the cli
>>>> module before parsing it and passing info to the ynl module.
>>> Interesting. Is this related to Donald's comments about subscribing
>>> to notifications from multiple families?
>>>
>>> Can you share some info about your use case?
>>
>> Yes it's related. We are working towards using YNL as a netlink agent or
>> part of a netlink agent that's driven by YAML specs. We are
>>
>> trying to enable existing Kubernetes CNIs to integrate with DPUs via an
>> OPI [1] API without having to change these existing CNIs. In several
>>
>> cases these CNIs program the Kernel as both the control plane and the
>> fallback dataplane (for packets the DPU accelerator doesn't know what
>> to do with). And so being able to monitor netlink state and reflect it
>> to the DPU accelerator (and vice versa) via an OPI API would be
>> extremely useful.
>>
>>
>> We think the YAML part gives us a solid model that showcases the breadth
>> of what these CNIs program (via netlink) as well as a base for the grpc
>> protobufs that the OPI API would like to define/use.
> So agent on the host is listening to netlink and sending to DPU gRPC
> requests? From what you're describing it sounds like you'd mostly want
> to pass the notifications. The multi-command thing is to let the DPU
> also make requests if it needs to do/know something specific?

Yes, this is pretty much the idea.


>
>>>> Example configs would be:
>>>>
>>>> {
>>>>       "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>>>>       "spec-args": {
>>>>           "ethtool.yaml": {
>>>>               "do": "rings-get",
>>>>               "json-params": {
>>>>                   "header": {
>>>>                       "dev-name": "eno1"
>>>>                   }
>>>>               }
>>>>           },
>>>>          "netdev.yaml": {
>>>>               "do": "dev-get",
>>>>               "json-params": {
>>>>               "ifindex": 3
>>>>               }
>>>>           }
>>>>       }
>>>> }
>>> Why is the JSON preferable to writing a script to the same effect?
>>> It'd actually be shorter and more flexible.
>>> Maybe we should focus on packaging YNL as a python lib?
>> I guess you can write a script. The reasons I picked JSON were mainly:
>>
>> -  Simplicity and Readability for both developers and non-developers/users.
>>
>> - With the JSON Schema Validation I could very quickly validate the
>> incoming configuration without too much logic in cli.py.
>>
>> - I thought of it as a stepping stone towards an agent configuration
>> file if YNL evolves to provide or be part of a netlink agent (driven by
>> yaml specs)...
> Those are very valid. My worry is that:
>   - it's not a great fit for asynchronous stuff like notifications
>     (at least a simple version built directly from cli.py)
>   - we'd end up needing some flow control and/or transfer of values
>     at some point, and it will evolve into a full blown DSL
Ok, I can look at a script and see what this looks like.
>
>>>> OR
>>>>
>>>> {
>>>>       "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>>>>       "spec-args": {
>>>>           "ethtool.yaml": {
>>>>               "subscribe": "monitor",
>>>>               "sleep": 10
>>>>           },
>>>>           "netdev.yaml": {
>>>>               "subscribe": "mgmt",
>>>>               "sleep": 5
>>>>           }
>>>>       }
>>>> }
>>> Could you also share the outputs the examples would produce?
>>>   
>> Right now the output is simple, an example would be for the first config
>> in the email:
>>
>> [ linux]# ./tools/net/ynl/cli.py --config ./tools/net/ynl/multi-do.json
>> ###############  ethtool.yaml  ###############
>>
>> {'header': {'dev-index': 3, 'dev-name': 'eno1'},
>>    'rx': 512,
>>    'rx-max': 8192,
>>    'rx-push': 0,
>>    'tx': 512,
>>    'tx-max': 8192,
>>    'tx-push': 0}
>> ###############  netdev.yaml  ###############
>>
>> {'ifindex': 3, 'xdp-features': {'xsk-zerocopy', 'redirect', 'basic'}}
> My concern was that this will not be optimal for the receiver to parse.
> Because the answer is not valid JSON. We'd need something like:
>
> [
>   { "cmd-id": "some-identifier?".
>     "response": { ... }
>   },
>   { "cmd-id": "identifier-of-second-command".
>     "response": { ... }
>   }
> ]
>
Yeah - makes sense. I was only focused on the configuration part for 
this patchset. This can be added.


>> Or for the second config in the email (note: I just toggled the tx ring
>> descriptors on one of my NICs to trigger an ethtool notification):
>>
>> [root@nfvsdn-06 linux]# ./tools/net/ynl/cli.py --config
>> ./tools/net/ynl/multi-ntf.json
>> ###############  ethtool.yaml  ###############
>>
>> [{'msg': {'header': {'dev-index': 3, 'dev-name': 'eno1'},
>>             'rx': 512,
>>             'rx-max': 8192,
>>             'rx-push': 0,
>>             'tx': 8192,
>>             'tx-max': 8192,
>>             'tx-push': 0},
>>     'name': 'rings-ntf'}]
>> ###############  netdev.yaml  ###############
>>
>> []
>>
>> At the moment (even with these changes) YNL subscribes-sleeps-checks for
>> notification for each family sequentially...
>> I will be looking into enabling an agent like behaviour: subscribe to
>> notifications from multiple families and monitor (babysteps)....
>>
>> [1] https://opiproject.org/
> Modulo the nits it sounds fairly reasonable. Main question is how much
> of that we put in the kernel tree, and how much lives elsewhere :S
> If we have a dependency on gRPC at some point, for example, that may
> be too much for kernel tools/

Yeah, that's a fair question. We would like to get all the gRPC stuff 
into the OPI repos. In the Kernel tree we'd like to get the netlink

agent and the YAML specs.

Thanks for the feedback. I will take it onboard.

>


