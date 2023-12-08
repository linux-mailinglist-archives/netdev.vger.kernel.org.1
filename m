Return-Path: <netdev+bounces-55151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E3809973
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 03:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8561F21162
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7E15CB;
	Fri,  8 Dec 2023 02:44:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F9171D;
	Thu,  7 Dec 2023 18:44:18 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vy1YA3j_1702003454;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vy1YA3j_1702003454)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:44:15 +0800
Date: Fri, 8 Dec 2023 10:44:12 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>
Subject: Re: [PATCH net] MAINTAINERS: remove myself as maintainer of SMC
Message-ID: <ZXKC_AyVp4lGAMQI@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20231207202358.53502-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207202358.53502-1-wenjia@linux.ibm.com>

On Thu, Dec 07, 2023 at 09:23:58PM +0100, Wenjia Zhang wrote:
> From: Karsten Graul <kgraul@linux.ibm.com>
> 
> I changed responsibilities some time ago, its time
> to remove myself as maintainer of the SMC component.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thank you Karsten.

Tony Lu

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6109201e8b4..ddb858576d8b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19638,7 +19638,6 @@ S:	Maintained
>  F:	drivers/misc/sgi-xp/
>  
>  SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
> -M:	Karsten Graul <kgraul@linux.ibm.com>
>  M:	Wenjia Zhang <wenjia@linux.ibm.com>
>  M:	Jan Karcher <jaka@linux.ibm.com>
>  R:	D. Wythe <alibuda@linux.alibaba.com>
> -- 
> 2.40.1

