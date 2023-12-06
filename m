Return-Path: <netdev+bounces-54550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059280770F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78591C20A9F
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B416DCEE;
	Wed,  6 Dec 2023 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK8kw/XU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952886ABBD;
	Wed,  6 Dec 2023 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3032DC433C8;
	Wed,  6 Dec 2023 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701885342;
	bh=TUDaZmgDVeZf7ahZppg49YtSKlr7WValVfZgX1WCnVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TK8kw/XUVkKievC9keVIJ/kgNUTLNcfUMDiIE0sX9zBqoXq3H33LGkxmfpBxTQUEf
	 X4Vn6NtX3K3TwtKKadtebAEL/rUorESSrG/6I6JbvL1TlrQ6jZFWpWFX30VIAdNQAl
	 yIg/TYJePDYhtU6QDHajNNwk07clyGKKaIwZKmv4ExPjt4B65PA0jnOkdPnxdF4FiF
	 LIDOrMTVv/7ON8GKbjcRHAwvKd46IOynujTAKQKpgTgbbNy/HANNOWEZ5G9HPgcPhk
	 kucN9PqPJ3kllVfH8kOD/CZZX/0yotzEZDp3ghchuL+18cKjKv7RBgZHpIG9/ecaYj
	 fBkmLlFUdtgew==
Date: Wed, 6 Dec 2023 09:55:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 alexander.duyck@gmail.com, ecree.xilinx@gmail.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/8] Support symmetric-xor RSS hash
Message-ID: <20231206095540.5df7c5a5@kernel.org>
In-Reply-To: <20231205230049.18872-1-ahmed.zaki@intel.com>
References: <20231205230049.18872-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 16:00:41 -0700 Ahmed Zaki wrote:
> Patches 1 and 2 modify the get/set_rxh ethtool API to take a pointer to 
> struct of parameters instead of individual params. This will allow future
> changes to the uAPI-shared struct ethtool_rxfh without changing the
> drivers' API.

Looks like it breaks the allmodconfig build.
-- 
pw-bot: cr

