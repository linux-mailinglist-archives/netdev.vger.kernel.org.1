Return-Path: <netdev+bounces-267761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a3BpKoqGtWnP1QAAu9opvQ
	(envelope-from <netdev+bounces-267761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:02:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A228DC3A
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A37E4300AD82
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277DB26ED3E;
	Sat, 14 Mar 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Z+BVyB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044721A8F97
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504132; cv=none; b=uxMrMseRPRPl2W2p3aLBttYeQDD5DNlOE4rWoqNU605tnAVrMryHnsvmupj7OYSDY/T6GdKgSSip+gkFnu9CfeVKrUJzUSEEvdtpjgUynx5kyhzu5IcbQoWd9qJiHVXnOndToq+OPwVOKHvH0PTjWLlU0hjH9YkBI3OSAxzPKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504132; c=relaxed/simple;
	bh=Smcm86Ij1wsWitZt1z9fSB9bWtP35J/tCMhsdyLFYDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J212A1hzEHyu0niCH5G+t74rziZj7nMZAca3jl7lqoxMCYC95y8FMtQpHfB4vQrlDihhLmyB6ucRhFdHy6ZUuH+RJHF+j/3boBa4tuAt6RpnUne68U4BoznxcMaV8kLrjYxkerJEB3eYaOsCmwCdLjHWAfnCjjFnmDTU1+E8wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Z+BVyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5280BC2BC86;
	Sat, 14 Mar 2026 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773504131;
	bh=Smcm86Ij1wsWitZt1z9fSB9bWtP35J/tCMhsdyLFYDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7Z+BVyB9shwymR5Y++VcuaD03uITEu/0nRBYKOGXX/8FzxvwhFrYIz6TOAjflTxF
	 v8Ot8Al8joDc3MJVkK/B0Pn2YJs+vMC09xA7r5Vvl199uu3x9Gye6Zr2NutHX5j/wT
	 eS7wUUVkUuz+6ndeecq7vFtOTCpW8xJAS8XcVrbgBUkAFS5/K5r8EyWYSOOzz+ka41
	 w17Jx17rgsookS3pw9qnIgHprbPmqJgVJkuEt3NRj1cyTTUPSIYyzRBBoe+U/9qisQ
	 AJu8UYiWG9x5x/4HAjj9ruISs6Z3RhAFk0aQCYdtkd7A8thcbahcmaO1iNCappXd7T
	 Uhz9hdvF/y8sA==
Date: Sat, 14 Mar 2026 09:02:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] netdevsim: move TC offload code to a
 dedicated file
Message-ID: <20260314090210.0b7260d4@kernel.org>
In-Reply-To: <b9c3cab13359044df5e8fe52f47c09cf37754e92.1773411667.git.dcaratti@redhat.com>
References: <cover.1773411667.git.dcaratti@redhat.com>
	<b9c3cab13359044df5e8fe52f47c09cf37754e92.1773411667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267761-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 794A228DC3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 18:23:56 +0100 Davide Caratti wrote:
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index f767fc8a7505..fdd35ab29d98 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -470,3 +470,6 @@ struct nsim_bus_dev {
>  
>  int nsim_bus_init(void);
>  void nsim_bus_exit(void);
> +
> +int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
> +		  void *type_data);

Put this above struct nsim_bus_dev please

