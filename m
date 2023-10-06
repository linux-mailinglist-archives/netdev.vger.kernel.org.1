Return-Path: <netdev+bounces-38639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC237BBD38
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228F8281EC2
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC628DCF;
	Fri,  6 Oct 2023 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KwAJDuzP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941001CF8A
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:50:34 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC63AD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:50:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b95622c620so444566266b.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696611028; x=1697215828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WHxPw0sJL5MxZLr93ecAPoqmX4WTFFt2Rb45FCqo6KQ=;
        b=KwAJDuzPnlDH8v56YP+tWHlHhlrB1kd3UDUUZiic7DK7wc89/3eMCGN8z4OitoUhVL
         6sVtPsmZoecKp4KhVFtbIzwBWLD3v+uC08IDnt+MMpl+yskPUnauuZjfyHpkE5n5gheS
         Zk1eZ1JP+Xs/cDQ+zgFJi/bLsHtoq2nijaG3rh2iK79HO4SjkxlUZy6xIPHkORv2l3IZ
         chQ1rx8L0bw5teaOFmmGRbfa3WAFTZbDjlnnGat2SDOQHiWzTVV5aK8w1h2kKKQFyqBf
         cooCJm+8FwIeP2m9SfN+YcswPBhTf4ivnFF7sltdpP72h3/zDKFob49qFf7xt4XzhOA9
         KdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611028; x=1697215828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHxPw0sJL5MxZLr93ecAPoqmX4WTFFt2Rb45FCqo6KQ=;
        b=GCpd1B5O9j4dsYffCxB6qyULMjC5lmdIfmY1lnLj3V5o9M7hAgxOCvBaNhC6qVhkfB
         rG+f/1odzoBoLaZVf4QVfAJlM5nxdsSuQ9mGwYvRe4AdvAXMgvdb12+FLaZ1Rk45D8Tc
         VCBJZsy8yGJMvMeHmZrzKQfndcLZnt+fwL9j7q2iJDD3mOQZ5bOhUYciOV7Y6tqIOS0w
         GtYj9fBqJmWn1zyx8UcariopSp+sfhgXF6DEcw80b8PtPSLWepezZRbj49OdtDqyPsU3
         xy8lveQOZ81szQlX8U2nQsb4pJEvTcPzj1ZbSvQlGrI0o9CuVVUVmUtGE8LznQkpSaJZ
         yjDw==
X-Gm-Message-State: AOJu0YyE0VV+Bjx58XNZrww0vAqk5ssZPwyN358HKfSg416rjL2MbwWS
	GafG1iCk1hvtjWrmW6ZNA4N2ig==
X-Google-Smtp-Source: AGHT+IEezNH/uj+1HSfdW1RYnQjdLcqSdhNkudc+R/+iffVMQ+yqbg0lHukS8wFAeAZ2gJJvY1iogw==
X-Received: by 2002:a17:906:3f5d:b0:9b2:b2f8:85dd with SMTP id f29-20020a1709063f5d00b009b2b2f885ddmr7912004ejj.34.1696611028311;
        Fri, 06 Oct 2023 09:50:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709067c4700b0099c53c4407dsm3156646ejp.78.2023.10.06.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:50:26 -0700 (PDT)
Date: Fri, 6 Oct 2023 18:50:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	kuba@kernel.org, mleitner@redhat.com, vladbu@nvidia.com,
	simon.horman@corigine.com, pctammela@mojatatu.com,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSA60cyLDVw13cLi@nanopsycho>
References: <20231005184228.467845-1-victor@mojatatu.com>
 <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Oct 06, 2023 at 05:37:41PM CEST, jhs@mojatatu.com wrote:
>On Fri, Oct 6, 2023 at 8:59 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Oct 05, 2023 at 08:42:25PM CEST, victor@mojatatu.com wrote:
>> >__Context__
>> >The "tc block" is a collection of netdevs/ports which allow qdiscs to share
>> >match-action block instances (as opposed to the traditional tc filter per
>> >netdev/port)[1].
>> >
>> >Example setup:
>> >$ tc qdisc add dev ens7 ingress block 22
>> >$ tc qdisc add dev ens8 ingress block 22
>> >
>> >Once the block is created we can add a filter using the block index:
>> >$ tc filter add block 22 protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action drop
>> >
>> >A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
>> >either ens7 or ens8 is dropped.
>> >
>> >__This patchset__
>> >Up to this point in the implementation, the block is unaware of its ports.
>> >This patch fixes that and makes the tc block ports available to the
>>
>> Odd. You fix a bug. Is there a bug? If yes, you need to describe it. If
>> no, don't use "fix".
>
>Ok, Jiri;->  we will change the language.
>
>>
>> >datapath.
>> >
>> >For the datapath we provide a use case of the tc block in an action
>> >we call "blockcast" in patch 3. This action can be used in an example as
>> >such:
>> >
>> >$ tc qdisc add dev ens7 ingress block 22
>> >$ tc qdisc add dev ens8 ingress block 22
>> >$ tc qdisc add dev ens9 ingress block 22
>> >$ tc filter add block 22 protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action blockcast
>>
>> Seems to me a bit odd that the action works with the entity (block) is
>> is connected to. I would expect rather to give the action configuration:
>>
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action blockcast block 22
>>                                                 ^^^^^^^^
>
>We are currently passing the blockid in the skb cb field so it is
>configuration-less. I suppose we could add this as an optional field
>and use it when specified.

