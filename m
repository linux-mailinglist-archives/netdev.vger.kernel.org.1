Return-Path: <netdev+bounces-21326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD16763473
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 13:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2C2281D97
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A89DCA6C;
	Wed, 26 Jul 2023 11:02:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF41CA4D
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:02:55 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2556110EC;
	Wed, 26 Jul 2023 04:02:51 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qOcI2-0002aO-AM; Wed, 26 Jul 2023 13:02:46 +0200
Message-ID: <cbc3f335-fc6a-f45a-4a08-f31bda1efd88@leemhuis.info>
Date: Wed, 26 Jul 2023 13:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Another regression in the af_alg series (s390x-specific)
Content-Language: en-US, de-DE
To: David Howells <dhowells@redhat.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info>
 <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
 <20079.1690368182@warthog.procyon.org.uk>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20079.1690368182@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690369371;464acef4;
X-HE-SMSGID: 1qOcI2-0002aO-AM
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26.07.23 12:43, David Howells wrote:
> "Linux regression tracking (Thorsten Leemhuis)" wrote:
> 
>> What's the status wrt to this regression (caused by c1abe6f570af from
>> David)? It looks like there never was a real reply and the regression
>> still is unresolved. But maybe I missed something, which can easily
>> happen in my position.
> 
> I was on holiday when the regression was posted.

Welcome back. And, no worries, I was just wondering what was up here.

>  This week I've been working
> through various things raised during the last couple of weeks whilst fighting
> an intermittent apparent bug on my desktop kernel somewhere in ext4, the mm
> subsys, md or dm-crypt.

Good luck with that!

> I'll get round to it, but I'll I don't have s390x h/w immediately to hand.

thx! Ciao, Thorsten

