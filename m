Return-Path: <netdev+bounces-22084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CC765FF4
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA911C216F3
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F082134B1;
	Thu, 27 Jul 2023 22:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAD3FF4
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 22:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50932126;
	Thu, 27 Jul 2023 15:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gxst0MV95XkxjAxP5vu3jd+SGLllfaqP4uTfI0i8aYU=; b=hTokEEYXZn8ySLNVTv4Ah4W896
	WcN2W0pLQjkOkrFkJzHC7mPxvaeG4HBjhy7vR6oFWlzVGiBawqKGErNRIFcbdWTFuxqlodgYow/SO
	6b2MxyciEmSe2H3JQvQsZHa5bfXA4o9Gw+O/oenTcZPeNDfBHYhajGazcf7tHPpgyYVnGtWPdleQL
	ZZnUHNsxR2krZZZ/IkFaNtA/YOnfdUTxevTujg3Qq+Qs4zMFGYHoyLraE1b792NsYSmEthrTcROAD
	qe+EokPkjf2lLZvDy4B4U5JX2zp4kS1+hEb3OA3icNlZO1ojFY31KFXowqJlt2SCE0WnpvtWlQ28t
	b0KyLvIQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qP9pe-000mOj-0l;
	Thu, 27 Jul 2023 22:51:42 +0000
Message-ID: <c1f6344f-1b5d-15cc-f692-b5d036d8ad20@infradead.org>
Date: Thu, 27 Jul 2023 15:51:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] netconsole: Enable compile time configuration
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20230727163132.745099-1-leitao@debian.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727163132.745099-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/27/23 09:31, Breno Leitao wrote:
> +config NETCONSOLE_APPEND_RELEASE
> +	bool "Enable kernel release version in the message"
> +	depends on NETCONSOLE_EXTENDED_LOG
> +	default n
> +	help
> +	  Enable kernel release to be prepended to each netcons message. The
> +	  kernel version is prepended to the first message, so, the peer knows what
> +	  kernel version is send the messages.

	                 is sending
or
	                 sends

> +	  See <file:Documentation/networking/netconsole.rst> for details.

-- 
~Randy

