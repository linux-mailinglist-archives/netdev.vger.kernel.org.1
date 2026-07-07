Return-Path: <netdev+bounces-305297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0yuGrafTGrinAEAu9opvQ
	(envelope-from <netdev+bounces-305297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C74097180E3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305297-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305297-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1740E3010BB8
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F33A9D8B;
	Tue,  7 Jul 2026 06:41:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F73A9615;
	Tue,  7 Jul 2026 06:41:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406483; cv=none; b=nJwhT4K57FJpHIzwATB91V/kh0K+A/xIVbS5yyZgz4qf4oLVwfo6N2ImCPuXQw5kzR+Q0y12GK2hrFe8s+mKFi4jGhoALKDcdG74dfm0tITh46xPQWK15PkUdC1vGjHsav4CeyZYCOMMf9Nx7QN4dkRynn2ycN/KSkcXvcVbfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406483; c=relaxed/simple;
	bh=rQi3+ECihJ0aHJVpmhEJgssG8t9I+u7Nf94GYKMaJWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gM26LjjDyyG1Ccz2GiVYW3WZm4HjKUnG5BAmhUBAGKtyuSMreSUHl/pUZ19uSRaySS70YzERMOCvqbTrae6wEtuxz03S6hXaXeK1wRHWocf6Q8zVXUjJpFHSGHJ2A4UTkjeGcNCqx8rGK8sAjWMjistSlUdNWsKfEpmch4IjSVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgB3DHFln0xqXQ0yAA--.28072S2;
	Tue, 07 Jul 2026 14:40:40 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v10 0/4] net: stmmac: eic7700: add eth1 variant support and update delay bindings
Date: Tue,  7 Jul 2026 14:40:33 +0800
Message-ID: <20260707064033.1265-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3DHFln0xqXQ0yAA--.28072S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF4fJr1DKw13Xr47CFW3ZFb_yoW8Gr43Go
	WSqrWrXr40vr13CFn2krnrGa9xW3s29r13JayUWr1qyryvqa17t34ruayxXFy3tFWFkFW5
	Xa4xXw1ftanxJayfn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRK1vVDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:devicetree@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:maxime.chevallier@bootlin.com,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:pritesh.patel@einfochips.com,m:weishangjuan@eswincomputing.com,m:horms@kernel.org,m:lizhi2@eswincomputing.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305297-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lizhi2@eswincomputing.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:from_mime,eswincomputing.com:email,eswincomputing.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C74097180E3

From: Zhi Li <lizhi2@eswincomputing.com>

This series updates Ethernet support for the ESWIN EIC7700 SoC,
including support for the eth1 MAC variant.

The series includes DT binding updates and stmmac glue driver updates
for the EIC7700 Ethernet controller.

The changes include:
  - Update the tx-internal-delay-ps binding property from a fixed enum
    list to a range-based definition, and make it optional with the
    corresponding driver update.

  - Add support for the EIC7700 eth1 MAC variant, which has
    silicon-specific RX sampling behavior and TX timing characteristics.
    A dedicated compatible string is introduced for this hardware variant,
    and the driver applies the required RX clock inversion handling and
    timing adjustments.

Due to silicon characteristics, the eth1 interface has a fixed TX
internal delay of approximately 2 ns and an RX sampling skew of 4-5 ns
that cannot be compensated solely by standard RGMII delay settings.
The binding models the effective TX delay range of this variant, while
the driver handles the required hardware-specific timing configuration.

Only the DT bindings and driver patches are included in this series. The
DTS changes are intentionally omitted for the following reasons:
  - The HSP bus infrastructure is being introduced by Pinkesh Vaghela's
    DT series [0], currently under review.
  - The HSPCRG clock/reset series [1] provides additional infrastructure
    for the HSP subsystem.

Once these dependencies are merged, a follow-up DT series will enable
Ethernet, USB, eMMC, and SD across the HSP bus.

Reference:
  [0] https://lore.kernel.org/lkml/20260706081055.1126275-1-pinkesh.vaghela@einfochips.com/
  [1] https://lore.kernel.org/all/20260605060730.1605-1-dongxuyang@eswincomputing.com/

