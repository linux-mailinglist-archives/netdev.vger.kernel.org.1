Return-Path: <netdev+bounces-301338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9eiBipgOmrp7QcAu9opvQ
	(envelope-from <netdev+bounces-301338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:30:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF66B6490
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:30:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hldRoK8v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301338-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C165301A12C
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733B3B42D3;
	Tue, 23 Jun 2026 10:29:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AC35200A;
	Tue, 23 Jun 2026 10:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210597; cv=none; b=CN2AD3C5PT9XHTDeXd7oi7WViQEXGFWPFCrlH9YdNC84HwZL7jc2I66PE/tFPIlqlx43ecqO6lvpkQvI2FAG3kMxc6ji2fm0vly+2fwUKDqDX9y5nXheNsoK72huo1dkSvg6tKW48kbC1IA+FXvbU5cSdVqE3lS6WSOQLwxbxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210597; c=relaxed/simple;
	bh=sAG2e6gDVhDw/IMNqh2cES6ptv4l5e7DQ7s0H/IcCeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEE18QeDX003mx3c18MZw4ouZibFnngiyVCbpQdEydoG+dfQExvWtSNDOwikVp+4B59qo7kbMPtw8USM7PELqOVh8dEmhDq4svqNGE7idvUkQ5oxhJesZ6/934wOXIuFeKM5OjK2IjQ7ZlgZAbB4wdY1YQ1iPtVUUJFp12eE4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hldRoK8v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985471F000E9;
	Tue, 23 Jun 2026 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782210596;
	bh=7T1CU5SSShDw0aJ9KVYUgQhuWKn/RhlR48iRi5suHSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hldRoK8vcpn7kEthG8alQzSf9gF2SaT6ZvQLwwP/WpSnZHbTrSJaeQzykQjKQv4OW
	 bUk3ic3Ua2enzhh8wA9tt1SSv86e7xsKb9LBy6yLxffWTqULMaTzer1ETP6W4vGL1C
	 hsO7N28i9oeDbDpZ5AC4HiBfVFcJUMJiFAIQyRINGAXSwAJ5NofUv/Ne2jMoVuCYS2
	 130Rvc7zknfhC3MlmVDMZMlV/goMSXobtzsFcBvLmGpSpakIwJ+6fyWQeUW/hNBbVl
	 laEx8Rix5+b0CxuyEqDSh+XwszZqPej60MvjCQnWvdsH6hPMxTX8UNWukO+lYefsnt
	 5UcKC2eGY0H+g==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: clear the default forwarding VSI rule when releasing a VSI
Date: Tue, 23 Jun 2026 11:29:34 +0100
Message-ID: <20260623102934.1072800-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622081030.2312129-1-poros@redhat.com>
References: <20260622081030.2312129-1-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301338-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:poros@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CCF66B6490

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: clear the default forwarding VSI rule when releasing a VSI

This patch restores the cleanup of the default forwarding VSI rule
in ice_vsi_release(), clearing it when the VSI owns it. This prevents
a rule leak if a trusted VF enters promiscuous mode and is then destroyed.

> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2871,6 +2871,9 @@ int ice_vsi_release(struct ice_vsi *vsi)
>  		return -ENODEV;
>  	pf = vsi->back;
>  
> +	if (ice_is_vsi_dflt_vsi(vsi))
> +		ice_clear_dflt_vsi(vsi);
> +

[Severity: High]
Is there a time-of-check to time-of-use race here?

ice_is_vsi_dflt_vsi() acquires and releases the filt_rule_lock to check if
the current VSI is the default. If true, ice_clear_dflt_vsi() is called,
which acquires the lock again during rule removal.

If the lock is dropped between these two calls, could another thread
establish a new default VSI rule before ice_clear_dflt_vsi() runs?

When ice_clear_dflt_vsi() executes, it appears the rule search only matches
by l_data and flag:

ice_switch.c:ice_find_rule_entry() {
	if (!memcmp(&f_info->l_data, &list_itr->fltr_info.l_data,
		    sizeof(f_info->l_data)) &&
	    f_info->flag == list_itr->fltr_info.flag) {
        ...
}

For the default VSI rule, l_data is empty, so it might match any newly
established default rule.

And since ice_remove_rule_internal() does not appear to validate the
vsi_handle for non-list rules:

ice_switch.c:ice_remove_rule_internal() {
	if (list_elem->fltr_info.fltr_act != ICE_FWD_TO_VSI_LIST) {
		remove_rule = true;
        ...
}

Could this blindly remove the default forwarding configuration for a
completely unrelated VSI?

>  	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
>  		ice_rss_clean(vsi);

