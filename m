Return-Path: <netdev+bounces-299278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h24GHaAhL2pg8AQAu9opvQ
	(envelope-from <netdev+bounces-299278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 23:48:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A35682595
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 23:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dGwdeafq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299278-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299278-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772FE3004C76
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334F23C4E9;
	Sun, 14 Jun 2026 21:48:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FFE1FC7FB
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 21:48:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781473693; cv=none; b=GeuB+VbtdPJKILbNINxTnLdfnEbFf9gbwqGQmVuu5J0Kah09bofhXPa1kMF0RvEcDEU8LGdE1TOnPmbzhK8aBfSeiMO9J6zjAoXjmHS8zaDJlOBenpvOtQ1O84CvT8H0mjPUS72W23NetkvMtjHznvgvwLBYzesVViGJ9PCF+TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781473693; c=relaxed/simple;
	bh=dh9OFZ/OYOxg2E9E7qjU/cxffU/qwZ8W8t9uZNGnR7w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C8hTVJnRVLlUCeXO37xy4IGVmIzJQ+aaFlgGPnz7pZm0hDxv1ZsQpsttza+yOoCHx0eu0Z9Dja2sVPqL0nc+xy5wj08BUC5i2TFFlYexyHY0kOij6Wuxj8++dXPhIRgiW4JZSySjaLb6pqecmsFV1vuRdFtwAgri86qTxAXzRrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGwdeafq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8111F000E9;
	Sun, 14 Jun 2026 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781473692;
	bh=FOjtmSzT3RN4Tr1FeLf4o+G99sWvrsBZEtIXPtsCwyI=;
	h=Date:From:To:Subject;
	b=dGwdeafqB2XGev+98jQdMr4LsTswXNS9LJJf72QpuSlLhxCKcgV8V48AAFb8tSmJh
	 +/fwe8R+lpUwsev+E6Qq8GT8WgMbFVhPKzQo7VD7GS2h/thZpELQOgTIymc7NR6t1s
	 S4JISqkxlk1op6Z0Twn2eKkQj7uLpfE6oeW0ly9s59/RIL4TaOhMRiPHF3sL5OPRhm
	 HQkdaWc1zdjsdb/V0AEMzK7f5LZ8sDlBTjGxLT5kLJ/eer0oLquFj7KInvX2B90GxM
	 Qz+QhV/4V3Odoain4X/GJNoumtNlCtdt5cFNTW8CH1rgLKXE29/v+CFRGmZlljOl8E
	 BglYFjQxkpP8g==
Date: Sun, 14 Jun 2026 23:48:08 +0200
From: Helge Deller <deller@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: e1000e: Report link down after "Detected Hardware Unit Hang" ?
Message-ID: <ai8hmGQmXQu64Ld3@carbonx1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299278-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[deller@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deller@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7A35682595

I'm regularily facing the known "eno1: Detected Hardware Unit Hang:"
with my on-board intel e1000e NIC hardware.
Since none of he various tips on the internet helped, I had the idea
to setup a master/slave bond networking to fail over to another NIC when
the Intel chip hangs.

Sadly this doesn't work as intended, because the link of the intel NIC 
isn't reported "down", so the failover never happens, unless I manually
start "ifconfig eno1 down".

My question: Shouldn't the intel NIC ideally report Link Down if we know
it hangs? That way a fail-over should at least happen, right?

Below is a completely untested patch.
Does it make sense that I try to test and/or develop such a patch, or
are there things I miss?

Helge 


diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7ce0cc8ab8f4..c6edcf4ac032 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1157,6 +1157,10 @@ static void e1000_print_hw_hang(struct work_struct *work)
 
 	e1000e_dump(adapter);
 
+	/* The NIC hangs. Force link down in e1000e_has_link() such that a
+	 * failover can happen */
+	hw->phy.media_type = e1000_media_type_unknown;
+
 	/* Suggest workaround for known h/w issue */
 	if ((hw->mac.type == e1000_pchlan) && (er32(CTRL) & E1000_CTRL_TFCE))
 		e_err("Try turning off Tx pause (flow control) via ethtool\n");

