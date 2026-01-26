Return-Path: <netdev+bounces-253551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MJ7Ci+hd2kCjQEAu9opvQ
	(envelope-from <netdev+bounces-253551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:15:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4628B5B9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A74302E7A2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F7F34AAF2;
	Mon, 26 Jan 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABE2lW/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0E9330679;
	Mon, 26 Jan 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447624; cv=none; b=pBzdIx/3pKRY7iZ/oq7trFlc47kMM+KxKX+3MuJFlUd51W0dWs1U0dDXS/L09Zr+yt/SQN0gND69iQTA6u6+E/Siq7MeCqDPnevDcuOS9qebUJFYiUEm5ysVhifr9WWPjDlqSpVLz38KtRFOKYnZV9+5u0AIeOOSmXvT5kz+Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447624; c=relaxed/simple;
	bh=NBz7ZaIkqSaPXtHRkfG/f3m6UU+9n6nZ52q+gmm16do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/f52c7JEPmqhywC/DySzXFl22kcfdl0HlFA0Dn6VsgrqXfK9x8d0OMKAz3d+u1Ob2/+mdxVutioSekiINFSyC1XH8L2qlGDrjAol4gwHuHUYUEKb35JVZVNmf6OthWGXqNk1EzWqdeVjc9k3hxHXDtIo4FRK06/7K49bl7boqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABE2lW/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7EC116C6;
	Mon, 26 Jan 2026 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447623;
	bh=NBz7ZaIkqSaPXtHRkfG/f3m6UU+9n6nZ52q+gmm16do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABE2lW/Y+5QJwdaq1KwjbZrGoUb7Xr5uiAgpY0MFWpiwuAOBnXoDQ145dq2v97Dt9
	 6MzEq7k76NfEHcZLmwbtIMHFGFcxiZSZ4FOEKCs8NN/JQR+NJveHamQOJ0KoQYqf/R
	 LkeyHDuBgWZb3clzHL7rbfjv1AVkaX2Z/wQjcYOUgAjxLy4dEyelzTPLQswF45Bl1T
	 yg6Q+QIqY+ykCE6HKOw/gel/xZqPHYqnmNudLvQWdd1gkBm6UJKR4R0rrKPLE6jhjR
	 HgrHlA9HN5TLwXGNrK60NYgHS1w0pkfN6eDmhvzx+mCpy0yYOe5tQxYUNIZ4LXcrLT
	 f6G86SMlz6nOA==
From: Simon Horman <horms@kernel.org>
To: mmyangfl@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	olteanv@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Subject: Re: [net-next,v3,1/3] net: dsa: tag_yt921x: fix priority support
Date: Mon, 26 Jan 2026 17:13:24 +0000
Message-ID: <20260126171324.1392638-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125001328.3784006-2-mmyangfl@gmail.com>
References: <20260125001328.3784006-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,vger.kernel.org,davemloft.net,armlinux.org.uk,lunn.ch];
	TAGGED_FROM(0.00)[bounces-253551-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C4628B5B9
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: yt921x: Add DCB/QoS support

This commit adds DCB/QoS support to the yt921x DSA switch driver,
setting up global DSCP/PCP priority mappings and adding related DCB
methods.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index af8464c42b51..87e33d0df4ac 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c

[ ... ]

> +/* Not "port" - DSCP mapping is global */
> +static int __maybe_unused
> +yt921x_dsa_port_get_dscp_prio(struct dsa_switch *ds, int port, u8 dscp)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	u32 val;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_IPM_DSCPn(dscp), &val);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		return res;
> +
> +	return FIELD_GET(YT921X_IPM_PRIO_M, val);
> +}
> +
> +static int __maybe_unused
> +yt921x_dsa_port_del_dscp_prio(struct dsa_switch *ds, int port, u8 dscp, u8 prio)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_write(priv, YT921X_IPM_DSCPn(dscp),
> +			       YT921X_IPM_PRIO(IEEE8021Q_TT_BK));
> +	mutex_unlock(&priv->reg_lock);
> +
> +	return res;
> +}

Should yt921x_dsa_port_del_dscp_prio() check the prio parameter before
resetting the DSCP mapping? The ocelot driver (ocelot_port_del_dscp_prio
in drivers/net/ethernet/mscc/ocelot.c) has a comment explaining that
during a "dcb app replace" command, the new entry is added first, then
the old entry is deleted. If the delete operation ignores the prio
parameter, it will incorrectly reset the newly-added mapping instead
of only deleting when the current priority matches the old one.

The ksz driver also checks this condition in ksz_port_del_dscp_prio().

Without this check, the sequence for "dcb app replace ... dscp X prio N"
followed by "dcb app replace ... dscp X prio M" would be:
  1. add dscp X -> prio M (correct)
  2. del dscp X, prio N (but code ignores prio N and resets to BK)
  3. result: dscp X -> BK instead of prio M

Perhaps something like this is needed:

  if (yt921x_dsa_port_get_dscp_prio(ds, port, dscp) != prio)
      return 0;

