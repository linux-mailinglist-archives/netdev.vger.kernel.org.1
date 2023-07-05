Return-Path: <netdev+bounces-15489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C647E747FD0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51454280FB3
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16D20E8;
	Wed,  5 Jul 2023 08:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6E17FE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:37:31 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E7133;
	Wed,  5 Jul 2023 01:37:27 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qGy0j-0007za-T3; Wed, 05 Jul 2023 10:37:17 +0200
Message-ID: <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
Date: Wed, 5 Jul 2023 10:37:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Linux-6.5 iwlwifi crash
To: Jeff Chua <jeff.chua.linux@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linux Wireless <linux-wireless@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688546247;14f75381;
X-HE-SMSGID: 1qGy0j-0007za-T3
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi! Thanks for your report.

Side note: is there any relation to the thread[1] you posted this in?
Doesn't look like it from here.

Side note: discussing multiple unrelated issues in one thread increases
the risk a lot that some or all of them are ignored:
https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

[1] https://lore.kernel.org/all/ZE0kndhsXNBIb1g7@debian.me/

On 05.07.23 09:24, Jeff Chua wrote:
> Latest linux-6.4

What do you mean by that? From later in the mail it sounds like you mean
latest mainline -- is that correct?

> after June 27 crash my whole linux notebook once
> iwlwifi is loaded. Anyone seeing this?

I haven't heard of any such problems, but that doesn't have to mean much.

> Bisect? Or there's a patch for this?
> 
> # modprobe iwlwifi
> ... Whole system frozen!
> 
> 
> Here's my system before the crash ...
> 
> # dmesg
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
> iwlwifi 0000:00:14.3: api flags index 2 larger than supported by driver
> thermal thermal_zone1: failed to read out thermal zone (-61)
> iwlwifi 0000:00:14.3: Sorry - debug buffer is only 4096K while you
> requested 65536K
> 
> # lspci
> 00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi
> WiFi (rev 01)
> 
> # linux git log
> commit d528014517f2b0531862c02865b9d4c908019dc4 (HEAD -> master,
> origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Jul 4 15:05:12 2023 -0700
> 
> # lsmodModule                  Size  Used by
> iwlmvm                397312  0
> mac80211              626688  1 iwlmvm
> iwlwifi               307200  1 iwlmvm
> cfg80211              413696  3 iwlmvm,iwlwifi,mac80211
> 
> 
> Bisect?

If none of the others CCed comes up with an idea within the next few
hours then yes please!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

