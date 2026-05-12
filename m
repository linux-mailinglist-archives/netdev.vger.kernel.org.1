Return-Path: <netdev+bounces-287017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KTFJmrwAmrpywEAu9opvQ
	(envelope-from <netdev+bounces-287017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C951D800
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF48830C5809
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBA3B19BB;
	Tue, 12 May 2026 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNCRQlZm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0AC3AEF58;
	Tue, 12 May 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577132; cv=none; b=HibUky1KHPVHkpkVk+FhVV0+OsVE8wvraR1kKW7CaaOzid/qVrpLcM5+jnEBrzjHIoJbFju9xFecnsrBqPJD2+hC+mSSlbK9djAVV7pwvUOGFrRK1dljduVc7KUVZYcHWHySySXe0jz9obodLmyIXbqA2643S/TxaHYiT8xQ7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577132; c=relaxed/simple;
	bh=ASUr0cAjHB2oNYvQBT8q+pwOY1rqCRztmrKEFxoQHPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmkDIsi8J7NZ2OLqJlYquRxd2d272S9qe0/XA2DWX0NOaIdiQ1h9XP6q9c5cPRSLPTYNUq1ba/UwHmubVwtQWzLFvo4jvmTjVWSX+yJsPvJ6TwGVdTg0HXTNeMUxdCwuLLWJh0cvdQxpmGiwBjwMwg+3nwon6UlgVBDzableQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNCRQlZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62856C2BCF5;
	Tue, 12 May 2026 09:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778577131;
	bh=ASUr0cAjHB2oNYvQBT8q+pwOY1rqCRztmrKEFxoQHPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNCRQlZm1SjRYfiofTkP/+vGlRXOOzTlKxK2Lu6fw4FJq/M64qik5ein6WwVIHWTq
	 XlTaEu8CQtwTIXo5Rk/4BdvD/cm4yy1UY3j6ZZZQo2SQEii9l8LS6/Q4yKiIFKstS2
	 qi9PqdHKoFRriInA4IEvIx+bTvdOObceYPxkubYhRKwnSI8v/e41HaZhd00737X9kW
	 AUdrTUuB8M/frdSkHtJYahg8O/c4xbETaAPDJ3yvUxWJfKVGQE7tVF2dWpCSBwNsfk
	 8RUNjHV1zZkqZ/3hMkOFFZfCrY3tJ+qXBA98g9FE2JMpeiHMXdtDO0GlVSzkzL8BbM
	 O2X3wbXR5QRyQ==
From: Simon Horman <horms@kernel.org>
To: mmyangfl@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Add port TBF support
Date: Tue, 12 May 2026 10:10:27 +0100
Message-ID: <20260512091026.279150-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508065757.2566258-3-mmyangfl@gmail.com>
References: <20260508065757.2566258-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F3C951D800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-287017-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: dsa: yt921x: Add port TBF support

This commit adds support for configuring the egress shaper via the
TC_SETUP_QDISC_TBF offload in the yt921x driver.

> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index 42dca9617fb17..c5af64ea0c326 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
[ ... ]
> +static int
> +yt921x_dsa_port_setup_tc_tbf_port(struct dsa_switch *ds, int port,
> +				  const struct tc_tbf_qopt_offload *qopt)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct netlink_ext_ack *extack = qopt->extack;
> +	u32 ctrls[2];
> +	int res;
> +
> +	if (qopt->parent != TC_H_ROOT)
> +		return -EOPNOTSUPP;
> +
> +	switch (qopt->command) {
> +	case TC_TBF_STATS:
> +		return 0;

Is it intended to return 0 here without populating the hardware statistics?

When the driver handles this command by returning 0 without modifying
qopt->stats, it incorrectly signals to the TC core that hardware statistics
were successfully fetched. As a result, the subsystem will report
unmodified (typically zeroed) statistics, which hides any packets shaped
or dropped by the hardware.

Should this read the hardware statistic registers (like the newly defined
YT921X_PORTn_SHAPE_STAT) to update qopt->stats, or alternatively return
-EOPNOTSUPP to indicate a lack of support?

