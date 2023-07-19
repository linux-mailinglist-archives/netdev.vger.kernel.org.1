Return-Path: <netdev+bounces-19003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91138759496
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB081C20E6D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130013ADB;
	Wed, 19 Jul 2023 11:49:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5D134A5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:49:50 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52C21705;
	Wed, 19 Jul 2023 04:49:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qM5gT-0002S1-7g; Wed, 19 Jul 2023 13:49:33 +0200
Message-ID: <444d8158-cc58-761d-a878-91e5d4d28b71@leemhuis.info>
Date: Wed, 19 Jul 2023 13:49:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Unexplainable packet drop starting at v6.4
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 hq.dev+kernel@msdfc.xyz
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Intel Ethernet Drivers <intel-wired-lan@lists.osuosl.org>
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689767386;d78491b8;
X-HE-SMSGID: 1qM5gT-0002S1-7g
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.07.23 02:51, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> After I updated to 6.4 through Archlinux kernel update, suddenly I noticed random packet losses on my routers like nodes. I have these networking relevant config on my nodes
>>
>> 1. Using archlinux
>> 2. Network config through systemd-networkd
>> 3. Using bird2 for BGP routing, but not relevant to this bug.
>> 4. Using nftables for traffic control, but seems not relevant to this bug. 
>> 5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level
>>
>> After I ruled out systemd-networkd, nftables related issues. I tracked down issues to kernel.
> [...]
> See Bugzilla for the full thread.
> 
> Thorsten: The reporter had a bad bisect (some bad commits were marked as good
> instead), hence SoB chain for culprit (unrelated) ipvu commit is in To:
> list. I also asked the reporter (also in To:) to provide dmesg and request
> rerunning bisection, but he doesn't currently have a reliable reproducer.
> Is it the best I can do?

When a bisection apparently went sideways it's best to not bother the
culprit's developers with it, they most likely will just be annoyed by
it (and then they might become annoyed by regression tracking, which we
need to avoid).

I'd have forwarded this to the network folks, but in a style along the
lines of "FYI, in case somebody has a idea or has heard about something
similar and thus can help; if not, no worries, reporter is repeating the
bisection".

> Anyway, I'm adding this regression to be tracked in regzbot:
> 
> #regzbot introduced: a3efabee5878b8 https://bugzilla.kernel.org/show_bug.cgi?id=217678
> #regzbot title: packet drop on Intel X710-T4L due to ipvu boot fix
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217678

Side note for the record: Stephen also forwarded this. And let me also
clear the commit you specified, as it sounds it's unlikely to be causing
this.

#regzbot introduced: v6.3..v6.4
#regzbot monitor:
https://lore.kernel.org/all/20230717115352.79aecc71@hermes.local/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

