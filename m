Return-Path: <netdev+bounces-291696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBSkLhyhFWprWwcAu9opvQ
	(envelope-from <netdev+bounces-291696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FC5D6906
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3C1130488F4
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5593D6494;
	Tue, 26 May 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="KmUGKaxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EFA3D16FD
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802050; cv=none; b=iNBVREydMh4K6+qDoukLaec1BqNCVhoUZJ7Cian4o0s7TbuYBuqHiQbvHIq9IL2OopBjcr1ewhXcG7WrOix4o0NOHH/bMS5QAmW2yS9rb4/fIJ3Nkf4ltgdvh5llvc6iHCSwWtEAwRm1puKBDA15yh0kU2yCnqcpQf2j7uKIJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802050; c=relaxed/simple;
	bh=JTDozst65TfitN/LoRQp6+zNLnI407g8AVHWZh7Aw7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzfIXDOK2brvNW4JMveuOakscLeM+GreV1ct0yOMxQ0KWQAihA0rNRtiMxs/5ZhpJ5sSLmfeO6pZba65+lWDLQswTr72Hjrx3TcBidrHR+xoqfNv3LZY/U4aw5cBf5IUJua36Eaq58EHMpC84sHvY3nUJpP/NZ43drYz1eAzIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=KmUGKaxD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45d96d21e82so5761091f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779802044; x=1780406844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOoP5D+3GayAYX2czvg1Rx3yDcS/IwtTCjoyb2Dq9dI=;
        b=KmUGKaxDUYvseZ7VmtLYZEn+F718dJBurWUitBbCQu+iYKfcHV0ABA+Rby5N+8hZVj
         XFI9Ym/ZuhV6vdbDimkaqvpD889sxvb9HrHy3aw05jYSaPD/DfD6DEGTUb04ivWo9DxD
         7cPmaAhcUqLvTqNZS1WhzfywnypnP/NdI0CrmUItVqJkfAcMxjq/wTL4zsE/dtRhkaWo
         Lu8u+VKUzEVQnoPlXyRjVmatK3rGCJ4RRxUOWwhuoKgr8j3UxMzZzUcdmnrJR8uf784Y
         Yc6r9hNhtjV66NXROMVuKvtOWQ52vgSvw9PNRhr3c/u4rDvP15IS0DV/Q96xubrqjIrR
         zr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779802044; x=1780406844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOoP5D+3GayAYX2czvg1Rx3yDcS/IwtTCjoyb2Dq9dI=;
        b=Zqw3mR7jtic/IBUgUyFOQxewzKcow1AmdfcxZNlJdO1gym5j91NYd71yVykYzqaOUm
         gxkyDyPXChplNp+P/V85kxkTt2fwraFVJeExqdrX1/QTTyUhiQd/EoN56Txk0zLpQ0L3
         BccRH1PguEb9WzbBQBTiy7jzxkigpJpSCV8jaSAE5UQDD9vi8ej2CYCOIqM9X4IIqVdo
         mYrNWJ7zuHhnlz7PZ+Jj+WnnOy2ymUTbwhSEzsJ2LgWGHcJCjuyyCcGpME9RJNAw8/Al
         h0BpVJ23LQDTo20KF/RJc/o+OwVfwwrfGlfVP5LahQJLsjGZ/x2FKB3cz13xV/FMdoZ2
         8fhg==
X-Gm-Message-State: AOJu0YwAYqUHTaxKYtShheE5dcYIjITPyywiull0Gtq20LkyrJlWCtem
	rwDQXv7QxU4XA+YWQHUUwBGdt4bCiBZb+JDkQmOcCB1c3toxDPs2ssUW+GoQ0DpbudI=
X-Gm-Gg: Acq92OELKTr8BcwWjc33mNydamorEv9mzetYnEyGxWsGM3fcVqAz/9kjtBzYdppq1pa
	NWzNk2Q6QqxcpBERdqoacYVFA4j9RE0moYJAoypsK9W5hymdL0foDdncjiQU72Qcy6DPAtnR8e+
	QlOSXpBb/XqWr2sCLR8tW7fZCvly7xbIl1BF4KMM69em4c6SBZg2tI5m0J+TFmkBgbIxIoR/Aw8
	V4dqolaXZVvWEhCQRL7+60lNrvKEGqSLv36KbZ28IjTfh9c3AWE/DbmMPSRP1FZndSyDsmR5UoI
	scH6EVCg9s8dfgH+YlE27hYwBcge5Kp0mO8Rpx+YPf9OGy1Aet+hyIO04agLXh3Yk60H3mKyB5i
	UpKX1TrMnKyB7HHhj77Ofne3Bz3bvJz5ln1YTjpZDk565Zypb9QwPdeonEnvb6z4/06YtrZsSJs
	d4BsJXX3qG9vqIVQsJMAeehgqZpEw1tdWQ
X-Received: by 2002:a05:600c:4f52:b0:490:4f91:5519 with SMTP id 5b1f17b1804b1-4904f91568dmr296207535e9.18.1779802043944;
        Tue, 26 May 2026 06:27:23 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526c926sm578470375e9.1.2026.05.26.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:27:23 -0700 (PDT)
Date: Tue, 26 May 2026 15:27:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v11 net-next 3/8] dpll: extend pin notifier with
 notification source ID
Message-ID: <ahWfsblAd0Cgpe25@FV6GYCPJ69>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
 <20260526093419.639220-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526093419.639220-4-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291696-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 113FC5D6906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, May 26, 2026 at 11:34:14AM +0200, grzegorz.nitka@intel.com wrote:
>Extend the DPLL pin notification API to include a source identifier
>indicating where the notification originates. This allows notifier
>consumers to distinguish between notifications coming from
>an associated DPLL instance, a parent pin, or the pin itself.
>
>A new field, src_clock_id, is added to struct dpll_pin_notifier_info
>and is passed through all pin-related notification paths. Callers of
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

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

