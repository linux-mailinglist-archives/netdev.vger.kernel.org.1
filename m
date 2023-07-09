Return-Path: <netdev+bounces-16238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3374C0F1
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DC9281231
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 04:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2009E546;
	Sun,  9 Jul 2023 04:36:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1080E544
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 04:36:41 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF61B1;
	Sat,  8 Jul 2023 21:36:39 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qIM9x-0002mt-1c; Sun, 09 Jul 2023 06:36:33 +0200
Message-ID: <ac957af4-f265-3ba0-0373-3a71d134a57e@leemhuis.info>
Date: Sun, 9 Jul 2023 06:36:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
Content-Language: en-US, de-DE
To: Andrew Lunn <andrew@lunn.ch>, Ross Maynard <bids.7405@bigpond.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Bagas Sanjaya
 <bagasdotme@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux USB <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
 <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
 <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
 <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
 <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
 <14fd48c8-3955-c933-ab6f-329e54da090f@bigpond.com>
 <05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <05a229e8-b0b6-4d29-8561-70d02f6dc31b@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1688877399;eabebbaa;
X-HE-SMSGID: 1qIM9x-0002mt-1c
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08.07.23 22:49, Andrew Lunn wrote:
>> Could someone please submit the patch for me?
> 
> You are not far from it yourself.
> 
> I've not followed the history here. Did it never work, or has it
> worked in the past, and then at some point broke?
> 
> If it never worked, this would be classed as new development, and so
> the patch should be for net-next. If it did work, but at some point in
> time it stopped working, then it is for net.
> [...]

To chime in here: I most agree, but FWIW, it broke more than a decade
ago in v3.0, so maybe this is better suited for net-next. But of course
that up to the -net maintainers.

Ciao, Thorsten

