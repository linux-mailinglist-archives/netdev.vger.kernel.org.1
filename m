Return-Path: <netdev+bounces-22721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67235768F3B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988441C20B2E
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED316AAB;
	Mon, 31 Jul 2023 07:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942072569
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:54:40 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09F3130;
	Mon, 31 Jul 2023 00:54:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8BA8E5C0151;
	Mon, 31 Jul 2023 03:54:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 31 Jul 2023 03:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690790076; x=1690876476; bh=f9a19zDZjNcON
	kGSvwU/ccXQLcnN68H9kNz0ct684aA=; b=hLe35k/inq0uQdO95iOPCxw3eXbRG
	yULIl/EghzQVtjJrVpclC1BZhGosK5qI77Nh3bNro+9Q73oFfTdDOmXVMfY3PCbS
	58rzyRJxBVb4Y9RVOA7u6whWYali4+YZuN7HsZ/ZN214jp0dzVGVMvW9TSEPs6Qf
	9Vt+XOJHfNbYQAM9sVtLAqT6qazv9GkR5WP2FTvBc8XqJsG9P1G+N7BocHCiLqFV
	u28Rj/rbfxuwQ7jNoTzVZ4bUfizKywmYcxJvvhEBP1Bl/o4yxtVJjWdMtojKkxEh
	ePKWY7n0TRPD8sx83Xa02lXSDGU6vMqC7nO9Lz9UrvSJOTDtAnQOOyjgg==
X-ME-Sender: <xms:vGjHZCGtmIM4O7ccAG8GDpJRcYnCSE09Vryb_K2NOKqnHBYbAhq0jg>
    <xme:vGjHZDV577Mur8rI1ZHsgSSfitVAsoUykpSVdS_1pPlKJ_wLfdRIYO2LoYwE7QFgz
    FLbl2p8xpP3704>
X-ME-Received: <xmr:vGjHZMKRGG4MHnRr9C3KYDkwifqzHr57ZG2rjPLTqflKOkxGFZWq_G9hBShF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:vGjHZMHHJdNJI7qYwJVAQgAbm1N2WXZTOVQHgOf2I8G3em2r5oyDAQ>
    <xmx:vGjHZIU3vZhTzRMb-lvL6ADliqjK6v2SPgtkirmX2hX-F2gzlwGNZQ>
    <xmx:vGjHZPO99A2zvQ3RMSzRgn1EW2bRZtsC7fTvlFj9fIXMhKinuW4YHQ>
    <xmx:vGjHZMRasOge-MssfTKdF1M3FaG25fi6jJ0SrK5GXVeZTH5oygc16Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Jul 2023 03:54:35 -0400 (EDT)
Date: Mon, 31 Jul 2023 10:54:33 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: petrm@nvidia.com, razor@blackwall.org, Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1 01/11] selftests: forwarding:
 custom_multipath_hash.sh: add cleanup for SIGTERM sent by timeout
Message-ID: <ZMdouQRypZCGZhV0@shredder>
References: <20230722003609.380549-1-mirsad.todorovac@alu.unizg.hr>
 <ZLzj5oYrbHGvCMkq@shredder>
 <0550924e-dce9-f90d-df8a-db810fd2499f@alu.unizg.hr>
 <adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr>
 <ZL6OljQubhVtQjcD@shredder>
 <cab8ea8a-98f4-ef9b-4215-e2a93cccaab1@alu.unizg.hr>
 <ZMEQGIOQXv6so30x@shredder>
 <a9b6d9f5-14ae-a931-ab7b-d31b5e40f5df@alu.unizg.hr>
 <ZMYXABUN9OzfN5D3@shredder>
 <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da3f4f4e-47a7-25be-fa61-aebeba1d8d0c@alu.unizg.hr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks for testing.

On Sun, Jul 30, 2023 at 06:48:04PM +0200, Mirsad Todorovac wrote:
> not ok 26 selftests: net/forwarding: ip6_forward_instats_vrf.sh # exit=1

Regarding this one, in the log I don't see the require_command() that I
added in "selftests: forwarding: Set default IPv6 traceroute utility".
Also, at line 470 I see "ip vrf exec vveth0 2001:1:2::2" which is
another indication that you don't have the patch.

