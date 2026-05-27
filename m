Return-Path: <netdev+bounces-292321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PEuJwr+FmoJ0QcAu9opvQ
	(envelope-from <netdev+bounces-292321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:22:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 358645E5CB4
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C73A33036FBC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51466410D04;
	Wed, 27 May 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX/x28YA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43833FE1F
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891709; cv=pass; b=YrpBwQ53eDTiStGEBXAl8Uta07swBIdbYgfT0Eqx4NMLe0glLGUZCzF9gvs7l/HdJUj3fT7Ee/KszLs68HrroQjKlPqgDhJb/SNMgLh1UoWyA8xALsMwQILwuPgEFmX8ocZGEGDuQpsXZDQNh3poZT6Yobvu8PJH/gda7K5oPUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891709; c=relaxed/simple;
	bh=YurxwnvFf2EB/iLHQOzX7OV5FxVsG3QNnTbk7azhjlI=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ijxbc/X+cqtuEF1BHZG67pteXKxWQHdaPgpqznm11rYMLircO6VBwQWgfmwWJVOTLLRB8dr/5Z37tAR7dDuJ8ot/yPmuPLTYomwroWJhmj4gVP/OAKgppWYY982RdNe+AOzPwMRqo6q88ZP1gdmlz/sB6AObBCx7qm+Bq7Fssz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sX/x28YA; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-512f09ecc67so81376701cf.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 07:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779891701; cv=none;
        d=google.com; s=arc-20240605;
        b=AhkGjjLW4B8KA92k5Rd6JlW6EFASJilyanRYp5shT3Q3iBPSlngv7VKf+6UgpxNlEs
         79ue9xMqBIwAK6wgmCiA8R9okSKsspr9sC7/Hl+nVX43EJO5gUPY8R0yWoXdnsEaUoUO
         F/bLxP1SqNv1KAQOZygepjLXHqXxiQ25byffbX1OmJliZD52kVTUgi41vn+o9v+imYE7
         wg1OOUBg7Qhjb52leJgohGLeHcJLW8zzyWh/bRFHTPeKhd1WccdzhR6ij83Vwo+E6Fg/
         uTkZupl1snwlCK/X1pebFUkdaT00BuNUoC8F0oZP6UjobQZ9bV2KjfIck1APFG3krrbQ
         +vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=z1x64FzaMphQdQHi2P+W5m03uJBZN9PD7YSKPgINeZQ=;
        fh=jrW8BN5pfxPLUtU6dUYpxwZIpkO+FxpkWTJThX8aZ3E=;
        b=D0vtfcfh3/SAeJjAdVQXMCHyvTrRFRatEd3m/3YRMtQ4xBBy5gwM9CgkZeV3zvh59m
         oaN7OZUT1IN4pcqjFEmxyLw1E8HCmUzl3I3zS8mYdvUQcmPEfNOEl7tzhCdQY/HAxNDN
         YOvuuY6salDoFm6OUmdia/I99giei6ysTMAP4oSXgJHjbgQQ7EHQRYhnqnPRE0iNA7ny
         2kylxmnom0Kizv7uy0kToTXD+POiBq43NN/cmtf9hO94hBHf8djcU4wVRRPqqGuDMkHw
         qThdlGOwWEzwPX2jntrIohzwFNT3x/+pziboQAExYxRSsLqk+fIQGzfqjconnpEXov3b
         uhNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891701; x=1780496501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z1x64FzaMphQdQHi2P+W5m03uJBZN9PD7YSKPgINeZQ=;
        b=sX/x28YAbTRDHaJkITfi5ZAAbo3ueOM2SSeXqxqOanbxkP9izG7DuYWcLuy54Vtfys
         5pJf/bsgmOoD/VWSw/lxd+k+oJyMvAZhrhBQ9NQJER4vzIJLC80aHP59TEyoROY9BKPm
         Lo/jAGLSTVXpmhMq6vz+szBHqwHeMPG6hlM//uE6cgC/CCR6XwrXkSxPuO6PnyERYYN/
         tTKiE6jcBlBVCkRaths/ZhCzHzoGEcis9EwWHVscjwmrlBWH79R0YI9S8O6179PeG0M3
         faGnlGGyNfYciqUBMs1eKuMQ15jE7yUIdm9lmBmJck7ntF23M0H4SnmRHrhUvyXDZj0n
         kdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891701; x=1780496501;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1x64FzaMphQdQHi2P+W5m03uJBZN9PD7YSKPgINeZQ=;
        b=GqQ5QbrFPRAA+Cr/vTNDFmWbdzOzT2bALSifN+VhD/0V5Crz3O91jqe7p6SmMIwJXj
         kF1QrUTUuKJBjhH0DR+sV5WS6hTJCQtorHQrVlvt3451vUyQ1BzIe+Vyjg92KF2as17D
         MAhH0lcIWy/ZEmaXCwYa2d/ENYMweeiJvl22WL+6pcrHEE30lSCXrUmO5ohZFWvMbPfI
         EUwWZJ3Qn97AREm2Gm9pXPQ9evvJqHzN/M7xrIYPk1fSNikyKJzgyGgeyXbvorDT1hdk
         tiH0u0hyAopnwqLlMbuAKM1y68MzQ6n8/z7cSZfXB+pwNeVYPjpIMgS8qVBL1A7epBSJ
         MCcg==
X-Gm-Message-State: AOJu0YzZ4EeCvv1gqg7dJfvcgWwM4LrfG7YDWXpJKbJ+Aag/IoXHB3GC
	G95rEyCAINKJrDph8XsKPdLGpzZHEuDkA/SnWvltj54N9uWAHh1Ns7OtoeNQyNMpuSBFfCW0G7z
	ZEZngUbn+zjHSqa50vWZHOCQ6n4i5lRqpJQ==
X-Gm-Gg: Acq92OGc+6r99vV62caLm/xMWXe61cW9PtHMnclmsgxfuWqSra1W9JxykWOnIthtEHI
	hRVKT5Fr4OqC7QhRFLrxMOK7irgjLjB76V7gTKj1PJLleE0sgr+Bp1Vw7EQbKFV66BQXunp3NrH
	oYq+R/SxU6rToCTFNF+QBZ+pV5xn8ZYfEihVMqxPer1I667UGNqGENx2N44iSllCIWJgQhFX3f2
	M5emftytXLo+RS2tZ4eueFXERom0o3q8kxFKM2zQ9R2Er3OssDBWhhjqjCCDovcmUQ4s0OinGUg
	ZpNT//sbuF6LPkGRdU26g3yqDA==
X-Received: by 2002:a05:622a:8588:b0:50d:97e8:939b with SMTP id
 d75a77b69052e-516d436b32dmr250735241cf.36.1779891700721; Wed, 27 May 2026
 07:21:40 -0700 (PDT)
Received: from 1074302158857 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 07:21:39 -0700
Received: from 1074302158857 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 07:21:39 -0700
From: Stefano Ursino <insalata.fresca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 07:21:39 -0700
X-Gm-Features: AVHnY4KmhPOnRJjRKuHtC28hDmEIN-Bbi2WpsUnhpJusgUUhF69092PL4xdV8dI
Message-ID: <CAAepT2Ta12CHDuvb0+2-=q3GJiYpo+Xo6_oGdamKbudsN8eAVw@mail.gmail.com>
Subject: pcs: qcom-ipq9574: XPCS USXGMII in-band AN never completes with
 AQR113C (ANINTR stays 0) on a non-RDP board
To: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: quic_leiwei@quicinc.com, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[quicinc.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292321-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[insalatafresca@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 358645E5CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm bringing up the 10G Aquantia (AQR113C) port on an IPQ9574 board (Wallys
DR9574, AP-AL02-C4) on mainline (kernel 6.12, OpenWrt qualcommbe target) using
the upstream qcom_ppe + pcs-qcom-ipq9574 + aquantia stack. The in-tree
ipq9574-rdp433 (AP-AL02-C7) uses the same stack and works. On my board the
netdev never gets carrier: the PCS get_state reads XPCS_USXG_AN_LINK_STS and it
never asserts.

DT port (mirrors rdp433): phy-mode="usxgmii"; managed="in-band-status";
phy-handle=<&aqr>; pcs-handle=<&pcs1_ch0>; the AQR phy node has
nvmem-cells=<&aqr_fw>.

I instrumented ipq_pcs_get_state_usxgmii() to dump the PCS/XPCS registers (via
the driver regmap). Stable across all polls, port admin-up, copper line linked
at 1G:

  XPCS_MII_AN_INTR_STS (0x1f8002) = 0x00000000   <- AN_LINK_STS never
set; NO bits at all
  PCS_MODE_CTRL        (0x46c)    = 0x00001021    <- PCS_MODE_SEL =
XPCS (0x10) [OK]
  PCS_CALIBRATION      (0x1e0)    = 0x00000ac1    <- CALIBRATION_DONE
(bit7) set [OK]
  PCS_PLL_RESET        (0x780)    = 0x000002ff
  XPCS_DIG_CTRL        (0x38000)  = 0x00002200    <- XPCS_USXG_EN
(bit9) set [OK]
  XPCS_MII_CTRL        (0x1f0000) = 0x00003140    <- XPCS_MII_AN_EN
(bit12) set [OK]
  XPCS_MII_AN_CTRL     (0x1f8001) = 0x00000100    <- XPCS_MII_AN_8BIT
(bit8) set [OK]

AQR113C side (read via mdio-tools), all healthy:
  PMA(MMD1).1 = 0x0006  -> copper line link UP (1000)
  VEND1(0x1E).0x031c = 0x0080 -> SERDES_MODE=XFI + RATE_ADAPT_USX (= USXGMII)
  PHYXS(MMD4).0xC441 bit3 SET -> USXGMII in-band AN enabled (firmware default)
  PHYXS(MMD4).1 = 0x0006 -> system-side link bit set
  VEND1(0x1E).0x0020 = 0x0504 -> FW v5.4 loaded (from 0:ETHPHYFW NOR via nvmem)

So: XPCS is in XPCS mode, calibrated, USXG_EN + MII_AN_EN + MII_AN_8BIT all set;
the AQR is in USXGMII with in-band AN enabled and its system-side link bit set;
copper is up. Yet XPCS_MII_AN_INTR_STS reads 0x00000000 -- the XPCS appears to
receive no in-band USXGMII signalling from the AQR at all (no AN_LINK_STS, no
status bits).

Things I've already verified / ruled out:
- All known pcs-qcom-ipq9574 fixes are present (the fsleep(20000) PLL settle
  after PCS_ANA_SW_RESET; the GCC_UNIPHY1/2_XPCS_RESET reset is in DT and
  requested by the driver; calibration completes).
- Not a phy-mode/firmware/AQR-provisioning issue (AQR 4.0xC441 bit3 already set;
  this is the USXGMII in-band-AN enable bit).
- Asserting XPCS_USXG_ADPT_RESET in ipq_pcs_config_usxgmii() (instead of only on
  .pcs_link_up) did not help.
- It is plain single-port USXGMII (not 10G-QXGMII / multi-port).

Questions:
1. With the XPCS configured as above and the AQR sending USXGMII in-band, what
   would leave XPCS_MII_AN_INTR_STS at 0 (no codewords received)? Is there a
   UNIPHY/SerDes RX lane bring-up, RX CDR/eq lock, or signal-detect step the
   public driver relies on the bootloader for that a non-RDP board's U-Boot may
   not perform?
2. Is there a UNIPHY/SerDes RX-lock or status register I should check (and how
   to read it -- it's not in pcs-qcom-ipq9574)?
3. Any board-specific UNIPHY config (lane/polarity, the AP-AL02-C4 vs C7
   difference) that the RDP433 bootloader/DTS sets up implicitly?

Happy to provide more register dumps / test patches. The board otherwise works
(copper line links in U-Boot; the AQR + XPCS both report local link).

Thanks,
Stefano

