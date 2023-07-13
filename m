Return-Path: <netdev+bounces-17379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5375166C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A680F1C20FBD
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB136A;
	Thu, 13 Jul 2023 02:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B37C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:46:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB519BA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1CirAZ6nyDpruZV7FUkA3PDSBAtQ/NjkFO1KNgzqE+M=; b=Gn7ObU+IjMAoLR1TDd0PifU5kg
	TGkn5sbSehKlurqqQuWKItuUmRq4FhyOqA96BNoPgALAPsBq7Qj0qd3QgxT4E/Y2aeLBQRhUttt9s
	gqJ9+oG5d04m3ar83IWRVbhK4d5yB2Rc5Ts2cJFVd0Pdwc6eNuLP6SQuOoW9Dy9NnVE3iEc4CbruA
	DZ+yDHgWJXLPkdaDHUJtKXUBTZW2De7DTl1hLz90aBx7YD9vI7PTsHPxmtD4Jp6FL5ZiZRtLEZ5Vo
	WwcvFygXMrZrNdmjgeSMjrZBIzd2jRXFI/u088qyxsD23Ht4ujY5213UdSUejE/l8D3rrRjqagyvh
	2/JE/F2Q==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qJmLk-001l6p-2g;
	Thu, 13 Jul 2023 02:46:37 +0000
Message-ID: <405a88ba-8f6f-4794-96f6-01a0f77cf662@infradead.org>
Date: Wed, 12 Jul 2023 19:46:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 net 07/12] inet: frags: eliminate kernel-doc warning
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
References: <20230712044040.10723-1-rdunlap@infradead.org>
 <20230712171637.5c9630b9@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712171637.5c9630b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/12/23 17:16, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 21:40:40 -0700 Randy Dunlap wrote:
>> Change the anonymous enum kernel-doc content so that it doesn't cause
>> a kernel-doc warning.
>>
>> inet_frag.h:33: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Could you resend the entire series with the more complex WiFi patches
> taken out as well?

Sure, will do.

-- 
~Randy

