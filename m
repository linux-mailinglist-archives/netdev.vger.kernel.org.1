Return-Path: <netdev+bounces-296006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PFa0NcVsI2pztwEAu9opvQ
	(envelope-from <netdev+bounces-296006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 02:41:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E16264C0AE
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 02:41:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cqL7y8ki;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296006-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5875301DE06
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 00:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A3233937;
	Sat,  6 Jun 2026 00:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347DF221F1F;
	Sat,  6 Jun 2026 00:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780706424; cv=none; b=cCQ8zmr8IcX3DvYmHpiCqrmbwSklKG82D2Tb2I/NRSR4/OC14n4Qb80UEbALpDutBbITZWTsnFixs7I+6z3kSSaHlKl3ptpTdHADHAyUDaCJjL/Ht/6/eJO6303w2gFVX63Emh8KHkjjHBpA5LgARCqzqsmGq2Hd4lzdXZS+m+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780706424; c=relaxed/simple;
	bh=3fAK4Dl8JZG1llmMesKBVr1X2bxg5q//jqNGIv/QkmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfL58wIvIgaRomlR8A4V3FkdU5GC9QhcLZW4uP8IZ+22xYsAkeXvOi6bh7ODuKlLJuP79MmNxLjIKcQNmKYYk78b4co0Ff42AA97Ljj6BAoXtvPd+wy84ZTY10x0HnX6MDywUHHhsAyXbGFtGqFYZJvehSfQy55h4ydCw1s6V4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqL7y8ki; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A31F00893;
	Sat,  6 Jun 2026 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780706423;
	bh=GdG4svP0NHvHQkHliVHok2ibO/bodbvKdcGBvy/bY1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cqL7y8kiJkcPjWRuO4ZdQFMG8MFhX0juI3NAsEEVShVYecF1cCVNxA7RZxQbV/Yr0
	 Ri3KnDlg4bgfFW5iPik7wG7FdljefPU634ER5u87lJto1477xYQeuT5krW1MRc5Ctg
	 qSGW3CdgXbJrZGp9DWrusVLQdIfM0JW45kswX22fRM77gbVPOLaSrrU0yFTbCdtIzT
	 ILD1Qrl2gS8u04ZvqTBwc/VRkBti/wLNlXULKxL4NA0YcGfgelJ1+0B91s0a3QueSU
	 7MLauaHBTx8tUB0mQXJZOlBiw2Hs6nT4Wj1Ram3njHtwADq3Vj7/FhO695iEiOhEFW
	 0qN3CVfwu0JMA==
Date: Fri, 5 Jun 2026 17:40:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 3/6] net: hns3: support two more actions for
 tc flow
Message-ID: <20260605174021.7d4c6ec4@kernel.org>
In-Reply-To: <20260602133337.2216918-4-shaojijie@huawei.com>
References: <20260602133337.2216918-1-shaojijie@huawei.com>
	<20260602133337.2216918-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296006-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:shaojijie@huawei.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E16264C0AE

On Tue, 2 Jun 2026 21:33:34 +0800 Jijie Shao wrote:
> Currently, the driver supports only one action:HCLGE_FD_ACTION_SELECT_TC.
> 
> This patch adds support for HCLGE_FD_ACTION_SELECT_QUEUE and
> HCLGE_FD_ACTION_DROP_PACKET.
> 
> A rule can have only one action. Therefore, the driver intercepts rules
> that have multiple actions or no action.
> 
> Note: The driver considers cls_flower->classid as an action:
> HCLGE_FD_ACTION_SELECT_TC.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 59 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index 5e1f76513622..aa85abda2909 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -7344,18 +7344,45 @@ static int hclge_get_tc_flower_action(struct hclge_dev *hdev,
>  				      struct flow_cls_offload *cls_flower,
>  				      struct hclge_fd_rule *rule)
>  {
> +	struct flow_rule *flow = flow_cls_offload_flow_rule(cls_flower);
>  	struct hnae3_handle *handle = &hdev->vport[0].nic;
> +	struct flow_action *action = &flow->action;
> +	struct flow_action_entry *act;
>  	int tc;
>  
> -	tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
> -	if (tc < 0 || tc > hdev->tc_max) {
> -		dev_err(&hdev->pdev->dev, "invalid traffic class: %d\n", tc);
> -		return -EINVAL;
> +	if (!flow_action_has_entries(&flow->action)) {
> +		tc = tc_classid_to_hwtc(handle->netdev, cls_flower->classid);
> +		if (tc < 0 || tc > hdev->tc_max) {
> +			dev_err(&hdev->pdev->dev,
> +				"invalid traffic class: %d\n", tc);
> +			return -EINVAL;
> +		}
> +
> +		rule->action = HCLGE_FD_ACTION_SELECT_TC;
> +		rule->cls_flower.tc = tc;
> +		return 0;
>  	}
>  
> -	rule->action = HCLGE_FD_ACTION_SELECT_TC;
> -	rule->cls_flower.tc = tc;
> -	return 0;
> +	act = &action->entries[0];
> +	switch (act->id) {
> +	case FLOW_ACTION_RX_QUEUE_MAPPING:
> +		if (act->rx_queue >= handle->kinfo.num_tqps) {
> +			dev_err(&hdev->pdev->dev,
> +				"queue id (%u) should be less than %u\n",
> +				act->rx_queue, handle->kinfo.num_tqps);
> +			return -EINVAL;
> +		}
> +
> +		rule->queue_id = act->rx_queue;
> +		rule->action = HCLGE_FD_ACTION_SELECT_QUEUE;
> +		return 0;
> +	case FLOW_ACTION_DROP:
> +		rule->action = HCLGE_FD_ACTION_DROP_PACKET;
> +		return 0;
> +	default:
> +		dev_err(&hdev->pdev->dev, "unsupported action(%d)\n", act->id);
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int hclge_parse_cls_flower(struct hclge_dev *hdev,
> @@ -7412,6 +7439,24 @@ static int hclge_check_cls_flower(struct hclge_dev *hdev,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* driver will parses classid into an action */
> +	if (cls_flower->classid && flow_action_has_entries(&flow->action)) {
> +		dev_err(&hdev->pdev->dev,
> +			"please not set classid and action together\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!flow_action_has_entries(&flow->action) && !cls_flower->classid) {
> +		dev_err(&hdev->pdev->dev, "please set action or classid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (flow_action_has_entries(&flow->action) &&
> +	    !flow_offload_has_one_action(&flow->action)) {
> +		dev_err(&hdev->pdev->dev, "unsupported multiple actions\n");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	return 0;

Please use struct flow_cls_offload::common:extack and
NL_SET_ERR_MSG_MOD() to return these to the caller instead of dumping
them into the system logs.
-- 
pw-bot: cr

