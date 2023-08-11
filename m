Return-Path: <netdev+bounces-26651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18277882F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A81C20BA4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433DD1FC4;
	Fri, 11 Aug 2023 07:30:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F91117
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:30:04 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7026AB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:30:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so1453618f8f.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691739000; x=1692343800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVs8GP/KKP3l7uk2C2YMLUg3oRMrM7bgeVE6UAb0kEo=;
        b=DpTu8fC+PDcLRHOyecA6PstUY/gwNzJPre0SK11Wff57+McHtZ1CM6NkoFHBhWCljM
         9rJPfxroH3mv9FVLdqM8Erht5Q3CZS2uSsg5Q1ZuJnxQd0c34XRPT+sv2ynMQkGTCWS+
         CWas2Xtyddnzzw9jj8lr8hxDKO93nsiEXwbahbIdVqksv1yovHEZBw0NQUNfFLPPIilW
         0J/lKnOiy4WRCJDrjrkNoYV0eCodBwLshOAmYxioVL1fAJLCQskyFKaDUsPavnMJ1l6x
         9Z0B3S27hhfoewRCE+hWzD17aSxOHERf+t+ot6qpChVeFdoXNIuA2MGxGwy4KpeLglk3
         gIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739000; x=1692343800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVs8GP/KKP3l7uk2C2YMLUg3oRMrM7bgeVE6UAb0kEo=;
        b=AG7orEoPx6KgY96jHr0ewFJ6LAZzHTgPoe20FGWUpcIq9aXdRhVlVsU6oiSxR74Vpr
         YUgna2rGNH6HbRwNNM0/ZRLl1+1gvKXl8mr29F7ZU2aarPEHyITJ67FHJlWNkJ2k38yP
         NH5u9POp0z8okK/4WItcYlUmC2Xde3XEYattRkqwj9gxaYL5Nz77PKXQrTP+Aw+GrGGX
         f4bTGq3W+LaYJSNT/XEwa7C7JvEjY06UbSAh65nJ82W1t9yBT5+dKuDwPoLQmQXfBt8X
         NjlKrgmHC/dYKmX9m9D8tTVo240LePSHHuyo3+gdYs1OrN7CtTAqMiHluFRohcTNFy6v
         mQlw==
X-Gm-Message-State: AOJu0Yx9HLZi1Sb0OnQhxc/X+yLKfPvMnDx4vq7sOXU2nnqIfR7dpyXB
	fCVQTXVZOjfhMiE9L+Ca/f0AOQ==
X-Google-Smtp-Source: AGHT+IE7xm9zgM+I6Pg63RuAL6J0atowi4kWJFIGUxNpKLZKbzjS8ZIybi4WAF1kU9jWarbSXzl/9Q==
X-Received: by 2002:a5d:4451:0:b0:317:5722:a41b with SMTP id x17-20020a5d4451000000b003175722a41bmr948866wrr.7.1691739000534;
        Fri, 11 Aug 2023 00:30:00 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id t18-20020adff612000000b00317b0155502sm4538257wrp.8.2023.08.11.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 00:29:59 -0700 (PDT)
Date: Fri, 11 Aug 2023 09:29:58 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	johannes@sipsolutions.net,
	Vladimir Oltean <vladimir.oltean@nxp.com>, gal@nvidia.com,
	tariqt@nvidia.com, lucien.xin@gmail.com, f.fainelli@gmail.com,
	andrew@lunn.ch, simon.horman@corigine.com, linux@rempel-privat.de
Subject: Re: [PATCH net-next v2 10/10] ethtool: netlink: always pass
 genl_info to .prepare_data
Message-ID: <ZNXjdj3edS1Up3Mt@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-11-kuba@kernel.org>
 <ZNXYZRNJkAqw686J@nanopsycho>
 <20230811071324.gfkzlpb3gbwvuufm@lion.mk-sys.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811071324.gfkzlpb3gbwvuufm@lion.mk-sys.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 09:13:24AM CEST, mkubecek@suse.cz wrote:
>On Fri, Aug 11, 2023 at 08:42:45AM +0200, Jiri Pirko wrote:
>> Fri, Aug 11, 2023 at 01:38:45AM CEST, kuba@kernel.org wrote:
>> >@@ -24,7 +24,7 @@ const struct nla_policy ethnl_wol_get_policy[] = {
>> > 
>> > static int wol_prepare_data(const struct ethnl_req_info *req_base,
>> > 			    struct ethnl_reply_data *reply_base,
>> >-			    struct genl_info *info)
>> >+			    const struct genl_info *info)
>> > {
>> > 	struct wol_reply_data *data = WOL_REPDATA(reply_base);
>> > 	struct net_device *dev = reply_base->dev;
>> >@@ -39,7 +39,8 @@ static int wol_prepare_data(const struct ethnl_req_info *req_base,
>> > 	dev->ethtool_ops->get_wol(dev, &data->wol);
>> > 	ethnl_ops_complete(dev);
>> > 	/* do not include password in notifications */
>> >-	data->show_sopass = info && (data->wol.supported & WAKE_MAGICSECURE);
>> >+	data->show_sopass = genl_info_is_ntf(info) &&
>> >+		(data->wol.supported & WAKE_MAGICSECURE);
>> 
>> I believe that you are missing "!" here:
>> 	data->show_sopass = !genl_info_is_ntf(info) &&
>> 		(data->wol.supported & WAKE_MAGICSECURE);
>
>Agreed.
>
>> But, you are changing the output for dumpit if I'm not mistaken.
>> ethnl_default_dump_one() currently calls this with info==NULL too, not
>> only ethnl_default_notify().
>
>I would rather see this as a fix. Not showing the password in dumps made
>little sense as it meant the dump output was different from single
>device queries. It was the price to pay for inability to distinguish
>between a dump and a notification.
>
>IIRC the early versions submitted went even further and did not set
>GENL_UNS_ADMIN_PERM for ETHTOOL_MSG_WOL_GET and only omitted the
>password when the request came from an unprivileged process (so that
>unprivileged processes could still query the rest of WoL information)
>but this was dropped during the review as an unnecessary complication.
>
>> Anyway, the genl_info_is_ntf() itself seems a bit odd to me. The only
>> user is here and I doubt there ever going to be any other. This
>> conditional per-op attr fill seems a bit odd.
>> 
>> Can't you handle this in side ethtool somehow? IDK :/
>
>I don't think so. The point here is that notification can be seen by any
>unprivileged process so as long as we agree that those should not see
>the wake up passwords, we must not include the password in them. While
>ethtool could certanly drop the password from its output, any other
>utility parsing the notifications (or even patched ethtool) could still
>show it to anyone.

Yeah, the question is, if it is a good design to have one CMD type
to conditionally send sensitive data. I would argue that sensitive data
could be sent over separate CMD with no notifier for it.



