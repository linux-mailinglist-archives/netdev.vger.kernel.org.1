Return-Path: <netdev+bounces-37690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7C7B6A79
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B8D891C20856
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB36727EDE;
	Tue,  3 Oct 2023 13:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3511273D4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:26:52 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBB6A9;
	Tue,  3 Oct 2023 06:26:49 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtKcuA3_1696339603;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0VtKcuA3_1696339603)
          by smtp.aliyun-inc.com;
          Tue, 03 Oct 2023 21:26:44 +0800
Date: Tue, 3 Oct 2023 21:26:43 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Albert Huang <huangjie.albert@bytedance.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
Message-ID: <20231003132643.GG92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
 <20230927034209.GE92403@linux.alibaba.com>
 <6e5fb3e148ae1fb4a29561fe9d04235d8be6ab1f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5fb3e148ae1fb4a29561fe9d04235d8be6ab1f.camel@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 12:41:25PM +0200, Paolo Abeni wrote:
>On Wed, 2023-09-27 at 11:42 +0800, Dust Li wrote:
>> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
>> > If the netdevice is within a container and communicates externally
>> > through network technologies like VXLAN, we won't be able to find
>> > routing information in the init_net namespace. To address this issue,
>> 
>> Thanks for your founding !
>> 
>> I think this is a more generic problem, but not just related to VXLAN ?
>> If we use SMC-R v2 and the netdevice is in a net namespace which is not
>> init_net, we should always fail, right ? If so, I'd prefer this to be a bugfix.
>
>Re-stating the above to be on the same page: the patch should be re-
>posted targeting the net tree, and including a suitable fixes tag.
>
>@Dust Li: please correct me if I misread you.

Right, this is exactly what I mean.

Best regards,
Dust

>
>Thanks,
>
>Paolo

