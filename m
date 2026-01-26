Return-Path: <netdev+bounces-253603-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD68Dxrjd2k9mQEAu9opvQ
	(envelope-from <netdev+bounces-253603-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB008DBD3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 22:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 437EA30416EF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 21:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A02FBE1C;
	Mon, 26 Jan 2026 21:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgEjQqDE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B22FA0EF
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769464568; cv=pass; b=R0CdffjgF7ed3v6ZTz+IWxFxzXv9f8juuuoll54Lo+5k15OF9F1zshjwpYGpIg0EuEQsqK+UYoGXdtEz5y/Ov/pUUX2YmUEwP3kKRwantKPFw+vKehtQjicYmJag8NVmE/9Ev71kK6n/Sn9fn7421ZpU+ta0trAszSIz19Uw8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769464568; c=relaxed/simple;
	bh=EmrUOUr7XM3Exo/uQsZdt9V5jIFgd+t9+cU10Y+sims=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnW1X5V43J2qjxLi3V0Z7kRKYc/kNDnGS35LsewA6GeS4jRI4/jgHlvlh7vj3qFFicbCK5a1qg08+c8fDCD5ltV7pDMobuMyy0WbSVMcc4qrJ0grdZtlDgWc+/kxL29OVD9etnQl88XZsiBa1hz/vCoE/FXbc8yGfF5uSqt8v1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgEjQqDE; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233b953bebso12466326c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 13:56:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769464566; cv=none;
        d=google.com; s=arc-20240605;
        b=R4d2k/9US9ka9wY8JCimN815GwbjtWN5AsDAqk7XmP7Rpw+M+a0e53D71iv9daAX05
         2NLcBvrgUiyCA9LgWx5PAm66W7q9puzTEAj4vS+uyV8glCRKEl2O2plDsU7Zn9DFQymZ
         +Q9B5/TZUBDZ9VoD2QFloq4oPvPvXMGy488LBQNbCEoUPZco7bfVpFRB2RUTFXO/nbHf
         /tqb0NdELqFBfvzVYj4gjhluuViL6sTZz87RNTjbw120Y34mQcolrk8n1OpBws+X7AVt
         5VnmLyiPe5eZuIJAbNRUtxBkb7i0A6wmUX8cug2xzBVpdZVcYNN8N22ZcarINAym1efq
         qolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAfnYUWqZJMkTRljxQqqOceKMfg6TUYZ4qV1PCN8Qk8=;
        fh=TLmFk4CYzeRqskM1ib/c2R5LaNvrmXKe3O6RCkUqJY8=;
        b=FENX7mcnUECW6zj2dgNG+xmYrdCAiGRx/J3gce52U3QCAfZA1D1K1pToZj++0ytDb4
         ujMNcxBYzwuDBatWmvB0QhP6KuyeO6eb+OpGNKsc/FwDzR7cGONXUgWhztkjlR+Ollf9
         spSmggEbzn793gsK67Riy51bxFqkMTgry8TnltE5a2Wr1BuVuIC+RlAGofGb+WaYNIY7
         /J/uCZRKM9atYGbulP3STzklojdLramlzIvkyt8frXZFen82p/caSQ935UWCT3NiKX3y
         MnNzCroGSt44fW2Xx0wPph2HrjhRaXlIlx3O00s6ExepamA0KnxdDkTsnl3vEsWS+xNf
         VbKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769464566; x=1770069366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAfnYUWqZJMkTRljxQqqOceKMfg6TUYZ4qV1PCN8Qk8=;
        b=cgEjQqDEMV6S01l4Tm2BFPzEgbDWu7N9d0wVRZxC1umY/xPCjezXU3/aT5iokl+bnj
         yJxFHkWYBQWhjhGa+zcDFfaO2jtt6/2KM2DuLM+q0yyf0TBBUfD54paDhnUaLD2APxN3
         GJib+aYf1JdYq+GPGq5+OyIzznRzGv1RIJkh+dzSi7u5OFRU4DOzryxjdt+906wm5Ugp
         hXSPx8LSbkOzWQcDI94aQUrui8t28uB+2rBz59VjN2KGf4ECWR4CVOEEpKtTUIA1BoC5
         wiJmYEDZVaxoXSV9+xleQFg9mOFsHX4Qc9H9dAXEDyo2ysf+CVOVbxRITvY5paVrX4p6
         oq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769464566; x=1770069366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAfnYUWqZJMkTRljxQqqOceKMfg6TUYZ4qV1PCN8Qk8=;
        b=xDHg7oHlj2mkJycDaiHju69HpyHxq5kQy+C0TSXBxUBcly0Bts47dKcpIUteZm+8Sk
         03mW6+ZApKsrhvw6BPNpjWtRo9FL2Wi1JRtUpWPWAO75+GYVesirYbfz/a8SjA07EQQS
         ksk/mv4FBP2GW+NgjYezTumAFzw7/10AcxMrvRuJ8irY8SU8azdNfE+5Tfg6I9SwbR5d
         x3Gi8E0efDNmMfjc57eTUE3D3iUZDSiuitR5lfBvc++dp4ugjRRj/lFSk9GNFj2VcZHq
         o2P1VOIkNXWLcySDdUE88JySc8LP9Q7P6bIlaQPW7HJ7CTBWF4M50jLnYTFik7s8ZefA
         FIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtV2Du3uPHIWiMmlVMsdzNaQheum8XcVVJRh0KVSHP/f6U/EbX/GNqOHfR/ENr3wIRrSL/Lgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChjHz7Tw7cL5rH9Ip0hMbKqBhwQo/uiVDxei42O0JNBNqq9Vt
	oY/Fnots3l32VFNT+HZ4xl3BLArYWTWm5ZS4vpjJ7jq5nfQERGvcRoPjVWSI+jvoD3/P3rgER8G
	g7TnVKyE96ccQ60K8ioZ/8LIsiPsmQEtzhLiX0Dl7
X-Gm-Gg: AZuq6aJwwwdxddFmUuQN7p/GIT0pfneakBWNr0hoyzs/Qr1l4G2R1BlMFprDW9mOJry
	QnLYQKUq/ewpXwIWSZDt7UNF5FT+XNLT94SsM2iElwuOg+P4J12jzwHigMPkDPpRXAu3EJRfKsS
	i2uBWzfdjSQX1rpuDzXoS68pMO5xtbs9TNQU8ZtgiFMe9y56TO3Jh2T8RurFc7dGjvQoQs9M9AV
	d8+DBvNAKJudhEHxGL6qPBPSESduR680QKDlr+VdfSIdOv4oDFEWm9SWFhivAwTNCa5U9Oij6QO
	oAy8PPY=
X-Received: by 2002:a05:7022:458e:b0:11d:e25a:d9ca with SMTP id
 a92af1059eb24-1248ec8d5d9mr2907961c88.26.1769464565359; Mon, 26 Jan 2026
 13:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126144624.2319784-1-brianvv@google.com> <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
 <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>
 <b18b4b38-b3e7-485f-91f8-e3a74ff90572@lunn.ch> <72764a6e-602a-42ed-88c9-e4259b6078f3@intel.com>
 <CANn89iK-W6bKuVZD-5FxxunOtcmwOgAM9d4NPA8XwXXKi_TVJw@mail.gmail.com> <649ae4be-3081-49a2-8ac7-18724272498f@lunn.ch>
In-Reply-To: <649ae4be-3081-49a2-8ac7-18724272498f@lunn.ch>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 26 Jan 2026 16:55:53 -0500
X-Gm-Features: AZwV_Qg-_6RwoCQJkPRhHwJl-qOx5LoDk058u9jX1e_3TVI-Yv9hjldXz_u6cv4
Message-ID: <CAMzD94TJ7pg8gVbUCAhtfkpL4+FtSfepqd=CJ-imNFq-A5W0gw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH v2] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Dumazet <edumazet@google.com>, Jacob Keller <jacob.e.keller@intel.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253603-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[google.com,intel.com,gmail.com,davemloft.net,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 9CB008DBD3
X-Rspamd-Action: no action

Sure, sending v3 to add more details about the ABI.

On Mon, Jan 26, 2026 at 4:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jan 26, 2026 at 09:51:10PM +0100, Eric Dumazet wrote:
> > On Mon, Jan 26, 2026 at 9:46=E2=80=AFPM Jacob Keller <jacob.e.keller@in=
tel.com> wrote:
> > >
> > >
> > >
> > > On 1/26/2026 9:53 AM, Andrew Lunn wrote:
> > > > On Mon, Jan 26, 2026 at 12:40:15PM -0500, Brian Vazquez wrote:
> > > >> On Mon, Jan 26, 2026 at 11:24=E2=80=AFAM Andrew Lunn <andrew@lunn.=
ch> wrote:
> > > >>>
> > > >>> On Mon, Jan 26, 2026 at 02:46:24PM +0000, Brian Vazquez wrote:
> > > >>>> The code uses the vidx for the IRQ name but that doesn't match e=
thtool
> > > >>>> reporting or netdev naming, this makes it hard to tune the devic=
e and
> > > >>>> associate queues with IRQs. Sequentially requesting irqs startin=
g from
> > > >>>> '0' makes the output consistent.
> > > >>>>
> > > >>>> Before:
> > > >>>>
> > > >>>> ethtool -L eth1 tx 1 combined 3
> > > >>>>
> > > >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > > >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > > >>>> /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> > > >>>> /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> > > >>>> /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> > > >>>> /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> > > >>>>
> > > >>>> ethtool -S eth1 | grep -v ': 0'
> > > >>>> NIC statistics:
> > > >>>>       tx_q-0_pkts: 1002
> > > >>>>       tx_q-1_pkts: 2679
> > > >>>>       tx_q-2_pkts: 1113
> > > >>>>       tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
> > > >>>>       rx_q-0_pkts: 1143
> > > >>>>       rx_q-1_pkts: 3172
> > > >>>>       rx_q-2_pkts: 1074
> > > >>>>
> > > >>>> After:
> > > >>>>
> > > >>>> ethtool -L eth1 tx 1 combined 3
> > > >>>>
> > > >>>> grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > > >>>>
> > > >>>> /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > > >>>> /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> > > >>>> /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> > > >>>> /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> > > >>>> /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> > > >>>>
> > > >>>> ethtool -S eth1 | grep -v ': 0'
> > > >>>> NIC statistics:
> > > >>>>       tx_q-0_pkts: 118
> > > >>>>       tx_q-1_pkts: 134
> > > >>>>       tx_q-2_pkts: 228
> > > >>>>       tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
> > > >>>>       rx_q-0_pkts: 111
> > > >>>>       rx_q-1_pkts: 366
> > > >>>>       rx_q-2_pkts: 120
> > > >>>
> > > >>> Are there any ABI issues here?
> > > >>
> > > >> The patch doesn't change the format, it just fixes the numbering i=
n
> > > >> the name to make it consistent with other reporting tools. It
> > > >> shouldn't break any library.
> > > >
> > > > But is the numbering part of the ABI?
> > > >
> > > > Making a comment about ABI in the commit message makes it clear it =
is
> > > > something you have considered, and you have decided it is not an
> > > > issue. If there is no such comment, reviewers probably should ask.
> > > >
> > > >         Andrew
> > >
> > > I don't see how an application can depend on the name if it can't
> > > correlate it to anything meaningful. The change fixes the ID values u=
sed
> > > so that they *do* correlate. If an application was previously assumin=
g
> > > it correlated to the queue ID, it would incorrect associate the IRQ w=
ith
> > > the wrong queue.
> >
> > Agree, this mismatch caused me some surprises, we can not keep a broken
> > ABI (which has been broken by accident)
>
> So everybody is agreed, great. I just think it would of been good to
> mention ABI in the commit message, to show due diligence has been
> done.
>
>    Andrew

