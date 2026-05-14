Return-Path: <netdev+bounces-287783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI3jARUwBWr9TAIAu9opvQ
	(envelope-from <netdev+bounces-287783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:14:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877D53CF5B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAAE03020121
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5F3314C5;
	Thu, 14 May 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH7sqF9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A0330668;
	Thu, 14 May 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724876; cv=none; b=UuvrkiTQS3p4CyCRWTmFiBDHMaOPUWJocQZ4XwjCoaRuTtI6A+RJNFmHwqvYmdwUOa3Sm5SBP92wHYf8DUeJgJTlYJ89grMp9IcN5HoMCpKbafdWy0yxmi3RWfcBndV8Tv4IsKxGICm+EDwClPqQflM4zGRmZZvtzd1U6zEIKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724876; c=relaxed/simple;
	bh=G/iBw356i6FwwNFaRGJcDFTyhXVbkFhL5HSpQTP3Iwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndU8yBgyC4GdJK2RFi0SU4zracXXMrpRQ71tgVHfh6DpdgvLLFKRJMe/4wp8zKsipIJfcDolMUScG6JO0IAS36YAJ8DA7dbT7ZMuNFtI5EFfnfkDcrfe8NL+SObpC4AHCXBNySGxOR4Jfils0k+7KEjHnhMHVcYyLpIxLX46qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH7sqF9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BEC19425;
	Thu, 14 May 2026 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724876;
	bh=G/iBw356i6FwwNFaRGJcDFTyhXVbkFhL5HSpQTP3Iwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bH7sqF9vhCpKUOclspI6MDe9PtkaGG/fsJ8QmG3hFxDk1aKKIhYT6O79lK8N/mOU0
	 qlmsuLsHo6Juq4ajoabBOc56Oz/wCYHtEl2pHqFbb9qBPNgOYoL4ihbpfWoZX4Nu9t
	 5DA7aEsALv4g0Xv5Ex9xP3he8wsWbq59LwWu9RhIDzzguAZdE27851sdDNotmlrUBq
	 UMqy04RwmCWTEmVFmaBZEohgEs332uWGt+mBeZQN110JAZCEtuwS3tnnzbM9VMUQgm
	 pkdxGeHJVe/l2ZZo6YfzToAcUmuUecRRoqeIzWQF2E/mVfeBju1eodTCcb72JALyzt
	 9XwfBXUacRv7w==
Date: Wed, 13 May 2026 19:14:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, poros@redhat.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 Prathosh.Satish@microchip.com, ivecera@redhat.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, vadim.fedorenko@linux.dev,
 donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, Jiri Pirko <jiri@nvidia.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v8 net-next 2/8] dpll: allow registering FW-identified
 pin with a different DPLL
Message-ID: <20260513191434.7db663fe@kernel.org>
In-Reply-To: <20260511233159.2558165-3-grzegorz.nitka@intel.com>
References: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
	<20260511233159.2558165-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9877D53CF5B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287783-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 01:31:53 +0200 Grzegorz Nitka wrote:
> --- a/drivers/dpll/dpll_core.h
> +++ b/drivers/dpll/dpll_core.h
> @@ -59,6 +59,7 @@ struct dpll_pin {
>  	u32 pin_idx;
>  	u64 clock_id;
>  	struct module *module;
> +	char module_name[MODULE_NAME_LEN];
>  	struct fwnode_handle *fwnode;
>  	struct xarray dpll_refs;
>  	struct xarray parent_refs;


Warning: drivers/dpll/dpll_core.h:70 struct member 'module_name' not described in 'dpll_pin'
-- 
pw-bot: cr