v9 -> v10:
  - Drop the DTS patches (patches 5 and 6 in v9) from this series.
  - Update the cover letter to include a description of the series.
  - Add Conor Dooley's Acked-by tag.

  - Link to v9:
    https://lore.kernel.org/lkml/20260630063123.1118-1-lizhi2@eswincomputing.com/

v8 -> v9:
  - patch2:
      - Update DT binding schema for tx-internal-delay-ps:
        - Replace the previous oneOf schema with a base range plus
          allOf/if-then conditional constraints.
        - Define a common range of 0-4540 ps and apply compatible-specific
          constraints using conditional schema rules:
            - eswin,eic7700-qos-eth:
              maximum 2540 ps
            - eswin,eic7700-qos-eth-clk-inversion:
              minimum 2000 ps
  - patch6:
      - Refine DTS implementation to address Sashiko review comments:
        - Address DTC and dtbs_check warnings.
        - Improve node naming and HSP bus organization.
  - patch5 and patch6:
      - Update commit messages for the DTS patches:
        - Clarify that the DTS patches are included only to provide an
          overview of the complete Ethernet integration for review.
        - The upstream DTS enablement will be submitted as a separate series
          after the DT bindings and driver changes have been applied.

  - Link to v8:
    https://lore.kernel.org/lkml/20260610012727.848-1-lizhi2@eswincomputing.com/

v7 -> v8:
  - eth0-related fixes were moved into separate series [1], [2]:
    - All eth0-related fixes have been removed from this series to avoid mixing
      MAC variants and RX timing logic in a single review context.
    - Reference:
      [1]https://lore.kernel.org/lkml/20260602014528.2076-1-lizhi2@eswincomputing.com/
      [2]https://lore.kernel.org/lkml/20260518021919.404-1-lizhi2@eswincomputing.com/

  - Update cover letter and overall series scope description:
    - Replace previous wording "EIC7700 eth1 RX sampling timing fix"
      with a more accurate description:
        - Add eth1 MAC variant support.
        - Update RGMII delay binding model.
    - This reflects the structural nature of the series rather than a pure
      bug fix.

  -  Split DT bindings changes into two patches:
    - patch1:
        - Relax RGMII internal delay constraints.
        - Change rx/tx internal delay from enum-based model to range-based
          model.
        - Mark delay properties as optional.
    - patch2:
        - Introduce EIC7700 eth1 MAC variant compatible string
          "eswin,eic7700-qos-eth-clk-inversion".
        - Model silicon-specific RX clock inversion requirement via SoC
          variant instead of board-level properties.

    - Due to this restructuring:
        - Patch structure and commit messages have changed significantly
          compared to v7.
        - The previously received Acked-by from Conor Dooley is not
          carried forward because the binding patches were substantially
          reworked and split.

  - Split driver changes into two patches. No functional changes to eth1
    compared to v7:
    - patch 3:
        - Make rx-internal-delay-ps and tx-internal-delay-ps optional.
        - Remove mandatory DT property requirement in probe path.
        - Allow zero-delay default when properties are absent.
    - patch 4:
        - Add support for eth1 MAC variant using compatible-specific
          match data.
        - Introduce RX clock inversion handling for eth1 at runtime.
        - Apply speed-dependent configuration via fix_mac_speed()
          callback.

  - Note:
    - These patches (5/6 and 6/6) are included only to facilitate review
      of the overall Ethernet integration across bindings, driver, and
      device tree.
      A cleaned-up, upstream-ready DTS series will be submitted separately
      once all dependencies and final hardware integration are completed.

  - Link to v7:
    https://lore.kernel.org/lkml/20260427072353.1114-1-lizhi2@eswincomputing.com/

