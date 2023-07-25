Return-Path: <netdev+bounces-20814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0117611FD
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C9D2817F2
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9549B15AC5;
	Tue, 25 Jul 2023 10:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882331D301
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:58:36 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21654681
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:58:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qOFkN-00045L-Mr; Tue, 25 Jul 2023 12:58:31 +0200
Message-ID: <9e584314-cb54-1dd4-1686-572973777580@leemhuis.info>
Date: Tue, 25 Jul 2023 12:58:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Regression: supported_interfaces filling enforcement
Content-Language: en-US, de-DE
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Sergei Antonov <saproj@gmail.com>, netdev@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
 <ZLATb/obklRDT3KW@shell.armlinux.org.uk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <ZLATb/obklRDT3KW@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690282713;bcb04fc0;
X-HE-SMSGID: 1qOFkN-00045L-Mr
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 13.07.23 17:08, Russell King (Oracle) wrote:
> On Mon, Jul 10, 2023 at 03:35:56PM +0300, Vladimir Oltean wrote:
>> On Tue, Jul 04, 2023 at 05:28:47PM +0300, Sergei Antonov wrote:
>>> This commit seems to break the mv88e6060 dsa driver:
>>> de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
>>> supported_interfaces to be filled"
>>>
>>> The driver does not fill 'supported_interfaces'. What is the proper
>>> way to fix it? I managed to fix it by the following quick code.
>>> Comments? Recommendations?
>>
>> Ok, it seems that commit de5c9bf40c45 ("net: phylink: require
>> supported_interfaces to be filled") was based on a miscalculation.
> 
> Yes, it seems so. I'm not great with dealing with legacy stuff - which
> is something I've stated time and time again when drivers fall behind
> with phylink development. There's only so much that I can hold in my
> head, and I can't runtime test the legacy stuff.
> 
> I suspect two other DSA drivers are also broken by this:
> 
> drivers/net/dsa/dsa_loop.c
> drivers/net/dsa/realtek/rtl8366rb.c
> 
> based upon:
> 
> $ grep -lr dsa_switch_ops drivers/net/dsa | xargs grep -L '\.phylink_get_caps.*=' | xargs grep -L '\.adjust_link'

What happened to this regression? From here it looks like things
stalled, but I might have missed something, hence allow me to ask:

Is this still happening? Is anyone still working on fixing this?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

