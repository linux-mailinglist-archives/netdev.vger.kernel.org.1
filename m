Return-Path: <netdev+bounces-300476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZHUcODwQNGoYNAYAu9opvQ
	(envelope-from <netdev+bounces-300476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:35:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C226A1464
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:35:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BMiqxNAN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300476-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300476-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2813015899
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC43242BE;
	Thu, 18 Jun 2026 15:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B228690;
	Thu, 18 Jun 2026 15:34:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796884; cv=none; b=i/nTtxeBVau5scFVxz8wBEzMoTAUc6+ATabGb9B1PY8HxI9xQHZgpYGM9uUhGbOih6NY01T+CejDz7WYVoMU980s7ih9SVaUdZPrLd2xItIn6B9i35vmAccgL4rStqdNOnhZDaiEz7FlsdhZRdc86W8+1DP809P3rG/o8MCEUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796884; c=relaxed/simple;
	bh=YdIOd05NYnaVdja/vE3HNhUA081qUvBnA1pScLNqSIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDQ9MUdoiMJA3e4LNnqT4vjjMBCy1U7wYH+YNgdt0JcNWjMfG6aBUvLkvPb8nEn4gvL4buqZdLYvknvtJMkAAqmSsvn+4KkA1brT8SOWmjYE7TMkH/qvEHKEf6gBI6ykk+QOwIkGk3QxK7bzZ783qzxmRi/XXXo8rZwV33m7H7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMiqxNAN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40971F000E9;
	Thu, 18 Jun 2026 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796883;
	bh=sBLe+p6631vFA1BjPLOBoGBEGW+dqbF3AjFYIuGtie4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BMiqxNAN02eLH1ZOL1jmrffDmkyUVmcyoNnY/8Z28cZPpcuP93MiUey0mjuz/DgMh
	 X3dpxas/1nZc219re23tUsuPQqOLB16HxnZDfOtZ/39zHkv0OJaetSNVZm/jcrEKDn
	 46qz1MgsC6tCpd1reTAhHqn+oE7NARakAW6zbzOIUkZcXcYtReM8Z4IaDV1z1rZ4sP
	 5Y7GOOL79fqF/X2BNRbN+i00LFtnx08lpcYNWxm0KUt4IT84sgTFHqiXpHYX3Jkq4E
	 qDhx07RvtJISPttrkzB0e6fi98J+nxwBorGFjCdan7ufovynmWunDl2uyrRLqRcHiY
	 /T54wj1gv5ARw==
From: Simon Horman <horms@kernel.org>
To: shaojijie@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shenjian15@huawei.com,
	liuyonglong@huawei.com,
	chenhao418@huawei.com,
	huangdonghua3@h-partners.com,
	yangshuaisong@h-partners.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/5] net: hns3: refactor MAC autoneg and speed configuration
Date: Thu, 18 Jun 2026 16:34:19 +0100
Message-ID: <20260618153419.909913-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617112721.75186-3-shaojijie@huawei.com>
References: <20260617112721.75186-3-shaojijie@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300476-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:horms@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41C226A1464

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: hns3: refactor MAC autoneg and speed configuration

This refactor extracts the MAC autoneg and speed/duplex/lane configuration
out of hclge_mac_init() into a new helper hclge_set_autoneg_speed_dup(),
and invokes it from both hclge_init_ae_dev() and hclge_reset_ae_dev().

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 5a00797d9252..2c74675b149f 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -2957,20 +2957,6 @@ static int hclge_mac_init(struct hclge_dev *hdev)
>  	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
>  		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
>  
> -	if (hdev->hw.mac.support_autoneg) {
> -		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	if (!hdev->hw.mac.autoneg) {
> -		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
> -						 hdev->hw.mac.req_duplex,
> -						 hdev->hw.mac.lane_num);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	mac->link = 0;

[ ... ]

> @@ -11901,6 +11908,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>  	if (ret)
>  		goto err_ptp_uninit;
>  
> +	ret = hclge_set_autoneg_speed_dup(hdev);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to set autoneg speed duplex, ret = %d\n", ret);
> +		goto err_ptp_uninit;
> +	}
> +

