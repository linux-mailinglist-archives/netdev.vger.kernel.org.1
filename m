Return-Path: <netdev+bounces-256962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK7sG9QlhGlRzwMAu9opvQ
	(envelope-from <netdev+bounces-256962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:08:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FDEEA18
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 06:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87F4E30055D9
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74792D6E78;
	Thu,  5 Feb 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lspoIFcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2D29DB8F;
	Thu,  5 Feb 2026 05:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268095; cv=none; b=Thwc/xcm++tJga2xCP2t/n9Th4ThwEBswnjXTfNft4wrtLMbuuOUceKNUskJcQ5yaXrO/0qEmY5Hx3k50HgpfLFafR5X2wjEV6rJeS5JBoeY4uomjvB2NrtdFeqzZNE9a+1/XFAZ4pnrcPLV8DjCcjaD1ECWwQh9e5G+QquFvmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268095; c=relaxed/simple;
	bh=inmDEKbqFTqXVQ5qF5Tjt+Mij9tKR0GACRGVtbrQBdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX9pvYekojIBfLyTC+ECFFuDqfschVbZ8+/UuYPA1ORYWK2iSR7803P3OK0jgXZCK6bisKnOddpF3BsGJY1ADqQgTSjuVP1ia19CwnZqlk5OsPvfT0s++BbzJmXttH9VF1oEoOUO9gX9pT2nKDNzfeIgxSn4hExeIf7oKKcA9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lspoIFcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2EC4CEF7;
	Thu,  5 Feb 2026 05:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268095;
	bh=inmDEKbqFTqXVQ5qF5Tjt+Mij9tKR0GACRGVtbrQBdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lspoIFcbaMfG73s4KgKC+4s9KylwRZ97G/LPrBTRgpbM9G5lc67pWQhLQ8NL2WFud
	 jDpC6x7SQ85hc0a3o/c9DUScEWFlekKHWFdlFMWAy8jxz15E1do3DcfoX40qPmB0fK
	 D8uUri15zg8Y4QuXoW8af2LMUlQODjqEfIF5plPdsZCfeZY8Bgxx8UYEuXBl+yrbTO
	 xzee3HS/m1vcv0YeUOyeJlEUjFYZX3ed1OD8RsGYnvJBnn5Lyk3hdodl+/gIfGty2P
	 qxeLil2WgWzYrt2kI/UPUb2qiVG4p+bCCdZLwWl4z3Z7AnpXGl/l1b22FJ3+ufuMFh
	 U5dV55176y/+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: mmyangfl@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch
Subject: Re: [net-next,2/3] net: dsa: yt921x: Return early for failed MIB read
Date: Wed,  4 Feb 2026 21:08:13 -0800
Message-ID: <20260205050813.2421675-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203171305.95085-3-mmyangfl@gmail.com>
References: <20260203171305.95085-3-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,vger.kernel.org,redhat.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-256962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A01FDEEA18
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: dsa: yt921x: Return early for failed MIB read

This patch refactors error handling in yt921x_read_mib() by checking
for read failures earlier and returning immediately, before attempting
to compute statistics from potentially incomplete data.

> net: dsa: yt921x: Return early for failed MIB read
>
> This patch does not change anything effectively, but serves as a
> prerequisite for another patch.

The claim "This patch does not change anything effectively" is not
accurate. The patch changes the behavior when MIB register reads fail.

Before the patch: If yt921x_reg_read() fails partway through the loop,
the function would still compute pp->rx_frames and pp->tx_frames using
the partially-read MIB values before returning the error code. The frame
counts would contain a mix of old values (for registers read before the
error) and new values (for registers read successfully).

After the patch: If yt921x_reg_read() fails, the function returns
immediately without updating pp->rx_frames and pp->tx_frames, leaving
them at their previous values from the last successful read.

This affects how five callers behave when reads fail:
  - yt921x_dsa_get_pause_stats()
  - yt921x_dsa_get_eth_mac_stats()
  - yt921x_dsa_get_rmon_stats()
  - yt921x_dsa_get_eth_ctrl_stats()
  - yt921x_dsa_get_ethtool_stats()

These functions don't check the return value, so they will now report
stale data from the last successful read instead of partially-updated
data from a failed read.

Should the commit message be updated to accurately describe this
behavior change?

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -714,6 +714,11 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  		WRITE_ONCE(*valp, val);
>  	}
>
> +	if (res) {
> +		print_port_err(dev, port, res, "read stats for");
> +		return res;
> +	}
> +
>  	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
>  			mib->rx_128_255byte + mib->rx_256_511byte +
>  			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> @@ -723,9 +728,7 @@
>  			mib->tx_512_1023byte + mib->tx_1024_1518byte +
>  			mib->tx_jumbo;
>
> -	if (res)
> -		print_port_err(dev, port, res, "read stats for");
> -	return res;
> +	return 0;
>  }
-- 
pw-bot: cr

