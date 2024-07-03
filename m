Return-Path: <netdev+bounces-108972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9F926690
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E601C220A5
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D5A1836CC;
	Wed,  3 Jul 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkhk4eNj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6B17C9EE;
	Wed,  3 Jul 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025979; cv=none; b=bXeUciYdbOhd9nsU1iSp5kBenZ04/Bg8NRF704mHHS29ZNJ0yxTtoLuu3R13dJlVHvtQG2pCf9zcGsWX/cYEt5UN4zT+UTJq63JIxQgXlRREcy6hqPqt6g6D+YpPUDcLZn5zzAUyeoGhVZ0dgd4cpSmSKq+hlAMNWgIfXZp0e5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025979; c=relaxed/simple;
	bh=NFyM8QPRMkDVYC+NVystQN63yGnTmn1Wc1KCB4O+Y64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNt1OKuLEHihx3Mo+Dkr7jqdtmZgnRmHmcoK8PhOoJALtZlgvhEQj51cQ9DSPOMQ4hdrVC/WxLdcgfR00c8i+WNfjIUBaM2BRlliAa8MiHzieZqPBYh4Bg6u0Mud3oe9rBoBKSMnuRMVuuEQw86rx52SmoM7pT+2nYLb+x92KXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkhk4eNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E641EC2BD10;
	Wed,  3 Jul 2024 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025978;
	bh=NFyM8QPRMkDVYC+NVystQN63yGnTmn1Wc1KCB4O+Y64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkhk4eNjKgJzSlXrPcO7hJWoqxUP7FUEGiUkkLcGMG5KLw3rN0V0wd3+F13ffZeSY
	 PFhmmod8y0HD+fegztUsURNfzZsfV11pK1hNPk7jt0yZOQ6ePlz9kwP/fDphWRAcHT
	 8N9BT+T4RGXnXTzb0h7X6/MxkL3fu6BIBAz5AhGdEzA2imETgokOoNtik2cH35EsvU
	 rHfbafvDDRQfJn++G7JKgImTI7yeiMZJJ6PHlxWQ9JIZnzr12jgsTJ50HhFemvUo3b
	 LB2xoEeMANZpIoopuCl4vkjTsa1MjcxvBR3smp9pybYEh9HgZMPBuPHpuY/dqORxlI
	 NX3mUISgb/SPQ==
Date: Wed, 3 Jul 2024 17:59:33 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 03/13] rtase: Implement the rtase_down
 function
Message-ID: <20240703165933.GV598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-4-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-4-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:53PM +0800, Justin Lai wrote:
> Implement the rtase_down function to disable hardware setting
> and interrupt and clear descriptor ring.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


