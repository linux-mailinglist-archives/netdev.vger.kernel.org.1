Return-Path: <netdev+bounces-211027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D729B163EC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B121702AB
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABE0192D6B;
	Wed, 30 Jul 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nskOhZaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56957C2C9
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890818; cv=none; b=T9oCXbJtEt5iDTq2/zpJeS+boze5bOC4bTdZgDXHvierME8dEGi/xa8RbqWEWhKxayD904rXXWvXaG1oDW9DvAKtsyRTZJY+J/0XiUMmH+NKjR7/VOFcBz9oS8y5EBI5vXgBzutXsxjeTn3hFDEJNxrHLs8Y2M5ym79ZJ/xVsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890818; c=relaxed/simple;
	bh=qm14rsLPIwEBCD2eaCO9J84G5ClWgITQ8doS3N1jx80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9equN7q4Q/YobIbhEInVAagO9YXvuVTjqSFcEK4n6rDScDVg0pjqzfX9Ma1HCN+GJ3ZVI8wN1ZKkx5iy/OwheCjXL5Ld7S9vpLBqSUpI1rorVyS0P6t7jo4CUWw39j2EhLzft1fiDLCRrHaShf6ARAO+PbOR2Prw7ZkcgZid30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nskOhZaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB900C4CEE3;
	Wed, 30 Jul 2025 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753890817;
	bh=qm14rsLPIwEBCD2eaCO9J84G5ClWgITQ8doS3N1jx80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nskOhZaPP4A8r9ye04+aw+a9sx2BDcCj7igCM9GF0YzDQUmL+2/rzEc0iWjap8v7n
	 atrrTz0F5aTfukf07PJyuuNqCtgAxRxthGjqGiuv6WzHkJ2wBbibhLurzfg/oCGg7U
	 JO9Wwr4DHTmQWipWEMqirV7PnimxcA78Lw1wTCEGjdY5+lzsaBmpzoB8hXaj9PsV+y
	 CTjPJIBlkbT+wjTG1qGBtPtDzGViAyap4Ci4ok3pMUIXE4FVj5rh9PSLwsGZjYdRyJ
	 y7cCrpGpBct2NzJTFDAlBtXSZFr9riOF2jhNMAKJQVHC/5jzyPMy3PT8NXlagKhjfq
	 KB3kf8F8xJR5A==
Date: Wed, 30 Jul 2025 16:53:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] ixgbe: fix ixgbe_orom_civd_info struct layout
Message-ID: <20250730155334.GK1877762@horms.kernel.org>
References: <20250730145209.1670909-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730145209.1670909-1-jedrzej.jagielski@intel.com>

On Wed, Jul 30, 2025 at 04:52:09PM +0200, Jedrzej Jagielski wrote:
> The current layout of struct ixgbe_orom_civd_info causes incorrect data
> storage due to compiler-inserted padding. This results in issues when
> writing OROM data into the structure.
> 
> Add the __packed attribute to ensure the structure layout matches the
> expected binary format without padding.
> 
> Fixes: 70db0788a262 ("ixgbe: read the OROM version information")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> index 09df67f03cf4..38a41d81de0f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
> @@ -1150,7 +1150,7 @@ struct ixgbe_orom_civd_info {
>  	__le32 combo_ver;	/* Combo Image Version number */
>  	u8 combo_name_len;	/* Length of the unicode combo image version string, max of 32 */
>  	__le16 combo_name[32];	/* Unicode string representing the Combo Image version */
> -};
> +} __packed;

...

Hi Jedrzej,

I agree that this is correct. Otherwise there will be a 3 byte hole before
combo_ver and a 1 byte hole before and combo_name. Which, based on the
commit message, I assume is not part of the layout this structure
represents.

A side effect of this change is that both combo_ver and elements of
combo_name become unaligned. As elements combo_ver does not seem to be
accessed directly, things seem clean there. But in the case of combo_ver,
I wonder if this change is also needed. (Compile tested only!)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 71ea25de1bac..754c176fd4a7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3123,7 +3123,7 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
 	if (err)
 		return err;
 
-	combo_ver = le32_to_cpu(civd.combo_ver);
+	combo_ver = get_unaligned_le32(&civd.combo_ver);
 
 	orom->major = (u8)FIELD_GET(IXGBE_OROM_VER_MASK, combo_ver);
 	orom->patch = (u8)FIELD_GET(IXGBE_OROM_VER_PATCH_MASK, combo_ver);

