Return-Path: <netdev+bounces-35771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2A7AB096
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 06FB428270F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DC1F18A;
	Fri, 22 Sep 2023 11:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9451DDFB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:28:55 +0000 (UTC)
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [IPv6:2001:41d0:203:375::c3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A1CA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 04:28:53 -0700 (PDT)
Message-ID: <5b5704d6-3eca-70a8-4dc4-3a37653e3956@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695382131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahl86MwZXr+YqMQ9RZ+afjaNkizX+5JO/dtLHweXa+0=;
	b=gbo+nDcY+K7sqWqfH1y+mtpLzXZVT+gU+uCU4HjweuzKp+hMT/maJL2DepzaWVkDhft0qn
	3/17euRx65ZP5m8+32f6CksOSBABeWeo2tuCyATsoYzSAL+JkuJLAHOwjwHBN+S38DowYS
	Nl/4C0oOQKnS+VFKfWElQ9KPPYcfuaU=
Date: Fri, 22 Sep 2023 12:28:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix error handling in ptp_ocp_device_init
Content-Language: en-US
To: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Vadim Fedorenko <vadfed@fb.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230922094044.28820-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/09/2023 10:40, Dinghao Liu wrote:
> When device_add() fails, ptp_ocp_dev_release() will be called
> after put_device(). Therefore, it seems that the
> ptp_ocp_dev_release() before put_device() is redundant.
> 
> Fixes: 773bda964921 ("ptp: ocp: Expose various resources on the timecard.")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thanks!

Reviewed-by: Vadim Feodrenko <vadim.fedorenko@linux.dev>


