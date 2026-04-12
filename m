Return-Path: <netdev+bounces-277827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNobOl7F22kRGgkAu9opvQ
	(envelope-from <netdev+bounces-277827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:16:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E4E3E4B39
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D41300FFA5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22842DC76A;
	Sun, 12 Apr 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Snttv5c7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8B2DC331;
	Sun, 12 Apr 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010575; cv=none; b=OgUiw2/oSrlp7E/IpNTrvNF4CrfhBSLebSFlvSBi/L/aTQCyIlHO0wtX3A5lPkzTu61R8HSDxo/+b9wuav0p4a/pxlF/Pjcc4Kts/G4URml/bbZ94nsFGW6OwYCkiGoGNryp1LIK0taZq/InFvI72rTjs7z2hqfEd8X3l9cLLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010575; c=relaxed/simple;
	bh=i8+c3zrd0aQ70iWJjRyQOJIhJYSNkL7NpiN2ytAgdyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmTr35Lz0jIhbEE3NEQWyV1l83C9eDcsflf3aBX/mR6Qr6htUxvKmqSSD0gFjo6Jm8A0+v+oYS1BTlA1LIJe45nVG0hmPE0pOhCCEBY5X3GxhLUZmRiN3MtoqvvOTnXnaqnI4Y8hldW0if+io/PQ6KzBvMUc33McPQCFq0HDUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Snttv5c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D24FC19424;
	Sun, 12 Apr 2026 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010575;
	bh=i8+c3zrd0aQ70iWJjRyQOJIhJYSNkL7NpiN2ytAgdyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Snttv5c7ZYaIftvcONG5laIm6mjGFHPF6/0lkK8wot828xgp4NiATEHhEIp5F3lnF
	 JdS8qJve4gHwmJqt2/TsTQobM+srDcyNFGlV/8dYSEXGKGJIKIUgtggo9YOtLXsJLV
	 2d4DHir4STAWNdSkGlhcl55H/Upwk7CMnXLnkkbkpEpuiIBC81aZQbABPZ6TW2DED2
	 UsUxHAXhCT95Xixhbiv9zJFiqwPbeX+ctxxBLl2UfJS5el70bPcOKOZbpRGgcQUknW
	 aamRotzmgqrBWO4SFo/TFxpXOTXWrMTYtJj0FJ1SY0YQlNiTZmK5OYtJs8xTl+muyb
	 MNFTMGw/0Lglg==
Date: Sun, 12 Apr 2026 09:16:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2026-04-10
Message-ID: <20260412091614.1786af4e@kernel.org>
In-Reply-To: <20260410172206.150975-1-luiz.dentz@gmail.com>
References: <20260410172206.150975-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9E4E3E4B39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 13:22:06 -0400 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
> core:
>  - hci_core: Rate limit the logging of invalid ISO handle
>  - hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
>  - hci_event: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
>  - hci_event: fix potential UAF in SSP passkey handlers
>  - HCI: Avoid a couple -Wflex-array-member-not-at-end warnings
>  - L2CAP: CoC: Disconnect if received packet size exceeds MPS
>  - L2CAP: Add missing chan lock in l2cap_ecred_reconf_rsp
>  - L2CAP: Fix printing wrong information if SDU length exceeds MTU
>  - SCO: check for codecs->num_codecs == 1 before assigning to sco_pi(sk)->codec
> 
> drivers:
>  - btusb: MT7922: Add VID/PID 0489/e174
>  - btusb: Add Lite-On 04ca:3807 for MediaTek MT7921
>  - btusb: Add MT7927 IDs ASUS ROG Crosshair X870E Hero, Lenovo Legion Pro 7
> 	  16ARX9, Gigabyte Z790 AORUS MASTER X, MSI X870E Ace Max, TP-Link
> 	  Archer TBE550E, ASUS X870E / ProArt X870E-Creator.
>  - btusb: Add MT7902 IDs 13d3/3579, 13d3/3580, 13d3/3594, 13d3/3596, 0e8d/1ede
>  - btusb: MediaTek MT7922: Add VID 0489 & PID e11d
>  - btintel: Add support for Scorpious Peak2 support
>  - btintel: Add support for Scorpious Peak2F support
>  - btintel_pcie: Add device id of Scorpius Peak2, Nova Lake-PCD-H
>  - btintel_pcie: Add device id of Scorpious2, Nova Lake-PCD-S
>  - btmtk: Add reset mechanism if downloading firmware failed
>  - btmtk: Add MT6639 (MT7927) Bluetooth support
>  - btmtk: fix ISO interface setup for single alt setting
>  - btmtk: add MT7902 SDIO support
>  - Bluetooth: btmtk: add MT7902 MCU support
>  - btbcm: Add entry for BCM4343A2 UART Bluetooth
>  - qca: enable pwrseq support for wcn39xx devices
>  - hci_qca: Fix BT not getting powered-off on rmmod
>  - hci_qca: disable power control for WCN7850 when bt_en is not defined
>  - hci_qca: Fix missing wakeup during SSR memdump handling
>  - hci_ldisc: Clear HCI_UART_PROTO_INIT on error
>  - mmc: sdio: add MediaTek MT7902 SDIO device ID
>  - hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

Two fixes tags are messed up here:

Commit: 802446198014 ("Bluetooth: btmtk: hide unused btmtk_mt6639_devs[] array")
	Fixes tag: Fixes: 4cdd001ff03f ("Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support")
	Has these problem(s):
		- Target SHA1 does not exist

Commit: 28c9cc700e30 ("Bluetooth: L2CAP: Fix printing wrong information if SDU length exceeds MTU")
	Fixes tag: Fixes: fa768fce4aae ("Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU")
	Has these problem(s):
		- Target SHA1 does not exist

