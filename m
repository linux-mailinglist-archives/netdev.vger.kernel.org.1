Return-Path: <netdev+bounces-42850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA07D06AD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5ED4B213B5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69655818;
	Fri, 20 Oct 2023 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2D80B;
	Fri, 20 Oct 2023 02:59:47 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id A3E7318C;
	Thu, 19 Oct 2023 19:59:44 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B8284604C5033;
	Fri, 20 Oct 2023 10:59:41 +0800 (CST)
Message-ID: <f9d9860c-0446-faea-2a69-0b2516ba7dcf@nfschina.com>
Date: Fri, 20 Oct 2023 10:59:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] net: lan78xx: add an error code check in
 lan78xx_write_raw_eeprom
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <aa78dff4-d572-4abc-9f86-3c01f887faf1@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/10/19 18:34, Dan Carpenter wrote:
> On Thu, Oct 19, 2023 at 04:40:23PM +0800, Su Hui wrote:
>> check the value of 'ret' after call 'lan78xx_read_reg'.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>
>> Clang complains that value stored to 'ret' is never read.
>> Maybe this place miss an error code check, I'm not sure
>> about this.
> There are a bunch more "ret = " assignments which aren't used in this
> function.
Yep, same problem  exists at lan78xx_read_raw_eeprom().
I try to send v2 patch to fix this.

Su Hui


