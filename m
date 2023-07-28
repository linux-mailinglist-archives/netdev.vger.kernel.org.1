Return-Path: <netdev+bounces-22238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D6766A5B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2708528268E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F00125A1;
	Fri, 28 Jul 2023 10:25:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8E1118B
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:25:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E64217
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690539895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAWba4cN1kABxS+VBrOWpAMxCky09h9P/cCqvU2dr+c=;
	b=Zs1P+nUMUw0ynmJ7okrfI5x2fuQiZX3MqLSPyPoP13eR1DodXgrs9gspj+LN7h5tThCZyS
	OrnmUYfkYnmhk4FVTyKGyty9wwnWPuvSG26cNbcrJAHKdmzEk2THzDcylDZ/deQKaOHj4E
	uPcR8kgkel0I+XEAPVA9sKvzPygIW1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-ltB0QWPTOH-Ff8dJu4BUdQ-1; Fri, 28 Jul 2023 06:24:54 -0400
X-MC-Unique: ltB0QWPTOH-Ff8dJu4BUdQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbfc766a78so10450945e9.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 03:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690539893; x=1691144693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAWba4cN1kABxS+VBrOWpAMxCky09h9P/cCqvU2dr+c=;
        b=F81L9kx52HvLnRDvbSqPGtW3M9210LMzHt8zVFDIZJZaSktpUpe7klS/6N6mgRyT8H
         ugDwuP2qEefrGJA8JEZYRIGNK6Ow2IZw9ZVNkGcBnlQy8eM5tttiJHYzoI2zGKQG0tbw
         ZxXl+nJP38w7cluefQ3obB/5IpSlU96gmexaitY1Kq5Uog6FqBJwQI2FN3JAO6mnuZGQ
         6qHkU2ui0K21o3B59R3EzpGNTFK55T8v0pCvr71dXl1kFz+7g+aYwYnFB5DM+hUqxLKe
         hePyYzOyJqTuTRcjYI3Gy7wFCitjaBkJBUrXR6Xjd6syCk12FY8DN3VgyIyr656ZLHiU
         HRiQ==
X-Gm-Message-State: ABy/qLYf9NBdn2HmgGudTDCCxfr8b87l52UDdHiVgRj2tfZs4hNyvlyr
	DAJSsaFmvcA34SBoU8ZQxaLIQIiUZOMWpzcwhK8ZBV7JDEaettZu4dwHJqjN2PPC3gOCZo9cumP
	nCAg4/giSGt2AQGhVavmRmdeFBEs=
X-Received: by 2002:a1c:4c0e:0:b0:3fd:d763:448e with SMTP id z14-20020a1c4c0e000000b003fdd763448emr1315749wmf.21.1690539893142;
        Fri, 28 Jul 2023 03:24:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGzDmNzUaiLW6U5M1A2xnVUfk2+FW60ndIuKr8Hdh8tw28y5uhD5NXvLIKqQqUkOBpVWe68Ew==
X-Received: by 2002:a1c:4c0e:0:b0:3fd:d763:448e with SMTP id z14-20020a1c4c0e000000b003fdd763448emr1315733wmf.21.1690539892708;
        Fri, 28 Jul 2023 03:24:52 -0700 (PDT)
Received: from [192.168.0.12] ([78.19.108.164])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003f91e32b1ebsm6745542wmi.17.2023.07.28.03.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 03:24:52 -0700 (PDT)
Message-ID: <908e8567-05c8-fb94-5910-ecbee16eb842@redhat.com>
Date: Fri, 28 Jul 2023 11:24:51 +0100
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
 pabeni@redhat.com
References: <20230727120353.3020678-1-mtahhan@redhat.com>
 <20230727173753.6e044c13@kernel.org>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20230727173753.6e044c13@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/07/2023 01:37, Jakub Kicinski wrote:
