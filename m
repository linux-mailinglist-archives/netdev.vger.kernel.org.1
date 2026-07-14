Return-Path: <netdev+bounces-307354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 84EUBBzKVWoMtQAAu9opvQ
	(envelope-from <netdev+bounces-307354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862675128B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:33:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=suksangroup.co.th header.s=default header.b="T/iWzP8D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307354-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307354-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=inbox.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0769530015AA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 05:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A1327C18;
	Tue, 14 Jul 2026 05:27:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02B320A0E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 05:27:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006822; cv=none; b=p/en7cKkllfJW7kHO7nmwc7ssHqgzKuiNa4d3A9IRBnMR6JttRoam79rm4o5ye4SJL/4ZMmwgMZmyxQJvmRkm8Jm9dp1CE/mAr9BCxKuFqDDhKabZQHzqXr/nUE+tAR6GYEi8qG1S5l2kaCnf6pnqK7C15KizHOy4StjOp0Wlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006822; c=relaxed/simple;
	bh=Ksp19kX0g56Jx0HC5LzqKK8IaulQoUq3YsbW756Izfg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oWMBwOK718Tb3sOfu3+B4IX7dywm9HNZp7nBnMTuy99jO6IXnVHtdlYJQh5lr0Ssx8a6L0uObRbS7tc7I/L2QoDhbxNDXYHewTobzNGvpP0y7mfBbHhv5MHRl7dyODf/vsUTLQ1Zn8Aj2pLrygzyuJ7Hn49gH80Ihy3tdQqK4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=T/iWzP8D; arc=none smtp.client-ip=103.13.31.55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ksp19kX0g56Jx0HC5LzqKK8IaulQoUq3YsbW756Izfg=; b=T/iWzP8DTo2vR7lS7ENk2dEhLA
	MK9sev7vHR9wOCps6ptLKCyY+DmoLj4b42MZSsdcfows3BeJh7MXS5KZ5hDrQKnPCVID/au/Uta6w
	DJLbfc/NImA1y4Ah8na/UrUBR4e52rVjDe3Agnou7/mCPiDdGXfAXX5vq6pFwJnkfGKsPeSRA4IJf
	EQe+Z2U9I447jqQUex3t5Voc/bhvj29WlPmjbLQkaUy6PXj7MUXcH76U9F87j+Es/A3wC1Q6/NTCp
	MFzzzi+CBjyv1xbG4OQ80qF7tbeXPlCOl2qiPUiwSfSsJx81lAPPcM5edEDDAE+6EO4tjduFEFElb
	ql5HTf6Q==;
Received: from [207.189.26.187] (port=64034)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVfX-0000000FytZ-36E5
	for netdev@vger.kernel.org;
	Tue, 14 Jul 2026 12:26:58 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: netdev@vger.kernel.org
Subject: Dear netdev@vger.kernel.org, 
Date: 14 Jul 2026 00:26:55 -0500
Message-ID: <20260714002654.B46DD6F77A40BB52@inbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Action: add header
X-Spamd-Result: default: False [6.44 / 15.00];
	ABUSE_SURBL(5.00)[lexcapitalgrowth.com:replyto];
	R_DKIM_REJECT(1.00)[suksangroup.co.th:s=default];
	SUBJECT_ENDS_SPACES(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[inbox.org : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-307354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[smtp@suksangroup.co.th];
	GREYLIST(0.00)[pass,body];
	HAS_X_SOURCE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_GMSV(0.00)[smtp@suksangroup.co.th];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[info@inbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[hanns.schofield@lexcapitalgrowth.com];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[info@inbox.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	DKIM_TRACE(0.00)[suksangroup.co.th:-];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	MISSING_XM_UA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lexcapitalgrowth.com:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,inbox.org:from_mime,inbox.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0862675128B
X-Spam: Yes


Re:Good day netdev,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA



