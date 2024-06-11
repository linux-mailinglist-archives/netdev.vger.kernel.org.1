Return-Path: <netdev+bounces-102431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9F902E9E
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD6C1F21ED5
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB016F85D;
	Tue, 11 Jun 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQTsI11q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FE8286B;
	Tue, 11 Jun 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074459; cv=none; b=fx/PLyLVAmn9D5+mLAuIPHRlULe4f8TeYTeV/QS4BWy5a6FyVs/uH1TIfGNZ9BGxGySdH0/mRtrNenBeY4DibLyvy7oTLVyu7W1Rv2zNNjnTP8S9QmoE4FnV+FR8RFMG9CLzy4OQ7ID7gq77DVMRBu1lenNZRcj8Tg/sW3nKGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074459; c=relaxed/simple;
	bh=BACHajv8XfvegwB5hT1c4hcnhBTRLgPvz/ukzBeVJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geE6dGHCxJ0x4LfOF4sKUGl6k1MygAc7a4Z3gJX/FzlVV3HK7AZtrn8z2fUuoqur8CWuxhYDtr7n6t4RNInwz41hFSa4EUHLjXboETdz+bYWf6M4YFl657ZZDlJlvdtODBcv47Lk63c9uc8dyxAnDAWh+pgANFyhWlpAcyIf3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQTsI11q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804F1C2BBFC;
	Tue, 11 Jun 2024 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074459;
	bh=BACHajv8XfvegwB5hT1c4hcnhBTRLgPvz/ukzBeVJGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RQTsI11qBbrzc8MjOJ+YV2bzWi4FqNKyLiyaFws5E60kxRiFZt8fe4Hu50qMwnymD
	 ZKZhIRLv42LnU55YT/ERC7Cl8lMYpR4cysJqz3gLdoMABDMsn+a8bUsPZ8GUPfCSJ0
	 JDoDZt5bZR65MBw2w7MMrcePJRRXQOPrhfSgnl5t6anBgNCvfIeLNZs232lDWzUtMU
	 JhpMXVdl3kD0GKUmsCjSTKhnN63YCAZP40LCBh2RHZE1vQWkdR2IpF0/UHkULTjf/J
	 HGKAdIbL+zAdX8DNwsmMRBayvXha2C4dfRya+wlobCz2NotHc2BVJ6z0QwrBrbC25M
	 noJEzNS0t7TFQ==
Date: Mon, 10 Jun 2024 19:54:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Edwin Peer <edwin.peer@broadcom.com>, Michael Chan
 <michael.chan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>, Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH net v2] bnxt_en: Adjust logging of firmware messages in
 case of released token in __hwrm_send()
Message-ID: <20240610195417.693fb12e@kernel.org>
In-Reply-To: <20240609070129.12364-1-amishin@t-argos.ru>
References: <20240609070129.12364-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Jun 2024 10:01:29 +0300 Aleksandr Mishin wrote:
>  		hwrm_err(bp, ctx, "hwrm req_type 0x%x seq id 0x%x error 0x%x\n",
> -			 req_type, token->seq_id, rc);
> +			req_type, le16_to_cpu(ctx->req->seq_id), rc);

The alignment with the ( looks messed up

