Return-Path: <netdev+bounces-30574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873457881F1
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85C41C20F50
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D917495;
	Fri, 25 Aug 2023 08:20:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476C20E7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 08:20:41 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958119AD;
	Fri, 25 Aug 2023 01:20:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 290651BF214;
	Fri, 25 Aug 2023 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692951635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7m/4pQD3gCo/V071m4nl/HimDm8tCat76xxXDvmJYA=;
	b=J7moYxo990zjrNGVbGz9dyMSVVZAZHwGenTXVI2UQoCJpa3uiE73RzLpHB+htrM2DcO/eD
	ymITedzE/IvdtnqZnCIB88gU1ktv2TVVMmLbV1NRwlbDrygCgYZmN2r4YlRAwuaFWWh83j
	efMo1zMtXy412NGR/LTuxscqVvYCL1zD+X3COXWk1xuX3LbezfrVqg6cPByzLFIUZoU0kl
	kDpg+T+63ySmPMsLYaDJpuEClSrZ3pnwwpNTadCTt4N+zx1v5ukVMyiivMr8H+kZ2X100w
	zLMwlDpfYo0YoCJimbDkHLEc9VUVWbQDcJ3/G3w3uXT05EuiQsSlRiMwAC9I8w==
Message-ID: <f8ff7611-d8e8-d229-2b72-95e6b3ca951d@bootlin.com>
Date: Fri, 25 Aug 2023 10:21:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: marvell: add
 MV88E6361 switch to compatibility list
Content-Language: en-US
To: airat.gl@gmail.com
Cc: andrew@lunn.ch, davem@davemloft.net, devicetree@vger.kernel.org,
 edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, olteanv@gmail.com,
 pabeni@redhat.com, paul.arola@telus.com, richardcochran@gmail.com,
 scott.roberts@telus.com, thomas.petazzoni@bootlin.com
References: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <add84df503df6b0bd3f572cd396dbde9da558eab.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On 8/24/23 20:49, airat.gl@gmail.com wrote:
> Is there an error? The new string include 6163 instead of 6361

I am afraid you are right, I made a dumb typo in the binding docs while
submitting 88E6361 support.
I have sent the corresponding fix to net, thanks for spotting this.

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


