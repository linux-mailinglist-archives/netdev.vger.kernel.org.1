Return-Path: <netdev+bounces-271482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MON2DJGyw2kktgQAu9opvQ
	(envelope-from <netdev+bounces-271482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:01:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99032294A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDD513011C6A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025D3A1684;
	Wed, 25 Mar 2026 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HU8RaYLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B1356A3C
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432750; cv=none; b=tzmMKOkY3pEGO1mifDDPDo+7V5hdWbRgx1Mw3RAHFLPf6jnsoxHkJmr9aLiBZJdWuUqKtmCBY0GvGfCYPPQR1lmDSdUOS1SuWgtAtm7SaZzwoNNwWSdXrQNsm3vTqUCq42uYp+TPnfaaAW/nXFnjI4zb1nTFqzw1GjAz2DOlB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432750; c=relaxed/simple;
	bh=TzJzAT89SxJyz0FUhXrVwUVSf3c7FeaCb7AD9FUS71g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSW7BMu5Gr+UGi5rT7V/szWmuSZRbbTzUOUjux8wUs4zfbQdVLE9AvrRWmap7RXjfXMoYel9Zh2Oozscxu2w8jrmSsrK9N7Dk5rYTNpLH0hsVU6e0QQwZeSFv821unJOu64mF6UdqWcdIAG6rDDP9elcvutcbjMor38Rd0C2Juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HU8RaYLK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so15507495e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774432746; x=1775037546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z8my4K4S6JiGTnFA/zJLFhSFrIgH4OD1hMW4MDAGPJ8=;
        b=HU8RaYLKY3puIqTwT6Sdwu/rAl60ew9/EFQyZkecDweoPWsnbbT+eTBkeycLLH1AYv
         6St6yScTrDyYMaGTkYXfAMdKhML4iqKfh72JZLQyklwgvw3Xv1p4p91vj+guEYo14115
         ibJiSW05YXvWsAfvAMfhZTLfvmygllaShgFz0WjI4o09cqZUw/JXJL8fP3oPIQdq/1/J
         p1iGAyWL9dW+ZTSWtXHZsfkFmZstX7TuB3Cw071T4pu/LGTffjUqIL929JyUenZm7pYU
         w430yr71YyHD/Xap2IEPXfb7Klon/I9/swD1qau5a6XWmTZ8EEAKU4oo1+XlALx2jPe8
         vqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432746; x=1775037546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8my4K4S6JiGTnFA/zJLFhSFrIgH4OD1hMW4MDAGPJ8=;
        b=pYNMLN4Y5RNHke51lUUA4QtkR+CVFOOGyx3izLzNVN2uiutEGNDkN3up/OQGyl9x5S
         1XwNqEgkLrQBlM15cmKPjkb1XVfFThlpsXxOQn3xqv6VgKlLWBX8Kou1rCzpNztl4RWA
         BD/r5HWNHbPwLpSZdZR58zzlY6eMt8oXFjywo9RbdjDta9PlYUi26yWiM6b+I+Mo0uNe
         Op/mRdEKx+WRsOFxz8QbQvY8wpq9y2/M8RTmMorogFHM/xFJmk+XGzzitdDin36/h02Y
         GQ7YzUtnxN3Eq92xIz1XsH8p7qLz7b/+WcFrcitZL7ltsmRgPVdPfpIRWxeJCBhmj3cn
         ReOQ==
X-Gm-Message-State: AOJu0YxdoFPq1yJMhHUIr3GiYl6SRv8A2oQdflb4KPdLiDErGKWNeRmS
	sMCmYbp833vJ8EN8gOX3wO64/zxQh5FwqH7z9dOH1fewW2u9E4bJ5+9qfTIQHIKMzPI=
X-Gm-Gg: ATEYQzx+ynzCRvwmSBxNpBm5gUjJ5e5pCdrwBGzWhA8VAeWCXCyqFJGZpCzug+Osq1g
	qP4trEwsdRZNtv/23LGuexPoDP3gtbTwR40stlt53ldkJjAqEdSJ3oZbDIobQI0jCdM5yAIXc7w
	+K5GGCRbRwNWrIYLe648FzTtdeBkOYPgN317+J7qynDdE948KFigWKawAlGVAyDrURWwMq6uEZF
	4k5wOC34lGc2GriRf772EfO1B+/KZpOkWtu27Y5iNjZ/pQZAoGLLUj+0mFF0JLAXCmp87LFHdo7
	8+vmVG7W/IDkMnIjzNBz3JFOXL7BKrqjm6QpCYxAe8U+/opLUm1rkCNdf6BsvL8zrlojAlNUcsH
	oR0pQ8rmOcVJm78Ol6F3MJbd+Rh3Xe4NaAoVLYABx6GAI84Yw6HthZjwOq/JqjCJoQCNYbSWbj4
	1++oMUufJl/r9pBo3GLPEgrw/UAapQV3WUlU4=
X-Received: by 2002:a05:600c:6287:b0:487:1108:48af with SMTP id 5b1f17b1804b1-48715fd4ab1mr43491825e9.4.1774432745752;
        Wed, 25 Mar 2026 02:59:05 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871664ad92sm26049735e9.4.2026.03.25.02.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:59:05 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:59:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v3 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <wb55h7a7leyclks6lktz4cl2kut7bsfhxztptv5s4x6pjgbd7l@mhhqpb4vxmn7>
References: <20260323222133.1796997-1-grzegorz.nitka@intel.com>
 <20260323222133.1796997-4-grzegorz.nitka@intel.com>
 <ncudf3km2qvvbbx6rb4agurqfrvsu2u2cmidhvtwgvfvxxkfew@xicgdybftgqb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ncudf3km2qvvbbx6rb4agurqfrvsu2u2cmidhvtwgvfvxxkfew@xicgdybftgqb>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271482-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20230601.gappssmtp.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[20];
	URIBL_MULTI_FAIL(0.00)[resnulli-us.20230601.gappssmtp.com:server fail,intel.com:server fail,resnulli.us:server fail,tor.lore.kernel.org:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:email]
X-Rspamd-Queue-Id: DA99032294A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 25, 2026 at 10:55:27AM +0100, jiri@resnulli.us wrote:
>Mon, Mar 23, 2026 at 11:21:28PM +0100, grzegorz.nitka@intel.com wrote:
>>Extend the DPLL pin notification API to include a source identifier
>>indicating where the notification originates. This allows notifier
>>consumers and netlink listeners to distinguish between notifications
>>coming from an associated DPLL instance, a parent pin, or the pin
>>itself.
>>
>>A new field, src_id, is added to struct dpll_pin_notifier_info and is
>>passed through all pin-related notification paths. Callers of
>>dpll_pin_notify() are updated to provide a meaningful source identifier
>>based on their context:
>>  - pin registration/unregistration use the DPLL's clock_id,
>>  - pin-on-pin operations use the parent pin's clock_id,
>>  - pin changes use the pin's own clock_id.
>>
>>This enables richer event routing and more accurate state handling in
>>user space and in-kernel consumers.
>>
>>The current DPLL pin notification infrastructure does not provide any
>>way to identify where a pin-related notification originates. Both the
>>in-kernel notifier chain and the netlink notification path only carry
>>information about the pin itself, not about the component that triggered
>>the event.
>>
>>This becomes problematic on platforms where multiple DPLL devices or
>>drivers share the same physical pin via firmware description (fwnode).
>>In such setups pin creation, deletion, or state changes can be triggered
>>from several independent contexts:
>>
>>  - from the DPLL device that owns the pin,
>>  - from another DPLL device that re-registers or rebinds the same
>>    fwnode-described pin,
>>  - or from a pin-on-pin relationship (parent pin registering child
>>    pins).
>>
>>Without a source identifier all these notifications look identical to
>>listeners. Drivers cannot reliably determine whether a received event
>>is a result of their own registration/unregistration actions or
>>originated from a different DPLL instance. This leads to several types
>>of problems:
>>
>>  * risk of duplicate pin registration when a driver reacts to its own
>>    event,
>>  * difficulty suppressing notifications that are merely internal
>>    bookkeeping side effects,
>>  * inability to implement correct pin‑multiplexing or cross‑device
>>    synchronization logic when pins are shared across fwnode domains.
>>
>>To address this, extend `struct dpll_pin_notifier_info` with a new
>>`src_id` field that identifies the originator of the event. The DPLL
>>core sets this field for all pin notifications:
>>
>>  - pin registration/unregistration: the source is the clock_id of the
>>    DPLL initiating the operation,
>>  - pin-on-pin relationships: the source is the parent pin's clock_id,
>>  - pin property/state updates: the source is the pin's own clock_id.
>>
>>Netlink notifications now also carry this additional field.
>>
>>With this information notifier consumers can differentiate true external
>>events from internal ones and ignore the latter when appropriate.
>>As shown later in this series, ICE/E825 devices rely on this to avoid
>>reacting to the events that their own registration logic triggers
>>when a shared-fwnode pin appears.
>>
>>This change only extends the notification metadata and does not alter
>>existing semantics for drivers that do not use the new field.
>>
>
>I wonder, did you miss my comment to v2?

Ah, sorry, I forgot time flows only one direction :)

