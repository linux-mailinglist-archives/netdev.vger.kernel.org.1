Return-Path: <netdev+bounces-17039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7174FDFC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11A32817CD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058951FA6;
	Wed, 12 Jul 2023 03:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CDA34
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:46:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE86F10CF;
	Tue, 11 Jul 2023 20:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1fP2aadW9sQB3PeC+sTa6nL9JleVOZKEZwbcczLmOHo=; b=FAILc6bww/IP5YqEdaQPEbP0xK
	52oilyszynVVY53LaH1POpUtrJPhQ4H0lLdwkwEt4/sGVVDUMFGu8BIpdDsv/n+v9i91HApZrHwaM
	h/O1tsXXm+KpOG9uYtnRULzaPzs0Q0hqDs6E3o9SYvtKRUG75y9f1hYk42Hfpvwa5wiQFNb+x2ZaW
	CvyIHBt2bgl7/ik0/k0HVH6MbT5tjRas9Pql6SWG4PfdASJE0fXwKo/1U3N+ZLTb6CSIaNi2A8Evj
	cevArfb0Hac+9f/6TWQN6p5sTFGj8mXkeByuXMfFL7/p/g7PeCa91y66NjXw9080pqeCouzmto/M/
	GQ8HWfxQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJQo9-00GQDM-0G;
	Wed, 12 Jul 2023 03:46:29 +0000
Message-ID: <2d510b31-fe26-c89b-9ae7-0dfffa900cc1@infradead.org>
Date: Tue, 11 Jul 2023 20:46:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 09/12] wifi: mac80211: fix kernel-doc notation warning
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Benjamin Berg <benjamin.berg@intel.com>, linux-wireless@vger.kernel.org
References: <20230710230312.31197-1-rdunlap@infradead.org>
 <20230710230312.31197-10-rdunlap@infradead.org>
 <20230711203702.001235a4@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711203702.001235a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/11/23 20:37, Jakub Kicinski wrote:
> On Mon, 10 Jul 2023 16:03:09 -0700 Randy Dunlap wrote:
>> + * @agg: station's active links data
> 
> That does not sound right. It'd be better to wait for the WiFi
> maintainers to return to get the WiFi bits merged. Can we defer
> WiFi patches for now?

Sure, no problem.

-- 
~Randy

