Return-Path: <netdev+bounces-294813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zo5PFmNSIGoV1AAAu9opvQ
	(envelope-from <netdev+bounces-294813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:12:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE1F639957
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 18:12:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eiwB42KR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294813-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294813-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92D330C4741
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84613CD8BB;
	Wed,  3 Jun 2026 15:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900213D522C
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:23:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500239; cv=none; b=OOagyOjrvn/siv4pnWvSjyqLK26aAxFqdVRFYNvIRGsHmAEG1W6gvoloa8Jf2vKA47H2HfDxTj8+JjQuHvcFtrmMwgSFRWn8lx5AsGn5KC+HCxMABK1NUM82ZXkp+ebcV6B1lIYNPmBgD1E2sjUX34LxrzeoMni0WhZB4Hccof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500239; c=relaxed/simple;
	bh=vRPY8IVMxncuydJzDvs9L/UnNO6Y3NL0spYHvmZmZt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kReGmQWClG2hi7DaGxnYeBxF0K0Qo9sTW9FNGZvWEdLASSJ8kui94RZLimfCHml2kFLPMLmCQY1+UWvoJfoXgLynJgNNMbAoKMcZHKIO8WryyZEw8TtotHPVNxvAy21mCj5GnVBGlQP/fWALhGXxgB9WdCueaYKOneIh2QRzS7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiwB42KR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163661F00893;
	Wed,  3 Jun 2026 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500238;
	bh=wvfRUZtfuJ4psmTYEeP0sco4QIXX7+GAYLk2Oha/pJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiwB42KRJLTaOthJna0ARn4hTQJP2hoNty36f8hzpja8Eyj6R+r+w4KCa2j7aEVv2
	 nWshDXPI5ddGFaRxLQ2wwKZbVpw86wKHyQdG4ws+wx83OVYppN1DHsGAIaAWaTTTsT
	 5d+d2u+qwEMiZTLLcMhCCZysdWSPy4jpgoYqEKVCNW5bnoWJLZ/GaQQIG78BYM+Vb8
	 cUOOWAqIz8QEocg1kwuXnX2xTXawdoXqYrMpRmg3cWENn4Yv3X8lHq/9eyLyyKoBmu
	 LQ762lD8fTSh9ZD9Aiy2WsnQGreGqw/NlZOYInRwFge8fc9bvX+qDL4TDGI0tpkZEv
	 9vilpYAhcDLCg==
From: Simon Horman <horms@kernel.org>
To: mengyuanlou@net-swift.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v3 2/3] net: libwx: add support for set_coalesce in wx_ethtool_ops_vf
Date: Wed,  3 Jun 2026 16:23:25 +0100
Message-ID: <20260603152324.3795898-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529075147.88398-3-mengyuanlou@net-swift.com>
References: <20260529075147.88398-3-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294813-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADE1F639957

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: libwx: add support for set_coalesce in wx_ethtool_ops_vf

This change wires wx_set_coalesce() into wx_ethtool_ops_vf and
dispatches the per-vector ITR write through wx_write_eitr_vf() when
operating on a virtual function.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 6d8fcddde6fa..30c6ef6103ac 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -488,7 +489,10 @@ int wx_set_coalesce(struct net_device *netdev,
>  		else
>  			/* rx only or mixed */
>  			q_vector->itr = rx_itr_param;
> -		wx_write_eitr(q_vector);
> +		if (wx->pdev->is_virtfn)
> +			wx_write_eitr_vf(q_vector);
> +		else
> +			wx_write_eitr(q_vector);
>  	}

[High]
After this change wx_set_coalesce() is reachable on the VF path, but
the validation and the values computed for q_vector->itr come from
the PF logic earlier in the same function:

	switch (wx->mac.type) {
	case wx_mac_sp:
		max_eitr = WX_SP_MAX_EITR;
		rx_itr_param = WX_20K_ITR;
		tx_itr_param = WX_12K_ITR;
		break;
	case wx_mac_aml:
	case wx_mac_aml40:
		max_eitr = WX_AML_MAX_EITR;
		rx_itr_param = WX_20K_ITR;
		tx_itr_param = WX_12K_ITR;
		break;
	default:
		max_eitr = WX_EM_MAX_EITR;
		rx_itr_param = WX_7K_ITR;
		tx_itr_param = WX_7K_ITR;
		break;
	}

	if ((ec->rx_coalesce_usecs > (max_eitr >> 2)) ||
	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
		return -EINVAL;

The VF write helper masks with a 9-bit field:

void wx_write_eitr_vf(struct wx_q_vector *q_vector)
{
	...
	itr_reg = q_vector->itr & WX_VXITR_MASK;
	...
}

with WX_VXITR_MASK = GENMASK(8, 0) = 0x1FF, while the PF max_eitr
constants used to bound ec->rx_coalesce_usecs / ec->tx_coalesce_usecs
are WX_SP_MAX_EITR=0xFF8, WX_AML_MAX_EITR=0xFFF and
WX_EM_MAX_EITR=0x7FFC.

Can any q_vector->itr value greater than 511 be silently truncated by
this VF path?  For example, on a wx_mac_sp VF, an
ec->rx_coalesce_usecs of 128 yields q_vector->itr = 512, which
becomes register value 0 (no coalescing) after the mask, while
wx_get_coalesce() reports back the original wx->rx_itr_setting and
hides the mismatch from the user.

Does the wx_mac_em default also misbehave here?  When adaptive is
disabled and the defaults are picked, rx_itr_param/tx_itr_param =
WX_7K_ITR = 595, and 595 & 0x1FF = 83, so the VF programs a value
unrelated to the requested 7K rate.

[High]
For wx_mac_aml / wx_mac_aml40, wx_set_coalesce() computes the same
q_vector->itr for PF and VF, but the two write helpers differ in how
they encode it:

void wx_write_eitr(struct wx_q_vector *q_vector)
{
	...
	case wx_mac_aml:
	case wx_mac_aml40:
		itr_reg = (q_vector->itr >> 3) & WX_AML_MAX_EITR;
		break;
	...
}

void wx_write_eitr_vf(struct wx_q_vector *q_vector)
{
	...
	itr_reg = q_vector->itr & WX_VXITR_MASK;
	...
}

txgbevf_sw_init() sets wx->mac.type = wx_mac_aml, so on aml VFs the
same ec->rx_coalesce_usecs setting now programs the hardware with a
value 8x different from the equivalent PF setting.

Is the VF ITR register on aml expected to have the same time-base as
the PF (in which case the >>3 scaling is missing in
wx_write_eitr_vf() for aml), or a different time-base (in which case
the rx_itr_param / tx_itr_param defaults shared with the PF in the
wx_mac_aml case of wx_set_coalesce() do not match the VF)?

> @@ -844,6 +848,7 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
>  	.set_ringparam		= wx_set_ringparam_vf,
>  	.get_msglevel		= wx_get_msglevel,
>  	.get_coalesce		= wx_get_coalesce,
> +	.set_coalesce		= wx_set_coalesce,
>  	.get_ts_info		= ethtool_op_get_ts_info,
>  	.get_link_ksettings	= wx_get_link_ksettings_vf,
>  };

