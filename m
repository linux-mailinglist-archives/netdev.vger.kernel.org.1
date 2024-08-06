Return-Path: <netdev+bounces-116074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B0D948F78
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C0F28204A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCF21C5791;
	Tue,  6 Aug 2024 12:49:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75A1C463D
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948593; cv=none; b=SABAJB9C5WHVF8S2HH45DqlgqjPGTlOZ+s9LUCfeszNF1jV+XbG7vuWM6hZM9/4VR0k+hGCWoGSPXfFMgKcwltk0+dtKxNy007l1E2/oXHmYEkNEQ8Q4DQSU0m+xjqR5AXyiix1dX//x+T+QlP/q59Uhp3pvoaJUx9D8BHJLjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948593; c=relaxed/simple;
	bh=R9iRMHrGBCwSA38VQDNVxZzsf0yYcGUdX9Lw8XXKFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxUiEo3Mxr2cniBj54QmZdqPRbKZaoKAir0McTJ/Ehf99zGZvJ8Qw8Hp9Blc750vvMW7pl2vnOmy6Uuo7vmO1E3uhyMnCBJldPKmNbzR/62ZKErtYXo4X9gPB0d2Hif3w80n/wDHfv7sg/yF8r4zKjZ0P7HGoqOAtx+mjDpDl+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so928948a12.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 05:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948590; x=1723553390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PEcDlPNthfqb5P0eN14oIJ+uWO3UjB3Kt9EBgQ7PU8=;
        b=Lmg7tD8w1wAJH67piHO8tLw4qCGQG3GwIk8cEirF0pp1TfzPDPUfuvkaqVCQA30xXm
         JrQD/+QEfdRpJO2Pj9u91Q24u2MJsYB7T0LRGRpnL845esWvu8ifrSTEyZdzu7epONY0
         7LHsK6Hl20RwtHBAAokmJyV0IITlWV2LIOJYORTgTakBOI0Lsv4lzPK3or41s/nCyvrG
         XXl58xStbso9PWZoyBulqgG8lvx8RrHLfit6qc0XOhMRMxEzpNXP2XQrzeVBiX+tEV1Q
         7YRU8SOs+V+on4CnTUrFVhSdRArw6RfqD79aq6Bd6FcDaDHE5JOjJpgwQIURvjHK+gTm
         q2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUwqZPvgQpsXYw4cNG7JoJDsBNto9uUo2rIv98xIWhMDyCIbAOyQ5BC3QCQhhXFpa9yU2heRbktR+LmFtwX6mm0+LwX1WXk
X-Gm-Message-State: AOJu0YxxPBng6Q5uZO8erdpnEliaJM28zDmqkRLHdBZcWMkPkPpmsvR2
	Z+w/IxoleqhZwRP0QagK1gS4DqGCH5Bmk7evUGUwUU7texJPwv+G
X-Google-Smtp-Source: AGHT+IGzmZw1UOCXPZkTi9NVHTIvC+zqWIzanfPuuzR+USQYKYzCrxKTS2Q/cNWTuUxtjDx0c8J3zA==
X-Received: by 2002:a17:906:6a01:b0:a77:e0ed:8bb with SMTP id a640c23a62f3a-a7dc509f7e3mr1034742466b.42.1722948590156;
        Tue, 06 Aug 2024 05:49:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc95sm539775366b.85.2024.08.06.05.49.48
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
Message-ID: <ZrIb6zgbCxvc42HO@gmail.com>
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

