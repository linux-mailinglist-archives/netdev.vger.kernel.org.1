Return-Path: <netdev+bounces-266377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3nYnMYirsGnflwIAu9opvQ
	(envelope-from <netdev+bounces-266377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:38:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500C2594CD
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E64F3051463
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C83783A2;
	Tue, 10 Mar 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj6CyWLS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885C363C51
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185925; cv=none; b=T4xePy1a92JhnCyPNSW9eVtZUPlcTJu1GyCwQQCS1NTlKTjowHmql4nAnOkQzoxFDRK8Ya7+2MzMZo7+e9jlOpU9zYrTk0nEMxahiYpFDlBsEZ03RfEOxJTUL5oXBfPk09SBZwd1c81Gke2Vul3QA/Foy9GlpnRvENkUkdHZf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185925; c=relaxed/simple;
	bh=ojiXvpP7i21cNwmHmFAHmwnvjKQ6gz9OdecP7pefKkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1HlAcTtUNRI6bnexwB0OxXfmtK2Thd7wptBKArNzVV0fAf4nQqkqOLR30VoObmQJ7wd+1hmlpLimW3s/wOJX/FxW8DHPuw4MemFOZAaMHbG89jX61m+RxgnPnqTJnpxk1RGN4OkYA3jFn2d5NTkzNKWQj4FUv+dAKRlZjDbTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj6CyWLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A99C19423;
	Tue, 10 Mar 2026 23:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773185925;
	bh=ojiXvpP7i21cNwmHmFAHmwnvjKQ6gz9OdecP7pefKkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gj6CyWLSeQKZc82mFPhnCEowzLLoZ3bd9eE1mHkqjSfHxZPUpD17JglKfTAipTPmF
	 iLtfP5zQwO67XIwtKZ+DXvrEycj/CTetpCmChUX08Im+MewEjlNPW4+wv4Hl6LEaOh
	 VsvO1KZVmgCD7NHCkQ7rFojngetpDiPaMk8YdAliIEIQ4Ezc1+dkb6goSV52eSFB1G
	 b7fio8dWxLGPEI0Qk53zvYGNGYosxh9dGWgD5V9QPfxkBNWphY39q+uazrPdsM/Vc6
	 IroM0dPBznSg0S6flOLxT5P4fhHH5PR1ovxKx/2h8JyivhgEMi4qvSr8oEBz12iOsR
	 S2EGDJ6nBF8qg==
Date: Tue, 10 Mar 2026 16:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] netdevsim: generalize taprio offload
Message-ID: <20260310163844.58f66f93@kernel.org>
In-Reply-To: <52ae15a7e42d7754487bb744c1a1718246d032ef.1773165520.git.dcaratti@redhat.com>
References: <cover.1773165520.git.dcaratti@redhat.com>
	<52ae15a7e42d7754487bb744c1a1718246d032ef.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2500C2594CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266377-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 19:06:29 +0100 Davide Caratti wrote:
> -static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
> -{
> -	stats->window_drops = 0;
> -	stats->tx_overruns = 0;
> -}
> +static LIST_HEAD(nsim_block_cb_list);
>  
> -static int nsim_setup_tc_taprio(struct net_device *dev,
> -				struct tc_taprio_qopt_offload *offload)
> -{
> -	int err = 0;
> -
> -	switch (offload->cmd) {
> -	case TAPRIO_CMD_REPLACE:
> -	case TAPRIO_CMD_DESTROY:
> -		break;
> -	case TAPRIO_CMD_STATS:
> -		nsim_taprio_stats(&offload->stats);
> -		break;
> -	default:
> -		err = -EOPNOTSUPP;
> -	}
> +#define QDISC_OFFLOAD_HANDLERS(X)					\
> +	X(taprio, tc_taprio_qopt_offload, cmd, TAPRIO_CMD_REPLACE,	\
> +	  TAPRIO_CMD_DESTROY, TAPRIO_CMD_STATS, stats)			\
>  
> -	return err;
> +#define QH(NAME, OL_TYPE, CMD_FLD, O_REPLACE, O_DESTROY, O_STATS, STATS_FLD) \
> +static int handle_##NAME(struct net_device *dev, struct OL_TYPE *offload) \
> +{									\
> +	switch (offload->CMD_FLD) {					\
> +	case O_REPLACE:							\
> +	case O_DESTROY:							\
> +		/* Do nothing, accept offload */			\
> +		return 0;						\
> +	case O_STATS:							\
> +		/* Zero out the requested stats block */		\
> +		memset(&offload->STATS_FLD, 0, sizeof(offload->STATS_FLD)); \
> +		return 0;						\
> +	default:							\
> +		return -EOPNOTSUPP;					\
> +	}								\
>  }
>  
> -static LIST_HEAD(nsim_block_cb_list);
> +QDISC_OFFLOAD_HANDLERS(QH)
> +#undef QH

Please just type the code in. These sort of macros are too ugly to live
in code I directly maintain, sorry.
-- 
pw-bot: cr

