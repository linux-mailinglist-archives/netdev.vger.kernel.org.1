Return-Path: <netdev+bounces-253558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOK+KxKnd2lrjwEAu9opvQ
	(envelope-from <netdev+bounces-253558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:40:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C1C8B95B
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB463028B0F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5434D3AD;
	Mon, 26 Jan 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVoQcV9K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B333BBD3
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449230; cv=pass; b=I86Ezd0zEvcPHxJpBkYgHeAOXdHNnWJUGOgVHg0DPipjrBhSXI42R1gW+EcgN68CO9e7Xsx9ABvIn0sv2k5KyiRFKBFHFdKYQvW60uN396J+fi8XYE+ZjPbkzmAUaDlsrV2HVj6A9bSIMfw7szm8lOWIzOGuwSgcVDzVSXjtibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449230; c=relaxed/simple;
	bh=4UNOcMzuUkUOYuRmH7MmKBSBGhyiePwww6iVHA7MGPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hy/Q7NJq/fwcFdZmF/UpBAKT4KeecZk4U6g2CZUfsdEgG7sCzwiWNoBeBw3DHRj9TM2hCJdsuJjA5JljeX4SFQr12Ee1kJVfBjr3PPWAAmPRkKmgUDnvSuv0cEqozkT9/udUvX1og55+KmfGFtXJZI9zVrmLHyAHxaLsizgkpQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVoQcV9K; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-124877d78a6so2260881c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:40:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769449228; cv=none;
        d=google.com; s=arc-20240605;
        b=Cb4Yf5iVqCLe2iLxXuFANAj2dDhIcXhvQF99/TKsPeg+auTpHQGijZzXcerDM9t/7f
         odp2Hm1X3Mr94mMT38UbAQQLL8uNJriCf4EWml4jOOY6xuh7VlQwAorITq08b3dDFv0h
         A4rzxysyl0TzjpxGbwxFQJai35ygtWlW5LFKoZfl7dXHE3VwRu0jCm+evcq41iRndQTi
         FLTqJ7RtDU4ZzpNyG3ERx6meo0LH4OTUyzi+Bedh9ZQJ2tSDPPxnoz1surThMzJGj5xd
         K0eOJ1q4yOngK2FrJwK5OODwk4m3AKMfNKCF/tHzRE5gMGnwulFvjCrSq7RhG8/xArkM
         yN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O2YPljFd1Myds7GZBBZxikHuHSUzwMw9rrYzn56kfh0=;
        fh=r1EcfkN8hmoN3W63iVoiXnpOvWOXWnoooab6tvUu4Gc=;
        b=fe8PsEfTB0FTjIgWcQMTtYg6oTDRjeZSImn0GOqije0NoktTDmvGaW7K5BOaZ1/auY
         PdAA6OpqU6i4aA1rUGL7/C3KCTQxaPmOwzLeK5sCXAvUs7Pu1jbqmBr1Ihc3Z4oZWU/O
         FEzI/G8LE5eZGwafkt9i73IL4nmz1urD0WHtWlEoPb2BAwt14tUQ9e6WfLTo/v/KOP/g
         ZWRLPTT8VM7LNRC8p+skzGPYbyXMnW1qPvzbczWUJL3y7G2xcw2yJotvLODfgSyeYz2m
         /di+h40IaKkbKLbnBJB05t1I0V+W7lbqVcCvTviKLcfL8v6jzvbgmbkem3aKzYkQwyKm
         lcSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769449228; x=1770054028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2YPljFd1Myds7GZBBZxikHuHSUzwMw9rrYzn56kfh0=;
        b=nVoQcV9Kr26Kwun9yPQRymkgyDr/It1IqEppkHtY2a7Oe8eUu6rfVBt2q0+JkhpbUS
         rCrVJkfkOWvUz2eav5nM8kG3tttiMmfDbySJt/h5OTOxIJYgRuAP+KjDA0TWlFZYxBLj
         AWj/Bd/j5BH066sE5hHmMyW2RXvYlnC/u4FPi9g8Rf0yyN388ipmXSzo+m59wmQiaAWL
         qp0IOAu63mFkb0QqRMsK5zzyBZFriIBjh/5FC5xvy2FjtJ+/c15FgRpjDmHXsOsHzOKc
         pGxW+nSrUjaVsfLMGy12mIafDDmf18056oGEit581fG99yNUOfLiKMKNxi1qow+zIoD9
         utCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449228; x=1770054028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2YPljFd1Myds7GZBBZxikHuHSUzwMw9rrYzn56kfh0=;
        b=GplCIXZPQPJzKHY/xRiDntXzkFUMmtDsljpKHQF5RF43exVjftqOqemYVw97jlMaYa
         ANX87TZI4izhL5c4+61/KrvlzPjzaSuCmD97cC2MHZjnLKJTpCa7wAUneuAYOs2CECBy
         Apt1EyCVO/C8wcKsMq5V3+dEcZqBwqYLxTDa7bgPLyY99VsfU7A7EhDBGXMvpEA+IMGY
         iY7fRc/mrrWzqSspE7HMZ+g4bMZ5Rv2rPrHbGBaaQq6Dl9pEEiANeQ78w7+pYwbwGUdW
         M0+SIR1V1d7n/bcT18LjMGoxQVtVk/FqYGoURJjCtvLaBhKPjvEvb8GX7S9Min011v6l
         q9bg==
X-Forwarded-Encrypted: i=1; AJvYcCX+nGC2jrs4thjRJqju3mhtkLqcOPM9kC+cBdCLT/b32DAP1OHh9TGn2UBtexzaFbZkyYWH8iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqlbi26Wn8uN/hRz0DXvyKB0Gqmm4g5LZgm8lAWcn6EZcg4WM4
	XORjy6gd2svJaHRi3CSda5wPbabIo6iyPlVzSDHBfNh3ek7UXVizvUjJXMxTlF262YpftgVxEnp
	ICpKZjsnXu7+etPaqxvehBhFZwFU1KNYOuWEItojo
X-Gm-Gg: AZuq6aJs1B5Lqg+kdxsVW2MGya7/AwgrBzzPnnH/t17I3OGYWCP/kwfpIcxFToaNNZm
	XUxMpF9NC5LCK5o0tDg5/onYan+HGNrC9M//KKBv4pxK/5DJgcLJT2hF0Qrrx7HqC180XA/7laX
	uFQZ/eTCWFOqH7EO8OQWb0/thgjzK9nwgI2DSs5/cPf52RAArgGNN3Brnv/RXHL/lTgPxhSRbiP
	Bm0+i/jsuugzrK4ukdpURKhxp8wM3OUYgYv1UOYCcRlgLcKt4eq2UlZaRDGcW9QTDP+7dWQ
X-Received: by 2002:a05:7022:4582:b0:123:3407:106a with SMTP id
 a92af1059eb24-1248ec4141emr2882844c88.32.1769449227636; Mon, 26 Jan 2026
 09:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126144624.2319784-1-brianvv@google.com> <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
In-Reply-To: <37e1a648-609b-4d5e-9176-fbbacc7e9e07@lunn.ch>
From: Brian Vazquez <brianvv@google.com>
Date: Mon, 26 Jan 2026 12:40:15 -0500
X-Gm-Features: AZwV_QhpEsBrkcG32TbQrICcb_Md0HToT8n22VHYr9HbxmIV-YjNNXh0C-d9bu0
Message-ID: <CAMzD94Qt9-5G-8MHcmHLgYEyjRUoPB+SruzZXafxSTkNV8criA@mail.gmail.com>
Subject: Re: [iwl-net PATCH v2] idpf: change IRQ naming to match netdev and
 ethtool queue numbering
To: Andrew Lunn <andrew@lunn.ch>
Cc: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, David Decotigny <decot@google.com>, 
	Li Li <boolli@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	Brett Creeley <brett.creeley@amd.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-253558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,davemloft.net,google.com,kernel.org,redhat.com,lists.osuosl.org,vger.kernel.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36C1C8B95B
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 11:24=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Mon, Jan 26, 2026 at 02:46:24PM +0000, Brian Vazquez wrote:
> > The code uses the vidx for the IRQ name but that doesn't match ethtool
> > reporting or netdev naming, this makes it hard to tune the device and
> > associate queues with IRQs. Sequentially requesting irqs starting from
> > '0' makes the output consistent.
> >
> > Before:
> >
> > ethtool -L eth1 tx 1 combined 3
> >
> > grep . /proc/irq/*/*idpf*/../smp_affinity_list
> > /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > /proc/irq/68/idpf-eth1-TxRx-1/../smp_affinity_list:0
> > /proc/irq/70/idpf-eth1-TxRx-3/../smp_affinity_list:1
> > /proc/irq/71/idpf-eth1-TxRx-4/../smp_affinity_list:2
> > /proc/irq/72/idpf-eth1-Tx-5/../smp_affinity_list:3
> >
> > ethtool -S eth1 | grep -v ': 0'
> > NIC statistics:
> >      tx_q-0_pkts: 1002
> >      tx_q-1_pkts: 2679
> >      tx_q-2_pkts: 1113
> >      tx_q-3_pkts: 1192 <----- tx_q-3 vs idpf-eth1-Tx-5
> >      rx_q-0_pkts: 1143
> >      rx_q-1_pkts: 3172
> >      rx_q-2_pkts: 1074
> >
> > After:
> >
> > ethtool -L eth1 tx 1 combined 3
> >
> > grep . /proc/irq/*/*idpf*/../smp_affinity_list
> >
> > /proc/irq/67/idpf-Mailbox-0/../smp_affinity_list:0-55,112-167
> > /proc/irq/68/idpf-eth1-TxRx-0/../smp_affinity_list:0
> > /proc/irq/70/idpf-eth1-TxRx-1/../smp_affinity_list:1
> > /proc/irq/71/idpf-eth1-TxRx-2/../smp_affinity_list:2
> > /proc/irq/72/idpf-eth1-Tx-3/../smp_affinity_list:3
> >
> > ethtool -S eth1 | grep -v ': 0'
> > NIC statistics:
> >      tx_q-0_pkts: 118
> >      tx_q-1_pkts: 134
> >      tx_q-2_pkts: 228
> >      tx_q-3_pkts: 138 <--- tx_q-3 matches idpf-eth1-Tx-3
> >      rx_q-0_pkts: 111
> >      rx_q-1_pkts: 366
> >      rx_q-2_pkts: 120
>
> Are there any ABI issues here?

The patch doesn't change the format, it just fixes the numbering in
the name to make it consistent with other reporting tools. It
shouldn't break any library.
>    Andrew

