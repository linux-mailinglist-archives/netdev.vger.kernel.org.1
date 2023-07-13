Return-Path: <netdev+bounces-17411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F87517F0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40306281B3E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC16539F;
	Thu, 13 Jul 2023 05:19:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1C1FCF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5EFC433C7;
	Thu, 13 Jul 2023 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689225580;
	bh=UORb9mc0lGDf75zSOdKYCgMV7oZNdLKIXMMWW6q0N5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j6g+cCZs+khGuIxRz84uliHvE461LQgBMfHoehprB45BRCFOqLRQ/Icmy2VmsAhZL
	 Ckl8k9B6eUph1LLJCgh07g/gYX4e3/OqwK17L+iuCuCU7SkdKVpMhIC6ao17qVea+T
	 Hv8CO//9N4HOKsI5feWg5cfFI5n9Y8/dG+q/w27h3CES8TUENYCpm7Tbi8jZoy2XKw
	 4EwWw+RhLGA4pYKNuXkMYZLKUm5u76b2HnhzsKJEQSdZq9DVFThBqLL7+ffKD61uqa
	 K00MjFdCXYqoMKmnwE2xGBElrZ4cRPiDoIyfgAeCyO2ZI8Ay4g4/ZxmmC/ZMY0IyZP
	 1pk1dEFyRiV9Q==
Date: Wed, 12 Jul 2023 22:19:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 1/3] octeontx2-af: Fix hash extraction mbox message
Message-ID: <20230712221938.0ae4374e@kernel.org>
In-Reply-To: <20230712111604.2290974-2-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
	<20230712111604.2290974-2-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 16:46:02 +0530 Suman Ghosh wrote:
> As of today, hash extraction mbox message response supports only the
> secret key. This patch adds support to extract both hash mask and hash
> control along with the secret key. These are needed to use hash
> reduction of 128 bit IPv6 address to 32 bit.

What are hash mask and hash control?

Why is this a fix and not a new feature / extension?

