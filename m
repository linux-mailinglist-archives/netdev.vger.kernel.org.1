Return-Path: <netdev+bounces-13711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF3F73CB3A
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51D5281350
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BCC53AD;
	Sat, 24 Jun 2023 14:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FED53AB
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 14:00:35 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8339011F;
	Sat, 24 Jun 2023 07:00:34 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qD3oU-0002F4-Q1; Sat, 24 Jun 2023 16:00:30 +0200
Message-ID: <08ea34c8-7194-eafb-98f4-1e0b52ca7e81@leemhuis.info>
Date: Sat, 24 Jun 2023 16:00:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: After kernel 6.3.7 or 6.3.8 b43 driver fails
Content-Language: en-US, de-DE
To: Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Michael_B=c3=bcsch?=
 <m@bues.ch>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Wireless <linux-wireless@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 Simon Horman <simon.horman@corigine.com>,
 Larry Finger <Larry.Finger@lwfinger.net>, Kalle Valo <kvalo@kernel.org>,
 sardonimous@hotmail.com
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <20230624105023.146d99e0@barney>
 <d33a248c-c7ac-43d3-b602-3c801d697922@app.fastmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <d33a248c-c7ac-43d3-b602-3c801d697922@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687615234;ca01182a;
X-HE-SMSGID: 1qD3oU-0002F4-Q1
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24.06.23 11:29, Arnd Bergmann wrote:
> On Sat, Jun 24, 2023, at 10:50, Michael Büsch wrote:
>> On Sat, 24 Jun 2023 08:44:15 +0700
>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>> I suspect change introduced when addressing a compiler warning
>>>> cased the error.
>>>>
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20230516183442.536589-1-arnd%40kernel.org/
>>
>> I doubt it.
>> This patch affects the device initialization code. But the crash is in
>> the transmit path.
>> Can you please double check by manually reverting the patch?
> 
> I'm travelling at the moment and can't easily check it, but I would
> expect that my patch has no effect on the generated object code [...]

Michael, Arnd, thx for the replies. To you and everyone else that looked
into this: sorry for the trouble this caused.

The reporter's guess was wrong, as the reporter meanwhile confirmed in
the bugzilla ticket that the problem started to happen earlier.

Bagas, please be a bit more careful and don't blame a specific commit
unless it's was found by bisection, a revert through a lucky guess, a
statement from a developer, or something like that. In cases like this
it would have been better to sent the developers of said commit a quick
mail along the lines of "could you imagine that this change could lead
to the problem the reporter described". But even that might be too much
in a case like this, as too many of such false alarms and inquiries will
make developers start hating or ignoring regression tracking in general
or mails from you or me – and that is something that must be avoided, as
without help from developers regression tracking becomes a lot harder or
impossible.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: Updating regzbot status, while at it:

#regzbot introduced: v6.1..v6.2






