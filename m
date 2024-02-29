Return-Path: <netdev+bounces-76019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAA386BFE7
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F92286BCA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B01374DD;
	Thu, 29 Feb 2024 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjBOyHpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7FE812
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181299; cv=none; b=lQIlx+ClZP9XLq0I4kOx9KA1gByTPXDVI6EMl9PL75lIH6sECTZtfM8OF2A5jamujldNoWouIgyCFDKHdzjVemgFGTDV41YuQMQw6bzVp6Mmd8I0fDkXo06PHovwD6vYVUM+3Ze1gAmpewc/NbfVPHTXec/+fP/zppLTDfREFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181299; c=relaxed/simple;
	bh=im9nHjJzac++4GCL+wt2hEj2xXBI86hfXDYb3AicNhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB7C9C8/X94vivjQwlCOEMGCVHOVw7O4fTQB+fZC2/j2sWejX2VK114IKy/YNzped53+iwRBX3uIjQuw2z/2h7xJSppv9cUruDdpUFTKkURiEmfZpDWlXgxx6Wbt+6aUTrwk8C3YCrUl5KRX0n74MXCJLV69haJeSbHWBG6HLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjBOyHpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08626C433C7;
	Thu, 29 Feb 2024 04:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709181299;
	bh=im9nHjJzac++4GCL+wt2hEj2xXBI86hfXDYb3AicNhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SjBOyHprl+681rw6LSnlLjkwA5sXGKD8seEy65K552aXKhMBDm77FKLO11hNgZ87Y
	 3Il1B/Z83sNdIYv9yha/bGPzyOIuDeqQXoD+zvi3NaehbJS6oRY1N1/OyVJJ+kbi3z
	 ONkoeC8o3CfxZSxD2EUqGeo6OQzKV/EVWDq09J8cIz6Ck7hQItBnZ6Nz/NCJsHYxZY
	 bAyqSGxSGmpYrMS6GNHY9iRJC8p3clmvW5ImZ+kc/xq5qQjhKJSNgCYZB/QhrrtcLB
	 NWRdZUwYFfeqdV9fpchG2RaSd88RdCQ/fotobRSKzdvTdEQby50GcJ6MbLUZnCAnau
	 SdIynwqHj6zqg==
Date: Wed, 28 Feb 2024 20:34:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Fei
 Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
 oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 2/4] nfp: update devlink device info output
Message-ID: <20240228203458.4a7234f5@kernel.org>
In-Reply-To: <20240228075140.12085-3-louis.peens@corigine.com>
References: <20240228075140.12085-1-louis.peens@corigine.com>
	<20240228075140.12085-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 09:51:38 +0200 Louis Peens wrote:
> +   * - ``part_number``
> +     - fixed
> +     - Part number of the entire product

Belongs in the previous patch..

>     * - ``fw.bundle_id``
>       - stored, running
>       - Firmware bundle id
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> index 635d33c0d6d3..5b41338d55c4 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_devlink.c
> @@ -159,7 +159,8 @@ static const struct nfp_devlink_versions_simple {
>  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,	"assembly.partno", },
>  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_REV,	"assembly.revision", },
>  	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MANUFACTURE, "assembly.vendor", },
> -	{ "board.model", /* code name */		"assembly.model", },
> +	{ DEVLINK_INFO_VERSION_GENERIC_BOARD_MODEL,	"assembly.model", },

Ah, it is the code name. I don't understand why you're trying to make
this generic. I never seen other vendors report code names for boards.

