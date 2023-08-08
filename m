Return-Path: <netdev+bounces-25364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37110773CC3
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42A9280D3E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B1154A4;
	Tue,  8 Aug 2023 15:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EF1F92D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 15:52:09 +0000 (UTC)
Received: from out-111.mta1.migadu.com (out-111.mta1.migadu.com [IPv6:2001:41d0:203:375::6f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB333100F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 08:51:56 -0700 (PDT)
Message-ID: <1591f6c8-f346-83da-f4f5-abdd7d0c0bd4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691500286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/lIaGaMy4aD0ASgIkzR9MKyiCWlm3ct+3qApo5JH54=;
	b=WR0ktPZvEmEl5N39254FTQWH+skmrzfpOSuswr5kLbplNopwYJKoazBPF3QGUK4b8P+BaO
	bZRp6seoxUGwn4MKBjnwNcwH96DxlfT2dlAhuMikf3kEebqNQ9CuZKDWHPSMnO6iKtNu6w
	Wi71nghvkj7PwcS+TFXkDASf6jsysJA=
Date: Tue, 8 Aug 2023 14:11:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH linux-next v2] net/ipv4: return the real errno instead of
 -EINVAL
Content-Language: en-US
To: xu.xin.sc@gmail.com
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xu xin <xu.xin16@zte.com.cn>, Yang Yang <yang.yang29@zte.com.cn>,
 Si Hao <si.hao@zte.com.cn>, davem@davemloft.net
References: <20230807015408.248237-1-xu.xin16@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230807015408.248237-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/08/2023 02:54, xu.xin.sc@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, No matter what error pointer ip_neigh_for_gw() returns,
> ip_finish_output2() always return -EINVAL, which may mislead the upper
> users.
> 
> For exemple, an application uses sendto to send an UDP packet, but when the
> neighbor table overflows, sendto() will get a value of -EINVAL, and it will
> cause users to waste a lot of time checking parameters for errors.
> 
> Return the real errno instead of -EINVAL.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Si Hao <si.hao@zte.com.cn>
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

