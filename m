Return-Path: <netdev+bounces-32500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204479809C
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 04:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0823281832
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C3636;
	Fri,  8 Sep 2023 02:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94B627
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 02:33:34 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98381BD7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 19:33:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a7e68f4214so1156016b6e.1
        for <netdev@vger.kernel.org>; Thu, 07 Sep 2023 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694140413; x=1694745213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foT0RKKXa/0xI1IV2zThdA/M5ZTrklmVwaPtHksuwyU=;
        b=SJhj8x+sYBZhraubYQgnSAMMNVlqmAYA7xXZoAtnZWxbjD7WB+C+KfTNafm1HDoFuT
         h+fwKxzfbwOtaHJV4pjY5xpZMto/GocCnoFUa0VEhQz2eLCmVyLV3ppzE/B2JMxYng4A
         Qh80J4gT+F7jVS3LclL40aUci6zYxMPQ1jZm0cb8becoW4oYRITh+aC0S9ejJPPoyT/F
         Z4puoDFrQHQXsV1AY7AQmus3Ysfy8H3Qag/5Jd0ktB49rzmm659yIovL9HZFci9TFZpt
         aOO/euID3t01+XEOO0bujtEaJIqESzXXUZWeoJnNX2p+SeSpYgk3tiK17xXWzo3ky1gk
         Ru6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694140413; x=1694745213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=foT0RKKXa/0xI1IV2zThdA/M5ZTrklmVwaPtHksuwyU=;
        b=WczAtuZrlTP3wTjMeL1TdyR5p/d4COUcM1Is1nym3V49S8BBUdi4E7c4yyCDq6pslg
         o2ZWiUxXlfz+UQXiKWRC2VdH/r3HBIdV6zjfy7XwW9SoGTiDHx7JsCgLvVQfs6jDBDmT
         wpvbr0gS/QYOaDA0y87kVVEVXXYYA3tAVJPPI3UyaAlz2PzLNq1WkeUqiG5pVQxLphG0
         6wCslEX/tHjuYLuTk3wvEx6EmktOMuQjtMSoHiv/pwTmN5FQNCCiJQ/1aAcV5mcdwCn9
         hMtmbRd17Lz1tXHzqyrS+wbOTkY/B4nRlH2hxQK577CjYY2EgvTKfqU8XRqu4BSMx0aQ
         bO7A==
X-Gm-Message-State: AOJu0Yy9SlYz7TmGwpXD7vajW6/AMq49PogAomrGVZhZG9wHQ3ZvKCok
	wFNqfbpqR3jOcc8H7FgS0QnnacsbcVPtNg==
X-Google-Smtp-Source: AGHT+IFmCmfVgAeERBag9yT0XfCMj0JzHRY4x2qWFf+PsHmEeKU5Hqu9qAkYjSSTbSDDbRxoHDOziw==
X-Received: by 2002:a05:6808:490:b0:3a8:4f87:f92c with SMTP id z16-20020a056808049000b003a84f87f92cmr1358622oid.44.1694140412953;
        Thu, 07 Sep 2023 19:33:32 -0700 (PDT)
Received: from [192.168.123.100] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id a5-20020a655c85000000b0055b61cd99a1sm203132pgt.81.2023.09.07.19.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 19:33:32 -0700 (PDT)
Message-ID: <79c0acf1-8ede-4e4c-c032-9365dbdb902e@gmail.com>
Date: Fri, 8 Sep 2023 11:33:29 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net] net: team: do not use dynamic lockdep key
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 jiri@resnulli.us, netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
References: <20230905084610.3659354-1-ap420073@gmail.com>
 <20230907103124.6adb7256@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20230907103124.6adb7256@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023. 9. 8. 오전 2:31, Jakub Kicinski wrote:

Hi Jakub,
Thank you so much for taking care of this.

 > On Tue,  5 Sep 2023 08:46:10 +0000 Taehee Yoo wrote:
 >> @@ -1203,18 +1203,31 @@ static int team_port_add(struct team *team, 
struct net_device *port_dev,
 >>
 >>   	memcpy(port->orig.dev_addr, port_dev->dev_addr, port_dev->addr_len);
 >>
 >> -	err = team_port_enter(team, port);
 >> +	err = dev_open(port_dev, extack);
 >>   	if (err) {
 >> -		netdev_err(dev, "Device %s failed to enter team mode\n",
 >> +		netdev_dbg(dev, "Device %s opening failed\n",
 >>   			   portname);
 >> -		goto err_port_enter;
 >> +		goto err_dev_open;
 >>   	}
 >>
 >> -	err = dev_open(port_dev, extack);
 >> +	err = team_upper_dev_link(team, port, extack);
 >
 > I'm guessing the syzbot complaint:
 >
 > https://lore.kernel.org/all/000000000000e44e4a0604c66b67@google.com/
 >
 > is related to this reordering of team_upper_dev_link() before things
 > are initialized. I'll revert this version in net, let's target v2 at
 > net-next, next week? "lockdep runs out of keys" isn't a real bug,
 > or at least I don't think the benefit is high enough for pushing
 > functional code changes into current release. Sounds reasonable?
 >

I agree with you.

I think the syzbot reported bug is a side effect of reordering of 
initialization path, especially the reordering of disable_lro() and 
team_upper_dev_link().
This is a more critical issue than the lockdep false-positive bug.

I will send the v2 patch after more tests.
Thanks a lot!
Taehee Yoo



 >>   	if (err) {
 >> -		netdev_dbg(dev, "Device %s opening failed\n",
 >> +		netdev_err(dev, "Device %s failed to set upper link\n",
 >>   			   portname);
 >> -		goto err_dev_open;
 >> +		goto err_set_upper_link;
 >> +	}
 >> +
 >> +	/* lockdep subclass variable(dev->nested_level) was updated by
 >> +	 * team_upper_dev_link().
 >> +	 */
 >> +	team_unlock(team);
 >> +	team_lock(team);
 >> +
 >> +	err = team_port_enter(team, port);
 >> +	if (err) {
 >> +		netdev_err(dev, "Device %s failed to enter team mode\n",
 >> +			   portname);
 >> +		goto err_port_enter;
 >>   	}
 >>
 >>   	err = vlan_vids_add_by_dev(port_dev, dev);
 >> @@ -1242,13 +1255,6 @@ static int team_port_add(struct team *team, 
struct net_device *port_dev,
 >>   		goto err_handler_register;
 >>   	}
 >>
 >> -	err = team_upper_dev_link(team, port, extack);
 >> -	if (err) {
 >> -		netdev_err(dev, "Device %s failed to set upper link\n",
 >> -			   portname);
 >> -		goto err_set_upper_link;
 >> -	}

