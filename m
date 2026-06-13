Return-Path: <netdev+bounces-299058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sGHZJK3PLWqmkQQAu9opvQ
	(envelope-from <netdev+bounces-299058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:46:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEBB67FCFA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hp7mMl9Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299058-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299058-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECF4530028C2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05269390990;
	Sat, 13 Jun 2026 21:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A230AD0A;
	Sat, 13 Jun 2026 21:46:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387175; cv=none; b=DTepa/UDEEtn2xm/c5H4xPULC4L0umQzC5pFqHJHmDnD6GE8xvcNqLTlJ8pt92qCqfeE6umYwxgrZ6H0KFgs9kFtwuMsYHoa/BrjSF51ugd/+rN7jXL7XyzmxnuCcw5xqrDe4yflshN9Er/klXJJqbzNwkg6LNPHBZ8vH3QgB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387175; c=relaxed/simple;
	bh=zqlV0V63IbKpxbr9fwwmyONmhCfojXlap9NLfuONAkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCaRRgHe/ubmS716jrdO1liugJ++353OyanR54pZCcQKVKwoVIEc/CdmeVqJJNvWV2oHCLy/mLgNuLZZq+RGxqu3hfBpfaK3RSVjQ3lH/23e0VqjHPUKBzBNeoSwdHdaNAF4OLdcAA5mOB7xUXVdyOY7RjY+GWeeFgOK3Pog1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp7mMl9Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF2B1F000E9;
	Sat, 13 Jun 2026 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781387174;
	bh=DHPUWFhEc+P/6/WSeaEK4iPlDI8nADtP+PJ07MwcJaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hp7mMl9Ym8tJ2XdfqPdZGfo+vykzjQxng+7ebjZLaKO+jELHcJR5FU/7Dsowzz2aH
	 0aXPcZRSft7MmlaZsk5rPU5hXCM+uC7EKuizdEd6Mzu5YJUB4d57b8sdysaOKJWsyw
	 UDRC2Hkwm8C1gtm1iba2ZLXPv4DFWP9mwiB/A9Hzluy3oMePKyQQINigmvdCF098UQ
	 KRoRCEDZBnQcO5hIFn9hm3uZsKb4ZK7C2YrmF+EVd+q3ukr19WwvnXOy2vDgr9Jiew
	 mR6nBuKxZyYpFqw2FyGAcFTTRctiDzvz3ALm4jOJAQtuI1VmPQVMDBnjFGu1YiToxu
	 eYCzJEVe7xR1Q==
Date: Sat, 13 Jun 2026 14:46:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, xuanzhuo@linux.alibaba.com,
 mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
Message-ID: <20260613144612.0c5b7ba4@kernel.org>
In-Reply-To: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn>
	<CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299058-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:eperezma@redhat.com,m:menglong8.dong@gmail.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AEBB67FCFA

On Wed, 10 Jun 2026 10:27:28 +0200 Eugenio Perez Martin wrote:
> And the From and Signed-off-by emails don't match, which I'm not sure is valid.

It's clearly the same person. Please focus on the code, not trivial
process issues.

Quoting documentation:

  Reviewer guidance
  -----------------

  [...]

  Reviewers are highly encouraged to do more in-depth review of submissions
  and not focus exclusively on process issues, trivial or subjective
  matters like code formatting, tags etc.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#reviewer-guidance

