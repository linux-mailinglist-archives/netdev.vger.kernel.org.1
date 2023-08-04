Return-Path: <netdev+bounces-24393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50B770087
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BE71C20A58
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737B8BA5D;
	Fri,  4 Aug 2023 12:50:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A85A929
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:50:08 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2565C49F9
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:49:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 928945C012E;
	Fri,  4 Aug 2023 08:49:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 04 Aug 2023 08:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691153365; x=1691239765; bh=ZkTw5kO1c2ZG3
	7EkceTgB9peVFdVCQxiEDEIZ4UVvnk=; b=hgVY4Yltdjy0F/s22o8xzzye98Eei
	Pswg1ehVdc+dKepaPrOFBJ9liulpQ4Fog1Bvj5OQxibtyl8yL8qsDIdhjxuqSh7j
	u/8KX02vBnBIFYg4KrALAu/sCvP4oYAH0dcqPtJbSvW/muQ4fgLWTzcQMqZbsBxV
	eTRA55FjOEPNNx6S0zQdiSDUkgAa+7PIzElHZTyOZ0GL7mtSEsB1IC/5+aZ4OjfA
	REMzabs/dYMfcEP37UgbYKopTBqS7ZEOsVHkdrLE8pbWCL+mYsmQm0ETJltSNLZl
	6+62jPRDzWFdPikwlsAD95QzIHC7HSyX1v87V4WEXRfTz80FApz19mZLQ==
X-ME-Sender: <xms:1fPMZBRyAs0kHTEF0HC_TXRgimSjgPD3eKTXnclVA58b5u5My-Almw>
    <xme:1fPMZKym7kayBAT4wMHxxqJ_IWj59JcC_mQY229SuTGoB6Rmb-qXFUl2yE9ZcLctO
    ov5ofB4814wnxE>
X-ME-Received: <xmr:1fPMZG3XS2Py6nCjfRE8asGjceun5jN0kqOPraj7qoWGaQ_DVBIhDEB8JZ38e_J_XS-e68BDGOsl0hjsb9vzr1o-0gUGnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:1fPMZJATNs40C-77E1h9cS4fOFm1n4ALCKpeLJukeyVi9JR8wz6vCw>
    <xmx:1fPMZKh4nYf1UmPUW3PAZRXgg7AmpCPC1Nc0DnXh08EJ4_grJDGAtw>
    <xmx:1fPMZNrrOaRs9CqZT1ts2He26a-07uqH6DElzZ9w0XfCtb5c8VrTXw>
    <xmx:1fPMZMYvVikvP_TDn1hyCMC_taxqNZy1uLZEqOE9BS52jdWVs9JD7Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 08:49:24 -0400 (EDT)
Date: Fri, 4 Aug 2023 15:49:21 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum: Remove unused function
 declarations
Message-ID: <ZMzz0fkoFt/QbJ+D@shredder>
References: <20230803142047.42660-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803142047.42660-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 10:20:47PM +0800, Yue Haibing wrote:
> Commit c3d2ed93b14d ("mlxsw: Remove old parsing depth infrastructure")
> left behind mlxsw_sp_nve_inc_parsing_depth_get()/mlxsw_sp_nve_inc_parsing_depth_put().
> And commit 532b49e41e64 ("mlxsw: spectrum_span: Derive SBIB from maximum port speed & MTU")
> remove mlxsw_sp_span_port_mtu_update()/mlxsw_sp_span_speed_update_work() but leave the
> declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

