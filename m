Return-Path: <netdev+bounces-129439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26874983DA6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04EE2845E5
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 07:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CC3145A18;
	Tue, 24 Sep 2024 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf7qzpNe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B11448DC;
	Tue, 24 Sep 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162142; cv=none; b=BheUaJjjG4evXq7i2JzpPHUyjQ2XbsQTb2dZcJ5r6jVgqsk1PdZy+jmiBLuez13XinWtmdorkv4IURCaXxCi7PY1WtMuDPAbBbR7n+mNtCQ8MUcyaErMt1XeXwLdk7C7//pm+G/lsuT6aR3IPF8zgVgkTHn+n7nHef1XG7oTEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162142; c=relaxed/simple;
	bh=+3WJUhhtf5BZnaLhD5R1AYzUor/yGx2LgUXKhT+ewAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krk6dcYZ81y9x+KkW7ZXRmFP4tifFcJUE0aJ81TVyhvDW9tJNi1GgrsiqKdXoQmFPYon4nDUt6xjuJQdDQXmpwYEUF9bJe2pvoJA64u86D2lSG7OSO4Ghxy7634j4KWZa/8sIdGr/4O2dBzw0LMgZEu8K8fUxKRolhqbrm4t8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf7qzpNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74605C4CEC4;
	Tue, 24 Sep 2024 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727162141;
	bh=+3WJUhhtf5BZnaLhD5R1AYzUor/yGx2LgUXKhT+ewAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lf7qzpNeQemiYgC2PW3vgA2ell1wHs3qgY509b/3p/HMf0FZEFG/gyi3Iv6Zgooj5
	 s0tmKiqfJTKFvdPIGOTqqLerhaen8cBDRC7n63De+nvPOePEIiYud5RMujEn6Zl1wx
	 lL/nAgP+rbcF7OxcsK38Y51eNXostlU7lW/7NP8d4xVw6+SbQjog44VXG/rbgRpges
	 pdimngUa7TaNAE84ufMKTzmuvVgtsFO0+RlRDXPTpzXu84+I5Waqq2ve9GNIP1ihGa
	 rvo2BmHkh+UMxHcTqiUVWQ9Fk7Rxmw//GFvtIQVtRDjJGOGwSMIwt4EGySKWZLZLvn
	 BqPXjdwK5NMxA==
Date: Tue, 24 Sep 2024 08:15:37 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v2 net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_common.c
Message-ID: <20240924071537.GC4029621@kernel.org>
References: <20240923161738.4988-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923161738.4988-1-kdipendra88@gmail.com>

+ Maxime Chevallier

On Mon, Sep 23, 2024 at 04:17:37PM +0000, Dipendra Khadka wrote:
> Adding error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> ---
> v2:
>  - Added Fixes: tag.
>  - Changed the return logic to follow the existing return path.
> v1: https://lore.kernel.org/all/20240923110633.3782-1-kdipendra88@gmail.com/
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++++
>  1 file changed, 4 insertions(+)

Hi Dipendra,

Thanks for the updates,

I agree that this addresses Maxime's changes.  I've CCed him here, please
consider CCing people who comment on earlier revisions of patches.

My only nit about this patch is that, as per mo comment on [1], I think the
prefix in the subject should be 'octeontx2-pf: '.

[1] https://lore.kernel.org/netdev/20240924071026.GB4029621@kernel.org/

> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 87d5776e3b88..e4bde38eebda 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1837,6 +1837,10 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
>  	if (!rc) {
>  		rsp = (struct nix_hw_info *)
>  		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> +		if (IS_ERR(rsp)) {
> +			rc = PTR_ERR(rsp);
> +			goto out;
> +		}
>  
>  		/* HW counts VLAN insertion bytes (8 for double tag)
>  		 * irrespective of whether SQE is requesting to insert VLAN

-- 
pw-bot: changes-requested