v6 -> v7:
  - Address checkpatch.pl --strict warnings for DTS changes:
    - Split DT binding documentation and DTS board description into separate patches
    - Fix DTS style issues reported by checkpatch:
      - Reduce line length where applicable
      - Add required description for rgmii-rxid

  - DTS changes in this series are split into:
    - Patch 3/4: syscon binding update (documentation / reference only)
    - Patch 4/4: board DTS changes (architecture overview only)

    These patches (3/4 and 4/4) are provided to facilitate review of the overall
    Ethernet integration across binding, driver, and device tree, and are not
    intended as final upstream submission in their current form.

    A cleaned-up, upstream-ready DTS series will be submitted separately once
    all dependencies and final hardware integration are completed.

  - Note:
    - Clock-related bindings referenced in earlier revisions are now already merged
      into net-next, so dtbs_check warnings related to clock are no longer present
      and are not relevant to this revision.

  - No functional changes in the stmmac driver or binding semantics in this revision.

  - Link to v6:
    https://lore.kernel.org/lkml/20260423085501.760-1-lizhi2@eswincomputing.com/

v5 -> v6:
  - Update DTS/DTSI descriptions to fix invalid phandle references reported by DTC:
    - Add missing GMAC provider nodes required for proper hardware description:
      - HSP power domain: GMAC nodes moved under this domain to reflect
        hardware power hierarchy.
      - Clock nodes: added to provide clk phandles referenced by GMAC.
      - Reset nodes: added to provide reset phandles referenced by GMAC.
      - Pinctrl nodes: defines pinctrl settings for GMAC signals
        (pinctrl_gpio106, pinctrl_gpio111).
    - Move GMAC nodes under the correct HSP power domain.
    - Ensure DTS builds without dtc errors and all phandle references
      (clk/reset/pinctrl/power-domain) are valid.
    - This update does not change runtime behavior; it only improves DTS
      consistency and resolves issues reported by dtc.

  - Note:
    - The patch 3/3 for DTS changes in this series provide an overview of the GMAC
      integration and its dependencies, as discussed previously:
      https://lore.kernel.org/lkml/64bf6b40-b947-4ffa-8d48-4d6341931327@lunn.ch/

    - It is **not intended for upstream inclusion** in its current form,
      and is provided solely for architecture overview and integration
      context.

    - A fully cleaned and upstream-ready DTS series will be submitted
      separately once all related components (pinctrl, clock, power-domain,
      etc.) are finalized.

  - dtbs_check has been run on top of net-next for reference purposes.
    Remaining warnings are expected due to missing EIC7700 clock bindings[1]
    in net-next and do not reflect issues in the DTS design itself.

  - One remaining warning:
    - eswin,eic7700-clock

  - The clock binding has already been applied to upstream and is present
    in mainline, but not yet available in net-next.

  - The syscon binding is extended in this series to include the
    eswin,eic7700-syscfg compatible.

  - Any further refinement of the syscfg binding will be handled in
    separate patches if needed.

  - Dependencies:
    - [1]EIC7700 clock binding:
      https://lore.kernel.org/lkml/20260303080637.2100-1-dongxuyang@eswincomputing.com/
      (already applied to upstream)

  - Link to v5:
    https://lore.kernel.org/lkml/20260324073017.376-1-lizhi2@eswincomputing.com/

v4 -> v5:
  - eswin,eic7700-eth.yaml:
    - Add Acked-by from Conor Dooley
    - No functional changes

  - Update dwmac-eic7700.c:
    - Disable clocks on the error path to fix a clock leak in
      eic7700_dwmac_init() when regmap_set_bits() fails
      (reported by Simon Horman <horms@kernel.org>)

  - Link to v4:
    https://lore.kernel.org/lkml/20260313075234.1567-1-lizhi2@eswincomputing.com/

v3 -> v4:
  - Update eswin,eic7700-eth.yaml:
    - Improve commit message in dt-bindings patch to clarify the
      hardware difference of the eth1 MAC and why a new compatible
      string is required.
    - Move the newly added eswin,hsp-sp-csr item to the end of the list
      to avoid inserting entries in the middle of the binding schema.
    - Simplify the compatible schema by replacing the previous oneOf
      construct with an enum.

  - Update dwmac-eic7700.c:
    - Fix build issues.
    - Adjust code to match the updated binding definition.

  - Update DTS/DTSI descriptions:
    - Move SoC-level descriptions to the .dtsi file.
    - Keep board-specific configuration in the .dts file.

  - Link to v3:
    https://lore.kernel.org/lkml/20260303061525.846-1-lizhi2@eswincomputing.com/

