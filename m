Return-Path: <netdev+bounces-23185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962176B3F6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AEB1C20B40
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0F214F1;
	Tue,  1 Aug 2023 11:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AF1F952
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C2FC433C7;
	Tue,  1 Aug 2023 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690890936;
	bh=75N0AL6nh/GGlaa6WPHq86lW5bcuavySMo6LPe1YdjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9BNwV8uaON83bpsaWXkl5J3kleepSr76Zo3nPEpaLvDd5wkwcFl5DyFARH60LZIM
	 Gi2yZVJpMOrIwmIr6V9+lN9QJRzvbG3nKD2UUGJG1BUVSxj6cIQOQ1nmOPNPW61HSu
	 CW6dj53T2o0TJn3Y3oKwz6jfY2xduGcC/OJ3LU6DXn+irSX/xNqjKopyZAVnm1+Nsq
	 apj67YfWyp9XTxjvKAYbRDhucCcTPzLstW5tH0X1q/+LFJrLy4hB8NXjkOJ8DxgHnm
	 gNiWz+zuSTK3fGhmBDvu7t04FZGX5ywTW+WClgskfE6NUqMjlnLxtVKQisH2I2EDTL
	 6xw8LeeOZG+SQ==
Date: Tue, 1 Aug 2023 13:55:31 +0200
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lcherian@marvell.com,
	jerinj@marvell.com, simon.horman@corigine.com,
	jesse.brandeburg@intel.com
Subject: Re: [net-next PATCH V3 0/2] octeontx2-af: TC flower offload changes
Message-ID: <ZMjys4e4/S/dtyj2@kernel.org>
References: <20230801053813.2857958-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801053813.2857958-1-sumang@marvell.com>

On Tue, Aug 01, 2023 at 11:08:11AM +0530, Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan

Hi Suman,

unfortunately this does not apply to current net-next.
Please considering rebasing and posting as v4.

-- 
pw-bot: changes-requested

