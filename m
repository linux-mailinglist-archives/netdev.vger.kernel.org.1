Return-Path: <netdev+bounces-16562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B40AF74DD45
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46871C20B53
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960714A87;
	Mon, 10 Jul 2023 18:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7A14290
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 18:23:08 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFE180
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689013386; x=1720549386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1xzDrBpolB/cKF57T6jq2gKg8ggrF6TzxDCqID6R20=;
  b=cLoFT8WxTkNFc58G3nT7XtaAR+a3qAKgbi7FN2xGuj9ozITsCctDhpSH
   J/EAKlnKwHb+bKzpof/s72n8gN1BU8KVG3bCBccDihv1xRw2yK4f0pMqp
   pRSg6V0pl9k//BOVlBr0gF8u7jkGg4hAJvOa/WzZRnoDyBpsdUtKu4qNJ
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="15456624"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:23:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 1B5BE60A26;
	Mon, 10 Jul 2023 18:23:04 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 18:23:03 +0000
Received: from 88665a182662.ant.amazon.com (10.119.65.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 10 Jul 2023 18:23:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Gregorio Maglione <Gregorio.Maglione@city.ac.uk>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: DCCP Deprecation
Date: Mon, 10 Jul 2023 11:22:53 -0700
Message-ID: <20230710182253.81446-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
References: <CWLP265MB6449FC7D80FB6DDEE9D76DA9C930A@CWLP265MB6449.GBRP265.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.65.132]
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

CC maintainers

From: "Maglione, Gregorio" <Gregorio.Maglione@city.ac.uk>
Date: Mon, 10 Jul 2023 12:06:11 +0000
> Hi Kuniyuki,
> 
> I saw the deprecation notice on the DCCP. We are working with a multipath
> extension of the protocol, and this would likely impact us in the
> standardisation effort. Do you know whom I must contact to know how I can
> volunteer to maintain the protocol, and  to get more information about
> the maintenance process?

I think it would be better to review others' patches or post patches before
stepping up as a maintainer.

However, this repo seems to have a license issue that cannot be upstreamed
as is.
https://github.com/telekom/mp-dccp


> 
> Kind Regards,
> Greg

