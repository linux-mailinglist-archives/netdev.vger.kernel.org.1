Return-Path: <netdev+bounces-50280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D55F7F535F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 23:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD6B9B20D53
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36111CF8C;
	Wed, 22 Nov 2023 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj8eRfpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A68208A2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD2C433C7;
	Wed, 22 Nov 2023 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700692008;
	bh=WwfXqFdQODJ5eTAQRPCjbazPXFZyyOZtLQqG0NVTAI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mj8eRfpfYxI40HfwoISrzssx+kkuZA28UzQVDjZAc3lZ9iCJOMcbXgesxLQbEzNn6
	 u2RVu+eXC0ZBurldpJHEdydeXETb5MFr5lp0ZX2lrVQ3Jdga+H0cWALWU/aSsPLBxM
	 oHlVnuUYU3DKESBXE4PXBsMxvNmxGXO+T9wB/1cL2hF6yP1J/kv8qBsYb2ngsO35Ca
	 HKHh9M7fdPu2ehotCkRxBw1ZeK6Px2ZUn1Xwvwc1FjGU/OKXe6D0lsLa/QwYBGLFto
	 hVjkoDrkrNI1RryKQAjmhMsUuukS1H6TuZbBgI/+J91qZyqPkrCvLqggwlt2ftqJiz
	 wiSgMFuERNT7Q==
Date: Wed, 22 Nov 2023 14:26:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v2] netlink: specs: devlink: add missing
 attributes in devlink.yaml and re-generate the related code
Message-ID: <20231122142647.570426c8@kernel.org>
In-Reply-To: <20231122143033.89856-1-swarupkotikalapudi@gmail.com>
References: <20231122143033.89856-1-swarupkotikalapudi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 20:00:33 +0530 Swarup Laxman Kotiaklapudi wrote:
> Add missing attributes in devlink.yaml.
> 
> Re-generate the related devlink-user.[ch] code.

Try running:

make -C tools/net/ynl/

in the kernel tree. The C samples no longer build, looks like there 
are some typos in the spec.
-- 
pw-bot: cr

