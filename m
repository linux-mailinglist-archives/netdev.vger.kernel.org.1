Return-Path: <netdev+bounces-29055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5487817BB
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 09:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4121C20B0A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6A7110D;
	Sat, 19 Aug 2023 07:03:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05972634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C7C433C8;
	Sat, 19 Aug 2023 07:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692428619;
	bh=zaCiXBQ9Im6UJf9wKSq8d9Iu/HdAEmZZBSgF+FKSMHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1yuBtk7hz9AuosnOhN1SU2tUPCMI6xCApiWPhXop5LlN9ktTnXskwRjUf2YczQ84
	 v+rGAXf9rAvjIzxKQDPvDgaWz0R9pLsoNCoNI5s8yfCf7sAcEkQ2SlSMZZG7ckFhL5
	 gL5/2LAhOqDlABRsR1gN+nmGOGnBrD/e/LbGw2vsqGezyzWb3nwX5XYMOXYhv353/m
	 JZ6vFGGWHpUcChCmfJ61RkAQeBJVTQmeBh+dLHxEsLgOKAopctQXKwoVqW/KckLVpn
	 dCs0Szg5suXVXqXTmLkM7rImOopJ+7TzvbRWHLL97yI3ow/S6b/ffuODEF5KEc9bK/
	 2k/bEpyqWTEuQ==
Date: Sat, 19 Aug 2023 09:03:34 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: horatiu.vultur@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
	richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 0/3] net: Update and fix return value check
 for vcap_get_rule()
Message-ID: <ZOBpRmHXndkvFcnA@vergenet.net>
References: <20230818050505.3634668-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818050505.3634668-1-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:05:02PM +0800, Ruan Jinjie wrote:
> As Simon Horman suggests, update vcap_get_rule() to always
> return an ERR_PTR() and update the error detection conditions to
> use IS_ERR(), which would be more cleaner.
> 
> So se IS_ERR() to update the return value and fix the issue
> in lan966x_ptp_add_trap().
> 
> Changes in v2:
> - Update vcap_get_rule() to always return an ERR_PTR().
> - Update the return value fix in lan966x_ptp_add_trap().
> - Update the return value check in sparx5_tc_free_rule_resources().
> 
> Ruan Jinjie (3):
>   net: microchip: vcap api: Always return ERR_PTR for vcap_get_rule()
>   net: lan966x: Fix return value check for vcap_get_rule()
>   net: microchip: sparx5: Update return value check for vcap_get_rule()

Thanks.

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


