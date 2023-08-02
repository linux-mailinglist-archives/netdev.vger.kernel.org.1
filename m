Return-Path: <netdev+bounces-23507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B276C3B4
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 05:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729681C211B2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 03:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF3710E2;
	Wed,  2 Aug 2023 03:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10261EA5
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 03:51:00 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561411BC1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1690948260; x=1722484260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYjlMC9UqypMREBQnOuArCCzahAxzN1Dw8navl74tro=;
  b=NZz9aIMaSu4FuRiQ2PalwK7xUOlqzzdLS5SsfViNwIBdo/2j6Vj/k8U9
   hYlIKrD00vGwdWziSlRf864UfWi/Ishxit4akCIVBSG2ebf14SSRRkgLn
   /9+OkRin0s8ykXQT5VEl2WVzNbfAhYhTtFqLaYNH2SDrZMVpOB4jndbQf
   M=;
X-IronPort-AV: E=Sophos;i="6.01,248,1684800000"; 
   d="scan'208";a="596406468"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 03:50:57 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 03C9840D4B;
	Wed,  2 Aug 2023 03:50:55 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 2 Aug 2023 03:50:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Wed, 2 Aug 2023 03:50:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <samuel.j.hasenbosch@boeing.com>
CC: <andrew@lunn.ch>, <hcoin@quietfountain.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <stephen@networkplumber.org>
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if bridge in non-default namespace.
Date: Tue, 1 Aug 2023 20:50:44 -0700
Message-ID: <20230802035044.53051-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <60bf35338d424beca3d9ba60deb1839c@boeing.com>
References: <60bf35338d424beca3d9ba60deb1839c@boeing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.171.32]
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "Hasenbosch, Samuel J" <Samuel.J.Hasenbosch@boeing.com>
Date: Wed, 2 Aug 2023 03:45:10 +0000
> Forwarding related issue:
> 
> https://lore.kernel.org/netdev/cf3001de-4ee2-45f2-83d3-3c878b85d628@free.fr/

It's the same issue and this series fixed it.
https://lore.kernel.org/netdev/20230718174152.57408-1-kuniyu@amazon.com/

