Return-Path: <netdev+bounces-38586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B987BB850
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34392821AF
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9351F604;
	Fri,  6 Oct 2023 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z/CGcxu9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEC1D690
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:59:25 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FADE
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:59:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-534659061afso3564006a12.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696597162; x=1697201962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFlsrhnP1/HfCk/6XDssfceLvaISdO3xQuiwUq+aROM=;
        b=Z/CGcxu9uESHnBvcIpxfUn3z5l0AIfXBhiXmD9llzCscKpntA+cocANXqP+YkyjcCl
         tTZuFyNNi9itMLjImYoQrQLlq7LTvMEFJdqW/LK2UH2Q9KTx3V+pPyThXL97qWpIm7AL
         Z5RJX37rWDRz64AYUSHHzXr63TA8pUIFivHk9HllEjjW0N33g3egq7sxPZM69kasK71d
         zhg+R74BHa7qO8pSi5my3SZjgA/lrWtnrLysRVXGxzCGG1LAXI5wS2/PHDqMGxKq8ylk
         BLTPeeyw16LoSUvpsd6JtCTJcdK36OlqsmwwweQdWpVkrR/E9bdm0n8RCYV2dWQcWRS2
         J7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696597162; x=1697201962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFlsrhnP1/HfCk/6XDssfceLvaISdO3xQuiwUq+aROM=;
        b=vxwmCdfrwOi/wXZ3fx9t2SXHOhNVUckT9ZixuRnm2NyUNeHLU511DnEBMt0pXlfJni
         Hykh2l3ZHYz/eR46a72faOTdcnGSuZxehOdNxVypgtchUWIw293YTJRrd8HFbb7AyqML
         spKBHqZrp4Wxr2ooJnI5wzhzX276Qvu/sRxlsKqA/ZNELbCKPm+O86Sk3E5i+3CqQJOH
         zYcjgJ0FxwhUzSKR/pU4iMO5CmZ7T2Q3ddU/N8ERjqrWwXRRiIvegHYEyqKbosCFvJGp
         XysqJFTB9UJ1ezvbMu4Ns2w3+uN4el50UYgb6MNkGovzkM7kvUludrsWnhFJbVUbCC6g
         GhHg==
X-Gm-Message-State: AOJu0YyR3Phi94AiB7BDDDHRmohXY3kpoWu2BVZNuvhqIlijhKPogyaN
	PIWgED/EHZFNVJ/ZNOiyFBuG0w==
X-Google-Smtp-Source: AGHT+IGI56/u4vzDm6qQ2m9Pnoth6l4vTcHOxC/UpRQhlqIr8/2twG9q26ynOtKCcPPw+hmuSEybOA==
X-Received: by 2002:aa7:d299:0:b0:531:11fa:eacf with SMTP id w25-20020aa7d299000000b0053111faeacfmr6870878edq.2.1696597161989;
        Fri, 06 Oct 2023 05:59:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d9c4000000b0052284228e3bsm2546463eds.8.2023.10.06.05.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:59:21 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:59:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	mleitner@redhat.com, vladbu@nvidia.com, simon.horman@corigine.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
Message-ID: <ZSAEp+tr1oXHOy/C@nanopsycho>
References: <20231005184228.467845-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005184228.467845-1-victor@mojatatu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 05, 2023 at 08:42:25PM CEST, victor@mojatatu.com wrote:
>__Context__
>The "tc block" is a collection of netdevs/ports which allow qdiscs to share
>match-action block instances (as opposed to the traditional tc filter per
>netdev/port)[1].
>
>Example setup:
>$ tc qdisc add dev ens7 ingress block 22
>$ tc qdisc add dev ens8 ingress block 22
>
>Once the block is created we can add a filter using the block index:
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action drop
>
>A packet with dst IP matching 192.168.0.0/16 arriving on the ingress of
>either ens7 or ens8 is dropped.
>
>__This patchset__
>Up to this point in the implementation, the block is unaware of its ports.
>This patch fixes that and makes the tc block ports available to the

