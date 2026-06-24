Return-Path: <netdev+bounces-301804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDmxK8lpPGpGnwgAu9opvQ
	(envelope-from <netdev+bounces-301804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:35:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EBA6C1E50
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:35:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F5cwixsg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301804-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85F1301D68D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A83B42CA;
	Wed, 24 Jun 2026 23:35:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB216F27F;
	Wed, 24 Jun 2026 23:35:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344134; cv=none; b=VBIBNF/U91vfgEbwtn8CwgCAWDjqyit8Y7P9mf61aloKP+J6Ja6ctJFSwg4qeq14OVdiynq+gPMHHGQt5DlJSytrvxZnS96EAodhund5aSl1BiuJ0arbqVKEqpuTeUz2+jNUZzoIKfDoiP0rR4hhScV5RLLUCaE0h+6Eu56ZSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344134; c=relaxed/simple;
	bh=JLmutQCxoo5wzH9sgIQ32+4GwLi13waZ3ElW5YR0dMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZziqi5KGwZCJepFbgfS5mX13VUTAKGwCYiMG5M2KdDymALeg6fKL8ZgF9vmJjTd3xc/RAKVdux6qDwJBbpLRI9MsIBVo+eboZuiuYRdHG2/TfMc9y0C/O8PY6dCSfWKWx87WfK10VmNPsiJiDxqSxIbF0I2euCr5QSV0hUR3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5cwixsg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F30C1F000E9;
	Wed, 24 Jun 2026 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782344133;
	bh=JLmutQCxoo5wzH9sgIQ32+4GwLi13waZ3ElW5YR0dMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F5cwixsgtLYdexl9DskEsNL0+nnUb59ozL9di74fEHG1wzoVHg0myhY66KtbT85SM
	 /zBo7TaDS8t1cjY6+fLxqGI/NlIaFuvMkSENRhLqmJmGvH0jlAXchMuULAkX1DSIsz
	 QuGO1a8ExUudqTOoyrdUXM4HRP7QgaR97CrGnEPsm7wu7HzWkVgY9bPoNeUY09iOfW
	 zQio73OS7lZi9h/Uw7Uj6zgFzJCHuSbRg9d78H4AKRFEzU2+2PBeL3W18QgS2z2avB
	 aDan7AE9d8bVRIjZyPGjUG6CYTW2vT5igx61z8cYNmX5lJCLSJdlH/0ZI4dVwb8UYV
	 xB/51UsAFPivA==
Date: Wed, 24 Jun 2026 16:35:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei
 Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [External Mail] [PATCH v2 1/7] net: wwan: t9xx: Add PCIe core
Message-ID: <20260624163531.2bae55dc@kernel.org>
In-Reply-To: <b02c0e1e9f0449f2b819197e4329373b@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
	<20260610-t9xx_driver_v1-v2-1-c65addf23b3f@compal.com>
	<b02c0e1e9f0449f2b819197e4329373b@compal.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301804-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:JackBB_Wu@compal.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00EBA6C1E50

On Wed, 24 Jun 2026 09:15:17 +0000 Wu. JackBB (GSM) wrote:
> ================================================================================================================================================================
> This message may contain information which is private, privileged or confidential of Compal Electronics, Inc. If you are not the intended recipient of this message, please notify the sender and destroy/delete the message. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information, by persons or entities other than the intended recipient is prohibited.
> ================================================================================================================================================================

If you want to do anything upstream you have to get rid of this first.

