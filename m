Return-Path: <netdev+bounces-62989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBF682A98A
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F49B1C22295
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26ACEAFA;
	Thu, 11 Jan 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xU3tZdNi"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB01EADD
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 09B055C00A5;
	Thu, 11 Jan 2024 03:51:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 11 Jan 2024 03:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704963099; x=1705049499; bh=fcGbkQfDGCmxUjDYrTIuTDpZFxWQ
	QHWXQSis0y1FoH4=; b=xU3tZdNiH1fet/cl6mjixUqc8KcmFtIujeVBBx6jper3
	l/nQddpUoYHsloNA1bB0N44AMXIhg4a6RBO+GbZNrJd0vwbJ8JPJ5VGuKJCGIIJS
	tKVh30tKGcZitXP4IryFPIw+eVjVw5o1A4SOpD022CuBI1vNWw8zL69KqZHGd379
	elUNkkF7ON0eX1eTQPKWzWgB/a9QbRcoP2xIKLGaLjF6FZ1k7eyGI2NS0i4a1AAS
	ahQ6Izx/eU8cHzAwnHkPMXL0ixSmQpT9L42+Kp8lqcr5EGO/1DnOOFz8JDBXhVM9
	fb8moRMNFSqkMG9JkObEBIrDoWskTWI65iNWy0VZxQ==
X-ME-Sender: <xms:GqyfZbpwYTJVrlMbpYc2tOYK-MM4La7U8qcPlMKVTjE1_cZzaLQo0w>
    <xme:GqyfZVo3Mn4_l5AJmhFLnPTTXUOwBrk8pDg0Asac0P19nJteUlpHxIGeAfF-tXPxd
    x4MN9CL03sCmEk>
X-ME-Received: <xmr:GqyfZYPFdOOvZBF2WwUeIFadjUExOE_OXQVcg4jyN05gEAdxKsJUbkvl1_L5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeej
    geeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:GqyfZe4207WYjYHgR2eQmDDDJlVh-sfL4pS_-xHvcIQWkw-NljuxMQ>
    <xmx:GqyfZa7783FCzGfC-P0B9tRv0MjXLtkuVicPbJCkkGmPWJybtlv85g>
    <xmx:GqyfZWgZTyKJm-shZT27raKy843dAS5Fl-Hqi-206OX5GbNfMVq-ug>
    <xmx:G6yfZXzVKLK7pt0putDsqgxg1pPTcfvoX9WXbLgzrBkLo1Y2u-G4VQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 03:51:37 -0500 (EST)
Date: Thu, 11 Jan 2024 10:51:35 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZ-sF8zVqzqwOAy_@shredder>
References: <20240104125844.1522062-1-jiri@resnulli.us>
 <ZZ6JE0odnu1lLPtu@shredder>
 <ZZ7DLvAwXcQit3Ar@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ7DLvAwXcQit3Ar@nanopsycho>

On Wed, Jan 10, 2024 at 05:17:50PM +0100, Jiri Pirko wrote:
> Feel free to text following patch. Since I believe it is not possible
> to send fixes to net-next now, I will send it once net-next merges
> into net.

Looks good, thanks. I will run it through regression to make sure no
other issues pop up.

