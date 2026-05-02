Return-Path: <netdev+bounces-283450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 845pAPsz9mktTAIAu9opvQ
	(envelope-from <netdev+bounces-283450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:27:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED24E4B30A0
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 19:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0977A3002500
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB63845C1;
	Sat,  2 May 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/a5kajj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D591301468;
	Sat,  2 May 2026 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777742837; cv=none; b=Y1jbl03mb0VToyqAJusRPsp18nbanExibCEiH3iSBvdZtMmZWfAbN/GVS4IWNJan7vBoRtPQz0S7JY/+YbAijreWO+bspNQXMeoCXdtVuWWrcdOT0M2joSCw5XVpOq/O/v57pDjGjH1JRse9nSOIQHqcZ5H72XtiYJqCc/Bq/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777742837; c=relaxed/simple;
	bh=iuYfZKUsNFsWCYPYDPPaNu+LCCi5oQDcfqzf4SNpk70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaQiauD94DMHH87YAfIXcsD0KRhn9p35LX1eiV5X7xYFfC594+beAjUAS/EfAIIQFHyG6FwgBXGg7H0G6G5iNlGYAi6YxqZ/K+9Qh9DgBioKH3aXiJu/V3rmyhgSkRwsLxtBqz4ORp+h89Z6RL1FwRxztZO4sYvNQPB7/Y8Uqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/a5kajj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A8C19425;
	Sat,  2 May 2026 17:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777742837;
	bh=iuYfZKUsNFsWCYPYDPPaNu+LCCi5oQDcfqzf4SNpk70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/a5kajjxzIX7CwRTkvhKQ0DYG8l2UfCCg5YkiLPBia0fvmdwd/b36WgPs/y3EOCf
	 Oba4ioqDlb4yliOCAqRiCn1t1j21Q0XXIa741i1Gj/u+YVjEgijMYDthLOeqPhxE/b
	 4FdfNHjgOiCLujSG60SEWhgQBijMV5dPTbJqPp2neSrXywc+3gBNMw8+6bGb080S5s
	 SrxIIa5+ERxkrmONbsucmHHWWO+khgtawrjGPuqRd5oT3GoGvzD3vYwSOTIXilwXnD
	 lISSAZ3Wh4Ts6VMB2fCVE8DGre5lt4VpkJg6i1OZwU14Twa9Yx6NzYl3tvLAXYcUgZ
	 ZpzVXnW8Cwe3Q==
Date: Sat, 2 May 2026 10:27:15 -0700
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
Subject: Re: [PATCH v7 net-next 2/8] dpll: allow registering FW-identified
 pin with a different DPLL
Message-ID: <20260502102715.2ac364c8@kernel.org>
In-Reply-To: <20260430094238.987976-3-grzegorz.nitka@intel.com>
References: <20260430094238.987976-1-grzegorz.nitka@intel.com>
	<20260430094238.987976-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED24E4B30A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283450-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 11:42:32 +0200 Grzegorz Nitka wrote:
> Relax the (module, clock_id) equality requirement when registering a
> pin identified by firmware (pin->fwnode). Some platforms associate a
> FW-described pin with a DPLL instance that differs from the pin's
> (module, clock_id) tuple. For such pins, permit registration without
> requiring the strict match. Non-FW pins still require equality.

AI asks what prevents the modules from disappearing:

Does this relaxed check expose pin->module to a use-after-free during
netlink queries?
If module A registers a firmware-described pin allocated by module B,
they will have different module pointers. 
Because fwnode_dpll_pin_find() increases the pin's refcount but does
not take a reference to module B via try_module_get(), it appears module B
could be unloaded while module A still holds an active reference to the pin.
When module B unloads, its struct module memory is freed, leaving
pin->module as a dangling pointer.
A subsequent user-space Netlink query using DPLL_CMD_PIN_GET iterates over
the registered pins and calls nla_put_string() with module_name(pin->module),
which would dereference the freed module memory.

