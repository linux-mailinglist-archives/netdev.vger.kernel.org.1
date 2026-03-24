Return-Path: <netdev+bounces-271042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKo0I2aGwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31A6308734
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC35331C5762
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C73FE347;
	Tue, 24 Mar 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XSy5qu4K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F23F9F56
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355470; cv=none; b=kYFPBXMA5vcHERDhbdEVvrpnjpWuGceldGh+s59NcVPJYQFLeuHpNjOwTM7IGTZqTjxuZyW9jrm/5aGEr3CcKKGCfOAvjnwqbZJ+ZwG8hEMEApz2dUS+bZqNTK/Ttq9Tj7ESuTWWYEF9ksL7nPgzvOAHyIm6sSfcdB3AkoWb+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355470; c=relaxed/simple;
	bh=cNaZ16Av/pHiTgNmSUlJBQ+S1AKjelzqjrsdrMAWcQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esyc4FwdlkDGtgxWYssGxr14tuQpwHJhPHqIqRNl8Qo2qHpP7gHOGuTRVI2vQdGmOs9WWgd/BUKJqd99WEJb7b8PMKdePAoL/kCwNyHSkFg5h1U8s19NrOMAoqvQbbKSLfK61jzx8V0ZP36texOfBUzw/PDwZLu3sZQPw2iAv+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XSy5qu4K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso44036585e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774355467; x=1774960267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNaZ16Av/pHiTgNmSUlJBQ+S1AKjelzqjrsdrMAWcQU=;
        b=XSy5qu4KzRKl14Z+UdXlcYZpz0fwL9Eju2kFdlOFDtqesNvdEATHgQvi0hp+vesHd0
         VoedIflO03vLEo0qAIzdd0Q1ZexkI7EKBfZyXN98RA7TSWjrbvRDez1SHPzIJhm7z7W4
         Djiamsktn7SfuvMIrEM73weCzbY57uMuZmQ0mt7iNXzivWprP/VcEaPoT+VWZdfJWY8C
         e+yck7xKVnRbbms/VERjYWOKwEUwbwrHmzo20NTZ0tFEBx74sINndNLw558U/ShnKoHm
         23ARZFEXA7VbafPM6L0DqqAaRzIFIj9pIk1f04xLx0P4qKENtTWumNMzpZjPHF5h9ALD
         SoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355467; x=1774960267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNaZ16Av/pHiTgNmSUlJBQ+S1AKjelzqjrsdrMAWcQU=;
        b=VNgEz9sL8qrHEgp4h27gj5aWDyKGDg1A0VBoeWXQbFqleGlZtb9sQCOgFkgHpdZx+Q
         GBRHdGWBI2jb2jQFp6Zz+JVPNAkq9e8VR7kw85zzUOgf3hDiQpX8ZdtdT07JYBtPmBG8
         uqiN579JzNcHhu87upfjPFaavoPXWMDxFM9kl5AKOSrBt/IWtwb1Wn1aYHrTIVrVSKpn
         vnDvG63tRYIQOrd8k0XH6p2zESzD+C07zcIzCLZMaE48qJMunLPSeBhftD+w7kCskPNX
         JZWhu6A+mO8/GRJSNVse7fOuakCvcsz5PT7HwqhSwbZfgUOf0OQFRlfCB+EtoRn4oxci
         40yQ==
X-Gm-Message-State: AOJu0YxTr6W23bciXX7Pl1f1B0zE2gnjfzuNch2TzOvYZXmK0lNwPvxg
	WX2RaWCCSq3/MojsNTxkBp8lSePMSzskriqrXpdv+Qn7cg4eHBzp/auy5Vbra4sC+xZdb0i1Bix
	xkUoRNHo=
X-Gm-Gg: ATEYQzw12VmlQY/urfW9e5wPpxAwVLekXCOzyK0IlV/S1jAS8YwYIIBFXQRFl5kmSQk
	yOJ/lTvHclFV7xISU9MnhdNXcgLx71SFgccHAjHCsSEyZ88GciQf39jGRPVucn0/BHU4g+dsQhb
	pzdjva90W3EjwK4CqcwiFik3AbjMvIqO+gHN7QRo9KM1IunI9WjO6C5nlW0yjYo2bVCZxIyabM+
	E9GCgXdPxSFFFBTthGElViIsHH8fQfW5HQtit7yX+6KkJ/HSL98D1wA4S3h+TNLH9n+v1xdJG7w
	ZaZ9ANtZJlbMVw6sTnodX4X7TKZhV4fzUl+ByIvVQ2+NvFVR9nFZnOsDuSn3HkjnadYDYC8dT/C
	W/otwt/5SU8UITC1vBu0v56LypyOH4O7Lm1cq4RKcgJMWKA3VAOnSdeY0U6M6e2QgEzYOX9gc5O
	64wOKRyiEm2dqHLyX1c8GmENDePRMvVU64L1c=
X-Received: by 2002:a05:600c:528e:b0:485:3fc8:de9c with SMTP id 5b1f17b1804b1-486fedb2ef0mr212873175e9.12.1774355467376;
        Tue, 24 Mar 2026 05:31:07 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711764625sm50073125e9.14.2026.03.24.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:31:06 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:31:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 net-next 1/8] dpll: add new DPLL type for transmit
 clock (TXC) usage
Message-ID: <ao4eviden4pqqxpxhnrymdv2nkb4qumewoevuf4khbhqprvv5n@7ie2fsz77t63>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-2-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321222627.1193603-2-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271042-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: E31A6308734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sat, Mar 21, 2026 at 11:26:20PM +0100, grzegorz.nitka@intel.com wrote:
>Extend the DPLL subsystem with a new DPLL type, DPLL_TYPE_TXC,
>representing devices that drive a transmit reference clock. Certain
>PHYs, MACs and SerDes blocks use a dedicated TX reference clock for
>link operation, and this clock domain is distinct from PPS- and
>EEC-driven synchronization sources. Defining a dedicated type allows
>user space and drivers to correctly classify and configure DPLLs
>intended for TX clock generation.
>
>The corresponding netlink specification is updated to expose "txc"
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

