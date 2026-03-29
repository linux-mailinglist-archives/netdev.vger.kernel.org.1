Return-Path: <netdev+bounces-272881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDFzEfoLyWkHtwUAu9opvQ
	(envelope-from <netdev+bounces-272881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:24:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B1351CA3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E204300559F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422F346E58;
	Sun, 29 Mar 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V4nvhR2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEDC2C15AC
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783479; cv=none; b=OkK2bNz0IO6BghUfMeqaakhpqb/1jfraHqe3q/tDgQ8hWIawvOBP0XMskEwhgY8kVfjmrL7PMxrqiUIVUOQaFzbiqDUr6tLlJgL+DvmW20iCDbQG0Xi1ujxjVcax1I/2fUjKesDxzmNIF4ImU7Y2+wpRtAag72HjYv/VrHE1m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783479; c=relaxed/simple;
	bh=MLi0Z6pFA5N+tSKxLYzNxj0vUcsbG7LsGqtWENUdFw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe2+K7AqO6PnZW8OwVnezisWa2jRSaQqcjFL81H7S/Jvvf23UNVDTZ6Et1ie1RaMrHlqI72W56puLwRR0bdHaqp8DcJlAMoAF91fJ8Gov0vBKhqayflwWYhCdKXEJ297o8bya3wRfFsMzNAA1NCAjG97tg7mDNc7WhYwcHjt8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V4nvhR2R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso42451815e9.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774783476; x=1775388276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PThdoORy2iuaX5Hlbv5/ayxBCCRV0jzN1bLjarnMAh0=;
        b=V4nvhR2RWMviLvQOJYzMK+cHUxVzMJ2pKf2pKJKUiHHCJ17RkRKdwJtbhp5fITNBpB
         QmGmu+8uzcnWELaWS9WAg1qwQ6owQTjtjYb9g+z0Kf8T63odyEHTIXdRw44GP3NNGD9E
         PSfKdCfi/NxpHv+77MYPJqC5yif+BAXded3u8dxAUTtdZIPIcNaFz04WoexxnalYrxgC
         sIvOImhaPAMBmjqdd/+PZImlm3SmrfIzShB13snDjmBh8YaEdNj437qUVSriOgeJWAuH
         rynqyuLXRNnM4SzI8by9mxUZ+MKe4hQFnNT0g5DdYLlgaAVCFnUnvjPzVG0bvbV8jHtu
         Oi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774783476; x=1775388276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PThdoORy2iuaX5Hlbv5/ayxBCCRV0jzN1bLjarnMAh0=;
        b=G2DsjcfC6bQU+VKXs2CdAVi4iZJ3nF9EZkisAZEUQU0SA/Ff3SOawipvQIDgZt1nbm
         K18yAUcEIzoB8P8Jz1zISWVOZQE9cryybVenh2WWIsnOJigVYdVJHt7079XgmnJfnYq3
         OQlRTePU6XiIm85Q9VxmKIcdPg6i84LmuCiHe3/A/vP6jGO8zbxuTKsCQFuoY+Mhylfd
         yS7rNBS7z1Hl2GRA7MEP62mhdCjg046PKz+TUx2+msHbMnWnDZTQk6WJlx/fCYVJPDWY
         gq21Yl4Cj4Ni4Rw31xsgaaJMPMPtSlS0vstXoR6f9r+fqotpGRAXZwNc1SjismMkeAOL
         BSKQ==
X-Gm-Message-State: AOJu0Yw80P66Q+xUXUCVQUIBilKDYArFmcD9207MGACljKUQneMFsJpn
	w4pWS3MsVkVdsFhn37GtqGcTs+9kPrPbV1Dcqw66Ly3k/JzUhEN6rs5Is2fgseS60rc=
X-Gm-Gg: ATEYQzxQf7nHXFg+ewHjNCcKp9FfN0nKw5a2DYniE+DAC5FYu9UheDjIK//3DkmDiVb
	SQNIRt/BrdYJPoLwIOd5JIyMhA8TfjCyjNcH1ijVTQC4pGkzMawXlDGevVw5T1P+08D02GyBlWw
	CVrIHsXXEHixOhRijXIfHTGpmFFl0ZXQ1IbT5Z9/MEBjDv/KwNDX7GYPFrC8PFMpU7GxYtTVaYJ
	vcDlw1AzaTOfjqYTcT1mqZ7Y933+hrSKYNxyHUqMtuAvUYGJ2wjENcbYKzZ+HUVtLNns3cJozBq
	owi3pL1twUk+vDbeX9Po9tA3QHtXph0A9xNnVvIv9EOHS9SAV8p7jIynKTPxy/YrNx1CEf1SxUL
	E6F+M23S7TjElVALoedSOqQdac6ZpXpA4eDQe8FVdg3ccuv49+Zoc6Fgv1pVEB5gL1NI4A+tiWy
	7vViIyFzy/YvA7fIf7eO7I5qyTb9jrJMjGFNNsKp5AXWepRbS70aI8Qw==
X-Received: by 2002:a05:600d:8402:b0:485:3428:774c with SMTP id 5b1f17b1804b1-487290b36b5mr91083805e9.4.1774783475709;
        Sun, 29 Mar 2026 04:24:35 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4c27:3a72:8516:e661])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873bbcac33sm3844315e9.15.2026.03.29.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 04:24:35 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:24:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v4 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <y5rjyaqyvmnyfaj7o2fari2t6i2klegklpnwi7xw7ld6rmajqb@uovrzb76cjs5>