v2 -> v3:
  - Update eswin,eic7700-eth.yaml:
    - Extend rx-internal-delay-ps and tx-internal-delay-ps range
      from 0-2400 to 0-2540 to match the full 7-bit hardware delay
      field (127 * 20 ps).
    - Add "multipleOf: 20" constraint to reflect the 20 ps hardware
      step size.
    - Make rx-internal-delay-ps and tx-internal-delay-ps optional.
      A well-designed board should not require internal delay tuning.
    - Remove rx-internal-delay-ps and tx-internal-delay-ps from the
      example to avoid encouraging blind copy into board DTs.

  - Update dwmac-eic7700.c:
    - Treat rx-internal-delay-ps and tx-internal-delay-ps as optional
      DT properties.
    - Apply delay configuration only when properties are present.
    - Keep TX/RX delay registers cleared by default to ensure a
      deterministic state when no delay is specified.

  - Describe Ethernet configuration for the HiFive Premier P550 board:
    - Add GMAC controller nodes for the HiFive Premier P550 board
      to describe the on-board Ethernet configuration.

      The Ethernet controller depends on clock, reset, pinctrl
      and HSP subsystem providers which are currently under
      upstream review. These dependent nodes will be submitted
      separately once the corresponding drivers are merged.

      Due to these missing dependencies, dt-binding-check may
      report warnings or failures for this series.

  - No functional changes to RX clock inversion logic.

  - Link to v2:
    https://lore.kernel.org/lkml/20260209094628.886-1-lizhi2@eswincomputing.com/

  - This series is based on the EIC7700 clock support series:
    https://lore.kernel.org/all/20260210095008.726-1-dongxuyang@eswincomputing.com/
    The clock series is currently under review.

v1 -> v2:
  - Update eswin,eic7700-eth.yaml:
    - Drop the vendor-specific properties eswin,rx-clk-invert and
      eswin,tx-clk-invert.
    - Introduce a distinct compatible string
      "eswin,eic7700-qos-eth-clk-inversion" to describe MAC instances that
      require internal RGMII clock inversion.
      This models the SoC-specific hardware difference directly via the
      compatible string and avoids per-board configuration properties.
    - Change rx-internal-delay-ps and tx-internal-delay-ps from enum to
      minimum/maximum to reflect the actual delay range (0-2400 ps)
    - Add reference to High-Speed Subsystem documentation in eswin,hsp-sp-csr
      description. The HSP CSR block is described in Chapter 10
      ("High-Speed Interface") of the EIC7700X SoC Technical Reference Manual,
      Part 4 (EIC7700X_SoC_Technical_Reference_Manual_Part4.pdf):
      https://github.com/eswincomputing/EIC7700X-SoC-Technical-Reference-Manual/releases

  - Update dwmac-eic7700.c:
    - Remove handling of eswin,rx-clk-invert and eswin,tx-clk-invert
      properties.
    - Select RX clock inversion based on the new
      "eswin,eic7700-qos-eth-clk-inversion" compatible string, using
      match data to apply the required configuration for affected MAC
      instances (eth1).

  - Link to v1:
    https://lore.kernel.org/lkml/20260109080601.1262-1-lizhi2@eswincomputing.com/

Zhi Li (4):
  dt-bindings: ethernet: eswin: relax internal delay model to
    range-based constraints
  dt-bindings: ethernet: eswin: add EIC7700 eth1 RX clock inversion
    variant
  net: stmmac: eic7700: make RGMII delay properties optional
  net: stmmac: eic7700: add support for eth1 clock inversion variant

 .../bindings/net/eswin,eic7700-eth.yaml       |  74 +++++++++--
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 117 +++++++++++++++---
 2 files changed, 164 insertions(+), 27 deletions(-)

-- 
2.25.1


