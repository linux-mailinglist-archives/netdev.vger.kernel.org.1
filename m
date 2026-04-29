Return-Path: <netdev+bounces-282382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wExrADEB8mmElwEAu9opvQ
	(envelope-from <netdev+bounces-282382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05649466F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAD6F3061738
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4C13FD134;
	Wed, 29 Apr 2026 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b="WbUFTpZo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB893E5EC7
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467208; cv=pass; b=Dkffz3e2VS48v9WKdeOv8ONQulRwAr8zcXnqXmressR2lO5FsLey+bcgGGufhyDJYkPmAXq5gOnn47FI7IeUjtXJ+O4N1ZkkpIfybPX3LxVboHLPtynfI2KnDfy4Nejav/6FzsOFETYgC/NILWGLKLG0BOt5JQvgVOMaLxSYQvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467208; c=relaxed/simple;
	bh=06RKrpgsQ3tyvS0Nz8ZDPd2l1j0XicmNOtk7LKv+OpI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fcAQ2B9VmCa1BQHQqNqj8AevMgtNlUz06dosKp2sweXx3WBSiRm8N+osup9+zA2NRvRh9Kvzi/JI1lDY+P5H4FSQmkREfiLs7AQLtUS1M1hEY4ZMdVYO4IIpQXI8FXlhYkug7w2VF2Bh9Fduk2VquDPTm/3R01dPBk5J3LfoJrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com; spf=none smtp.mailfrom=friendlyarm.com; dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b=WbUFTpZo; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=friendlyarm.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so18109184a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777467205; cv=none;
        d=google.com; s=arc-20240605;
        b=HBrd7ioSURRu4gJPMYtu5AIM5FgkHeSFv+Eeyia6wEJvCwjQmHlVlDNux4nJwzMJIS
         2XXD5PsC6AuoL3xKDjrA2P8lPdUrM5I2aNubU8SNohymcFx+Tilrdzskrz0ldYUbGCTr
         mLk290vsI0n9yazAPRFWYLn8ZtFFDThbtu4AniBfLwGcGMBI3A8BQM9QpbeMhVPDjYGa
         Ok/SvSgEIafipcFo13hTlrCrWgzCTwuP+FxdBuWeFAKyKCnCQylM7gOFHgmDz+GwJMn/
         dpdgMhyBaF6kk4BOAFrOW/hk3WmR4uCt9hq0Ym3eiNe+nwv2QAo1mdzBs+FrTWa4X99e
         CgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oT/Pyour7xLSBQAuqnvOXlLVXzS57qaNd61owTC44EE=;
        fh=ECmIafiim7NNQS5lyrsOHitEAm4//QnNxNB1RMjBoTo=;
        b=Fr70t3+aV4HspkkVkWUsRGEkSQKUPMcXDiHhind5jXc3zpw/BvVjeqX8MIxg/Vni2n
         yZ/Bi9StvrCRzEazk4iWFXJJDkNRpkXBvEcbMu03b612nWAptJVBuXto746hAndz0Ph1
         J59SgOxflb3KNXS9AqhQHzaeW7sDySw3ItbjpS5c3t+vzA6TRNHCZJN+P90c5tBRyVNN
         nf9N2Tk4MPSUZPIoGK9Ogjj4kaT3J14S+LtN5upRUWwiK5+Bu0KqrER8ttYkJWRf7uST
         UUDk5n9ShhiOo0sFAavRIuDck4pdgBtlI0N83/2CrdrObHln30yPCqUtympUyV1TsuIk
         SiIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20251104.gappssmtp.com; s=20251104; t=1777467205; x=1778072005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oT/Pyour7xLSBQAuqnvOXlLVXzS57qaNd61owTC44EE=;
        b=WbUFTpZo2okZxrgkdlZ5If5V03hWqMtfscFA10bcYC7xxtyvboffbbj8aykwQA69HJ
         p+JLJDRac7p6K4oG+RLxs1imyHnV98amXQgO6ZmHb2JErdWF8mKOa3bGV6tcZrmp5IzY
         jvy4FyXKB4S9KAQqypRYuyIfa6p/NsJZsons/I0ZqGtP8b9zmmF6tFXJIuCKzxF4eNQV
         iYcPZD5aKUlCpYMNHSVocjuPJ3KWz5M8ibb2wFMS3EfKpAsl57hgYqVwpDWNKwbmin63
         V8tZa3urdupyQcQJyo6VVYCkzsHVv3HiLgMe5I4e1SVvMGlZ3dVOSi8rKrnCgViUCLMh
         bitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467205; x=1778072005;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oT/Pyour7xLSBQAuqnvOXlLVXzS57qaNd61owTC44EE=;
        b=eSwJLCp449PJtXmbaE4JsO/TTJWeMso7ye1ltaEVS+9noG/cuPe89dIRSQMj2Rz06F
         rhCTiFDGSu043687zAtsQNgSQzmreJvnku/qMBWnUJmJcaTf2rEjsENXRWPwKL3n98va
         CCAeJsb3AYMkO6JnE6Wf7umbON3Hd14KCUzS5BWRj/QemGwhfn2EqhuJ8z/H2t5OaqvO
         uxVl0Y2Y5pq5TPHATaago7EDoIKAqnZm4hGyScPUlCfbfrYz8R+al1AWloQvnYX/E+el
         uq42aoYpg5F3LTOPxbwhPc3qpLoqQus1sUF/FzmtgK4KdqhfnS6X1EtZfaCBq5m673Cl
         0byQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Cp3VFIQ/EI79+fIbgamThsB5/GNZhGtT7MoClNsYlHVHH1SIAiIY2KksXocxvYgXpUqtfTH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/3WrhPYmoxbsYUnM2HK3ip4niTVhm/HZGBZDQ8fMepslDJ4oS
	uz/rrkf1pIOC+pizpbR+TRpQFnMPouIEU3qrEWuYWrJNjfiYhRMV81LU7C8ICvA4CgTg6hxofY0
	jlErNI61YfKHx4ojgTvXZkhHUB0o0cB/Ftgdh9+nbGA==
X-Gm-Gg: AeBDiesEp5qqcEhlDdQVx4km71gfvt0ExGKELst1KWWIfjE5MkkMVUgibv4Wl+bTx+k
	V/75FntZGjJse1AMlGIx+Dpp6kZ6AE2KMHJHpzRJ0bH1RsnpCT/rH4P7B5mNh/GkRlBDK2LkUqT
	T8n8ek3lQlAvmq8eP6wawfB1H2+50Yn4Aqqy92e2NVtLEizK3I9OmHfQu9d7mBwyuA12eV9UFll
	aVGSRXJDiG2ucawSUgE+eTS5N3C1s4XmNE1tj+KyRcuXryHGI97IaGaK+l/6WGIQWys6OVcTZHL
	wrGRweOv/e0mAvrNt0tc4O+UcSJ7C56E65toQUNrs76dGMfSyaU=
X-Received: by 2002:a05:6402:13cb:b0:670:b72b:4044 with SMTP id
 4fb4d7f45d1cf-679bb08bb19mr4513652a12.15.1777467205191; Wed, 29 Apr 2026
 05:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jensen Huang <jensenhuang@friendlyarm.com>
Date: Wed, 29 Apr 2026 20:53:13 +0800
X-Gm-Features: AVHnY4IlVroWBWccVPHiX-RgaaOUhLs_YEcqSmZCBe4GoTeuJY95EL9MbMBryWI
Message-ID: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
Subject: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since v6.18
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7A05649466F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[friendlyarm-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[friendlyarm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[armlinux.org.uk,lunn.ch,gmail.com];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[friendlyarm-com.20251104.gappssmtp.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[friendlyarm-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensenhuang@friendlyarm.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282382-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
When a network cable is connected during boot, the DMA reset
occasionally fails with the error message: "Failed to reset the dma".

This appears to be a timing issue related to the EEE RX clock-stop
logic. Based on my investigation with the RTL8211E PHY, I monitored
the PHY register PS1R (MMD device 3, address 0x01) and observed a
value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
clock may have already stopped.

While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
ensures the clock is running before the DMA reset, my tests suggest
that the phylink_rx_clk_stop_block() call might not provide a
sufficiently stable RX clock in time for the immediate DMA reset that
follows.

Since stmmac already sets mac_requires_rxc = true, I modified
phylink_bringup_phy() to honor this flag. This avoids toggling the
PHY's clk_stop_enable during the initialization sequence, ensuring the
RX clock remains active and stable throughout.
With the change below, I achieved 200/200 successful reboots with the
cable connected (previously ~50% failure rate).

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
*pl, struct phy_device *phy,
     /* Allow the MAC to stop its clock if the PHY has the capability */
     pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;

-    if (pl->mac_supports_eee_ops) {
+    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
         /* Explicitly configure whether the PHY is allowed to stop it's
          * receive clock.
          */

Any feedback/testing on this would be appreciated.

Best regards,
Jensen Huang

