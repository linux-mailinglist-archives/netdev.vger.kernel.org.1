Return-Path: <netdev+bounces-116075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE0948F79
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2EA51C21FF1
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F921C57A6;
	Tue,  6 Aug 2024 12:49:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B511C463F
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948594; cv=none; b=K6kjInZxNcSd/yR5qkeCbNi6FpQPt6eiybfiFiukquOFqW/jNSFpjn0gRq1U1nXn+6W1rmQSQLdJwAlKHp9cUME8xkHlXM6uU65Y1pjoTuGrUsPWVhswWs9R4iheditBxGexV8fBdm8Qd50cDpXBQ4H++m0EFfP9BiY18AnkhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948594; c=relaxed/simple;
	bh=R9iRMHrGBCwSA38VQDNVxZzsf0yYcGUdX9Lw8XXKFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhX/3NciqjmqIALrnJRnUNB5CudC12xaTyKYp+vEmDwhOs/vRcctwOhq2O2Q3om4hl0IClFz4cdUa+ctwhwrN7+tQIw/uoN1PsnF7y4HRweKozeapg2UKqQur4in4BqmKzIqqcv80L38wMeJ5lJLnIo+TNnWeMOsUV8EDk9vIXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so750134e87.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 05:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948590; x=1723553390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PEcDlPNthfqb5P0eN14oIJ+uWO3UjB3Kt9EBgQ7PU8=;
        b=nDnTsmqOjnUcpdodnp3+CcwdfXbYYTa9WBnChXb3lAtJmmBWkKcpaR6McANNCUoN85
         YzWLTDTgE3QvY70FPndo161zZTuFxeZhhFV4D46s3+jUZ8Z1Ikr+cwKSTObEIVXV+Gp2
         AuJOTCYOydmzCfpT3BIIliVC/rd0eJzMYq67YMTztTFDH38FKjoC4WP/0FjJdtr2Hf8w
         Rg1jedz27YQ6UDXbzPDjglLIXwGdIXCXMrLMlDKb3r170HhQztNLUhqhtWETK53jrWm+
         LE97uDrXTb0irV62/QsqvgbxK1V89CS45FZ6M4BlZMLYIZRzVF3+KVjNiknZPsLfSkp6
         we5g==
X-Forwarded-Encrypted: i=1; AJvYcCV35dFY4xGQ1Vj1rWHrfogVO8edfFQZvaaMmpV9zhyI+gXHj/EwUfQlvX4RiF2CE4/e6oZ7JiSkg4393MTLF6ax6ggebVkr
X-Gm-Message-State: AOJu0YxkV+tsxSuONzSCOdAwzaauGPOculCaEgt+A2FGyTcuxbzl3Yl8
	sdLJjmr0iVyh9VWWZYX6non3jQXvbjicn25BdMVmcGnNoF5lS6L4
X-Google-Smtp-Source: AGHT+IHluAPqZ9gEwcLIqNHlKm6WRfY2ficrUnrLCisR+Nwo4wXNZzYowG3niObiJpgnZNIEQOLiiQ==
X-Received: by 2002:a05:6512:a93:b0:52e:9cb1:d254 with SMTP id 2adb3069b0e04-530bb39dc80mr9845004e87.46.1722948590009;
        Tue, 06 Aug 2024 05:49:50 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c5asm548650866b.36.2024.08.06.05.49.48
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
Message-ID: <ZrIb66tqsNnzedja@gmail.com>
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

