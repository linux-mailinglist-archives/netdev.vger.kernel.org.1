Return-Path: <netdev+bounces-307101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RjXLGfGtVGpepQMAu9opvQ
	(envelope-from <netdev+bounces-307101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:20:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C24A77493CD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:20:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=l28QzEYu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307101-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307101-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8B63045492
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E33D954C;
	Mon, 13 Jul 2026 09:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD91368D4B;
	Mon, 13 Jul 2026 09:16:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934195; cv=none; b=E6jqmEZ4L4J/VO+4PAOS9QrbJ3jyqaMtKTcMm4sxkNIWKkDKC4a/rljyDaW/oK7h1eaVB+B2eJsq+LM028krTDFHAv4a9Ji3uCzpelO+wUB31pEBLTbHIk/yEElpge/4SoyxFEOytuFH+yS1yUhQrMw2PxAWhxsamP22kEsarWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934195; c=relaxed/simple;
	bh=zyF231xatrpSZ32MNA32jgQliAUCizy7L4S9+SYQy9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DobNERmBJKmpJOR9s1Z7Jdxwa65cvloTW2IuSKhy2nbJ7KDj1zecZHa4xWFW/UTfkByIbzmdu+oH9skmCUBHXlBfoxiP8CwFsGz51BKWxvfAJnjJBBrusFq/y5KfoPko0qsXgr55FW96xgaDV80V5n8txLfvLTkqT5qW18vE4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l28QzEYu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A721F000E9;
	Mon, 13 Jul 2026 09:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783934193;
	bh=5siJLG0LOwXZuo10jBFt4fMZPIUJHqjzh+luwyjmAXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l28QzEYuqIxm8425yFC4+/OlfyHCjpMbHkVM4n55jZRRNGraF61E6PUfOfjMvqNPg
	 1PRV8ZsrPmGGWCkKBfzGi8f+WGh9hFpAk2CWiHQFs+MojCfDBavqzPRn5GEKtIzhKK
	 cdXTO51kUqUWY0Q++mhZVX8qtwMjBV6olzEXrvXL5kOsJrPAXb4qB12rViEdtgkbxW
	 /+OAjpUoW0E36npC8mWza+l8SpD+l/1Aw2WObkjoSuvrr+HMxCjnec1fghFzPJRwjC
	 g9gQSByClPjI/7FS6jGUzP7MJ6kOnJkReQG/JF/gJ52hYLheFM6/F1zcrgMLDlXPBx
	 zkxOiTwRjE0Vg==
From: Simon Horman <horms@kernel.org>
To: pengpeng@iscas.ac.cn
Cc: Simon Horman <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jedrzej.jagielski@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	arkadiusz.kubalewski@intel.com,
	karol.kolacinski@intel.com,
	sergey.temerkhanov@intel.com,
	michal.michalik@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ice: propagate ETH56G deskew read errors
Date: Mon, 13 Jul 2026 10:16:06 +0100
Message-ID: <20260713091605.1756659-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706144325.91320-1-pengpeng@iscas.ac.cn>
References: <20260706144325.91320-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307101-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:horms@kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:jedrzej.jagielski@intel.com,m:aleksandr.loktionov@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:jacob.e.keller@intel.com,m:arkadiusz.kubalewski@intel.com,m:karol.kolacinski@intel.com,m:sergey.temerkhanov@intel.com,m:michal.michalik@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,lists.osuosl.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C24A77493CD

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: propagate ETH56G deskew read errors

ice_ptp_calc_deskew_eth56g() returns a u32 deskew value, but it also
returns the negative read_poll_timeout() error when the DESKEW valid bit
never appears. That converts the negative error into a large unsigned
deskew contribution, which can then be folded into the RX timestamp
offset and programmed into hardware.

Return the deskew value through an output parameter and propagate the
read error from ice_phy_set_offsets_eth56g() instead of using it as
offset data.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 8e5f97835954c..cc424518a2a67 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c

[ ... ]

> @@ -1736,17 +1736,21 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
>   * @ds: deskew multiplier
>   * @rs: RS-FEC enabled
>   * @spd: link speed
> + * @deskew: output parameter for the calculated deskew value
>   *
> - * Return: calculated deskew value
> + * Return: 0 on success, negative error code otherwise
>   */
> -static u32 ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
> -				      bool rs, enum ice_eth56g_link_spd spd)
> +static int ice_ptp_calc_deskew_eth56g(struct ice_hw *hw, u8 port, u32 ds,
> +				      bool rs, enum ice_eth56g_link_spd spd,
> +				      u32 *deskew)
>  {
>  	u32 deskew_i, deskew_f;
>  	int err;
>  
> -	if (!ds)
> +	if (!ds) {
> +		*deskew = 0;
>  		return 0;
> +	}
>  
>  	read_poll_timeout(ice_read_ptp_reg_eth56g, err,
>  			  FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i), 500,
>  			  50 * USEC_PER_MSEC, false, hw, port, PHY_REG_DESKEW_0,
>  			  &deskew_i);

[Severity: High]
This is a pre-existing issue, but is the return value of read_poll_timeout()
supposed to be checked here?

The read_poll_timeout() macro returns -ETIMEDOUT if the condition is never
met, but this return value doesn't appear to be assigned to any variable.

The err variable will only hold the result of the inner function
ice_read_ptp_reg_eth56g(), which might be 0 if the read succeeds but the
VALID bit is not set.

Will this cause the function to proceed as if successful, ignoring the timeout?

[Severity: Medium]
This is a pre-existing issue, but could deskew_i be read uninitialized if
ice_read_ptp_reg_eth56g() fails?

If the read fails, err receives the error code, but deskew_i may remain
uninitialized. The loop condition in read_poll_timeout():

    FIELD_GET(PHY_REG_DESKEW_0_VALID, deskew_i)

will evaluate this uninitialized memory.

Additionally, since the loop condition doesn't check if err == 0, won't
this pointlessly spin for 50ms on hard read failures instead of aborting
early?

>  	if (err)
>  		return err;

