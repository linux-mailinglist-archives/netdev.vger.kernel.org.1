Return-Path: <netdev+bounces-106717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6865591756D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2736C2832B9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772E6BA47;
	Wed, 26 Jun 2024 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRS2JEBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B76125;
	Wed, 26 Jun 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719364080; cv=none; b=Yb28n2nXggpkxjAjII41ouIWptPADTypzAcoQvtL78Z1CxKrGVb0/0qcOvjMtW8BGS7IFZZMBpSVQXk+Z8ZvppyhA6riZ/6eqMc6qmcCgNOfO3VPyO3pWWLvxomsmQ4PpQtQv5DWvBNclQIIoWsC09geyw9UxL2ktGvltIc0QbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719364080; c=relaxed/simple;
	bh=iLGdpkzyr7SI1aiVURjiW/LPzHYSNF0CwENLNEPe2/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShwdvHt/isYVwW1Cgux2NMGtuYZ3shdwW8Wjc899ieTPDbijTA0+OQcWPipgIWLeHutQV5qNX7ZIQfORn+uThjpZNSs2fNicxu7EPIstCohzhBmWUZO1qjIwRNpkFCp3DEQogXo3GzDPqx4cj5U6IFTJtOkrEmh2QpJ6CX2oMPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRS2JEBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C03C32781;
	Wed, 26 Jun 2024 01:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719364079;
	bh=iLGdpkzyr7SI1aiVURjiW/LPzHYSNF0CwENLNEPe2/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRS2JEBolDJkVF2/Gw2Hm7Jl1Ehnjy94Snootr/3aq3HVprszQb3+zhbcN5r3Tnxn
	 lECi4AU+FTe3nDyXF6c4S101/MpmxMXNCbIsP7Mm45g3G8FbPfaHK0O9PHvzdDbI13
	 cgNjmHySfMFRWHDewb4hKWwV25TfZ87Em9EnvElsFj+mUuu+K4iMGHBlgCLxnAds/A
	 MeRLJ1cb9zw2kc5mj63M9yDgrvknVk9XDcPGOuBLnL+xygBT6RFd6f5TD6434LAnjT
	 fRJ1PYVrx248QnbNZDau0Ma+K0DFDw0LnvEojAYrwK4fvMdKxyejY3k8cTBocXWaD5
	 8zjXnKuIuwRHQ==
Date: Tue, 25 Jun 2024 18:07:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v21 12/13] realtek: Update the Makefile and
 Kconfig in the realtek folder
Message-ID: <20240625180758.069a9d4f@kernel.org>
In-Reply-To: <20240624062821.6840-13-justinlai0215@realtek.com>
References: <20240624062821.6840-1-justinlai0215@realtek.com>
	<20240624062821.6840-13-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 14:28:20 +0800 Justin Lai wrote:
> diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
> index 635491d8826e..046adf503ff4 100644
> --- a/drivers/net/ethernet/realtek/Makefile
> +++ b/drivers/net/ethernet/realtek/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_ATP) += atp.o
>  r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
>  r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
>  obj-$(CONFIG_R8169) += r8169.o
> +obj-$(CONFIG_RTASE) += rtase/

sparse points out:

drivers/net/ethernet/realtek/rtase/rtase_main.c:1668:32: warning: cast to restricted __le64
drivers/net/ethernet/realtek/rtase/rtase_main.c:1668:32: warning: cast from restricted __le32
-- 
pw-bot: cr

