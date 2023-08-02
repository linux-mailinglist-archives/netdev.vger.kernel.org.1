Return-Path: <netdev+bounces-23787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B276D86E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 22:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC94B281DDA
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF04111AE;
	Wed,  2 Aug 2023 20:13:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38810793
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 20:12:59 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A7A2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:12:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id BF8DC3200645;
	Wed,  2 Aug 2023 16:12:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 02 Aug 2023 16:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1691007176; x=1691093576; bh=5T
	nAcmVt6xeZTYPKfAGH1vbQiUFJdbJWgnGsgJ7wcWg=; b=m94ebRBkDslDivdTuc
	DraTGDmCUHdhh+LZx2L4LRD60E8LXbD0ufwvRb8NTkQiJP/+v+Ipc3aXkrgIMM00
	iluk6N9Gnyv8zBuKagx8eOLAd68IF0S3YI/1IR40h5iTzSCmi5ZQbVUrj6OErLR+
	AInFdF/XwVkiUW3lqECSoaR+jFcERStN6SHNGdIa9QOk0BxEoNqT/w+yyX0ij5gt
	fsiSCE302jEkuExk4or8msx+uQWYrUKkJQGTnAdMZO8oWbWF1sCeICdQN7tA/91+
	TSf12gvZDYMgqRkF/DeXRlfRY+zS5jvUdr6kaFqioVEtyKdxihKvxEjX/k08UINZ
	suFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691007176; x=1691093576; bh=5TnAcmVt6xeZT
	YPKfAGH1vbQiUFJdbJWgnGsgJ7wcWg=; b=EOvhSW6lVruxF/+WTFK7cT55ZG9ig
	y3PvYAuBuXHA99Fn6/EKWWDjT4FMUEea+g9kH74SW5kMYvlhXOFBo9RIQ8wGybFN
	fYI4vhx81BuYSBRoHB1ykU0eho/QST+4wOcu2LiD9L6UP64gg2njUZ8H/DAWwvuD
	tk8wmaLaoORsRufBPWWdQxOTzSS8m4pPvzXgFrDF6umetTFTMdJ6CJKDrERhprLp
	0ErZP1UR+QDuvHHRKjYKbbt91EkWIQ8QKLI72s4r0FGPZj5qS/mKz0h/mGFEzqMM
	bM+eSyjxZQXs2q1wM0Qj1x3QRuVw55NKgyKD6V3epBLtglSDbyZIhMUeg==
X-ME-Sender: <xms:x7jKZFSppcMM_IN8RelZHqMAmuAavxcZb_Q-i62oIPLK96Pvq2Ikuw>
    <xme:x7jKZOysEF0lM1LxzXK4Plz4G62K2p1CIXmLR6vibv545SN93572uGJUDaD0tsGXu
    jU_-rm4gWrOZYLZM68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:x7jKZK0AZqTqhH9-zljUVb5jOr1ia2n8PXRbvQZq9BuwoUZVwY5ktQ>
    <xmx:x7jKZNAjaY6_483LAQUhf_EKfY_xMTnnbSAsFkF90YN8ZOrvWhgTbQ>
    <xmx:x7jKZOjj9LjEOtj8mqYSIsFjPOhMPuuQ_Cq7BPyfbwZQP0WQAcCrYA>
    <xmx:yLjKZHVu-u_FTa44NEfqiB5I_snD-uUtfLy24ip3Ng17tAnif3uadg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 10B43B60089; Wed,  2 Aug 2023 16:12:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <5404bdbd-8567-463a-8d79-87248c928485@app.fastmail.com>
In-Reply-To: <f19933ef-346c-e777-4b1e-f53291d90feb@linaro.org>
References: <20230801133121.416319-1-ruanjinjie@huawei.com>
 <ZMoUjMGxhUZ9v2pT@kernel.org>
 <f19933ef-346c-e777-4b1e-f53291d90feb@linaro.org>
Date: Wed, 02 Aug 2023 22:12:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alex Elder" <elder@linaro.org>, "Simon Horman" <horms@kernel.org>,
 "Ruan Jinjie" <ruanjinjie@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Wei Fang" <wei.fang@nxp.com>,
 "Rob Herring" <robh@kernel.org>, bhupesh.sharma@linaro.org,
 Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] cirrus: cs89x0: fix the return value handle and remove
 redundant dev_warn() for platform_get_irq()
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023, at 15:33, Alex Elder wrote:
> On 8/2/23 3:32 AM, Simon Horman wrote:
>> On Tue, Aug 01, 2023 at 09:31:21PM +0800, Ruan Jinjie wrote:
>>> There is no possible for platform_get_irq() to return 0
>>> and the return value of platform_get_irq() is more sensible
>>> to show the error reason.
>>>
>>> And there is no need to call the dev_warn() function directly to print
>>> a custom message when handling an error from platform_get_irq() function as
>>> it is going to display an appropriate error message in case of a failure.
>>>
>>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>
> First, I agree that the dev_warn() is unnecessary.
>
> On the "<" versus "<=" issue is something I've commented on before.
>
> It's true that 0 is not (or should not be) a valid IRQ number.  But
> at one time a several years back I couldn't convince myself that it
> 100% could not happen.  I no longer remember the details, and it
> might not have even been in this particular case (i.e., return
> from platform_get_irq()).
>
> I do see that a85a6c86c25be ("driver core: platform: Clarify that
> IRQ 0 is invalid)" got added in 2020, and it added a WARN_ON()
> in platform_get_irq_optional() before returning the IRQ number if
> it's zero.  So in this case, if it *did* happen to return 0,
> you'd at least get a warning.

Some of the older arm32 platforms used to start IRQ numbers at 0
instead of 1, but those should all have been converted by now,
and it's unlikely that the first interrupt would be the network
controller on any of those that did.

      Arnd

