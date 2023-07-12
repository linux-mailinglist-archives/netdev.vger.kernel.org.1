Return-Path: <netdev+bounces-17314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E8B751285
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8050F2817C3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB1EAF1;
	Wed, 12 Jul 2023 21:19:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA53E568
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC943C433C9;
	Wed, 12 Jul 2023 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689196758;
	bh=dYtNnKuYlMPnFmMK+CkNEWy3wxW+TIkeChH8MvDahpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exbYo7W2JJL35k7GVM9tC91j/4uDlVl7utEmOOfI9o+xoEKzICXqzEsEhouOKMMlW
	 AoproVCrV6icHn6bUhF9mwKZ/ZP43xW8zZ8KLg/F7oF9m2xxEEBGopsTMuR0OkU6UA
	 hgReFm1XuQu8+drP4gwRYxl1uxZmKVuW0hQcwjojqspzWU/ZihMMRozmCNSpTlbiHA
	 gEri/ngb0301iroH81XbUBHMpe6o6nshd9+XXE0syUSCXIwvoEOR6Rr8V4Ce1g/Jjb
	 aWbIfJ7EuJFFgHUIZGE0YFet8s6Afp+41m2POaGDTpBfuaRrZw7i/4Nx/bwqCS7Z/Z
	 nfVBsxC/RwQiw==
Date: Wed, 12 Jul 2023 14:19:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next/RFC PATCH v1 4/4] netdev-genl: Add support for
 exposing napi info from netdev
Message-ID: <20230712141917.4fcabaa0@kernel.org>
In-Reply-To: <3ee3105f-a2f9-8da1-b7b1-92ddfc6156f6@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
	<168564136118.7284.18138054610456895287.stgit@anambiarhost.jf.intel.com>
	<20230602231753.37ec92b9@kernel.org>
	<3ee3105f-a2f9-8da1-b7b1-92ddfc6156f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 13:10:45 -0700 Nambiar, Amritha wrote:
> So, I think we could have two new commands for napi data. Would this be 
> acceptable, a 'napi-queue-get' command for napi-queue specific 
> information (set of TX and RX queues, IRQ number etc.), and another 
> 'napi-info-get' for other information,  such as PID for the napi thread, 
> CPU etc.
> 
> Example:
>   $ ./cli.py --spec netdev.yaml  --do napi-queue-get --json='{"ifindex": 
> 12}'
> 
> [{'napi-info': [{'napi-id': 600, 'rx-queues': [7], 'tx-queues': [7], 
> 'irq': 298},

I think the commands make sense. You should echo back the ifindex, tho,
it threw me off initially that there's only on attribute ('napi-info')
in the reply, in which case the nest would have been pointless..

