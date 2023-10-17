Return-Path: <netdev+bounces-41717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE17CBC08
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B941C20A6E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8018050;
	Tue, 17 Oct 2023 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4jB56u3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843541864F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:08:58 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3F1107;
	Tue, 17 Oct 2023 00:08:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso36166925ad.3;
        Tue, 17 Oct 2023 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697526537; x=1698131337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzW3ddlIc/g6qI+zVds2r3DLCiTHQ00BzaCVpAuMb6I=;
        b=e4jB56u313GO8zL/skCN1rbJLqtaJSs9elokkbHQ24e2YYryqSF8CFT575hKpjwa0T
         pdw+REbXiGcvYIfAl937Rdunhbe8kn1jdtfosph+IzsOb9hQqfgJP1gbnu7OKVKXuXc4
         uy8sVv4xFVfvQNjWthV55A++2+0WrKNTuV18igqGHsb9K0xydX8odjDxxUeLFce4umOV
         G225a9aXGCnim/dASc4QWRaCTWUB0OHzgcgPOZ/yt/yUm8KqDfsibpsDG/tykD1hsv6j
         XShgsz5ripVOk9d7DGn9sU/jG3+tp+qwCmsPwgKq9TUaV8OSbVnDytZWa1JUEkETHm3A
         pzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697526537; x=1698131337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzW3ddlIc/g6qI+zVds2r3DLCiTHQ00BzaCVpAuMb6I=;
        b=bc6zsSgUuFRf1zny8npe/jIztusDh7dQ2ygRcFe2Hm5HgIqGCITiBvXyoBlQsnbhIO
         2We+uKRSkl4xlcCZApWPc/2ZRviMLaLxZVeS9I1n//ZpDQ3pAfG+xtq+UHfrMlMbHWv2
         c5cE2WfP/nz65vfh/o9lmfFpQy2nnMI6ZwiZ9IkteaaAIy4TH9SlICvCNmpaCUA4Y3/i
         HM369Nkqz6OEL84mknEJhqbiDX4O9da+B7I4SBzJJZZeWBbVQ6cpT/02tThxfBNllbWe
         kkNKvo8KuVBLMon09yvrvz8a8k8vp+xpcOJLtPP6KdsKF2GVL+Cga/F4LdH3NKxZYjEm
         paPA==
X-Gm-Message-State: AOJu0Yz5Gtk1IIIucmW/2qoauLBDKn68eX/13DNv1Y/1YdnDH836EImU
	LJfXWcbgeN97TC811XVsItY=
X-Google-Smtp-Source: AGHT+IFcZm2I+/ze3s7LVVDqOJSLHWpKutKCrCcG53oJu5+j2C1Yli/FVpo7Mkc/J58Z4ZLrjwq0PA==
X-Received: by 2002:a17:903:228e:b0:1ca:86a9:cace with SMTP id b14-20020a170903228e00b001ca86a9cacemr1578654plh.2.1697526536615;
        Tue, 17 Oct 2023 00:08:56 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902bd0c00b001b850c9d7b3sm738472pls.249.2023.10.17.00.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 00:08:56 -0700 (PDT)
Message-ID: <f8387cd2-032e-4231-9769-a8229b573614@gmail.com>
Date: Tue, 17 Oct 2023 14:08:51 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To: Loic Poulain <loic.poulain@linaro.org>
Cc: M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Linux Intel Wireless WAN <linuxwwan@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
 <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
 <ZSiJdxjokD0P9wRc@debian.me>
 <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/10/2023 20:18, Loic Poulain wrote:
> Hi Bagas,
> 
> On Fri, 13 Oct 2023 at 02:04, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On Thu, Oct 12, 2023 at 06:54:11PM +0200, Loic Poulain wrote:
>>> Hi Chetan,
>>>
>>> On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>>
>>>>> I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
>>>>>
>>>>> The journal listed this error message multiple times:
>>>>> kernel: iosm 0000:01:00.0: msg timeout
>>>>>
>>>>> It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
>>>>> Only a shutdown revived the modem.
>>>>>
>>>>> I did a bisection of the error and I was able to find the culprit:
>>>>>
>>>>> [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560
>>>
>>> Any quick fix for this issue? alternatively we will probably revert e4f5073d53.
>>
>> Chetan can't be contacted as sending to his address bounces (error 550)
>> (had he left Intel?). Last message on LKML is this culprit patch [1].
>> Hence, revert for now.
> 
> Could you please submit the revert fix?
> 

OK, will do.

-- 
An old man doll... just what I always wanted! - Clara


