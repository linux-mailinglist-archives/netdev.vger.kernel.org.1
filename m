Return-Path: <netdev+bounces-300017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ADBHIJ0lMmq4vgUAu9opvQ
	(envelope-from <netdev+bounces-300017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:42:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E26696778
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:42:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=Umzakdkg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300017-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300017-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D4A23009387
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB331AF1B;
	Wed, 17 Jun 2026 04:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52C314D26;
	Wed, 17 Jun 2026 04:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671316; cv=none; b=NJMI5ePJONrnXXgZ5eq40IjT8dxDIU41WaFx3Hq9YwoBnEw8qyX2mPf/Hly77rbAH5S5Fd+S/LbNwl1MV1RRmezWeGQCHts09Fj7hcxzJNWLWo4wk0nsRjd0Xtt3sQNHIRWkzCcvOjJvL3oL4jjx1+pkeG0uJecTqzqbDGyUPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671316; c=relaxed/simple;
	bh=HkKOZV+fj5Zqiu2cPPOgGz8MSCvp5lZDlZmrvU6IPY8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvMvjBxMR2lIpPIbwEvmRMX26Yz3FaHHEsTIHawYwhx+yFL/8imFaOfyU1UiMedvjuYJ0SQnsvZyokP/IDh0fjpBW+DG9+7Kehc6CvwIjb1N9mtSpCWaKUDuwu/MX30yQT7/3hcUaw1W4pD5f2hjoQ4MFylJx8y/5j5SnviDSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Umzakdkg; arc=none smtp.client-ip=109.224.244.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781671310; x=1781930510;
	bh=HkKOZV+fj5Zqiu2cPPOgGz8MSCvp5lZDlZmrvU6IPY8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UmzakdkgHiAxDi8Pq1JmVriCN6mzvm+eZpy8I3D9ZpFhc3MX4I+IKhugyi6zMed31
	 pSghcz1jiknPFVyWj2q4L15FLKcJG8bQqY0sV1WTXEIK9O6lVzxNW6fKRuhBlM4jm/
	 4YoXP3jzmHjiyoZtkuFT7cbeigk33O+Ig2AXKGRfTmWU/MbfwdVliRbsWTs15x6kK5
	 GpOcRxu1nDxZ7Tyn35UhyH0kE8Rmk7Is7gNtK4mJa7LKWe6/ng6/1lUqcK/9KbrKDV
	 nVKgKbzgtyaACORE4w7RWGPhbiNSi5cGwNXcHHsuvcCrH/LdVACF/ExaWGNEU0FXE4
	 VwhpbDKdgZ74Q==
Date: Wed, 17 Jun 2026 04:41:45 +0000
To: Simon Horman <horms@kernel.org>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: David Heidelberg <david@ixit.cz>, Robert Dolca <robert.dolca@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Kang Chen <void0red@gmail.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: fdp: reject an oversized device-reported packet length
Message-ID: <20260617044138.347012-1-hexlabsecurity@proton.me>
In-Reply-To: <20260616090035.GS712698@horms.kernel.org>
References: <20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me> <20260616090035.GS712698@horms.kernel.org>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 3b9377f30beea3c075e93f227664b9155535cb14
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300017-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ixit.cz,intel.com,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:david@ixit.cz,m:robert.dolca@intel.com,m:sameo@linux.intel.com,m:void0red@gmail.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:mid,proton.me:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60E26696778

> So I wonder if the check you are adding below should also guard
> against phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD.

Agreed. Both routes are reachable: a length packet with tmp[2] =3D=3D 0 &&
tmp[3] < 2 gives 3 or 4 directly, and the + 3 can carry the u16 store
past 65535 (tmp[2] =3D=3D tmp[3] =3D=3D 0xff -> 65538, truncated to 2).
next_read_size then drops below the 2-byte header + 1-byte LRC that
fdp_nci_i2c_remove_len_lrc() strips, and the short read also leaves
tmp[2]/tmp[3] unrefreshed when the next packet is parsed as a length
packet, so the following length comes from stale buffer bytes. It is not
a second overflow -- skb_pull()/skb_trim() are self-guarding, so the
frame is malformed rather than out of bounds -- but the desync is real
and bounding it is correct.

v2 folds both ends into one range check on the stored value, so the
truncation case is covered too. It also carries a fix for an skb leak in
the same function (a device that sends two data packets in one call
leaks the first skb); I am happy to split that into its own patch if you
would prefer.

I will add your Suggested-by.

Bryam


