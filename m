Return-Path: <netdev+bounces-302287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3VwAN6YhP2p/PAkAu9opvQ
	(envelope-from <netdev+bounces-302287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:04:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254E6D0AC5
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:04:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cZkmGFrM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302287-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302287-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 715F5301983C
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DCD21D596;
	Sat, 27 Jun 2026 01:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6E2F84F;
	Sat, 27 Jun 2026 01:04:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522276; cv=none; b=nbniuM2AsWI+2H4S8PCXQuBEAeVv4F3/mNddxhxUUbAJ00pE6nm9D3UxiVjSKwhVEN6i/CrCUnt2aXZH7U9b14bRjq9fJ3Nk57SYMBLGA0UVPXx5AS83oUD5LWkcIRZ1ofPYIbZLdtCEDujFvTNT/gjF1uVFPO87IjMYssllE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522276; c=relaxed/simple;
	bh=mZeJONeWC2+4NAO16Z4Q4zs8uJzgi3MSlcGjfB7ggDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edjp/CcFgl9uLrOQP5XalyKMsVKNRXRJmGKIjcVkII4U8fn4KrWWbgbmvkXTaP9n1AAF709O50m7YfvSDdcgwkR31SDV8/xsV+zvJ5B/dV1DrB1c604RHVnWRUbR3gXF4vaAUuwd6Ql+ZVLNTstiDaJjpKGkl+fGmkSeQcSORsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZkmGFrM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A5F1F000E9;
	Sat, 27 Jun 2026 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522275;
	bh=mZeJONeWC2+4NAO16Z4Q4zs8uJzgi3MSlcGjfB7ggDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cZkmGFrMR+ImhXOM5F3WmWB0SGF7d+fViBKGBWx3xpkybsMYL8p3PIwd6jDnc1vqX
	 h44GKaSG/LFK16roKmJWyf863RHH8ebjl864/j3bkR1wILR9UKAERU2xEiVqEBawZq
	 Gf9IqDWqicQbp8Z9CDHx14AwXK1Vl8uuGMmHW/yHjisjDLKUnyh9pwOSNFNN9Tm4e6
	 nm0ocNA7giTXBnBtgbRjREHZ2TeLhWttJyMg7X+GtCj+ONTZPS3rid53NlMH/zS6wL
	 ObPppVDRndlKjCI8nEf2XsUYu/UgpKIFxG+xVlFsKGRYXbqCQUVGitBH5zcsY2XCM+
	 vVAh9QiBLAefw==
Date: Fri, 26 Jun 2026 18:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 eperezma@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update Jason Wang's email address
Message-ID: <20260626180433.3e302324@kernel.org>
In-Reply-To: <20260626022039.96139-1-jasowang@redhat.com>
References: <20260626022039.96139-1-jasowang@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302287-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jasowang@redhat.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:eperezma@redhat.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6254E6D0AC5

On Fri, 26 Jun 2026 10:20:38 +0800 Jason Wang wrote:
> I will use jasowangio@gmail.com for future review and discussion

Do you want to add a mailmap entry, too?
Otherwise I think you'll get CCed twice (once for MAINTAINERS and once
because you given tags to previous changes)

