Return-Path: <netdev+bounces-40393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378F7C71D9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129221C20E3F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF882AB2F;
	Thu, 12 Oct 2023 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQbK6SWr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD0266C6;
	Thu, 12 Oct 2023 15:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900FB8;
	Thu, 12 Oct 2023 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8RVJPN0HB6MxXDFbRxx5/l1GgBlrlJr+jq++zl6CXoc=; b=ZQbK6SWrVLDLDykCOvFDAvn7Xu
	MUYsRM1i7go0fld55cuSIK5u9oty5W7/IWZCybr7DNgGn67obthxjNHD4vbiI1Nz0PpVAtqnn1olv
	fx6v6FUcLMM9O26aUNst1s9OpKHWMWMld62cm/4OTIfoWkYHay4ydHChEyr1GE6EGbpm0R3nU2qxN
	3n2IrkxqAcVyjle5S5QKlhyRAjoe+MqHQzpHk2VFx+imevMbgMDbrWaB1q2RApRSsMJRFGmAI9h0A
	pB6h/ysmKOM/eHK/5Or61nHLeLoh/rt4DpO79CvTvwQpYMUFFCr++V7lXQ2+yypCWVJUyNgLFpI7t
	WY6Av6CA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qqxyI-001Kp1-14;
	Thu, 12 Oct 2023 15:51:34 +0000
Message-ID: <aed223c3-9065-42c4-8edb-40facbbbf0ee@infradead.org>
Date: Thu, 12 Oct 2023 08:51:33 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: netlink: clean up after deprecating
 version
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, linux-doc@vger.kernel.org
References: <20231012154315.587383-1-kuba@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231012154315.587383-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/12/23 08:43, Jakub Kicinski wrote:
> Jiri moved version to legacy specs in commit 0f07415ebb78 ("netlink:
> specs: don't allow version to be specified for genetlink").
> Update the documentation.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../userspace-api/netlink/genetlink-legacy.rst     | 14 ++++++++++++++
>  Documentation/userspace-api/netlink/specs.rst      |  5 -----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
> index 40b82ad5d54a..11710086aba0 100644
> --- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
> +++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
> @@ -11,6 +11,20 @@ the ``genetlink-legacy`` protocol level.
>  Specification
>  =============
>  
> +Gobals

Globals
?

> +------
> +
> +Attributes listed directly at the root level of the spec file.
> +
> +version
> +~~~~~~~
> +
> +Generic Netlink family version, default is 1.
> +
> +``version`` has historically been used to introduce family changes
> +which may break backwards compatibility. Since breaking changes
> +are generally not allowed ``version`` is very rarely used.

I would s/are/is/. To me "breaking changes" is singular, not plural.

> +
>  Attribute type nests
>  --------------------
>  
> diff --git a/Documentation/userspace-api/netlink/specs.rst b/Documentation/userspace-api/netlink/specs.rst
> index cc4e2430997e..40dd7442d2c3 100644
> --- a/Documentation/userspace-api/netlink/specs.rst
> +++ b/Documentation/userspace-api/netlink/specs.rst
> @@ -86,11 +86,6 @@ name
>  Name of the family. Name identifies the family in a unique way, since
>  the Family IDs are allocated dynamically.
>  
> -version
> -~~~~~~~
> -
> -Generic Netlink family version, default is 1.
> -
>  protocol
>  ~~~~~~~~
>  

-- 
~Randy

