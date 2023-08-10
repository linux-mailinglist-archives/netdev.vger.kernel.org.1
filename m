Return-Path: <netdev+bounces-26215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16D7772E9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA49B281C57
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DFE46A0;
	Thu, 10 Aug 2023 08:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE431E52A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:30:54 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90250ED
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:30:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so5279905e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691656252; x=1692261052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izdgj1+Ti9qTMM+7DJT/zvVEar//RGl1qcQTHqRs4Y4=;
        b=3BfeGE52edDNAZ9J7zdcGnSjYv6mWl/8Q6A1+8EU0wwkb21gBoUe4PUSKAweZBcyEu
         J5NI1pBcX64kpvCiz+X4SXwc49nKMFJpNvVy0Db0P75OPKLoyzZJERlmx/1pBQ2qm8ln
         E/kJyM8BMUucCiMhLSZehHcAOuhnmfag77o68IN62nR/QAELBVvcupFqK6+EAVoApVim
         i7Ki71JAAAz9GHm1YgJMygi3lnHZMPzM1r8z4W5Zus0cbTg+SgeYhyZRKgV6/WcTj1Pa
         m8LC81cs9eSKcTGFgRuXYq7R/7kTVxy6gN9M/CC0g3RWXBhOyvnOZy4H5HyP+Wg1kC1N
         HJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656252; x=1692261052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izdgj1+Ti9qTMM+7DJT/zvVEar//RGl1qcQTHqRs4Y4=;
        b=Y6ac5SLK2pr/6p+TXmGA/XsSy9exOwNvTD1UZrVTPxsSgCYA34+/9Yodoe+69L1wT7
         YozTJIEx3beTlj9pbSBMABdq/o3c2E/BgCfntEzmy1bllPDgwRRseisoPy0J07jDh0Bz
         vkPrnfh3pG1ee577PGmu2MheM03Yhdn7mRYTmQh+tJlYLvTWbc2nnGzPHtgYKb6qNG1P
         3R3V2Iff1GB6GH7I5P8DZ3uxvvIGHfrmXma/2UQ6mLzYPNXjR4C7AzblE+cUsuRPTZLL
         k7IklBUZIBG5hoA7e0Khuee0W7JJO7NN1SEURaJOSiJxBkpGagC75HAhI90nr0KMfKOG
         U0tQ==
X-Gm-Message-State: AOJu0YzqzZi7XYzLVFX13KuRZlaXrWl4Egbj7QBE+ssAQ54UtNSfyiw1
	fTDy7iaaEVbVHOlecqMPXm5ymKzwEKzrYOdtRmsEFQ==
X-Google-Smtp-Source: AGHT+IENxJUkilSCfneA1mmQnbDAbKtF/8JHkb3KeUD54mEM5gHoY6e6pYTUMQdeQGoO2prmKZZlTg==
X-Received: by 2002:a05:600c:b59:b0:3fe:18d8:a61b with SMTP id k25-20020a05600c0b5900b003fe18d8a61bmr1410209wmr.29.1691656251760;
        Thu, 10 Aug 2023 01:30:51 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id l24-20020a7bc458000000b003fbb25da65bsm1358020wmi.30.2023.08.10.01.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:30:51 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:30:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 00/10] genetlink: provide struct genl_info to
 dumps
Message-ID: <ZNSgOt91RerMMhXV@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-1-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:38PM CEST, kuba@kernel.org wrote:
>One of the biggest (which is not to say only) annoyances with genetlink
>handling today is that doit and dumpit need some of the same information,
>but it is passed to them in completely different structs.
>
>The implementations commonly end up writing a _fill() method which
>populates a message and have to pass at least 6 parameters. 3 of which
>are extracted manually from request info.
>
>After a lot of umming and ahing I decided to populate struct genl_info
>for dumps, without trying to factor out only the common parts.
>This makes the adoption easiest.
>
>In the future we may add a new version of dump which takes
>struct genl_info *info as the second argument, instead of

That would be very nice. I'm dreaming about that for quite some time :)


>struct netlink_callback *cb. For now developers have to call
>genl_info_dump(cb) to get the info.
>
>Typical genetlink families no longer get exposed to netlink protocol
>internals like pid and seq numbers.
>
>Jakub Kicinski (10):
>  genetlink: use push conditional locking info dumpit/done
>  genetlink: make genl_info->nlhdr const
>  genetlink: remove userhdr from struct genl_info
>  genetlink: add struct genl_info to struct genl_dumpit_info
>  genetlink: use attrs from struct genl_info
>  genetlink: add a family pointer to struct genl_info
>  genetlink: add genlmsg_iput() API
>  netdev-genl: use struct genl_info for reply construction
>  ethtool: netlink: simplify arguments to ethnl_default_parse()
>  ethtool: netlink: always pass genl_info to .prepare_data
>
> drivers/block/drbd/drbd_nl.c    |   9 +--
> drivers/net/wireguard/netlink.c |   2 +-
> include/net/genetlink.h         |  72 +++++++++++++++++--
> net/core/netdev-genl.c          |  15 ++--
> net/devlink/health.c            |   2 +-
> net/devlink/leftover.c          |   6 +-
> net/ethtool/channels.c          |   2 +-
> net/ethtool/coalesce.c          |   6 +-
> net/ethtool/debug.c             |   2 +-
> net/ethtool/eee.c               |   2 +-
> net/ethtool/eeprom.c            |   9 ++-
> net/ethtool/features.c          |   2 +-
> net/ethtool/fec.c               |   2 +-
> net/ethtool/linkinfo.c          |   2 +-
> net/ethtool/linkmodes.c         |   2 +-
> net/ethtool/linkstate.c         |   2 +-
> net/ethtool/mm.c                |   2 +-
> net/ethtool/module.c            |   5 +-
> net/ethtool/netlink.c           |  31 ++++-----
> net/ethtool/netlink.h           |   2 +-
> net/ethtool/pause.c             |   5 +-
> net/ethtool/phc_vclocks.c       |   2 +-
> net/ethtool/plca.c              |   4 +-
> net/ethtool/privflags.c         |   2 +-
> net/ethtool/pse-pd.c            |   6 +-
> net/ethtool/rings.c             |   5 +-
> net/ethtool/rss.c               |   3 +-
> net/ethtool/stats.c             |   5 +-
> net/ethtool/strset.c            |   2 +-
> net/ethtool/tsinfo.c            |   2 +-
> net/ethtool/tunnels.c           |   2 +-
> net/ethtool/wol.c               |   5 +-
> net/ieee802154/nl802154.c       |   4 +-
> net/ncsi/ncsi-netlink.c         |   2 +-
> net/ncsi/ncsi-netlink.h         |   2 +-
> net/netlink/genetlink.c         | 119 +++++++++++++++-----------------
> net/nfc/netlink.c               |   4 +-
> net/openvswitch/conntrack.c     |   2 +-
> net/openvswitch/datapath.c      |  29 ++++----
> net/openvswitch/meter.c         |  10 +--
> net/tipc/netlink_compat.c       |   4 +-
> net/tipc/node.c                 |   4 +-
> net/tipc/socket.c               |   2 +-
> net/tipc/udp_media.c            |   2 +-
> 44 files changed, 226 insertions(+), 178 deletions(-)
>
>-- 
>2.41.0
>

