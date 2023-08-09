Return-Path: <netdev+bounces-25682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17FD77525D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 07:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D612B1C21108
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D54E4430;
	Wed,  9 Aug 2023 05:47:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BF81B
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:47:49 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C381BF0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:47:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 025025C00A8;
	Wed,  9 Aug 2023 01:47:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 09 Aug 2023 01:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691560068; x=1691646468; bh=yLvlcFCleSMkH
	jdDx+BJE+52uyRxuKQqUkkFUbCUpSM=; b=OGeTH9WVSoTriihSRTPgx+ybwkAXy
	THDTz3+ZCnEtO+MuwwO9lKG4CpSHGqZA2tyGAALRadsBjPQrmO+mewRT5goQ4tKs
	sDz/c9tsXDs30Q+uQXGQUf/6eKO4NrJIYsZOT/s4ybXW9OJsRm6FEhjd3Cxt7yHX
	pPFPUYYBXGiHtc19tO1+uO9ozoYAtTemIK453ivKXgY4eBzGX4RDkItkSVygUn2X
	a7XQN8uDixSGP8tM5iy9oDChcZVIYNDVwRK9d35kIYq+QhAi5gYYiNYqj4pCM2pt
	Et3KxDsZsUEtk3ASdakgjercUiimViGZF4nvrGtA9CvSzCp06bx9rh4aA==
X-ME-Sender: <xms:gyjTZF20fOgxcMsXBSDX8Oon86BKoHlJZCptmP9geLruILx193YSZQ>
    <xme:gyjTZMF11jo7HljvRxzJZzGdDn57c-c5jqqlQ4zuhBFveZjK1QoTAu4ith5sdjFki
    agtyNOzvn-YxuM>
X-ME-Received: <xmr:gyjTZF7hZ57kX9bLrH0FCP1bNv2lhfEp5N1vY7MaN5dRxC2Ws_Wx8lcv_E0ZSLPkouIfe75bJ19fE6gKKF2co8_DoT6T8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleefgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:gyjTZC3VQFKfGYFWHs86Rh0ZxNHAFI-KISjM4c3kvenGWQ1CmGnm0Q>
    <xmx:gyjTZIH24AwJ6-ie_gUSzjyV9VoRWCoQ0YwcHkaTuVqiKFRrRaL1SA>
    <xmx:gyjTZD93EzfQtXgqIh-9nzD593-5oXcDGEdaEoRiA1Zmlqf08E1qIw>
    <xmx:hCjTZD3yPEtIBqwSQCVBK6bj05LKkf5Mql81TpFommbKzkJIieaxcg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Aug 2023 01:47:47 -0400 (EDT)
Date: Wed, 9 Aug 2023 08:47:45 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, petrm@nvidia.com, razor@blackwall.org,
	mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 06/17] selftests: forwarding: Add a helper to skip
 test when using veth pairs
Message-ID: <ZNMogU0whoFeerho@shredder>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-7-idosch@nvidia.com>
 <ZNLyDT5X2GYQfqQR@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNLyDT5X2GYQfqQR@Laptop-X1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:55:25AM +0800, Hangbin Liu wrote:
> On Tue, Aug 08, 2023 at 05:14:52PM +0300, Ido Schimmel wrote:
> > A handful of tests require physical loopbacks to be used instead of veth
> > pairs. Add a helper that these tests will invoke in order to be skipped
> > when executed with veth pairs.
> 
> Hi Ido,
> 
> How to create physical loopbacks?

It's the same concept as veth. Take two physical ports and connect them
with a cable.

