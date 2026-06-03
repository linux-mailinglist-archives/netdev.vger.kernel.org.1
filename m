Return-Path: <netdev+bounces-294516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UBr5NU+QH2rYnAAAu9opvQ
	(envelope-from <netdev+bounces-294516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:24:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AC6633A1C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:24:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Gwm9kMJC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294516-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294516-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5908D303D308
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E43D813F;
	Wed,  3 Jun 2026 02:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C43D75C4;
	Wed,  3 Jun 2026 02:21:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453311; cv=none; b=NMdn2pLgk4jq80WLPu7Av8Tr9C/qCixs400qy/cWgXpqzfj0Qn6f4oitkbpDiiYlTcrqFj3Yx6CCWMWOZ8ua/RP6Xmpb5rfOaDozYduuJHrnVbPiMv09o2lNmvcSrwmCeFQo0Tnl2JLlQOvWWPWIuZiCJD9lqqRIUA6aqyliigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453311; c=relaxed/simple;
	bh=NQ+8uBpv2+/0PdKtI70kU1g2Ta82QW2ErIZzI2ukItE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSr5akUHLB/mVl4WRO5rsh0emAocv+7ZMsvTQrjY/n9Pe5jWXA6ZGMPuOT+Fz7b4T61eMaNTU+wJTbOH0kKJviRTqJZufQVwufr8jkl5ryJxwyrRPCudoNOqXGspLRHvLHCOxtvPPsRKzT/KpcGyZBenxi3HpPTcMDnkBHNfwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwm9kMJC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD931F00898;
	Wed,  3 Jun 2026 02:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453310;
	bh=oRvfGkadThN28A+4nC2mZwKCLc8uSYzi+IwPFo8dqgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gwm9kMJCnF3gF3CphivIvgG3mf5yYW/gp5LUYZxwhcl4c+xKOdq7YZ1qRwF+2z9H9
	 oNPasZsY+xsWSponiJ3KIzpGFAQ268/n7s4YU4E1S5bg9jaKhe23zreY/3nUT5sx1h
	 OzXauVoWh4yToPAJW241oPZaedVYAkrXenJ7OKKuQztUnPUxSW4QlXkXBb88cHG/f3
	 lzsWN4Nu+JcFFiVz0bQ/HU+NxB/J2x8AkImK/pwxnUG4GU9NSOxq1AdyqCmfYT2/HN
	 2n0pX39ccUB3f8jpns2KkcS5JUdz977qvBG1WP0W1UGR6ihgmrAXEj/gj1qzJs2uDX
	 jj6PDfo0//oFA==
From: Jakub Kicinski <kuba@kernel.org>
To: lihaoxiang@isrc.iscas.ac.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	kees@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: microchip: sparx5: clean up PSFP resources on flower setup failure
Date: Tue,  2 Jun 2026 19:21:48 -0700
Message-ID: <20260603022148.2296220-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529065615.35782-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260529065615.35782-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-294516-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lihaoxiang@isrc.iscas.ac.cn,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25AC6633A1C

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: microchip: sparx5: clean up PSFP resources on flower setup failure

This patch adds error handling paths to sparx5_tc_flower_psfp_setup() so
that PSFP resources allocated earlier in the function are unwound when a
later step fails.

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> index f779a5c00803..a17143953502 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> @@ -807,7 +807,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  		/* Add new flow-meter */
>  		ret = sparx5_psfp_fm_add(sparx5, pol_idx, fm, &psfp_fmid);
>  		if (ret < 0)
> -			return ret;
> +			goto err_sg_del;
>  	}
>  
>  	/* Map stream filter to stream gate */
> @@ -816,7 +816,7 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  	/* Add new stream-filter and map it to a steam gate */
>  	ret = sparx5_psfp_sf_add(sparx5, sf, &psfp_sfid);
>  	if (ret < 0)
> -		return ret;
> +		goto err_fm_del;
>  
>  	/* Streams are classified by ISDX - map ISDX 1:1 to sfid for now. */
>  	sparx5_isdx_conf_set(sparx5, psfp_sfid, psfp_sfid, psfp_fmid);
> @@ -824,13 +824,23 @@ static int sparx5_tc_flower_psfp_setup(struct sparx5 *sparx5,
>  	ret = vcap_rule_add_action_bit(vrule, VCAP_AF_ISDX_ADD_REPLACE_SEL,
>  				       VCAP_BIT_1);
>  	if (ret)
> -		return ret;
> +		goto err_sf_del;
>  
>  	ret = vcap_rule_add_action_u32(vrule, VCAP_AF_ISDX_VAL, psfp_sfid);
>  	if (ret)
> -		return ret;
> +		goto err_sf_del;
>  
>  	return 0;
> +
> +err_sf_del:
> +	sparx5_isdx_conf_set(sparx5, psfp_sfid, 0, 0);
> +	sparx5_psfp_sf_del(sparx5, psfp_sfid);
> +err_fm_del:
> +	if (pol_idx >= 0)
> +		sparx5_psfp_fm_del(sparx5, psfp_fmid);

[High]
Can the err_fm_del path leak a flow-meter refcount when the flow meter
was already in use?

Looking at sparx5_psfp_fm_add():

	ret = sparx5_psfp_fm_get(sparx5, uidx, &fm->pol.idx);
	if (ret < 0)
		return ret;
	/* Was already in use, no need to reconfigure */
	if (ret > 1)
		return 0;
	...
	*id = fm->pol.idx;
	return 0;

When the flow meter is already in use, sparx5_psfp_fm_add() returns 0
without writing back to *id, so the caller's psfp_fmid is left at its
initialized value of 0.

If sparx5_psfp_sf_add() or one of the vcap_rule_add_action_* calls then
fails, err_fm_del runs sparx5_psfp_fm_del(sparx5, 0). Pool ids appear to
be 1-based:

	u32 sparx5_pool_idx_to_id(u32 idx)
	{
		return ++idx;
	}

so id 0 has no valid LBSET, sparx5_sdlb_group_get_by_index() returns
-EINVAL, and sparx5_psfp_fm_del() aborts before reaching its
sparx5_psfp_fm_put() call:

	ret = sparx5_sdlb_group_get_by_index(sparx5, id, &fm.pol.group);
	if (ret < 0)
		return ret;

	ret = sparx5_psfp_fm_put(sparx5, id);

The refcount that sparx5_psfp_fm_get() incremented on the actually-reused
flow meter would not be decremented.

Would it work to either move the *id = fm->pol.idx; assignment before the
ret > 1 early return inside sparx5_psfp_fm_add(), or to call
sparx5_psfp_fm_del(sparx5, fm->pol.idx) at this cleanup site instead?

> +err_sg_del:
> +	sparx5_psfp_sg_del(sparx5, psfp_sgid);
> +	return ret;
>  }
>  
>  /* Handle the action trap for a VCAP rule */
-- 
pw-bot: cr

