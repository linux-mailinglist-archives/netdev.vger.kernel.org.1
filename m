Return-Path: <netdev+bounces-299066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NXAPEt/ULWrBkwQAu9opvQ
	(envelope-from <netdev+bounces-299066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B092D67FDEC
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:08:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K94pHjga;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299066-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299066-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10E23053DC2
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3603859DE;
	Sat, 13 Jun 2026 22:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2A30DED5;
	Sat, 13 Jun 2026 22:06:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388370; cv=none; b=N9J20F8i57V8T5MQf+ZrSPdfPqpEIXjgniMnF/f32lnwx87aXaDSa3J+MBu7vcpgRWU/DfgB0akm7ZAI6mOS65GvZWEw3O+hgfz64WSE/XjuoFLery7jUiPm0AXCP2Y5aeQHE/4aBd6AjVgyTfT9W6lezWQA60xR5XVXGR37Ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388370; c=relaxed/simple;
	bh=/hAcVRG4OiAxYuGPCQOTR88/XoL62QAPkEM8enyd3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8o3fFFtV2xPj1C3ZIEiJGvBUnaYDl00Ak/ZrnDsMlXBjER9p+L0CYvihkN8mUn0Sa1+DkPN6xgfz+tLo7C7AMpBIw7CCg/VWcRzoULSoAVTm8Ns0Nb8J1XhGPrw17It11F7ywHWFJ0dXZbZ/+LYudCZOuF7n5cGsjisCOtNyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K94pHjga; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2351F000E9;
	Sat, 13 Jun 2026 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388365;
	bh=BxFDB+Dbp29fvUO8SbkuSPDqEh4Rx58zetJfg6hIPuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K94pHjgaUIvip9HyBF77Uq4Fxi+Q7Flc4Lqjm3/fD96AL8qnUQsRta4lCGs9jBogm
	 lJuNtp56uUPD6BpBpFhG+IANrYLb9jJpfbt9QDTjNeCCh+JIH46KfyvQKnSK/emuMD
	 COa42WhoqrhV6LyEumZj52umVg2kq479+MXCwo9Y2JE6ZzLS+7E7JuiXe1VMw7kmI4
	 NLo83Hv70oOZydBWCbYAHmb/AfNhUN8oh1zs75t+IVEycOw5+AvM5bv6wZDLW9bje5
	 4VDYb9LcDETBc+y9fFB6LTVgMnYmUh5qehPR8Q6NVMmH2sxurAmTs2PzLXFAYeYcnM
	 pz+tM85vyiUQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: javen_xu@realsil.com.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/6] r8169: fix RTL8116af can not enter s0idle and c10
Date: Sat, 13 Jun 2026 15:06:04 -0700
Message-ID: <20260613220604.219837-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611094345.880-7-javen_xu@realsil.com.cn>
References: <20260611094345.880-7-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:kuba@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B092D67FDEC

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8169: fix RTL8116af can not enter s0idle and c10

RTL8116AF is a multi-function device where functions 2 to 7 are hidden from
the PCI core. This commit puts these hidden functions into D3hot and enables
ASPM on their PCIe link control register by writing to their configuration
spaces.

> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index a49e7a8d8f4da..bc00cdc3add65 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -356,6 +356,9 @@ enum rtl_registers {
>  #define LINK_SPEED_CHANGE_EN		BIT(14)
>  #define LTR_SNOOP_EN			GENMASK(15, 14)
>  #define LTR_MSG_EN			BIT(0)
> +#define RTL8116AF_FUNC_PM_CSR		0x80
> +#define RTL8116AF_FUNC_EXP_LNKCTL	0x44

[Severity: High]
Are these offsets swapped?

In typical Realtek PCIe configuration space, the PM capability is at 0x40
(making PM_CSR offset 0x44) and the PCIe capability is at 0x70 (making Link
Control offset 0x80).

Because these definitions might be swapped, the code later reads 0x80 (Link
Control) and applies PCI_PM_CTRL_PME_ENABLE, and reads 0x44 (PM_CSR) and
applies PCI_EXP_LNKCTL_ASPMC. Could this cross-wiring fail to set PME_ENABLE
in the PM_CSR register as intended?

> +#define RTL_PM_D3HOT			GENMASK(1, 0)
>  };
>  
[ ... ]
> @@ -3731,6 +3734,33 @@ static void rtl_hw_start_8168ep_3(struct rtl8169_private *tp)
>  	r8168_mac_ocp_modify(tp, 0xe860, 0x0000, 0x0080);
>  }
>  
> +static void rtl_disable_hidden_function(struct pci_dev *pdev)
> +{
> +	unsigned int slot = PCI_SLOT(pdev->devfn);
> +	struct pci_bus *bus = pdev->bus;
> +	unsigned int devfn;
> +	int func;
> +	int ret;
> +	u32 val;
> +
> +	for (func = 2; func < 8; func++) {
> +		devfn = PCI_DEVFN(slot, func);
> +
> +		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, &val);
> +		if (!ret && !PCI_POSSIBLE_ERROR(val)) {

[Severity: High]
Is it possible to verify that the function is the intended hidden device
before proceeding?

The commit message notes that the hidden functions return an all-ones
response when their vendor ID is read. However, this code reads offset 0x80
and checks that it did not return 0xFFFFFFFF. If a legitimate, OS-enumerated
function exists at any of these indices (e.g., a secondary NIC, Wi-Fi, or SD
card reader), the read will succeed with valid register data and the driver
will overwrite its registers at 0x80 and 0x44.

Should the loop read the Vendor ID (offset 0x00) and verify it returns
0xFFFFFFFF to ensure the function is truly hidden before mutating its
configuration space?

> +			val &= ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE);
> +			val |= (RTL_PM_D3HOT | PCI_PM_CTRL_PME_ENABLE);
> +			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_PM_CSR, val);

[Severity: High]
Can these 32-bit read-modify-write operations on natively 16-bit registers
unintentionally clear adjacent Write-1-to-Clear (W1C) status bits?

Reading a 32-bit value from offset 0x80 fetches both the Link Control (lower
16 bits) and Link Status (upper 16 bits) registers. Link Status contains W1C
bits. Writing the unmodified 32-bit value back writes 1s to any W1C bits
that were set, clearing them.

The same applies to the 16-bit PM_CSR register, where writing back the 32-bit
value might clear the W1C PME_Status bit (bit 15) if it was set, and
needlessly overwrite the adjacent 8-bit PM_Data and PM_Bridge_Ext registers.

Would it be safer to use pci_bus_read_config_word() and
pci_bus_write_config_word(), and explicitly mask out the PME_Status bit when
writing PM_CSR?

> +		}
> +
> +		ret = pci_bus_read_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, &val);
> +		if (!ret && !PCI_POSSIBLE_ERROR(val)) {
> +			val |= PCI_EXP_LNKCTL_ASPMC;
> +			pci_bus_write_config_dword(bus, devfn, RTL8116AF_FUNC_EXP_LNKCTL, val);
> +		}
> +	}
> +}

