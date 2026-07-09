Return-Path: <netdev+bounces-306233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mMXqIASxT2pQmwIAu9opvQ
	(envelope-from <netdev+bounces-306233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:32:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F35A732468
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 16:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=mail header.b=AE5djD+B;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306233-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306233-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E0CCB30CDDF7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7110381AEA;
	Thu,  9 Jul 2026 13:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19153101A7;
	Thu,  9 Jul 2026 13:42:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604579; cv=none; b=Bc7Q4igd4PK2eM4JElTpI7e+SZ970xH7VBPFDFYp9xORDekWQO5XpwErLQL4//wAFfmfg9VjsKXw61W3vakXoTF8MHUNWMQ/X1hmvtyIa1S0ovDcIGTChOpGVJ+6dIWFPij5aoSFKjEHIXqGNjzUCa+HzNyb+qBMwcRd0nDtBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604579; c=relaxed/simple;
	bh=MZpSgeA/3y51G0ijWq5mgY3FPQJZh/AgDpSAdHJpOGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jgRIZtova+6Hq18kXF3t44SzDbqPMq0FvvnOC5s80efcwXZew+DxoCkD4qMLFVHJ4hYudoB48DBrZGWBdgr2PiCUMgObkGgrTRwK/UnOiVG+hM281JYujeOk3kDQFnOatBTJGgLRRUvq6Qaj1FoaialUcpyvbEOKzSqmv7KDshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AE5djD+B; arc=none smtp.client-ip=148.251.105.195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604576;
	bh=MZpSgeA/3y51G0ijWq5mgY3FPQJZh/AgDpSAdHJpOGI=;
	h=From:Subject:Date:To:Cc:From;
	b=AE5djD+BNEIFk2fN0gyNCHXzE2Se6J96D5UTtxxbHKfFCRYf204/vTcH2Yn6ysHqB
	 uOEiIZZcBUUIWlARsJHFP0pg5IeuoEp2uV/PIP0oJdKMhQBQRYM26RJiNUD/k9f51b
	 bDzMVhKZ5xLHnDoFNeSgppJL0a84Xmvm5h2EmmXILLPn1iBlJF1B3+dt3iErBpSknr
	 ujh5HdhrqlmQZnzjRHC088ibUG81Jnp1s84UwjNwO77neQqNT9xYKCvZEJsKuA7xr2
	 DKlnE8t+OeukyB0plybiWEiDVLTdZUDsv7wlWoIxvhRqaAb1VXYiVaR5PoMBRx+Nbi
	 3BybLLgcrDwXg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 29F6917E05E8;
	Thu, 09 Jul 2026 15:42:55 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH v2 00/18] MT8189: Add support for system and base clock
 controllers
Date: Thu, 09 Jul 2026 15:42:40 +0200
Message-Id: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0Jm7Zi2IlRW3sOwKHXQRqDaVgIh3
 N1aXLt8M3n//wU8OUMeqmwBR6Pxxg4RxC4DfVfDjdBcI4NgomDFgWEfJJcn1J3VD49+9oF6bJQ
 nLFnJc8rbVigF0X86as2Usi/1xo5e71gRtiMkTdu+N6HKBpoCppqSSfgKd+ODdXPaNvJk/P78z
 4yRI0PRsFy2ROrI1FnbrlONdWofu6Be1/UDANO47PcAAAA=
