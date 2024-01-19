Return-Path: <netdev+bounces-64389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C2832CB4
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A3B1C226FA
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05E54BC1;
	Fri, 19 Jan 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEXasTp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1C54BF9
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680143; cv=none; b=YxcGGeCqaRst74zNO34mWBI81xdTJuT49w5+21SzBENphkpEH1bzILUq/70qZ03b/b+ZDA5nWIn56UTrf/xn48U4j9KeedRftR2gKiL+tMXfks8g3+HMlLjM7LDqPolf+e7C4s/T7dulqaLN/JQFYrAngnl6bCP0xHoXKgmzHW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680143; c=relaxed/simple;
	bh=j99FGhsPkO0OdUev0nx6o0lc9b/hSGs9dBHLOK576NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkiCvrNSmFMBaSKSidWx5nbTGvYG6xwFnL8TvK2mX8jL7FvUTwGsmzz4wpHQL8EAMJBcJ8ry4HeArBWQ5GhJ4oViKjCZ/0jVIE7LlfrVTR9PDNMsno3xFhkE5pbsvOOHEmb95Z9qHLftW7JPX1GBTeIujsO55z7MXymAL3Q32+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEXasTp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCE1C433C7;
	Fri, 19 Jan 2024 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680143;
	bh=j99FGhsPkO0OdUev0nx6o0lc9b/hSGs9dBHLOK576NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEXasTp7IODwPDJCcr/saQ0HTTuJ6LL/sax4pFl7yesDohz1mj5FcnwUnZ3h5ExKU
	 w1ACeMJSYIb6O2z9urWVD+F8fTFOgdrgxMxZYlg4MMasSfqMajVGvhBJsRUbrH2fWT
	 uU4mLXxzkCO+vOyT97q0ylYF/1cJU0TLeHtvTbfnYSXSi1Me8YV/cQ9RvBmdncbdxd
	 5TsTnHMVGtbYxvt/FmlBxr1cBgyupwR6KhnMSVej/VdmMa4PX6ZAx7b6BRdUpmefgj
	 k4mD/PNxQKKEkRF/0kFr4ukg9+9Ajgj85gL2nls+Iflc1VV0aTCFjhNNKi87tx6k26
	 auCr3DxcLL2hA==
Date: Fri, 19 Jan 2024 16:02:19 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 3/3] ixgbe: Cleanup after type convertion
Message-ID: <20240119160219.GE89683@kernel.org>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118134332.470907-3-jedrzej.jagielski@intel.com>

On Thu, Jan 18, 2024 at 02:43:32PM +0100, Jedrzej Jagielski wrote:
> Clean up code where touched during type convertion by the patch
> 8035560dbfaf. Rearrange to fix reverse Christmas tree.
> 
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> @@ -771,12 +771,12 @@ static int ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
>  				      ixgbe_link_speed speed,
>  				      bool autoneg_wait_to_complete)
>  {
> -	bool autoneg = false;
> -	int status;
> -	u32 pma_pmd_1g, link_mode, links_reg, i;
> -	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
>  	u32 pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;
>  	ixgbe_link_speed link_capabilities = IXGBE_LINK_SPEED_UNKNOWN;
> +	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
> +	u32 pma_pmd_1g, link_mode, links_reg, i;
> +	bool autoneg = false;
> +	int status;

Hi Jedrzej,

In the new arrangement above autoc2 is used before it is declared.
Perhaps this could be:

	ixgbe_link_speed link_capabilities = IXGBE_LINK_SPEED_UNKNOWN;
	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
	u32 pma_pmd_1g, link_mode, links_reg, i;
	u32 pma_pmd_10g_serial;
	bool autoneg = false;
	int status;

	...

	pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;

>  
>  	/* holds the value of AUTOC register at this current point in time */
>  	u32 current_autoc = IXGBE_READ_REG(hw, IXGBE_AUTOC);

...

