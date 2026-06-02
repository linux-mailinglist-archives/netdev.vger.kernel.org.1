Return-Path: <netdev+bounces-294326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i58UF3ccH2pHgQAAu9opvQ
	(envelope-from <netdev+bounces-294326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CE4630F3A
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 20:09:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grapheneos.org header.s=default header.b=pNvmjepN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294326-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grapheneos.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C98493001BE8
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9831A576;
	Tue,  2 Jun 2026 18:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.grapheneos.org (mail.grapheneos.org [91.246.30.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6BE31987D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:09:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780423795; cv=none; b=SqM+slNSYC8IPf0QrMjS6x59l7kxrUNLOQd1y/fiueBzbEdvZD2swg1CMsvF/vQJQz1Q5ewpTb8VF7N5rhOYFklWl9e8YQTIPHO5JKE/yswn15DgXw9JyfSDmJno2tPUYQAA66cJ+H/dt9Eg3+aKFDENF482lmAjoo1iZyXAOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780423795; c=relaxed/simple;
	bh=b+tJMtici/QxQpneg5L/lApe9epO/pWWupxr66xOIKQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L/Uggj/BGAMzylIcaOn5biKohTMA9s0rKD3kEHgE3Na9pj2IuInIJBEPOJSrNmsP0FQcYD8/uBd7kwxX5cNo3V8igndAsVKDWj0vAXUHqvvwZKnGuDoCSFqUEdZPSuGebJ4FwH6qHMKIPUq19xquu/AESyGRdYuv+lyLAa1pblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grapheneos.org; spf=pass smtp.mailfrom=grapheneos.org; dkim=pass (2048-bit key) header.d=grapheneos.org header.i=@grapheneos.org header.b=pNvmjepN; arc=none smtp.client-ip=91.246.30.4
Received: by mail.grapheneos.org (Postfix) id 997443C08F09E
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grapheneos.org;
	s=default; t=1780423236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=6fFGdjST3g/P4faIjxC6n1Ki+ytnfZ1JrGtXnuXlvg4=;
	b=pNvmjepNfLrOBOdvi59bpKAD4B8uYYNSn1xpVxqdccxYoyTxWx1qkBn0JEkNdEMw0hoRhv
	P7pGnFZQNYhZu5XTvYPLh0j+WmXwqF7KWZUwc6XYIspZsz2IHon0fphPNmRM5zLVf4MU3q
	R53PICSKC3SD2i2ZOxi7JCwoC46Rs7e5IjyGZJm0OZj2QR/SrFjIRbzhURhw4rZjJb1l8p
	PL/LQa6UVnROI7xTe5huRlEHSE+lASAGcrie0M941SX1OuwgNoVhIrcdFpeXCSrhzvMgA7
	XCWzIJtMPHaG15H+ff8ejATSgivRwHST3qtbKofdDTPV7DyjyeKsvrJ4X49cSQ==
Date: Tue, 2 Jun 2026 14:00:33 -0400
From: Andrew Fenton <andrew.fenton@grapheneos.org>
To: netdev@vger.kernel.org
Subject: [QUESTION] Packet uid for kernel-generated multicast
Message-ID: <ah8aQWX60nTiHMLQ@acomputer.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[grapheneos.org,reject];
	R_DKIM_ALLOW(-0.20)[grapheneos.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294326-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew.fenton@grapheneos.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[grapheneos.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.fenton@grapheneos.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,grapheneos.org:from_mime,grapheneos.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3CE4630F3A

Certain multicast-related system calls such as setsockopt with options
IP_ADD_MEMBERSHIP, IPV6_ADD_MEMBERSHIP and MCAST_JOIN_GROUP result in outgoing
kernel-generated packets that don't have an associated uid.

Not having the packet uid set to the uid of the system caller makes it
difficult to use netfilter to ensure a specific uid can't send any traffic out
a particular interface. It is possible to use network namespaces or system call
filtering, but neither of these options are feasible for us working on top of 
Android Open Source Project.

If we submit a patch that adds a kernel configuration for setting the packet uid
to the uid that made the system call, would this get merged? Or is this not a
viable approach?

