Return-Path: <netdev+bounces-278808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBr8Jo6i32miXAAAu9opvQ
	(envelope-from <netdev+bounces-278808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:37:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DAF4055F2
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7EA5301F998
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937682EDD62;
	Wed, 15 Apr 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EXW5bVsF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48651279358
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263510; cv=none; b=O5I95oYncI4dyehlQvvDOGzK/O+sN35VwNHQcGDFNF1er2KTCJVNDn26vPR0YbTBF9Ok5GZj3fN/H+/tl3GfxE+0Usgu5q6eaYpgg4h3FWgpwOV3C9Y+/qN1Tt92x150r4mjil84ekjAw90OaVZvd9XpLpi8DH51HqrbHliGQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263510; c=relaxed/simple;
	bh=wQDKXZGfN1iQ3TdXjKRE27aW3Gf0HLMrSIqTCik24Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9x4/8mLimxLjnepj1zPIQ0rkLKIEQtE0tblo+KsWUDfZBjmi/2P5TuZ/qTnVg5eYwaZcY7gHjE75VPsXMt3k4YFdPqNhB722uyBztHoKcaXvbIq89b3kglzc1OMCUPuPjl19dMHuzBhtmg2GS97sViQt/G9W1A2gM/6QPMPCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EXW5bVsF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HJiqj1zYLicAnKqnVFV7bNQNK2SnNCmyQUwM2+mbFXc=; b=EXW5bVsFV2WQpig/KfzSrsgxmX
	CQwdwf6R3NYCYYUwk3fv9am5+uLMJbBQ5+m4SGvRZrRuMLp87A4wyLeza3+sO1wLLobtSqv15/jmS
	0vIXT+geve9AO9PA3ePPj2VjRbdeKP2oIilonN97K1DoJ65rWkum64JlbDFTvOqS1m9Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD1HN-00GBEj-0s; Wed, 15 Apr 2026 16:31:45 +0200
Date: Wed, 15 Apr 2026 16:31:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next 3/3] net/ethernet/zte/dinghai: add hardware
 register access and PCI capability scanning
Message-ID: <4872fe90-75d4-4e54-af11-fc2a030378d8@lunn.ch>
References: <20260415015334.2018453-1-han.junyang@zte.com.cn>
 <20260415015334.2018453-3-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415015334.2018453-3-han.junyang@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278808-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3DAF4055F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +int32_t zxdh_pf_pci_find_capability(struct pci_dev *pdev, uint8_t cfg_type,
> +                    uint32_t ioresource_types, int32_t *bars)
> +{
> +    int32_t pos = 0;
> +    uint8_t type = 0;
> +    uint8_t bar = 0;
> +
> +    for (pos = pci_find_capability(pdev, PCI_CAP_ID_VNDR); pos > 0;
> +         pos = pci_find_next_capability(pdev, pos, PCI_CAP_ID_VNDR)) {
> +        pci_read_config_byte(pdev, pos + offsetof
> (struct zxdh_pf_pci_cap, cfg_type), &type);
> +        pci_read_config_byte(pdev, pos + offsetof
> (struct zxdh_pf_pci_cap, bar), &bar);

Something odd going on with indentation? Has the mailer corrupted it?

> +
> +        /* ignore structures with reserved BAR values */
> +        if (bar > ZXDH_PF_MAX_BAR_VAL)
> +            continue;
> +
> +        if (type == cfg_type) {
> +            if (pci_resource_len(pdev, bar) &&
> +                pci_resource_flags(pdev, bar) & ioresource_types) {
> +                *bars |= (1 << bar);
> +                return pos;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +void __iomem *zxdh_pf_map_capability(struct dh_core_dev *dh_dev, int32_t off,
> +                     size_t minlen, uint32_t align,
> +                     uint32_t start, uint32_t size,
> +                     size_t *len, resource_size_t *pa,
> +                     uint32_t *bar_off)
> +    p = pci_iomap_range(pdev, bar, offset, length);
> +    if (unlikely(!p)) {

Is this hot path? Please only use unlikely() when dealing with frames
in the hot path.

> +int32_t zxdh_pf_common_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +    int32_t common = 0;
> +    struct zxdh_pf_device *pf_dev = dh_core_priv(dh_dev);
> +    struct pci_dev *pdev = dh_dev->pdev;
> +
> +    /* check for a common config: if not, use legacy mode (bar 0). */
> +    common = zxdh_pf_pci_find_capability(pdev, ZXDH_PCI_CAP_COMMON_CFG,
> +                         IORESOURCE_IO | IORESOURCE_MEM,
> +                         &pf_dev->modern_bars);
> +    if (common == 0) {
> +        LOG_ERR("missing capabilities %i, leaving for legacy driver\
> n", common);
> +        return -ENODEV;
> +    }
> +
> +    pf_dev->common = zxdh_pf_map_capability(dh_dev, common,
> +                        sizeof(struct zxdh_pf_pci_common_cfg),
> +                        ZXDH_PF_ALIGN4, 0,
> +                        sizeof(struct zxdh_pf_pci_common_cfg),
> +                        NULL, NULL, NULL);
> +    if (unlikely(!pf_dev->common)) {
> +        LOG_ERR("pf_dev->common is null\n");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}

> +int32_t zxdh_pf_notify_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +    /* We don't know how many VQs we'll map, ahead of the time.
> +     * If notify length is small, map it all now. Otherwise, map each VQ individually later.
> +     */
> +    if ((uint64_t)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {

Please try to avoid casts. They suggest the types are wrong. You will
probably have better code if you don't need the cast.

> +int32_t zxdh_pf_modern_cfg_init(struct dh_core_dev *dh_dev)
> +{
> +    int32_t ret = 0;
> +    struct zxdh_pf_device *pf_dev = dh_core_priv(dh_dev);
> +    struct pci_dev *pdev = dh_dev->pdev;
> +
> +    ret = zxdh_pf_common_cfg_init(dh_dev);
> +    if (ret != 0) {

if (ret)

would be more normal.

> +void zxdh_pf_get_vf_mac
> (struct dh_core_dev *dh_dev, uint8_t *mac, int32_t vf_id)
> +{
> +    uint32_t DEV_MAC_L = 0;
> +    uint16_t DEV_MAC_H = 0;
> +    struct zxdh_pf_device *pf_dev = dh_core_priv(dh_dev);
> +
> +    if (pf_dev->pf_sriov_cap_base) {
> +        DEV_MAC_L = ioread32((void __iomem *)(pf_dev->pf_sriov_cap_base +
> +                     (pf_dev->sriov_bar_size) * vf_id +
> +                     pf_dev->dev_cfg_bar_off));

Is the cast needed? pf_dev->pf_sriov_cap_base should already be void *
__iomem.

	Andrew

