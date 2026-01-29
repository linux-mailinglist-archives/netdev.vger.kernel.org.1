Return-Path: <netdev+bounces-254805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIu8B2xhe2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:32:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F48B0687
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E8C30071F3
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A610E2FFFB5;
	Thu, 29 Jan 2026 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lZtFhp/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgCzt01A"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D2A2F360A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693543; cv=none; b=NaDGiWiIxidlt4W41gr7LEDsu4J78TavHwDjRmEiyapBIuR/q+hIzGmByTPSP0s7W57Y8LVeR+5dGdO48yqZgisbDTi7hf3Et/tCBnTnHm/jmbSvdJk+TaGmHux+CaaoV8+WHopwb1jQvN6NNoME9pJGpOa1gt/X/pXq4Z8grxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693543; c=relaxed/simple;
	bh=acr+l+n5uELIpTITkxqlcC0HuyiXv9eaM40kwXcyjGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0cNaw+rJXN6Vi7u1KaF3zt2QuBZlET8ke/VGoDAC/w5HCMBNuW/bPV4CdmNU9fhAKscdfeAcYbvgu66YfakNsSAlL1nA6hyvBrAWtoCEQeaaudjDV1LEYsGUV36gQE8prV5a+InyMBr4lEvm72hGkxHVF4bnp8wUFDcBvfuWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lZtFhp/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgCzt01A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 14:32:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769693539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZkDa4VE6zcXB0OuRLMsj/2QJ59tGffpRG45d25eYRw=;
	b=lZtFhp/jrtI5+ZUUGCc4dCf+dQe8zHXJi9mcWrvDMYraiToP2eVyWDO8HzK4c4cFFiGPZM
	kh6FeuRFU3UqUA8DVvNwXRB+51iuvOABUDR0xB2hICO6MIig+VyJAmDQ5PGg5taIBj3b1Z
	FZLDlWRop16l7Wl4jVWYXrE44iSfPeYu+Q9nD+5kmIMOb2CUF0HfmIaKSvEin1EnjBOARn
	wQK5P6juBZEnQTyjQ1j5Wr6vR0h9emSHn6OV7GFWQf1Kcb4BrfuCMNiEPBhwWm/46VTyA+
	FXViBzN+QRNDx/XTR0l6FiJBcziPO6wZPuw9m/of5I3akJZYNppmaLmDl7eWSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769693539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZkDa4VE6zcXB0OuRLMsj/2QJ59tGffpRG45d25eYRw=;
	b=FgCzt01AgnSirlptXjeks5e3vFOVxgNQ7QqwniuxrXswHYQRwnIB1AwRToSjf2b7WSlt4D
	f+jHSvy17mc2KCAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 5/9] selftests: hsr: Add tests for more link
 faults with PRP
Message-ID: <20260129133217.xNoDm9nn@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <774d7a2327d1c05b78ee30ac21297794bfcb0245.1769093335.git.fmaurer@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254805-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2F48B0687
X-Rspamd-Action: no action

On 2026-01-22 15:57:00 [+0100], Felix Maurer wrote:
> Add tests where one link has different rates of packet loss or reorders
> packets. PRP should still be able to recover from these link faults and
> show no packet loss.  However, it is acceptable to receive some level of
> duplicate packets. This matches the current specification (IEC
> 62439-3:2021) of the duplicate discard algorithm that requires it to be
> "designed such that it never rejects a legitimate frame, while occasional
> acceptance of a duplicate can be tolerated." The rate of acceptable
> duplicates in this test is intentionally high (10%) to make the test
> stable, the values I observed in the worst test cases (20% loss) are around
> 5% duplicates.

Do you know why we have the duplicates? It is because of the high
sending rate at which point the blocks are dropped and we can't
recognise the duplicate?

> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Sebastian

