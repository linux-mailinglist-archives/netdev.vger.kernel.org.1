Return-Path: <netdev+bounces-31080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958678B45C
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2083F1C2037E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9179134B2;
	Mon, 28 Aug 2023 15:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71946AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:24:24 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F70128;
	Mon, 28 Aug 2023 08:24:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E5CFB5C01AA;
	Mon, 28 Aug 2023 11:24:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 28 Aug 2023 11:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1693236262; x=1693322662; bh=IC2Ni55JbvbiY
	en3M7/lpKhphMlrMLm+MC6BBrUPUNE=; b=jXr+JQfVMpNFh2132kX4u7XuE9HtV
	bgtXdYFF9VsniPcvMiJb+1tDt1tgPy0CKySN7WkIYghi8sd0UHzLFeOR9IQ3C4sv
	HDedVV/xPPYa7yXe/DcgOveXax54gg50+yl0gKgCTWy/bUvdJTmpjFT6SKZFZdA1
	KgQK+zEwrx3g9g093vLMgrJdGCwJWZ5DhGRUqd1UmR7ubOgoPRzjW+6oPxbzQxY3
	1nyEMGvJSURWohZHzaTmuNXoOBTyQd6dsmYlR2R0GxSPfAv/sQVadFGW2pgK3KNX
	/pXpo4JW4OpXClChvtd019aLmqvwcyQKMWX5cmtHktulZjSI0NVlpDgqg==
X-ME-Sender: <xms:JrzsZMzJA34WJlZlrvOjFd3-FEM5Ixes2BXeWpCJHCLYJq9908JRZg>
    <xme:JrzsZARQ8EafUgCg3ohUHsk4p_aYCedHV_j8oFYcLB7LQxh1xlWkCGJ87zlNt9t27
    OGqYV7cvdr7xqs>
X-ME-Received: <xmr:JrzsZOUBRk_nbMewoaplV59g8YXGr0GI8eJ5mDKrCB-PHiGls15ZqK28VTrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:JrzsZKj4gUC32owiI2Ka-WqP0RxYrdS7TPCmMaDfEdeByQraPZqv3g>
    <xmx:JrzsZOCT4WMihSH1l-N-Y4vumrjq4wUvWbRR6oOFI5Fnr7UnTlSuBA>
    <xmx:JrzsZLLSTUWhQYHRckSR_0QnHWS_kTPJA05D1V9wrzfUsvTr2Z5IWw>
    <xmx:JrzsZC7eVLFR39OHnoJ5W_ZbAwu4sb830f0P1_m5gKTZD8peH8Z5RA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Aug 2023 11:24:22 -0400 (EDT)
Date: Mon, 28 Aug 2023 18:24:20 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>, kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v3 3/3] selftests: fib_tests: Add multipath list
 receive tests
Message-ID: <ZOy8JOjw9W4g8fYa@shredder>
References: <20230828113221.20123-1-sriram.yagnaraman@est.tech>
 <20230828113221.20123-4-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828113221.20123-4-sriram.yagnaraman@est.tech>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 01:32:21PM +0200, Sriram Yagnaraman wrote:
> The test uses perf stat to count the number of fib:fib_table_lookup
> tracepoint hits for IPv4 and the number of fib6:fib6_table_lookup for
> IPv6. The measured count is checked to be within 5% of the total number
> of packets sent via veth1.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

I just tested this with a debug config and noticed that the single path
test is not very stable. It's not really related to the bug fix, so I
think you can simply remove it.

Jakub / Paolo, this change conflicts with changes in net-next and I
assume that the next PR that you are going to send is from net-next.
What is your preference in this case? Wait for the PR to be accepted and
for master to be merged into net?

Thanks

