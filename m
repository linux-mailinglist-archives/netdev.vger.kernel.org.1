Return-Path: <netdev+bounces-24606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C9770CD3
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D81D282793
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278277E2;
	Sat,  5 Aug 2023 01:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0D3622
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D02C433C8;
	Sat,  5 Aug 2023 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197354;
	bh=M+8sBjbD2p3XMgRE2SbAVr+Bgkba2GrE2IRQxa8Vhfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZEDe28rbiXMnMFtr+WtRHCOqLd7GonE2XTeocQ64SBl8ZCZ9Xrdn7fpK26ey8BG5
	 DhsuxiBGjL1hPL0DB/gwBzOg44Wlzmo6Nw/Z/n0oJap00UFHCmVkNzPTAb4jOrUvJp
	 YeUZ34Fcqy2KrsSHcs9hkI4GWnrD3OkuqjETdVDkpIcNZ+bAi7UtJz4jlEP1OLyiNd
	 T1MwqpE049ZODhsIB0vYPJ/GAGA3d47W9Y5MFoTUfRox2gtXyiZxNZlanUXfuc+Iw/
	 6CIHQMf4duu84ySnDwHfWWLOdkn51SkQKLte0W+J2NBjwfl2IKi2o4tx+GGJ23E5Az
	 e0iuTYNpyezcw==
Date: Fri, 4 Aug 2023 18:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: renesas: rswitch: Add runtime speed
 change support
Message-ID: <20230804180232.68813359@kernel.org>
In-Reply-To: <20230803120621.1471440-2-yoshihiro.shimoda.uh@renesas.com>
References: <20230803120621.1471440-1-yoshihiro.shimoda.uh@renesas.com>
	<20230803120621.1471440-2-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Aug 2023 21:06:20 +0900 Yoshihiro Shimoda wrote:
> +static const struct soc_device_attribute rswitch_soc_match[]  = {

nit: maybe a better than for this table would be good?
     To indicate what IDs it holds. E.g. rswitch_soc_no_speed_change[] ?

> +	{ .soc_id = "r8a779f0", .revision = "ES1.0" },
> +	{ /* Sentinel */ }
> +};
-- 
pw-bot: cr

