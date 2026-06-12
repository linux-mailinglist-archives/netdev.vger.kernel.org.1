Return-Path: <netdev+bounces-298716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0PHkEYowLGoNNQQAu9opvQ
	(envelope-from <netdev+bounces-298716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:15:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5E167AC7C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gyt9cM8s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298716-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298716-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10603320D91C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0536F439;
	Fri, 12 Jun 2026 16:08:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9537188B;
	Fri, 12 Jun 2026 16:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280507; cv=none; b=qIG1nidxYNjsJ0zFy9yGF5aRM294xz+ZkC3ofVXJO5TzZBphLB3D8/FxzEk+2fxJDfNswiygAHBjfRsMK6AXTQyjMdP/y2MkdBFRVbqcwil5cy/Tzn9/QDdVDp2dZbiDmse14Dyg2oQO9Huhpchdqajr9goXi83EMsYKSDnp6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280507; c=relaxed/simple;
	bh=YDm9Y3X+BMD1MMeKdBZ+hd2k4h8UP63ReISLG8bNtCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbsbSWzNl51j6eGlwYNVjJlp3CYeoGYgMOfWLMkGlEaakO3LHb7mgWC7JCUVhEUu3ORRrCXbPsaA5bZUldzMdbUqWm0q1Ul1sohOKa7G77deyQOHSxWIn2qdQPxUEG4eJ5gAkQwEMILyTn+iZ3SQKfRX96suqvpt2icFI7M+JB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gyt9cM8s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6E21F000E9;
	Fri, 12 Jun 2026 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280506;
	bh=c411ca9RcVodJSRBNrpG9pskyg/ZhgijZ1oAXidL7Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gyt9cM8sBPLv9z7CeII+316XLznuJQXYcs1FxIiFPnMg9TNnLbn39QV9k0ds+UzqT
	 zdUBov8X8RQbwL5yEd1zTlc7ZYN4l/rQ5oB/NHBecitbQNx27emUaQEaXQoc5gOdtD
	 5deIAY5l9p3enWlZGHscYiDBtL1BKLh2v4yQIWhrXBG1MFrZ3YgPrNlt004ebdEbQM
	 E8V6A28UFYgIYGmwyvwpzmxmCu0WkMc9STAHrKo/y2aoYXBPlzeZh5E1Z2MDMv1uUt
	 4txRegZidpzi7HSgx1xtN6GrhWtiO5uTKhfG5gVndVut26LFP79sKoDY89/CtaaUkT
	 MhfgHc63RqVHQ==
From: Simon Horman <horms@kernel.org>
To: gongfan1@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	wudi234@huawei.com,
	tengpeisen@huawei.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	ioana.ciornei@nxp.com,
	mohsin.bashr@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	luosifu@huawei.com,
	guoxin09@huawei.com,
	zhoushuai28@huawei.com,
	wulike1@huawei.com,
	shijing34@huawei.com,
	zhengjiezhen@h-partners.com,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v09 4/5] hinic3: Add ethtool rss ops
Date: Fri, 12 Jun 2026 17:08:18 +0100
Message-ID: <20260612160818.690620-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7d1a4375fdf7c3e7a5a6162382cee4f48991d5da.1781062575.git.wudi234@huawei.com>
References: <7d1a4375fdf7c3e7a5a6162382cee4f48991d5da.1781062575.git.wudi234@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298716-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:horms@kernel.org,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,vger.kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,nxp.com,gmail.com,h-partners.com,bootlin.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE5E167AC7C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
hinic3: Add ethtool rss ops

This commit implements ethtool callback functions for the hinic3 driver.
These callbacks allow users to utilize ethtool for detailed RSS parameters
configuration and monitoring.

> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c

[ ... ]

> +int hinic3_set_channels(struct net_device *netdev,
> +			struct ethtool_channels *channels)
> +{
[ ... ]
> +	if (netif_running(netdev)) {
> +		q_params = nic_dev->q_params;
> +		q_params.num_qps = (u16)count;
> +		q_params.txqs_res = NULL;
> +		q_params.rxqs_res = NULL;
> +		q_params.irq_cfg = NULL;
> +
> +		err = hinic3_change_channel_settings(netdev, &q_params);
> +		if (err) {
> +			netdev_err(netdev, "Failed to change channel settings\n");
> +			return err;
> +		}
> +	} else {
> +		nic_dev->q_params.num_qps = (u16)count;
> +	}
> +
> +	err = hinic3_rss_update_num_qps_and_reprogram(netdev);
> +	if (err)
> +		return err;

[Severity: Medium]
If hinic3_rss_update_num_qps_and_reprogram() fails, the error code is
returned to the caller, but the queue changes made earlier by
hinic3_change_channel_settings() remain active. Is it expected that a failure
leaves the newly requested channel configuration running?

[ ... ]

> +static int hinic3_set_rss_rxfh(struct net_device *netdev,
> +			       const u32 *indir, u8 *key)
> +{
[ ... ]
> +	if (indir) {
> +		for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
> +			temp_indir[i] = (u16)indir[i];
> +
> +		err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, temp_indir);
> +		if (err) {
> +			netdev_err(netdev, "Failed to set rss indir table\n");
> +			return err;
> +		}
> +
> +		memcpy(nic_dev->rss_indir, temp_indir, L2NIC_RSS_INDIR_SIZE);

[Severity: High]
Does this copy the entire indirection table? Since temp_indir is an array
of u16 elements, copying L2NIC_RSS_INDIR_SIZE bytes instead of
L2NIC_RSS_INDIR_SIZE * sizeof(u16) will only update the first half of the
nic_dev->rss_indir array.

[ ... ]

> +static int hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev,
> +				    u32 *indir_table)
> +{
[ ... ]
> +	err = hinic3_cmdq_detail_resp(hwdev, MGMT_MOD_L2NIC,
> +				      L2NIC_UCODE_CMD_GET_RSS_INDIR_TBL,
> +				      pair.in, pair.out, NULL);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to get rss indir table\n");
> +		goto err_get_indir_tbl;
> +	}
> +
> +	indir_tbl = (__force __le16 *)pair.out->buf;
> +	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
> +		indir_table[i] = le16_to_cpu(*(indir_tbl + i));

[Severity: High]
Should the response buffer words be swabbed using hinic3_cmdq_buf_swab32()
before reading, similar to how it is handled in the set operation? Also,
does the data start immediately at offset 0, or is there a 16-byte
reserved prefix like the one defined in struct l2nic_cmd_rss_set_indir_tbl
that needs to be skipped?

[ ... ]

> +static int hinic3_update_hash_func_type(struct net_device *netdev, u8 hfunc)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	enum hinic3_rss_hash_type new_rss_hash_type;
> +	int err;
[ ... ]
> +	if (new_rss_hash_type == nic_dev->rss_hash_type)
> +		return 0;
> +
> +	err = hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);

[Severity: Medium]
Will this push the old hash type to the hardware instead of the newly
requested one? It passes nic_dev->rss_hash_type rather than
new_rss_hash_type.

> +	if (err) {
> +		netdev_err(netdev, "Failed to set RSS hash type to HW\n");
> +		return err;
> +	}
> +
> +	nic_dev->rss_hash_type = new_rss_hash_type;
> +
> +	return 0;
> +}

