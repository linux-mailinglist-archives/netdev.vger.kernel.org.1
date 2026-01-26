Return-Path: <netdev+bounces-253598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJOPDH/Ud2n1lwEAu9opvQ
	(envelope-from <netdev+bounces-253598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:54:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 868818D5A1
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EF0300CE4B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915C2D8777;
	Mon, 26 Jan 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmE+ZuWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57626283FC5
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460684; cv=pass; b=R20npxmt3ZVHOWG6S+X5S3NLKpJDTSfo9QbI92Scw7yJWK1ddHm2Hi8t0lqJlS57E6Q8CoxyhDZBPi4FloAo2X/IPdFbVUd/Nxqo9U6mq327HJ5q0/doebiLEMITWErWHVBh66MoPmWILj4o2aW9LKR7H6L//ZRsOCv41Bk+1IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460684; c=relaxed/simple;
	bh=u1PIZl3rDC3WjLRm/ufZ38uhmKT6wSLTwzWxhqmnfxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr3RaJvxZ2v7I5aj+4niGLC8Oz5gZJmy6AIqTZYOzl1Fl9XNgc8d7G6KbJ6d1ppUGRTY6iQBhRaHgB9CzpIEJiPj5cNVkM61UaJswWanDTlwzfkyrMO86B9gQnB1CHJvB/eqklVL0NsdhRB5KTydksFYKrZoj7tvb/ynl6hkyr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmE+ZuWt; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6b16bd040so560424285a.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:51:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769460682; cv=none;
        d=google.com; s=arc-20240605;
        b=E23EmvzRCeYGtf8TsTxg9jHdDbqBpYvYQ5vPK+nqGluLAdtiRCAhVeSvmGzMPWx2Ux
         rLe0FQhXot5/avAf3uMEQwVqpb5RtEhuABXeLa5lM4PoTryblGVuwrMd2SNw30H8PTPZ
         kFI/dEpGKy7Ottn2+dFqyBPjmcNKEyjQ2cDQkMUZkEfUWy36YMFOWQrMoIU00GYp19/b
         +in8zBHhTWIw6kl3mnJaNRzUzsW3k5L6O2oIcCt//jrn2uTnjnu915glITEZj+5iTFvX
         l+7uXBF93zxSHw7f+VyJ5deAaoi8LHa7Pn2AHRy2WJCPuMhcD4CR8URuVNKYU1vxY3u4
         mXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENp8sXYiCU/BCY2lNHnkEOHR/VlkLaoPoCHWW8j8iyg=;
        fh=cElbcISyP2oXxSiNyY4owE8C7ubWCIMJfOOBtSosZG8=;
        b=J8DNGM57HJve+W+X9UTNXKLSr0KrLIfBTKCeEtBAvkdaPaW/woIGFaTfBC8OOM/rqv
         LCh1ylqyeAhb4qWkuT67w7xJEV1Z4DVNePjV7T+JYHSHfd+pOVMgdhI0XThurkWeIH5Z
         YEWMaRY1T/mLYzf8R+G2pUe2e6dI2Cj53g/cm7sesb8TJrRtE9OSz7U5bBuWFOXhq5BT
         XPBv9vUN2SlMpER03jbCmoyBW0PrIoz7pPzvo4PZzcubq5XkNvJ+l4TJ6Vb9QcPpU5pm
         B+O9D0K6iD/x182Nsozu6Oe41Zn9kb6rcSguw8fcSjz4Ld42mRJ8Fn7I8OaLTETBfNXe
         hyBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769460682; x=1770065482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENp8sXYiCU/BCY2lNHnkEOHR/VlkLaoPoCHWW8j8iyg=;
        b=gmE+ZuWt2Xcu91o2yF01QCCiOuujra2mdfKZiHWaySol3QSFa1sDDp44+EOoN4CV3c
         kgrWtCK/gZGuWvZFkt9aQXIitkRQg4hpOnvLRwMBog4Bry3/Kgitpr01vxOS+eaEw2cb
         fyVHj1odIv9Dfw++k9AltoSIpDyM8vVLa4PhadBjBxGobrhMIOjaZYPI13UJWm4ksPb7
         nN6sRLkiUZTjHJF3BY4x5bInR1bRs+TYOuNiNm8fo94FA4YxqAD3b1TCJe74pBbbbUQ8
         uLusCJO+Cbs1hGuUeTymxT+kLmcQ+oCn3zVNIzlF2PxWKW+wgPPy/QrLeC9dtVzeknst
         W5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460682; x=1770065482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENp8sXYiCU/BCY2lNHnkEOHR/VlkLaoPoCHWW8j8iyg=;
        b=LFm1oiz5EsTgIoESICSjWi+kQKuYFICKMJOJaCLwQ1VOkR5Ik+zlzXbh4gCC7sLyPa
         8Huks6PajF9DuaBzVfv7gN2JIDrA+EK3PJOaATFKSuUoJkqRriJm8jPO38Sgmiq7/Cpv
         lGOBShfOQK2/jwUFzEzUyK1Szpdk63U0cjLGa5TqgkjhFJveUvl1/iVyzFTd7O5KwOq9
         Uvr/M6FcRpkFSFwu+2akpu91q8oKz3TeHI1JlSyjDbZ2K8vR3XsfaA2iZVzYc0g8ZkB2
         wHnsGhmmRdNeN12EGKVuiL/e0R+f6HfinFo2rSQmFTc51EArCudzyp+hnjoJnbgGeNdl
         BAqw==
X-Forwarded-Encrypted: i=1; AJvYcCXrJ1CxM/L4YRLqrJ3VVTQ+2nyBRMWZaAhSJMenupT5dHWYy61xMAV047LN+RsdX6LqgXud7ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwioRJywLcqfYuYy4Qa2YoAvjzX9QmUHLaRxQdoaDOYegUMDh75
	n42B6rOXdjBZvkEXQMJuoWJG9Baty5gAKZYXEdcU0YnRvx0MuO020GNU2XN5F1aZUUFMOqAp+I3
	GSSm1gBugQx9rcFjLx2z8gNqcuzhpeTEziKFpcDk4
X-Gm-Gg: AZuq6aIPu6I4uUXPtYrVe/4HYE61v2e3VvSR+JQPQ18/Qv+D+2tAYt1Z0nba5KJCuUx
	S3G08vufUmNdgRosCdSnXln920Xa6qg4ic8N7M+KevIX9uPxQpZwHinFNfQRUTwZ9LTW/njKFyS
	QuSMTCegL4SF2q5CBJUPGmLRbpuSQOEmGFetzW1s4I5MSr8wSbjnhkFgUFDatgXt137+bZ2k7ZH
	OL1/PEvGjpH2W/s/0Tq4QEtaW7+QcOD0QuSaSu5gtOvpqmgHKRKoIJ2HHyL6nwbPBCnhSaLdjEG
	Vpr6
X-Received: by 2002:a05:620a:7019:b0:8c6:a373:c4a1 with SMTP id
 af79cd13be357-8c6f95c6c74mr647834185a.24.1769460681792; Mon, 26 Jan 2026
 12:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126144624.2319784-1-brianvv@google.com> <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
 <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>
 <b18b4b38-b3e7-485f-91f8-e3a74ff90572@lunn.ch> <72764a6e-602a-42ed-88c9-e4259b6078f3@intel.com>
In-Reply-To: <72764a6e-602a-42ed-88c9-e4259b6078f3@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 21:51:10 +0100
X-Gm-Features: AZwV_Qhh_PEhvkPKzu590pUTjsLtRZieIIkuvJZ7P2FqQzkzAE6q0pICP-cPsIo
Message-ID: <CANn89iK-W6bKuVZD-5FxxunOtcmwOgAM9d4NPA8XwXXKi_TVJw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH v2] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Brian Vazquez <brianvv@google.com>, 
	Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Brett Creeley <brett.creeley@amd.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,gmail.com,intel.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 868818D5A1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 9:46=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 1/26/2026 9:53 AM, Andrew Lunn wrote:
