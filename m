Return-Path: <netdev+bounces-116072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC58948F76
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287E11F2139A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839F1BE233;
	Tue,  6 Aug 2024 12:49:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966A1FA5
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948593; cv=none; b=isY9iq7qJ39Q9qFykRBbuxxXfvH+biW5/pFW5YfqK6M+bIS+AiJRhH2blT+b9BHQal339wquAHXlQlbt2ZZ8L+u8UYutACNToAtVKqYgOVMheVNfaNX+v/VOMSbFAORUWc8ZJL8HJK7vXF/moTrF8SneruOK+WqCo3cCEch1u1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948593; c=relaxed/simple;
	bh=R9iRMHrGBCwSA38VQDNVxZzsf0yYcGUdX9Lw8XXKFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXbX223+10aq2vTtYDWMLhiF4Dpgm/MfC1OiIH1Qfe6W4/2zYZtR/KNw82EkQi0+F9C6VcAYcTkF6f/f4iabvNgZTzoCuhjfu6ou/a3lMBqyYtE7iRRiqI4PrwXfHY6OcohuTO/oBl4DIA6ZNMkw9zA2EohpD+zchZK0NfYZsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a9a369055so54495966b.3
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 05:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948590; x=1723553390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PEcDlPNthfqb5P0eN14oIJ+uWO3UjB3Kt9EBgQ7PU8=;
        b=DqJS9fRUl3S+QIj4zjNNtCbsdY3WkJAXF21VAFW3aW/cyNiPbf6DwCiWZW3Dn6yLHY
         b4SD+JQCpUCZne9qWPvWXlEHLHLM+d3hcznKPCmae2X+EJ3NOaZjnpR7j6yN14+OqTAq
         27xFN1jZYgy8MmtRX51xbRv7GzRifr1rhWhk868nL+as8hhYeSHhJSh9k8+Bh0pJe7zn
         uuN+KHGie/ouCu+o5T5MUMxwz7bS1CY9ocVt75P5edxtR7GPxcLdnsJKh1BZuA0+pPHt
         bMug3H65l4A4Z5HJhZo0e1kmjTGGX8bAtOnXIK/BL1/Nh69F5lXVBF6XHUTA4I+JGBAY
         WFgw==
X-Forwarded-Encrypted: i=1; AJvYcCUDMzUumR+E+yxPN43h8pkSchQuZF3BY5T6lDFC6rtWmymUu1h1gxeDlRhdPpRhT+GpU66E0+tPdBDnd+tO1VB+hLfg3dEu
X-Gm-Message-State: AOJu0YzwHLfMQxPmOFN0Gp0cp56F5VtPYYjS73KBZIFWxaFIuSWuQUBF
	Uo6RkLj1GVfKjanYjFfpP5HLtppmL+KOXf1iTZAhDjkVbPw0t0ptmNV2wA==
X-Google-Smtp-Source: AGHT+IHHMQXv39yQcWK7fFyVKhPeMx/uKbi4IEoBb3XOWMn8ClWw7I8VkVBh1bjo4busKnrXUsaBEg==
X-Received: by 2002:a17:907:3f8b:b0:a7a:a6e1:2c60 with SMTP id a640c23a62f3a-a7dc5148422mr1030825466b.61.1722948589850;
        Tue, 06 Aug 2024 05:49:49 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0casm541517666b.47.2024.08.06.05.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:49:49 -0700 (PDT)
Date: Tue, 6 Aug 2024 05:49:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net] bnxt_en : Fix memory out-of-bounds in
 bnxt_fill_hw_rss_tbl()
Message-ID: <ZrIb62iptSK3qBTM@gmail.com>
References: <20240806053742.140304-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806053742.140304-1-michael.chan@broadcom.com>

On Mon, Aug 05, 2024 at 10:37:42PM -0700, Michael Chan wrote:
> A recent commit has modified the code in __bnxt_reserve_rings() to
> set the default RSS indirection table to default only when the number
> of RX rings is changing.  While this works for newer firmware that
> requires RX ring reservations, it causes the regression on older
> firmware not requiring RX ring resrvations (BNXT_NEW_RM() returns
> false).
> 
> With older firmware, RX ring reservations are not required and so
> hw_resc->resv_rx_rings is not always set to the proper value.  The
> comparison:
> 
> if (old_rx_rings != bp->hw_resc.resv_rx_rings)
> 
> in __bnxt_reserve_rings() may be false even when the RX rings are
> changing.  This will cause __bnxt_reserve_rings() to skip setting
> the default RSS indirection table to default to match the current
> number of RX rings.  This may later cause bnxt_fill_hw_rss_tbl() to
> use an out-of-range index.
> 
> We already have bnxt_check_rss_tbl_no_rmgr() to handle exactly this
> scenario.  We just need to move it up in bnxt_need_reserve_rings()
> to be called unconditionally when using older firmware.  Without the
> fix, if the TX rings are changing, we'll skip the
> bnxt_check_rss_tbl_no_rmgr() call and __bnxt_reserve_rings() may also
> skip the bnxt_set_dflt_rss_indir_tbl() call for the reason explained
> in the last paragraph.  Without setting the default RSS indirection
> table to default, it causes the regression:
> 
> BUG: KASAN: slab-out-of-bounds in __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
> Read of size 2 at addr ffff8881c5809618 by task ethtool/31525
> Call Trace:
> __bnxt_hwrm_vnic_set_rss+0xb79/0xe40
>  bnxt_hwrm_vnic_rss_cfg_p5+0xf7/0x460
>  __bnxt_setup_vnic_p5+0x12e/0x270
>  __bnxt_open_nic+0x2262/0x2f30
>  bnxt_open_nic+0x5d/0xf0
>  ethnl_set_channels+0x5d4/0xb30
>  ethnl_default_set_doit+0x2f1/0x620
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/netdev/ZrC6jpghA3PWVWSB@gmail.com/
> Fixes: 98ba1d931f61 ("bnxt_en: Fix RSS logic in __bnxt_reserve_rings()")
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Tested-by: Breno Leitao <leitao@debian.org>

