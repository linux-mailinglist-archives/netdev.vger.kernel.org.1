Return-Path: <netdev+bounces-20837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3142761813
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 14:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566A1281786
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576841F16C;
	Tue, 25 Jul 2023 12:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB913AD9
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 12:16:02 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE810F9
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 05:16:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 4D3C45C00E8;
	Tue, 25 Jul 2023 08:16:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 25 Jul 2023 08:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690287360; x=1690373760; bh=mvA9i+KS8O4p2
	tc2N5nUjGjmv+LWaVsgHtUJiQAHBxU=; b=dW1wTosNDkk/dXk15iAR1B9zRNbIW
	t3ma+RCrkDuX5Dsu2JoCQkRNe+5L+rLnJ9S+QcCOE7T07fOuhN4tAsFjopop7vp3
	AbMSj+vk6vQSZqkZycQoJLhBJ96ynZgRXh8WEHCPZgCjk0HmgRwPotQU0olbJLjE
	QOML6iwMqqhyfEr/RQNcTAYIktagAkchnlNveudHErtPOvxFtei8qAmZiLAMaCac
	jbJzMTbQjoAl4cwDuFkxk5ge6AOa3B6znZJ/txkpOHV2sgw7O/6xuhFVPZ/0pdA3
	WIRxXX4V8TwUPisHR5TqnfroLCYWjV7CQJXQr+4+Zyo90Lx0LtrVKpp4Q==
X-ME-Sender: <xms:AL2_ZOWMa4D0adRxzbNytCjOgN53herdex-XjibevAsLzmpq1wrsOw>
    <xme:AL2_ZKnXcg-XvcLtPxzwnpWg4Im29Ah_lhWm7S4HkgOUoRfJOPg6wdhBJWW9DeqFx
    uAgz-ITws-iDJs>
X-ME-Received: <xmr:AL2_ZCYB1Bby9WGiLqX1WKtndrYXoRgJsmPVZb46wXcIRAgxstIL_1rkUuvSYp1Pnw2mzSDgrHY38dxCmODV-bkOl_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:AL2_ZFUNOHldvAGjmjDt6Q4_qqo8aHmphU2b9n6uKsBnGl9ra9h1pg>
    <xmx:AL2_ZInPdzWQsBfKdK9pJF5acvXCLtljo2Im2QeJ1YehZnQtM-OXYA>
    <xmx:AL2_ZKcPqwneCcu7F74RQPMXj0vUbFlWNe57xNeoB7JOgGdka4pNZw>
    <xmx:AL2_ZHsOvzrfS2MD5KrrnVYKJp-hG2lQjDwkcrJk1WcYxs0o-2e6xw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 08:15:59 -0400 (EDT)
Date: Tue, 25 Jul 2023 15:15:56 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [PATCHv3 net-next] IPv6: add extack info for IPv6 address
 add/delete
Message-ID: <ZL+8/E2uFOuwFdXM@shredder>
References: <20230724075051.20081-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724075051.20081-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 03:50:51PM +0800, Hangbin Liu wrote:
> Add extack info for IPv6 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

