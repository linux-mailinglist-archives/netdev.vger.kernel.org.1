Return-Path: <netdev+bounces-17040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B374FDFE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B761C20FDF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE21FBD;
	Wed, 12 Jul 2023 03:48:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AE11FA6
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:48:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AD210D2
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RQlcOYvlKTCgXV+mrFYr+dSenRDQe79YXFPYNdKNPVc=; b=2DLeyOtieObYkgEDdveo8yLhgf
	sraQou33YGUaMbdIAViFJZB3qZJuzUMsyBN587jFDew7rPOYsYjilpvtrgnoqYMXFncpaSMOH77Rt
	8bg1IiLQOslBEyEsz+NIerqAuTZmUyOooTMPujmGmkwyaqI96vfHhm/yro+HW9MSuL7xYlRxdf5y+
	H/1qTIktb+HpNTqhGN9Z6gjM8ni7Mmi0laE/2JaPZ7WGKlzPoWnpPP0xb0mXlEp6gGmojNuyc9qGH
	I5uzjsyiB7Ms1r8zSfnOcxY+MOI4/syN9rDonQdzFmaioRDc06D4RXvPVFuTGgk781N45tXJj4JE6
	cImYjJ8A==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJQpk-00GQPj-13;
	Wed, 12 Jul 2023 03:48:08 +0000
Message-ID: <a1b99cea-0abc-a94a-7f59-28340aaf2cfe@infradead.org>
Date: Tue, 11 Jul 2023 20:48:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net 07/12] inet: frags: remove kernel-doc comment marker
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
 <20230710230312.31197-8-rdunlap@infradead.org>
 <20230711203430.3c9e9ad2@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230711203430.3c9e9ad2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/11/23 20:34, Jakub Kicinski wrote:
> On Mon, 10 Jul 2023 16:03:07 -0700 Randy Dunlap wrote:
>> -/**
>> +/*
>>   * fragment queue flags
> 
> Can we do:
> 
> 	enum: fragment queue flags
> 
> instead? This seems to get accepted by ./scripts/kernel-doc and it's
> nice to keep the "syntax" highlight of the comment, IMHO.

That's not quite kernel-doc syntax but we don't have syntax for an
anonymous enum. But you are correct, kernel-doc isn't complaining
about it, so OK, I can send a v2.

thanks.
-- 
~Randy

