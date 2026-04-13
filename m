Return-Path: <netdev+bounces-278191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +kS4ISxN3WmacAkAu9opvQ
	(envelope-from <netdev+bounces-278191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:08:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C49893F301C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB46930210C5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F338BF67;
	Mon, 13 Apr 2026 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egeaQXz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29E2D9481
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110889; cv=pass; b=O3RRQn5g6WPbpH+lPXL7cozznFd40mXy9xMxdRHVzrzGOG6+4BKA5R3lFnxGKIY8YBnmohUjZipRuIjkkyb/zgXCL7rG6pvE6iUESZlrIB/xiDEqwwYiAInSmYpCh3/XQB4tWQSQqkI+b9a3fJXqV+0iu9rl7IdIqz7O44qCw0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110889; c=relaxed/simple;
	bh=YVMIrUVS6zcmaa+3JMMy551/txh2lQw63V9+1RoWZ28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdHgJKw6qdZZP+YY1tYXYVAItrGsqImY6SqSfDJMc99BE5SDX7RHzpcC/B+vMNTU57UxPItpdz61yY9n9mUNf753Ov1OTZLy2EFu8BXmKjhtmCPK/wfaD+9PZIBX0SHu+9V4mHVLkFkVyQEX7cEREZQscvqsZ2VCjCN8KHxIUoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egeaQXz1; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651bf4a4140so1806716d50.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776110887; cv=none;
        d=google.com; s=arc-20240605;
        b=KBgMWwsHLtl5owJr7xiiUJqg6Y+X3U62iqMzr6xQDjO1QSLyBpWvOqTCsb1m71ai2b
         kDDOKd7ojBlzzSAITNZPJ+Tyab7jWrF2zVekQVvd2UIRp3L79ovkrV/gjkkrNHrgHEQ5
         ASwxv8lJ0w0iuk4oowqdEUgEN8Vo6aGqUCwlcVhu8yO7B4qS1mm2R9zWxB9exBC2+5LY
         VpcAWDDvDcVKs64imksk34TMDYURr41InmflT9ZLgegwnhydK1u75Wbo2mgfvFd3pyOR
         e8vCseRbdVC3s7QI/JYUyy3Vi93FE6xvIBKv8fLb7nfPOGuMMrrWakQ03T3CfCRtq7UQ
         VaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        fh=4rh2dAgAhp6VsGkh0ckTbGyQR3eiClrbba7m7l8PXbI=;
        b=bd3Ebvl8vhr2/cRkzT5keNmlq4nppp0kL8VlJN37+wk7QT1p6fkxfp6K2Srz5rIqwg
         cm3JZGP7zrttxs2fAgWwK7VMt9Pk1DWR81s/pcQ0rG1NURtRKcEgPT/TRHQUsHc5jluB
         upjbCTllMtM001b+7S3JHqoZ5IiW8JZL2qMD2VcGZ2gcpo7JdbB/y1wE2FSfVdg7KHb2
         9fTFfZACA5+rYNmgE5aaJ74Duw+Bd/E3qLwj2TLvWkCgAegtfSMcKjI1X18o7jZOlG32
         RQRn+CtVeQ6JuOcxXtQ1DZuLAU35Cug20GNLOFcPlsagkRoVSr3ucB28xwddvXQXA/Xt
         K9zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776110887; x=1776715687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        b=egeaQXz1sPI2rQH3TeLrsGVI6UEz444+82T7uUqKAkQBwoCt9loSBETe4SAvC2F8dt
         KMkbyOEz8vL6yfelltOxnCvFX/aTP2ku2XE5piUY9qLnCS/nZByTrieUHB0nQMAznozn
         hz+064mkJdew7xJpW6PKsUA/lMBU8k5sd7MS/9O/9rsHZWvgahi7n6k11V2mRtDzTuBA
         kEFCvDati90yL0ex657/qNAlJNPO2u0MEmJkT4/chEN+w4EycfoSq2m98YJXF5EwP6GB
         f/mPY8otywlBRNF8idPIuIZ/p+PizRzfEmtSFPYUeYjreI0Vu8rxlOG/e0Fb1exopEIL
         RFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776110887; x=1776715687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPf0rvmFFFJycYIPeYdrhVjXf9meJ4UbCJJ7TADNpE8=;
        b=JMD9M7a7oBbmz1IWsznw2DlOQeoZUxdzFbOOCL7fkPBtn8Fcq69+sFKow1TZYiS2Ye
         BJnE4SjBiDBgxs8kWcmllVuIzJBtFKKpkByKO+fJF1w1bdqt/IE9byJWaQVw6FxlgBEZ
         ms+cEj/ZB5QEZH4prJvL6m+T8QG0cGkjkG3qp+WTmIigywBRcJJIzrdKR6i+xYA7DIUS
         QtMcIhY18sPxiUj91WhHx2oNqvh62w+jnEmS2gnyVHRGXk+5JIVPDGMUr0Yh7XzUkah9
         k8ySwj6L0Uh7A/gNr2ywvIRia+KjMDfOgaJQap7g6znWGoEH6U8v76CRAN/6Dh71L1uS
         rTLg==
X-Forwarded-Encrypted: i=1; AFNElJ8jiJcBv5HTKrrsmPOoLHQwn1MA5MjJA2nY/5EMzecuklaS9PBJjoX+qimuwOVD5bF/+98dN8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM8pVa7rsVnGStAK2TspJejWeUO0lRW2uBjAPjFznii+PMcEY1
	ISz9uyn1yiN4iw3r605zFZIfPgaG4mSGEMkSZwvEyMeJitxkWwF2vwl6dVyH4CIHehUIVDdFYbW
	vwx2GVVAu3ayvWElSDVSgD3xUJ2UUcck=
X-Gm-Gg: AeBDiesC9OSiOZfggXgL0U4+GwTxm7j4bnXOyQM93mSkL5qlEzApqN2hSeHRUIWqewP
	aRB6QoCjzr7c7hE67PwNn20nHVkP33MkQxxtLVk61j4YHKxnqLonNhwbdISB87Ho7BtBDmx2enW
	Hhw0dVZkLbu/d8RXrUABsPimom4CZSnxWGJtaI1DukhLSe3VggRQMIacZ5SbfKXN3czw7GrFtKX
	HhP53x/GVz41xGJy1K/y8j+LagSqv3aSJppxIQsOhGCopMftjWQ42IkB3nDa/g9xzkSmIFEMzE3
	MNjF36XN9J516PM5fjd+/WNwg+HYKkVughYYYGdX+xkcXL/+iIwKS2aZda3QwMXEehu28Q==
X-Received: by 2002:a05:690e:1919:b0:651:b2ed:5dc with SMTP id
 956f58d0204a3-651b2ed0f0bmr9095260d50.52.1776110886898; Mon, 13 Apr 2026
 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410172206.150975-1-luiz.dentz@gmail.com> <20260412091614.1786af4e@kernel.org>
In-Reply-To: <20260412091614.1786af4e@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Apr 2026 16:07:55 -0400
X-Gm-Features: AQROBzA-VwBQCcwLZ_TGntNXIr8QWO5A1gfM_ntaeN0OoblK55smm1NdczSB36s
Message-ID: <CABBYNZLg_Dz9ieQ+ioXf2+Oa+vdL8BMbnt=qOfkONOpNsUZ5qw@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth-next 2026-04-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C49893F301C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub

On Sun, Apr 12, 2026 at 12:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 10 Apr 2026 13:22:06 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
> >
> > core:
> >  - hci_core: Rate limit the logging of invalid ISO handle
> >  - hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
> >  - hci_event: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFE=
R
> >  - hci_event: fix potential UAF in SSP passkey handlers
> >  - HCI: Avoid a couple -Wflex-array-member-not-at-end warnings
> >  - L2CAP: CoC: Disconnect if received packet size exceeds MPS
> >  - L2CAP: Add missing chan lock in l2cap_ecred_reconf_rsp
> >  - L2CAP: Fix printing wrong information if SDU length exceeds MTU
> >  - SCO: check for codecs->num_codecs =3D=3D 1 before assigning to sco_p=
i(sk)->codec
> >
> > drivers:
> >  - btusb: MT7922: Add VID/PID 0489/e174
> >  - btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
> >  - btusb: Add MT7927 IDs ASUS ROG Crosshair X870E Hero, Lenovo Legion P=
ro 7
> >         16ARX9, Gigabyte Z790 AORUS MASTER X, MSI X870E Ace Max, TP-Lin=
k
> >         Archer TBE550E, ASUS X870E / ProArt X870E-Creator.
> >  - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e=
8d/1ede
> >  - btusb: MediaTek MT7922: Add VID 0489 & PID e11d
> >  - btintel: Add support for Scorpious Peak2 support
> >  - btintel: Add support for Scorpious Peak2F support
> >  - btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
> >  - btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
> >  - btmtk: Add reset mechanism if downloading firmware failed
> >  - btmtk: Add MT6639 (MT7927) Bluetooth support
> >  - btmtk: fix ISO interface setup for single alt setting
> >  - btmtk: add MT7902 SDIO support
> >  - Bluetooth: btmtk: add MT7902 MCU support
> >  - btbcm: Add entry for BCM4343A2 UART Bluetooth
> >  - qca: enable pwrseq support for wcn39xx devices
> >  - hci_qca: Fix BT not getting powered-off on rmmod
> >  - hci_qca: disable power control for WCN7850 when bt_en is not defined
> >  - hci_qca: Fix missing wakeup during SSR memdump handling
> >  - hci_ldisc: Clear HCI_UART_PROTO_INIT on error
> >  - mmc: sdio: add MediaTek MT7902 SDIO device ID
> >  - hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
>
> Two fixes tags are messed up here:
>
> Commit: 802446198014 ("Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] =
array")
>         Fixes tag: Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT=
7927) Bluetooth support")
>         Has these problem(s):
>                 - Target SHA1 does not exist
>
> Commit: 28c9cc700e30 ("Bluetooth: L2CAP: Fix printing wrong information i=
f SDU length exceeds MTU")
>         Fixes tag: Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect =
if received packet's SDU exceeds IMTU")
>         Has these problem(s):
>                 - Target SHA1 does not exist

Would you be able to pull the for-net-next-2026-04-13?

--=20
Luiz Augusto von Dentz

