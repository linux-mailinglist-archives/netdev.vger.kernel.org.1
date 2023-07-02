Return-Path: <netdev+bounces-14997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A3B744E21
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D639C280CAC
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B51FB0;
	Sun,  2 Jul 2023 14:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EF17C9
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 14:39:25 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A996E5E;
	Sun,  2 Jul 2023 07:39:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so32806135e9.1;
        Sun, 02 Jul 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688308763; x=1690900763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmWE/+OVbbOkp5arD2QWZvot2DrqmmBuebMCluZRLlU=;
        b=lNRv7Y75jNaGFaUzZiem2M/SVeM3fbfAZ2EusS/EMwnVwHUh0Cv1PfUnIFhv4H8lE6
         lKwxA087yawS86B9xez2UO6UautuAP+licyJ6B0t7jfXDPHacrB39pAFwDn8QtnQ7Pop
         aQg5u+IdBtfy0ELpbytYq4xfZUy4qGRr0rUNxHBdQLUSgNrawDc9gOc6/yzKu0F8/kHc
         wgssOsenVfMe8LcpkB928c/QXt9LlOP2ovMBlqaEM7ZVbTrYp+IvBmvU1JBnvrxbyP4V
         wGTpuQlxehoeGq4n5GczTrRoghdODGH95Ti9V2H1cZxU/5MxO/Lh1aMhPyeNWo0/Sxqn
         xQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688308763; x=1690900763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmWE/+OVbbOkp5arD2QWZvot2DrqmmBuebMCluZRLlU=;
        b=a3/iD7s11XiDWXf8NhRKXh1T+5uhqDLK1+95inoTe5U9kWiOtiu2aCv/QenRG/R8rL
         wBbrAE9GvecnsYTJkXO5zaGnyHEupj0+cDe7PY1uBpgvhKDDXlBFhb080N+Aub/iKPp4
         4EB2UcTgffMU0JVhWKr6/GmK5aXCPQjyoz3l8YnNqwvAejTSYxO5ZrmCf7Ps9PgxG5MU
         rntWO9d1koH7256wFqC34pkN3/uDNtCW0+zkz9mo3+qc7pj/j9B2EldhczNBQvlubK4B
         D+2W7uIfxsNp7BTH2+kRsL3HVm7ohA5JezSrYPHlJcYc4hEbdEh1xmHQiFVHp6cQAesd
         2BtA==
X-Gm-Message-State: AC+VfDwhK8qoPBYYwV6ZPN0ZDbmy1x9i9P4R5CCP6+PHDppzIDHEcbHd
	WvI5QKymw5idwul1h4haxGo=
X-Google-Smtp-Source: ACHHUZ4ClLanINggBoqHyv9kmRS6FmZnFmrtoPpA/EEzisFafuUR0/0s6EswMr8jQJxyLAth0KYcOg==
X-Received: by 2002:a7b:ce0a:0:b0:3fb:b1fd:4172 with SMTP id m10-20020a7bce0a000000b003fbb1fd4172mr5612865wmc.22.1688308762593;
        Sun, 02 Jul 2023 07:39:22 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:86f5:6700:2cba:4a71:c713:649b? (2a01cb0586f567002cba4a71c713649b.ipv6.abo.wanadoo.fr. [2a01:cb05:86f5:6700:2cba:4a71:c713:649b])
        by smtp.gmail.com with ESMTPSA id c23-20020a05600c0ad700b003fbc9371193sm6305550wmr.13.2023.07.02.07.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 07:39:21 -0700 (PDT)
Message-ID: <f601d1c6-f131-b77e-0cb3-65b4afad8cff@gmail.com>
Date: Sun, 2 Jul 2023 16:39:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 2/2] net: dsa: sja1105: always enable the send_meta
 options
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20230629141453.1112919-1-vladimir.oltean@nxp.com>
 <20230629141453.1112919-3-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230629141453.1112919-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/29/2023 4:14 PM, Vladimir Oltean wrote:
> incl_srcpt has the limitation, mentioned in commit b4638af8885a ("net:
> dsa: sja1105: always enable the INCL_SRCPT option"), that frames with a
> MAC DA of 01:80:c2:xx:yy:zz will be received as 01:80:c2:00:00:zz unless
> PTP RX timestamping is enabled.
> 
> The incl_srcpt option was initially unconditionally enabled, then that
> changed with commit 42824463d38d ("net: dsa: sja1105: Limit use of
> incl_srcpt to bridge+vlan mode"), then again with b4638af8885a ("net:
> dsa: sja1105: always enable the INCL_SRCPT option"). Bottom line is that
> it now needs to be always enabled, otherwise the driver does not have a
> reliable source of information regarding source_port and switch_id for
> link-local traffic (tag_8021q VLANs may be imprecise since now they
> identify an entire bridging domain when ports are not standalone).
> 
> If we accept that PTP RX timestamping (and therefore, meta frame
> generation) is always enabled in hardware, then that limitation could be
> avoided and packets with any MAC DA can be properly received, because
> meta frames do contain the original bytes from the MAC DA of their
> associated link-local packet.
> 
> This change enables meta frame generation unconditionally, which also
> has the nice side effects of simplifying the switch control path
> (a switch reset is no longer required on hwtstamping settings change)
> and the tagger data path (it no longer needs to be informed whether to
> expect meta frames or not - it always does).
> 
> Fixes: 227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through standalone ports")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

