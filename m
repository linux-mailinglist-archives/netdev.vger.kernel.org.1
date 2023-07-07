Return-Path: <netdev+bounces-16162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1FD74B9FD
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A421C210A2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339F17FE7;
	Fri,  7 Jul 2023 23:20:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0573F17FE0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 23:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E9FC433C8;
	Fri,  7 Jul 2023 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688772023;
	bh=guclDQFZI4tq3u2imvS9tUxe63HHhCTkPyK5YI7SuLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FMFf+Hsp7R1yqbzEezLy50tmzQwci415mMRqj29gIDM0kkhhWAP/BJb4nrvXmVXoc
	 e5amezl57ut5LMp81/4PLd/VYCJvqJOoh+tfVMGNy1BfaODRBAykkJEJ8ZJrSjmsQo
	 HTdb81LIkDZcaP0ZZMFrRj9Dpi+fWoV/J3vWwZSXztblUYG3hIgFUzqq5sQ1xTwpGq
	 zohQp0LGZo5hDsYO8ufFsomd+/A45sJa/tjb9Y3MA8SwXs/JHyOQ6Ey0XUzaAyxKAr
	 CaupJAhF8UC1gldzi989hO4bUAF7YZclUAFKB6qaT1WGMv2NnBlCakI3h+MiLct8CH
	 AOH/2s1JtQIUQ==
Date: Fri, 7 Jul 2023 16:20:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, haiyue.wang@intel.com, awogbemila@google.com,
 davem@davemloft.net, pabeni@redhat.com, yangchun@google.com,
 edumazet@google.com
Subject: Re: [PATCH net-next] gve: enhance driver name usage
Message-ID: <20230707162022.2df4359e@kernel.org>
In-Reply-To: <20230707024405.3653316-1-junfeng.guo@intel.com>
References: <20230707024405.3653316-1-junfeng.guo@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jul 2023 10:44:05 +0800 Junfeng Guo wrote:
> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.

Please read the guidelines before posting patches:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

