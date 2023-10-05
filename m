Return-Path: <netdev+bounces-38250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5827B9D91
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 67683281D3E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B32D266AB;
	Thu,  5 Oct 2023 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F412629F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:49:39 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EBB199F;
	Thu,  5 Oct 2023 06:49:35 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 15AF0102396;
	Thu,  5 Oct 2023 15:32:09 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 0FFD1102395;
	Thu,  5 Oct 2023 15:31:24 +0300 (MSK)
Received: from [176.16.7.18] (gang [176.16.7.18])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 395CVNlh030864;
	Thu, 5 Oct 2023 15:31:23 +0300
Message-ID: <fb9f1d68-77a4-0620-10fc-982b83660de8@mcst.ru>
Date: Thu, 5 Oct 2023 15:31:23 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [lvc-project] [PATCH] wifi: mac80211: fix buffer overflow in
 ieee80211_rx_get_bigtk()
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
References: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
 <3ba8e3902ade7483a82bd305a35a236744ffba25.camel@sipsolutions.net>
From: "Igor A. Artemiev" <Igor.A.Artemiev@mcst.ru>
In-Reply-To: <3ba8e3902ade7483a82bd305a35a236744ffba25.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20231005 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 10/4/23 17:58, Johannes Berg wrote:
> And ... how exactly do you propose that is going to happen?

'conf.keyidx', the value that is passed to the function, can be 0. But I 
missed checking the second argument of the ieee80211_rx_get_bigtk() 
function before calling it. Sorry to bother you.

Thanks,
Igor


