Return-Path: <netdev+bounces-254488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EH+Fx+Peml+7wEAu9opvQ
	(envelope-from <netdev+bounces-254488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:35:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F308AA99F7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6DF03011796
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDA344046;
	Wed, 28 Jan 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hep+3N49"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F022340A6F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769639701; cv=pass; b=aedbt1qJwxxpzdrkxXWHqCWBSHbgZlUOBqJwlFyCybraRfPNgl/lci2BReEEJ1zhmX9d/ZCg8Z7/ojAL1QenxW5ugx4uqJJBWcqvAn1/SzR8wmzqjVPGFuOwQL56DqMGYf1Z0/NjaBLOMpeIrxMJodvQgLplPUALGcN9qk8y02w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769639701; c=relaxed/simple;
	bh=T4c3iVSddoT05c+TpiMovdeD0e9uxdfRSa2mtz8rdcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUg5/2UIovFuZEubFbxY8WonzJk+KvSGhaslTFf3VxzcwcpBBxlMANs4fPPM3Uq+hxuHcEI5SrR6a3xpP8vqCaMdVAgpB23gOA6s8FQXo9+bLHNK0CvaSsF3mb8Ju51ybGHAEuy2Z4WydSCQsLqe5PKGAXyzsobGjsTdtautbgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hep+3N49; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d18f80b5c2so227793a34.3
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:35:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769639699; cv=none;
        d=google.com; s=arc-20240605;
        b=A3rLfpG19tmNLiM12Zz/bBTO/UX6oP7A4uIrXpZvL36MOhZnPBAuWQ0ARXQEDCqRQC
         3bkP57pQXp4NV81vOhyPfgFuM4FAUjHPNs/IZBg9OcvKWLD57IhjW7V1qibwvvfEZ9W2
         X2G9X06nlKG9n+NGSlu1fB2KZfvI1YiB8Isx1HSTTh3aQFvKg8PeyXJrSqnMMgZqx4Wg
         40jtDKW/X/nrVkRVUxzhNWnRcUJlLZWYoWWoiIkADTQTmMBE47gCcnjQl+uaOpwyj/qe
         Nbf2xc5DzmS5hEiAvfX8stdBa+zYSKaXhAH/AEyQFiXsby9DCigTgloI6c3gpWvomH26
         z9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        fh=A/PuSikZBGQXkvKQFFSvq47B91OiHkCPp4feUdsDHYI=;
        b=goOHTh9exn1r8h1wm3LBWn3cooczVUDXe3R83BZ0Gl0LkbIPVouCWm8ZxFj3J/aCTV
         GQ9BXMU0BcrgbR/rdcunW5q6bVAzL/Qa/yh9gWhMkDs8PHXhoED2n6CsCHhnW5pAkUap
         4OA0VhNi7gTPSDZDEXoP+QD/NT43ixz55aZbCYeLJ8i6G5u4MOA/rJJa4E0Bvp5wziup
         LZSiujBqdkxdT4xJ3TXbDQygp2YARd1WjXk6NmoF8m3Y+sbxhsHm2PKl1LbD1r9flRib
         FQT2H3po7m8+Uc/fXSQY5UxHXg19BvdSVDINUkZ/A40ukPRNqQ3zTvgW6P/yDtergLJ0
         18xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769639699; x=1770244499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        b=hep+3N49/KL8sIa/4Btrobzwx42EP31pzE03WiBKGSxngiR+LTni04utGg4bmIIaui
         BMAK44J83Cak3kAP4aOjaStaNOP/a7qaq7Y40xVuiAca5Yt7FXVv9T42IhfzbvnN9c6/
         d2xOrBXIaafZlBXELP+YoiLKosd0k3v5GCv9aB2uCkumQJ7aQzC9h4WjabZfxp0K6Pzs
         dlT3CMlD5cVwbPnH78mQgz2xqO9X2riHl6JLhPfa66c0ReIGnwu7OvUzcKiondn0dfM/
         QFCvLSOYTwCiX1/eOsLc5GK3FcRmTZuIuXkL4aKDBOKleIa4aCHFBeDdC3sawAmqIkh0
         rlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769639699; x=1770244499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PoIWrgGOWoR2ADTfr2zon4Uc9JuSMJyuA/FLzPv3E4g=;
        b=ZA49QIygt4q6F3r372ltoXzK97tuOiPx7qapI7u9DSJzsnAh6iCwmtQxj9ZVfvbaDQ
         DdTRHdGahvuCb/u7drkuMnnpaEc017BnYxRPGp51zZw4pQF+if+LUGUtA2fzABta3TrQ
         zewEutpMjsJRWIegwXqfjc4vliH9o0xK9gYxrDeZ3I8dk0WzGHnIO1ZY4MSrz7IZP4up
         m0iWUDOLxjjZOXgcTSxIBCgmVltFbzdZ9Mxzj3FEHF1EzgO6NVBiKdZ/d4vgssKAwLXu
         5s/CV1zEcq0essevUrXi0Dng87NvRzmaypgakOrhWvWfX/a1cTvrkpybJMpaRYxHQIFO
         0bVg==
X-Gm-Message-State: AOJu0Yy2a/ARSTEdD9N8ojyP3/ZqVsNYsV6DN5TDaCAba1erE6JmDTEG
	whzh79Nuelw4TndBpkmEeHbI4zLV2pdgKe8iwK5oSEBMyHHdhHdnlFCusjiVZciLpnk4R9jSXXD
	jAcGlNn2mpXR/zmQnzgkS3PAJib/Vh7s=
X-Gm-Gg: AZuq6aLHRG+vjRBilX2GcrqB0fpWbjXeRr2shAaPdHTANzA0g3JjhZNKkVat5PcBb/1
	X/sxSYbkNzuzdUc7rNmSJG4vvVkC69lKWxoadIdHtOOJrvehnNyZyHM8IQ3c++Xi2guzoIrPcph
	kmUZZbtAdhC3hZG5brj7k2g042kmuOSoKsNMKubTE6MI2G8P2XrIyCfAeKZx4mJTfy2T3J87Pt1
	WTk7OPDD7Y8hJJOrI/Ha3BbRc9Iid1dlZaU0bN6VtDqiEKIQ8oMO7a8a7nQ/oCCPQajVFb6XIWc
	VR+bKR2l8459kdy1yNcqv99AMIHm
X-Received: by 2002:a4a:ee0e:0:b0:65c:f545:c05a with SMTP id
 006d021491bc7-662f2048020mr4358797eaf.27.1769639699382; Wed, 28 Jan 2026
 14:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FFDD6CD9-5100-49E6-B3B8-F38099043E87@amazon.com> <76564BD3-B685-45EC-B53F-06534512EBC7@amazon.com>
In-Reply-To: <76564BD3-B685-45EC-B53F-06534512EBC7@amazon.com>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 29 Jan 2026 06:34:22 +0800
X-Gm-Features: AZwV_QjDlfRMv0KQKKWP2gkRkHnGfGfmqRNVLTQ_ZpvT-etoTOs890LpyTx1UI0
Message-ID: <CAAXyoMNi3W-5VHWgr8L-gmbR2x1e3p=vsr6CdjKV8XfzLG8JsQ@mail.gmail.com>
Subject: Re: [RFC net-next] net: ena: Use u64_stats_t with u64_stats_sync properly
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Allen, Neil" <shayagr@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "horms@kernel.org" <horms@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "leitao@debian.org" <leitao@debian.org>, 
	"Enju, Kohei" <enjuk@amazon.co.jp>, "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, 
	"mingo@kernel.org" <mingo@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,amazon.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,debian.org,amazon.co.jp,intel.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F308AA99F7
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 9:21=E2=80=AFPM Arinzon, David <darinzon@amazon.com=
> wrote:
>
> > Hi David,
> >
> >
> > Thank you for submitting the patch.
> >
> >
> > > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > > against load/store tearing. Convert to u64_stats_t to ensure atomic
> > > operations.
> > >
> >
> >
> > We would like to run some quick performance tests internally before sig=
ning off.
> >
>
> We have conducted initial internal performance testing and observed no me=
asurable impact from
> the proposed changes to the driver statistics.
>
> > > Signed-off-by: David Yang <mmyangfl@gmail.com <mailto:mmyangfl@gmail.=
com>>
> > > ---
> > > RFC Comment:
> > >
> > > The write side of u64_stats should ensure mutual exclusion, however I=
 couldn't
> > > find the synchronization mechanism in use (for example, ena_up / ena_=
io_poll /
> > > ena_start_xmit). Should this be considered an issue?
> >
> >
> > We reviewed other drivers and it looks like none add extra synchronizat=
ion on the write side.
> > Adding extra synchronization would degrade datapath performance to fix =
extremely rare missed counts.
> >
> >
> > You've submitted similar patches for other drivers but only commented o=
n write-side
> > synchronization for ENA. Is there something specific to ENA that differ=
s from other drivers?
>
> We're still waiting for your response to our previous question: You've su=
bmitted similar patches
> for other drivers but only commented on write-side synchronization for EN=
A.
> Is there something specific to ENA that differs from other drivers?
>

Hi, the series is suspended for the moment, as discuessed at
https://lore.kernel.org/all/CANn89iK9xfvQ275f+PPht8mM6K49mUq-T9D-4UUxUkTncM=
4tRw@mail.gmail.com/

u64_stats says: write side must ensure mutual exclusion (more
specifically, updates to the syncp), or one seqcount update could be
lost, thus blocking readers forever. I added a new u64_stats update
block in ena_fw_reset_device(), but I could not find the lock that
protects adapter->syncp, at first glance. It would be totally fine, if
all calls to u64_stats_update_begin() are actually guarded by RTNL or
something else, including all indirect uses from ena_increase_stat().

Note the issue affects 32-bit arches only, u64_stats_sync is no-op on
64-bit arches.

> > > @@ -440,42 +440,42 @@ struct ena_admin_eni_stats {
> > >     /* The number of packets shaped due to inbound aggregate BW
> > >      * allowance being exceeded
> > >      */
> > > -   u64 bw_in_allowance_exceeded;
> > > +   u64_stats_t bw_in_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to outbound aggregate BW
> > >      * allowance being exceeded
> > >      */
> > > -   u64 bw_out_allowance_exceeded;
> > > +   u64_stats_t bw_out_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to PPS allowance being exceed=
ed */
> > > -   u64 pps_allowance_exceeded;
> > > +   u64_stats_t pps_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to connection tracking
> > >      * allowance being exceeded and leading to failure in establishme=
nt
> > >      * of new connections
> > >      */
> > > -   u64 conntrack_allowance_exceeded;
> > > +   u64_stats_t conntrack_allowance_exceeded;
> > >
> > >     /* The number of packets shaped due to linklocal packet rate
> > >      * allowance being exceeded
> > >      */
> > > -   u64 linklocal_allowance_exceeded;
> > > +   u64_stats_t linklocal_allowance_exceeded;
> > >  };
>
> Regarding the modifications to ena_admin_defs.h: these structures define =
the hardware-software
> interface between the host driver and the ENA device.
> The fields are specified as native u64 types to ensure consistent interpr=
etation between the driver
> and device across different architectures.
> We're concerned that converting these interface definitions to u64_stats_=
t could potentially
> affect the structure layout or introduce subtle compatibility issues with=
 the device.
> Since these definitions represent a contract with the hardware, we'd pref=
er to keep them
> unchanged while accepting the driver-internal statistics changes.
>
> Would you be willing to split the patch to exclude the ena_admin_defs.h c=
hanges and any
> code that touches these hardware interface fields?
>

Sorry, I'm not familiar with the details with the device. If they are
managed by the device, load/store tearing should not be possible and I
think plain unguarded read is enough. It was unconditional use of
ena_safe_update_stat() in ena_metrics_stats() that made them
suspicious. If that is the case, refining ena_metrics_stats() and/or
adding a comment about it would be better.

