Return-Path: <netdev+bounces-253022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DB9iMpdQdGks4gAAu9opvQ
	(envelope-from <netdev+bounces-253022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:54:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1D7C843
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 05:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67003300DDD7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825C314A9D;
	Sat, 24 Jan 2026 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Qs814irt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF992F361A
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769230484; cv=none; b=VVNSFQF63jCtFvZLgCwAPBUeaywq9F3b4mrnpPKDigTKco8Z8kwI6Dsm4vG+i4abP7dc4EHFRkTuut1EDyqSB9lL5sbZQ45MJ2VoFgkPbkBCnJQhOXwzvd7hyFai0dNLsAaYSQbkK3Uj/8riPKsEAy/Zcy6CYG4+rZGQKbtEn+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769230484; c=relaxed/simple;
	bh=LB7S6PUlD14lXO8YfB+ct/9cjnTVX2gXuAkdqSvHjcM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eQBAnfgGmU5+/7QHnCu5SBl4XkuOjAqoakLN6qcplNjzfaSdjP1WL924zrAZWhp4HUdyste2O6Nr/4R1jlP2uwB+JIEtujgN52g6O+xJ5rWdfGsYt42lwGcp8ACiNSTAT7aHJmXCLXGifdFycVlwO8NjTHl3XvKgF1VO904ZYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Qs814irt; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1769230474; x=1769489674;
	bh=fgOu5jKUUSWX3Hxt25dv7m8LYtN16SHauFgK7e331gU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Qs814irtrvwV+m8SGEbsvKdAe3uFIIYdTjVH6neXK9SX7sW0GRM+aVB9Eeyopl2nI
	 xIy+VVOlk9d57pvYUNxu3zKgn5N1k/m8YbU/0o1JyS5suRb6pAaNw5PQ/up8qpTAbZ
	 Pjrr3CFe4QMJOENomPRA7necNKj1A9ciXmYk0t3OhniWM+z96ecRZBdHgLE48+F3MI
	 69QnFy57WZbTTjnmkJo1wIOl7WYSJ8K5PDHivDJdH2tCj9eJExZOSTD4gMwvYpb56U
	 V5ZAiEAZ7jrqAfrO9MDDf01YC/sYEFuVLa3sdUMVt0+ZYJxJAvfKcwi8L/qyLmeSgr
	 O7JvxrpbdL2ag==
Date: Sat, 24 Jan 2026 04:54:32 +0000
To: Linux Networking <netdev@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: IPsec Remote Access VPN Phase 1 and Phase 2 Settings
Message-ID: <arI5CzCvQQFUbKihE827uOSWKhHpM9TzyZQqEu64NWM509-MAwl5GflVBC7Tv4nmW_2hJmJDeDfmCIArhlcBNJe6VGTBh48zTfHkQIPSsD8=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: a354ee9878c4d818f8aa867160f5333e26672288
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-253022-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[teo.en.ming@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:mid,protonmail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26B1D7C843
X-Rspamd-Action: no action

Subject: IPsec Remote Access VPN Phase 1 and Phase 2 Settings

Good day from Singapore,

config vpn ipsec phase1-interface
    edit "IPsec VPN"
        set type dynamic
        set interface "wan1"
        set ike-version 2
        set peertype any
        set net-device disable
        set mode-cfg enable
        set proposal aes128-sha256 aes256-sha256
        set comments "VPN: IPsec VPN (Created by VPN wizard)"
        set dhgrp 14
        set eap enable
        set eap-identity send-request
        set authusrgrp "VPN_Users"
        set ipv4-start-ip 10.10.10.1
        set ipv4-end-ip 10.10.10.254
        set dns-mode auto
        set ipv4-split-include "IPsec VPN_split"
        set save-password enable
        set psksecret ENC ---snipped---
    next
end
config vpn ipsec phase2-interface
    edit "IPsec VPN"
        set phase1name "IPsec VPN"
        set proposal aes128-sha1 aes256-sha1
        set dhgrp 14
        set comments "VPN: IPsec VPN (Created by VPN wizard)"
    next
end

IPsec VPN troubleshooting CLI commands:

diagnose debug reset
diagnose debug application ike -1
diagnose debug enable

show vpn ipsec phase1-interface "IPsec VPN"

diagnose vpn ike gateway list
diagnose vpn tunnel list
diagnose vpn ike log-filter clear
diagnose vpn ike log-filter dst-addr4 x.x.x.x
diagnose debug application ike -1
diagnose debug enable

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Extremely Democratic People's Republic of Singapore
24 Jan 2026 Saturday 12.54 pm Singapore Time







