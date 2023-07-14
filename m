Return-Path: <netdev+bounces-17734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCE752EE8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 03:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE43E1C20D7B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 01:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CF7FF;
	Fri, 14 Jul 2023 01:49:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099B7F4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:49:00 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B8B2694;
	Thu, 13 Jul 2023 18:48:57 -0700 (PDT)
X-QQ-mid:Yeas43t1689299276t121t06280
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.254.133])
X-QQ-SSF:00400000000000F0FPF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16226584020387075153
To: "'Wang Ming'" <machel@vivo.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Cc: <opensource.kernel@vivo.com>,
	<opensource.kernel@vivo.com>
References: <20230713121633.8190-1-machel@vivo.com>
In-Reply-To: <20230713121633.8190-1-machel@vivo.com>
Subject: RE: [PATCH net v1] net: ethernet: Remove repeating expression
Date: Fri, 14 Jul 2023 09:47:55 +0800
Message-ID: <000a01d9b5f5$3591e8b0$a0b5ba10$@trustnetic.com>
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
Thread-Index: AQI0yjQuFQ/A5lRuvqU7vaX0n2FvbK8CVZYw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, July 13, 2023 8:16 PM, Wang Ming wrote:
> Identify issues that arise by using the tests/doublebitand.cocci
> semantic patch. Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 39a9aeee7aab..6321178fc814 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -1511,7 +1511,6 @@ static void wx_configure_rx(struct wx *wx)
>  	psrtype = WX_RDB_PL_CFG_L4HDR |
>  		  WX_RDB_PL_CFG_L3HDR |
>  		  WX_RDB_PL_CFG_L2HDR |
> -		  WX_RDB_PL_CFG_TUN_TUNHDR |
>  		  WX_RDB_PL_CFG_TUN_TUNHDR;
>  	wr32(wx, WX_RDB_PL_CFG(0), psrtype);

Reviewed-by: Jiawen Wu <jiawenwu@trustnetic.com>


