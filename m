Return-Path: <netdev+bounces-95696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3448C31C2
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50DC1C20B65
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA7535B8;
	Sat, 11 May 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLImxu8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0A06FC6;
	Sat, 11 May 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715436642; cv=none; b=ewJWrk/1bjPHlKoe3QdPWpCKGsissrwq1MSUcm+RWtnbcXeQZ8enjkY1Zqh7a3oRCQCpIUx2/J1yb7zOWsf5ES44zB2QWH7bziOCpg28zZnMb5S7zFy0wSVy5uoEQzrcQkaLHhOo9rxoI5VlFyIRQeWfSnj9mlEJUYAXlxWOq5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715436642; c=relaxed/simple;
	bh=zD5fChJ3hY7Vmh3mn4DutQ/zNAJcBuVvGUeGdpCzZ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0XmCQIT447QCXYMTcIUgwgsqTG5/kFawHmK1UadCKI+YT27JXE3EqDAB5a3A7YK9BPomZpVuR58G5/C6+sS3MJA0Vc4GmqkF5c6m3cFMHy/8z5HFLg2iKvVHsGmvS4OjkwVQG9LM0134Ltm6eR+ar868zVFpTmgZ00KusL0aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLImxu8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47DC2BBFC;
	Sat, 11 May 2024 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715436642;
	bh=zD5fChJ3hY7Vmh3mn4DutQ/zNAJcBuVvGUeGdpCzZ5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLImxu8ACnlb783mu9dsXGyEYmPsjqZH2+9wZnUrkFcH5PSKNwPGXtMcf40Ty6jDC
	 3WMfMAhe0s4E/hArSsdoSvTIk2jSWAxAqAKUEzH8Gge1Ey1V566lINOFPPzzyidBRW
	 9iQoWWLL7/UzAJajSWNhYynl/yExAP8f/rfWBLrHdUtjWtORtt2caYH/C0Wndn65vk
	 C/vNe69SwXUt7orpUHNtSyR4fjyTVPbHWyDOsu7G/siDPgyA9qPnZZNqZAkwpxyjJf
	 UquyN/e05Ple1A3vfLpdu2Jn4NAR5KBWJmuY8Ivk9qJ2BLoBJpLOZgaPeiByjHP8n5
	 5Nrub4l79alvw==
Date: Sat, 11 May 2024 15:10:36 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v4 03/10] octeontx2-pf: Create representor netdev
Message-ID: <20240511141036.GG2347895@kernel.org>
References: <20240507163921.29683-1-gakula@marvell.com>
 <20240507163921.29683-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507163921.29683-4-gakula@marvell.com>

On Tue, May 07, 2024 at 10:09:14PM +0530, Geetha sowjanya wrote:
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

...

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> index 33ebbcb223e1..ff4318f414f8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -28,6 +28,157 @@ MODULE_DESCRIPTION(DRV_STRING);
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
>  
> +static int rvu_rep_napi_init(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> +{
> +	struct otx2_cq_poll *cq_poll = NULL;
> +	struct otx2_qset *qset = &priv->qset;
> +	struct otx2_hw *hw = &priv->hw;
> +	int err = 0, qidx, vec;
> +	char *irq_name;

Please consider using reverse xmas tree - longest line to shortest -
for local variable declarations in new Networking code.

This tool can be helpful: https://github.com/ecree-solarflare/xmastree

...

> +int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
> +{
> +	int rep_cnt = priv->rep_cnt;
> +	struct net_device *ndev;
> +	struct rep_dev *rep;
> +	int rep_id, err;
> +	u16 pcifunc;
> +
> +	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev *),
> +				  GFP_KERNEL);
> +	if (!priv->reps)
> +		return -ENOMEM;
> +
> +	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
> +		ndev = alloc_etherdev(sizeof(*rep));
> +		if (!ndev) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack, "PFVF representor:%d
> +					       creation failed", rep_id);

gcc-13 seems unhappy with a string spanning multiple lines.
I suggest living with a line longer than 80 columns in this case.
Maybe:

			NL_SET_ERR_MSG_FMT_MOD(extack,
					       "PFVF representor:%d creation failed",
					       rep_id);

> +			err = -ENOMEM;
> +			goto exit;
> +		}

...