[High]

Has the relocation of the autoneg/speed configuration in hclge_init_ae_dev()
been considered against the surrounding init order?

Previously the equivalent calls ran inside hclge_mac_init() before
hclge_update_port_info(). After this patch the helper runs after
hclge_update_port_info(), and hclge_update_port_info() ->
hclge_get_sfp_info() unconditionally overwrites hdev->hw.mac.autoneg,
hdev->hw.mac.support_autoneg and hdev->hw.mac.lane_num from firmware
whenever resp->speed_ability is non-zero.

The new helper then feeds the firmware-supplied lane_num back through:

    if (!hdev->hw.mac.autoneg) {
        ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
                                         hdev->hw.mac.req_duplex,
                                         hdev->hw.mac.lane_num);

On a non-copper port where firmware reports forced mode (autoneg=0) and a
stale lane_num inherited from a previous link lifecycle (for example
lane_num=4 from a prior 100G state), the (req_speed, lane_num) pair given
to hclge_cfg_mac_speed_dup_hw() can be inconsistent (for example 25G with
4 lanes), and firmware rejects it with -EINVAL, which propagates back to
hclge_init_ae_dev() and unwinds via err_ptp_uninit, failing the entire
probe.

The follow-up commit a7e52c16ecbf "net: hns3: fix init failure caused by
lane_num contamination" later in this series fixes this by introducing a
separate req_lane_num=0 and passing that to hclge_cfg_mac_speed_dup_hw()
instead of mac.lane_num. Should the fix be folded into this patch so the
series does not introduce a probe-failure regression at this point and
then repair it?

[Medium]

After this change, the last write to MAC speed/duplex on the init path is
hclge_cfg_mac_speed_dup_hw() inside the new helper, which programs
hardware but does not update the cached hdev->hw.mac.speed and
hdev->hw.mac.duplex. Previously the last writer was
hclge_cfg_mac_speed_dup() inside hclge_update_port_info(), which updates
both hardware and the cached fields.

When req_speed differs from the firmware-reported mac.speed (which can
happen if the active SFP speed differs from cfg.default_speed parsed in
hclge_configure()), is hardware left programmed with req_speed while
mac.speed retains the firmware-reported value, leaving the cache out of
sync with the actual hardware configuration until the periodic service
task refreshes mac.speed?

> @@ -12231,6 +12245,13 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
>  		return ret;
>  	}
>  
> +	ret = hclge_set_autoneg_speed_dup(hdev);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to set autoneg speed duplex, ret = %d\n", ret);
> +		return ret;
> +	}
> +
>  	ret = hclge_tp_port_init(hdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to init tp port, ret = %d\n",

[Low]

Could the commit message be tightened to match the resulting code?

The message says the helper "will also be invoked during the hardware
reset recovery path to re-apply link settings without repeating
unnecessary buffer or MTU initializations." However hclge_reset_ae_dev()
still calls hclge_mac_init() immediately before hclge_set_autoneg_speed_dup(),
and hclge_mac_init() still performs hclge_set_mac_mtu(),
hclge_set_default_loopback() and hclge_buffer_alloc(), so the avoidance
of MTU/buffer re-initialization described in the changelog is not
realized here.

The commit message is also framed as a pure readability/cyclomatic-
complexity refactor, but the autoneg/speed configuration is not just
extracted: in hclge_init_ae_dev() it is moved to a materially later
point (after hclge_update_port_info(), TSO, GRO, VLAN, TM, RSS, FD and
PTP setup), versus the original code where it was the very first
hardware-touching step inside hclge_mac_init(). The reset path keeps the
original relative ordering (helper runs immediately after
hclge_mac_init()), so the init and reset paths are now asymmetric in
placement, and the rationale for the late placement on the init path is
not stated.

