Return-Path: <netdev+bounces-25558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A48774B93
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067AC1C20FAB
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB115495;
	Tue,  8 Aug 2023 20:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1610FF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:50:29 +0000 (UTC)
Received: from out-123.mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97E11CDC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 13:50:13 -0700 (PDT)
Message-ID: <e0e08b40-4917-7b41-e3fb-1e347275be43@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691527811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wO51R1rpXagvmAqQLUK3W1Qk21JeQvWYbe9/wfKEmM=;
	b=i+06nOX4eaxGuPpGXCN+nwEaTvrpo6OAA8K8kjoRU/j08daCcOuaODCr8EH4GIGxlYcPqm
	m8fHftzLTomoHBMbTqJfY1b69hURAcHmEARtcmarQMzyZJb6eQIaBshdthwmpwjSLQs3Ji
	nmoEsRJpUQnuzrNItghoXDB50z2pZqM=
Date: Tue, 8 Aug 2023 21:50:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] tools: ynl-gen: add missing empty line between
 policies
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20230808200907.1290647-1-kuba@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230808200907.1290647-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/08/2023 21:09, Jakub Kicinski wrote:
> We're missing empty line between policies.
> DPLL will need this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Yep, now it works perfect.

Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



