Return-Path: <netdev+bounces-247562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C1CFBB26
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86F9303E674
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA34284665;
	Wed,  7 Jan 2026 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpMEZrXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FEF283C82
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752116; cv=none; b=VNVvJbmEKI3tblxS6ICbf9IUPcRqc/upqH3jPSDmoH/Bh/nQDFIzJOBTjZa65PhcC6ku8w3a2IzEPGkRP8kHFQMaKb3bmleaScxszcV+kWXUSFMIqlgOfffgxAAxkaHIMEiVSxLlDXUQTk6i2C+7i92agJSMQUkCD8VIjGwguKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752116; c=relaxed/simple;
	bh=iEdfXCVIDG2db/BN5yptdxGxwWUtHuKA0Ok1eRnLKtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOobtTSIKGFTNfL9WPUavf5ya1A395qIUVrxxeZUcdo/ZmDw+FkOzLbBpwHcMeYQI3XwyqdMx8ZoBGqjUWR+wlqCmZE9OS110uwiI9f/TV07S5mz5JlXZf+dwzA4FZRQ2c60CKRRu9NVLmMHJn8lCiixpU85bXy72/Nu2NKwEms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpMEZrXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05923C116C6;
	Wed,  7 Jan 2026 02:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767752114;
	bh=iEdfXCVIDG2db/BN5yptdxGxwWUtHuKA0Ok1eRnLKtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HpMEZrXVjL6DiDuYYFVc6r4iccHmX7LI78K9PfG9I+qiDPIQadH8g2zuEoZSSCrDF
	 He0wTuG/qKlHmMeDk1BP/sFqLh61JSaM8FyZhdCCfWpl+kF6icLP4p/yYQtCg4dzpx
	 fDQe1SR4dl0dD3hadX/biWO9dSgPztpQ9Hh1u4TTugdPp4hjJM5oYQ0Swgi5vmNCDy
	 ccC/awhGqkhNFZpnFi5ryqVEBoy4QVV+fHX/IctDX5JRfpXKlSRDTaebMRTmgl1iRH
	 pyskWEfjpsRS+mI6+ky1qg2gmgrufIO+VC14DTFK4+Dai3sMtl9ePp26nOD37wXPC0
	 A1rHTpxp3hlqw==
Date: Tue, 6 Jan 2026 18:15:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 6/6] bnxt_en: Implement ethtool_ops ->
 get_link_ext_state()
Message-ID: <20260106181513.48e8f218@kernel.org>
In-Reply-To: <20260105215833.46125-7-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
	<20260105215833.46125-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 13:58:33 -0800 Michael Chan wrote:
> +static char *bnxt_link_down_reason(struct bnxt_link_info *link_info)
> +{
> +	u8 reason = link_info->link_down_reason;
> +
> +	/* Multiple bits can be set, we report 1 bit only in order of
> +	 * priority.
> +	 */
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_RF)
> +		return "(Remote fault)";
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_OTP_SPEED_VIOLATION)
> +		return "(OTP Speed limit violation)";
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED)
> +		return "(Cable removed)";
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT)
> +		return "(Module fault)";
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_BMC_REQUEST)
> +		return "(BMC request down)";
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_TX_LASER_DISABLED)
> +		return "(TX laser disabled)";
> +	return "";
> +};

spurious ;

> +static int bnxt_get_link_ext_state(struct net_device *dev,
> +				   struct ethtool_link_ext_state_info *info)
> +{
> +	struct bnxt *bp = netdev_priv(dev);
> +	u8 reason;
> +
> +	if (BNXT_LINK_IS_UP(bp))
> +		return -ENODATA;
> +
> +	reason = bp->link_info.link_down_reason;
> +	if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_CABLE_REMOVED) {
> +		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_NO_CABLE;
> +		return 0;
> +	} else if (reason & PORT_PHY_QCFG_RESP_LINK_DOWN_REASON_MODULE_FAULT) {
> +		info->link_ext_state = ETHTOOL_LINK_EXT_STATE_MODULE;
> +		return 0;

Please extend the uAPI to add the missing codes. None of the strings
you're adding look very Broadcom specific to me. And there's a code 
for Remote Fault already.

