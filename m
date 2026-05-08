Return-Path: <netdev+bounces-285798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOctLUTX/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:29:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175F44F6628
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8137300EF50
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE53D5662;
	Fri,  8 May 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/n97a4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0FF37AA98;
	Fri,  8 May 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243093; cv=none; b=lFQsuo92Zaxz0qGSr7t+klqNYBIW9kCNZiQYTlCN+2QsheXxFjmbSaC3jONDYWIOgaqyRN/Okff3MgpaQ3bdfIei3qBvbJX/Nu6gDo8n1AX0AujMdguJBBGjzvs0fo+TSsPOF03MNg0sO3wdfwbnMQ7OS4I8sqB2dc9cA7/a6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243093; c=relaxed/simple;
	bh=4NwDosvbGWnrUCphv7qM/c8OQJHtLovL+a0HlV2ooQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Flr7Y8pT892dIRFRzENlEreXTwoNyRrmhJNBFzi/vtdDZl4WO/ofaFDqh/0DuysY2aemb9ZaSI0JBeMNO4uBfJx2hw4Q9UIcirtuSHFJhkrpyn2mBHymFcCxr+4q9ql7i8QJozZ+jl8Eh2VYTFXqg0iUZ5IyDEdkAWdkKpZE290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/n97a4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358CBC2BCB0;
	Fri,  8 May 2026 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243093;
	bh=4NwDosvbGWnrUCphv7qM/c8OQJHtLovL+a0HlV2ooQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/n97a4ArnT+eMpzWlQQ5iXxQf+1+g7+CLJoh/s2g83Zc6RP+L8EEDv4SAOJ9n1dI
	 qgFqu6A2U5dwepsrRPfpJJy7L0QgU3uF3zWBgfzcAf0nXoHvWs9s+bDkhIGyTlnLWn
	 ZIipQTwk8fvR8fKhDoIfq0j7iFN3SLG+gv97HOD5aeu3U3JEYWjorMJCF+lbpJDFfG
	 48QGlcDVLrtZx8o86mYbWFML2qdccvMaFUEflSNC0O7hSttmQv5t+bTc6+vKFypDSZ
	 9va2nOxctj+c4ZeQ3UgtijvV4Z1wKuBhXW7kkKNc3saRj+YkgNYV39xzVu8XTQpMrA
	 eCkrCa4l52u/w==
From: Simon Horman <horms@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: 'Simon Horman' <horms@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	linux@armlinux.org.uk,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	tristram.ha@microchip.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next 9/9] net: dsa: microchip: split ksz_connect_tag_protocol()
Date: Fri,  8 May 2026 13:23:32 +0100
Message-ID: <20260508122330.1155059-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505-clean-ksz-driver-v1-9-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-9-05d70fa42461@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 175F44F6628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,armlinux.org.uk,se.com,vger.kernel.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev

Simon says: I also note that there is an AI review of patch 7/9.
However, I believe that is a false positive.

---
net: dsa: microchip: split ksz_connect_tag_protocol()

The commit splits the common ksz_connect_tag_protocol() into switch-specific
operations to ensure each switch only accepts the tag protocol it supports.

> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index 9bac95bb079ff..ac2c63fe0588c 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
[ ... ]
> @@ -1624,6 +1625,20 @@ static enum dsa_tag_protocol ksz9477_get_tag_protocol(struct dsa_switch *ds,
>  	return DSA_TAG_PROTO_KSZ9477;
>  }
>  
> +static int ksz9477_connect_tag_protocol(struct dsa_switch *ds,
> +					enum dsa_tag_protocol proto)
> +{
> +	struct ksz_tagger_data *tagger_data;
> +
> +	if (proto != DSA_TAG_PROTO_KSZ9893 && proto != DSA_TAG_PROTO_KSZ9477)
> +		return -EPROTONOSUPPORT;

Does this fully enforce the restriction mentioned in the commit message?

The commit message states "each switch will only accept to connect the tag
protocol it supports". While ksz88xx_connect_tag_protocol() correctly checks
the chip family, ksz9477_connect_tag_protocol() accepts either
DSA_TAG_PROTO_KSZ9893 or DSA_TAG_PROTO_KSZ9477 without checking the specific
chip ID.

For comparison, ksz9477_get_tag_protocol() returns DSA_TAG_PROTO_KSZ9893 only
for specific chips (KSZ8563, KSZ9893, KSZ9563).

Should this function check dev->chip_id to prevent a chip from being
configured to use the wrong protocol?

> +
> +	tagger_data = ksz_tagger_data(ds);
> +	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
> +
> +	return 0;
> +}

