Return-Path: <netdev+bounces-233784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92864C18436
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 05:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03401A26F11
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6FA2E8B80;
	Wed, 29 Oct 2025 04:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ASucv68z"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9352F1FE2;
	Wed, 29 Oct 2025 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761713890; cv=none; b=rlubtWYKWD583DQyiplgzLs5zKDdGISiSLT1uWK2pLD8nsDZGDNJfoBirysssOHXnkY4mNg58m4ZqrGOkBs2wB+83aX+8CfDZRgVHlCQ6orZfSJ4jpvMOxOVdfoGoCA4leKVgNjWH7udgVw3rpjpkVM80OjBaG4YLtza2jB6M/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761713890; c=relaxed/simple;
	bh=GZYXUSYtyIYlOo3QBlsYXoJE5H9ioNVFGr9aV1N/wgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFUEF5Odyw4gPhzPQmBSQNq8YmVxrGwtfle3H6EpE08ySHOPglgDqsh+Qk2IW61QFVPCqMZZOCNt4f48Nfw1KTEqLA6UNu4fxd1KVboaFCWMtyuBopx2rxE1O14BjTPWxZSUeGlcRVS0RHJP/+fQhD+FqGurlPBi5DHeKyMgBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ASucv68z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=iLHGpr68jMu20RQ5Q/dozEDn13xb9hZQEqbOYuypP0M=; b=ASucv68zdF4Bj4WO3PElcBVkHf
	V9mvI48KrW4m8hLw8diA2TdLycxk0Y2vKRkbw8CigUVJAhZS+ESl2r3GRycaox9O7EjbEiBvFMOk1
	VWkDsBoGRNcy53PDotKOAhcF4ljQ94shQ/IYKMZp7c8pn9sjI8Qdeoh4BbgnAZsBsQO/P84RRoN49
	8W6pJOu15RSMYqS4KNQpPgP+MvM0EtqOFiC2RXB1vzu+XmAu0V+BpixJeajkJF0YOljJUi9hU5ZWK
	ekMDFhkcPoMe20XSAGMhpR36seKM4FIiai/NMGSDRQ7pw36FEFpM8FZYzdlvja1xyFv2x5qvKBl3R
	3GVmqMTw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyG8-0000000HFMh-1mJe;
	Wed, 29 Oct 2025 04:58:08 +0000
Message-ID: <4521c29e-e6c3-4d9b-bbce-8ada0dd2065c@infradead.org>
Date: Tue, 28 Oct 2025 21:58:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Doucmentation: netconsole: Separate literal code
 blocks for full netcat command name versions
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20251029015940.10350-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251029015940.10350-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


(typo in Subject: "Doucmentation")

On 10/28/25 6:59 PM, Bagas Sanjaya wrote:
> Both full and short (abbreviated) command name versions of netcat
> example are combined in single literal code block due to 'or::'
> paragraph being indented. Unindent it to separate the versions.

            being indented one more space than the preceding
	    paragraph (before the command example).

> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/networking/netconsole.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
> index 59cb9982afe60a..0816ce64dcfd68 100644
> --- a/Documentation/networking/netconsole.rst
> +++ b/Documentation/networking/netconsole.rst
> @@ -91,7 +91,7 @@ for example:
>  
>  	nc -u -l -p <port>' / 'nc -u -l <port>
>  
> -    or::
> +   or::
>  
>  	netcat -u -l -p <port>' / 'netcat -u -l <port>
>  
> 
> base-commit: 61958b33ef0bab1c1874c933cd3910f495526782

-- 
~Randy