> > On Mon, Jan 26, 2026 at 12:40:15PM -0500, Brian Vazquez wrote:
> >> On Mon, Jan 26, 2026 at 11:24=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> =
wrote:
> >>>
> >>> On Mon, Jan 26, 2026 at 02:46:24PM +0000, Brian Vazquez wrote:
> >>>> The code uses the vidx for the IRQ name but that doesn't match ethto=
ol
> >>>> reporting or netdev naming, this makes it hard to tune the device an=
d
> >>>> associate queues with IRQs. Sequentially requesting irqs starting fr=
om
> >>>> '0' makes the output consistent.
> >>>>
> >>>> Before:
> >>>>
> >>>> ethtool -L eth1 tx 1 combined 3
> >>>>
> >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> >>>> /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> >>>> /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> >>>> /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> >>>> /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> >>>>
> >>>> ethtool -S eth1 | grep -v ': 0'
> >>>> NIC statistics:
> >>>>       tx_q-0_pkts: 1002
> >>>>       tx_q-1_pkts: 2679
> >>>>       tx_q-2_pkts: 1113
> >>>>       tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
> >>>>       rx_q-0_pkts: 1143
> >>>>       rx_q-1_pkts: 3172
> >>>>       rx_q-2_pkts: 1074
> >>>>
> >>>> After:
> >>>>
> >>>> ethtool -L eth1 tx 1 combined 3
> >>>>
> >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> >>>>
> >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> >>>> /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> >>>> /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> >>>> /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> >>>> /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> >>>>
> >>>> ethtool -S eth1 | grep -v ': 0'
> >>>> NIC statistics:
> >>>>       tx_q-0_pkts: 118
> >>>>       tx_q-1_pkts: 134
> >>>>       tx_q-2_pkts: 228
> >>>>       tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
> >>>>       rx_q-0_pkts: 111
> >>>>       rx_q-1_pkts: 366
> >>>>       rx_q-2_pkts: 120
> >>>
> >>> Are there any ABI issues here?
> >>
> >> The patch doesn't change the format, it just fixes the numbering in
> >> the name to make it consistent with other reporting tools. It
> >> shouldn't break any library.
> >
> > But is the numbering part of the ABI?
> >
> > Making a comment about ABI in the commit message makes it clear it is
> > something you have considered, and you have decided it is not an
> > issue. If there is no such comment, reviewers probably should ask.
> >
> >         Andrew
>
> I don't see how an application can depend on the name if it can't
> correlate it to anything meaningful. The change fixes the ID values used
> so that they *do* correlate. If an application was previously assuming
> it correlated to the queue ID, it would incorrect associate the IRQ with
> the wrong queue.

Agree, this mismatch caused me some surprises, we can not keep a broken
ABI (which has been broken by accident)

