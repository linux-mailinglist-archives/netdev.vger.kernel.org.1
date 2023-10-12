Return-Path: <netdev+bounces-40374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F577C6F76
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AC81C20DF9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAE2942B;
	Thu, 12 Oct 2023 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uXt3wDbd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1822770E
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:42:33 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3494
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:42:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso1795743a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697118149; x=1697722949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptKGcVsgbG5guyvEzNf7T8XWxFq0oIGK9V19XuyWDf8=;
        b=uXt3wDbd/19dqyUmoFUsZL5J0iQGWIGiNqMjIHKcoqj9QQYxGiGFVacncQM/5rjPhi
         c9Cvgm3+DIwNh1X6/RMSB26ER+g7Vc6Rp9c6XO7NP2UADuQXIcp+cVXhI6djnxCx47us
         JAQsPT2Or6FNhbIKjZmXPHXmU9puXBXz7SeFI4K1A13BKG0tW8sIAiwgoPDYckuWrdDF
         hzYNSjK34tCEgG1k7TW392o2TLLlAjyxRi23CsKtnhYMfKmYQBDTusCYiAI/KZLKrKT9
         57MMRhjy2bU4oyijidMSFjIAqu/1jtoVSGmbG9/BbDP1o0U5mYUPlmum2JF8vgs3/l3V
         /PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118149; x=1697722949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptKGcVsgbG5guyvEzNf7T8XWxFq0oIGK9V19XuyWDf8=;
        b=GI3Jl1Aa1YKRxjbKYu+GxWybu73/6ycQY6T8uTkgv6LqknG2BQIubxabPVOd4lRz7T
         mMZeFm1KyaTmlGWGRwZo/QVrbl1SMNSP8Axca3ytjH2eIvzEPE93v7MuJKxU4aouHexM
         2HyLg8BzVyXPlMtrJ8Jj8MHdAWAwd/DbW0KVtQhvOgbt1Rllq+ASDQLYqQ6W6W0LhwvO
         6sD5WrKuihpBhAjwjJrKKNolB/xK5xpBn6DSUSin4oWTqzBhS+tYB5DYLuSzu8ugG+Cn
         irZ+7eMrhX9K+kPVjrsJywUluyctWprt4rC0KM/kv331/vDMz4CLJguTYDYzjIO0C0CO
         hq1A==
X-Gm-Message-State: AOJu0YyzMq6OkTk3wS7JQk4at6ekFvFdGyCWNhgBGZJ4Y3Zsk2XGrNrR
	MxT+DoB2OmUORS/sZ6PtXYvM7w==
X-Google-Smtp-Source: AGHT+IFs1Cpu+Eb1jCRwmQJrX297SwOYbLj3Nj99SCnBBymP4GBDj2PjQh/8sjowPyhMbuB0//dtpA==
X-Received: by 2002:a17:906:318e:b0:9b2:d554:da0e with SMTP id 14-20020a170906318e00b009b2d554da0emr19260450ejy.69.1697118148835;
        Thu, 12 Oct 2023 06:42:28 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090681c500b00993a37aebc5sm11025050ejx.50.2023.10.12.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:42:28 -0700 (PDT)
Date: Thu, 12 Oct 2023 15:42:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew@lunn.ch, aelior@marvell.com, manishc@marvell.com,
	horms@kernel.org, vladimir.oltean@nxp.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jdamato@fastly.com,
	d-tatianin@yandex-team.ru, kuba@kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v4 1/2] ethtool: Add forced speed to supported
 link modes maps
Message-ID: <ZSf3wqZ33fA0yfA1@nanopsycho>
References: <20231011131348.435353-1-pawel.chmielewski@intel.com>
 <20231011131348.435353-2-pawel.chmielewski@intel.com>
 <ZSa7Y9gwC8qCBv2r@nanopsycho>
 <ZSf1m7uIYGuF35a8@baltimore>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSf1m7uIYGuF35a8@baltimore>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 12, 2023 at 03:33:15PM CEST, pawel.chmielewski@intel.com wrote:
>> >diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> 
>> Why you put this into ioctl.c?
>> 
>> Can't this be put into include/linux/linkmode.h as a static helper as
>> well?
>
>I'm a little bit confused, include/linux/linkmode.h doesn't contain
>similar ethtool helpers.. Did you maybe meant ethtool.h?

I just looked there linkmode_set_bit_array is. ethtool.h might be the
place.


> 
>> 
>> >index 0b0ce4f81c01..34507691fc9d 100644
>> >--- a/net/ethtool/ioctl.c
>> >+++ b/net/ethtool/ioctl.c
>> >@@ -3388,3 +3388,16 @@ void ethtool_rx_flow_rule_destroy(struct ethtool_rx_flow_rule *flow)
>> > 	kfree(flow);
>> > }
>> > EXPORT_SYMBOL(ethtool_rx_flow_rule_destroy);
>> >+
>> >+void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
>> >+				    u32 size)
>> >+{
>> >+	for (u32 i = 0; i < size; i++) {
>> >+		struct ethtool_forced_speed_map *map = &maps[i];
>> >+
>> >+		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
>> >+		map->cap_arr = NULL;
>> >+		map->arr_size = 0;
>> >+	}
>> >+}
>> >+EXPORT_SYMBOL(ethtool_forced_speed_maps_init);
>> >-- 
>> >2.37.3
>> >
>> >
>

