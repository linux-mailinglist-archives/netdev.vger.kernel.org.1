Return-Path: <netdev+bounces-18726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEC758629
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D25028171B
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732EA1641A;
	Tue, 18 Jul 2023 20:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1F154B3
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68808C433C8;
	Tue, 18 Jul 2023 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689712707;
	bh=k0PounCfLuAZPM9E0vlfC9GUV2WhU2Rz0BjcWP0QwFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u48RxaSeBEEnMV2TkHa8sVNbmPXk70JYdBrDRUKsyCybPeAw/k/0SZrUBZJCDuce9
	 WrGgXR7H3sHFD8czIqDln14EXzXgMKDEryNMmoc5uCdRM3xJqF7+jiz3kYym3j3LQH
	 ab01MVo2XuasrbgGruTzE4qi6ciBEJ0+uIQS/UWxx8ToRGOhhapTGPFcKRdLqqVcmw
	 8E8j+3gjN007C3bFE6ATvRoZ1Cxz0jH4PLA5dFiJY84CrgXq3eAkWTnhRNt4yFE7/j
	 sZUSl6KXPJzAjOrBmmtN5wh9fhoncn1io1kKxf78ir/KS9iRPDCyffBVOd2RB+Voaq
	 1xBLsigoDC52w==
Date: Tue, 18 Jul 2023 13:38:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH V2 0/3] octeontx2-af: Fix issues with NPC field hash
 extract
Message-ID: <20230718133826.09db812c@kernel.org>
In-Reply-To: <20230714071141.2428144-1-sumang@marvell.com>
References: <20230714071141.2428144-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 12:41:38 +0530 Suman Ghosh wrote:
> This patchset fixes the issues with NPC field hash extract. This feature is
> supported only for CN10KB variant of CN10K series of silicons. This features
> helps to hash reduce 128 bit IPv6 source/destination address to 32 bit(also
> configurable) which can save 96 bit and can be used to store other key information
> during packet filtering.

For better or worse these patches seem to have already been merged
in May. Why are you resending this?