Odd. You fix a bug. Is there a bug? If yes, you need to describe it. If
no, don't use "fix".


>datapath.
>
>For the datapath we provide a use case of the tc block in an action
>we call "blockcast" in patch 3. This action can be used in an example as
>such:
>
>$ tc qdisc add dev ens7 ingress block 22
>$ tc qdisc add dev ens8 ingress block 22
>$ tc qdisc add dev ens9 ingress block 22
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action blockcast

Seems to me a bit odd that the action works with the entity (block) is
is connected to. I would expect rather to give the action configuration:

$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast block 22
                                                ^^^^^^^^

Then this is more flexible and allows user to use this action for any
packet, no matter from where it was received.

Looks like this is functionality-wise similar to mirred redirect. Why
can't we have that action extended to accept block number instead of
netdev and have something like:

$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22

This would be very much alike we do either "tc filter add dev X" or "tc
filter add block Y".

Regarding the filtering, that could be a simple flag config of mirred
action:

$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
  srcfilter

Or something like that.

Makes sense?



>
>When a packet(matching dst IP 192.168.0.0/16) arrives on the ingress of any
>of ens7, ens8 or ens9 it will be copied to all ports other than itself.
>For example, if it arrives on ens8 then a copy of the packet will be
>"blockcasted";-> to both ens7 and ens9 (unmodified), but not to ens8.
>
>Patch 1 introduces the required infra. Patch 2 exposes the tc block to the
>tc datapath and patch 3 implements datapath usage via a new tc action
>"blockcast".
>
>__Acknowledgements__
>Suggestions from Vlad Buslov and Marcelo Ricardo Leitner made this patchset
>better. The idea of integrating the ports into the tc block was suggested
>by Jiri Pirko.
>
>[1] See commit ca46abd6f89f ("Merge branch 'net-sched-allow-qdiscs-to-share-filter-block-instances'")
>
>Changes in v2:
>  - Remove RFC tag
>  - Add more details in patch 0(Jiri)
>  - When CONFIG_NET_TC_SKB_EXT is selected we have unused qdisc_cb
>    Reported-by: kernel test robot <lkp@intel.com> (and horms@kernel.org)
>  - Fix bad dev dereference in printk of blockcast action (Simon)
>
>Changes in v3:
>  - Add missing xa_destroy (pointed out by Vlad)
>  - Remove bugfix pointed by Vlad (will send in separate patch)
>  - Removed ports from subject in patch #2 and typos (suggested by Marcelo)
>  - Remove net_notice_ratelimited debug messages in error
>    cases (suggested by Marcelo)
>  - Minor changes to appease sparse's lock context warning
>
>Changes in v4:
>  - Avoid code repetition using gotos in cast_one (suggested by Paolo)
>  - Fix typo in cover letter (pointed out by Paolo)
>  - Create a module description for act_blockcast
>    (reported by Paolo and CI)
>
>Victor Nogueira (3):
>  net/sched: Introduce tc block netdev tracking infra
>  net/sched: cls_api: Expose tc block to the datapath
>  net/sched: act_blockcast: Introduce blockcast tc action
>
> include/net/sch_generic.h    |   8 +
> include/net/tc_wrapper.h     |   5 +
> include/uapi/linux/pkt_cls.h |   1 +
> net/sched/Kconfig            |  13 ++
> net/sched/Makefile           |   1 +
> net/sched/act_blockcast.c    | 297 +++++++++++++++++++++++++++++++++++
> net/sched/cls_api.c          |  12 +-
> net/sched/sch_api.c          |  58 +++++++
> net/sched/sch_generic.c      |  34 +++-
> 9 files changed, 426 insertions(+), 3 deletions(-)
> create mode 100644 net/sched/act_blockcast.c
>
>-- 
>2.25.1
>