X-Change-ID: 20260630-mt8189-clocks-system-base-70714e4ff2aa
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 Irving-CH Lin <irving-ch.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=7229;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=MZpSgeA/3y51G0ijWq5mgY3FPQJZh/AgDpSAdHJpOGI=;
 b=+CQQGWq7HsjC1kYHYwSLmlDyeNo4BSaZi14VzEYcGj66cvcvhq32lQDgEZBVDyp/YyhZOf9We
 lidhZyNHNmAChZLLVQdb8Mu7sgSygc2Qm+J4wwddYL+HGa6D6pME25R
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306233-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,redhat.com,gmail.com,collabora.com,mediatek.com,pengutronix.de];
	FORGED_SENDER(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:chun-jie.chen@mediatek.com,m:p.zabel@pengutronix.de,m:edward-jw.yang@mediatek.com,m:richardcochran@gmail.com,m:kernel@collabora.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:louisalexis.eyraud@collabora.com,m:irving-ch.lin@mediatek.com,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F35A732468

This series is a continuation by AngeloGioacchino Del Regno and I of a
previous series ([1]), that adds the clock controller support for
the Mediatek MT8189 SoC and its variants (MT8371, MT8391).  

The first major changes is the split of the series in two:
- one for all basic clock controllers including system ones (this
series)
- one for the multimedia and graphics related clock controllers (to be
send in the future)

We chose to separate the multimedia clock drivers from the base system
ones, as there is currently an unsolvable inter-dependency between the
power domains and multimedia clocks; the power domains need a
dual-stage bring-up, where only a part of the multimedia clocks are
accessible in the first power domain powerup stage, and the rest when
the second stage (SRAM enablement) is done.
The current workarounds for this issue, such as removing the is_enabled
operation from the impacted clock controllers clk_ops table or
let the multimedia power domain always on, were quickly discarded
for upstream.

The second major change is the dt-bindings patch that got heavily
reworked, not only because of the split choice. We took the opportunity
to regroup in the MT8186 clock and system clock dt-bindings the
description of several other Mediatek SoC (MT8188, MT8192 and MT8195)
and add in them the MT8189 new ones.
The rationale is to ease maintainability and have common files for
several currently supported SoC or new future ones, that have the same
kind of clock controller design.

Finally the pending remarks from peer reviews on the v6 revision of [1]
were also taken into account and new fixes and cleanups were also
added.

A more detailed changelog between [1] and this series:
- Removed multimedia and graphics related clock controllers code and
  definitions from series
- Added new dt-bindings patches to factorise existing MT8188, MT8192
  and MT8195 in MT8186 clock dt-bindings
- Heavily modified the MT8189 dt-bindings to add new compatibles 
  in MT8186 clock dt-bindings
- Created a new dt-bindings include for the MT8189 reset controller
  definitions (include/dt-bindings/reset/mediatek,mt8189-resets.h)
- Removed unnecessary `syscon` compatible fallback from MT8189 base
  clock controllers
- Added missing 'mediatek,mt8189-fhctl' compatible declaration in
  dt-bindings
- Modified Kconfig to COMMON_CLK_MT8189 be tristate (and not bool) to 
  allow all MT8189 clock controller drivers to be built as modules (it
  was partial) 
- Fix pll unregisters in clk_mt8189_apmixed_probe error case
- Reparent several clocks to correct 26M references in clk-mt8189-bus.c,
  clk-mt8189-topckgen.c and clk-mt8189-vlpckgen.c
- Removed CLK_SET_RATE_NO_REPARENT flag from mfg_sel_mfgpll
- Rename TOPCKGEN_fmipi_csi_up26m clock to fmipi_csi_up26m to remove caps usage
- Implemented reset controllers in clk-mt8189-ufs.c
- Updated all file headers to update copyrights and add all authors
- Added all co-developed-by trailers

The series is based on linux-next tree (tag: next-20260630) and has
been tested on Mediatek Genio 520-EVK (MT8371) and 720-EVK (MT8391) boards
with board hardware enablement patch series ([3]).

[1]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-1-irving-ch.lin@mediatek.com/
[2]: https://lore.kernel.org/linux-mediatek/20260309120512.3624804-2-irving-ch.lin@mediatek.com/
[3]: https://lore.kernel.org/linux-mediatek/20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com/

---
Changes in v2:
- Rebased on next-20260708 tag
- Added patch 1,2 and 3 to make the #clock-cells a required property in
  MT8186, MT8192 and MT8195 clock controller dt-bindings
- Patch 5:
  - Removed conditional blocks to check clock-cells property presence
    for MT8188 clock controller compatible
  - Reworded commit message to remove the note (no more applicable)
  - Fixed incorrect property value in else block for #reset-cells
    property check.
_ Removed from patch 9 conditional blocks to check clock-cells property
  presence for MT8189 clock controller compatible
- Fixed missing MODULE_DEVICE_TABLE in patches 10, 11 and 12.
- Added devicetree series link in cover letter
- Link to v1: https://lore.kernel.org/r/20260701-mt8189-clocks-system-base-v1-0-2b048feea50a@collabora.com

---
Louis-Alexis Eyraud (18):
      dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8186
      dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8192
      dt-bindings: clock: mediatek: Make '#clock-cells' required for MT8195
      dt-bindings: clock: mediatek: reorder MT8186 compatibles
      dt-bindings: clock: mediatek: regroup MT8188 dt-bindings into MT8186
      dt-bindings: clock: mediatek: regroup MT8192 dt-bindings into MT8186
      dt-bindings: clock: mediatek: regroup MT8195 dt-bindings into MT8186
      dt-bindings: clock: mediatek: Add MT8189 clocks
      clk: mediatek: Add MT8189 apmixedsys clock support
      clk: mediatek: Add MT8189 topckgen clock support
      clk: mediatek: Add MT8189 vlpckgen clock support
      clk: mediatek: Add MT8189 vlpcfg clock support
      clk: mediatek: Add MT8189 bus clock support
      clk: mediatek: Add MT8189 dbgao clock support
      clk: mediatek: Add MT8189 dvfsrc clock support
      clk: mediatek: Add MT8189 i2c clock support
      clk: mediatek: Add MT8189 scp clock support
      clk: mediatek: Add MT8189 ufs clock support

 .../bindings/clock/mediatek,mt8186-clock.yaml      |  128 ++-
 .../bindings/clock/mediatek,mt8186-fhctl.yaml      |    1 +
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml  |   24 +-
 .../bindings/clock/mediatek,mt8188-clock.yaml      |   93 --
 .../bindings/clock/mediatek,mt8188-sys-clock.yaml  |   58 --
 .../bindings/clock/mediatek,mt8192-clock.yaml      |  191 ----
 .../bindings/clock/mediatek,mt8192-sys-clock.yaml  |   68 --
 .../bindings/clock/mediatek,mt8195-clock.yaml      |  238 -----
 .../bindings/clock/mediatek,mt8195-sys-clock.yaml  |   76 --
 drivers/clk/mediatek/Kconfig                       |   79 ++
 drivers/clk/mediatek/Makefile                      |    8 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c       |  196 ++++
 drivers/clk/mediatek/clk-mt8189-bus.c              |  200 ++++
 drivers/clk/mediatek/clk-mt8189-dbgao.c            |   98 ++
 drivers/clk/mediatek/clk-mt8189-dvfsrc.c           |   58 ++
 drivers/clk/mediatek/clk-mt8189-iic.c              |  122 +++
 drivers/clk/mediatek/clk-mt8189-scp.c              |   77 ++
 drivers/clk/mediatek/clk-mt8189-topckgen.c         | 1025 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8189-ufs.c              |  133 +++
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c           |  116 +++
 drivers/clk/mediatek/clk-mt8189-vlpckgen.c         |  285 ++++++
 include/dt-bindings/clock/mediatek,mt8189-clk.h    |  433 +++++++++
 include/dt-bindings/reset/mediatek,mt8189-resets.h |   17 +
 23 files changed, 2988 insertions(+), 736 deletions(-)
---
base-commit: 451b00e20bcd5526c6def9ee76f9bdb322ae9b46
change-id: 20260630-mt8189-clocks-system-base-70714e4ff2aa

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>