I don't understand the need for configuration less here. You don't have
it for the rest of the actions. Why this is special?


>
>> Then this is more flexible and allows user to use this action for any
>> packet, no matter from where it was received.
>>
>> Looks like this is functionality-wise similar to mirred redirect. Why
>> can't we have that action extended to accept block number instead of
>> netdev and have something like:
>>
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>>
>> This would be very much alike we do either "tc filter add dev X" or "tc
>> filter add block Y".
>>
>
>We did consider it but concluded it is a lot of work to get it done on
>mirred - just take a look at mirred and you'll see what i mean;->
>Based on that review we came to the conclusion that at some point it
>would be safer to separate mirred's mirror from redirect; there are
>too many checks to avoid one or the other based on whether you are
>coming from egress vs ingress etc. This one is simple, it is just a
>broadcast.

Perhaps it is a nice opportunity to do such mirred cleanup, prepare the
code and implement block send afterwards?

If I omit the code for now, from user perspective, this functionality
belongs into mirred, don't you think? Just replace "dev" by "block" and
you got what you need.


>
>
>> Regarding the filtering, that could be a simple flag config of mirred
>> action:
>>
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>>   srcfilter
>>
>> Or something like that.
>>
>
>See my comment above.
>
>cheers,
>jamal
>> Makes sense?
>>
>>
>>
>> >
>> >When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of any
>> >of ens7, ens8 or ens9 it will be copied to all ports other than itself.
>> >For example, if it arrives on ens8 then a copy of the packet will be
>> >"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.
>> >
>> >Patch 1 introduces the required infra. Patch 2 exposes the tc block to the
>> >tc datapath and patch 3 implements datapath usage via a new tc action
>> >"blockcast".
>> >
>> >__Acknowledgements__
>> >Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patchset
>> >better. The idea of integrating the ports into the tc block was suggested
>> >by Jiri Pirko.
>> >
>> >[1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-share-filter-block-instances'")
>> >
>> >Changes in v2:
>> >  - Remove RFC tag
>> >  - Add more details in patch 0(Jiri)
>> >  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
>> >    Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.org)
>> >  - Fix bad dev dereference in printk of blockcast action (Simon)
>> >
>> >Changes in v3:
>> >  - Add missing xa_destroy (pointed out by Vlad)
>> >  - Remove bugfix pointed by Vlad (will send in separate patch)
>> >  - Removed ports from subject in patch #2 and typos (suggested by Marcelo)
>> >  - Remove net_notice_ratelimited debug messages in error
>> >    cases (suggested by Marcelo)
>> >  - Minor changes to appease sparse's lock context warning
>> >
>> >Changes in v4:
>> >  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
>> >  - Fix typo in cover letter (pointed out by Paolo)
>> >  - Create a module description for act_blockcast
>> >    (reported by Paolo and CI)
>> >
>> >Victor Nogueira (3):
>> >  net/sched: Introduce tc block netdev tracking infra
>> >  net/sched: cls_api: Expose tc block to the datapath
>> >  net/sched: act_blockcast: Introduce blockcast tc action
>> >
>> > include/net/sch_generic.h    |   8 +
>> > include/net/tc_wrapper.h     |   5 +
>> > include/uapi/linux/pkt_cls.h |   1 +
>> > net/sched/Kconfig            |  13 ++
>> > net/sched/Makefile           |   1 +
>> > net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
>> > net/sched/cls_api.c          |  12 +-
>> > net/sched/sch_api.c          |  58 +++++++
>> > net/sched/sch_generic.c      |  34 +++-
>> > 9 files changed, 426 insertions(+), 3 deletions(-)
>> > create mode 100644 net/sched/act_blockcast.c
>> >
>> >--
>> >2.25.1
>> >

