Return-Path: <netdev+bounces-26441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14B777C78
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB102821DB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A820CA0;
	Thu, 10 Aug 2023 15:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA5200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E862125;
	Thu, 10 Aug 2023 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LZZwhU2q9tKRTuT4LMGtkLl/YytlWdJV5ADQ7yyf884=; b=nzCVWxdZKZwPPVrpb79vDihKKN
	YQMNeNih7Df6L+pZOvTjw50y9FCJs6aH8rL8h5X2REST5vdC3Wq9YdRoE5xnf6hw68vx0zt8985/4
	+9cDPaBlKuKeAHsCvu3wOh/4f+NA8FgH2SNngUajJxMQhE16KsGIQEWgQG79GUlXunzjgzLhpAOr+
	SYDCVy0iFP1vRNzRSbC+T0oIVVz6F2RvcjiMZYX3czR+nm5oLvCNzwtupO+DnMacrLMCIbCpZMS31
	kUka0xfiEZR78ZR0A8ZecYiCVpTdwXhUWyz2kMWRbBUeMIq9zHuWNHz7b8W60+R7DbtqAwg0Ryp6u
	XrPT05iA==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7mf-0084NA-10;
	Thu, 10 Aug 2023 15:41:09 +0000
Message-ID: <efb2d30c-3945-a63d-9a3f-7cf39124f76a@infradead.org>
Date: Thu, 10 Aug 2023 08:41:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V8 1/9] drivers core: Add support for Wifi band RF
 mitigations
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, johannes@sipsolutions.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Mario.Limonciello@amd.com, mdaenzer@redhat.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, hdegoede@redhat.com,
 jingyuwang_vip@163.com, Lijo.Lazar@amd.com, jim.cromie@gmail.com,
 bellosilicio@gmail.com, andrealmeid@igalia.com, trix@redhat.com,
 jsg@jsg.id.au, arnd@arndb.de, andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
References: <20230810073803.1643451-1-evan.quan@amd.com>
 <20230810073803.1643451-2-evan.quan@amd.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230810073803.1643451-2-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 00:37, Evan Quan wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41..21f73a0bbd0b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7152,3 +7152,12 @@
>  				xmon commands.
>  			off	xmon is disabled.
>  
> +	wbrf=		[KNL]
> +			Format: { on | auto | off }
> +			Controls if WBRF features should be enabled or disabled
> +			forcely. Default is auto.

"forcely" is not a word. "forcedly" is a word, but it's not used very much
AFAIK.
I would probably write "Controls if WBRF features should be forced on or off."

> +			on	Force enable the WBRF features.
> +			auto	Up to the system to do proper checks to
> +				determine the WBRF features should be enabled
> +				or not.
> +			off	Force disable the WBRF features.

-- 
~Randy

