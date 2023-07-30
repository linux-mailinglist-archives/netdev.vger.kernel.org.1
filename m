Return-Path: <netdev+bounces-22640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9476865D
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 18:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE371C20AA4
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 16:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686C6DF6E;
	Sun, 30 Jul 2023 16:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0420EE
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 16:16:38 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560810D7
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 09:16:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qQ95t-0001iD-IZ; Sun, 30 Jul 2023 18:16:33 +0200
Message-ID: <3ef4662e-7888-9f41-32a3-d4cd07f1572c@leemhuis.info>
Date: Sun, 30 Jul 2023 18:16:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: supported_interfaces filling enforcement
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: netdev@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <ac2efb70-aa19-41d3-ac57-8aaaf39c620b@leemhuis.info>
In-Reply-To: <ac2efb70-aa19-41d3-ac57-8aaaf39c620b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690733795;7e21cda9;
X-HE-SMSGID: 1qQ95t-0001iD-IZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08.07.23 16:01, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 04.07.23 16:28, Sergei Antonov wrote:
>> Hello!
>> This commit seems to break the mv88e6060 dsa driver:
>> de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
>> supported_interfaces to be filled"
>>
>> The driver does not fill 'supported_interfaces'. What is the proper
>> way to fix it? I managed to fix it by the following quick code.
>> Comments? Recommendations?

#regzbot monitor:
https://lore.kernel.org/all/E1qOflM-001AEz-D3@rmk-PC.armlinux.org.uk/
#regzbot fix: 9945c1fb03a3
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



