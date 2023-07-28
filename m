Return-Path: <netdev+bounces-22092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7576609D
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8141C2149B
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC247F2;
	Fri, 28 Jul 2023 00:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490018E
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44748C433C7;
	Fri, 28 Jul 2023 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690503352;
	bh=qO4orcqKIyixzmIclS1d/jfz4X+1nmlz+rtM+R1Fxos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LobF8n518Uk7LAFEXo5QKP3w6kV5tGfANO6/cFDubUC8bnhwYaicNcoDykkloTom+
	 U5FUaRwtxyZ6FL16q8fCCFCBXRKBnDCq13kQecKp2NBJlgVRQP/+PfWalXXpd7XJbo
	 q3GmY3PZPd025cMREcBcgrnAK9SZEcTZVza909aZcKDnunX9RiCcBvU9todEt2eHxn
	 ymTC5AdZ0YJzlHLiorrN/JFGo7Rnjk7bhtLHualsDsm317FLCVkpvYsYVo0JUqfCm5
	 mLfcyBTA4TD8sFMG8Kphmb17L/Vvu2lQlV1BrCfvgPdvP6Do97k2AB8X5NrH2xMKhk
	 t26B14KayTlOg==
Date: Thu, 27 Jul 2023 17:15:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 razor@blackwall.org, idosch@nvidia.com, lucien.xin@gmail.com,
 liuhangbin@gmail.com, edwin.peer@broadcom.com, jiri@resnulli.us,
 md.fahad.iqbal.polash@intel.com, anirudh.venkataramanan@intel.com,
 jeffrey.t.kirsher@intel.com, neerav.parikh@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <20230727171551.28b7504d@kernel.org>
In-Reply-To: <20230726075314.1059224-1-linma@zju.edu.cn>
References: <20230726075314.1059224-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 15:53:14 +0800 Lin Ma wrote:
> V2 -> V3: add net subject prefix and Acked-by tag

Because of the repost this patch didn't make it in time to today's
PR and you'll have to wait another week before posting the cleanup
of the drivers :(

