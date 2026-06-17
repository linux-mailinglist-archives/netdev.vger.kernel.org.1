Return-Path: <netdev+bounces-300248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mkEWNTkTM2qt9AUAu9opvQ
	(envelope-from <netdev+bounces-300248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:35:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCD769C897
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gYHJW721;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300248-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37DCF3008633
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FD13B0ADF;
	Wed, 17 Jun 2026 21:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE33B8413;
	Wed, 17 Jun 2026 21:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732148; cv=none; b=gCJApUPhBK64F2WpGv3r14qmrIXN8PRLQC8zZBkXIt8mMmawDwhg6paPn1DpK7pgT0EkD+JcbomtlPJj9366NKhO6WqyquYk74+AY7i+AjV+q49n9/XazMMKLjKHSayw4DgW9qIckiknDwbdfKYgwRDkCDAK4m0fCrwam4lDCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732148; c=relaxed/simple;
	bh=4zM0t/NNS0aXX/L0toG6tdWJncYQSTlT23kpgauvtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXDH4tiSjbI61s4LLZK9w9lQ5QmF/NkqjvwPMt3qRI6I9KNCQxcWcWORQVCeI26fZLuF1cG5d3Y/dzlS+uuYgUtM+siVETF0S9d5z8pgFz9WNtz+nWdadAcPoj6CKIg9tG3KKatNTBoN1MDoEL4Ez1hlN0RBoT6pN6KQsiXuy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYHJW721; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F232A1F000E9;
	Wed, 17 Jun 2026 21:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781732146;
	bh=uRfXJNcthQCgAy/2/5C1RpLOF0v4wynixEcGeTRlwY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gYHJW721aT41s7LJYe3ehqyMWZyVPIgaI7TMN1juAZlDCo8jWTa44Fzq5DtfuNF46
	 0p2UDcxYWtFekykg4boRkkWB0v3aIwsnXzFq+s0VP1vwXlOl9xA3tFgd1PoS2+HT1a
	 DT/m5QP+GcUcTNJcZ1gz5jZSHqFH7XDhAk/6aNymim6kcSX35x9vfJMKbsIm7RRg0W
	 Vh47OlW3MxdzcqORw3A/MDn8557x3N/YVq0CQMdqzzdqRe0DBcP8x/bbKB7yOlSN0C
	 jue5RbMxoVNMFDG5TYHRHeYqvy2NJ/3wJlR9r4mFcp1UFtUJ9AcDC1uT2z+iKbsoGD
	 DC67wR/MLxSTQ==
Date: Wed, 17 Jun 2026 14:35:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: mvneta_bm: add suspend/resume support to
 prevent crash after resume
Message-ID: <20260617143544.2310b7a6@kernel.org>
In-Reply-To: <20260616112540.4181231-1-yun.zhou@windriver.com>
References: <20260616112540.4181231-1-yun.zhou@windriver.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BCD769C897

On Tue, 16 Jun 2026 19:25:40 +0800 Yun Zhou wrote:
> Add a device_link (DL_FLAG_AUTOREMOVE_CONSUMER) in mvneta_probe to
> guarantee BM resumes before mvneta and suspends after mvneta.

You say "guarantee" but you pretty much ignore the failure to add it:

+				if (!device_link_add(&pdev->dev,
+						     &pp->bm_priv->pdev->dev,
+						     DL_FLAG_AUTOREMOVE_CONSUMER))
+					dev_warn(&pdev->dev,
+						 "failed to create device link to BM\n");
 			}

Why not handle this error properly ?
-- 
pw-bot: cr