> On Thu, 27 Jul 2023 08:03:29 -0400 Maryam Tahhan wrote:
>> Use a json configuration file to pass parameters to ynl to allow
>> for operations on multiple specs in one go. Additionally, check
>> this new configuration against a schema to validate it in the cli
>> module before parsing it and passing info to the ynl module.
> Interesting. Is this related to Donald's comments about subscribing
> to notifications from multiple families?
>
> Can you share some info about your use case?


Yes it's related. We are working towards using YNL as a netlink agent or 
part of a netlink agent that's driven by YAML specs. We are

trying to enable existing Kubernetes CNIs to integrate with DPUs via an 
OPI [1] API without having to change these existing CNIs. In several

cases these CNIs program the Kernel as both the control plane and the 
fallback dataplane (for packets the DPU accelerator doesn't know what

to do with). And so being able to monitor netlink state and reflect it 
to the DPU accelerator (and vice versa) via an OPI API would be 
extremely useful.


We think the YAML part gives us a solid model that showcases the breadth 
of what these CNIs program (via netlink) as well as a base for the grpc 
protobufs that

the OPI API would like to define/use.


>> Example configs would be:
>>
>> {
>>      "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>>      "spec-args": {
>>          "ethtool.yaml": {
>>              "do": "rings-get",
>>              "json-params": {
>>                  "header": {
>>                      "dev-name": "eno1"
>>                  }
>>              }
>>          },
>>         "netdev.yaml": {
>>              "do": "dev-get",
>>              "json-params": {
>>              "ifindex": 3
>>              }
>>          }
>>      }
>> }
> Why is the JSON preferable to writing a script to the same effect?
> It'd actually be shorter and more flexible.
> Maybe we should focus on packaging YNL as a python lib?

I guess you can write a script. The reasons I picked JSON were mainly:

-  Simplicity and Readability for both developers and non-developers/users.

- With the JSON Schema Validation I could very quickly validate the 
incoming configuration without too much logic in cli.py.

- I thought of it as a stepping stone towards an agent configuration 
file if YNL evolves to provide or be part of a netlink agent (driven by 
yaml specs)...


>
>> OR
>>
>> {
>>      "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
>>      "spec-args": {
>>          "ethtool.yaml": {
>>              "subscribe": "monitor",
>>              "sleep": 10
>>          },
>>          "netdev.yaml": {
>>              "subscribe": "mgmt",
>>              "sleep": 5
>>          }
>>      }
>> }
> Could you also share the outputs the examples would produce?
>
Right now the output is simple, an example would be for the first config 
in the email:

[ linux]# ./tools/net/ynl/cli.py --config ./tools/net/ynl/multi-do.json
###############  ethtool.yaml  ###############

{'header': {'dev-index': 3, 'dev-name': 'eno1'},
  'rx': 512,
  'rx-max': 8192,
  'rx-push': 0,
  'tx': 512,
  'tx-max': 8192,
  'tx-push': 0}
###############  netdev.yaml  ###############

{'ifindex': 3, 'xdp-features': {'xsk-zerocopy', 'redirect', 'basic'}}


Or for the second config in the email (note: I just toggled the tx ring 
descriptors on one of my NICs to trigger an ethtool notification):

[root@nfvsdn-06 linux]# ./tools/net/ynl/cli.py --config 
./tools/net/ynl/multi-ntf.json
###############  ethtool.yaml  ###############

[{'msg': {'header': {'dev-index': 3, 'dev-name': 'eno1'},
           'rx': 512,
           'rx-max': 8192,
           'rx-push': 0,
           'tx': 8192,
           'tx-max': 8192,
           'tx-push': 0},
   'name': 'rings-ntf'}]
###############  netdev.yaml  ###############

[]

At the moment (even with these changes) YNL subscribes-sleeps-checks for 
notification for each family sequentially...
I will be looking into enabling an agent like behaviour: subscribe to 
notifications from multiple families and monitor (babysteps)....

[1] https://opiproject.org/



