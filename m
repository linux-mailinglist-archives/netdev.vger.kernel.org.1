Return-Path: <netdev+bounces-300478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qg8GAbYQNGp+NAYAu9opvQ
	(envelope-from <netdev+bounces-300478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:37:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D8A6A1487
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HN6uP1O7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300478-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300478-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC3430A19AF
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235633B6DB;
	Thu, 18 Jun 2026 15:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C38733D509;
	Thu, 18 Jun 2026 15:34:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796897; cv=none; b=apxqbHyGk/HRSuOmx1aZJwZMbLLf4HJUnvlNaTQRL53qLLw8SggWWE1DAiHuxholH6K4mx7/DluOarS+CeaONWilgqWi1vBo4Av3Nzo+b1eXIyjadvgKdot9quufHjLvVGj4lYPpIvioJdbrGUbJn45tqibLsFHvME/fAg9DE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796897; c=relaxed/simple;
	bh=3aj130vGy6lMZ/4OfIru8bKGI+olPagwRhpviFSvlkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCVOgMvZo10VMn5an8dLCghYJns/XmSqAwqSLsvHkjRy0SAyyJgJywXv7O8doqqLJD7eDEIYNj+VKTsTvq5ld3qIf2HpSKHdZ04cv5wpJqoHNKauVJ9hqFZK1XQkTecV90XQXPC5CnLp4zcXxaZtn5fqaUahuvvN+vuhlRwfCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN6uP1O7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58E11F000E9;
	Thu, 18 Jun 2026 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796896;
	bh=JOH3UvfxE8S5XlN8WY1u0RjYXaafi3kxscGtwmwPCtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HN6uP1O71BsEK8iDe/0t2lyhS5QrJDYoetGU2bpQDy2wqPGI8dcdfiLqsNzTySV5+
	 ZgMt4U4bTvBHpVCG8e+ZS23q0mtE5zx3rXg6T0dTNH+qbdayXSWfAdIGfM6sj0cIlJ
	 FsMLYsmSUFMyp15HL/ip3t+JLbJNcOF72Qa2IN99c36jFoTIrSLR2RK004ARsLvaMs
	 4O5QIO6LM5bhvlO2/4tCklLd67J44blMffBui1bWY0VmMblHSLa6pcOIQFgrWmlfXf
	 IWb3KJqbJnq597N5lKNEk/3TNm1hjBo4hWz+qd1s+2uXkk5vEssK0yK1i/EKmBRQXq
	 2SXy2C4U0FsXw==
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
Subject: Re: [PATCH net 4/5] net: hns3: differentiate autoneg default values between copper and fiber
Date: Thu, 18 Jun 2026 16:34:50 +0100
Message-ID: <20260618153450.909964-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617112721.75186-5-shaojijie@huawei.com>
References: <20260617112721.75186-5-shaojijie@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-300478-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59D8A6A1487

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: hns3: differentiate autoneg default values between copper and fiber

This commit addresses a link loss issue during driver initialization on
optical ports connected to forced-mode remote switches. It modifies
hclge_init_ae_dev to set autonegotiation based on media type. Copper ports
retain the AUTONEG_ENABLE default, while optical ports inherit the firmware
pre-configured autoneg setting.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -11916,6 +11916,9 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>  	if (ret)
>  		goto err_ptp_uninit;
>  
> +	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
> +		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
> +

[Severity: High]
Does this apply the wrong speed when autonegotiation is disabled on fiber
ports?

During driver initialization, hclge_update_port_info() dynamically probes
the SFP module and updates mac->speed, but does not update mac->req_speed,
which retains its statically configured default capability.

When hdev->hw.mac.autoneg is 0 (forced-mode), req_autoneg becomes 0, and
then hclge_set_autoneg_speed_dup() uses req_speed:

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:hclge_set_autoneg_speed_dup() {
...
    if (!hdev->hw.mac.req_autoneg) {
        ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
...
}

Could this override the dynamically probed SFP speed with the static default
speed?

[Severity: High]
Does this unconditionally disable autonegotiation for V1 optical hardware?

Looking at hclge_update_port_info(), it only queries SFP information via
hclge_get_sfp_info() for V2 hardware. For V1 hardware, it falls back to
hclge_get_sfp_speed(), which leaves mac->autoneg uninitialized (0):

drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c:hclge_update_port_info() {
...
    if (hdev->ae_dev->dev_version >= HNAE3_DEVICE_VERSION_V2) {
        speed = mac->speed;
        ret = hclge_get_sfp_info(hdev, mac);
    } else {
        speed = HCLGE_MAC_SPEED_UNKNOWN;
        ret = hclge_get_sfp_speed(hdev, &speed);
    }
...
}

If mac->autoneg is left as 0, wouldn't req_autoneg unconditionally be set
to 0 here, overriding the speed and breaking connectivity for V1 devices?

>  	ret = hclge_set_autoneg_speed_dup(hdev);
>  	if (ret) {
>  		dev_err(&pdev->dev,

