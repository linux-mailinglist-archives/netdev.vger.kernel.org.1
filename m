Return-Path: <netdev+bounces-43350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B207D2AE0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5145D2813F4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CFB7480;
	Mon, 23 Oct 2023 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BPHRQwcC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A747D
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 07:05:46 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A52D68;
	Mon, 23 Oct 2023 00:05:41 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39N75ebo001004;
	Mon, 23 Oct 2023 02:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1698044740;
	bh=n46QO4lzKlwajVMvpQYMgEK4ghMWmPTH/e8dZkq1/Dk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BPHRQwcCEPzLlps3Uu8b13q7QmYriaJv4g+EuyH+YnqxiwFZmF66+WqEQsQPZPVAJ
	 ucJh16qfdChzAHo/1BEJHPCnU2iz/ipkgh/F2RcrRCAwH+2XZeUgqWDsSY9CqRLUpI
	 EiPInoG5h4BDjgixxb01NUzxrRHsz5wrG9C6LDmM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39N75dMI014098
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Oct 2023 02:05:40 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 02:05:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 02:05:38 -0500
Received: from [172.24.227.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39N75aH5017134;
	Mon, 23 Oct 2023 02:05:36 -0500
Message-ID: <5aff2aa7-a4bd-19d8-8c61-8cd9ab25f01b@ti.com>
Date: Mon, 23 Oct 2023 12:35:35 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 01/17] Make cork in inet_sock a pointer.
Content-Language: en-US
To: Oliver Crumrine <ozlinuxc@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <davem@davemloft.n>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
 <1a849abd2f67545bc99988c5f18de46e6b273618.1697989543.git.ozlinuxc@gmail.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <1a849abd2f67545bc99988c5f18de46e6b273618.1697989543.git.ozlinuxc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 10/22/23 9:50 PM, Oliver Crumrine wrote:
> Change the cork in inet_sock to a pointer. This is the actual change
> to the struct itself for ipv4.
> 
> Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
> ---
>  include/net/inet_sock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 2de0e4d4a027..335cd6b2d472 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -240,7 +240,7 @@ struct inet_sock {
>  	}			local_port_range;
>  
>  	struct ip_mc_socklist __rcu	*mc_list;
> -	struct inet_cork_full	cork;
> +	struct inet_cork_full	*cork;
>  };
>  
>  #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */

Please make sure each patch in the series in buildable. This helps during a
git bisect.

-- 
Regards,
Ravi

