Return-Path: <netdev+bounces-58172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C385D815670
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0691C23787
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C01384;
	Sat, 16 Dec 2023 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+zNpKHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C12812
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC68C433C7;
	Sat, 16 Dec 2023 02:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702694178;
	bh=2ciOFUfrauh0vKavWFvd+4WqQNU7qgJetfPsc2M064Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t+zNpKHilXGyBJKUIkkbq/h9xEc5sJctbj+HwVubtm5y6NhoEmLOrbRj2LVxPujHQ
	 XgrXu3ltnVRIoOzjqAFPrdp/BT987XG9yviwdIxevrki5PxFIyaFRh+7kqoRmcwu7B
	 mE/KCItgWTgsw2722t65H/b7/r+ZYHIHq96fe0XMD7mid/d9y9g4HGVy0ORhzj8oWB
	 ghDPFWGR5u4yEhAPTTFhAlaCTp1eFsA+4UIzarvdFw0dsWKOvI5MC0c+VzURMIzn42
	 lTgB3NKgswGawLwVAmnzkm2FI/3zyZRytBTNSTD91ohsOfgAtGmbY6GKxI0uj1oeh5
	 sNjz+Ke0VoLCg==
Date: Fri, 15 Dec 2023 18:36:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 5/8] net: wangxun: add ethtool_ops for ring
 parameters
Message-ID: <20231215183616.0114c73b@kernel.org>
In-Reply-To: <20231214025456.1387175-6-jiawenwu@trustnetic.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
	<20231214025456.1387175-6-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:54:53 +0800 Jiawen Wu wrote:
> +	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> +		return -EOPNOTSUPP;

Kernel already checks request is within what's reported as max.
-- 
pw-bot: cr

