Return-Path: <netdev+bounces-302288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YBS+EloiP2qrPAkAu9opvQ
	(envelope-from <netdev+bounces-302288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:07:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F86D0AD8
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hz3k8gLP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302288-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 493B83006232
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE8221F20;
	Sat, 27 Jun 2026 01:07:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5A19E96D;
	Sat, 27 Jun 2026 01:07:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522452; cv=none; b=BYLKB9oaViN/5xfR5IIl1+2enH6pmkEplUgmUGg19q6+JjM+AGHkEEH3+C5iDjLnz1DJgVAmVTs0afn5nBIyjkmcx5YEq4l8mYCeO6ls0tDvoa4tHC7Zg06kkVFFvwaKP0VqwuhLstg81yIYJxOjTBY8enZHW4kED+Yo23xhpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522452; c=relaxed/simple;
	bh=vpIvxoKQKFfhXA+X6SFekX2JrlijPsGH42zskx/uscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju18I2td5oQ3/Ji96US+5SU448nLOWtVMRmfO2lqN2O+r+tLdobcKzXkhAWCoasrRI3fpAK6Fe1MEu0lj7KdhZsbDSqbcEoSXMTZMe1rm36lVQa7aQ4+g669jA8vmho5Xu473Cha9JKRYfNacUi8yiE2OD6UoCaUdtMXFtv+7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz3k8gLP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA971F000E9;
	Sat, 27 Jun 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522451;
	bh=BkGX+usI/fxfwPaRgM4lPTX8bSxwTJJ7MAR255BYggY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hz3k8gLP8rPJyrjt+nEFqBgSY1elMbl0fKWxaTMYraLF8+RtZ9mkQ8YDxDqtxHgAJ
	 IxrsmpbyaGgWwroXoLVI3bihMiX7F4aGUsBVWIuJc4tkAF1iWky7WUjVO3bYhiPFci
	 8sR4+2dFJAsbt2WRnQmyrF05mwo4NFQCxA63LB0dAFFnuFkpSn3dvLB61Py28PsnCU
	 fka3P1xnj5IMNvj/9iDYYBH2YxQAWTASRqBYySgG91TxWVVNQVOZNRDhLtTzsBGQgX
	 NB4eUR04x+kjSy674m/Oo0TTYnb4CPT9PNGYI9i0nTBih3Cs5ZD52sN/EXdcNscmPU
	 VU8cZGjt+K2Mw==
Date: Fri, 26 Jun 2026 18:07:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] caif: annotate phyinfo lookup under config
 lock
Message-ID: <20260626180730.42eb297b@kernel.org>
In-Reply-To: <20260626042440.2013499-1-runyu.xiao@seu.edu.cn>
References: <20260626042440.2013499-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302288-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 325F86D0AD8

On Fri, 26 Jun 2026 12:24:40 +0800 Runyu Xiao wrote:
> cfcnfg_get_phyinfo_rcu() is used by both RCU read-side paths and config
> update paths that hold cnfg->lock before adding or deleting entries from
> cnfg->phys. The helper walks the list with list_for_each_entry_rcu(),
> but does not tell lockdep about the config-lock-protected callers.
> 
> Pass lockdep_is_held(&cnfg->lock) to the iterator. RCU-reader callers
> remain valid, and CONFIG_PROVE_RCU_LIST can now see the non-RCU
> protection used by the add/delete paths.
> 
> This was found by our static analysis tool and then manually reviewed
> against the current tree. The dynamic triage evidence is a
> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> to documenting the existing protection contract.

This code was removed a couple of releases ago.

