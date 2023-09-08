Return-Path: <netdev+bounces-32674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8496B79917E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 23:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89D4281C49
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6A830FB8;
	Fri,  8 Sep 2023 21:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3A30FB3
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 21:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3E8C433C7;
	Fri,  8 Sep 2023 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694208442;
	bh=DmwIh27VDJqYmJb/+d1zU+KcpsagMmGvhv7EnakglH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZEv0QUo17xhBx8KfSKasISAvcZO4zmj2nkOeV/sIbcwycOYPKZXD6Sb2w9usmCdP
	 mIbSvpVWzgML7PryBR44cUpATJWEpE+L4dWx2Tnp+qxIQ59HnHLUbU7yIyLPUjkTE7
	 qVmjKmRSWwJtettgCY7snXw1QHQjipgoal6yFEu8HKKUOsvJlWKs9qMMIuNXU2xMxE
	 ixPH6EA8zvmSp1ry/9dYrkZcbKPuTYGMdR3964aJb/lR+ceFj62rKX4dOUPfwBYYBK
	 0HLxTt+PyZQZAIldnv2kvDaGKqm+7cSqHNn+9Ibc5gB1zG7JohfnRQgYaWNMtbowqr
	 woFiY0i4VQSPg==
Date: Fri, 8 Sep 2023 14:27:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jiri Pirko
 <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, jiri@resnulli.us, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.5 02/45] devlink: remove reload failed checks
 in params get/set callbacks
Message-ID: <20230908142720.1b66b853@kernel.org>
In-Reply-To: <20230908181327.3459042-2-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
	<20230908181327.3459042-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Sep 2023 14:12:43 -0400 Sasha Levin wrote:
> Therefore, the checks are no longer relevant. Each driver should make
> sure to have the params registered only when the memory the ops
> are working with is allocated and initialized.

Not a fix.

