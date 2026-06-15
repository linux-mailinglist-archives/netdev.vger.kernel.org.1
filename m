Return-Path: <netdev+bounces-299657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ItSdGBWNMGpXUQUAu9opvQ
	(envelope-from <netdev+bounces-299657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:39:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063A868A9A1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fXErsTMo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299657-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299657-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F301301476D
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC8234A796;
	Mon, 15 Jun 2026 23:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A06344DA4;
	Mon, 15 Jun 2026 23:38:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566729; cv=none; b=gSGGGkm+JJkpB1cSTl8rbsuDKWDnffmMcdlJDvS/EU7VoPb7ckSJm+C6u7ipLOk8ifsDP58i2WpCQCH8+O1F5xugZiAikvN5BPg4yRMZdOHZhvVsKhXptF7uDUGVL12UK0InPGdgLiVufBXFzKuQunwFOVkgQLreiS8AQQAGUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566729; c=relaxed/simple;
	bh=LSS6SA7ndAwKBD4Ji623q1nQqMdUmaEbNSacEo44JwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsonyANz5F897FnskWnYAnxqjPDSFA8ZTISYJeNHWjZDJ4xycZBenZfcHIqT6IuJAO9ntDxpzEu+hguMcSLHtAmYOejwPKJ5e914ixkfub+NtFKSt6cBq03ilJpFsQg2XnNrv4gglGz7TDk69Hy+RY+XgbO+peyGSCm35V0vOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXErsTMo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158A81F00A3A;
	Mon, 15 Jun 2026 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566728;
	bh=Ahma7VBoZ8dq8G9kkkrgpiRxv6MF4l51nMrG6V7ECUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fXErsTMo7IXfvHroDy5VP9L4x1Q1/WSWexCMsq3Zp5D6IM9+9qxK41L2l1QCCipdV
	 iFrC2LxTdQ0l/ZXUJWf4yYnKrq2hB1PxP+DIDu3DjclbSLUvejy1JvZT6oBNsEQQ3N
	 iE8SV4RFBfcoCEb04Hny79+dSsxl/yRu3f5DCeVa+wzen5D3iPo/zNIu8HiGwhVLHF
	 r/l72EN87SX12WaTWHMYFxrolmzs7x8pxKFuXGvjFq75mjy2GRMHVNJRuItNEFHz1S
	 cOFu1S3RicYTmoMexnKJHCzb0Yv3dENSdNxx/OeQ1W9XmTnu3iYPLKTy7FtanHVzaS
	 7cHR/Hku65MUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jensemil.schulzostergaard@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel.machon@microchip.com,
	Steen.Hegelund@microchip.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 4/9] net: microchip: vcap: expose helpers in vcap api and update debugfs
Date: Mon, 15 Jun 2026 16:38:47 -0700
Message-ID: <20260615233847.1042253-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-sparx5_l3_routing-v1-4-fc3c10160f49@microchip.com>
References: <20260612-sparx5_l3_routing-v1-4-fc3c10160f49@microchip.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jensemil.schulzostergaard@microchip.com,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:daniel.machon@microchip.com,m:Steen.Hegelund@microchip.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-hardening@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 063A868A9A1

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: microchip: vcap: expose helpers in vcap api and update debugfs

Add new helpers to the vcap client api in preparation for L3 routing
functionality, rename PREROUTING to PREROUTING_L0, and fix a latent
undefined-behavior bug in the debugfs action-field printer.

> diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
> index 30700648672fc..0905e4f192a02 100644
> --- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
> +++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c

[ ... ]

> @@ -3547,6 +3560,18 @@ int vcap_rule_mod_action_u32(struct vcap_rule *rule,
>  }
>  EXPORT_SYMBOL_GPL(vcap_rule_mod_action_u32);
>  
> +/* Modify a bit action with value in the rule */
> +int vcap_rule_mod_action_bit(struct vcap_rule *rule,
> +			     enum vcap_action_field action,
> +			     enum vcap_bit val)
> +{
> +	struct vcap_client_actionfield_data data;
> +
> +	vcap_rule_set_action_bitsize(&data.u1, val);
> +	return vcap_rule_mod_action(rule, action, VCAP_FIELD_BIT, &data);

[Severity: Medium]
Could this copy uninitialized stack memory to the heap?

The data union is allocated on the stack but not initialized. The call to
vcap_rule_set_action_bitsize() only initializes the first byte (data.u1).

When data is passed to vcap_rule_mod_action(), it performs a memcpy() of the
entire 16-byte union:

vcap_rule_mod_action() {
	...
	memcpy(&field->data, data, sizeof(field->data));
	...
}

This appears to copy 15 bytes of uninitialized kernel stack memory into the
heap-allocated field->data, which might trigger KMSAN uninit-value warnings.

While a similar pattern exists in the pre-existing vcap_rule_mod_action_u32()
function, should the new data union be zero-initialized here?

> +}
> +EXPORT_SYMBOL_GPL(vcap_rule_mod_action_bit);
> +
>  /* Drop keys in a keylist and any keys that are not supported by the keyset */
>  int vcap_filter_rule_keys(struct vcap_rule *rule,
>  			  enum vcap_key_field keylist[], int length,

