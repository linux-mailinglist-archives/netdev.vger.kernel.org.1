Return-Path: <netdev+bounces-277838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMHVOVTJ22nzGgkAu9opvQ
	(envelope-from <netdev+bounces-277838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2F3E4D3C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3185F300D0FF
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85832D0606;
	Sun, 12 Apr 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QSgjPB9B"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E102BDC16;
	Sun, 12 Apr 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011562; cv=none; b=G4Jh3JidAkwZnu5JlNKpq/ml5jrcNP4lvts03omCK7JkJmKLFDEBtTVp/CdB1G3T3kYMI0QTj5VAJVZNAaDGJmbE4+15Kq7rbBVgP6ErD8Lsbx5yS4DaH+KtoyCtUBj1rcUVvrbU2jxDmRsQX3zzP5r450tkTjSyBmd5DgBwAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011562; c=relaxed/simple;
	bh=UjQDAId9WQdEAg14YypIOiJ/06HqP8HxWPyBiEuJ7Vc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=iLBpbjVgfMI3Xu9cu+04UiHsNIWbqTYGNU3f/QOGdG/W9pEYAYctYVb+5Rqr4AdgQwEEXqS28hIf2FQl3GBopsIWDPZu4N/GDqxSxHOo6GzalylH8W5o0iHfkJVzttHSR4T+wZypvvJSJS4n4pPwBLSzYX/AYvOrkNXh3Lg6DeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QSgjPB9B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BvEui7YzOMs2w83yqMw0LMQ9AQ/M/3wnsv2L1WGp8e4=; b=QSgjPB9B/Sj+3KZH4ndY9jr5mB
	TIEXIglSf74En2XewCfvlhWvSY4eGfle08xn4+ovhgJLQZmnBw/LsI5T6QRsAloXkqQ6zSKlFbBhF
	ObRALBfrj07p0909nEo/ruT8IDe+iQfibgwapCmxbyr12h1koWMWB7Ky57Zh3EcJwKbNA8OX3Ne1a
	NqhuqaCsXpahW31yXyWRTbNkEQyIH/vuYD+4NTgs3SspvU207gDMuGHBQTW5kNAxw+72fT0u9C+TI
	fA6qDGDAqG/xqF/cefcXokVCd32ZdQW1je9LvqSPwDhWcvD5th/iLziGx3LPFTlIMHDLzNfn20aLh
	M0eV2LIw==;
Received: from [2a02:8013:6d1:1:722c:2a9d:de6a:f9a7] (helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBxjT-0000000Fi0j-34FG;
	Sun, 12 Apr 2026 16:32:24 +0000
Date: Sun, 12 Apr 2026 17:32:22 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>
CC: Wen Gu <guwen@linux.alibaba.com>, tglx@kernel.org, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 nick.shi@broadcom.com, ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, mani@kernel.org, imran.shaik@oss.qualcomm.com,
 taniya.das@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/2=5D_MAINTAINERS=3A_update_PT?=
 =?US-ASCII?Q?P_maintainer_entries_after_directory_split?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260412084704.743482ad@kernel.org>
References: <20260407104802.34429-1-guwen@linux.alibaba.com> <20260407104802.34429-3-guwen@linux.alibaba.com> <20260412084704.743482ad@kernel.org>
Message-ID: <4B889ED5-D1F6-401D-B753-89AE2037F316@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linutronix.de,nxp.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,oss.qualcomm.com];
	DKIM_TRACE(0.00)[infradead.org:?];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-277838-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[infradead.org : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[infradead.org:s=desiato.20200630];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54A2F3E4D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12 April 2026 16:47:04 BST, Jakub Kicinski <kuba@kernel=2Eorg> wrote:
>On Tue,  7 Apr 2026 18:48:02 +0800 Wen Gu wrote:
>> +PTP EMULATED CLOCK SUPPORT
>> +M:	David Woodhouse <dwmw2@infradead=2Eorg>
>> +M:	Wen Gu <guwen@linux=2Ealibaba=2Ecom>
>> +M:	Xuan Zhuo <xuanzhuo@linux=2Ealibaba=2Ecom>
>> +L:	linux-kernel@vger=2Ekernel=2Eorg
>> +S:	Maintained
>> +T:	git git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/tip/tip=2Egit=
 timers/core
>
>Hi David,
>
>Do you have a tree to route the patches thru? Or do you really have
>access to the tip tree?

I do not have access to the tip tree=2E I can make a shared tree on git=2E=
infradead=2Eorg if the other two maintainers would like to send me a SSH pu=
bkey and preferred username=2E=2E=2E