References: <20260326162832.3135857-1-grzegorz.nitka@intel.com>
 <20260326162832.3135857-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326162832.3135857-4-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272881-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D11B1351CA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 26, 2026 at 05:28:27PM +0100, grzegorz.nitka@intel.com wrote:
>Extend the DPLL pin notification API to include a source identifier
>indicating where the notification originates. This allows notifier
>consumers and netlink listeners to distinguish between notifications
>coming from an associated DPLL instance, a parent pin, or the pin
>itself.
>
>A new field, src_id, is added to struct dpll_pin_notifier_info and is
>passed through all pin-related notification paths. Callers of
>dpll_pin_notify() are updated to provide a meaningful source identifier
>based on their context:
>  - pin registration/unregistration uses the DPLL's clock_id,
>  - pin-on-pin operations use the parent pin's clock_id,
>  - pin changes use the pin's own clock_id.
>
>As introduced in the commit ("dpll: allow registering FW-identified pin
>with a different DPLL"), it is possible to share the same physical pin
>via firmware description (fwnode) with DPLL objects from different
>kernel modules. This means that a given pin can be registered multiple
>times.
>
>Driver such as ICE (E825 devices) rely on this mechanism when listening
>for the event where a shared-fwnode pin appears, while avoiding reacting
>to events triggered by their own registration logic.
>
>This change only extends the notification metadata and does not alter
>existing semantics for drivers that do not use the new field.
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>---
> drivers/dpll/dpll_core.c    | 14 ++++++++------
> drivers/dpll/dpll_core.h    |  2 +-
> drivers/dpll/dpll_netlink.c | 10 +++++-----
> drivers/dpll/dpll_netlink.h |  4 ++--
> include/linux/dpll.h        |  1 +
> 5 files changed, 17 insertions(+), 14 deletions(-)
>
>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>index 55ad03977d6d..c7fcae76c3f5 100644
>--- a/drivers/dpll/dpll_core.c
>+++ b/drivers/dpll/dpll_core.c
>@@ -71,7 +71,8 @@ void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
> 	call_dpll_notifiers(action, &info);
> }
> 
>-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
>+void dpll_pin_notify(struct dpll_pin *pin, u64 ntfy_src,

I don't see the reason for "ntfy_" prefix here. Also. It's src_clock_id.

Could you perhaps consistently name this "src_clock_id" here and in the
info struct as well?

Thanks!

[..]

