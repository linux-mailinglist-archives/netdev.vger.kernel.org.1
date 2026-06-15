Return-Path: <netdev+bounces-299616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RdrSCkFnMGrySgUAu9opvQ
	(envelope-from <netdev+bounces-299616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:57:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B638868A126
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gYl0DjZ5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C356300CB2A
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC52E3AE19B;
	Mon, 15 Jun 2026 20:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F33B6366
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:57:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557055; cv=none; b=NeCHU+8/4VzPGnbKe/33O3Mis7bTyw7EkevEx6g6enZcdnB7t5bPPLaWhZcR1u6OlJxn3+6itwN+zo6pbftZZWxnkjMH2F3Mee/XTZkaIpkaaM27tbGgk1gX9TIzYVELdxwWHrjiSmActP9tHNn7abX2SNz2uGElQWI2Y8C6EKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557055; c=relaxed/simple;
	bh=YgWz6K0NTvDB81mFnQwWiW0hOf9tgkdMYaAvHvM/j3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgHkeTnWlzJbZBpP99hCQFO+DIjCH9DWZJRHbyAtgG41PyKRye3TcrIjFIRrK1oGg1HqWLvpZo9c4LMH8+YBlfSqQGdqFtB6wLMkNkiYDSfWXztRFn5zsCywN0XYev/WawMnLi83hqmNhwrdtycNz9FDy4hs5hlHlwIg9S8w1QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYl0DjZ5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049E31F000E9;
	Mon, 15 Jun 2026 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557054;
	bh=ePVcjmagvb9z3F60PKoau1le/WC48TdGbEMixoGqzgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gYl0DjZ5H+AXUNDXgomxyLKy6xVDaNhfqySf7a1Ug99VYCxphxNE7czrhv0gl1JH7
	 LMF9RATpMZUAxnZLOR7neCZdXDFCWAJ8fol2X2ffG7XlYUrPafjWTgZO3Y+FRpcfyW
	 0u4SJxO8P/h0JRMc+NksW6MFjP0ZC9+CWkh2pmFYJgCg/QvXkaJwXyvNqgGeWKKsoV
	 mhCMj/Nekr7x71Jv1G4uV1mkF2+93BWbvt9O17Pg9f59fmkHFhrnShsz+UtAayjygO
	 e+JgCv5vkZUGzOmOo/hw+rhi+x/9sm+7emKR4/6C8fHp1kpoTZea8MfIiG3QrnRoIa
	 jCaYhGJHXUruA==
Date: Mon, 15 Jun 2026 13:57:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v3 09/15] bnxt_en: Add infrastructure for
 crypto key context IDs
Message-ID: <20260615135733.281f0d94@kernel.org>
In-Reply-To: <20260614072407.2761092-10-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
	<20260614072407.2761092-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299616-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B638868A126

On Sun, 14 Jun 2026 00:24:01 -0700 Michael Chan wrote:
> Each kTLS connection requires a crypto key context ID (KID).  These KIDs
> are allocated from the firmware in batches.  Add data structure to store
> these IDs.  The bnxt_kid_info structure stores a batch of IDs and it can be
> linked as we allocate more batches.  There is a bitmap in the structure
> to keep track of which ones are in use.  Add APIs to allocate and free
> these KIDs.

../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:283:7: warning: variable 'kctx_tx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  283 |                 if (retry_cnt++ > KTLS_RETRY_MAX) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:319:8: note: uninitialized use occurs here
  319 |         kfree(kctx_tx);
      |               ^~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:283:3: note: remove the 'if' if its condition is always false
  283 |                 if (retry_cnt++ > KTLS_RETRY_MAX) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  284 |                         atomic64_inc(&ktls->counters[BNXT_KTLS_ERR_RETRY_EXCEEDED]);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  285 |                         netdev_warn(dev, "%s timed out waiting for device, state %lx\n",
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  286 |                                     __func__, bp->state);
      |                                     ~~~~~~~~~~~~~~~~~~~~~
  287 |                         goto free;
      |                         ~~~~~~~~~~
  288 |                 }
      |                 ~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:277:7: warning: variable 'kctx_tx' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
  277 |                 if (!netif_running(dev) ||
      |                     ^~~~~~~~~~~~~~~~~~~~~~
  278 |                     test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
      |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:319:8: note: uninitialized use occurs here
  319 |         kfree(kctx_tx);
      |               ^~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:277:3: note: remove the 'if' if its condition is always false
  277 |                 if (!netif_running(dev) ||
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
  278 |                     test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
      |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  279 |                         goto free;
      |                         ~~~~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:277:7: warning: variable 'kctx_tx' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
  277 |                 if (!netif_running(dev) ||
      |                     ^~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:319:8: note: uninitialized use occurs here
  319 |         kfree(kctx_tx);
      |               ^~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:277:7: note: remove the '||' if its condition is always false
  277 |                 if (!netif_running(dev) ||
      |                     ^~~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c:260:42: note: initialize the variable 'kctx_tx' to silence this warning
  260 |         struct bnxt_ktls_offload_ctx_tx *kctx_tx;
      |                                                 ^
      |                                                  = NULL
-- 
pw-bot: cr

