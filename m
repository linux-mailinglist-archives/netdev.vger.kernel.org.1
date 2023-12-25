Return-Path: <netdev+bounces-60211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA681E1E0
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371111F22297
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03152F8E;
	Mon, 25 Dec 2023 17:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvWbA15p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430453809
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B39C433C8;
	Mon, 25 Dec 2023 17:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526290;
	bh=xPrfmFJ7lJ66hoewyjrRMWiUehb49/stRvTGJlxqbU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvWbA15p1gzLvTLxKnV6LQRhhXluPhhZM1hlFV1+Bo2yNeB07MgAvksTFTm7b0PM0
	 tmzGyn99PT2RhSyptJnNEb07Th2X8BnE9uAnZj1ITbCS6CUt2Cy8GI4F4H5xv3iF/V
	 G8tNIYs2Ziosj6yXiWWeQWBfBKcvPvmcYHRMLkEGcbJ4gcE1fAVZqJodsXKEYw2OST
	 mxFbR03T0VRfkRyEitEUNmsfGMDmIi+K8ctJig0AUq7HpAMctljtwz02AUJZwfVcnu
	 pIykzZbJMT3nfKCIKSZYmGWbqEJxJok9iA4Ea21SQqEmxLm/6+fkzaQw7H53750U3w
	 9CXLPqyNUEdug==
Date: Mon, 25 Dec 2023 17:44:46 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 02/13] bnxt_en: Add bnxt_l2_filter hash table.
Message-ID: <20231225174446.GO5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-3-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:21:59PM -0800, Michael Chan wrote:
> The current driver only has an array of 4 additional L2 unicast
> addresses to support the netdev uc address list.  Generalize and
> expand this infrastructure with an L2 address hash table so we can
> support an expanded list of unicast addresses (for bridges,
> macvlans, OVS, etc).  The L2 hash table infrastructure will also
> allow more generalized n-tuple filter support.
> 
> This patch creates the bnxt_l2_filter structure and the hash table.
> This L2 filter structure has the same bnxt_filter_base structure
> as used in the bnxt_ntuple_filter structure.
> 
> All currently supported L2 filters will now have an entry in this
> new table.
> 
> Note that L2 filters may be created for the VF.  VF filters should
> not be freed when the PF goes down.  Add some logic in
> bnxt_free_l2_filters() to allow keeping the VF filters or to free
> everything during rmmod.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


