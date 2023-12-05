Return-Path: <netdev+bounces-53843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B48804D7F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24DB1C20B2F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABAF3E496;
	Tue,  5 Dec 2023 09:21:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DC583
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:21:31 -0800 (PST)
X-QQ-mid:Yeas1t1701768050t854t48136
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.204.154.156])
X-QQ-SSF:00400000000000F0FSF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13344881203513048041
To: "'duanqiangwen'" <duanqiangwen@net-swift.com>,
	<netdev@vger.kernel.org>,
	<kuba@kernel.org>,
	<mengyuanlou@net-swift.com>,
	<davem@davemloft.net>,
	<pabeni@redhat.com>,
	<yang.lee@linux.alibaba.com>,
	<error27@gmail.com>,
	<horms@kernel.org>
References: <20231205065033.19536-1-duanqiangwen@net-swift.com>
In-Reply-To: <20231205065033.19536-1-duanqiangwen@net-swift.com>
Subject: RE: [PATCH net] net: libwx: fix memory leak on free page
Date: Tue, 5 Dec 2023 17:20:49 +0800
Message-ID: <04f201da275c$566735d0$0335a170$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJx97aawQypS/CXAFrzFUrGxQZG6q9qx4TA
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

> @@ -2248,8 +2180,7 @@ static void wx_clean_rx_ring(struct wx_ring *rx_ring)
> 
>  		/* free resources associated with mapping */
>  		page_pool_put_full_page(rx_ring->page_pool, rx_buffer->page, false);
> -		__page_frag_cache_drain(rx_buffer->page,
> -					rx_buffer->pagecnt_bias);
> +

No need to add this blank line. Other looks good to me, thanks!

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>

> 
>  		i++;
>  		rx_buffer++;
 


